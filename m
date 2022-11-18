Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE762F8E0
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 16:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiKRPIS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 10:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbiKRPIR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 10:08:17 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A1140EF;
        Fri, 18 Nov 2022 07:08:16 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id z17so3551002qki.11;
        Fri, 18 Nov 2022 07:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vchearp9WS1QYhrT0ExBOsKGzWpettAVm8UGsd0BETI=;
        b=Ff3h4ArePwDYN1xRuKlThjZBJO+/FYWTbRmsPc0Vpw+XAa0h79DlBpSJhg3Sfx08eh
         PE6nq7Eucup8e1aebvKu4d/ijGYBMRPrshZFkGCIykriQK+KZpnWH3Eu8i8ZpHpApm+D
         rugDbofIPOX1feN46Ft8heenpbQqEf4fH3S4PClOHv4L7WOBxKXwT3NvZfa7037MO45G
         52oxv5sE1/j+PAcRzvtUjm4C5YG8ZFM4bhBVPhaxu7yVLjHjMBZ3cRaDxrADyQELPqTB
         oWeR7zlvh4ZB30PFm8cxdtPOEHNkcg1M2uwMNsOhCEaBiPjP5kGLLUPZ/JcuNuq+3xYN
         6sVg==
X-Gm-Message-State: ANoB5pkT8FQBXPLRjZDyjMJ52zjg/MfaFYRogh0Fo4VsZq7NkP1FCv5N
        EASxiisEhFMLHVTFUY5m7Cw=
X-Google-Smtp-Source: AA0mqf4dnWpW0TRHSAnW2PBBFLo5pcg7LY4zqqDppwpcN25sekLxKlgL6ETMgD+oYSz+IJqtdFwe7w==
X-Received: by 2002:a37:9a0e:0:b0:6fa:b56e:38b2 with SMTP id c14-20020a379a0e000000b006fab56e38b2mr6233053qke.521.1668784095114;
        Fri, 18 Nov 2022 07:08:15 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a401200b006fa2b1c3c1esm2557495qko.58.2022.11.18.07.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 07:08:14 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:08:12 -0600
From:   David Vernet <void@manifault.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com, kpsingh@kernel.org,
        jolsa@kernel.org, haoluo@google.com, tj@kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 0/3] Support storing struct task_struct
 objects as kptrs
Message-ID: <Y3ef3Mlzd96iANLm@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <6376a1b12bb4d_4101208d@john.notmuch>
 <Y3atifGs0DM9to8z@maniforge.lan>
 <6376b7822f4df_8c7a208f7@john.notmuch>
 <Y3biwxIq8B5oYdOS@maniforge.lan>
 <6377206bed37e_2063d20878@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6377206bed37e_2063d20878@john.notmuch>
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

On Thu, Nov 17, 2022 at 10:04:27PM -0800, John Fastabend wrote:

[...]

> > > And last thing I was checking is because KF_SLEEPABLE is not set
> > > this should be blocked from running on sleepable progs which would
> > > break the call_rcu in the destructor. Maybe small nit, not sure
> > > its worth it but might be nice to annotate the helper description
> > > with a note, "will not work on sleepable progs" or something to
> > > that effect.
> > 
> > KF_SLEEPABLE is used to indicate whether the kfunc _itself_ may sleep,
> > not whether the calling program can be sleepable. call_rcu() doesn't
> > block, so no need to mark the kfunc as KF_SLEEPABLE. The key is that if
> > a kfunc is sleepable, non-sleepable programs are not able to call it
> > (and this is enforced in the verifier).
> 
> OK but should these helpers be allowed in sleepable progs? I think
> not. What stops this, (using your helpers):
> 
>   cpu0                                       cpu1
>   ----
>   v = insert_lookup_task(task)
>   kptr = bpf_kptr_xchg(&v->task, NULL);
>   if (!kptr)
>     return 0;
>                                             map_delete_elem()
>                                                put_task()
>                                                  rcu_call
>   do_something_might_sleep()
>                                                     put_task_struct
>                                                       ... free  
>   kptr->[free'd memory]
>  
> the insert_lookup_task will bump the refcnt on the acquire on map
> insert. But the lookup doesn't do anything to the refcnt and the
> map_delete_elem will delete it. We have a check for spin_lock
> types to stop them from being in sleepable progs. Did I miss a
> similar check for these?

So, in your example above, bpf_kptr_xchg(&v->task, NULL) will atomically
xchg the kptr from the map, and so the map_delete_elem() call would fail
with (something like) -ENOENT. In general, the semantics are similar to
std::unique_ptr::swap() in C++.

FWIW, I think KF_KPTR_GET kfuncs are the more complex / racy kfuncs to
reason about. The reason is that we're passing a pointer to the map
value containing a kptr directly to the kfunc (with the attempt of
acquiring an additional reference if a kptr was already present in the
map) rather than doing an xchg which atomically gets us the unique
pointer if nobody else xchgs it in first. So with KF_KPTR_GET, someone
else could come along and delete the kptr from the map while the kfunc
is trying to acquire that additional reference. The race looks something
like this:

   cpu0                                       cpu1
   ----
   v = insert_lookup_task(task)
   kptr = bpf_task_kptr_get(&v->task);
                                             map_delete_elem()
                                                put_task()
                                                  rcu_call
                                                     put_task_struct
                                                       ... free  
   if (!kptr)
     /* In this race example, this path will be taken. */
     return 0;

The difference is that here, we're not doing an atomic xchg of the kptr
out of the map. Instead, we're passing a pointer to the map value
containing the kptr directly to bpf_task_kptr_get(), which itself tries
to acquire an additional reference on the task to return to the program
as a kptr. This is still safe, however, as bpf_task_kptr_get() uses RCU
and refcount_inc_not_zero() in the bpf_task_kptr_get() kfunc to ensure
that it can't hit a UAF, and that it won't return a dying task to the
caller:

/**
 * bpf_task_kptr_get - Acquire a reference on a struct task_struct kptr. A task
 * kptr acquired by this kfunc which is not subsequently stored in a map, must
 * be released by calling bpf_task_release().
 * @pp: A pointer to a task kptr on which a reference is being acquired.
 */
__used noinline
struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
{
        struct task_struct *p;

        rcu_read_lock();
        p = READ_ONCE(*pp);

	/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	 * cpu1 could remove the element from the map here, and invoke
	 * put_task_struct_rcu_user(). We're in an RCU read region
	 * though, so the task won't be freed until at the very
	 * earliest, the rcu_read_unlock() below.
	 * >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	 */

        if (p && !refcount_inc_not_zero(&p->rcu_users))
		/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		 * refcount_inc_not_zero() will return false, as cpu1
		 * deleted the element from the map and dropped its last
		 * refcount. So we just return NULL as the task will be
		 * deleted once an RCU gp has elapsed.
		 * >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		 */
                p = NULL;
        rcu_read_unlock();

        return p;
}

Let me know if that makes sense. This stuff is tricky, and I plan to
clearly / thoroughly add it to that kptr docs page once this patch set
lands.
