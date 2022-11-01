Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997D5614204
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 01:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKAACp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 20:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiKAACo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 20:02:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27242A1B6;
        Mon, 31 Oct 2022 17:02:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so17352693pjc.3;
        Mon, 31 Oct 2022 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=INeo9qS6g2cO0Ga6Q7McZ2M/KfHyQluDKuMfnalxZQk=;
        b=ByCkrNGDTEx4mxjTwkvUZ3tT9Ae2Fq8n313F1J9fE5qC7le0MpkGNR/Bhdh3j+MeXf
         owrSscAUOQQrmhD8r0z5rGCenKMIsCNhHK+8eNw2t30hD95HiRcLi2wKfQ1dPooRFDZQ
         wc3ffJT8i/UYzI1vw5blihVYLPL6cWaVVlMbiAPRwlvk06eroDcwlp4D26oPfcjL2wwz
         XiOj7KVA9Pvdovqo41SXFiUWWYIIQ8MXgxwOw+EdxOwVAGFXS6js3XCLvFEhCcFpqLme
         AFKaAYxSJixqwlwGQTEeq1xYE2p9R85FI32TJNSDglWtOlOFZj+PlFXZKfeHa2zV0TA/
         BF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INeo9qS6g2cO0Ga6Q7McZ2M/KfHyQluDKuMfnalxZQk=;
        b=f53bcpgXyCR8X++jXgeUUBGvOnfXLwCYiVtZ4oF3oT3d5SiUmcWGuSTs12iOuqb4OF
         R1CiAMseoIcfn2dmgYCtajqVluYzj+rtWnCiuAIzbTvARj4JcswTHlFueFOJCaU9jJjv
         AE+nYRZxbKzmpcLhco5LAY5UbNpiyIsyu+8kcr+yFM5nddW23ei7gywKf7QBS92rfZmb
         42uLgWuYtfE5qgCVL0Zxec2Wm09EC9Q8TuUCp8U0n6xwkmQlyov9Rm3UxjyB7xNWdbfG
         V/kkr3+Js/6tkNP+lb/+q/4DfymcQU4jvSZrWVBN529qJu6nZpsN/Dv6d/6vQ3wIcYO/
         Q+Eg==
X-Gm-Message-State: ACrzQf2Dwwo3Geb/P0d47ufLV9+XxVa6lRzCSXAGt66ON8oTx0z+dMoS
        HtEg/kIfeM6MdCWdEgiqCOo=
X-Google-Smtp-Source: AMsMyM4TXdbOInSC2/0MYLMB66tIITZo2jLN0lFShM6Oh2lC7ucVA0FZkGnjGEwk320QhHLAC4YD4w==
X-Received: by 2002:a17:903:41c3:b0:186:dfe6:f25 with SMTP id u3-20020a17090341c300b00186dfe60f25mr16249396ple.47.1667260962346;
        Mon, 31 Oct 2022 17:02:42 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:500::6:7b96])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b00172973d3cd9sm4968884pln.55.2022.10.31.17.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:02:41 -0700 (PDT)
Date:   Mon, 31 Oct 2022 17:02:39 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <20221101000239.pbbmym4mbdbmnzjd@macbook-pro-4.dhcp.thefacebook.com>
References: <20221020222416.3415511-1-void@manifault.com>
 <20221020222416.3415511-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020222416.3415511-2-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 05:24:14PM -0500, David Vernet wrote:
> Kfuncs currently support specifying the KF_TRUSTED_ARGS flag to signal
> to the verifier that it should enforce that a BPF program passes it a
> "safe", trusted pointer. Currently, "safe" means that the pointer is
> either PTR_TO_CTX, or is refcounted. There may be cases, however, where
> the kernel passes a BPF program a safe / trusted pointer to an object
> that the BPF program wishes to use as a kptr, but because the object
> does not yet have a ref_obj_id from the perspective of the verifier, the
> program would be unable to pass it to a KF_ACQUIRE | KF_TRUSTED_ARGS
> kfunc.
> 
> The solution is to expand the set of pointers that are considered
> trusted according to KF_TRUSTED_ARGS, so that programs can invoke kfuncs
> with these pointers without getting rejected by the verifier.
> 
> There is already a PTR_UNTRUSTED flag that is set in some scenarios,
> such as when a BPF program reads a kptr directly from a map
> without performing a bpf_kptr_xchg() call. These pointers of course can
> and should be rejected by the verifier. Unfortunately, however,
> PTR_UNTRUSTED does not cover all the cases for safety that need to
> be addressed to adequately protect kfuncs. Specifically, pointers
> obtained by a BPF program "walking" a struct are _not_ considered
> PTR_UNTRUSTED according to BPF. For example, say that we were to add a
> kfunc called bpf_task_acquire(), with KF_ACQUIRE | KF_TRUSTED_ARGS, to
> acquire a struct task_struct *. If we only used PTR_UNTRUSTED to signal
> that a task was unsafe to pass to a kfunc, the verifier would mistakenly
> allow the following unsafe BPF program to be loaded:
> 
> SEC("tp_btf/task_newtask")
> int BPF_PROG(unsafe_acquire_task,
>              struct task_struct *task,
>              u64 clone_flags)
> {
>         struct task_struct *acquired, *nested;
> 
>         nested = task->last_wakee;
> 
>         /* Would not be rejected by the verifier. */
>         acquired = bpf_task_acquire(nested);
>         if (!acquired)
>                 return 0;
> 
>         bpf_task_release(acquired);
>         return 0;
> }
> 
> To address this, this patch defines a new type flag called PTR_WALKED
> which tracks whether a PTR_TO_BTF_ID pointer was retrieved from walking
> a struct. A pointer passed directly from the kernel begins with
> (PTR_WALKED & type) == 0, meaning of course that it is not obtained from
> walking another struct. Any pointer received from walking that object,
> however, would inherit that flag and become a walked pointer.
> 
> Additionally, because some kfuncs still only want BPF programs to be
> able to send them an arg that they "own" (i.e. which they own a refcount
> on) another kfunc arg flag called KF_OWNED_ARGS is added which is
> identical to KF_TRUSTED_ARGS, but imposes the stricter requirement that
> the arg must also have a refcount.
> 
> A subsequent patch will add kfuncs for storing a task kfunc as a kptr,
> and then another patch will validate this feature by ensuring that the
> verifier rejects a kfunc invocation with a nested pointer.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  Documentation/bpf/kfuncs.rst                  | 50 ++++++++++----
>  include/linux/bpf.h                           |  6 ++
>  include/linux/btf.h                           | 57 ++++++++++++++--
>  kernel/bpf/btf.c                              | 18 ++++-
>  kernel/bpf/verifier.c                         | 66 ++++++++++++++-----
>  net/bpf/test_run.c                            |  2 +-
>  net/netfilter/nf_conntrack_bpf.c              |  8 +--
>  net/netfilter/nf_nat_bpf.c                    |  2 +-
>  .../selftests/bpf/prog_tests/map_kptr.c       |  2 +-
>  tools/testing/selftests/bpf/verifier/calls.c  |  4 +-
>  .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
>  11 files changed, 169 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 0f858156371d..8e2825150a8d 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -137,30 +137,54 @@ KF_ACQUIRE and KF_RET_NULL flags.
>  --------------------------
>  
>  The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
> -indicates that the all pointer arguments will always have a guaranteed lifetime,
> -and pointers to kernel objects are always passed to helpers in their unmodified
> -form (as obtained from acquire kfuncs).
> +indicates that the all pointer arguments will always have a guaranteed
> +lifetime, and pointers to kernel objects are always passed to helpers in their
> +unmodified form (either as passed by the main kernel, or as obtained from
> +acquire kfuncs).
>  
> -It can be used to enforce that a pointer to a refcounted object acquired from a
> -kfunc or BPF helper is passed as an argument to this kfunc without any
> -modifications (e.g. pointer arithmetic) such that it is trusted and points to
> -the original object.
> +It can be used to enforce that a safe pointer passed to the program by the
> +kernel, or a refcounted object acquired from a kfunc or BPF helper, is passed
> +as an argument to this kfunc without any modifications (e.g. pointer
> +arithmetic) such that it is trusted and points to the original object.
>  
>  Meanwhile, it is also allowed pass pointers to normal memory to such kfuncs,
>  but those can have a non-zero offset.
>  
> -This flag is often used for kfuncs that operate (change some property, perform
> -some operation) on an object that was obtained using an acquire kfunc. Such
> -kfuncs need an unchanged pointer to ensure the integrity of the operation being
> -performed on the expected object.
> +This flag is often used for kfuncs that receive a trusted pointer from the
> +kernel, and which do not require a reference to be held by the program. For
> +example, if there's a kernel object that was allocated by the main kernel, and
> +which the BPF program wishes to store in a map as a kptr, KF_TRUSTED_ARGS can
> +be used to ensure that the pointer is actually a trusted kernel pointer before
> +a reference is acquired on it in a KF_ACQUIRE kfunc.
> +
> +2.4.6 KF_OWNED_ARGS flag
> +------------------------
> +
> +The KF_OWNED_ARGS flag is identical to the KF_TRUSTED_ARGS flag, though it is
> +more restrictive in that it also requires the BPF program to hold a reference
> +on the object.
>  
> -2.4.6 KF_SLEEPABLE flag
> +In other words, it can be used to enforce that a pointer to a refcounted object
> +acquired from a kfunc or BPF helper is passed as an argument to this kfunc
> +without any modifications (e.g. pointer arithmetic) such that it is trusted and
> +points to the original object that was allocated or owned by the BPF program.
> +
> +This flag is often used for kfuncs that operate (change some property, perform
> +some operation) on an object that was obtained using an acquire kfunc. For
> +example, if an acquire kfunc allocates an object on behalf of a program,
> +KF_OWNED_ARGS would be an appropriate flag to specify for other kfuncs which
> +allow the program to mutate that object. KF_TRUSTED_ARGS, on the other hand,
> +would likely not be sufficiently restrictive as the kfunc does not want to
> +allow the BPF program to mutate another instance of the same object type which
> +was allocated by the main kernel.
> +
> +2.4.7 KF_SLEEPABLE flag
>  -----------------------
>  
>  The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can only
>  be called by sleepable BPF programs (BPF_F_SLEEPABLE).
>  
> -2.4.7 KF_DESTRUCTIVE flag
> +2.4.8 KF_DESTRUCTIVE flag
>  --------------------------
>  
>  The KF_DESTRUCTIVE flag is used to indicate functions calling which is
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9e7d46d16032..ccdbefd72a95 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -457,6 +457,12 @@ enum bpf_type_flag {
>  	/* Size is known at compile time. */
>  	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
>  
> +	/* PTR was obtained from walking a struct. This is used with
> +	 * PTR_TO_BTF_ID to determine whether the pointer is safe to pass to a
> +	 * kfunc with KF_TRUSTED_ARGS.
> +	 */
> +	PTR_WALKED		= BIT(11 + BPF_BASE_TYPE_BITS),
> +
>  	__BPF_TYPE_FLAG_MAX,
>  	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
>  };
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f9aababc5d78..7f5a438196a2 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -17,9 +17,48 @@
>  #define KF_RELEASE	(1 << 1) /* kfunc is a release function */
>  #define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
>  #define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
> -/* Trusted arguments are those which are meant to be referenced arguments with
> - * unchanged offset. It is used to enforce that pointers obtained from acquire
> - * kfuncs remain unmodified when being passed to helpers taking trusted args.
> +/* Trusted arguments are those which are meant to be guaranteed valid
> + * arguments, with an unchanged offset. It is used to enforce that pointers
> + * obtained from either acquire kfuncs or the main kernel remain unmodified
> + * when being passed to helpers taking trusted args.
> + *
> + * Consider, for example, the following task tracepoint:
> + *
> + *	SEC("tp_btf/task_newtask")
> + *	int BPF_PROG(new_task_tp, struct task_struct *task, u64 clone_flags)
> + *	{
> + *		...
> + *	}
> + *
> + * And the following kfunc:
> + *
> + *	BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> + *
> + * All invocations to the kfunc must pass the unmodified, unwalked task:
> + *
> + *	bpf_task_acquire(task);		    // Allowed
> + *	bpf_task_acquire(task->last_wakee); // Rejected, walked task
> + *
> + * Users may also pass referenced tasks directly to the kfunc:
> + *
> + *	struct task_struct *acquired;
> + *
> + *	acquired = bpf_task_acquire(task);	// Allowed, same as above
> + *	bpf_task_acquire(acquired);		// Allowed
> + *	bpf_task_acquire(task);			// Allowed
> + *	bpf_task_acquire(acquired->last_wakee); // Rejected, walked task
> + *
> + * If users wish to only allow referenced objects to be passed to a kfunc, they
> + * may instead specify the KF_OWNED_ARGS flag.
> + */
> +#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
> +#define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
> +#define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> +/* Owned arguments are similar to trusted arguments, but are even more
> + * restrictive.  Owned arguments are arguments which are "owned" by the BPF
> + * program, meaning it has acquired a reference to the object via an acquire
> + * kfunc. Just as with trusted arguments, the verifier enforces that owned
> + * arguments have an unchanged offset when they're passed to kfuncs.

I don't think the kfunc writers will be able to use KF_OWNED_ARGS vs KF_TRUSTED_ARGS properly.
refcnt-ed or not is not a property that they should worry about.
Let's evaluate this patch set without KF_OWNED_ARGS and bpf_ct_* are still KF_TRUSTED_ARGS
and the other side of the verifier is relaxed to accept non-refcnted PTR_TO_BTF_ID
into kfunc.
What kind of bpf prog will be able to pass 'struct nf_conn___init *' into these bpf_ct_* ?
We've introduced nf_conn___init vs nf_conf specifically to express the relationship
between allocated nf_conn and other nf_conn-s via different types.
Why is this not enough?

I prefer to keep only one flag KF_TRUSTED_ARGS that kfunc-s need to use
and eventually make all kfuncs KF_TRUSTED_ARGS by default and remove that flag.

Separately...
I think there was a plan to strengthen PTR_TO_BTF_ID and apply PTR_UNTRUSTED.
This PTR_WALKED looks like new thing.
If we really need it PTR_TO_BTF_ID should be allowlisted instead of denylisted
as PTR_WALKED is doing.
I mean we can introduce PTR_TRUSTED and add this flag to return value
of bpf_get_current_task_btf() and arguments of tracepoints.
As soon as any ptr walking is done we can clear PTR_TRUSTED to keep
backward compat behavior of PTR_TO_BTF_ID.
PTR_WALKED is sort-of doing the same, but not conservative enough.
Too many things produce PTR_TO_BTF_ID. Auditing it all is challenging.

I might have missed earlier discussions on this patch set. Apologies if so.
