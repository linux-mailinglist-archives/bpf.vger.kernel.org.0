Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D482D658F44
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiL2QyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 11:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2QyF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 11:54:05 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52121DE3
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 08:54:03 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id a16so15375236qtw.10
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 08:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQtSHGhMmLPEEfdv7EfXhMXlMfO2cNbr7DGzMdKuYkg=;
        b=4oMvLpJGHXH2PQutV77gRdY9uQZmjnSDxBUmvRT4JdDaiaYk+GmC3ee1LIAzwaGsVS
         kfB48BssXtVzAeO+9scJJuVzJT55P5GQoJt6rdCPLJJopS+6jRmRGsVOgOatS6ZSN+5X
         F6gNN7J6qVIf+PU9Gw+ebcLAYzcPbOADEd5+Iek6prZH1rSs5DTVYR9JP+aimd0+P1/m
         C7Ho9YfHMFFfynXiDbONA9ZyZsuPs/KKcjS66a+iz3hf41mri7/6b1u3+RSU1XJ9KPx3
         edfRGuZ6tpOt3rYooDJ1pvkVYalGa/clyT6Q8sMW25g5Wu4G7MIkarCgsJbd2V89AoT7
         k+HA==
X-Gm-Message-State: AFqh2kqA0JWGdcxkuva4hBv2JopllcHYPpUQMte4/k9K7O50AFbRU/UF
        detfQej+yUOMRPOrqj969II=
X-Google-Smtp-Source: AMrXdXsgPbJj3vRxqpDieECTsgGnQAWqDf+8Jvn9iQK0l/XOjgBfz679ZOswz2Qk/OnW8QKKlaI12w==
X-Received: by 2002:a05:622a:22aa:b0:39c:da21:6c0e with SMTP id ay42-20020a05622a22aa00b0039cda216c0emr40671841qtb.16.1672332841916;
        Thu, 29 Dec 2022 08:54:01 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:290a])
        by smtp.gmail.com with ESMTPSA id t140-20020a37aa92000000b006fc8fc061f7sm13263033qke.129.2022.12.29.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:54:01 -0800 (PST)
Date:   Thu, 29 Dec 2022 10:54:06 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: Migrate release_on_unlock logic
 to non-owning ref semantics
Message-ID: <Y63GLqZil9l1NzY4@maniforge.lan>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-3-davemarchevsky@fb.com>
 <20221229035600.m43ayhidfisbl4sq@MacBook-Pro-6.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229035600.m43ayhidfisbl4sq@MacBook-Pro-6.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 28, 2022 at 07:56:00PM -0800, Alexei Starovoitov wrote:
> On Sat, Dec 17, 2022 at 12:24:55AM -0800, Dave Marchevsky wrote:
> > This patch introduces non-owning reference semantics to the verifier,
> > specifically linked_list API kfunc handling. release_on_unlock logic for
> > refs is refactored - with small functional changes - to implement these
> > semantics, and bpf_list_push_{front,back} are migrated to use them.
> > 
> > When a list node is pushed to a list, the program still has a pointer to
> > the node:
> > 
> >   n = bpf_obj_new(typeof(*n));
> > 
> >   bpf_spin_lock(&l);
> >   bpf_list_push_back(&l, n);
> >   /* n still points to the just-added node */
> >   bpf_spin_unlock(&l);
> > 
> > What the verifier considers n to be after the push, and thus what can be
> > done with n, are changed by this patch.
> > 
> > Common properties both before/after this patch:
> >   * After push, n is only a valid reference to the node until end of
> >     critical section
> >   * After push, n cannot be pushed to any list
> >   * After push, the program can read the node's fields using n
> 
> correct.
> 
> > Before:
> >   * After push, n retains the ref_obj_id which it received on
> >     bpf_obj_new, but the associated bpf_reference_state's
> >     release_on_unlock field is set to true
> >     * release_on_unlock field and associated logic is used to implement
> >       "n is only a valid ref until end of critical section"
> >   * After push, n cannot be written to, the node must be removed from
> >     the list before writing to its fields
> >   * After push, n is marked PTR_UNTRUSTED
> 
> yep
> 
> > After:
> >   * After push, n's ref is released and ref_obj_id set to 0. The
> >     bpf_reg_state's non_owning_ref_lock struct is populated with the
> >     currently active lock
> >     * non_owning_ref_lock and logic is used to implement "n is only a
> >       valid ref until end of critical section"
> >   * n can be written to (except for special fields e.g. bpf_list_node,
> >     timer, ...)
> >   * No special type flag is added to n after push
> 
> yep.
> Great summary.
> 
> > Summary of specific implementation changes to achieve the above:
> > 
> >   * release_on_unlock field, ref_set_release_on_unlock helper, and logic
> >     to "release on unlock" based on that field are removed
> 
> +1 
> 
> >   * The anonymous active_lock struct used by bpf_verifier_state is
> >     pulled out into a named struct bpf_active_lock.
> ...
> >   * A non_owning_ref_lock field of type bpf_active_lock is added to
> >     bpf_reg_state's PTR_TO_BTF_ID union
> 
> not great. see below.
> 
> >   * Helpers are added to use non_owning_ref_lock to implement non-owning
> >     ref semantics as described above
> >     * invalidate_non_owning_refs - helper to clobber all non-owning refs
> >       matching a particular bpf_active_lock identity. Replaces
> >       release_on_unlock logic in process_spin_lock.
> 
> +1
> 
> >     * ref_set_non_owning_lock - set non_owning_ref_lock for a reg based
> >       on current verifier state
> 
> +1
> 
> >     * ref_convert_owning_non_owning - convert owning reference w/
> >       specified ref_obj_id to non-owning references. Setup
> >       non_owning_ref_lock for each reg with that ref_obj_id and 0 out
> >       its ref_obj_id
> 
> +1
> 
> >   * New KF_RELEASE_NON_OWN flag is added, to be used in conjunction with
> >     KF_RELEASE to indicate that the release arg reg should be converted
> >     to non-owning ref
> >     * Plain KF_RELEASE would clobber all regs with ref_obj_id matching
> >       the release arg reg's. KF_RELEASE_NON_OWN's logic triggers first -
> >       doing ref_convert_owning_non_owning on the ref first, which
> >       prevents the regs from being clobbered by 0ing out their
> >       ref_obj_ids. The bpf_reference_state itself is still released via
> >       release_reference as a result of the KF_RELEASE flag.
> >     * KF_RELEASE | KF_RELEASE_NON_OWN are added to
> >       bpf_list_push_{front,back}
> 
> And this bit is confusing and not generalizable.

+1 on both counts. If we want to make it generalizable, I think the only
way to do would be to generalize it across different graph map types.
For example, to have kfunc flags like KF_GRAPH_INSERT and
KF_GRAPH_REMOVE which signal to the verifier that "for this graph-type
map which has a spin-lock associated with its root node that I expect to
be held, I've {inserted, removed} the node {to, from} the graph, so
adjust the refcnt / pointer type accordingly and then clean up when the
lock is dropped."

I don't see any reason to add kfunc flags for that though, as the fact
that the pointer in question refers to a node that has a root node that
has a lock associated with it is already itself a special-case scenario.
I think we should just special-case these kfuncs in the verifier as
"graph-type" kfuncs in some static global array(s).  That's probably
less error prone anyways, and I don't see the typical kfunc writer ever
needing to do this.

> As David noticed in his reply KF_RELEASE_NON_OWN is not a great name.
> It's hard to come up with a good name and it won't be generic anyway.
> The ref_convert_owning_non_owning has to be applied to a specific arg.
> The function itself is not KF_RELEASE in the current definition of it.
> The combination of KF_RELEASE|KF_RELEASE_NON_OWN is something new
> that should have been generic, but doesn't really work this way.
> In the next patches rbtree_root/node still has to have all the custom
> logic.
> KF_RELEASE_NON_OWN by itself is a nonsensical flag.

IMO if a flag doesn't make any sense on its own, or even possibly if it
needs to be mutually exclusive with one or more other flags, it is
probably never a correct building block. Even KF_TRUSTED_ARGS doesn't
really make sense, as it's redundant if KF_RCU is specified. This is
fine though, as IIUC our long-term plan is to get rid of KF_TRUSTED_ARGS
and make it the default behavior for all kfuncs (not trying to hijack
this thread with a tangential discussion about KF_TRUSTED_ARGS, just
using this as an opportunity to point out something to keep in mind as
we continue to add kfunc flags down the road).

> Only combination of KF_RELEASE|KF_RELEASE_NON_OWN sort-of kinda makes
> sense, but still hard to understand what releases what.

I agree and I think this is an important point. IMO it is a worse
tradeoff to try to generalize this by complicating the definition of a
reference than it is to keep the refcounting APIs straightforward and
well defined. As a basic building block, having an owning refcount
should mean one thing: that the object will not be destroyed and is safe
to dereference. When you start mixing in these graph-specific notions of
references meaning different things in specific contexts, it compromises
that and makes the API significantly less usable and extensible.

For example, at some point we may decide to add something like a
kptr_weak_ref which would function exactly like an std::weak_ptr, except
of course that it would wrap a kptr_ref instead of an std::shared_ptr.
IMO something like that is a more natural and generalizable building
block that cleanly complements refcounting as it exists today.

> More below.
> 
> > After these changes, linked_list's "release on unlock" logic continues
> > to function as before, except for the semantic differences noted above.
> > The patch immediately following this one makes minor changes to
> > linked_list selftests to account for the differing behavior.
> > 
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
> >  include/linux/bpf.h          |   1 +
> >  include/linux/bpf_verifier.h |  39 ++++-----
> >  include/linux/btf.h          |  17 ++--
> >  kernel/bpf/helpers.c         |   4 +-
> >  kernel/bpf/verifier.c        | 164 ++++++++++++++++++++++++-----------
> >  5 files changed, 146 insertions(+), 79 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 3de24cfb7a3d..f71571bf6adc 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -180,6 +180,7 @@ enum btf_field_type {
> >  	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
> >  	BPF_LIST_HEAD  = (1 << 4),
> >  	BPF_LIST_NODE  = (1 << 5),
> > +	BPF_GRAPH_NODE_OR_ROOT = BPF_LIST_NODE | BPF_LIST_HEAD,

Can you update the rest of the elements here to keep common indentation?

> >  };
> >  
> >  struct btf_field_kptr {
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 53d175cbaa02..cb417ffbbb84 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -43,6 +43,22 @@ enum bpf_reg_liveness {
> >  	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
> >  };
> >  
> > +/* For every reg representing a map value or allocated object pointer,
> > + * we consider the tuple of (ptr, id) for them to be unique in verifier
> > + * context and conside them to not alias each other for the purposes of
> > + * tracking lock state.
> > + */
> > +struct bpf_active_lock {
> > +	/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
> > +	 * there's no active lock held, and other fields have no
> > +	 * meaning. If non-NULL, it indicates that a lock is held and
> > +	 * id member has the reg->id of the register which can be >= 0.
> > +	 */
> > +	void *ptr;
> > +	/* This will be reg->id */
> > +	u32 id;
> > +};
> > +
> >  struct bpf_reg_state {
> >  	/* Ordering of fields matters.  See states_equal() */
> >  	enum bpf_reg_type type;
> > @@ -68,6 +84,7 @@ struct bpf_reg_state {
> >  		struct {
> >  			struct btf *btf;
> >  			u32 btf_id;
> > +			struct bpf_active_lock non_owning_ref_lock;
> 
> In your other email you argue that pointer should be enough.
> I suspect that won't be correct.
> See fixes that Andrii did in states_equal() and regsafe().
> In particular:
>         if (!!old->active_lock.id != !!cur->active_lock.id)
>                 return false;
> 
>         if (old->active_lock.id &&
>             !check_ids(old->active_lock.id, cur->active_lock.id, env->idmap_scratch))
>                 return false;
> 
> We have to do the comparison of this new ID via idmap as well.
> 
> I think introduction of struct bpf_active_lock  and addition of it
> to bpf_reg_state is overkill.
> Here we can add 'u32 non_own_ref_obj_id;' only and compare it via idmap in regsafe().
> I'm guessing you didn't like my 'active_lock_id' suggestion. Fine.
> non_own_ref_obj_id would match existing ref_obj_id at least.
> 
> >  		};
> >  
> >  		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> > @@ -223,11 +240,6 @@ struct bpf_reference_state {
> >  	 * exiting a callback function.
> >  	 */
> >  	int callback_ref;
> > -	/* Mark the reference state to release the registers sharing the same id
> > -	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
> > -	 * safe to access inside the critical section).
> > -	 */
> > -	bool release_on_unlock;
> >  };
> >  
> >  /* state of the program:
> > @@ -328,21 +340,8 @@ struct bpf_verifier_state {
> >  	u32 branches;
> >  	u32 insn_idx;
> >  	u32 curframe;
> > -	/* For every reg representing a map value or allocated object pointer,
> > -	 * we consider the tuple of (ptr, id) for them to be unique in verifier
> > -	 * context and conside them to not alias each other for the purposes of
> > -	 * tracking lock state.
> > -	 */
> > -	struct {
> > -		/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
> > -		 * there's no active lock held, and other fields have no
> > -		 * meaning. If non-NULL, it indicates that a lock is held and
> > -		 * id member has the reg->id of the register which can be >= 0.
> > -		 */
> > -		void *ptr;
> > -		/* This will be reg->id */
> > -		u32 id;
> > -	} active_lock;
> 
> I would keep it as-is.
> 
> > +
> > +	struct bpf_active_lock active_lock;
> >  	bool speculative;
> >  	bool active_rcu_lock;
> >  
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 5f628f323442..8aee3f7f4248 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -15,10 +15,10 @@
> >  #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
> >  
> >  /* These need to be macros, as the expressions are used in assembler input */
> > -#define KF_ACQUIRE	(1 << 0) /* kfunc is an acquire function */
> > -#define KF_RELEASE	(1 << 1) /* kfunc is a release function */
> > -#define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
> > -#define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
> > +#define KF_ACQUIRE		(1 << 0) /* kfunc is an acquire function */
> > +#define KF_RELEASE		(1 << 1) /* kfunc is a release function */
> > +#define KF_RET_NULL		(1 << 2) /* kfunc returns a pointer that may be NULL */
> > +#define KF_KPTR_GET		(1 << 3) /* kfunc returns reference to a kptr */
> >  /* Trusted arguments are those which are guaranteed to be valid when passed to
> >   * the kfunc. It is used to enforce that pointers obtained from either acquire
> >   * kfuncs, or from the main kernel on a tracepoint or struct_ops callback
> > @@ -67,10 +67,11 @@
> >   *	return 0;
> >   * }
> >   */
> > -#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
> > -#define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
> > -#define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> > -#define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
> > +#define KF_TRUSTED_ARGS	(1 << 4) /* kfunc only takes trusted pointer arguments */
> > +#define KF_SLEEPABLE		(1 << 5) /* kfunc may sleep */
> > +#define KF_DESTRUCTIVE		(1 << 6) /* kfunc performs destructive actions */
> > +#define KF_RCU			(1 << 7) /* kfunc only takes rcu pointer arguments */
> > +#define KF_RELEASE_NON_OWN	(1 << 8) /* kfunc converts its referenced arg into non-owning ref */
> 
> No need for this flag.
> 
> >  /*
> >   * Return the name of the passed struct, if exists, or halt the build if for
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index af30c6cbd65d..e041409779c3 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2049,8 +2049,8 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
> >  #endif
> >  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
> > -BTF_ID_FLAGS(func, bpf_list_push_front)
> > -BTF_ID_FLAGS(func, bpf_list_push_back)
> > +BTF_ID_FLAGS(func, bpf_list_push_front, KF_RELEASE | KF_RELEASE_NON_OWN)
> > +BTF_ID_FLAGS(func, bpf_list_push_back, KF_RELEASE | KF_RELEASE_NON_OWN)
> 
> No need for this.
> 
> >  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 824e2242eae5..84b0660e2a76 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -190,6 +190,10 @@ struct bpf_verifier_stack_elem {
> >  
> >  static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
> >  static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
> > +static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
> > +				       struct bpf_active_lock *lock);
> > +static int ref_set_non_owning_lock(struct bpf_verifier_env *env,
> > +				   struct bpf_reg_state *reg);
> >  
> >  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
> >  {
> > @@ -931,6 +935,9 @@ static void print_verifier_state(struct bpf_verifier_env *env,
> >  				verbose_a("id=%d", reg->id);
> >  			if (reg->ref_obj_id)
> >  				verbose_a("ref_obj_id=%d", reg->ref_obj_id);
> > +			if (reg->non_owning_ref_lock.ptr)
> > +				verbose_a("non_own_id=(%p,%d)", reg->non_owning_ref_lock.ptr,
> > +					  reg->non_owning_ref_lock.id);
> >  			if (t != SCALAR_VALUE)
> >  				verbose_a("off=%d", reg->off);
> >  			if (type_is_pkt_pointer(t))
> > @@ -4820,7 +4827,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >  			return -EACCES;
> >  		}
> >  
> > -		if (type_is_alloc(reg->type) && !reg->ref_obj_id) {
> > +		if (type_is_alloc(reg->type) && !reg->ref_obj_id &&
> > +		    !reg->non_owning_ref_lock.ptr) {
> >  			verbose(env, "verifier internal error: ref_obj_id for allocated object must be non-zero\n");
> >  			return -EFAULT;
> >  		}
> > @@ -5778,9 +5786,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
> >  			cur->active_lock.ptr = btf;
> >  		cur->active_lock.id = reg->id;
> >  	} else {
> > -		struct bpf_func_state *fstate = cur_func(env);
> >  		void *ptr;
> > -		int i;
> >  
> >  		if (map)
> >  			ptr = map;
> > @@ -5796,25 +5802,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
> >  			verbose(env, "bpf_spin_unlock of different lock\n");
> >  			return -EINVAL;
> >  		}
> > -		cur->active_lock.ptr = NULL;
> > -		cur->active_lock.id = 0;
> >  
> > -		for (i = fstate->acquired_refs - 1; i >= 0; i--) {
> > -			int err;
> > +		invalidate_non_owning_refs(env, &cur->active_lock);
> 
> +1
> 
> > -			/* Complain on error because this reference state cannot
> > -			 * be freed before this point, as bpf_spin_lock critical
> > -			 * section does not allow functions that release the
> > -			 * allocated object immediately.
> > -			 */
> > -			if (!fstate->refs[i].release_on_unlock)
> > -				continue;
> > -			err = release_reference(env, fstate->refs[i].id);
> > -			if (err) {
> > -				verbose(env, "failed to release release_on_unlock reference");
> > -				return err;
> > -			}
> > -		}
> > +		cur->active_lock.ptr = NULL;
> > +		cur->active_lock.id = 0;
> 
> +1
> 
> >  	}
> >  	return 0;
> >  }
> > @@ -6273,6 +6265,23 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >  	return 0;
> >  }
> >  
> > +static struct btf_field *
> > +reg_find_field_offset(const struct bpf_reg_state *reg, s32 off, u32 fields)
> > +{
> > +	struct btf_field *field;
> > +	struct btf_record *rec;
> > +
> > +	rec = reg_btf_record(reg);
> > +	if (!reg)
> > +		return NULL;
> > +
> > +	field = btf_record_find(rec, off, fields);
> > +	if (!field)
> > +		return NULL;
> > +
> > +	return field;
> > +}
> 
> Doesn't look like that this helper is really necessary.
> 
> > +
> >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  			   const struct bpf_reg_state *reg, int regno,
> >  			   enum bpf_arg_type arg_type)
> > @@ -6294,6 +6303,18 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  		 */
> >  		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
> >  			return 0;
> > +
> > +		if (type == (PTR_TO_BTF_ID | MEM_ALLOC) && reg->off) {
> > +			if (reg_find_field_offset(reg, reg->off, BPF_GRAPH_NODE_OR_ROOT))
> > +				return __check_ptr_off_reg(env, reg, regno, true);
> > +
> > +			verbose(env, "R%d must have zero offset when passed to release func\n",
> > +				regno);
> > +			verbose(env, "No graph node or root found at R%d type:%s off:%d\n", regno,
> > +				kernel_type_name(reg->btf, reg->btf_id), reg->off);
> > +			return -EINVAL;
> > +		}
> 
> This bit is only necessary if we mark push_list as KF_RELEASE.
> Just don't add this mark and drop above.
> 
> > +
> >  		/* Doing check_ptr_off_reg check for the offset will catch this
> >  		 * because fixed_off_ok is false, but checking here allows us
> >  		 * to give the user a better error message.
> > @@ -7055,6 +7076,20 @@ static int release_reference(struct bpf_verifier_env *env,
> >  	return 0;
> >  }
> >  
> > +static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
> > +				       struct bpf_active_lock *lock)
> > +{
> > +	struct bpf_func_state *unused;
> > +	struct bpf_reg_state *reg;
> > +
> > +	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
> > +		if (reg->non_owning_ref_lock.ptr &&
> > +		    reg->non_owning_ref_lock.ptr == lock->ptr &&
> > +		    reg->non_owning_ref_lock.id == lock->id)
> 
> I think the lock.ptr = lock->ptr comparison is unnecessary to invalidate things.
> We're under active spin_lock here. All regs were checked earlier and id keeps incrementing.
> So we can just do 'u32 non_own_ref_obj_id'.
> 
> > +			__mark_reg_unknown(env, reg);
> > +	}));
> > +}
> > +
> >  static void clear_caller_saved_regs(struct bpf_verifier_env *env,
> >  				    struct bpf_reg_state *regs)
> >  {
> > @@ -8266,6 +8301,11 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
> >  	return meta->kfunc_flags & KF_RELEASE;
> >  }
> >  
> > +static bool is_kfunc_release_non_own(struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +	return meta->kfunc_flags & KF_RELEASE_NON_OWN;
> > +}
> > +
> 
> No need.
> 
> >  static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
> >  {
> >  	return meta->kfunc_flags & KF_TRUSTED_ARGS;
> > @@ -8651,38 +8691,55 @@ static int process_kf_arg_ptr_to_kptr(struct bpf_verifier_env *env,
> >  	return 0;
> >  }
> >  
> > -static int ref_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
> > +static int ref_set_non_owning_lock(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> > -	struct bpf_func_state *state = cur_func(env);
> > +	struct bpf_verifier_state *state = env->cur_state;
> > +
> > +	if (!state->active_lock.ptr) {
> > +		verbose(env, "verifier internal error: ref_set_non_owning_lock w/o active lock\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	if (reg->non_owning_ref_lock.ptr) {
> > +		verbose(env, "verifier internal error: non_owning_ref_lock already set\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	reg->non_owning_ref_lock.id = state->active_lock.id;
> > +	reg->non_owning_ref_lock.ptr = state->active_lock.ptr;
> > +	return 0;
> > +}
> > +
> > +static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_obj_id)
> > +{
> > +	struct bpf_func_state *state, *unused;
> >  	struct bpf_reg_state *reg;
> >  	int i;
> >  
> > -	/* bpf_spin_lock only allows calling list_push and list_pop, no BPF
> > -	 * subprogs, no global functions. This means that the references would
> > -	 * not be released inside the critical section but they may be added to
> > -	 * the reference state, and the acquired_refs are never copied out for a
> > -	 * different frame as BPF to BPF calls don't work in bpf_spin_lock
> > -	 * critical sections.
> > -	 */
> > +	state = cur_func(env);
> > +
> >  	if (!ref_obj_id) {
> > -		verbose(env, "verifier internal error: ref_obj_id is zero for release_on_unlock\n");
> > +		verbose(env, "verifier internal error: ref_obj_id is zero for "
> > +			     "owning -> non-owning conversion\n");
> >  		return -EFAULT;
> >  	}
> > +
> >  	for (i = 0; i < state->acquired_refs; i++) {
> > -		if (state->refs[i].id == ref_obj_id) {
> > -			if (state->refs[i].release_on_unlock) {
> > -				verbose(env, "verifier internal error: expected false release_on_unlock");
> > -				return -EFAULT;
> > +		if (state->refs[i].id != ref_obj_id)
> > +			continue;
> > +
> > +		/* Clear ref_obj_id here so release_reference doesn't clobber
> > +		 * the whole reg
> > +		 */
> > +		bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
> > +			if (reg->ref_obj_id == ref_obj_id) {
> > +				reg->ref_obj_id = 0;
> > +				ref_set_non_owning_lock(env, reg);
> 
> +1 except ref_set_... name doesn't quite fit. reg_set_... is more accurate, no?
> and probably reg_set_non_own_ref_obj_id() ?
> Or just open code it?
> 
> >  			}
> > -			state->refs[i].release_on_unlock = true;
> > -			/* Now mark everyone sharing same ref_obj_id as untrusted */
> > -			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> > -				if (reg->ref_obj_id == ref_obj_id)
> > -					reg->type |= PTR_UNTRUSTED;
> > -			}));
> > -			return 0;
> > -		}
> > +		}));
> > +		return 0;
> >  	}
> > +
> >  	verbose(env, "verifier internal error: ref state missing for ref_obj_id\n");
> >  	return -EFAULT;
> >  }
> > @@ -8817,7 +8874,6 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> >  {
> >  	const struct btf_type *et, *t;
> >  	struct btf_field *field;
> > -	struct btf_record *rec;
> >  	u32 list_node_off;
> >  
> >  	if (meta->btf != btf_vmlinux ||
> > @@ -8834,9 +8890,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> >  		return -EINVAL;
> >  	}
> >  
> > -	rec = reg_btf_record(reg);
> >  	list_node_off = reg->off + reg->var_off.value;
> > -	field = btf_record_find(rec, list_node_off, BPF_LIST_NODE);
> > +	field = reg_find_field_offset(reg, list_node_off, BPF_LIST_NODE);
> >  	if (!field || field->offset != list_node_off) {
> >  		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
> >  		return -EINVAL;
> > @@ -8861,8 +8916,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> >  			btf_name_by_offset(field->list_head.btf, et->name_off));
> >  		return -EINVAL;
> >  	}
> > -	/* Set arg#1 for expiration after unlock */
> > -	return ref_set_release_on_unlock(env, reg->ref_obj_id);
> > +
> > +	return 0;
> 
> and here we come to the main point.
> Can you just call
> ref_convert_owning_non_owning(env, reg->ref_obj_id) and release_reference() here?
> Everything will be so much simpler, no?
> 
> >  }
> >  
> >  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
> > @@ -9132,11 +9187,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  			    int *insn_idx_p)
> >  {
> >  	const struct btf_type *t, *func, *func_proto, *ptr_type;
> > +	u32 i, nargs, func_id, ptr_type_id, release_ref_obj_id;
> >  	struct bpf_reg_state *regs = cur_regs(env);
> >  	const char *func_name, *ptr_type_name;
> >  	bool sleepable, rcu_lock, rcu_unlock;
> >  	struct bpf_kfunc_call_arg_meta meta;
> > -	u32 i, nargs, func_id, ptr_type_id;
> >  	int err, insn_idx = *insn_idx_p;
> >  	const struct btf_param *args;
> >  	const struct btf_type *ret_t;
> > @@ -9223,7 +9278,18 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
> >  	 */
> >  	if (meta.release_regno) {
> > -		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
> > +		err = 0;
> > +		release_ref_obj_id = regs[meta.release_regno].ref_obj_id;
> > +
> > +		if (is_kfunc_release_non_own(&meta))
> > +			err = ref_convert_owning_non_owning(env, release_ref_obj_id);
> > +		if (err) {
> > +			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning failed\n",
> > +				func_name, func_id);
> > +			return err;
> > +		}
> > +
> > +		err = release_reference(env, release_ref_obj_id);
> 
> and this bit won't be needed.
> and no need to guess in patch 1 which arg has to be released and converted to non_own.
> 
> >  		if (err) {
> >  			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
> >  				func_name, func_id);
> > -- 
> > 2.30.2
> > 
