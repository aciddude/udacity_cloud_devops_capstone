apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: udacity-weather-app
  namespace: udacity-weather-app
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/tags: Environment=dev
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/subnets: ${public_subnets}
    external-dns.alpha.kubernetes.io/hostname: weather.pools.ac
spec:
  rules:
  - host: weather.pools.ac
    http:
      paths:
      - backend:
          serviceName: udacity-weather-app
          servicePort: 80
