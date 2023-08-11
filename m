Return-Path: <bpf+bounces-7620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06404779B4B
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 01:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EC61C20B22
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1046E3D3A2;
	Fri, 11 Aug 2023 23:22:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEF329D4
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 23:22:33 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A94E73
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:22:09 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-586a3159588so35846067b3.0
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691796125; x=1692400925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GL/cL7PfMq9HhHTr9HiqB5q20RVJwth7m8ZG4Dx9ws=;
        b=HSD1G9FsbxYjmC0AD/vHWl3Eh1j/xuvelgyB0Ns8EGw5gFjyY576h0UXIoun6Is/Hl
         RzGsudsIu1RnZMZj+N8PGDyaAAMurrpyWfyetwPJb5XJiWmlvbCcbZt7NQUBqf8z9AyL
         9H34ka6UD5vH5OPNBZmcWcg1gX8vnVVbkM8c72o8SDF7qzRxX6HrI266S/AZonHZnIsq
         n2eMBqwa9OVoYhQpbfJ33FotarTJ52UcxLjxXz2MUZO9w3/9sMtqdvFkLaD1fbr54+WO
         mihdUUrwYI4NtrMhDmCv99x5OhJAZBRPoAhnaM1YXTtAZwqksHBb1lxNAV3kEcqizyP6
         o23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796125; x=1692400925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GL/cL7PfMq9HhHTr9HiqB5q20RVJwth7m8ZG4Dx9ws=;
        b=b5/1amobmDnqLvDJZl/NNU97rlz0ddePGxKa0g99hC1Jl+sk5/1AmDaAeyidiBjFei
         IdtWMRnh5izeas4mk+92mlFhocvfGA0qsBUQzYod3wxiLE4KpZ+8kMWIMX0u99i285RZ
         1GVRf0ZM1YUXviX5ALewnOkTFIUhMC1d6P+UjlGKlDtValOBLYEwLzCm/jtg7WW+8moO
         PqX4eyJoikWcdOoYB+dOIMaNhBXWgSBf8j70s7W3cORqPvFkflgKn/Ps4t22f2FS1C7F
         mt9Ux6mkFroEuURP/JlGQMiR1+mV7kBYviPidiCm1HuKPkXcvF/Yyow747V6gc3NJav7
         3EsQ==
X-Gm-Message-State: AOJu0YxyZKcAOS42VPB95CgM9H3whvU9E+rUY6/tZaU5SqdD6U6R+LkE
	LjuibCrmjrUluBDP993oKM4=
X-Google-Smtp-Source: AGHT+IF1/VbSrFwPGOiqQLDEaaE2JN/nXhxTOu6qKAx0ct+3XEZVMGrw3bE3IE1MfuxmkEp+lg0HgA==
X-Received: by 2002:a0d:cc53:0:b0:57a:3942:bb74 with SMTP id o80-20020a0dcc53000000b0057a3942bb74mr3791327ywd.17.1691796125489;
        Fri, 11 Aug 2023 16:22:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:680f:f8a3:c49b:84db? ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id p11-20020a0de60b000000b0057060bb2874sm1289029ywe.37.2023.08.11.16.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:22:05 -0700 (PDT)
Message-ID: <1f63f380-2bfb-62cb-e1c9-9c784690af85@gmail.com>
Date: Fri, 11 Aug 2023 16:22:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v2 1/6] bpf: enable sleepable BPF programs attached
 to cgroup/{get,set}sockopt.
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 yonghong.song@linux.dev, kuifeng@meta.com
References: <20230811043127.1318152-1-thinker.li@gmail.com>
 <20230811043127.1318152-2-thinker.li@gmail.com> <ZNa9uWK7KUVIj4Te@google.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZNa9uWK7KUVIj4Te@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 16:01, Stanislav Fomichev wrote:
> On 08/10, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <kuifeng@meta.com>
>>
>> Enable sleepable cgroup/{get,set}sockopt hooks.
>>
>> The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks may
>> received a pointer to the optval in user space instead of a kernel
>> copy. ctx->user_optval and ctx->user_optval_end are the pointers to the
>> begin and end of the user space buffer if receiving a user space
>> buffer. ctx->optval and ctx->optval_end will be a kernel copy if receiving
>> a kernel space buffer.
>>
>> A program receives a user space buffer if ctx->flags &
>> BPF_SOCKOPT_FLAG_OPTVAL_USER is true, otherwise it receives a kernel space
>> buffer.  The BPF programs should not read/write from/to a user space buffer
>> dirrectly.  It should access the buffer through bpf_copy_from_user() and
>> bpf_copy_to_user() provided in the following patches.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/filter.h         |   1 +
>>   include/uapi/linux/bpf.h       |   7 +
>>   kernel/bpf/cgroup.c            | 229 ++++++++++++++++++++++++++-------
>>   kernel/bpf/verifier.c          |   7 +-
>>   tools/include/uapi/linux/bpf.h |   7 +
>>   tools/lib/bpf/libbpf.c         |   2 +
>>   6 files changed, 206 insertions(+), 47 deletions(-)
>>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 761af6b3cf2b..54169a641d40 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1337,6 +1337,7 @@ struct bpf_sockopt_kern {
>>   	s32		level;
>>   	s32		optname;
>>   	s32		optlen;
>> +	u32		flags;
>>   	/* for retval in struct bpf_cg_run_ctx */
>>   	struct task_struct *current_task;
>>   	/* Temporary "register" for indirect stores to ppos. */
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 70da85200695..fff6f7dff408 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7138,6 +7138,13 @@ struct bpf_sockopt {
>>   	__s32	optname;
>>   	__s32	optlen;
>>   	__s32	retval;
>> +
>> +	__u32	flags;
>> +};
>> +
>> +enum bpf_sockopt_flags {
>> +	/* optval is a pointer to user space memory */
>> +	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
>>   };
>>   
>>   struct bpf_pidns_info {
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 5b2741aa0d9b..59489d9619a3 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -28,25 +28,46 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>>    * function pointer.
>>    */
>>   static __always_inline int
>> -bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>> -		      enum cgroup_bpf_attach_type atype,
>> -		      const void *ctx, bpf_prog_run_fn run_prog,
>> -		      int retval, u32 *ret_flags)
>> +bpf_prog_run_array_cg_cb(const struct cgroup_bpf *cgrp,
>> +			 enum cgroup_bpf_attach_type atype,
>> +			 const void *ctx, bpf_prog_run_fn run_prog,
>> +			 int retval, u32 *ret_flags,
>> +			 int (*progs_cb)(void *, const struct bpf_prog_array_item *),
>> +			 void *progs_cb_arg)
>>   {
>>   	const struct bpf_prog_array_item *item;
>>   	const struct bpf_prog *prog;
>>   	const struct bpf_prog_array *array;
>>   	struct bpf_run_ctx *old_run_ctx;
>>   	struct bpf_cg_run_ctx run_ctx;
>> +	bool do_sleepable;
>>   	u32 func_ret;
>> +	int err;
>> +
>> +	do_sleepable =
>> +		atype == CGROUP_SETSOCKOPT || atype == CGROUP_GETSOCKOPT;
>>   
>>   	run_ctx.retval = retval;
>>   	migrate_disable();
>> -	rcu_read_lock();
>> +	if (do_sleepable) {
>> +		might_fault();
>> +		rcu_read_lock_trace();
>> +	} else
>> +		rcu_read_lock();
>>   	array = rcu_dereference(cgrp->effective[atype]);
>>   	item = &array->items[0];
>> +
>> +	if (progs_cb) {
>> +		err = progs_cb(progs_cb_arg, item);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>   	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>   	while ((prog = READ_ONCE(item->prog))) {
>> +		if (do_sleepable && !prog->aux->sleepable)
>> +			rcu_read_lock();
>> +
>>   		run_ctx.prog_item = item;
>>   		func_ret = run_prog(prog, ctx);
>>   		if (ret_flags) {
>> @@ -56,13 +77,48 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>>   		if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
>>   			run_ctx.retval = -EPERM;
>>   		item++;
>> +
>> +		if (do_sleepable && !prog->aux->sleepable)
>> +			rcu_read_unlock();
>>   	}
>>   	bpf_reset_run_ctx(old_run_ctx);
>> -	rcu_read_unlock();
>> +	if (do_sleepable)
>> +		rcu_read_unlock_trace();
>> +	else
>> +		rcu_read_unlock();
>>   	migrate_enable();
>>   	return run_ctx.retval;
>>   }
>>   
>> +static __always_inline void
>> +count_sleepable_prog_cg(const struct bpf_prog_array_item *item,
>> +			int *sleepable, int *non_sleepable)
>> +{
>> +	const struct bpf_prog *prog;
>> +	bool ret = true;
>> +
>> +	*sleepable = 0;
>> +	*non_sleepable = 0;
>> +
>> +	while (ret && (prog = READ_ONCE(item->prog))) {
>> +		if (prog->aux->sleepable)
>> +			(*sleepable)++;
>> +		else
>> +			(*non_sleepable)++;
>> +		item++;
>> +	}
>> +}
> 
> Can we maintain this info in the slow attach/detach path?
> Running the loop every time we get a sockopt syscall another time
> seems like something we can avoid? (even though it's a slow path,
> seems like we can do better?)
> 
>> +
>> +static __always_inline int
>> +bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>> +		      enum cgroup_bpf_attach_type atype,
>> +		      const void *ctx, bpf_prog_run_fn run_prog,
>> +		      int retval, u32 *ret_flags)
>> +{
>> +	return bpf_prog_run_array_cg_cb(cgrp, atype, ctx, run_prog, retval,
>> +					ret_flags, NULL, NULL);
>> +}
>> +
>>   unsigned int __cgroup_bpf_run_lsm_sock(const void *ctx,
>>   				       const struct bpf_insn *insn)
>>   {
>> @@ -307,7 +363,7 @@ static void cgroup_bpf_release(struct work_struct *work)
>>   		old_array = rcu_dereference_protected(
>>   				cgrp->bpf.effective[atype],
>>   				lockdep_is_held(&cgroup_mutex));
>> -		bpf_prog_array_free(old_array);
>> +		bpf_prog_array_free_sleepable(old_array);
>>   	}
>>   
>>   	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
>> @@ -451,7 +507,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
>>   	/* free prog array after grace period, since __cgroup_bpf_run_*()
>>   	 * might be still walking the array
>>   	 */
>> -	bpf_prog_array_free(old_array);
>> +	bpf_prog_array_free_sleepable(old_array);
>>   }
>>   
>>   /**
>> @@ -491,7 +547,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
>>   	return 0;
>>   cleanup:
>>   	for (i = 0; i < NR; i++)
>> -		bpf_prog_array_free(arrays[i]);
>> +		bpf_prog_array_free_sleepable(arrays[i]);
>>   
>>   	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
>>   		cgroup_bpf_put(p);
>> @@ -525,7 +581,7 @@ static int update_effective_progs(struct cgroup *cgrp,
>>   
>>   		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
>>   			if (unlikely(desc->bpf.inactive)) {
>> -				bpf_prog_array_free(desc->bpf.inactive);
>> +				bpf_prog_array_free_sleepable(desc->bpf.inactive);
>>   				desc->bpf.inactive = NULL;
>>   			}
>>   			continue;
>> @@ -544,7 +600,7 @@ static int update_effective_progs(struct cgroup *cgrp,
>>   	css_for_each_descendant_pre(css, &cgrp->self) {
>>   		struct cgroup *desc = container_of(css, struct cgroup, self);
>>   
>> -		bpf_prog_array_free(desc->bpf.inactive);
>> +		bpf_prog_array_free_sleepable(desc->bpf.inactive);
>>   		desc->bpf.inactive = NULL;
>>   	}
>>   
>> @@ -1740,7 +1796,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>>   
>>   #ifdef CONFIG_NET
>>   static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
>> -			     struct bpf_sockopt_buf *buf)
>> +			     struct bpf_sockopt_buf *buf, bool force_alloc)
>>   {
>>   	if (unlikely(max_optlen < 0))
>>   		return -EINVAL;
>> @@ -1752,7 +1808,7 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
>>   		max_optlen = PAGE_SIZE;
>>   	}
>>   
>> -	if (max_optlen <= sizeof(buf->data)) {
>> +	if (max_optlen <= sizeof(buf->data) && !force_alloc) {
>>   		/* When the optval fits into BPF_SOCKOPT_KERN_BUF_SIZE
>>   		 * bytes avoid the cost of kzalloc.
>>   		 */
>> @@ -1773,7 +1829,8 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
>>   static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
>>   			     struct bpf_sockopt_buf *buf)
>>   {
>> -	if (ctx->optval == buf->data)
>> +	if (ctx->optval == buf->data ||
>> +	    ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
>>   		return;
>>   	kfree(ctx->optval);
>>   }
>> @@ -1781,7 +1838,50 @@ static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
>>   static bool sockopt_buf_allocated(struct bpf_sockopt_kern *ctx,
>>   				  struct bpf_sockopt_buf *buf)
>>   {
>> -	return ctx->optval != buf->data;
>> +	return ctx->optval != buf->data &&
>> +		!(ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER);
>> +}
>> +
>> +struct filter_sockopt_cb_args {
>> +	struct bpf_sockopt_kern *ctx;
>> +	struct bpf_sockopt_buf *buf;
>> +	int max_optlen;
>> +};
>> +
>> +static int filter_setsockopt_progs_cb(void *arg,
>> +				      const struct bpf_prog_array_item *item)
>> +{
>> +	struct filter_sockopt_cb_args *cb_args = arg;
>> +	struct bpf_sockopt_kern *ctx = cb_args->ctx;
>> +	char *optval = ctx->optval;
>> +	int sleepable_cnt, non_sleepable_cnt;
>> +	int max_optlen;
>> +
>> +	count_sleepable_prog_cg(item, &sleepable_cnt, &non_sleepable_cnt);
>> +
>> +	if (!non_sleepable_cnt)
>> +		return 0;
>> +
>> +	/* Allocate a bit more than the initial user buffer for
>> +	 * BPF program. The canonical use case is overriding
>> +	 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
>> +	 */
>> +	max_optlen = max_t(int, 16, ctx->optlen);
>> +	/* We need to force allocating from heap if there are sleepable
>> +	 * programs since they may created dynptrs from ctx->optval. In
>> +	 * this case, dynptrs will try to free the buffer that is actually
>> +	 * on the stack without this flag.
>> +	 */
>> +	max_optlen = sockopt_alloc_buf(ctx, max_optlen, cb_args->buf,
>> +				       !!sleepable_cnt);
>> +	if (max_optlen < 0)
>> +		return max_optlen;
>> +
>> +	if (copy_from_user(ctx->optval, optval,
>> +			   min(ctx->optlen, max_optlen)) != 0)
>> +		return -EFAULT;
>> +
>> +	return 0;
>>   }
>>   
>>   int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>> @@ -1795,27 +1895,22 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>>   		.level = *level,
>>   		.optname = *optname,
>>   	};
>> +	struct filter_sockopt_cb_args cb_args = {
>> +		.ctx = &ctx,
>> +		.buf = &buf,
>> +	};
>>   	int ret, max_optlen;
>>   
>> -	/* Allocate a bit more than the initial user buffer for
>> -	 * BPF program. The canonical use case is overriding
>> -	 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
>> -	 */
>> -	max_optlen = max_t(int, 16, *optlen);
>> -	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
>> -	if (max_optlen < 0)
>> -		return max_optlen;
>> -
>> +	max_optlen = *optlen;
>>   	ctx.optlen = *optlen;
>> -
>> -	if (copy_from_user(ctx.optval, optval, min(*optlen, max_optlen)) != 0) {
>> -		ret = -EFAULT;
>> -		goto out;
>> -	}
>> +	ctx.optval = optval;
>> +	ctx.optval_end = optval + *optlen;
>> +	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
>>   
>>   	lock_sock(sk);
>> -	ret = bpf_prog_run_array_cg(&cgrp->bpf, CGROUP_SETSOCKOPT,
>> -				    &ctx, bpf_prog_run, 0, NULL);
>> +	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_SETSOCKOPT,
>> +				       &ctx, bpf_prog_run, 0, NULL,
>> +				       filter_setsockopt_progs_cb, &cb_args);
>>   	release_sock(sk);
>>   
>>   	if (ret)
>> @@ -1824,7 +1919,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>>   	if (ctx.optlen == -1) {
>>   		/* optlen set to -1, bypass kernel */
>>   		ret = 1;
>> -	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
>> +	} else if (ctx.optlen > (ctx.optval_end - ctx.optval) ||
>> +		   ctx.optlen < -1) {
>>   		/* optlen is out of bounds */
>>   		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
>>   			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
>> @@ -1846,6 +1942,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>>   		 */
>>   		if (ctx.optlen != 0) {
>>   			*optlen = ctx.optlen;
>> +			if (ctx.flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
>> +				return 0;
>>   			/* We've used bpf_sockopt_kern->buf as an intermediary
>>   			 * storage, but the BPF program indicates that we need
>>   			 * to pass this data to the kernel setsockopt handler.
>> @@ -1874,6 +1972,36 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>>   	return ret;
>>   }
>>   
>> +static int filter_getsockopt_progs_cb(void *arg,
>> +				      const struct bpf_prog_array_item *item)
>> +{
>> +	struct filter_sockopt_cb_args *cb_args = arg;
>> +	struct bpf_sockopt_kern *ctx = cb_args->ctx;
>> +	int sleepable_cnt, non_sleepable_cnt;
>> +	int max_optlen;
>> +	char *optval;
>> +
>> +	count_sleepable_prog_cg(item, &sleepable_cnt, &non_sleepable_cnt);
>> +
>> +	if (!non_sleepable_cnt)
>> +		return 0;
>> +
>> +	optval = ctx->optval;
>> +	max_optlen = sockopt_alloc_buf(ctx, cb_args->max_optlen,
>> +				       cb_args->buf, false);
>> +	if (max_optlen < 0)
>> +		return max_optlen;
>> +
>> +	if (copy_from_user(ctx->optval, optval,
>> +			   min(ctx->optlen, max_optlen)) != 0)
>> +		return -EFAULT;
>> +
>> +	ctx->flags = 0;
>> +	cb_args->max_optlen = max_optlen;
>> +
>> +	return 0;
>> +}
>> +
>>   int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>   				       int optname, char __user *optval,
>>   				       int __user *optlen, int max_optlen,
>> @@ -1887,15 +2015,16 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>   		.optname = optname,
>>   		.current_task = current,
>>   	};
>> +	struct filter_sockopt_cb_args cb_args = {
>> +		.ctx = &ctx,
>> +		.buf = &buf,
>> +		.max_optlen = max_optlen,
>> +	};
>>   	int orig_optlen;
>>   	int ret;
>>   
>>   	orig_optlen = max_optlen;
>>   	ctx.optlen = max_optlen;
>> -	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
>> -	if (max_optlen < 0)
>> -		return max_optlen;
>> -
>>   	if (!retval) {
>>   		/* If kernel getsockopt finished successfully,
>>   		 * copy whatever was returned to the user back
>> @@ -1914,18 +2043,19 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>   			goto out;
>>   		}
>>   		orig_optlen = ctx.optlen;
>> -
>> -		if (copy_from_user(ctx.optval, optval,
>> -				   min(ctx.optlen, max_optlen)) != 0) {
>> -			ret = -EFAULT;
>> -			goto out;
>> -		}
>>   	}
>>   
>> +	ctx.optval = optval;
>> +	ctx.optval_end = optval + max_optlen;
>> +	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
>> +
>>   	lock_sock(sk);
>> -	ret = bpf_prog_run_array_cg(&cgrp->bpf, CGROUP_GETSOCKOPT,
>> -				    &ctx, bpf_prog_run, retval, NULL);
>> +	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_GETSOCKOPT,
>> +				       &ctx, bpf_prog_run, retval, NULL,
>> +				       filter_getsockopt_progs_cb,
>> +				       &cb_args);
>>   	release_sock(sk);
>> +	max_optlen = cb_args.max_optlen;
>>   
>>   	if (ret < 0)
>>   		goto out;
>> @@ -1942,7 +2072,9 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>   	}
>>   
>>   	if (ctx.optlen != 0) {
>> -		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
>> +		if (optval &&
>> +		    !(ctx.flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) &&
>> +		    copy_to_user(optval, ctx.optval, ctx.optlen)) {
>>   			ret = -EFAULT;
>>   			goto out;
>>   		}
>> @@ -2388,6 +2520,10 @@ static bool cg_sockopt_is_valid_access(int off, int size,
>>   		if (size != size_default)
>>   			return false;
>>   		return prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT;
>> +	case offsetof(struct bpf_sockopt, flags):
>> +		if (size != sizeof(__u32))
>> +			return false;
>> +		break;
>>   	default:
>>   		if (size != size_default)
>>   			return false;
>> @@ -2481,6 +2617,9 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
>>   	case offsetof(struct bpf_sockopt, optval_end):
>>   		*insn++ = CG_SOCKOPT_READ_FIELD(optval_end);
>>   		break;
>> +	case offsetof(struct bpf_sockopt, flags):
>> +		*insn++ = CG_SOCKOPT_READ_FIELD(flags);
>> +		break;
>>   	}
>>   
>>   	return insn - insn_buf;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 132f25dab931..fbc0096693e7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19538,9 +19538,11 @@ static bool can_be_sleepable(struct bpf_prog *prog)
>>   			return false;
>>   		}
>>   	}
>> +
> 
> Extra newline?
> 
>>   	return prog->type == BPF_PROG_TYPE_LSM ||
>>   	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
>> -	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
>> +	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
>> +	       prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT;
>>   }
>>   
>>   static int check_attach_btf_id(struct bpf_verifier_env *env)
>> @@ -19562,7 +19564,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>>   	}
>>   
>>   	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
>> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
>> +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe,"
>> +			"cgroup, and struct_ops programs can be sleepable\n");
> 
> I don't think we split the lines even if they are too long.
> Makes them ungreppable :-(

Got it!

> 
>>   		return -EINVAL;
>>   	}
>>   
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 70da85200695..fff6f7dff408 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -7138,6 +7138,13 @@ struct bpf_sockopt {
>>   	__s32	optname;
>>   	__s32	optlen;
>>   	__s32	retval;
>> +
>> +	__u32	flags;
>> +};
>> +
>> +enum bpf_sockopt_flags {
>> +	/* optval is a pointer to user space memory */
>> +	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
>>   };
> 
> Why do we need to export the flag? Do we still want the users
> to do something based on the presence/absence of
> BPF_SOCKOPT_FLAG_OPTVAL_USER?

I will remove this flag from the view of BPF programs.

