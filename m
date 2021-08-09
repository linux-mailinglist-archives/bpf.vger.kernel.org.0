Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE753E4FB1
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhHIXAp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 19:00:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:57736 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhHIXAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 19:00:44 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDEFq-0007BB-D9; Tue, 10 Aug 2021 01:00:22 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDEFq-0009jx-7J; Tue, 10 Aug 2021 01:00:22 +0200
Subject: Re: [PATCH v3 bpf-next 02/14] bpf: refactor BPF_PROG_RUN_ARRAY family
 of macros into functions
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>
References: <20210730053413.1090371-1-andrii@kernel.org>
 <20210730053413.1090371-3-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <578a340e-1880-bea9-62c2-a028ca2fa321@iogearbox.net>
Date:   Tue, 10 Aug 2021 01:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210730053413.1090371-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26258/Mon Aug  9 10:18:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/30/21 7:34 AM, Andrii Nakryiko wrote:
> Similar to BPF_PROG_RUN, turn BPF_PROG_RUN_ARRAY macros into proper functions
> with all the same readability and maintainability benefits. Making them into
> functions required shuffling around bpf_set_run_ctx/bpf_reset_run_ctx
> functions. Also, explicitly specifying the type of the BPF prog run callback
> required adjusting __bpf_prog_run_save_cb() to accept const void *, casted
> internally to const struct sk_buff.
> 
> Further, split out a cgroup-specific BPF_PROG_RUN_ARRAY_CG and
> BPF_PROG_RUN_ARRAY_CG_FLAGS from the more generic BPF_PROG_RUN_ARRAY due to
> the differences in bpf_run_ctx used for those two different use cases.
> 
> I think BPF_PROG_RUN_ARRAY_CG would benefit from further refactoring to accept
> struct cgroup and enum bpf_attach_type instead of bpf_prog_array, fetching
> cgrp->bpf.effective[type] and RCU-dereferencing it internally. But that
> required including include/linux/cgroup-defs.h, which I wasn't sure is ok with
> everyone.
> 
> The remaining generic BPF_PROG_RUN_ARRAY function will be extended to
> pass-through user-provided context value in the next patch.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   include/linux/bpf.h      | 187 +++++++++++++++++++++++----------------
>   include/linux/filter.h   |   5 +-
>   kernel/bpf/cgroup.c      |  32 +++----
>   kernel/trace/bpf_trace.c |   2 +-
>   4 files changed, 132 insertions(+), 94 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c8cc09013210..9c44b56b698f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1146,67 +1146,124 @@ struct bpf_run_ctx {};
>   
>   struct bpf_cg_run_ctx {
>   	struct bpf_run_ctx run_ctx;
> -	struct bpf_prog_array_item *prog_item;
> +	const struct bpf_prog_array_item *prog_item;
>   };
>   
> +#ifdef CONFIG_BPF_SYSCALL
> +static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
> +{
> +	struct bpf_run_ctx *old_ctx;
> +
> +	old_ctx = current->bpf_ctx;
> +	current->bpf_ctx = new_ctx;
> +	return old_ctx;
> +}
> +
> +static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
> +{
> +	current->bpf_ctx = old_ctx;
> +}
> +#else /* CONFIG_BPF_SYSCALL */
> +static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
> +{
> +	return NULL;
> +}
> +
> +static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
> +{
> +}
> +#endif /* CONFIG_BPF_SYSCALL */

nit, but either is fine..:

static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
{
	struct bpf_run_ctx *old_ctx = NULL;

#ifdef CONFIG_BPF_SYSCALL
	old_ctx = current->bpf_ctx;
	current->bpf_ctx = new_ctx;
#endif
	return old_ctx;
}

static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
{
#ifdef CONFIG_BPF_SYSCALL
	current->bpf_ctx = old_ctx;
#endif
}

>   /* BPF program asks to bypass CAP_NET_BIND_SERVICE in bind. */
>   #define BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE			(1 << 0)
>   /* BPF program asks to set CN on the packet. */
>   #define BPF_RET_SET_CN						(1 << 0)
>   
> -#define BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, ret_flags)		\
> -	({								\
> -		struct bpf_prog_array_item *_item;			\
> -		struct bpf_prog *_prog;					\
> -		struct bpf_prog_array *_array;				\
> -		struct bpf_run_ctx *old_run_ctx;			\
> -		struct bpf_cg_run_ctx run_ctx;				\
> -		u32 _ret = 1;						\
> -		u32 func_ret;						\
> -		migrate_disable();					\
> -		rcu_read_lock();					\
> -		_array = rcu_dereference(array);			\
> -		_item = &_array->items[0];				\
> -		old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);	\
> -		while ((_prog = READ_ONCE(_item->prog))) {		\
> -			run_ctx.prog_item = _item;			\
> -			func_ret = func(_prog, ctx);			\
> -			_ret &= (func_ret & 1);				\
> -			*(ret_flags) |= (func_ret >> 1);		\
> -			_item++;					\
> -		}							\
> -		bpf_reset_run_ctx(old_run_ctx);				\
> -		rcu_read_unlock();					\
> -		migrate_enable();					\
> -		_ret;							\
> -	 })
> -
> -#define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null, set_cg_storage)	\
> -	({						\
> -		struct bpf_prog_array_item *_item;	\
> -		struct bpf_prog *_prog;			\
> -		struct bpf_prog_array *_array;		\
> -		struct bpf_run_ctx *old_run_ctx;	\
> -		struct bpf_cg_run_ctx run_ctx;		\
> -		u32 _ret = 1;				\
> -		migrate_disable();			\
> -		rcu_read_lock();			\
> -		_array = rcu_dereference(array);	\
> -		if (unlikely(check_non_null && !_array))\
> -			goto _out;			\
> -		_item = &_array->items[0];		\
> -		old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);\
> -		while ((_prog = READ_ONCE(_item->prog))) {	\
> -			run_ctx.prog_item = _item;	\
> -			_ret &= func(_prog, ctx);	\
> -			_item++;			\
> -		}					\
> -		bpf_reset_run_ctx(old_run_ctx);		\
> -_out:							\
> -		rcu_read_unlock();			\
> -		migrate_enable();			\
> -		_ret;					\
> -	 })
> +typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
> +
> +static __always_inline u32
> +BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
> +			    const void *ctx, bpf_prog_run_fn run_prog,
> +			    u32 *ret_flags)
> +{
> +	const struct bpf_prog_array_item *item;
> +	const struct bpf_prog *prog;
> +	const struct bpf_prog_array *array;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_cg_run_ctx run_ctx;
> +	u32 ret = 1;
> +	u32 func_ret;
> +
> +	migrate_disable();
> +	rcu_read_lock();
> +	array = rcu_dereference(array_rcu);
> +	item = &array->items[0];
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	while ((prog = READ_ONCE(item->prog))) {
> +		run_ctx.prog_item = item;
> +		func_ret = run_prog(prog, ctx);
> +		ret &= (func_ret & 1);
> +		*(ret_flags) |= (func_ret >> 1);
> +		item++;
> +	}
> +	bpf_reset_run_ctx(old_run_ctx);
> +	rcu_read_unlock();
> +	migrate_enable();
> +	return ret;
> +}
> +
> +static __always_inline u32
> +BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
> +		      const void *ctx, bpf_prog_run_fn run_prog)
> +{
> +	const struct bpf_prog_array_item *item;
> +	const struct bpf_prog *prog;
> +	const struct bpf_prog_array *array;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_cg_run_ctx run_ctx;
> +	u32 ret = 1;
> +
> +	migrate_disable();
> +	rcu_read_lock();
> +	array = rcu_dereference(array_rcu);
> +	item = &array->items[0];
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	while ((prog = READ_ONCE(item->prog))) {
> +		run_ctx.prog_item = item;
> +		ret &= run_prog(prog, ctx);
> +		item++;
> +	}
> +	bpf_reset_run_ctx(old_run_ctx);
> +	rcu_read_unlock();
> +	migrate_enable();
> +	return ret;
> +}
> +
> +static __always_inline u32
> +BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
> +		   const void *ctx, bpf_prog_run_fn run_prog)
> +{
> +	const struct bpf_prog_array_item *item;
> +	const struct bpf_prog *prog;
> +	const struct bpf_prog_array *array;
> +	u32 ret = 1;
> +
> +	migrate_disable();
> +	rcu_read_lock();
> +	array = rcu_dereference(array_rcu);
> +	if (unlikely(!array))
> +		goto out;
> +	item = &array->items[0];
> +	while ((prog = READ_ONCE(item->prog))) {
> +		ret &= run_prog(prog, ctx);
> +		item++;
> +	}
> +out:
> +	rcu_read_unlock();
> +	migrate_enable();
> +	return ret;
> +}

Is there any way we could consolidate the above somewhat further and have things
optimized out at compilation time, e.g. when const args are null/non-null? :/

>   /* To be used by __cgroup_bpf_run_filter_skb for EGRESS BPF progs
>    * so BPF programs can request cwr for TCP packets.
> @@ -1235,7 +1292,7 @@ _out:							\
>   		u32 _flags = 0;				\
[...]
