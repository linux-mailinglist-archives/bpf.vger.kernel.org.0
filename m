Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856E6587F1
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiL1Xq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 18:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiL1Xqy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 18:46:54 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5A312762
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 15:46:51 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id s9so13883078qtx.6
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 15:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5oPK794prxK7Z/rpTrAlhq+hPp5gB9oB9VgxQGEo1o=;
        b=CsFgzdVjxG1Qr16mZyPqSFnerKbQiXnORJVNz8REtffJPl8koIZI+POlGsdYBYZ8xu
         o00vxEIaPa1ptkZmxt2Z6U++nWAc5TOfdVh3TL0YeubJSbmSN51kq50ep7B3Icvnz9x6
         i+Aqw69D7ozBSLxE6ytT4CE01bpFvdX751PHQU75AnKpgDv976IQ4nGC+4ZVk9POYv8J
         lP1kGiuRuqoKhbjcf0D5qI/Rh/ZDcUmiXAozERJP4/qvYhKMiSo/Z7VhMbV4z6gvfyzd
         78V5jrNX/VCpLCOkLYkzG6NweJ/teK+C6nNuJDUTcO9BE/mrbspmPfg+9OCPqAAsgneR
         3RrQ==
X-Gm-Message-State: AFqh2ko+CZ9LaKv+TnpXqAzDHp3gTqhVHFrZ6vROt2pVyQbykPyaE49l
        CnCZqtVKzti7uQGhnSH+Dyk=
X-Google-Smtp-Source: AMrXdXt51Fo9kthN5X0Y7J+6e4eXxUOXqEEnBS4gkCL8JnH/gWG+W+g8gCTFCnTYrCf+gN1LZLa2uA==
X-Received: by 2002:ac8:4711:0:b0:3a8:cf9:d33d with SMTP id f17-20020ac84711000000b003a80cf9d33dmr38269563qtp.4.1672271210205;
        Wed, 28 Dec 2022 15:46:50 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8b37])
        by smtp.gmail.com with ESMTPSA id dm28-20020a05620a1d5c00b006e702033b15sm12137472qkb.66.2022.12.28.15.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 15:46:49 -0800 (PST)
Date:   Wed, 28 Dec 2022 17:46:54 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: Migrate release_on_unlock logic
 to non-owning ref semantics
Message-ID: <Y6zVbnwptJT3iSoq@maniforge.lan>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-3-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217082506.1570898-3-davemarchevsky@fb.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 12:24:55AM -0800, Dave Marchevsky wrote:
> This patch introduces non-owning reference semantics to the verifier,
> specifically linked_list API kfunc handling. release_on_unlock logic for
> refs is refactored - with small functional changes - to implement these
> semantics, and bpf_list_push_{front,back} are migrated to use them.
> 
> When a list node is pushed to a list, the program still has a pointer to
> the node:
> 
>   n = bpf_obj_new(typeof(*n));
> 
>   bpf_spin_lock(&l);
>   bpf_list_push_back(&l, n);
>   /* n still points to the just-added node */
>   bpf_spin_unlock(&l);
> 
> What the verifier considers n to be after the push, and thus what can be
> done with n, are changed by this patch.
> 
> Common properties both before/after this patch:
>   * After push, n is only a valid reference to the node until end of
>     critical section
>   * After push, n cannot be pushed to any list
>   * After push, the program can read the node's fields using n
> 
> Before:
>   * After push, n retains the ref_obj_id which it received on
>     bpf_obj_new, but the associated bpf_reference_state's
>     release_on_unlock field is set to true
>     * release_on_unlock field and associated logic is used to implement
>       "n is only a valid ref until end of critical section"
>   * After push, n cannot be written to, the node must be removed from
>     the list before writing to its fields
>   * After push, n is marked PTR_UNTRUSTED
> 
> After:
>   * After push, n's ref is released and ref_obj_id set to 0. The
>     bpf_reg_state's non_owning_ref_lock struct is populated with the
>     currently active lock
>     * non_owning_ref_lock and logic is used to implement "n is only a
>       valid ref until end of critical section"
>   * n can be written to (except for special fields e.g. bpf_list_node,
>     timer, ...)
>   * No special type flag is added to n after push
> 
> Summary of specific implementation changes to achieve the above:
> 
>   * release_on_unlock field, ref_set_release_on_unlock helper, and logic
>     to "release on unlock" based on that field are removed
> 
>   * The anonymous active_lock struct used by bpf_verifier_state is
>     pulled out into a named struct bpf_active_lock.
> 
>   * A non_owning_ref_lock field of type bpf_active_lock is added to
>     bpf_reg_state's PTR_TO_BTF_ID union
> 
>   * Helpers are added to use non_owning_ref_lock to implement non-owning
>     ref semantics as described above
>     * invalidate_non_owning_refs - helper to clobber all non-owning refs
>       matching a particular bpf_active_lock identity. Replaces
>       release_on_unlock logic in process_spin_lock.
>     * ref_set_non_owning_lock - set non_owning_ref_lock for a reg based
>       on current verifier state
>     * ref_convert_owning_non_owning - convert owning reference w/
>       specified ref_obj_id to non-owning references. Setup
>       non_owning_ref_lock for each reg with that ref_obj_id and 0 out
>       its ref_obj_id
> 
>   * New KF_RELEASE_NON_OWN flag is added, to be used in conjunction with
>     KF_RELEASE to indicate that the release arg reg should be converted
>     to non-owning ref
>     * Plain KF_RELEASE would clobber all regs with ref_obj_id matching
>       the release arg reg's. KF_RELEASE_NON_OWN's logic triggers first -
>       doing ref_convert_owning_non_owning on the ref first, which
>       prevents the regs from being clobbered by 0ing out their
>       ref_obj_ids. The bpf_reference_state itself is still released via
>       release_reference as a result of the KF_RELEASE flag.
>     * KF_RELEASE | KF_RELEASE_NON_OWN are added to
>       bpf_list_push_{front,back}
> 
> After these changes, linked_list's "release on unlock" logic continues
> to function as before, except for the semantic differences noted above.
> The patch immediately following this one makes minor changes to
> linked_list selftests to account for the differing behavior.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Hey Dave,

I'm sorry to be chiming in a bit late in the game here, but I only
finally had the time to fully review some of this stuff during the
holiday-lull, and I have a few questions / concerns about the whole
owning vs. non-owning refcount approach we're taking here.

> ---
>  include/linux/bpf.h          |   1 +
>  include/linux/bpf_verifier.h |  39 ++++-----
>  include/linux/btf.h          |  17 ++--
>  kernel/bpf/helpers.c         |   4 +-
>  kernel/bpf/verifier.c        | 164 ++++++++++++++++++++++++-----------
>  5 files changed, 146 insertions(+), 79 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3de24cfb7a3d..f71571bf6adc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -180,6 +180,7 @@ enum btf_field_type {
>  	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
>  	BPF_LIST_HEAD  = (1 << 4),
>  	BPF_LIST_NODE  = (1 << 5),
> +	BPF_GRAPH_NODE_OR_ROOT = BPF_LIST_NODE | BPF_LIST_HEAD,
>  };
>  
>  struct btf_field_kptr {
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 53d175cbaa02..cb417ffbbb84 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -43,6 +43,22 @@ enum bpf_reg_liveness {
>  	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
>  };
>  
> +/* For every reg representing a map value or allocated object pointer,
> + * we consider the tuple of (ptr, id) for them to be unique in verifier
> + * context and conside them to not alias each other for the purposes of
> + * tracking lock state.
> + */
> +struct bpf_active_lock {
> +	/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
> +	 * there's no active lock held, and other fields have no
> +	 * meaning. If non-NULL, it indicates that a lock is held and
> +	 * id member has the reg->id of the register which can be >= 0.
> +	 */
> +	void *ptr;
> +	/* This will be reg->id */
> +	u32 id;
> +};
> +
>  struct bpf_reg_state {
>  	/* Ordering of fields matters.  See states_equal() */
>  	enum bpf_reg_type type;
> @@ -68,6 +84,7 @@ struct bpf_reg_state {
>  		struct {
>  			struct btf *btf;
>  			u32 btf_id;
> +			struct bpf_active_lock non_owning_ref_lock;
>  		};
>  
>  		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> @@ -223,11 +240,6 @@ struct bpf_reference_state {
>  	 * exiting a callback function.
>  	 */
>  	int callback_ref;
> -	/* Mark the reference state to release the registers sharing the same id
> -	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
> -	 * safe to access inside the critical section).
> -	 */
> -	bool release_on_unlock;
>  };
>  
>  /* state of the program:
> @@ -328,21 +340,8 @@ struct bpf_verifier_state {
>  	u32 branches;
>  	u32 insn_idx;
>  	u32 curframe;
> -	/* For every reg representing a map value or allocated object pointer,
> -	 * we consider the tuple of (ptr, id) for them to be unique in verifier
> -	 * context and conside them to not alias each other for the purposes of
> -	 * tracking lock state.
> -	 */
> -	struct {
> -		/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
> -		 * there's no active lock held, and other fields have no
> -		 * meaning. If non-NULL, it indicates that a lock is held and
> -		 * id member has the reg->id of the register which can be >= 0.
> -		 */
> -		void *ptr;
> -		/* This will be reg->id */
> -		u32 id;
> -	} active_lock;
> +
> +	struct bpf_active_lock active_lock;
>  	bool speculative;
>  	bool active_rcu_lock;
>  
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 5f628f323442..8aee3f7f4248 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -15,10 +15,10 @@
>  #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>  
>  /* These need to be macros, as the expressions are used in assembler input */
> -#define KF_ACQUIRE	(1 << 0) /* kfunc is an acquire function */
> -#define KF_RELEASE	(1 << 1) /* kfunc is a release function */
> -#define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
> -#define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
> +#define KF_ACQUIRE		(1 << 0) /* kfunc is an acquire function */
> +#define KF_RELEASE		(1 << 1) /* kfunc is a release function */
> +#define KF_RET_NULL		(1 << 2) /* kfunc returns a pointer that may be NULL */
> +#define KF_KPTR_GET		(1 << 3) /* kfunc returns reference to a kptr */
>  /* Trusted arguments are those which are guaranteed to be valid when passed to
>   * the kfunc. It is used to enforce that pointers obtained from either acquire
>   * kfuncs, or from the main kernel on a tracepoint or struct_ops callback
> @@ -67,10 +67,11 @@
>   *	return 0;
>   * }
>   */
> -#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
> -#define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
> -#define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> -#define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
> +#define KF_TRUSTED_ARGS	(1 << 4) /* kfunc only takes trusted pointer arguments */
> +#define KF_SLEEPABLE		(1 << 5) /* kfunc may sleep */
> +#define KF_DESTRUCTIVE		(1 << 6) /* kfunc performs destructive actions */
> +#define KF_RCU			(1 << 7) /* kfunc only takes rcu pointer arguments */
> +#define KF_RELEASE_NON_OWN	(1 << 8) /* kfunc converts its referenced arg into non-owning ref */

It would be nice if we could come up with new kfunc flag names that
don't have 'RELEASE' in it. As is this is arguably a bit of a leaky
abstraction given that kfunc authors now have to understand a notion of
"releasing", "releasing but keeping a non-owning ref", and "releasing
but it must be a non-owning reference". I know that in [0] you mention
that the notions of owning and non-owning references are entirely
relegated to graph-type maps, but I disagree. More below.

[0]: https://lore.kernel.org/all/20221217082506.1570898-14-davemarchevsky@fb.com/

In general, IMO this muddies the existing, crystal-clear semantics of
BPF object ownership and refcounting. Usually a "weak" or "non-owning"
reference is a shadow of a strong reference, and "using" the weak
reference requires attempting (because it could fail) to temporarily
promote it to a strong reference. If successful, the object's existence
is guaranteed until the weak pointer is demoted back to a weak pointer
and/or the promoted strong pointer is released, and it's perfectly valid
for an object's lifetime to be extended due to a promoted weak pointer
not dropping its reference until after all the other strong pointer
references have been dropped. The key point here is that a pointer's
safety is entirely dictated by whether or not the holder has or is able
to acquire a strong reference, and nothing more.

In contrast, if I understand correctly, in this proposal a "non-owning"
reference means that the object is guaranteed to be valid due to
external factors such as a lock being held on the root node of the
graph, and is used to e.g. signal whether an object has or has not yet
been added as a node to an rbtree or a list. If so, IMO these are
completely separate concepts from refcounting, and I don't think we
should intertwine it with the acquire / release semantics that we
currently use for ensuring object lifetime.

Note that weak references are usually (if not always, at least in my
experience) used to resolve circular dependencies where the reference
would always be leaked if both sides had a strong reference. I don't
think that applies here, where instead we're using "owning reference" to
mean that ownership of the object has not yet been passed to a
graph-type data structure, and "non-owning reference" to mean that the
graph now owns the strong reference, but it's still safe to reference
the object due to it being protected by some external synchronization
mechanism like a lock. There's no danger of a circular dependency here,
we just want to provide consistent API semantics.

If we want to encapsulate notions of "safe due to a lock being held on a
root node", and "pointer hasn't yet been inserted into the graph", I
think we should consider adding some entirely separate abstractions. For
example, something like PTR_GRAPH_STORED on the register type-modifier
side for signaling whether a pointer has already been stored in a graph,
and KF_GRAPH_INSERT, KF_GRAPH_REMOVE type kfunc flags for adding and
removing from graphs respectively. I don't think we'd have to add
anything at all for ensuring pointer safety from the lock being held, as
the verifier should be able to figure out that a pointer that was
inserted with KF_GRAPH_INSERT is safe to reference inside of the locked
region of the lock associated with the root node. The refcnt of the
object isn't relevant at all, it's the association of the root node with
a specific lock.

>  
>  /*
>   * Return the name of the passed struct, if exists, or halt the build if for
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index af30c6cbd65d..e041409779c3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2049,8 +2049,8 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
>  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_list_push_front)
> -BTF_ID_FLAGS(func, bpf_list_push_back)
> +BTF_ID_FLAGS(func, bpf_list_push_front, KF_RELEASE | KF_RELEASE_NON_OWN)
> +BTF_ID_FLAGS(func, bpf_list_push_back, KF_RELEASE | KF_RELEASE_NON_OWN)

I don't think a helper should specify both of these flags together.
IIUC, what this is saying is something along the lines of, "Release the
reference, but rather than actually releasing it, just keep it and
convert it into a non-owning reference". IMO KF_RELEASE should always
mean, exclusively, "I'm releasing a previously-acquired strong reference
to an object", and the expectation should be that the object cannot be
referenced _at all_ afterwards, unless you happen to have another strong
reference.

IMO this is another sign that we should consider going in a different
direction for owning vs.  non-owning references. I don't think this
makes sense from an object-refcounting perspective, but I readily admit
that I could be missing a lot of important context here.

[...]

Thanks,
David
