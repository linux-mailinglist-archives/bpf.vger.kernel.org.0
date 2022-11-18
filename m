Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE41562F7FF
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiKROpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 09:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiKROpq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 09:45:46 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B0B697C7;
        Fri, 18 Nov 2022 06:45:43 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id g10so3511119qkl.6;
        Fri, 18 Nov 2022 06:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGn+d8b2BmM48/8NVQGfBSvOR8nPlmFu+aJV8LvuTTU=;
        b=Qv44nhsgukVWfxMNC73N035NgsfVLQV4doJCTaTsWvjZZtP8iStQsRrdaeAoy/s7VS
         RUVTZswlvbKp5qvMZhTy6/EBU09oIQx4DEZaNjZmFSEv38oCVrVOIzKq0JQogMzlat/l
         fjr8szs+vvaps1FOoRrIdTpzGHqnY1KriNrB+nb8N8pLK2qXBjCjvPItwddWlVpl1TM7
         FLURMNNoUn+zTIsITU4VlKhjag4kqQlFWFbf2pw7RIRG2/bydreeyrgXG2fB75fo9I2l
         bj7K/O+4bM3uYJ6EDKuxUv5N+K7MI36bPgRsKmvkUaBgE0hQlQsKAE4SYDjOqosNN3NJ
         OkVQ==
X-Gm-Message-State: ANoB5pkLidUSBl8XayeFJ6r+KWJQgibe4rG3J4AvPxs6sIP2HMBwfQyT
        hMTYPeBI2LNKu0KQ+NHTe0dyCMebJzGTnxRn
X-Google-Smtp-Source: AA0mqf5YYsJdyKsVEa1IBaKlcL109PwKai7gukeLC4jJDpoE9ML6L8oMm2kvB4bIyqpXQQBRE0cHqA==
X-Received: by 2002:a05:620a:100f:b0:6fa:17e5:b62b with SMTP id z15-20020a05620a100f00b006fa17e5b62bmr6083380qkj.676.1668782742430;
        Fri, 18 Nov 2022 06:45:42 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a0bc300b006fa84082b6dsm2521800qki.128.2022.11.18.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:45:41 -0800 (PST)
Date:   Fri, 18 Nov 2022 08:45:44 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <Y3eamIVUVb6V47LF@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <20221117032402.2356776-2-void@manifault.com>
 <20221118022640.borhn6iy4v2fhl7g@MacBook-Pro-5.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118022640.borhn6iy4v2fhl7g@MacBook-Pro-5.local>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 06:26:40PM -0800, Alexei Starovoitov wrote:
> On Wed, Nov 16, 2022 at 09:24:00PM -0600, David Vernet wrote:
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
> >  Documentation/bpf/kfuncs.rst                  | 30 ++++-----
> >  include/linux/bpf.h                           | 30 +++++++++
> >  include/linux/btf.h                           | 65 ++++++++++++-------
> >  kernel/bpf/btf.c                              | 38 +++++++++--
> >  kernel/bpf/verifier.c                         | 45 ++++++++-----
> >  kernel/trace/bpf_trace.c                      |  2 +-
> >  net/ipv4/bpf_tcp_ca.c                         |  4 +-
> >  tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
> >  .../selftests/bpf/verifier/ref_tracking.c     |  4 +-
> >  9 files changed, 154 insertions(+), 66 deletions(-)
> > 
> > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > index 0f858156371d..67b7e2f46ec6 100644
> > --- a/Documentation/bpf/kfuncs.rst
> > +++ b/Documentation/bpf/kfuncs.rst
> > @@ -137,22 +137,20 @@ KF_ACQUIRE and KF_RET_NULL flags.
> >  --------------------------
> >  
> >  The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
> > -indicates that the all pointer arguments will always have a guaranteed lifetime,
> > -and pointers to kernel objects are always passed to helpers in their unmodified
> > -form (as obtained from acquire kfuncs).
> > -
> > -It can be used to enforce that a pointer to a refcounted object acquired from a
> > -kfunc or BPF helper is passed as an argument to this kfunc without any
> > -modifications (e.g. pointer arithmetic) such that it is trusted and points to
> > -the original object.
> > -
> > -Meanwhile, it is also allowed pass pointers to normal memory to such kfuncs,
> > -but those can have a non-zero offset.
> > -
> > -This flag is often used for kfuncs that operate (change some property, perform
> > -some operation) on an object that was obtained using an acquire kfunc. Such
> > -kfuncs need an unchanged pointer to ensure the integrity of the operation being
> > -performed on the expected object.
> > +indicates that the all pointer arguments are valid, and that all pointers to
> > +BTF objects have been passed in their unmodified form (that is, at a zero
> > +offset, and without having been obtained from walking another pointer).
> > +
> > +There are two types of pointers to kernel objects which are considered "valid":
> > +
> > +1. Pointers which are passed as tracepoint or struct_ops callback arguments.
> > +2. Pointers which were returned from a KF_ACQUIRE or KF_KPTR_GET kfunc.
> > +
> > +Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
> > +KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
> > +
> > +The definition of "valid" pointers is subject to change at any time, and has
> > +absolutely no ABI stability guarantees.
> >  
> >  2.4.6 KF_SLEEPABLE flag
> >  -----------------------
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 54462dd28824..763ae250693e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -524,6 +524,35 @@ enum bpf_type_flag {
> >  	/* Size is known at compile time. */
> >  	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
> >  
> > +	/* PTR was passed from the kernel in a trusted context, and may be
> > +	 * passed to KF_TRUSTED_ARGS kfuncs or BPF helper functions.
> > +	 * Confusingly, this is _not_ the opposite of PTR_UNTRUSTED above.
> > +	 * PTR_UNTRUSTED refers to a kptr that was read directly from a map
> > +	 * without invoking bpf_kptr_xchg(). What we really need to know is
> > +	 * whether a pointer is safe to pass to a kfunc or BPF helper function.
> > +	 * While PTR_UNTRUSTED pointers are unsafe to pass to kfuncs and BPF
> > +	 * helpers, they do not cover all possible instances of unsafe
> > +	 * pointers. For example, a pointer that was obtained from walking a
> > +	 * struct will _not_ get the PTR_UNTRUSTED type modifier, despite the
> > +	 * fact that it may be NULL, invalid, etc. This is due to backwards
> > +	 * compatibility requirements, as this was the behavior that was first
> > +	 * introduced when kptrs were added. The behavior is now considered
> > +	 * deprecated, and PTR_UNTRUSTED will eventually be removed.
> > +	 *
> > +	 * PTR_TRUSTED, on the other hand, is a pointer that the kernel
> > +	 * guarantees to be valid and safe to pass to kfuncs and BPF helpers.
> > +	 * For example, pointers passed to tracepoint arguments are considered
> > +	 * PTR_TRUSTED, as are pointers that are passed to struct_ops
> > +	 * callbacks. As alluded to above, pointers that are obtained from
> > +	 * walking PTR_TRUSTED pointers are _not_ trusted. For example, if a
> > +	 * struct task_struct *task is PTR_TRUSTED, then accessing
> > +	 * task->last_wakee will lose the PTR_TRUSTED modifier when it's stored
> > +	 * in a BPF register. Similarly, pointers passed to certain programs
> > +	 * types such as kretprobes are not guaranteed to be valid, as they may
> > +	 * for example contain an object that was recently freed.
> > +	 */
> > +	PTR_TRUSTED		= BIT(11 + BPF_BASE_TYPE_BITS),
> > +
> >  	__BPF_TYPE_FLAG_MAX,
> >  	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
> >  };
> > @@ -617,6 +646,7 @@ enum bpf_return_type {
> >  	RET_PTR_TO_RINGBUF_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_RINGBUF | RET_PTR_TO_MEM,
> >  	RET_PTR_TO_DYNPTR_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_MEM,
> >  	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
> > +	RET_PTR_TO_BTF_ID_TRUSTED	= PTR_TRUSTED	 | RET_PTR_TO_BTF_ID,
> >  
> >  	/* This must be the last entry. Its purpose is to ensure the enum is
> >  	 * wide enough to hold the higher bits reserved for bpf_type_flag.
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index d80345fa566b..13b969e74d3b 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -17,36 +17,53 @@
> >  #define KF_RELEASE	(1 << 1) /* kfunc is a release function */
> >  #define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
> >  #define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
> > -/* Trusted arguments are those which are meant to be referenced arguments with
> > - * unchanged offset. It is used to enforce that pointers obtained from acquire
> > - * kfuncs remain unmodified when being passed to helpers taking trusted args.
> > +/* Trusted arguments are those which are guaranteed to be valid when passed to
> > + * the kfunc. It is used to enforce that pointers obtained from either acquire
> > + * kfuncs, or from the main kernel on a tracepoint or struct_ops callback
> > + * invocation, remain unmodified when being passed to helpers taking trusted
> > + * args.
> >   *
> > - * Consider
> > - *	struct foo {
> > - *		int data;
> > - *		struct foo *next;
> > - *	};
> > + * Consider, for example, the following new task tracepoint:
> >   *
> > - *	struct bar {
> > - *		int data;
> > - *		struct foo f;
> > - *	};
> > + *	SEC("tp_btf/task_newtask")
> > + *	int BPF_PROG(new_task_tp, struct task_struct *task, u64 clone_flags)
> > + *	{
> > + *		...
> > + *	}
> >   *
> > - *	struct foo *f = alloc_foo(); // Acquire kfunc
> > - *	struct bar *b = alloc_bar(); // Acquire kfunc
> > + * And the following kfunc:
> >   *
> > - * If a kfunc set_foo_data() wants to operate only on the allocated object, it
> > - * will set the KF_TRUSTED_ARGS flag, which will prevent unsafe usage like:
> > + *	BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
> >   *
> > - *	set_foo_data(f, 42);	   // Allowed
> > - *	set_foo_data(f->next, 42); // Rejected, non-referenced pointer
> > - *	set_foo_data(&f->next, 42);// Rejected, referenced, but wrong type
> > - *	set_foo_data(&b->f, 42);   // Rejected, referenced, but bad offset
> > + * All invocations to the kfunc must pass the unmodified, unwalked task:
> >   *
> > - * In the final case, usually for the purposes of type matching, it is deduced
> > - * by looking at the type of the member at the offset, but due to the
> > - * requirement of trusted argument, this deduction will be strict and not done
> > - * for this case.
> > + *	bpf_task_acquire(task);		    // Allowed
> > + *	bpf_task_acquire(task->last_wakee); // Rejected, walked task
> > + *
> > + * Programs may also pass referenced tasks directly to the kfunc:
> > + *
> > + *	struct task_struct *acquired;
> > + *
> > + *	acquired = bpf_task_acquire(task);	// Allowed, same as above
> > + *	bpf_task_acquire(acquired);		// Allowed
> > + *	bpf_task_acquire(task);			// Allowed
> > + *	bpf_task_acquire(acquired->last_wakee); // Rejected, walked task
> > + *
> > + * Programs may _not_, however, pass a task from an arbitrary fentry/fexit, or
> > + * kprobe/kretprobe to the kfunc, as BPF cannot guarantee that all of these
> > + * pointers are guaranteed to be safe. For example, the following BPF program
> > + * would be rejected:
> > + *
> > + * SEC("kretprobe/free_task")
> > + * int BPF_PROG(free_task_probe, struct task_struct *tsk)
> > + * {
> > + *	struct task_struct *acquired;
> > + *
> > + *	acquired = bpf_task_acquire(acquired); // Rejected, not a trusted pointer
> > + *	bpf_task_release(acquired);
> > + *
> > + *	return 0;
> > + * }
> >   */
> >  #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
> >  #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 875355ff3718..8291f2911624 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5579,6 +5579,11 @@ static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
> >  	return nr_args + 1;
> >  }
> >  
> > +static bool prog_type_args_trusted(enum bpf_prog_type prog_type)
> > +{
> > +	return prog_type == BPF_PROG_TYPE_TRACING || prog_type == BPF_PROG_TYPE_STRUCT_OPS;
> > +}
> > +
> >  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> >  		    const struct bpf_prog *prog,
> >  		    struct bpf_insn_access_aux *info)
> > @@ -5722,6 +5727,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> >  	}
> >  
> >  	info->reg_type = PTR_TO_BTF_ID;
> > +	if (prog_type_args_trusted(prog->type))
> > +		info->reg_type |= PTR_TRUSTED;
> > +
> >  	if (tgt_prog) {
> >  		enum bpf_prog_type tgt_type;
> >  
> > @@ -6558,15 +6566,26 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  		/* These register types have special constraints wrt ref_obj_id
> >  		 * and offset checks. The rest of trusted args don't.
> >  		 */
> > -		obj_ptr = reg->type == PTR_TO_CTX || reg->type == PTR_TO_BTF_ID ||
> > +		obj_ptr = reg->type == PTR_TO_CTX ||
> > +			  base_type(reg->type) == PTR_TO_BTF_ID ||
> >  			  reg2btf_ids[base_type(reg->type)];
> >  
> >  		/* Check if argument must be a referenced pointer, args + i has
> >  		 * been verified to be a pointer (after skipping modifiers).
> >  		 * PTR_TO_CTX is ok without having non-zero ref_obj_id.
> > +		 *
> > +		 * All object pointers must be refcounted, other than:
> > +		 * - PTR_TO_CTX
> > +		 * - PTR_TRUSTED pointers
> >  		 */
> > -		if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
> > -			bpf_log(log, "R%d must be referenced\n", regno);
> > +		if (is_kfunc &&
> > +		    trusted_args &&
> > +		    obj_ptr &&
> > +		    base_type(reg->type) != PTR_TO_CTX &&
> > +		    (!(type_flag(reg->type) & PTR_TRUSTED) ||
> > +		     (type_flag(reg->type) & ~PTR_TRUSTED)) &&
> > +		    !reg->ref_obj_id) {
> 
> This is pretty hard to read.
> Is this checking:
> !(reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))
> ?
> 
> Why not to use the above?

Agreed this is more readable, I'll do this for v8 (from a helper as you
suggested).

> Similar in other places... type_flag(reg->type) & ~PTR_TRUSTED is not easy.
> Maybe add a helper that will do
> bool ff(reg)
> { 
>   return reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED);
> }
> 
> ?

Sure, will do.

> > +			bpf_log(log, "R%d must be referenced or trusted\n", regno);
> >  			return -EINVAL;
> >  		}
> >  
> > @@ -6646,8 +6665,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  					i, btf_type_str(t));
> >  				return -EINVAL;
> >  			}
> > -		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
> > -			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
> > +		} else if (is_kfunc && (base_type(reg->type) == PTR_TO_BTF_ID ||
> > +			   (reg2btf_ids[base_type(reg->type)]))) {
> >  			const struct btf_type *reg_ref_t;
> >  			const struct btf *reg_btf;
> >  			const char *reg_ref_tname;
> > @@ -6660,7 +6679,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  				return -EINVAL;
> >  			}
> >  
> > -			if (reg->type == PTR_TO_BTF_ID) {
> > +			if ((type_flag(reg->type) & ~PTR_TRUSTED)) {
> 
> and use that helper here?

I don't think that specific helper would work here because we also need
to verify that no type modifiers other than PTR_TRUSTED are present for
when reg2btf_ids[base_type(reg->type)] is non-NULL.

> 
> > +				bpf_log(log, "kernel function %s arg#%d pointer had unexpected modifiers %d\n",
> > +					func_name, i, type_flag(reg->type));
> > +				return -EINVAL;
> > +			}
> > +
> > +			if (base_type(reg->type) == PTR_TO_BTF_ID) {
> >  				reg_btf = reg->btf;
> >  				reg_ref_id = reg->btf_id;
> >  			} else {
> > @@ -6988,6 +7013,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
> >  			}
> >  
> >  			reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
> > +
> >  			reg->id = ++env->id_gen;
> >  
> >  			continue;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0312d9ce292f..f5b6b1f969d9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -543,7 +543,7 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
> >  static const char *reg_type_str(struct bpf_verifier_env *env,
> >  				enum bpf_reg_type type)
> >  {
> > -	char postfix[16] = {0}, prefix[32] = {0};
> > +	char postfix[16] = {0}, prefix[64] = {0};
> >  	static const char * const str[] = {
> >  		[NOT_INIT]		= "?",
> >  		[SCALAR_VALUE]		= "scalar",
> > @@ -575,16 +575,14 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> >  			strncpy(postfix, "_or_null", 16);
> >  	}
> >  
> > -	if (type & MEM_RDONLY)
> > -		strncpy(prefix, "rdonly_", 32);
> > -	if (type & MEM_RINGBUF)
> > -		strncpy(prefix, "ringbuf_", 32);
> > -	if (type & MEM_USER)
> > -		strncpy(prefix, "user_", 32);
> > -	if (type & MEM_PERCPU)
> > -		strncpy(prefix, "percpu_", 32);
> > -	if (type & PTR_UNTRUSTED)
> > -		strncpy(prefix, "untrusted_", 32);
> > +	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s",
> > +		 type & MEM_RDONLY ? "rdonly_" : "",
> > +		 type & MEM_RINGBUF ? "ringbuf_" : "",
> > +		 type & MEM_USER ? "user_" : "",
> > +		 type & MEM_PERCPU ? "percpu_" : "",
> > +		 type & PTR_UNTRUSTED ? "untrusted_" : "",
> > +		 type & PTR_TRUSTED ? "trusted_" : ""
> > +	);
> >  
> >  	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
> >  		 prefix, str[base_type(type)], postfix);
> > @@ -3844,7 +3842,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> >  			       struct bpf_reg_state *reg, u32 regno)
> >  {
> >  	const char *targ_name = kernel_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id);
> > -	int perm_flags = PTR_MAYBE_NULL;
> > +	int perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED;
> >  	const char *reg_name = "";
> >  
> >  	/* Only unreferenced case accepts untrusted pointers */
> > @@ -4707,6 +4705,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >  	if (type_flag(reg->type) & PTR_UNTRUSTED)
> >  		flag |= PTR_UNTRUSTED;
> >  
> > +	/* Any pointer obtained from walking a trusted pointer is no longer trusted. */
> > +	flag &= ~PTR_TRUSTED;
> > +
> >  	if (atype == BPF_READ && value_regno >= 0)
> >  		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
> >  
> > @@ -5774,6 +5775,7 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
> >  		PTR_TO_TCP_SOCK,
> >  		PTR_TO_XDP_SOCK,
> >  		PTR_TO_BTF_ID,
> > +		PTR_TO_BTF_ID | PTR_TRUSTED,
> >  	},
> >  	.btf_id = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> >  };
> > @@ -5807,9 +5809,19 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
> >  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
> >  static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
> >  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> > -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> > +static const struct bpf_reg_types btf_ptr_types = {
> > +	.types = {
> > +		PTR_TO_BTF_ID,
> > +		PTR_TO_BTF_ID | PTR_TRUSTED,
> > +	},
> > +};
> >  static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
> > -static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
> > +static const struct bpf_reg_types percpu_btf_ptr_types = {
> > +	.types = {
> > +		PTR_TO_BTF_ID | MEM_PERCPU,
> > +		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,
> > +	}
> > +};
> >  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> >  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > @@ -5897,7 +5909,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >  	return -EACCES;
> >  
> >  found:
> > -	if (reg->type == PTR_TO_BTF_ID) {
> > +	if (base_type(reg->type) == PTR_TO_BTF_ID && !(type_flag(reg->type) & ~PTR_TRUSTED)) {
> >  		/* For bpf_sk_release, it needs to match against first member
> >  		 * 'struct sock_common', hence make an exception for it. This
> >  		 * allows bpf_sk_release to work for multiple socket types.
> > @@ -5973,6 +5985,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  	 * fixed offset.
> >  	 */
> >  	case PTR_TO_BTF_ID:
> > +	case PTR_TO_BTF_ID | PTR_TRUSTED:
> >  		/* When referenced PTR_TO_BTF_ID is passed to release function,
> >  		 * it's fixed offset must be 0.	In the other cases, fixed offset
> >  		 * can be non-zero.
> > @@ -13690,6 +13703,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> >  			break;
> >  		case PTR_TO_BTF_ID:
> >  		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> > +		case PTR_TO_BTF_ID | PTR_TRUSTED:
> > +		case PTR_TO_BTF_ID | PTR_UNTRUSTED | PTR_TRUSTED:
> >  			if (type == BPF_READ) {
> >  				insn->code = BPF_LDX | BPF_PROBE_MEM |
> >  					BPF_SIZE((insn)->code);
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index f2d8d070d024..5b9008bc597b 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -774,7 +774,7 @@ BPF_CALL_0(bpf_get_current_task_btf)
> >  const struct bpf_func_proto bpf_get_current_task_btf_proto = {
> >  	.func		= bpf_get_current_task_btf,
> >  	.gpl_only	= true,
> > -	.ret_type	= RET_PTR_TO_BTF_ID,
> > +	.ret_type	= RET_PTR_TO_BTF_ID_TRUSTED,
> >  	.ret_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
> >  };
> >  
> > diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> > index d15c91de995f..0006b5438ff7 100644
> > --- a/net/ipv4/bpf_tcp_ca.c
> > +++ b/net/ipv4/bpf_tcp_ca.c
> > @@ -61,7 +61,9 @@ static bool bpf_tcp_ca_is_valid_access(int off, int size,
> >  	if (!bpf_tracing_btf_ctx_access(off, size, type, prog, info))
> >  		return false;
> >  
> > -	if (info->reg_type == PTR_TO_BTF_ID && info->btf_id == sock_id)
> > +	if (base_type(info->reg_type) == PTR_TO_BTF_ID &&
> > +	    !(type_flag(info->reg_type) & ~PTR_TRUSTED) &&
> > +	    info->btf_id == sock_id)
> >  		/* promote it to tcp_sock */
> >  		info->btf_id = tcp_sock_id;
> >  
> > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > index e1a937277b54..7ac947f00df4 100644
> > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > @@ -109,7 +109,7 @@
> >  	},
> >  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> >  	.result = REJECT,
> > -	.errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point",
> > +	.errstr = "arg#0 pointer had unexpected modifiers",
> >  	.fixup_kfunc_btf_id = {
> >  		{ "bpf_kfunc_call_test_acquire", 3 },
> >  		{ "bpf_kfunc_call_test_release", 5 },
> > diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > index fd683a32a276..d9367f2894b9 100644
> > --- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > +++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > @@ -142,7 +142,7 @@
> >  	.kfunc = "bpf",
> >  	.expected_attach_type = BPF_LSM_MAC,
> >  	.flags = BPF_F_SLEEPABLE,
> > -	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> > +	.errstr = "arg#0 pointer had unexpected modifiers",
> >  	.fixup_kfunc_btf_id = {
> >  		{ "bpf_lookup_user_key", 2 },
> >  		{ "bpf_key_put", 4 },
> > @@ -163,7 +163,7 @@
> >  	.kfunc = "bpf",
> >  	.expected_attach_type = BPF_LSM_MAC,
> >  	.flags = BPF_F_SLEEPABLE,
> > -	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> > +	.errstr = "arg#0 pointer had unexpected modifiers",
> >  	.fixup_kfunc_btf_id = {
> >  		{ "bpf_lookup_system_key", 1 },
> >  		{ "bpf_key_put", 3 },
> > -- 
> > 2.38.1
> > 
