resource "helm_release" "external_nginx" {
    name = "external"

    repository          = "https://kubernetes.github.io/ingress-nginx"
    chart               = "ingress-nginx"
    namespace           = "ingress"
    create_namespace    = true

    values              = [file("./../../Modules/EKS_cluster/values/nginx-ingress.yaml")]
    
    depends_on          = [helm_release.aws_lbc]
}