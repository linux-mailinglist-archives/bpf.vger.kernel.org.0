Return-Path: <bpf+bounces-43121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CC9AF630
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 02:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9511F22C0D
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD46AAD;
	Fri, 25 Oct 2024 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="POSimtOW"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388AFAD21
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816032; cv=none; b=jzfHaV3oV0oxG90kwJVCwwZUNnDpCidUGkvAmAT05atKq8Kh0ZAcPny08YbJJD7dXZdLYgZIJMryya7R3Zw6XKxHW9uWVDbsoreVYuv+ULrVj3ikX2+zSKjt2HMvcecwDaACimBgBjBDRIiSaAdW0NLvNFCOjvuhSX8Fklr/NyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816032; c=relaxed/simple;
	bh=sUlonnYzk09GLqAwS2WJKo0KBHCiiNG2So7rABxdhfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKVRYUkpNfcjUKALwQ7k2qBI4WrSqWvuv7O0cIqWwoK+ng5N82TR740YYXoPEeqdlgOMzonEdR00koM6FtPrHoolQzm4SsdV1FRX8rkBJ2rXW5E3XUo053STjjK8Nmg8ZHu1w2abwzNRfczjcQAUJFkcaEtNWP2wX7Qj7S4Itd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=POSimtOW; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <74c06b43-095f-414a-b4aa-2addbe610336@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729816021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO+P2/BVH76BUnj+FBfjAkcsAssXYM+8F1HEYhrXDuw=;
	b=POSimtOWIPEl0SvDBCtD8jra2jpxRO7BUt2vYNMqbYd76zb+19gQUvWCz4MdfsZpcmMt2/
	5c5pNRki6wj9VVbwf9zR5o0qSw3gEiU4nN2QjQMwzo2SwgEJokA5P/ax4c3u+SqtmS00rZ
	867z4ejQUEU79LgL2qiVjW9JvRV2V9M=
Date: Thu, 24 Oct 2024 17:26:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/4] net/smc: Introduce smc_bpf_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-4-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <1729737768-124596-4-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/23/24 7:42 PM, D. Wythe wrote:
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
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   include/linux/tcp.h   |   2 +-
>   include/net/smc.h     |  47 +++++++++++
>   include/net/tcp.h     |   6 ++
>   net/ipv4/tcp_input.c  |   3 +-
>   net/ipv4/tcp_output.c |  14 +++-
>   net/smc/Kconfig       |  12 +++
>   net/smc/Makefile      |   1 +
>   net/smc/af_smc.c      |  38 ++++++---
>   net/smc/smc.h         |   4 +
>   net/smc/smc_bpf.c     | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_bpf.h     |  34 ++++++++
>   11 files changed, 357 insertions(+), 16 deletions(-)
>   create mode 100644 net/smc/smc_bpf.c
>   create mode 100644 net/smc/smc_bpf.h
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b..4ef160a 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -478,7 +478,7 @@ struct tcp_sock {
>   #endif
>   #if IS_ENABLED(CONFIG_SMC)
>   	bool	syn_smc;	/* SYN includes SMC */
> -	bool	(*smc_hs_congested)(const struct sock *sk);
> +	struct tcpsmc_ctx *smc;
>   #endif
>   
>   #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> diff --git a/include/net/smc.h b/include/net/smc.h
> index db84e4e..34ab2c6 100644
> --- a/include/net/smc.h
> +++ b/include/net/smc.h
> @@ -18,6 +18,8 @@
>   #include "linux/ism.h"
>   
>   struct sock;
> +struct tcp_sock;
> +struct inet_request_sock;
>   
>   #define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
>   
> @@ -97,4 +99,49 @@ struct smcd_dev {
>   	u8 going_away : 1;
>   };
>   
> +/*
> + * This structure is used to store the parameters passed to the member of struct_ops.
> + * Due to the BPF verifier cannot restrict the writing of bit fields, such as limiting
> + * it to only write ireq->smc_ok. Using kfunc can solve this issue, but we don't want
> + * to introduce a kfunc with such a narrow function.

imo, adding kfunc is fine.

> + *
> + * Moreover, using this structure for unified parameters also addresses another
> + * potential issue. Currently, kfunc cannot recognize the calling context
> + * through BPF's existing structure. In the future, we can solve this problem
> + * by passing this ctx to kfunc.

This part I don't understand. How is it different from the "tcp_cubic_kfunc_set" 
allowed in tcp_congestion_ops?

> + */
> +struct smc_bpf_ops_ctx {
> +	struct {
> +		struct tcp_sock *tp;
> +	} set_option;
> +	struct {
> +		const struct tcp_sock *tp;
> +		struct inet_request_sock *ireq;
> +		int smc_ok;
> +	} set_option_cond;
> +};

There is no need to create one single ctx for struct_ops prog. struct_ops prog 
can take >1 args and different ops can take different args.

> +
> +struct smc_bpf_ops {
> +	/* priavte */
> +
> +	struct list_head	list;
> +
> +	/* public */
> +
> +	/* Invoked before computing SMC option for SYN packets.
> +	 * We can control whether to set SMC options by modifying
> +	 * ctx->set_option->tp->syn_smc.
> +	 * This's also the only member that can be modified now.
> +	 * Only member in ctx->set_option is valid for this callback.
> +	 */
> +	void (*set_option)(struct smc_bpf_ops_ctx *ctx);
> +
> +	/* Invoked before Set up SMC options for SYN-ACK packets
> +	 * We can control whether to respond SMC options by modifying
> +	 * ctx->set_option_cond.smc_ok.
> +	 * Only member in ctx->set_option_cond is valid for this callback.
> +	 */
> +	void (*set_option_cond)(struct smc_bpf_ops_ctx *ctx);

The struct smc_bpf_ops already has set_option and set_option_cnd, but...

> +};
> +
>   #endif	/* _SMC_H */
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 739a9fb..c322443 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2730,6 +2730,12 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
>   
>   #if IS_ENABLED(CONFIG_SMC)
>   extern struct static_key_false tcp_have_smc;
> +struct tcpsmc_ctx {
> +	/* Invoked before computing SMC option for SYN packets. */
> +	void (*set_option)(struct tcp_sock *tp);
> +	/* Invoked before Set up SMC options for SYN-ACK packets */
> +	void (*set_option_cond)(const struct tcp_sock *tp, struct inet_request_sock *ireq);
> +};

another new struct tcpsmc_ctx has exactly the same functions (at least the same 
name) but different arguments. I don't understand why this duplicate, is it 
because the need to prepare the "struct smc_bpf_ops_ctx"?

The "struct tcpsmc_ctx" should be the "struct smc_bpf_ops" itself.

[ ... ]

> +static int smc_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
> +					 const struct bpf_reg_state *reg,
> +					 const struct bpf_prog *prog,
> +					 int off, int size)
> +{
> +	const struct btf_member *member;
> +	const char *mname;
> +	int member_idx;
> +
> +	member_idx = prog->expected_attach_type;
> +	if (member_idx >= btf_type_vlen(smc_bpf_ops_type))
> +		goto out_err;
> +
> +	member = &btf_type_member(smc_bpf_ops_type)[member_idx];
> +	mname = btf_str_by_offset(saved_btf, member->name_off);
> +
> +	if (!strcmp(mname, "set_option")) {

btf_member_bit_offset can be used instead of strcmp. Take a look at bpf_tcp_ca.c 
and kernel/sched/ext.c

> +		/* only support to modify tcp_sock->syn_smc */
> +		if (reg->btf_id == tcp_sock_id &&
> +		    off == offsetof(struct tcp_sock, syn_smc) &&
> +		    off + size == offsetofend(struct tcp_sock, syn_smc))
> +			return 0;
> +	} else if (!strcmp(mname, "set_option_cond")) {
> +		/* only support to modify smc_bpf_ops_ctx->smc_ok */
> +		if (reg->btf_id == smc_bpf_ops_ctx_id &&
> +		    off == offsetof(struct smc_bpf_ops_ctx, set_option_cond.smc_ok) &&
> +		    off + size == offsetofend(struct smc_bpf_ops_ctx, set_option_cond.smc_ok))
> +			return 0;
> +	}
> +
> +out_err:
> +	return -EACCES;
> +}
> +
> +static const struct bpf_verifier_ops smc_bpf_verifier_ops = {
> +	.get_func_proto = bpf_base_func_proto,
> +	.is_valid_access = bpf_tracing_btf_ctx_access,
> +	.btf_struct_access = smc_bpf_ops_btf_struct_access,
> +};
> +
> +static struct bpf_struct_ops bpf_smc_bpf_ops = {
> +	.init = smc_bpf_ops_init,
> +	.name = "smc_bpf_ops",
> +	.reg = smc_bpf_ops_reg,
> +	.unreg = smc_bpf_ops_unreg,
> +	.cfi_stubs = &__bpf_smc_bpf_ops,
> +	.verifier_ops = &smc_bpf_verifier_ops,
> +	.init_member = smc_bpf_ops_init_member,
> +	.check_member = smc_bpf_ops_check_member,
> +	.owner = THIS_MODULE,
> +};
> +
> +int smc_bpf_struct_ops_init(void)
> +{
> +	return register_bpf_struct_ops(&bpf_smc_bpf_ops, smc_bpf_ops);
> +}
> +
> +void bpf_smc_set_tcp_option(struct tcp_sock *tp)
> +{
> +	struct smc_bpf_ops_ctx ops_ctx = {};
> +	struct smc_bpf_ops *ops;
> +
> +	ops_ctx.set_option.tp = tp;

All this initialization should be unnecessary. Directly pass tp instead.

> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ops, &smc_bpf_ops_list, list) {

Does it need to have a list (meaning >1) of smc_bpf_ops to act on a sock? The 
ordering expectation is hard to manage.

> +		ops->set_option(&ops_ctx);

A dumb question. This will only affect AF_SMC (or AF_INET[6]/IPPROTO_SMC) 
socket but not the AF_INET[6]/IPPROTO_{TCP,UDP} socket?

pw-bot: cr

> +	}
> +	rcu_read_unlock();
> +}

