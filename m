Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6C629FA4
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiKOQxv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiKOQxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:53:50 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E010FC7
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:53:49 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so17450626pjc.3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KatermWEaYj98rMOWiY5llAoihhz+HBAjkiuHkKL8hQ=;
        b=lp2t5WJD2Q+imAI5phVvCMH2RB+qkBfaLXcyiSVPOt88NZJKRe+8jhTYIeC4Z5GI/D
         oel9dUou6/GKVhlUja2Q25xo4SlMgNr2scV7hrKVHlz/Voswi4n7DMX6L3Cqrnmm4h0C
         cLalpAdih292rW/3q4LcltM4/Gd9hhHGxjIQGN+qYPeBsGlQPq9rtwM8CLEygcGyyOq4
         /4FSw3iQK4aS4Ax+WX8ZHpaPvXVrCBew1MK6Bkg7OiPGmSUIFSqxzX57ZmAb23KzeCoE
         T6iCohjxcEpbBre+PJF6Dc9bKKdUwkuboUZbdj6p7OFgBpVNFlx2XiEsssEydFbaFucz
         LJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KatermWEaYj98rMOWiY5llAoihhz+HBAjkiuHkKL8hQ=;
        b=UCFYjUNHP5EDVP844owcnh+xyzCJCldqjb5ApTPrjSidyT2R0IIm94XuRfFWrhKRgt
         dGQHz2Me8XvE+gDTCl3hby5hT2P0hf5wlkxRmFv27W7mCHE2AEP1aCzEwXZ4U3y3AXUA
         xTWWs4/xFNwfMnZeShz4xaMmwEwqqhPH5SpMEe3ErVb6ZOMtCQ0jPqYtVOacL40aiwv3
         1Uxy0SYBjpimfdcvQguaaxS8dRLMJDXOWmCOTLfex2m6SbmttRAb+5EHIt7FjAAT6A7k
         zR/3h6jKg63J6Xui9PfXFUcbLtCOnpe7fubdTwFiUCGa7j8eqcAf+30UaGIjVyJlYyvR
         W+qQ==
X-Gm-Message-State: ANoB5pnfLsx2OSauo3Q8g14+ray6Qu46+YtH43JeLnIIYKu8l1vtBjej
        VmHZQ3wuePiN4fh5G2muqxs=
X-Google-Smtp-Source: AA0mqf4zUM0t6AnnwhUFg3beVUiXjkkZtw5t64vTUN6WPZgqeQFxjJ2GWL2uFSZjOnMc1cxbvsOqxA==
X-Received: by 2002:a17:902:d54d:b0:186:886f:e1e0 with SMTP id z13-20020a170902d54d00b00186886fe1e0mr4836304plf.162.1668531228479;
        Tue, 15 Nov 2022 08:53:48 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id kx4-20020a17090b228400b002008d0e5cb5sm11789970pjb.47.2022.11.15.08.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:53:48 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:23:41 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 17/26] bpf: Introduce bpf_obj_new
Message-ID: <20221115165341.7y4hmnkfexjbo6oe@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-18-memxor@gmail.com>
 <20221115061912.pcgjnx427dn6aaq2@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115061912.pcgjnx427dn6aaq2@macbook-pro-5.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 11:49:12AM IST, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 12:45:38AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Introduce type safe memory allocator bpf_obj_new for BPF programs. The
> > kernel side kfunc is named bpf_obj_new_impl, as passing hidden arguments
> > to kfuncs still requires having them in prototype, unlike BPF helpers
> > which always take 5 arguments and have them checked using bpf_func_proto
> > in verifier, ignoring unset argument types.
> >
> > Introduce __ign suffix to ignore a specific kfunc argument during type
> > checks, then use this to introduce support for passing type metadata to
> > the bpf_obj_new_impl kfunc.
> >
> > The user passes BTF ID of the type it wants to allocates in program BTF,
> > the verifier then rewrites the first argument as the size of this type,
> > after performing some sanity checks (to ensure it exists and it is a
> > struct type).
> >
> > The second argument is also fixed up and passed by the verifier. This is
> > the btf_struct_meta for the type being allocated. It would be needed
> > mostly for the offset array which is required for zero initializing
> > special fields while leaving the rest of storage in unitialized state.
> >
> > It would also be needed in the next patch to perform proper destruction
> > of the object's special fields.
> >
> > Under the hood, bpf_obj_new will call bpf_mem_alloc and bpf_mem_free,
> > using the any context BPF memory allocator introduced recently. To this
> > end, a global instance of the BPF memory allocator is initialized on
> > boot to be used for this purpose. This 'bpf_global_ma' serves all
> > allocations for bpf_obj_new. In the future, bpf_obj_new variants will
> > allow specifying a custom allocator.
> >
> > Note that now that bpf_obj_new can be used to allocate objects that can
> > be linked to BPF linked list (when future linked list helpers are
> > available), we need to also free the elements using bpf_mem_free.
> > However, since the draining of elements is done outside the
> > bpf_spin_lock, we need to do migrate_disable around the call since
> > bpf_list_head_free can be called from map free path where migration is
> > enabled. Otherwise, when called from BPF programs migration is already
> > disabled.
> >
> > A convenience macro is included in the bpf_experimental.h header to hide
> > over the ugly details of the implementation, leading to user code
> > looking similar to a language level extension which allocates and
> > constructs fields of a user type.
> >
> > struct bar {
> > 	struct bpf_list_node node;
> > };
> >
> > struct foo {
> > 	struct bpf_spin_lock lock;
> > 	struct bpf_list_head head __contains(bar, node);
> > };
> >
> > void prog(void) {
> > 	struct foo *f;
> >
> > 	f = bpf_obj_new(typeof(*f));
> > 	if (!f)
> > 		return;
> > 	...
> > }
> >
> > A key piece of this story is still missing, i.e. the free function,
> > which will come in the next patch.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h                           |  21 ++--
> >  include/linux/bpf_verifier.h                  |   2 +
> >  kernel/bpf/core.c                             |  16 +++
> >  kernel/bpf/helpers.c                          |  47 ++++++--
> >  kernel/bpf/verifier.c                         | 107 ++++++++++++++++--
> >  .../testing/selftests/bpf/bpf_experimental.h  |  25 ++++
> >  6 files changed, 195 insertions(+), 23 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 62a16b699e71..4635e31bd6fc 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -54,6 +54,8 @@ struct cgroup;
> >  extern struct idr btf_idr;
> >  extern spinlock_t btf_idr_lock;
> >  extern struct kobject *btf_kobj;
> > +extern struct bpf_mem_alloc bpf_global_ma;
> > +extern bool bpf_global_ma_set;
> >
> >  typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
> >  typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
> > @@ -333,16 +335,19 @@ static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_f
> >  	return rec->field_mask & type;
> >  }
> >
> > -static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> > +static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
> >  {
> > -	if (!IS_ERR_OR_NULL(map->record)) {
> > -		struct btf_field *fields = map->record->fields;
> > -		u32 cnt = map->record->cnt;
> > -		int i;
> > +	int i;
> >
> > -		for (i = 0; i < cnt; i++)
> > -			memset(dst + fields[i].offset, 0, btf_field_type_size(fields[i].type));
> > -	}
> > +	if (!foffs)
> > +		return;
> > +	for (i = 0; i < foffs->cnt; i++)
> > +		memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
> > +}
> > +
> > +static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> > +{
> > +	bpf_obj_init(map->field_offs, dst);
> >  }
> >
> >  /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 887fa4d922f6..306fc1d6cc4a 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -427,6 +427,8 @@ struct bpf_insn_aux_data {
> >  		 */
> >  		struct bpf_loop_inline_state loop_inline_state;
> >  	};
> > +	u64 obj_new_size; /* remember the size of type passed to bpf_obj_new to rewrite R1 */
> > +	struct btf_struct_meta *kptr_struct_meta;
> >  	u64 map_key_state; /* constant (32 bit) key tracking for maps */
> >  	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
> >  	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 9c16338bcbe8..2e57fc839a5c 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/log2.h>
> >  #include <linux/bpf_verifier.h>
> >  #include <linux/nodemask.h>
> > +#include <linux/bpf_mem_alloc.h>
> >
> >  #include <asm/barrier.h>
> >  #include <asm/unaligned.h>
> > @@ -60,6 +61,9 @@
> >  #define CTX	regs[BPF_REG_CTX]
> >  #define IMM	insn->imm
> >
> > +struct bpf_mem_alloc bpf_global_ma;
> > +bool bpf_global_ma_set;
> > +
> >  /* No hurry in this branch
> >   *
> >   * Exported for the bpf jit load helper.
> > @@ -2746,6 +2750,18 @@ int __weak bpf_arch_text_invalidate(void *dst, size_t len)
> >  	return -ENOTSUPP;
> >  }
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +static int __init bpf_global_ma_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
> > +	bpf_global_ma_set = !ret;
> > +	return ret;
> > +}
> > +late_initcall(bpf_global_ma_init);
> > +#endif
> > +
> >  DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> >  EXPORT_SYMBOL(bpf_stats_enabled_key);
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 5bc0b9f0f306..c4f1c22cc44c 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/proc_ns.h>
> >  #include <linux/security.h>
> >  #include <linux/btf_ids.h>
> > +#include <linux/bpf_mem_alloc.h>
> >
> >  #include "../../lib/kstrtox.h"
> >
> > @@ -1735,25 +1736,57 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
> >
> >  		obj -= field->list_head.node_offset;
> >  		head = head->next;
> > -		/* TODO: Rework later */
> > -		kfree(obj);
> > +		/* The contained type can also have resources, including a
> > +		 * bpf_list_head which needs to be freed.
> > +		 */
> > +		bpf_obj_free_fields(field->list_head.value_rec, obj);
> > +		/* bpf_mem_free requires migrate_disable(), since we can be
> > +		 * called from map free path as well apart from BPF program (as
> > +		 * part of map ops doing bpf_obj_free_fields).
> > +		 */
> > +		migrate_disable();
> > +		bpf_mem_free(&bpf_global_ma, obj);
> > +		migrate_enable();
> >  	}
> >  }
> >
> > -BTF_SET8_START(tracing_btf_ids)
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global functions as their definitions will be in vmlinux BTF");
> > +
> > +void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> > +{
> > +	struct btf_struct_meta *meta = meta__ign;
> > +	u64 size = local_type_id__k;
> > +	void *p;
> > +
> > +	if (unlikely(!bpf_global_ma_set))
> > +		return NULL;
> > +	p = bpf_mem_alloc(&bpf_global_ma, size);
> > +	if (!p)
> > +		return NULL;
> > +	if (meta)
> > +		bpf_obj_init(meta->field_offs, p);
> > +	return p;
> > +}
> > +
> > +__diag_pop();
> > +
> > +BTF_SET8_START(generic_btf_ids)
> >  #ifdef CONFIG_KEXEC_CORE
> >  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
> >  #endif
> > -BTF_SET8_END(tracing_btf_ids)
> > +BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
> > +BTF_SET8_END(generic_btf_ids)
> >
> > -static const struct btf_kfunc_id_set tracing_kfunc_set = {
> > +static const struct btf_kfunc_id_set generic_kfunc_set = {
> >  	.owner = THIS_MODULE,
> > -	.set   = &tracing_btf_ids,
> > +	.set   = &generic_btf_ids,
> >  };
> >
> >  static int __init kfunc_init(void)
> >  {
> > -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
> > +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
> >  }
> >
> >  late_initcall(kfunc_init);
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a4a1424b19a5..c7f5d83783db 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7948,6 +7948,11 @@ static bool is_kfunc_arg_sfx_constant(const struct btf *btf, const struct btf_pa
> >  	return __kfunc_param_match_suffix(btf, arg, "__k");
> >  }
> >
> > +static bool is_kfunc_arg_sfx_ignore(const struct btf *btf, const struct btf_param *arg)
> > +{
> > +	return __kfunc_param_match_suffix(btf, arg, "__ign");
> > +}
> > +
> >  static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
> >  				      const struct btf_param *arg,
> >  				      const struct bpf_reg_state *reg,
> > @@ -8216,6 +8221,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  		int kf_arg_type;
> >
> >  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> > +
> > +		if (is_kfunc_arg_sfx_ignore(btf, &args[i]))
> > +			continue;
> > +
> >  		if (btf_type_is_scalar(t)) {
> >  			if (reg->type != SCALAR_VALUE) {
> >  				verbose(env, "R%d is not a scalar\n", regno);
> > @@ -8395,6 +8404,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  	return 0;
> >  }
> >
> > +enum special_kfunc_type {
> > +	KF_bpf_obj_new_impl,
> > +};
> > +
> > +BTF_SET_START(special_kfunc_set)
> > +BTF_ID(func, bpf_obj_new_impl)
> > +BTF_SET_END(special_kfunc_set)
> > +
> > +BTF_ID_LIST(special_kfunc_list)
> > +BTF_ID(func, bpf_obj_new_impl)
> > +
> >  static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  			    int *insn_idx_p)
> >  {
> > @@ -8469,17 +8489,64 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
> >
> >  	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
> > -		verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
> > -		return -EINVAL;
> > +		/* Only exception is bpf_obj_new_impl */
> > +		if (meta.btf != btf_vmlinux || meta.func_id != special_kfunc_list[KF_bpf_obj_new_impl]) {
> > +			verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
> > +			return -EINVAL;
> > +		}
> >  	}
> >
> >  	if (btf_type_is_scalar(t)) {
> >  		mark_reg_unknown(env, regs, BPF_REG_0);
> >  		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
> >  	} else if (btf_type_is_ptr(t)) {
> > -		ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
> > -						   &ptr_type_id);
> > -		if (!btf_type_is_struct(ptr_type)) {
> > +		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
> > +
> > +		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
> > +			if (!btf_type_is_void(ptr_type)) {
> > +				verbose(env, "kernel function %s must have void * return type\n",
> > +					meta.func_name);
> > +				return -EINVAL;
> > +			}
>
> Here you're checking that void *bpf_obj_new_impl and obj_drop actually were
> declared with 'void *' return ?
> and wasting run-time cycle to check that??
> Please don't.
>
> Even if we miss that during code review there is no safety issue.
>

Right, I think the later linked list patch actually drops this hunk anyway. We
fail if any of the other cases are unhandled anyway.
