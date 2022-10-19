Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EFD60508F
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJSThX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 15:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJSThT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 15:37:19 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A18B1ACAB5;
        Wed, 19 Oct 2022 12:37:10 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id l28so12387480qtv.4;
        Wed, 19 Oct 2022 12:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnqjzgCwOqHCDmAgzAEiSF5mqssA4p4OptEVntFCBl0=;
        b=vA8x7hBfQ+iW+uvkJ9sWCsnEKyoyPMcPqEnY2T5zXFq1QsnidjOR7IBjV/Tli/UCqQ
         pJCi1vaIL9vmFEBdpLb57PyBHwfl6b3jlihAGo46Ppk5eg9DYU/5W1m+uRltmGESESxu
         h3PQhlrDMKl1u0LRdhbVlqa4ul6DVeQPk1xegIl6OlJqJr+KpeGGNEXJfyMyHs9gQ5KN
         aR6LkGQzXs2J7o/NsHXQtiAlMv3tQRxDKaV0JC05kUdXQbjxrNuNnR2Hru/x92i37kkz
         8mZPjItol3MWVF6btgdhCnqUO1ORvh7xCyncVQa76kLXuopssTPum+eHOER00/svnpiG
         qyYQ==
X-Gm-Message-State: ACrzQf27HFOw4mqXfXRaKmy4VaPMqydLIH5psIa31SfmGpGtU56Zg9GK
        L5R1XWnATsAveZeyzeFppko=
X-Google-Smtp-Source: AMsMyM4SQf7W6xD0Pv8nsb9BgTntqKavyIg/1KdfYIZihCC84k0un3PkCxZuvvEfrrNmlcep5CZtMQ==
X-Received: by 2002:ac8:7d01:0:b0:39c:ebdf:490c with SMTP id g1-20020ac87d01000000b0039cebdf490cmr8093890qtb.179.1666208229310;
        Wed, 19 Oct 2022 12:37:09 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::e12b])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm5566817qkn.75.2022.10.19.12.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:37:08 -0700 (PDT)
Date:   Wed, 19 Oct 2022 14:37:09 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v5 1/3] bpf: Allow trusted pointers to be passed to
 KF_TRUSTED_ARGS kfuncs
Message-ID: <Y1BR5c6W4tgljA8q@maniforge.dhcp.thefacebook.com>
References: <20221014212133.2520531-1-void@manifault.com>
 <20221014212133.2520531-2-void@manifault.com>
 <CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 07:02:15AM +0530, Kumar Kartikeya Dwivedi wrote:
> Please tag the patches with [ PATCH bpf-next ... ] subject prefix.

Sure, will do.

> >  include/linux/bpf.h                          |  6 ++++++
> >  kernel/bpf/btf.c                             | 11 ++++++++++-
> >  kernel/bpf/verifier.c                        | 12 +++++++++++-
> >  tools/testing/selftests/bpf/verifier/calls.c |  4 ++--
> >  4 files changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9e7d46d16032..b624024edb4e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -457,6 +457,12 @@ enum bpf_type_flag {
> >         /* Size is known at compile time. */
> >         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > +       /* PTR was obtained from walking a struct. This is used with
> > +        * PTR_TO_BTF_ID to determine whether the pointer is safe to pass to a
> > +        * kfunc with KF_TRUSTED_ARGS.
> > +        */
> > +       PTR_NESTED              = BIT(11 + BPF_BASE_TYPE_BITS),
> > +
> >         __BPF_TYPE_FLAG_MAX,
> >         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
> >  };
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index eba603cec2c5..3d7bad11b10b 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6333,8 +6333,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                 /* Check if argument must be a referenced pointer, args + i has
> >                  * been verified to be a pointer (after skipping modifiers).
> >                  * PTR_TO_CTX is ok without having non-zero ref_obj_id.
> > +                *
> > +                * All object pointers must be refcounted, other than:
> > +                * - PTR_TO_CTX
> > +                * - Trusted pointers (i.e. pointers with no type modifiers)
> >                  */
> > -               if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
> > +               if (is_kfunc &&
> > +                   trusted_args &&
> > +                   obj_ptr &&
> > +                   base_type(reg->type) != PTR_TO_CTX &&
> > +                   type_flag(reg->type) &&
> > +                   !reg->ref_obj_id) {
> >                         bpf_log(log, "R%d must be referenced\n", regno);
> >                         return -EINVAL;
> >                 }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6f6d2d511c06..d16a08ca507b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -581,6 +581,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> >                 strncpy(prefix, "user_", 32);
> >         if (type & MEM_PERCPU)
> >                 strncpy(prefix, "percpu_", 32);
> > +       if (type & PTR_NESTED)
> > +               strncpy(prefix, "nested_", 32);
> >         if (type & PTR_UNTRUSTED)
> >                 strncpy(prefix, "untrusted_", 32);
> >
> 
> Since these are no longer exclusive, the code needs to be updated to
> append strings to the prefix buffer.
> Maybe just using snprintf with %s%s%s.. would be better, passing ""
> when !(type & flag).

Sure, I can make that change. We'll have to increase the size of the
prefix string on the stack, but that's hardly problematic as these
strings are not terribly large.

> > @@ -4558,6 +4560,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >         if (type_flag(reg->type) & PTR_UNTRUSTED)
> >                 flag |= PTR_UNTRUSTED;
> >
> > +       /* All pointers obtained by walking a struct are nested. */
> > +       flag |= PTR_NESTED;
> > +
> 
> Instead of PTR_NESTED, how about PTR_WALK?

I don't have a strong preference between either, though I would prefer
PTR_WALKED if we go with the latter. Does that work for you?

> >         if (atype == BPF_READ && value_regno >= 0)
> >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
> >
> > @@ -5694,7 +5699,12 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
> >  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
> >  static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
> >  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> > -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> > +static const struct bpf_reg_types btf_ptr_types = {
> > +       .types = {
> > +               PTR_TO_BTF_ID,
> > +               PTR_TO_BTF_ID | PTR_NESTED
> > +       },
> > +};
> >  static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
> >  static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
> >  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > index e1a937277b54..496c29b1a298 100644
> > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > @@ -181,7 +181,7 @@
> >         },
> >         .result_unpriv = REJECT,
> >         .result = REJECT,
> > -       .errstr = "negative offset ptr_ ptr R1 off=-4 disallowed",
> > +       .errstr = "negative offset nested_ptr_ ptr R1 off=-4 disallowed",
> >  },
> >  {
> >         "calls: invalid kfunc call: PTR_TO_BTF_ID with variable offset",
> > @@ -243,7 +243,7 @@
> >         },
> >         .result_unpriv = REJECT,
> >         .result = REJECT,
> > -       .errstr = "R1 must be referenced",
> > +       .errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point to scalar",
> >  },
> >  {
> >         "calls: valid kfunc call: referenced arg needs refcounted PTR_TO_BTF_ID",
> > --
> > 2.38.0
> >
> 
> On Sat, 15 Oct 2022 at 02:51, David Vernet <void@manifault.com> wrote:
> >
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
> > To address this, this patch defines a new type flag called PTR_NESTED
> > which tracks whether a PTR_TO_BTF_ID pointer was retrieved from walking
> > a struct. A pointer passed directly from the kernel begins with
> > (PTR_NESTED & type) == 0, meaning of course that it is not nested. Any
> > pointer received from walking that object, however, would inherit that
> > flag and become a nested pointer.
> >
> > With that flag, this patch also updates btf_check_func_arg_match() to
> > only flag a PTR_TO_BTF_ID object as requiring a refcount if it has any
> > type modifiers (which of course includes both PTR_UNTRUSTED and
> > PTR_NESTED). Otherwise, the pointer passes this check and continues
> > onto the others in btf_check_func_arg_match().
> >
> > A subsequent patch will add kfuncs for storing a task kfunc as a kptr,
> > and then another patch will validate this feature by ensuring that the
> > verifier rejects a kfunc invocation with a nested pointer.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  include/linux/bpf.h                          |  6 ++++++
> >  kernel/bpf/btf.c                             | 11 ++++++++++-
> >  kernel/bpf/verifier.c                        | 12 +++++++++++-
> >  tools/testing/selftests/bpf/verifier/calls.c |  4 ++--
> >  4 files changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9e7d46d16032..b624024edb4e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -457,6 +457,12 @@ enum bpf_type_flag {
> >         /* Size is known at compile time. */
> >         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > +       /* PTR was obtained from walking a struct. This is used with
> > +        * PTR_TO_BTF_ID to determine whether the pointer is safe to pass to a
> > +        * kfunc with KF_TRUSTED_ARGS.
> > +        */
> > +       PTR_NESTED              = BIT(11 + BPF_BASE_TYPE_BITS),
> > +
> >         __BPF_TYPE_FLAG_MAX,
> >         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
> >  };
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index eba603cec2c5..3d7bad11b10b 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6333,8 +6333,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                 /* Check if argument must be a referenced pointer, args + i has
> >                  * been verified to be a pointer (after skipping modifiers).
> >                  * PTR_TO_CTX is ok without having non-zero ref_obj_id.
> > +                *
> > +                * All object pointers must be refcounted, other than:
> > +                * - PTR_TO_CTX
> > +                * - Trusted pointers (i.e. pointers with no type modifiers)
> >                  */
> > -               if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
> > +               if (is_kfunc &&
> > +                   trusted_args &&
> > +                   obj_ptr &&
> > +                   base_type(reg->type) != PTR_TO_CTX &&
> > +                   type_flag(reg->type) &&
> > +                   !reg->ref_obj_id) {
> >                         bpf_log(log, "R%d must be referenced\n", regno);
> >                         return -EINVAL;
> >                 }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6f6d2d511c06..d16a08ca507b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -581,6 +581,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> >                 strncpy(prefix, "user_", 32);
> >         if (type & MEM_PERCPU)
> >                 strncpy(prefix, "percpu_", 32);
> > +       if (type & PTR_NESTED)
> > +               strncpy(prefix, "nested_", 32);
> >         if (type & PTR_UNTRUSTED)
> >                 strncpy(prefix, "untrusted_", 32);
> >
> > @@ -4558,6 +4560,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >         if (type_flag(reg->type) & PTR_UNTRUSTED)
> >                 flag |= PTR_UNTRUSTED;
> >
> > +       /* All pointers obtained by walking a struct are nested. */
> > +       flag |= PTR_NESTED;
> > +
> >         if (atype == BPF_READ && value_regno >= 0)
> >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
> >
> > @@ -5694,7 +5699,12 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
> >  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
> >  static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
> >  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> > -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> > +static const struct bpf_reg_types btf_ptr_types = {
> > +       .types = {
> > +               PTR_TO_BTF_ID,
> > +               PTR_TO_BTF_ID | PTR_NESTED
> > +       },
> > +};
> 
> CI fails, two of those failures are from not updating
> check_func_arg_reg_off for PTR_TO_BTF_ID | PTR_WALK, and the other one

Gah, I didn't think it was necessary for this case as it's not required
for btf_check_func_arg_match(), which will eventually just fail in the
following check:

	if (!btf_type_is_struct(ref_t)) {
		bpf_log(log, "kernel function %s args#%d pointer type %s %s is not support
			func_name, i, btf_type_str(ref_t),
			ref_tname);
		return -EINVAL;
	}

Note that we also don't include PTR_TO_BTF_ID | PTR_UNTRUSTED here. The
difference for PTR_TO_BTF_ID | PTR_WALK(ED) is of course that we also need to
allow it to work properly for normal helper calls, so I'll make that change.
Thanks for pointing it out. In general, the whole dance between register base
types + modifiers sometimes feels like a mine field...

> is a crash because you didn't add to the list in convert_ctx_access
> for PROBE_MEM based load fault handling.

Sorry, just a plain oversight on my end for this one. Thanks for pointing it
out as well.

> The third issue is a bit more interesting:
> 
> ; if (fib6_nh->fib_nh_gw_family) {
> 4375 58: (71) r1 = *(u8 *)(r9 +14)
> 4376 same insn cannot be used with different pointers
> 
> This is because one branch does:
> fib6_nh = &rt->fib6_nh[0];
> while the other does
> fib6_nh = &nh->nh_info->fib6_nh;
> 
> So the load insn 58 in one path uses PTR_TO_BTF_ID and in the other
> PTR_TO_BTF_ID | PTR_NESTED, so reg_type_mismatch bails on seeing src
> != prev.

Ah, that's tricky. Yeah it seems perfectly reasonable to just check the base
type here. As you point out below, check_mem_access() should guard against
invalid accesses.

> I think it's ok to allow this, and we can probably do base_type(src)
> != base_type(prev) here. If the load was not permitted,
> check_mem_access before this should have caught it. The check is
> mostly to prevent doing stuff like PTR_TO_CTX in one path and
> PTR_TO_BTF_ID in the other, because then the convert_ctx_access
> handling would be totally incorrect for the load instruction.
> 
> Hopefully I'm not missing anything.
> 
> But please add some comments about this when updating this particular
> check, it's very easy to forget all this later.

Definitely, will do in v6.

Thanks a lot for the thorough review.

- David
