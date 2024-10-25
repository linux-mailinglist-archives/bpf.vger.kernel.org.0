Return-Path: <bpf+bounces-43151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C719B00DE
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59635284144
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41E1EF958;
	Fri, 25 Oct 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zh80ygba"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC41CFEB5;
	Fri, 25 Oct 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854325; cv=none; b=L4j1dLrQI9jwRUNOhOoTre0rD2fUaAelncbPNF56NA1IT0BmqNlTxl8iYdgfkSTGHrq/yDJSPpL/gF6o37OHCobJY+FhzidcauED/q8TxvVip7ME5ZtmUIwaqaofZXb926iLwll4FIz96FkvtdBVyMp8GoehrcdUYP2Jqe7u25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854325; c=relaxed/simple;
	bh=OP+n9Lo5uVkyQ7KeuPyqUB9xxC4Afjg2YnkSGz18hQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH6tnBMZtIE36RfOdAHE/fQmB2grYC52e2udBBZweHekdvrtwJlGiwKcqJAhK//0v9/A/+7/netIa6LcRdM4uxXzMPVKvY++vkjf7JRcP9NpsmNUqQ5R9G2tAP9V3avYASbZE7evcpYDIvLkmqeBysV+VezgDpSI+f/6WOT6lwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zh80ygba; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729854312; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e0wxpLKhPBNVP2EQdPTAgZRzESsbupoxr0lzsi/G1MQ=;
	b=Zh80ygbakZ7j31wdWsOIENN6uv31RoPA+afgz1mOqkA7EAlCIDZGV0/J5R0UIKFnRtCW8deeF1vwmfz8Jtf1cUip8qDWlO8Dho1hj5ZWb8BhBsQWmdibZuCdhaVLO6ej5QhEsYK5djEGJqF5xmkZ9g+zblQhE3GV+phgL+l1Om0=
Received: from 30.221.147.209(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHsEbQx_1729854309 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 19:05:10 +0800
Message-ID: <e398770a-1ab5-478b-820d-16c6060e0008@linux.alibaba.com>
Date: Fri, 25 Oct 2024 19:05:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net/smc: Introduce smc_bpf_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-4-git-send-email-alibuda@linux.alibaba.com>
 <74c06b43-095f-414a-b4aa-2addbe610336@linux.dev>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <74c06b43-095f-414a-b4aa-2addbe610336@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/25/24 8:26 AM, Martin KaFai Lau wrote:
> On 10/23/24 7:42 PM, D. Wythe wrote:
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
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   include/linux/tcp.h   |   2 +-
>>   include/net/smc.h     |  47 +++++++++++
>>   include/net/tcp.h     |   6 ++
>>   net/ipv4/tcp_input.c  |   3 +-
>>   net/ipv4/tcp_output.c |  14 +++-
>>   net/smc/Kconfig       |  12 +++
>>   net/smc/Makefile      |   1 +
>>   net/smc/af_smc.c      |  38 ++++++---
>>   net/smc/smc.h         |   4 +
>>   net/smc/smc_bpf.c     | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   net/smc/smc_bpf.h     |  34 ++++++++
>>   11 files changed, 357 insertions(+), 16 deletions(-)
>>   create mode 100644 net/smc/smc_bpf.c
>>   create mode 100644 net/smc/smc_bpf.h
>>
>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>> index 6a5e08b..4ef160a 100644
>> --- a/include/linux/tcp.h
>> +++ b/include/linux/tcp.h
>> @@ -478,7 +478,7 @@ struct tcp_sock {
>>   #endif
>>   #if IS_ENABLED(CONFIG_SMC)
>>       bool    syn_smc;    /* SYN includes SMC */
>> -    bool    (*smc_hs_congested)(const struct sock *sk);
>> +    struct tcpsmc_ctx *smc;
>>   #endif
>>   #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
>> diff --git a/include/net/smc.h b/include/net/smc.h
>> index db84e4e..34ab2c6 100644
>> --- a/include/net/smc.h
>> +++ b/include/net/smc.h
>> @@ -18,6 +18,8 @@
>>   #include "linux/ism.h"
>>   struct sock;
>> +struct tcp_sock;
>> +struct inet_request_sock;
>>   #define SMC_MAX_PNETID_LEN    16    /* Max. length of PNET id */
>> @@ -97,4 +99,49 @@ struct smcd_dev {
>>       u8 going_away : 1;
>>   };
>> +/*
>> + * This structure is used to store the parameters passed to the member of struct_ops.
>> + * Due to the BPF verifier cannot restrict the writing of bit fields, such as limiting
>> + * it to only write ireq->smc_ok. Using kfunc can solve this issue, but we don't want
>> + * to introduce a kfunc with such a narrow function.
> 
> imo, adding kfunc is fine.
> 
>> + *
>> + * Moreover, using this structure for unified parameters also addresses another
>> + * potential issue. Currently, kfunc cannot recognize the calling context
>> + * through BPF's existing structure. In the future, we can solve this problem
>> + * by passing this ctx to kfunc.
> 
> This part I don't understand. How is it different from the "tcp_cubic_kfunc_set" allowed in 
> tcp_congestion_ops?

Hi Martin,

Yes, creating an independent kfunc for each callback and filtering via expected_attach_type can 
indeed solve the problem.

Our main concern is to avoid introducing kfuncs as much as possible. For our subsystem, we might 
need to maintain it in a way that maintains a uapi, as we certainly have user applications depending 
on it.

This is also why we need to create a separate ctx, as there’s no way to restrict bit writes, so we 
created a ctx->smc_ok that is allowed to write.

This is also why we had to create a separate structure, tcpsmc_ctx ...

However, I now realize that compromising to avoid introducing kfuncs has gone too far, affecting the 
readability of the code. I will try to use kfuncs in the next version to solve those issues.


> 
>> + */
>> +struct smc_bpf_ops_ctx {
>> +    struct {
>> +        struct tcp_sock *tp;
>> +    } set_option;
>> +    struct {
>> +        const struct tcp_sock *tp;
>> +        struct inet_request_sock *ireq;
>> +        int smc_ok;
>> +    } set_option_cond;
>> +};
> 
> There is no need to create one single ctx for struct_ops prog. struct_ops prog can take >1 args and 
> different ops can take different args.
> 

Same reason with concern on kfunc. I'll change it in next version.


>> +
>> +struct smc_bpf_ops {
>> +    /* priavte */
>> +
>> +    struct list_head    list;
>> +
>> +    /* public */
>> +
>> +    /* Invoked before computing SMC option for SYN packets.
>> +     * We can control whether to set SMC options by modifying
>> +     * ctx->set_option->tp->syn_smc.
>> +     * This's also the only member that can be modified now.
>> +     * Only member in ctx->set_option is valid for this callback.
>> +     */
>> +    void (*set_option)(struct smc_bpf_ops_ctx *ctx);
>> +
>> +    /* Invoked before Set up SMC options for SYN-ACK packets
>> +     * We can control whether to respond SMC options by modifying
>> +     * ctx->set_option_cond.smc_ok.
>> +     * Only member in ctx->set_option_cond is valid for this callback.
>> +     */
>> +    void (*set_option_cond)(struct smc_bpf_ops_ctx *ctx);
> 
> The struct smc_bpf_ops already has set_option and set_option_cnd, but...
> 
>> +};
>> +
>>   #endif    /* _SMC_H */
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 739a9fb..c322443 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -2730,6 +2730,12 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
>>   #if IS_ENABLED(CONFIG_SMC)
>>   extern struct static_key_false tcp_have_smc;
>> +struct tcpsmc_ctx {
>> +    /* Invoked before computing SMC option for SYN packets. */
>> +    void (*set_option)(struct tcp_sock *tp);
>> +    /* Invoked before Set up SMC options for SYN-ACK packets */
>> +    void (*set_option_cond)(const struct tcp_sock *tp, struct inet_request_sock *ireq);
>> +};
> 
> another new struct tcpsmc_ctx has exactly the same functions (at least the same name) but different 
> arguments. I don't understand why this duplicate, is it because the need to prepare the "struct 
> smc_bpf_ops_ctx"?

Yes, same reason with concern on kfunc. I'll change it in next version.

> 
> The "struct tcpsmc_ctx" should be the "struct smc_bpf_ops" itself.
> 
> [ ... ]
> 
>> +static int smc_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
>> +                     const struct bpf_reg_state *reg,
>> +                     const struct bpf_prog *prog,
>> +                     int off, int size)
>> +{
>> +    const struct btf_member *member;
>> +    const char *mname;
>> +    int member_idx;
>> +
>> +    member_idx = prog->expected_attach_type;
>> +    if (member_idx >= btf_type_vlen(smc_bpf_ops_type))
>> +        goto out_err;
>> +
>> +    member = &btf_type_member(smc_bpf_ops_type)[member_idx];
>> +    mname = btf_str_by_offset(saved_btf, member->name_off);
>> +
>> +    if (!strcmp(mname, "set_option")) {
> 
> btf_member_bit_offset can be used instead of strcmp. Take a look at bpf_tcp_ca.c and kernel/sched/ext.c
> 

Got it, thanks for that.

Besides, it seems that we don't need the export btf_str_by_offset anymore in that way.
I'll remove it in the next version.


>> +        /* only support to modify tcp_sock->syn_smc */
>> +        if (reg->btf_id == tcp_sock_id &&
>> +            off == offsetof(struct tcp_sock, syn_smc) &&
>> +            off + size == offsetofend(struct tcp_sock, syn_smc))
>> +            return 0;
>> +    } else if (!strcmp(mname, "set_option_cond")) {
>> +        /* only support to modify smc_bpf_ops_ctx->smc_ok */
>> +        if (reg->btf_id == smc_bpf_ops_ctx_id &&
>> +            off == offsetof(struct smc_bpf_ops_ctx, set_option_cond.smc_ok) &&
>> +            off + size == offsetofend(struct smc_bpf_ops_ctx, set_option_cond.smc_ok))
>> +            return 0;
>> +    }
>> +
>> +out_err:
>> +    return -EACCES;
>> +}
>> +
>> +static const struct bpf_verifier_ops smc_bpf_verifier_ops = {
>> +    .get_func_proto = bpf_base_func_proto,
>> +    .is_valid_access = bpf_tracing_btf_ctx_access,
>> +    .btf_struct_access = smc_bpf_ops_btf_struct_access,
>> +};
>> +
>> +static struct bpf_struct_ops bpf_smc_bpf_ops = {
>> +    .init = smc_bpf_ops_init,
>> +    .name = "smc_bpf_ops",
>> +    .reg = smc_bpf_ops_reg,
>> +    .unreg = smc_bpf_ops_unreg,
>> +    .cfi_stubs = &__bpf_smc_bpf_ops,
>> +    .verifier_ops = &smc_bpf_verifier_ops,
>> +    .init_member = smc_bpf_ops_init_member,
>> +    .check_member = smc_bpf_ops_check_member,
>> +    .owner = THIS_MODULE,
>> +};
>> +
>> +int smc_bpf_struct_ops_init(void)
>> +{
>> +    return register_bpf_struct_ops(&bpf_smc_bpf_ops, smc_bpf_ops);
>> +}
>> +
>> +void bpf_smc_set_tcp_option(struct tcp_sock *tp)
>> +{
>> +    struct smc_bpf_ops_ctx ops_ctx = {};
>> +    struct smc_bpf_ops *ops;
>> +
>> +    ops_ctx.set_option.tp = tp;
> 
> All this initialization should be unnecessary. Directly pass tp instead.
> 

Same reason with kfunc concern. I'll change it in next version.

>> +
>> +    rcu_read_lock();
>> +    list_for_each_entry_rcu(ops, &smc_bpf_ops_list, list) {
> 
> Does it need to have a list (meaning >1) of smc_bpf_ops to act on a sock? The ordering expectation 
> is hard to manage.
> 

Considering that the SMC modules also has its own ops that needs to be registered on it (the logic 
of smc_limit_fs), and need to be all executed, perhaps a list is a more suitable choice.


>> +        ops->set_option(&ops_ctx);
> 
> A dumb question. This will only affect AF_SMC (or AF_INET[6]/IPPROTO_SMC) socket but not the 
> AF_INET[6]/IPPROTO_{TCP,UDP} socket?
> 

Yes, it only affects AF_SMC, AF_SMC6, or IPPROTO_SMC sockets. Due to only SMC sockets will set 
tp->syn_smc, and we will check it before calling the very ops.

Best wishes,
D.

> pw-bot: cr
> 
>> +    }
>> +    rcu_read_unlock();
>> +}




