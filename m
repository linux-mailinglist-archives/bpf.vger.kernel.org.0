Return-Path: <bpf+bounces-40102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118197C953
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 14:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793501F21A9F
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1321619DF95;
	Thu, 19 Sep 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WM72yw3b"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5D19D08C;
	Thu, 19 Sep 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749427; cv=none; b=tF/1+r9aG3F9B04rZMS0GfRAYZ7youw/1JJYiFBRpul8J5t3cva6wqwKZIrLoGXvjRFi4d2uX1EYJx82NPWUNasZJMeXswLR0Wm0GnLSg6r9Jk4/vv2GwhpAXRlJx/opBJn37Z2htZnLbEAgub62sbRgpq9Hl0XNHToksFLSWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749427; c=relaxed/simple;
	bh=N2WynsJqV7oDSGGbemSMNH57TnUsdtuBktnsJkKy5CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqsNGdV13Mb1QouCulk4+5pshVnqTKQxJ1D7gCuSABQTV4HTIBJhPur7Y5nm/2CaizOz8flnjd2+t2ns8TyjSwl41vTz5Dd5U5LApStUFIS+5nvJNUGvD6Umg+dOlrb0drVcnqSHC2CgYMh+Z4L+hIf3LXet4PHigDFrQL3iIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WM72yw3b; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726749414; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aBKZsM/fHRggoyYOEWRaAoMcXXznHZBlGeUHWJKN660=;
	b=WM72yw3bmRzYz+mojppiYvXzsUVUpsh5cq/70oFpdUH/S0M8mC2z0UYV0XSu6DFcNyvtX/oaaXAT6N2Fv4vz75GCyXQELvbzuZ383UYtcnw9s22UPRwz7HbnFf1UX26uaqfIHGhn2fLVmGpxPh5nCIUfbnk8XePhlepdufTSTMU=
Received: from 30.221.101.105(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WFHgF5L_1726749412)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 20:36:54 +0800
Message-ID: <f9db0ec5-c779-4627-9e1f-0f6af98d2de5@linux.alibaba.com>
Date: Thu, 19 Sep 2024 20:36:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net/smc: Introduce a hook to modify syn_smc
 at runtime
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com,
 bpf@vger.kernel.org
References: <1726654204-61655-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <1726654204-61655-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/9/18 18:10, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> The introduction of IPPROTO_SMC enables eBPF programs to determine
> whether to use SMC based on the context of socket creation, such as
> network namespaces, PID and comm name, etc.
> 
> As a subsequent enhancement, this patch introduces a new hook for eBPF
> programs that allows decisions on whether to use SMC or not at runtime,
> including but not limited to local/remote IP address or ports. In
> simpler words, this feature allows modifications to syn_smc through eBPF
> programs before the TCP three-way handshake got established.
> 
> Thanks to kfunc for making it easier for us to implement this feature in
> SMC.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Hi D. Wythe, 

I think it is a good feature to have for more flexible using of SMC.

It is also a good solution for the problem we met before:
Some services are not correctly handled TCP syn packet with SMC experimental option in head.
The TCP connections to such services can not be successfully established through SMC. Thus, a
program can not using SMC and accessing the services mentioned above in the same time.
With this feature, by filter the port to the services metioned above, it is possible for
programes both using SMC and accessing the services metioned above.

> ---
>  include/linux/tcp.h  |  4 ++-
>  net/ipv4/tcp_input.c |  4 +--
>  net/smc/af_smc.c     | 69 ++++++++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b..d028d76 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -478,7 +478,9 @@ struct tcp_sock {
>  #endif
>  #if IS_ENABLED(CONFIG_SMC)
>  	bool	syn_smc;	/* SYN includes SMC */
> -	bool	(*smc_hs_congested)(const struct sock *sk);
> +	void	(*smc_openreq_init)(struct request_sock *req,
> +			     const struct tcp_options_received *rx_opt,
> +			     struct sk_buff *skb, const struct sock *sk);
>  #endif
>  
>  #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e37488d..e33e2a0 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7029,8 +7029,8 @@ static void tcp_openreq_init(struct request_sock *req,
>  	ireq->ir_num = ntohs(tcp_hdr(skb)->dest);
>  	ireq->ir_mark = inet_request_mark(sk, skb);
>  #if IS_ENABLED(CONFIG_SMC)
> -	ireq->smc_ok = rx_opt->smc_ok && !(tcp_sk(sk)->smc_hs_congested &&
> -			tcp_sk(sk)->smc_hs_congested(sk));
> +	if (ireq->smc_ok && tcp_sk(sk)->smc_openreq_init)Should be rx_opt->smc_ok?

> +		tcp_sk(sk)->smc_openreq_init(req, rx_opt, skb, sk);
>  #endif
>  }
>  
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 0316217..003b2ac 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -70,6 +70,15 @@
>  static void smc_tcp_listen_work(struct work_struct *);
>  static void smc_connect_work(struct work_struct *);
>  
> +__bpf_hook_start();
> +
> +__weak noinline int select_syn_smc(const struct sock *sk, struct sockaddr *peer)
> +{
> +	return 1;
> +}
> +
> +__bpf_hook_end();
> +
>  int smc_nl_dump_hs_limitation(struct sk_buff *skb, struct netlink_callback *cb)
>  {
>  	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
> @@ -156,19 +165,41 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  	return NULL;
>  }
>  
> -static bool smc_hs_congested(const struct sock *sk)
> +static void smc_openreq_init(struct request_sock *req,
> +			     const struct tcp_options_received *rx_opt,
> +			     struct sk_buff *skb, const struct sock *sk)
>  {
> +	struct inet_request_sock *ireq = inet_rsk(req);
> +	struct sockaddr_storage rmt_sockaddr = {0};
>  	const struct smc_sock *smc;
>  
>  	smc = smc_clcsock_user_data(sk);
>  
>  	if (!smc)
> -		return true;
> +		return;
It is better goto out_no_smc rather than return to explicitly set ireq->smc_ok to 0.

>  
> -	if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
> -		return true;
> +	if (smc->limit_smc_hs && workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
> +		goto out_no_smc;
>  
> -	return false;
> +	rmt_sockaddr.ss_family = sk->sk_family;
> +
> +	if (rmt_sockaddr.ss_family == AF_INET) {
> +		struct sockaddr_in *rmt4_sockaddr =  (struct sockaddr_in *)&rmt_sockaddr;
> +
> +		rmt4_sockaddr->sin_addr.s_addr = ireq->ir_rmt_addr;
> +		rmt4_sockaddr->sin_port	= ireq->ir_rmt_port;
> +	} else {
> +		struct sockaddr_in6 *rmt6_sockaddr =  (struct sockaddr_in6 *)&rmt_sockaddr;
> +
> +		rmt6_sockaddr->sin6_addr = ireq->ir_v6_rmt_addr;
> +		rmt6_sockaddr->sin6_port = ireq->ir_rmt_port;
> +	}
> +
> +	ireq->smc_ok = select_syn_smc(sk, (struct sockaddr *)&rmt_sockaddr);
> +	return;
> +out_no_smc:
> +	ireq->smc_ok = 0;
> +	return;
>  }
>  
>  struct smc_hashinfo smc_v4_hashinfo = {
> @@ -1671,7 +1702,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
>  	}
>  
>  	smc_copy_sock_settings_to_clc(smc);
> -	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
> +	tcp_sk(smc->clcsock->sk)->syn_smc = select_syn_smc(sk, addr);
>  	if (smc->connect_nonblock) {
>  		rc = -EALREADY;
>  		goto out;
> @@ -2650,8 +2681,7 @@ int smc_listen(struct socket *sock, int backlog)
>  
>  	inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
>  
> -	if (smc->limit_smc_hs)
> -		tcp_sk(smc->clcsock->sk)->smc_hs_congested = smc_hs_congested;
> +	tcp_sk(smc->clcsock->sk)->smc_openreq_init = smc_openreq_init;
>  
>  	rc = kernel_listen(smc->clcsock, backlog);
>  	if (rc) {
> @@ -3475,6 +3505,20 @@ static void __net_exit smc_net_stat_exit(struct net *net)
>  	.exit = smc_net_stat_exit,
>  };
>  
> +BTF_SET8_START(bpf_smc_fmodret_ids)
> +BTF_ID_FLAGS(func, select_syn_smc)
> +BTF_SET8_END(bpf_smc_fmodret_ids)
> +
> +static const struct btf_kfunc_id_set bpf_smc_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_smc_fmodret_ids,
> +};
> +
> +static int __init bpf_smc_kfunc_init(void)
> +{
> +	return register_btf_fmodret_id_set(&bpf_smc_fmodret_set);
> +}
Does it have unregister function? Is it OK for repeate register when reload the smc module?

Thanks,
Guangguan Wang
> +
>  static int __init smc_init(void)
>  {
>  	int rc;
> @@ -3574,8 +3618,17 @@ static int __init smc_init(void)
>  		pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
>  		goto out_ulp;
>  	}
> +
> +	rc = bpf_smc_kfunc_init();
> +	if (rc) {
> +		pr_err("%s: bpf_smc_kfunc_init fails with %d\n", __func__, rc);
> +		goto out_inet;
> +	}
> +
>  	static_branch_enable(&tcp_have_smc);
>  	return 0;
> +out_inet:
> +	smc_inet_exit();
>  out_ulp:
>  	tcp_unregister_ulp(&smc_ulp_ops);
>  out_lo:

