Return-Path: <bpf+bounces-41838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4BF99BF72
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 07:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C12F1F22A2D
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 05:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79813C9A4;
	Mon, 14 Oct 2024 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cWTYpbQ0"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08284A2F;
	Mon, 14 Oct 2024 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728884961; cv=none; b=Xes1LXCsZFd2L+2EIRHeeJLdA6F3sKc9F22dkksJ26wZqX1aS0a6SV0552mjBmzYbQH7+TSACVlZDMORduDFF0HVckPDQ0m4MueG7fvXca1fSNHjswyv8tGj8xjG3ZK6VvYYYKbUQIcTUJNmLEVH8tJVgDPhhk79DG7ldvYD6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728884961; c=relaxed/simple;
	bh=GZPQGeuVLly80GBQ5LNdOoFSVtvCh6X+j4fAOpNl+fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNbKFNLg9sHhCyd2xE6AjT9HTxhuPRAXMr7X8o5YaNJ84FC6RpRRLxXrLpcJBtU7NwAUx4Jlx6D/Zo9dWw9edLs1ho3BB+hxKZO+JxisXaJgAbKAeDry7+gLzOYLNJhoAuUR3btj2aSPw5RSgLNvBeuSTsSaD+mZWdIdBymOVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cWTYpbQ0; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728884954; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tgmBE+YRai5Mg3O+pgz5N0iZD5sYwVXA22b3yvk3T5U=;
	b=cWTYpbQ0TwLtcWFAeba0C+QZuwlfbJdHWzQJIXaauchjNC8CNazF68dyAKRILQr/Vw19XEsHIokrw1h/fIhyCgt/m2tFjCYQWBSPBbbXjfkHFFGPhyz27FiPiPpAgrx64ATAG8o5DQBdeGDoqpMa1ViLvjeUw3fxppSbTvZxQi0=
Received: from 30.32.80.190(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WH0jDKk_1728884953 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 13:49:14 +0800
Message-ID: <523f99d8-8b21-48a7-827c-01491994db6f@linux.alibaba.com>
Date: Mon, 14 Oct 2024 13:49:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: Introduce a hook to modify syn_smc at
 runtime
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com,
 Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Network Development <netdev@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-rdma@vger.kernel.org,
 Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>
References: <1728532691-20044-1-git-send-email-alibuda@linux.alibaba.com>
 <CAADnVQLXyA__zdDSiTdhaw=dXyfgmkr--cH068JvNK=JAYvRDA@mail.gmail.com>
 <b5aa477d-a4b1-45cb-af44-bd737504734e@linux.alibaba.com>
 <CAADnVQLS69MVZwTrek=ixP+1T7=+Fq0_kuOKgqBS+o4UoXMxFw@mail.gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAADnVQLS69MVZwTrek=ixP+1T7=+Fq0_kuOKgqBS+o4UoXMxFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/11/24 11:37 PM, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 11:44 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
>>
>>
>>
>> On 10/11/24 12:21 AM, Alexei Starovoitov wrote:
>>> On Wed, Oct 9, 2024 at 8:58 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
>>>>
>>>>
>>>> +__bpf_hook_start();
>>>> +
>>>> +__weak noinline int select_syn_smc(const struct sock *sk, struct sockaddr *peer)
>>>> +{
>>>> +       return 1;
>>>> +}
>>>> +
>>>> +__bpf_hook_end();
>>>> +
>>>>    int smc_nl_dump_hs_limitation(struct sk_buff *skb, struct netlink_callback *cb)
>>>>    {
>>>>           struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
>>>> @@ -156,19 +165,43 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>>>>           return NULL;
>>>>    }
>>>>
>>>> -static bool smc_hs_congested(const struct sock *sk)
>>>> +static void smc_openreq_init(struct request_sock *req,
>>>> +                            const struct tcp_options_received *rx_opt,
>>>> +                            struct sk_buff *skb, const struct sock *sk)
>>>>    {
>>>> +       struct inet_request_sock *ireq = inet_rsk(req);
>>>> +       struct sockaddr_storage rmt_sockaddr = {};
>>>>           const struct smc_sock *smc;
>>>>
>>>>           smc = smc_clcsock_user_data(sk);
>>>>
>>>>           if (!smc)
>>>> -               return true;
>>>> +               return;
>>>>
>>>> -       if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
>>>> -               return true;
>>>> +       if (smc->limit_smc_hs && workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
>>>> +               goto out_no_smc;
>>>>
>>>> -       return false;
>>>> +       rmt_sockaddr.ss_family = sk->sk_family;
>>>> +
>>>> +       if (rmt_sockaddr.ss_family == AF_INET) {
>>>> +               struct sockaddr_in *rmt4_sockaddr =  (struct sockaddr_in *)&rmt_sockaddr;
>>>> +
>>>> +               rmt4_sockaddr->sin_addr.s_addr = ireq->ir_rmt_addr;
>>>> +               rmt4_sockaddr->sin_port = ireq->ir_rmt_port;
>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>> +       } else {
>>>> +               struct sockaddr_in6 *rmt6_sockaddr =  (struct sockaddr_in6 *)&rmt_sockaddr;
>>>> +
>>>> +               rmt6_sockaddr->sin6_addr = ireq->ir_v6_rmt_addr;
>>>> +               rmt6_sockaddr->sin6_port = ireq->ir_rmt_port;
>>>> +#endif /* CONFIG_IPV6 */
>>>> +       }
>>>> +
>>>> +       ireq->smc_ok = select_syn_smc(sk, (struct sockaddr *)&rmt_sockaddr);
>>>> +       return;
>>>> +out_no_smc:
>>>> +       ireq->smc_ok = 0;
>>>> +       return;
>>>>    }
>>>>
>>>>    struct smc_hashinfo smc_v4_hashinfo = {
>>>> @@ -1671,7 +1704,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
>>>>           }
>>>>
>>>>           smc_copy_sock_settings_to_clc(smc);
>>>> -       tcp_sk(smc->clcsock->sk)->syn_smc = 1;
>>>> +       tcp_sk(smc->clcsock->sk)->syn_smc = select_syn_smc(sk, addr);
>>>>           if (smc->connect_nonblock) {
>>>>                   rc = -EALREADY;
>>>>                   goto out;
>>>> @@ -2650,8 +2683,7 @@ int smc_listen(struct socket *sock, int backlog)
>>>>
>>>>           inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
>>>>
>>>> -       if (smc->limit_smc_hs)
>>>> -               tcp_sk(smc->clcsock->sk)->smc_hs_congested = smc_hs_congested;
>>>> +       tcp_sk(smc->clcsock->sk)->smc_openreq_init = smc_openreq_init;
>>>>
>>>>           rc = kernel_listen(smc->clcsock, backlog);
>>>>           if (rc) {
>>>> @@ -3475,6 +3507,24 @@ static void __net_exit smc_net_stat_exit(struct net *net)
>>>>           .exit = smc_net_stat_exit,
>>>>    };
>>>>
>>>> +#if IS_ENABLED(CONFIG_BPF_SYSCALL)
>>>> +BTF_SET8_START(bpf_smc_fmodret_ids)
>>>> +BTF_ID_FLAGS(func, select_syn_smc)
>>>> +BTF_SET8_END(bpf_smc_fmodret_ids)
>>>> +
>>>> +static const struct btf_kfunc_id_set bpf_smc_fmodret_set = {
>>>> +       .owner = THIS_MODULE,
>>>> +       .set   = &bpf_smc_fmodret_ids,
>>>> +};
>>>> +
>>>> +static int bpf_smc_kfunc_init(void)
>>>> +{
>>>> +       return register_btf_fmodret_id_set(&bpf_smc_fmodret_set);
>>>> +}
>>>
>>> fmodret was an approach that hid-bpf took initially,
>>> but eventually they removed it all and switched to struct-ops approach.
>>> Please learn that lesson.
>>> Use struct_ops from the beginning.
>>>
>>> I did a presentation recently explaining the motivation behind
>>> struct_ops and tips on how to extend the kernel.
>>> TLDR: the step one is to design the extension _without_ bpf.
>>> The interface should be usable for kernel modules.
>>> And then when you have *_ops style api in place
>>> the bpf progs will plug-in without extra work.
>>>
>>> Slides:
>>> https://github.com/4ast/docs/blob/main/BPF%20struct-ops.pdf
>>
>>
>> Hi Alexei,
>>
>> Thanks very much for your suggestion.
>>
>> In fact, I tried struct_ops in SMC about a year ago. Unfortunately, at that time struct_ops did not
>> support registration from modules, and I had to move some smc dependencies into bpf, which met with
>> community opposition. However, I noticed that this feature is now supported, so perhaps this is an
>> opportunity.
>>
>> But on the other hand, given the current functionality, I wonder if struct_ops might be an overkill.
>> I haven't been able to come up with a suitable abstraction to define this ops, and in the future,
>> this ops might only contain the very one callback (select_syn_smc).
>>
>> Looking forward for your advises.
> 
> I guess I wasn't clear. It's a Nack to the current fmodret approach.


Understood, we do not oppose the use of struct_ops, especially when modules registration
was already supported.

