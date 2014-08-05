#--------------------
#!/bin/sh
#--------------------
#
# Desenvolvido por albertofreire@yahoo.com.br

# Simples função para comandos via ssh em RouterOS.

# Antes de qualquer coisa siga os passos informados nesse endereço:
# 	http://wiki.mikrotik.com/wiki/Use_SSH_to_execute_commands_%28DSA_key_login%29
#		Aos apressados... Não cadastre uma senha:
#		$ssh-keygen -t dsa [enter] [enter] [enter]

# Próximo passo, configure o script corretamente.
	
# Uso do script:
#	sh accssh.sh IP.ROUTEROS "/comando interno routerOS"
	
#	ex:
		# retorna quantidade de usuários autenticados
#		sh accssh.sh 172.16.30.1 "/ppp active print count-only"
		
		# lista rotas específicas
#		sh accssh.sh 172.16.30.2 "/ip route print where dst-address in 10.166.122.0/24"
		
		# verifica pacotes instalados e retorna "instalado ou não instalado"
#		sh accssh.sh 172.16.30.5 ":put [/system package get [find name=hotspot]];" | grep hotspot > /dev/null 2&>1 && echo "Instalado" || echo "Não instalado"


# Altere conforme a necessidade
# -----------------------------
user_mk="admin"
ssh_port="22"
ssh_key="/root/.ssh/dsa_key"
# -----------------------------

# Não altere nada aqui
ssh_consult()
{
	local ip="$1"
	local query="$2"
	local user="$user_mk"
	local port="$ssh_port"
	local key="$ssh_key"
	local timeout_path="$(which timeout)"
	local ssh_path="$(which ssh)"

	exec_query="$(${timeout_path} -s9 3s\
		${ssh_path} -o StrictHostKeyChecking=no\
		-l ${user} -p${port} -i ${key} ${ip} ${query})"

	echo "$exec_query"
	exit 0
}

ssh_consult "$1" "$2"