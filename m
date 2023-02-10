Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7994F691FB4
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 14:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjBJNY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 08:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBJNY0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 08:24:26 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5112B60336
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 05:24:25 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q19so4752794edd.2
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 05:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsZfV3ZOwxrFAnvk65v3/yfTEjq4Hgn+bLZsbcn3Eog=;
        b=gKxaxKLF2WOnAxJUgftwqtcS2vuMq5s3ntvpgzyoS6balHdAd1NrTtKk2Fl/UQMzZp
         MEwx/M13G7o5taDs27TaQV0v75onu8xwrP07LtcSZiZe7AegkZ0mPe+lbeK2t2YpN6O6
         DgpQypwjJ/G65m38XVzAWsaFBLWRNVzXsA2piU+9XXLL0wLMccPEh+SdIiaxfSvNeHS1
         EU/t1JThDpl8XraK9vVBcgb+fDdUdiQtZ1PzzWZr5IX0vnPW4byn2T6rWVXVTNDqJiEM
         6fG9kS6Ri/BFGAPbd3yKtcp0mfF+hnL/hNTqYPZafj63VGkjpmbIjyv2wTP8m1FSGBhK
         boig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsZfV3ZOwxrFAnvk65v3/yfTEjq4Hgn+bLZsbcn3Eog=;
        b=T1ZiLA1w5cNsH82+Bti1vy8gILbTrXsuMJyJrRi9gftQ0iblmE34by7t4VHAho42Qw
         gcSTT2EfMKo9g6fBYZGDYHEYyjXuXkA897mFJ/xNHAgtesd5R5yYlBoH+/y7UQUHJNu1
         G45brQ/hCcb5gsyf5c/g8tKLt8dCgQD+BObFPCROJAbABBrbLDwecmXOl6KFbqoARYIu
         ZzZsFJ9ptJXMfTDQqrsc/0Ak+F2vvMH2N2twoyljOFjInwZRcXmtVXxolOQ3yHxqFnrA
         FKy/Z4nSxyap8pzPojN9EU+vp7nrPoRo0bWnz60r3/98bkHAkpVA5eY4L/6oif42J/H5
         3Z8w==
X-Gm-Message-State: AO0yUKVqD4DrxwZujQvfm6nBPR+R1CylAWn4fvkUXzbdjOMvQcmpRvJa
        jKibX/i4SfAC3l1WyoH/4plV8muNqzZfrQ==
X-Google-Smtp-Source: AK7set9UnMu6uJ6V0MSd7sEYtrkogex5a2A/AIo3Yi+y5ACqYiIT3c1Onz/GVNowMFtStnC68HfH1Q==
X-Received: by 2002:a50:cd9b:0:b0:4aa:a0a8:94f8 with SMTP id p27-20020a50cd9b000000b004aaa0a894f8mr15545426edi.26.1676035464741;
        Fri, 10 Feb 2023 05:24:24 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:ed0])
        by smtp.gmail.com with ESMTPSA id u12-20020a50950c000000b004aac44175e7sm2193137eda.12.2023.02.10.05.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:24:24 -0800 (PST)
Date:   Fri, 10 Feb 2023 14:24:13 +0100
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 01/11] bpf: Migrate release_on_unlock logic
 to non-owning ref semantics
Message-ID: <20230210132413.o3nokabu5vk3mtgn@apollo>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-2-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209174144.3280955-2-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 09, 2023 at 06:41:34PM CET, Dave Marchevsky wrote:
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
> After these changes, linked_list's "release on unlock" logic continues
> to function as before, except for the semantic differences noted above.
> The patch immediately following this one makes minor changes to
> linked_list selftests to account for the differing behavior.
>

I think you need to squash sefltest changes into this one to ensure clean
bisection.

> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf.h          |   1 +
>  include/linux/bpf_verifier.h |  39 ++++-----
>  kernel/bpf/verifier.c        | 164 +++++++++++++++++++++++++----------
>  3 files changed, 136 insertions(+), 68 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 35c18a98c21a..9a79ebe1774c 100644
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
> index aa83de1fe755..7b5fbb66446c 100644
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

As Alexei said, it'd be better to merge patch 1 and patch 2. But if not, we
should probably increase the size of 'raw' member in this change.

>
>  		struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> @@ -226,11 +243,6 @@ struct bpf_reference_state {
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
> [...]
> +static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
> +				       struct bpf_active_lock *lock)
> +{
> +	struct bpf_func_state *unused;
> +	struct bpf_reg_state *reg;
> +
> +	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
> +		if (reg->non_owning_ref_lock.ptr &&
> +		    reg->non_owning_ref_lock.ptr == lock->ptr &&
> +		    reg->non_owning_ref_lock.id == lock->id)
> +			__mark_reg_unknown(env, reg);

Probably better to do:

	if (!env->allow_ptr_leaks)
		__mark_reg_not_init(...);
	else
		__mark_reg_unknown(...);
