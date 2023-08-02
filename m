Return-Path: <bpf+bounces-6744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454DA76D7AD
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F781C212AE
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F26107B7;
	Wed,  2 Aug 2023 19:25:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AAE101D0
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 19:25:13 +0000 (UTC)
X-Greylist: delayed 72433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 12:25:10 PDT
Received: from out-85.mta1.migadu.com (out-85.mta1.migadu.com [IPv6:2001:41d0:203:375::55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD330199F
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:25:10 -0700 (PDT)
Message-ID: <39bad6b2-5498-b2e3-c70c-e27a74834026@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691004309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/9G23BGCFDPF5yS0icPtAseV3LdNcLHhB+lifHV4t0=;
	b=iAArbzpadFXzDx0IAp1AQ2v2JSd3zxETNCtwdArCa4M+NaWUYrRCrJRUSOMbbBhm4Xdfnx
	f4uWCmBM+0xqpR6Nitf+ufdFkUTRF8ov8/JWXUOMgw88VELqoSpGToi/yF2qPS+/gwBGqm
	ObLgedj4fquEr4k1ICUVzB3vrIHa7Cs=
Date: Wed, 2 Aug 2023 12:25:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next 1/5] bpf: enable sleepable BPF programs attached to
 cgroup/{get,set}sockopt.
Content-Language: en-US
To: kuifeng@meta.com
Cc: sinquersw@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230722052248.1062582-1-kuifeng@meta.com>
 <20230722052248.1062582-2-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230722052248.1062582-2-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/21/23 10:22 PM, kuifeng@meta.com wrote:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 739c15906a65..b2f81193f97b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7135,6 +7135,15 @@ struct bpf_sockopt {
>   	__s32	optname;
>   	__s32	optlen;
>   	__s32	retval;
> +
> +	__bpf_md_ptr(void *, user_optval);
> +	__bpf_md_ptr(void *, user_optval_end);
> +	__u32	flags;

I will follow up on the UAPI discussion in the other existing thread.

> +};
> +
> +enum bpf_sockopt_flags {
> +	/* optval is a pointer to user space memory */
> +	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
>   };
>   
>   struct bpf_pidns_info {
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5b2741aa0d9b..b268bbfa6c53 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -38,15 +38,26 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>   	const struct bpf_prog_array *array;
>   	struct bpf_run_ctx *old_run_ctx;
>   	struct bpf_cg_run_ctx run_ctx;
> +	bool do_sleepable;
>   	u32 func_ret;
>   
> +	do_sleepable =
> +		atype == CGROUP_SETSOCKOPT || atype == CGROUP_GETSOCKOPT;
> +
>   	run_ctx.retval = retval;
>   	migrate_disable();
> -	rcu_read_lock();
> +	if (do_sleepable) {
> +		might_fault();
> +		rcu_read_lock_trace();
> +	} else
> +		rcu_read_lock();
>   	array = rcu_dereference(cgrp->effective[atype]);

array is now under rcu_read_lock_trace for the "do_sleepable" case.

The array free side should be changed also to wait for the tasks_trace gp. 
Please check if any bpf_prog_array_free() usages in cgroup.c should be replaced 
with bpf_prog_array_free_sleepable().

Another high level comment is, other cgroup hooks may get sleepable support in 
the future. In particular the SEC("lsm_cgroup") when considering other lsm hooks 
in SEC("lsm.s") have sleepable support already. just want to bring up here for 
awareness. This set can focus on get/setsockopt for now.

>   	item = &array->items[0];
>   	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>   	while ((prog = READ_ONCE(item->prog))) {
> +		if (do_sleepable && !prog->aux->sleepable)
> +			rcu_read_lock();
> +
>   		run_ctx.prog_item = item;
>   		func_ret = run_prog(prog, ctx);
>   		if (ret_flags) {
> @@ -56,13 +67,43 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>   		if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
>   			run_ctx.retval = -EPERM;
>   		item++;
> +
> +		if (do_sleepable && !prog->aux->sleepable)
> +			rcu_read_unlock();
>   	}
>   	bpf_reset_run_ctx(old_run_ctx);
> -	rcu_read_unlock();
> +	if (do_sleepable)
> +		rcu_read_unlock_trace();
> +	else
> +		rcu_read_unlock();
>   	migrate_enable();
>   	return run_ctx.retval;
>   }
>   
> +static __always_inline bool
> +has_only_sleepable_prog_cg(const struct cgroup_bpf *cgrp,
> +			 enum cgroup_bpf_attach_type atype)
> +{
> +	const struct bpf_prog_array_item *item;
> +	const struct bpf_prog *prog;
> +	int cnt = 0;
> +	bool ret = true;
> +
> +	rcu_read_lock();
> +	item = &rcu_dereference(cgrp->effective[atype])->items[0];
> +	while (ret && (prog = READ_ONCE(item->prog))) {
> +		if (!prog->aux->sleepable)
> +			ret = false;
> +		item++;
> +		cnt++;
> +	}
> +	rcu_read_unlock();
> +	if (cnt == 0)
> +		ret = false;
> +
> +	return ret;
> +}
> +
>   unsigned int __cgroup_bpf_run_lsm_sock(const void *ctx,
>   				       const struct bpf_insn *insn)
>   {
> @@ -1773,7 +1814,8 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
>   static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
>   			     struct bpf_sockopt_buf *buf)
>   {
> -	if (ctx->optval == buf->data)
> +	if (ctx->optval == buf->data ||
> +	    ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
>   		return;
>   	kfree(ctx->optval);
>   }
> @@ -1781,7 +1823,8 @@ static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
>   static bool sockopt_buf_allocated(struct bpf_sockopt_kern *ctx,
>   				  struct bpf_sockopt_buf *buf)
>   {
> -	return ctx->optval != buf->data;
> +	return ctx->optval != buf->data &&
> +		!(ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER);
>   }
>   
>   int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
> @@ -1796,21 +1839,31 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>   		.optname = *optname,
>   	};
>   	int ret, max_optlen;
> +	bool alloc_mem;
> +
> +	alloc_mem = !has_only_sleepable_prog_cg(&cgrp->bpf, CGROUP_SETSOCKOPT);

hmm... I am not sure if this would work. The cgroup->effective[atype] could have 
been changed after this has_only_sleepable_prog_cg() check. For example, a 
non-sleepable prog is attached after this check. The latter 
bpf_prog_run_array_cg() may end up having an incorrect ctx.

A quick thought is, this alloc decision should be postponed to the 
bpf_prog_run_array_cg()? It may be better to have a different 
bpf_prog_run_array_cg for set/getsockopt here, not sure.

> +	if (!alloc_mem) {
> +		max_optlen = *optlen;
> +		ctx.optlen = *optlen;
> +		ctx.user_optval = optval;
> +		ctx.user_optval_end = optval + *optlen;
> +		ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
> +	} else {
> +		/* Allocate a bit more than the initial user buffer for
> +		 * BPF program. The canonical use case is overriding
> +		 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
> +		 */
> +		max_optlen = max_t(int, 16, *optlen);
> +		max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
> +		if (max_optlen < 0)
> +			return max_optlen;
>   
> -	/* Allocate a bit more than the initial user buffer for
> -	 * BPF program. The canonical use case is overriding
> -	 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
> -	 */
> -	max_optlen = max_t(int, 16, *optlen);
> -	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
> -	if (max_optlen < 0)
> -		return max_optlen;
> -
> -	ctx.optlen = *optlen;
> +		ctx.optlen = *optlen;
>   
> -	if (copy_from_user(ctx.optval, optval, min(*optlen, max_optlen)) != 0) {
> -		ret = -EFAULT;
> -		goto out;
> +		if (copy_from_user(ctx.optval, optval, min(*optlen, max_optlen)) != 0) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
>   	}


