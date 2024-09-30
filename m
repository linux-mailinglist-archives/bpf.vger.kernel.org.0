Return-Path: <bpf+bounces-40542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DEC989B32
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DBF9B21230
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9D156F3C;
	Mon, 30 Sep 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PsX4i5iU"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37E45027;
	Mon, 30 Sep 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680561; cv=none; b=RaioUj5LImg7GdwMmLFTpjkfwnuOtV1SJkguLxXop9t07MiCewc/uaRZwu6rxgiZbTQLkw5m/SOhKfheuufLHPzz/25KW9ffOW4NebnTysly6FHbsePIpTncdPHaUY/ae6z7UrhhuArjvgMRLPwdh/UMErFX/aOSnEs3VD4oeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680561; c=relaxed/simple;
	bh=woMxg/j4NP6XZd49rIGatAG25hIrZzeXyxPnCn/FYPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFbSWjLYUCl6ol1doOjYgP31EQCDvHC2s226vqW4obA5AXxTH50ApodZCQCygD65DId/1WqLEIpBgbvXTaLUS214DIRtyBBHScd2aovon0XVqGC5iprWqRVI6KlhMkUU5MnHWWKO1yHOErPHSiBcWN5b8VWv2R/98EU4ucvuDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PsX4i5iU; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727680550; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JZL/ku9aK9zw7vcczmtqa5/1hHelV84Np4wXlJZ7rek=;
	b=PsX4i5iUM0+n2ProvPT6uiNcHZEsP6TcKgCZwiaE298gfOrJbmrO7UYLAGx3fCYNGcUKNxurI3jD8IZ0PJOuFXDJKfIlwmfobBxoR/d8u1eIO+6OqZwQr1tXorquIXg8iMzqTsggn9YSX3/+vRmpDaJkmJND8EsDf5Y/TkxDYGk=
Received: from 30.221.144.234(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WG-IUOL_1727680548)
          by smtp.aliyun-inc.com;
          Mon, 30 Sep 2024 15:15:49 +0800
Message-ID: <be2685ab-272a-4f10-9322-a0bb0a35e3d4@linux.alibaba.com>
Date: Mon, 30 Sep 2024 15:15:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2] net/smc: Introduce a hook to modify
 syn_smc at runtime
To: Zhu Yanjun <yanjun.zhu@linux.dev>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com,
 bpf@vger.kernel.org
References: <1727408549-106551-1-git-send-email-alibuda@linux.alibaba.com>
 <f60061bb-109a-4fa8-b419-07585cbb79e3@linux.dev>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <f60061bb-109a-4fa8-b419-07585cbb79e3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/29/24 7:56 PM, Zhu Yanjun wrote:
> 在 2024/9/27 11:42, D. Wythe 写道:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> The introduction of IPPROTO_SMC enables eBPF programs to determine
>> whether to use SMC based on the context of socket creation, such as
>> network namespaces, PID and comm name, etc.
>>
>> As a subsequent enhancement, this patch introduces a new hook for eBPF
>> programs that allows decisions on whether to use SMC or not at runtime,
>> including but not limited to local/remote IP address or ports. In
>> simpler words, this feature allows modifications to syn_smc through eBPF
>> programs before the TCP three-way handshake got established.
>>
>> Thanks to kfunc for making it easier for us to implement this feature in
>> SMC.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>
>> ---
>> v1 -> v2:
>> 1. Fix wrong use of ireq->smc_ok, should be rx_opt->smc_ok.
>> 2. Fix compile error when CONFIG_IPV6 or CONFIG_BPF_SYSCALL was not set.
>>
>> ---
>>   include/linux/tcp.h  |  4 ++-
>>   net/ipv4/tcp_input.c |  4 +--
>>   net/smc/af_smc.c     | 75 ++++++++++++++++++++++++++++++++++++++++++++++------
>>   3 files changed, 72 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>> index 6a5e08b..d028d76 100644
>> --- a/include/linux/tcp.h
>> +++ b/include/linux/tcp.h
>> @@ -478,7 +478,9 @@ struct tcp_sock {
>>   #endif
>>   #if IS_ENABLED(CONFIG_SMC)
>>       bool    syn_smc;    /* SYN includes SMC */
>> -    bool    (*smc_hs_congested)(const struct sock *sk);
>> +    void    (*smc_openreq_init)(struct request_sock *req,
>> +                 const struct tcp_options_received *rx_opt,
>> +                 struct sk_buff *skb, const struct sock *sk);
>>   #endif
>>   #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 9f314df..99f34f5 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -7036,8 +7036,8 @@ static void tcp_openreq_init(struct request_sock *req,
>>       ireq->ir_num = ntohs(tcp_hdr(skb)->dest);
>>       ireq->ir_mark = inet_request_mark(sk, skb);
>>   #if IS_ENABLED(CONFIG_SMC)
>> -    ireq->smc_ok = rx_opt->smc_ok && !(tcp_sk(sk)->smc_hs_congested &&
>> -            tcp_sk(sk)->smc_hs_congested(sk));
>> +    if (rx_opt->smc_ok && tcp_sk(sk)->smc_openreq_init)
>> +        tcp_sk(sk)->smc_openreq_init(req, rx_opt, skb, sk);
>>   #endif
>>   }
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 0316217..fdac7e2b 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -70,6 +70,15 @@
>>   static void smc_tcp_listen_work(struct work_struct *);
>>   static void smc_connect_work(struct work_struct *);
>> +__bpf_hook_start();
>> +
>> +__weak noinline int select_syn_smc(const struct sock *sk, struct sockaddr *peer)
>> +{
>> +    return 1;
>> +}
>> +
>> +__bpf_hook_end();
>> +
>>   int smc_nl_dump_hs_limitation(struct sk_buff *skb, struct netlink_callback *cb)
>>   {
>>       struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
>> @@ -156,19 +165,43 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>>       return NULL;
>>   }
>> -static bool smc_hs_congested(const struct sock *sk)
>> +static void smc_openreq_init(struct request_sock *req,
>> +                 const struct tcp_options_received *rx_opt,
>> +                 struct sk_buff *skb, const struct sock *sk)
>>   {
>> +    struct inet_request_sock *ireq = inet_rsk(req);
>> +    struct sockaddr_storage rmt_sockaddr = {0};
> 
> A trivial problem.
> 
> The following should be better?
> 
> struct sockaddr_storage rmt_sockaddr = {};
> 
> I think, we have discussed this problem in RDMA maillist for several times.
> 
> Zhu Yanjun


This is truly new information to me. Can you provide me with some discussion links?
Thanks.

D. Wythe


> 
>>       const struct smc_sock *smc;
>>       smc = smc_clcsock_user_data(sk);
>>       if (!smc)
>> -        return true;
>> +        return;
>> -    if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
>> -        return true;
>> +    if (smc->limit_smc_hs && workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
>> +        goto out_no_smc;
>> -    return false;
>> +    rmt_sockaddr.ss_family = sk->sk_family;
>> +
>> +    if (rmt_sockaddr.ss_family == AF_INET) {
>> +        struct sockaddr_in *rmt4_sockaddr =  (struct sockaddr_in *)&rmt_sockaddr;
>> +
>> +        rmt4_sockaddr->sin_addr.s_addr = ireq->ir_rmt_addr;
>> +        rmt4_sockaddr->sin_port    = ireq->ir_rmt_port;
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +    } else {
>> +        struct sockaddr_in6 *rmt6_sockaddr =  (struct sockaddr_in6 *)&rmt_sockaddr;
>> +
>> +        rmt6_sockaddr->sin6_addr = ireq->ir_v6_rmt_addr;
>> +        rmt6_sockaddr->sin6_port = ireq->ir_rmt_port;
>> +#endif /* CONFIG_IPV6 */
>> +    }
>> +
>> +    ireq->smc_ok = select_syn_smc(sk, (struct sockaddr *)&rmt_sockaddr);
>> +    return;
>> +out_no_smc:
>> +    ireq->smc_ok = 0;
>> +    return;
>>   }
>>   struct smc_hashinfo smc_v4_hashinfo = {
>> @@ -1671,7 +1704,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
>>       }
>>       smc_copy_sock_settings_to_clc(smc);
>> -    tcp_sk(smc->clcsock->sk)->syn_smc = 1;
>> +    tcp_sk(smc->clcsock->sk)->syn_smc = select_syn_smc(sk, addr);
>>       if (smc->connect_nonblock) {
>>           rc = -EALREADY;
>>           goto out;
>> @@ -2650,8 +2683,7 @@ int smc_listen(struct socket *sock, int backlog)
>>       inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
>> -    if (smc->limit_smc_hs)
>> -        tcp_sk(smc->clcsock->sk)->smc_hs_congested = smc_hs_congested;
>> +    tcp_sk(smc->clcsock->sk)->smc_openreq_init = smc_openreq_init;
>>       rc = kernel_listen(smc->clcsock, backlog);
>>       if (rc) {
>> @@ -3475,6 +3507,24 @@ static void __net_exit smc_net_stat_exit(struct net *net)
>>       .exit = smc_net_stat_exit,
>>   };
>> +#if IS_ENABLED(CONFIG_BPF_SYSCALL)
>> +BTF_SET8_START(bpf_smc_fmodret_ids)
>> +BTF_ID_FLAGS(func, select_syn_smc)
>> +BTF_SET8_END(bpf_smc_fmodret_ids)
>> +
>> +static const struct btf_kfunc_id_set bpf_smc_fmodret_set = {
>> +    .owner = THIS_MODULE,
>> +    .set   = &bpf_smc_fmodret_ids,
>> +};
>> +
>> +static int bpf_smc_kfunc_init(void)
>> +{
>> +    return register_btf_fmodret_id_set(&bpf_smc_fmodret_set);
>> +}
>> +#else
>> +static inline int bpf_smc_kfunc_init(void) { return 0; }
>> +#endif /* CONFIG_BPF_SYSCALL */
>> +
>>   static int __init smc_init(void)
>>   {
>>       int rc;
>> @@ -3574,8 +3624,17 @@ static int __init smc_init(void)
>>           pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
>>           goto out_ulp;
>>       }
>> +
>> +    rc = bpf_smc_kfunc_init();
>> +    if (rc) {
>> +        pr_err("%s: bpf_smc_kfunc_init fails with %d\n", __func__, rc);
>> +        goto out_inet;
>> +    }
>> +
>>       static_branch_enable(&tcp_have_smc);
>>       return 0;
>> +out_inet:
>> +    smc_inet_exit();
>>   out_ulp:
>>       tcp_unregister_ulp(&smc_ulp_ops);
>>   out_lo:

