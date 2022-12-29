Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB55658950
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 05:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiL2ECn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 23:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2ECn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 23:02:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C503CEE39
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 20:02:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl4so11563234plb.8
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 20:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rw7NDkC0CVN/zsE0bL+HkTWoIEGxXdNZMk50rrSLyI=;
        b=hbrPk2jDxpeIfNxrI7B37VFyM3y+QiI1CbJxtZYzBn+oRtz6vzt4O6L8ZM2yCnwJi0
         cpphq9TWjVtCLrXYVPEbqSNA9pwy4q66/+t8AY1WE9w/CoIMpse+dsXhReg8VIPgRSka
         +Kevf9Ug1agAJsj7f2QeLRKOX7zD7Z5E5KOgB937E6Kc2bqyOSIBgUWGn5JTvmHS1l/e
         JzzXNYiaL8fn3TotK4Q9wgFU0AOCKBgbFyat6c3nx1FwCorY3VOii745+ODSSTuJTH7O
         /9FeVNAU43O0q6e6VMkbooZtYE8H+gkESnNv7w+HCAmmDtvTDu3Fmx8xRl9NxNIqA5M0
         Np2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rw7NDkC0CVN/zsE0bL+HkTWoIEGxXdNZMk50rrSLyI=;
        b=p7Mf0tS3cO7GKAmkzgcqPWWYCYJFIW5hObGSKuK//8nb3jyPdVptySmj1o/jBoaAAz
         0kP7EBOMeZ1H+1y8jetREAmAgSS6wAaib0tuqNK9s3a9luS32ufRc0f+IR021oLGR477
         5uWOgs2X7vGEHvmdeEpopvM017STE0g9cm73F7OqQtQ4U5apEcI6HJ28iOC1FJwlo6jC
         p/EmHQNJdZ6Laqb+IY0F0D10s4VBFNZdvdOhrzo6lQZZfmmQKFAdFfjWdOtI3lzbQ6oX
         VyOQ8jA4ZcFHG4xf4eyKJ57UJLotCFJA4J4NRtf20HOIleUWS+8HRahfaaP4/R/jv59R
         LFbg==
X-Gm-Message-State: AFqh2ko8eJDc6mstDs3MijX53R1HMJU7kOo4ikwRGh0FFFiSLBEvEbjt
        TlaQtEUUhKOMblxDI6JdE3CphV1UFAo=
X-Google-Smtp-Source: AMrXdXsd00CK3HcoPn/IgpGjoE3x7hg3M87NNfJTNUmFQViQIWUc3Oh6d3rgI1SMp21CW6YPdE1WJA==
X-Received: by 2002:a17:902:b782:b0:192:6fc5:60 with SMTP id e2-20020a170902b78200b001926fc50060mr17006844pls.25.1672286561091;
        Wed, 28 Dec 2022 20:02:41 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:e38b])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b00192a04bc620sm425289plb.295.2022.12.28.20.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 20:02:40 -0800 (PST)
Date:   Wed, 28 Dec 2022 20:02:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <20221229040238.b2sbmsnz7rapdthd@MacBook-Pro-6.local>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-10-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217082506.1570898-10-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 12:25:02AM -0800, Dave Marchevsky wrote:
> Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
> that require handling in the verifier:
> 
>   * both bpf_rbtree_remove and bpf_rbtree_first return the type containing
>     the bpf_rb_node field, with the offset set to that field's offset,
>     instead of a struct bpf_rb_node *
>     * mark_reg_graph_node helper added in previous patch generalizes
>       this logic, use it
> 
>   * bpf_rbtree_remove's node input is a node that's been inserted
>     in the tree - a non-owning reference.
> 
>   * bpf_rbtree_remove must invalidate non-owning references in order to
>     avoid aliasing issue. Add KF_INVALIDATE_NON_OWN flag, which
>     indicates that the marked kfunc is a non-owning ref invalidation
>     point, and associated verifier logic using previously-added
>     invalidate_non_owning_refs helper.
> 
>   * Unlike other functions, which convert one of their input arg regs to
>     non-owning reference, bpf_rbtree_first takes no arguments and just
>     returns a non-owning reference (possibly null)
>     * For now verifier logic for this is special-cased instead of
>       adding new kfunc flag.
> 
> This patch, along with the previous one, complete special verifier
> handling for all rbtree API functions added in this series.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/btf.h   |  1 +
>  kernel/bpf/helpers.c  |  2 +-
>  kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++------
>  3 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 8aee3f7f4248..3663911bb7c0 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -72,6 +72,7 @@
>  #define KF_DESTRUCTIVE		(1 << 6) /* kfunc performs destructive actions */
>  #define KF_RCU			(1 << 7) /* kfunc only takes rcu pointer arguments */
>  #define KF_RELEASE_NON_OWN	(1 << 8) /* kfunc converts its referenced arg into non-owning ref */
> +#define KF_INVALIDATE_NON_OWN	(1 << 9) /* kfunc invalidates non-owning refs after return */
>  
>  /*
>   * Return the name of the passed struct, if exists, or halt the build if for
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index de4523c777b7..0e6d010e6423 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2121,7 +2121,7 @@ BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_task_acquire_not_zero, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_INVALIDATE_NON_OWN)

I don't like this 'generalization' either.

>  BTF_ID_FLAGS(func, bpf_rbtree_add, KF_RELEASE | KF_RELEASE_NON_OWN)
>  BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
>  
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 75979f78399d..b4bf3701de7f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8393,6 +8393,11 @@ static bool is_kfunc_release_non_own(struct bpf_kfunc_call_arg_meta *meta)
>  	return meta->kfunc_flags & KF_RELEASE_NON_OWN;
>  }
>  
> +static bool is_kfunc_invalidate_non_own(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_INVALIDATE_NON_OWN;
> +}
> +
>  static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
>  {
>  	return meta->kfunc_flags & KF_TRUSTED_ARGS;
> @@ -9425,10 +9430,20 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				verbose(env, "arg#%d expected pointer to allocated object\n", i);
>  				return -EINVAL;
>  			}
> -			if (!reg->ref_obj_id) {
> +			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_remove]) {
> +				if (reg->ref_obj_id) {
> +					verbose(env, "rbtree_remove node input must be non-owning ref\n");
> +					return -EINVAL;
> +				}
> +				if (in_rbtree_lock_required_cb(env)) {
> +					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
> +					return -EINVAL;
> +				}
> +			} else if (!reg->ref_obj_id) {
>  				verbose(env, "allocated object must be referenced\n");
>  				return -EINVAL;
>  			}
> +
>  			ret = process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
>  			if (ret < 0)
>  				return ret;
> @@ -9665,11 +9680,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
>  				struct btf_field *field = meta.arg_list_head.field;
>  
> -				mark_reg_known_zero(env, regs, BPF_REG_0);
> -				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> -				regs[BPF_REG_0].btf = field->graph_root.btf;
> -				regs[BPF_REG_0].btf_id = field->graph_root.value_btf_id;
> -				regs[BPF_REG_0].off = field->graph_root.node_offset;
> +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
> +			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||

Just call invalidate_non_owning_refs() here since it needs to be a special case anyway.

> +				   meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> +				struct btf_field *field = meta.arg_rbtree_root.field;
> +
> +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
>  			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
>  				mark_reg_known_zero(env, regs, BPF_REG_0);
>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> @@ -9735,7 +9751,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			if (is_kfunc_ret_null(&meta))
>  				regs[BPF_REG_0].id = id;
>  			regs[BPF_REG_0].ref_obj_id = id;
> +		} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> +			ref_set_non_owning_lock(env, &regs[BPF_REG_0]);
>  		}
> +
> +		if (is_kfunc_invalidate_non_own(&meta))
> +			invalidate_non_owning_refs(env, &env->cur_state->active_lock);
> +
>  		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
>  			regs[BPF_REG_0].id = ++env->id_gen;
>  	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
> -- 
> 2.30.2
> 
