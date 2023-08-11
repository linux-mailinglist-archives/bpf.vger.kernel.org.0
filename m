Return-Path: <bpf+bounces-7616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222B3779AEB
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 01:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2D21C20B5B
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88FA34CD8;
	Fri, 11 Aug 2023 23:01:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBA2F4E
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 23:01:17 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9B35B0
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:01:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bbbf96ebe1so39024025ad.1
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691794875; x=1692399675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8aAmnCjq7B90urf8bzyfghKxKKnyJmP4N/RKIl4R2E=;
        b=wfyHjpU3z6R8rGbmVzUsbA9SdYjjXcj8OJ0xqMtPzVmiIMmboIBgJ67ys8jdoskG/U
         0Za/gFK94FfNhm0XxkoqxMG76lWzG4D1NquCbi+kGy3PPd3ThhhHrx2RSIfNDVsROnkT
         OfQwf9EWABjbrm5mTj9WQ0X0LpzL5oU/VUBhtpKwB1Ay5FRQlM0obwSHUBICfDOKmRrf
         in5uc3LkP1Gk6hfYdKEZ2QYBp/1eRVYh5T1jUJSTMAAkXD1zFkQuEkOO3Q0YxgfQKNKA
         xyuLv+081xr7ztQ84AQ78P00sS3yQ8IKSKCxJH3Ho0+OkJEKXbAU4dVGt393gF77lwWl
         5Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691794875; x=1692399675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8aAmnCjq7B90urf8bzyfghKxKKnyJmP4N/RKIl4R2E=;
        b=GUzkZ/kvZKZJaP9Ktrm8h1COTwXlQ6FQWFG7PWXHZJLXuZK1ec/fanjcUaCdXdpCS9
         6BhBR/byxJplLMI38ES55z80OUL6cOfkW9+CFwJy3g6tgYFBkd07s0WVBE0OKGb0srFz
         gMtQy7GJl2+U90Vqs7sju3kOR9wDFHbt/TWWKXiKqsgZk1gtpxgHxZwpTEHhaa2VTr2s
         PWkxyAV7UEJdPg8+Y4tKojE9vDoiWYvLJVfS5AZDJhLqafvZ3jZGH6VaefkBr9Ua5bIX
         PCXYT6wItDcM1Izctklzt/HnB/ncCQb/tBPeb6sDPawhQIw3qvIerSVkyQ8AxvpKDXl1
         h2KQ==
X-Gm-Message-State: AOJu0YxRiMw/1ZAcp1LvxLhXJJIErSdGAZHTmFb9siVQe8HmGfaBtkCb
	8BPLmRNsXce7gpKp+bMCcli3ufo=
X-Google-Smtp-Source: AGHT+IEJP56A/kRtJz6vaM54YxyemWGfFbkHJaVAibD8jTK6YD3+DatOdvOIvoepkPCAKb6lHfY0CXo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:14b:b0:25b:809a:c7a with SMTP id
 em11-20020a17090b014b00b0025b809a0c7amr748202pjb.3.1691794874989; Fri, 11 Aug
 2023 16:01:14 -0700 (PDT)
Date: Fri, 11 Aug 2023 16:01:13 -0700
In-Reply-To: <20230811043127.1318152-2-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811043127.1318152-1-thinker.li@gmail.com> <20230811043127.1318152-2-thinker.li@gmail.com>
Message-ID: <ZNa9uWK7KUVIj4Te@google.com>
Subject: Re: [RFC bpf-next v2 1/6] bpf: enable sleepable BPF programs attached
 to cgroup/{get,set}sockopt.
From: Stanislav Fomichev <sdf@google.com>
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, yonghong.song@linux.dev, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/10, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <kuifeng@meta.com>
> 
> Enable sleepable cgroup/{get,set}sockopt hooks.
> 
> The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks may
> received a pointer to the optval in user space instead of a kernel
> copy. ctx->user_optval and ctx->user_optval_end are the pointers to the
> begin and end of the user space buffer if receiving a user space
> buffer. ctx->optval and ctx->optval_end will be a kernel copy if receiving
> a kernel space buffer.
> 
> A program receives a user space buffer if ctx->flags &
> BPF_SOCKOPT_FLAG_OPTVAL_USER is true, otherwise it receives a kernel space
> buffer.  The BPF programs should not read/write from/to a user space buffer
> dirrectly.  It should access the buffer through bpf_copy_from_user() and
> bpf_copy_to_user() provided in the following patches.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/linux/filter.h         |   1 +
>  include/uapi/linux/bpf.h       |   7 +
>  kernel/bpf/cgroup.c            | 229 ++++++++++++++++++++++++++-------
>  kernel/bpf/verifier.c          |   7 +-
>  tools/include/uapi/linux/bpf.h |   7 +
>  tools/lib/bpf/libbpf.c         |   2 +
>  6 files changed, 206 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 761af6b3cf2b..54169a641d40 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1337,6 +1337,7 @@ struct bpf_sockopt_kern {
>  	s32		level;
>  	s32		optname;
>  	s32		optlen;
> +	u32		flags;
>  	/* for retval in struct bpf_cg_run_ctx */
>  	struct task_struct *current_task;
>  	/* Temporary "register" for indirect stores to ppos. */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70da85200695..fff6f7dff408 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7138,6 +7138,13 @@ struct bpf_sockopt {
>  	__s32	optname;
>  	__s32	optlen;
>  	__s32	retval;
> +
> +	__u32	flags;
> +};
> +
> +enum bpf_sockopt_flags {
> +	/* optval is a pointer to user space memory */
> +	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
>  };
>  
>  struct bpf_pidns_info {
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5b2741aa0d9b..59489d9619a3 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -28,25 +28,46 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>   * function pointer.
>   */
>  static __always_inline int
> -bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
> -		      enum cgroup_bpf_attach_type atype,
> -		      const void *ctx, bpf_prog_run_fn run_prog,
> -		      int retval, u32 *ret_flags)
> +bpf_prog_run_array_cg_cb(const struct cgroup_bpf *cgrp,
> +			 enum cgroup_bpf_attach_type atype,
> +			 const void *ctx, bpf_prog_run_fn run_prog,
> +			 int retval, u32 *ret_flags,
> +			 int (*progs_cb)(void *, const struct bpf_prog_array_item *),
> +			 void *progs_cb_arg)
>  {
>  	const struct bpf_prog_array_item *item;
>  	const struct bpf_prog *prog;
>  	const struct bpf_prog_array *array;
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_cg_run_ctx run_ctx;
> +	bool do_sleepable;
>  	u32 func_ret;
> +	int err;
> +
> +	do_sleepable =
> +		atype == CGROUP_SETSOCKOPT || atype == CGROUP_GETSOCKOPT;
>  
>  	run_ctx.retval = retval;
>  	migrate_disable();
> -	rcu_read_lock();
> +	if (do_sleepable) {
> +		might_fault();
> +		rcu_read_lock_trace();
> +	} else
> +		rcu_read_lock();
>  	array = rcu_dereference(cgrp->effective[atype]);
>  	item = &array->items[0];
> +
> +	if (progs_cb) {
> +		err = progs_cb(progs_cb_arg, item);
> +		if (err)
> +			return err;
> +	}
> +
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>  	while ((prog = READ_ONCE(item->prog))) {
> +		if (do_sleepable && !prog->aux->sleepable)
> +			rcu_read_lock();
> +
>  		run_ctx.prog_item = item;
>  		func_ret = run_prog(prog, ctx);
>  		if (ret_flags) {
> @@ -56,13 +77,48 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>  		if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
>  			run_ctx.retval = -EPERM;
>  		item++;
> +
> +		if (do_sleepable && !prog->aux->sleepable)
> +			rcu_read_unlock();
>  	}
>  	bpf_reset_run_ctx(old_run_ctx);
> -	rcu_read_unlock();
> +	if (do_sleepable)
> +		rcu_read_unlock_trace();
> +	else
> +		rcu_read_unlock();
>  	migrate_enable();
>  	return run_ctx.retval;
>  }
>  
> +static __always_inline void
> +count_sleepable_prog_cg(const struct bpf_prog_array_item *item,
> +			int *sleepable, int *non_sleepable)
> +{
> +	const struct bpf_prog *prog;
> +	bool ret = true;
> +
> +	*sleepable = 0;
> +	*non_sleepable = 0;
> +
> +	while (ret && (prog = READ_ONCE(item->prog))) {
> +		if (prog->aux->sleepable)
> +			(*sleepable)++;
> +		else
> +			(*non_sleepable)++;
> +		item++;
> +	}
> +}

Can we maintain this info in the slow attach/detach path?
Running the loop every time we get a sockopt syscall another time
seems like something we can avoid? (even though it's a slow path,
seems like we can do better?)

> +
> +static __always_inline int
> +bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
> +		      enum cgroup_bpf_attach_type atype,
> +		      const void *ctx, bpf_prog_run_fn run_prog,
> +		      int retval, u32 *ret_flags)
> +{
> +	return bpf_prog_run_array_cg_cb(cgrp, atype, ctx, run_prog, retval,
> +					ret_flags, NULL, NULL);
> +}
> +
>  unsigned int __cgroup_bpf_run_lsm_sock(const void *ctx,
>  				       const struct bpf_insn *insn)
>  {
> @@ -307,7 +363,7 @@ static void cgroup_bpf_release(struct work_struct *work)
>  		old_array = rcu_dereference_protected(
>  				cgrp->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> -		bpf_prog_array_free(old_array);
> +		bpf_prog_array_free_sleepable(old_array);
>  	}
>  
>  	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> @@ -451,7 +507,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
>  	/* free prog array after grace period, since __cgroup_bpf_run_*()
>  	 * might be still walking the array
>  	 */
> -	bpf_prog_array_free(old_array);
> +	bpf_prog_array_free_sleepable(old_array);
>  }
>  
>  /**
> @@ -491,7 +547,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
>  	return 0;
>  cleanup:
>  	for (i = 0; i < NR; i++)
> -		bpf_prog_array_free(arrays[i]);
> +		bpf_prog_array_free_sleepable(arrays[i]);
>  
>  	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
>  		cgroup_bpf_put(p);
> @@ -525,7 +581,7 @@ static int update_effective_progs(struct cgroup *cgrp,
>  
>  		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
>  			if (unlikely(desc->bpf.inactive)) {
> -				bpf_prog_array_free(desc->bpf.inactive);
> +				bpf_prog_array_free_sleepable(desc->bpf.inactive);
>  				desc->bpf.inactive = NULL;
>  			}
>  			continue;
> @@ -544,7 +600,7 @@ static int update_effective_progs(struct cgroup *cgrp,
>  	css_for_each_descendant_pre(css, &cgrp->self) {
>  		struct cgroup *desc = container_of(css, struct cgroup, self);
>  
> -		bpf_prog_array_free(desc->bpf.inactive);
> +		bpf_prog_array_free_sleepable(desc->bpf.inactive);
>  		desc->bpf.inactive = NULL;
>  	}
>  
> @@ -1740,7 +1796,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>  
>  #ifdef CONFIG_NET
>  static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
> -			     struct bpf_sockopt_buf *buf)
> +			     struct bpf_sockopt_buf *buf, bool force_alloc)
>  {
>  	if (unlikely(max_optlen < 0))
>  		return -EINVAL;
> @@ -1752,7 +1808,7 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
>  		max_optlen = PAGE_SIZE;
>  	}
>  
> -	if (max_optlen <= sizeof(buf->data)) {
> +	if (max_optlen <= sizeof(buf->data) && !force_alloc) {
>  		/* When the optval fits into BPF_SOCKOPT_KERN_BUF_SIZE
>  		 * bytes avoid the cost of kzalloc.
>  		 */
> @@ -1773,7 +1829,8 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
>  static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
>  			     struct bpf_sockopt_buf *buf)
>  {
> -	if (ctx->optval == buf->data)
> +	if (ctx->optval == buf->data ||
> +	    ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
>  		return;
>  	kfree(ctx->optval);
>  }
> @@ -1781,7 +1838,50 @@ static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
>  static bool sockopt_buf_allocated(struct bpf_sockopt_kern *ctx,
>  				  struct bpf_sockopt_buf *buf)
>  {
> -	return ctx->optval != buf->data;
> +	return ctx->optval != buf->data &&
> +		!(ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER);
> +}
> +
> +struct filter_sockopt_cb_args {
> +	struct bpf_sockopt_kern *ctx;
> +	struct bpf_sockopt_buf *buf;
> +	int max_optlen;
> +};
> +
> +static int filter_setsockopt_progs_cb(void *arg,
> +				      const struct bpf_prog_array_item *item)
> +{
> +	struct filter_sockopt_cb_args *cb_args = arg;
> +	struct bpf_sockopt_kern *ctx = cb_args->ctx;
> +	char *optval = ctx->optval;
> +	int sleepable_cnt, non_sleepable_cnt;
> +	int max_optlen;
> +
> +	count_sleepable_prog_cg(item, &sleepable_cnt, &non_sleepable_cnt);
> +
> +	if (!non_sleepable_cnt)
> +		return 0;
> +
> +	/* Allocate a bit more than the initial user buffer for
> +	 * BPF program. The canonical use case is overriding
> +	 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
> +	 */
> +	max_optlen = max_t(int, 16, ctx->optlen);
> +	/* We need to force allocating from heap if there are sleepable
> +	 * programs since they may created dynptrs from ctx->optval. In
> +	 * this case, dynptrs will try to free the buffer that is actually
> +	 * on the stack without this flag.
> +	 */
> +	max_optlen = sockopt_alloc_buf(ctx, max_optlen, cb_args->buf,
> +				       !!sleepable_cnt);
> +	if (max_optlen < 0)
> +		return max_optlen;
> +
> +	if (copy_from_user(ctx->optval, optval,
> +			   min(ctx->optlen, max_optlen)) != 0)
> +		return -EFAULT;
> +
> +	return 0;
>  }
>  
>  int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
> @@ -1795,27 +1895,22 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>  		.level = *level,
>  		.optname = *optname,
>  	};
> +	struct filter_sockopt_cb_args cb_args = {
> +		.ctx = &ctx,
> +		.buf = &buf,
> +	};
>  	int ret, max_optlen;
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
> +	max_optlen = *optlen;
>  	ctx.optlen = *optlen;
> -
> -	if (copy_from_user(ctx.optval, optval, min(*optlen, max_optlen)) != 0) {
> -		ret = -EFAULT;
> -		goto out;
> -	}
> +	ctx.optval = optval;
> +	ctx.optval_end = optval + *optlen;
> +	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
>  
>  	lock_sock(sk);
> -	ret = bpf_prog_run_array_cg(&cgrp->bpf, CGROUP_SETSOCKOPT,
> -				    &ctx, bpf_prog_run, 0, NULL);
> +	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_SETSOCKOPT,
> +				       &ctx, bpf_prog_run, 0, NULL,
> +				       filter_setsockopt_progs_cb, &cb_args);
>  	release_sock(sk);
>  
>  	if (ret)
> @@ -1824,7 +1919,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>  	if (ctx.optlen == -1) {
>  		/* optlen set to -1, bypass kernel */
>  		ret = 1;
> -	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
> +	} else if (ctx.optlen > (ctx.optval_end - ctx.optval) ||
> +		   ctx.optlen < -1) {
>  		/* optlen is out of bounds */
>  		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
>  			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
> @@ -1846,6 +1942,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>  		 */
>  		if (ctx.optlen != 0) {
>  			*optlen = ctx.optlen;
> +			if (ctx.flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
> +				return 0;
>  			/* We've used bpf_sockopt_kern->buf as an intermediary
>  			 * storage, but the BPF program indicates that we need
>  			 * to pass this data to the kernel setsockopt handler.
> @@ -1874,6 +1972,36 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>  	return ret;
>  }
>  
> +static int filter_getsockopt_progs_cb(void *arg,
> +				      const struct bpf_prog_array_item *item)
> +{
> +	struct filter_sockopt_cb_args *cb_args = arg;
> +	struct bpf_sockopt_kern *ctx = cb_args->ctx;
> +	int sleepable_cnt, non_sleepable_cnt;
> +	int max_optlen;
> +	char *optval;
> +
> +	count_sleepable_prog_cg(item, &sleepable_cnt, &non_sleepable_cnt);
> +
> +	if (!non_sleepable_cnt)
> +		return 0;
> +
> +	optval = ctx->optval;
> +	max_optlen = sockopt_alloc_buf(ctx, cb_args->max_optlen,
> +				       cb_args->buf, false);
> +	if (max_optlen < 0)
> +		return max_optlen;
> +
> +	if (copy_from_user(ctx->optval, optval,
> +			   min(ctx->optlen, max_optlen)) != 0)
> +		return -EFAULT;
> +
> +	ctx->flags = 0;
> +	cb_args->max_optlen = max_optlen;
> +
> +	return 0;
> +}
> +
>  int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>  				       int optname, char __user *optval,
>  				       int __user *optlen, int max_optlen,
> @@ -1887,15 +2015,16 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>  		.optname = optname,
>  		.current_task = current,
>  	};
> +	struct filter_sockopt_cb_args cb_args = {
> +		.ctx = &ctx,
> +		.buf = &buf,
> +		.max_optlen = max_optlen,
> +	};
>  	int orig_optlen;
>  	int ret;
>  
>  	orig_optlen = max_optlen;
>  	ctx.optlen = max_optlen;
> -	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
> -	if (max_optlen < 0)
> -		return max_optlen;
> -
>  	if (!retval) {
>  		/* If kernel getsockopt finished successfully,
>  		 * copy whatever was returned to the user back
> @@ -1914,18 +2043,19 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>  			goto out;
>  		}
>  		orig_optlen = ctx.optlen;
> -
> -		if (copy_from_user(ctx.optval, optval,
> -				   min(ctx.optlen, max_optlen)) != 0) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
>  	}
>  
> +	ctx.optval = optval;
> +	ctx.optval_end = optval + max_optlen;
> +	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
> +
>  	lock_sock(sk);
> -	ret = bpf_prog_run_array_cg(&cgrp->bpf, CGROUP_GETSOCKOPT,
> -				    &ctx, bpf_prog_run, retval, NULL);
> +	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_GETSOCKOPT,
> +				       &ctx, bpf_prog_run, retval, NULL,
> +				       filter_getsockopt_progs_cb,
> +				       &cb_args);
>  	release_sock(sk);
> +	max_optlen = cb_args.max_optlen;
>  
>  	if (ret < 0)
>  		goto out;
> @@ -1942,7 +2072,9 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>  	}
>  
>  	if (ctx.optlen != 0) {
> -		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
> +		if (optval &&
> +		    !(ctx.flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) &&
> +		    copy_to_user(optval, ctx.optval, ctx.optlen)) {
>  			ret = -EFAULT;
>  			goto out;
>  		}
> @@ -2388,6 +2520,10 @@ static bool cg_sockopt_is_valid_access(int off, int size,
>  		if (size != size_default)
>  			return false;
>  		return prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT;
> +	case offsetof(struct bpf_sockopt, flags):
> +		if (size != sizeof(__u32))
> +			return false;
> +		break;
>  	default:
>  		if (size != size_default)
>  			return false;
> @@ -2481,6 +2617,9 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
>  	case offsetof(struct bpf_sockopt, optval_end):
>  		*insn++ = CG_SOCKOPT_READ_FIELD(optval_end);
>  		break;
> +	case offsetof(struct bpf_sockopt, flags):
> +		*insn++ = CG_SOCKOPT_READ_FIELD(flags);
> +		break;
>  	}
>  
>  	return insn - insn_buf;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 132f25dab931..fbc0096693e7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19538,9 +19538,11 @@ static bool can_be_sleepable(struct bpf_prog *prog)
>  			return false;
>  		}
>  	}
> +

Extra newline?

>  	return prog->type == BPF_PROG_TYPE_LSM ||
>  	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
> -	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
> +	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
> +	       prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT;
>  }
>  
>  static int check_attach_btf_id(struct bpf_verifier_env *env)
> @@ -19562,7 +19564,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  	}
>  
>  	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
> +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe,"
> +			"cgroup, and struct_ops programs can be sleepable\n");

I don't think we split the lines even if they are too long.
Makes them ungreppable :-(

>  		return -EINVAL;
>  	}
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 70da85200695..fff6f7dff408 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7138,6 +7138,13 @@ struct bpf_sockopt {
>  	__s32	optname;
>  	__s32	optlen;
>  	__s32	retval;
> +
> +	__u32	flags;
> +};
> +
> +enum bpf_sockopt_flags {
> +	/* optval is a pointer to user space memory */
> +	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
>  };

Why do we need to export the flag? Do we still want the users
to do something based on the presence/absence of
BPF_SOCKOPT_FLAG_OPTVAL_USER?

