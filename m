Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8696A632841
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiKUPdB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiKUPch (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:32:37 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCFDD2982;
        Mon, 21 Nov 2022 07:31:13 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id c8so8183987qvn.10;
        Mon, 21 Nov 2022 07:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REnLetKzAh9a3Kk0LcmnYoIt8FX0TxEIRG9oyHEqkz0=;
        b=fK58YKGZWN/F6keDXZEH0s/QO6a+Um0yVi5Pm4Rd0fkc9QDsaC9xyZYzuEqAWhP6dD
         BQtnBcfyGuDuK4AdBCj+60Jjw15FU5Jcp6ksugkZcbxoaVo728WqsGNmGL+O7cCBhC1k
         2+9sC94e6NLhR0lQ4a3IETRtiCvFkKMBLdNGhB+nGQqQMyJt+2N+KJTQjg1IeYdbPgsC
         V9d16UH/aJBxV129oBl6eU4O3qP22E4cser0ex2WiSEIFnh0FD8+uGbz1QUK5+0f0f8+
         AnuKmAaCH/DWGq0nF83Kr7Q+VT2jtiDgdRsyRWrFPEoPcrmM/g2OpNCadpeNIGNX/G+1
         GUOw==
X-Gm-Message-State: ANoB5pktJCbJh1hA9DvPdIfCLK4s4DDZ36YU3iDIqhya5ZWG6QyHpy2G
        AtT61BdIrNeA8p4gOL0vVhw=
X-Google-Smtp-Source: AA0mqf63xlz6ekq6fFaDllnxAMEvEo8EgI23MgA1QPnykZ8VK+CQMze0zbzWboMh2T1AT1KN/HnJCg==
X-Received: by 2002:ad4:5005:0:b0:4b1:8547:9788 with SMTP id s5-20020ad45005000000b004b185479788mr17929120qvo.60.1669044671893;
        Mon, 21 Nov 2022 07:31:11 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id y11-20020a37f60b000000b006ce1bfbd603sm8134925qkj.124.2022.11.21.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:31:11 -0800 (PST)
Date:   Mon, 21 Nov 2022 09:31:16 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, tj@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v9 2/4] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <Y3uZxDcEw0TzZDo7@maniforge.lan>
References: <20221120051004.3605026-1-void@manifault.com>
 <20221120051004.3605026-3-void@manifault.com>
 <20221120194548.g76fytbyxhi7xqcu@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120194548.g76fytbyxhi7xqcu@apollo>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 01:15:48AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Sun, Nov 20, 2022 at 10:40:02AM IST, David Vernet wrote:
> > Kfuncs currently support specifying the KF_TRUSTED_ARGS flag to signal
> > to the verifier that it should enforce that a BPF program passes it a
> > "safe", trusted pointer. Currently, "safe" means that the pointer is
> > either PTR_TO_CTX, or is refcounted. There may be cases, however, where
> > the kernel passes a BPF program a safe / trusted pointer to an object
> > that the BPF program wishes to use as a kptr, but because the object
> > does not yet have a ref_obj_id from the perspective of the verifier, the
> > program would be unable to pass it to a KF_ACQUIRE | KF_TRUSTED_ARGS
> > kfunc.
> >
> > The solution is to expand the set of pointers that are considered
> > trusted according to KF_TRUSTED_ARGS, so that programs can invoke kfuncs
> > with these pointers without getting rejected by the verifier.
> >
> > There is already a PTR_UNTRUSTED flag that is set in some scenarios,
> > such as when a BPF program reads a kptr directly from a map
> > without performing a bpf_kptr_xchg() call. These pointers of course can
> > and should be rejected by the verifier. Unfortunately, however,
> > PTR_UNTRUSTED does not cover all the cases for safety that need to
> > be addressed to adequately protect kfuncs. Specifically, pointers
> > obtained by a BPF program "walking" a struct are _not_ considered
> > PTR_UNTRUSTED according to BPF. For example, say that we were to add a
> > kfunc called bpf_task_acquire(), with KF_ACQUIRE | KF_TRUSTED_ARGS, to
> > acquire a struct task_struct *. If we only used PTR_UNTRUSTED to signal
> > that a task was unsafe to pass to a kfunc, the verifier would mistakenly
> > allow the following unsafe BPF program to be loaded:
> >
> > SEC("tp_btf/task_newtask")
> > int BPF_PROG(unsafe_acquire_task,
> >              struct task_struct *task,
> >              u64 clone_flags)
> > {
> >         struct task_struct *acquired, *nested;
> >
> >         nested = task->last_wakee;
> >
> >         /* Would not be rejected by the verifier. */
> >         acquired = bpf_task_acquire(nested);
> >         if (!acquired)
> >                 return 0;
> >
> >         bpf_task_release(acquired);
> >         return 0;
> > }
> >
> > To address this, this patch defines a new type flag called PTR_TRUSTED
> > which tracks whether a PTR_TO_BTF_ID pointer is safe to pass to a
> > KF_TRUSTED_ARGS kfunc or a BPF helper function. PTR_TRUSTED pointers are
> > passed directly from the kernel as a tracepoint or struct_ops callback
> > argument. Any nested pointer that is obtained from walking a PTR_TRUSTED
> > pointer is no longer PTR_TRUSTED. From the example above, the struct
> > task_struct *task argument is PTR_TRUSTED, but the 'nested' pointer
> > obtained from 'task->last_wakee' is not PTR_TRUSTED.
> >
> > A subsequent patch will add kfuncs for storing a task kfunc as a kptr,
> > and then another patch will add selftests to validate.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> 
> Sorry that I couldn't look at it earlier.
> 
> > [...]
> > @@ -5884,8 +5889,18 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
> >  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
> >  static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
> >  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> > -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> > -static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
> > +static const struct bpf_reg_types btf_ptr_types = {
> > +	.types = {
> > +		PTR_TO_BTF_ID,
> > +		PTR_TO_BTF_ID | PTR_TRUSTED,
> > +	},
> > +};
> > +static const struct bpf_reg_types percpu_btf_ptr_types = {
> > +	.types = {
> > +		PTR_TO_BTF_ID | MEM_PERCPU,
> > +		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,
> 
> Where is PTR_TRUSTED set for MEM_PERCPU?

We set PTR_TRUSTED in btf_ctx_access() for all PTR_TO_BTF_ID regs for
BPF_PROG_TYPE_TRACING and BPF_PROG_TYPE_STRUCT_OPS. See [0]. Let me know
if I've misunderstood anything.

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/btf.c#n5972

> > +	}
> > +};
> >  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> >  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > @@ -5973,7 +5988,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >  	return -EACCES;
> >
> >  found:
> > -	if (reg->type == PTR_TO_BTF_ID) {
> > +	if (reg->type == PTR_TO_BTF_ID || reg->type & PTR_TRUSTED) {
> 
> Now, earlier MEM_ALLOC was supposed to not enter this branch. If your patch
> allows MEM_ALLOC | PTR_TRUSTED (but I don't think it does), it will enter this
> branch. I think it is better to just be explicit and say PTR_TO_BTF_ID ||
> PTR_TO_BTF_ID | PTR_TRUSTED.

Currently I don't believe we set PTR_TRUSTED | MEM_ALLOC, so this won't
happen. I originally had this code doing:

	if (reg->type == PTR_TO_BTF_ID || reg->type & BPF_REG_TRUSTED_MODIFIERS) {

and it caused a bunch of the linked list tests to fail with:

verifier internal error: R0 has non-overwritten BPF_PTR_POISON type

Checking just PTR_TRUSTED avoids this (which I assume is what you were
worried about?). I'm happy to respin a patch that applies your
suggestion to do || PTR_TO_BTF_ID | PTR_TRUSTED, but to be honest I
don't think it buys us anything. That whole codepath where we take it
only in the event of no modifiers is kind of sketchy. Consider, e.g.,
that we're skipping this check if we don't take that path:

	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
				  btf_vmlinux, *arg_btf_id,
				  strict_type_match)) {
		verbose(env, "R%d is of type %s but %s is expected\n",
			regno, kernel_type_name(reg->btf, reg->btf_id),
			kernel_type_name(btf_vmlinux, *arg_btf_id));
		return -EACCES;
	}

I know we check it elsewhere such as in map_kptr_match_type() and
process_kf_arg_ptr_to_list_node(), but it feels pretty brittle to say:
"Check it only if there are no modifiers set, else check it later in
some helper-specific logic". I'd prefer to keep the check as broad as
possible for now, and then refactor and clean this up. Lmk if you
disagree.

> 
> >  		/* For bpf_sk_release, it needs to match against first member
> >  		 * 'struct sock_common', hence make an exception for it. This
> >  		 * allows bpf_sk_release to work for multiple socket types.
> > @@ -6055,6 +6070,8 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  	 */
> >  	case PTR_TO_BTF_ID:
> >  	case PTR_TO_BTF_ID | MEM_ALLOC:
> > +	case PTR_TO_BTF_ID | PTR_TRUSTED:
> > +	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
> 
> This and the one below:
> 
> > @@ -8366,6 +8402,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
> >  		ptr = reg->map_ptr;
> >  		break;
> >  	case PTR_TO_BTF_ID | MEM_ALLOC:
> > +	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
> 
> I think this will never be set, based on my reading of the code.
> Is the case with MEM_ALLOC | PTR_TRUSTED ever possible?
> And if this is needed here, why not update btf_struct_access?
> And KF_ARG_PTR_TO_ALLOC_BTF_ID is not updated either?
> Let me know if I missed something.

These are all reasonable observations, but we went into them
intentionally. Eventually the goal is to have PTR_TRUSTED be the single
source of truth for whether a pointer is trusted or not. See [1] for the
thread with the discussions.

I agree that I don't believe that MEM_ALLOC | PTR_TRUSTED can be set
together yet, but eventually they should and will be. Conceptually, the
behavior of check_func_arg_reg_off() should be the same for
PTR_TO_BTF_ID, PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED, PTR_TO_BTF_ID |
PTR_TRUSTED, etc, so IMO it's correct to add that case to
check_func_arg_reg_off() even if it's not yet used. Not adding it
because no callers currently happen to require it is IMO a bit brittle.

[1]: https://lore.kernel.org/all/20221119164855.qvhgdpg5axa7kzey@macbook-pro-5.dhcp.thefacebook.com/

> >  		/* When referenced PTR_TO_BTF_ID is passed to release function,
> >  		 * it's fixed offset must be 0.	In the other cases, fixed offset
> >  		 * can be non-zero.
> > @@ -7939,6 +7956,25 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
> >  	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
> >  }
> >
> > +static bool is_trusted_reg(const struct bpf_reg_state *reg)
> > +{
> > +	/* A referenced register is always trusted. */
> > +	if (reg->ref_obj_id)
> > +		return true;
> > +
> > +	/* If a register is not referenced, it is trusted if it has either the
> > +	 * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
> > +	 * other type modifiers may be safe, but we elect to take an opt-in
> > +	 * approach here as some (e.g. PTR_UNTRUSTED and PTR_MAYBE_NULL) are
> > +	 * not.
> > +	 *
> > +	 * Eventually, we should make PTR_TRUSTED the single source of truth
> > +	 * for whether a register is trusted.
> > +	 */
> > +	return type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS &&
> > +	       !bpf_type_has_unsafe_modifiers(reg->type);
> > +}
> > +
> >  static bool __kfunc_param_match_suffix(const struct btf *btf,
> >  				       const struct btf_param *arg,
> >  				       const char *suffix)
> > @@ -8220,7 +8256,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
> >  	const char *reg_ref_tname;
> >  	u32 reg_ref_id;
> >
> > -	if (reg->type == PTR_TO_BTF_ID) {
> > +	if (base_type(reg->type) == PTR_TO_BTF_ID) {
> >  		reg_btf = reg->btf;
> >  		reg_ref_id = reg->btf_id;
> >  	} else {
> >  		ptr = reg->btf;
> >  		break;
> >  	default:
> > @@ -8596,8 +8633,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  		case KF_ARG_PTR_TO_BTF_ID:
> >  			if (!is_kfunc_trusted_args(meta))
> >  				break;
> > -			if (!reg->ref_obj_id) {
> > -				verbose(env, "R%d must be referenced\n", regno);
> > +
> > +			if (!is_trusted_reg(reg)) {
> > +				verbose(env, "R%d must be referenced or trusted\n", regno);
> >  				return -EINVAL;
> >  			}
> >  			fallthrough;
> > @@ -8702,9 +8740,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  			break;
> >  		case KF_ARG_PTR_TO_BTF_ID:
> >  			/* Only base_type is checked, further checks are done here */
> > -			if (reg->type != PTR_TO_BTF_ID &&
> > -			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> > -				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> > +			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
> > +			     bpf_type_has_unsafe_modifiers(reg->type)) &&
> > +			    !reg2btf_ids[base_type(reg->type)]) {
> > +				verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
> > +				verbose(env, "expected %s or socket\n",
> > +					reg_type_str(env, base_type(reg->type) |
> > +							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
> >  				return -EINVAL;
> >  			}
> >  			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
> > @@ -14713,6 +14755,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> >  			break;
> >  		case PTR_TO_BTF_ID:
> >  		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> > +		case PTR_TO_BTF_ID | PTR_TRUSTED:
> >  		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
> >  		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
> >  		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
> > @@ -14720,6 +14763,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> >  		 * for this case.
> >  		 */
> >  		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
> > +		case PTR_TO_BTF_ID | PTR_UNTRUSTED | PTR_TRUSTED:
> 
> I feel this is confusing. What do we mean with PTR_UNTRUSTED | PTR_TRUSTED?

100% agreed. There are plans to clean this up, see the link above.
