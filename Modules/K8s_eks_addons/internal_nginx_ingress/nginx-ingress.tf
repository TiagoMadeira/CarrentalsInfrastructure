resource "helm_release" "internal_nginx" {
    name = "internal"

    repository          = "https://kubernetes.github.io/ingress-nginx"
    chart               = "ingress-nginx"
    namespace           = "ingress"
    create_namespace    = true

    values              = [file("./../../Modules/K8s_eks_addons/internal_nginx_ingress/values/nginx-ingress.yaml")]
    
}