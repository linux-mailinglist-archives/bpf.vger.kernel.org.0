Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF262FCD1
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 19:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiKRSbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 13:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242489AbiKRSbT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 13:31:19 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD0A1262D;
        Fri, 18 Nov 2022 10:31:18 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f3so5718567pgc.2;
        Fri, 18 Nov 2022 10:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEtVt7Ap9gNxP97uEUyKEWe7IDoCnngIOs3vo3ozwnY=;
        b=J8VX5yeSohiITeAIfpjvi97NQTjhlBBzeyIVWoK9J0T2o2NHCBvwNY7+ru+6U+9mhq
         F9JmdNbi1gRhyr3hi4dd+6ETUKkmj+sm5rAHMNFHZHwypcV/arPoqggVEqNQr4ApAtlA
         kEV34Ei6RK4UGAF4KW8yDWZeMubalBPXCUh12/jFlrVaOsRpSfVq2vGitGFbBzm+OklJ
         Q/mucqC0B8Wvy2aPQCeH9twMLfDCM7OuKLXobgOUj98Pni2ka4GpzlUT3R+nVAqQimvf
         jaZ0HMXGISiVRgFOseMFEhrr/SkXOvTjK/1b54jzvCaaRvzHnG5jndR5bWgUfjePJSUu
         1TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEtVt7Ap9gNxP97uEUyKEWe7IDoCnngIOs3vo3ozwnY=;
        b=vIBobITWKbOBnk/bz64G/7Gbreifrl+p7K9xDjvUdVYiWpbVITuCGCm6Q2Z60WO4qj
         CaywM7/qTZdMtduvpM4GtEbqnJALDn4h8jLvvtt0IPxqkRN1qlwDRSj334/c9vsh4zFD
         pwMJt83TEwU+eQNvq6fkF6b6brRlZP9F+c2yp3Tl9BsHzZwt74+0iei8PVgTSahbHAxH
         Uq+rSsOo3iF2cCCDIwj47LPo7neTWUCMen+iVnzrE3ySrtVgXYAjyk9N2TaTnCMJZ9H9
         irfOIvRY1bqusKqP100t6YNKSzZa5hbP6oOIJLDeEYZN07HW+V5xgAwqREY5nOOe4UJo
         VeBw==
X-Gm-Message-State: ANoB5pn86sZlEkkIw/llcv4r0hNYdquESM+HxhsUXdbSVjYj9E6Qjejm
        FVjwTd+ZgFXRSRuRs5gcqrA=
X-Google-Smtp-Source: AA0mqf7KtSvnbkWe7mbNo63QoODjpnvMiQrTzC42/RyY61BYHYF6DfLGnHILLxR/E8lL9AAagBztDA==
X-Received: by 2002:a62:16d4:0:b0:572:6b5f:bdc2 with SMTP id 203-20020a6216d4000000b005726b5fbdc2mr9008621pfw.36.1668796277450;
        Fri, 18 Nov 2022 10:31:17 -0800 (PST)
Received: from MacBook-Pro-5.local ([2620:10d:c090:500::4:6663])
        by smtp.gmail.com with ESMTPSA id w68-20020a627b47000000b0057280487af1sm3431900pfc.206.2022.11.18.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:31:16 -0800 (PST)
Date:   Fri, 18 Nov 2022 10:31:13 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, memxor@gmail.com, yhs@fb.com,
        song@kernel.org, sdf@google.com, kpsingh@kernel.org,
        jolsa@kernel.org, haoluo@google.com, tj@kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 0/3] Support storing struct task_struct
 objects as kptrs
Message-ID: <20221118183113.ftsafchmurs7copl@MacBook-Pro-5.local>
References: <20221117032402.2356776-1-void@manifault.com>
 <6376a1b12bb4d_4101208d@john.notmuch>
 <Y3atifGs0DM9to8z@maniforge.lan>
 <6376b7822f4df_8c7a208f7@john.notmuch>
 <Y3biwxIq8B5oYdOS@maniforge.lan>
 <6377206bed37e_2063d20878@john.notmuch>
 <Y3ef3Mlzd96iANLm@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ef3Mlzd96iANLm@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 09:08:12AM -0600, David Vernet wrote:
> On Thu, Nov 17, 2022 at 10:04:27PM -0800, John Fastabend wrote:
> 
> [...]
> 
> > > > And last thing I was checking is because KF_SLEEPABLE is not set
> > > > this should be blocked from running on sleepable progs which would
> > > > break the call_rcu in the destructor. Maybe small nit, not sure
> > > > its worth it but might be nice to annotate the helper description
> > > > with a note, "will not work on sleepable progs" or something to
> > > > that effect.
> > > 
> > > KF_SLEEPABLE is used to indicate whether the kfunc _itself_ may sleep,
> > > not whether the calling program can be sleepable. call_rcu() doesn't
> > > block, so no need to mark the kfunc as KF_SLEEPABLE. The key is that if
> > > a kfunc is sleepable, non-sleepable programs are not able to call it
> > > (and this is enforced in the verifier).
> > 
> > OK but should these helpers be allowed in sleepable progs? I think
> > not. What stops this, (using your helpers):
> > 
> >   cpu0                                       cpu1
> >   ----
> >   v = insert_lookup_task(task)
> >   kptr = bpf_kptr_xchg(&v->task, NULL);
> >   if (!kptr)
> >     return 0;
> >                                             map_delete_elem()
> >                                                put_task()
> >                                                  rcu_call
> >   do_something_might_sleep()
> >                                                     put_task_struct
> >                                                       ... free  

the free won't happen here, because the kptr on cpu0 holds the refcnt.
bpf side never does direct free of kptr. It only inc/dec refcnt via kfuncs.

> >   kptr->[free'd memory]
> >  
> > the insert_lookup_task will bump the refcnt on the acquire on map
> > insert. But the lookup doesn't do anything to the refcnt and the

lookup from map doesn't touch kptrs in the value.
just reading v->kptr becomes PTR_UNTRUSTED with probe_mem protection.

> > map_delete_elem will delete it. We have a check for spin_lock
> > types to stop them from being in sleepable progs. Did I miss a
> > similar check for these?
> 
> So, in your example above, bpf_kptr_xchg(&v->task, NULL) will atomically
> xchg the kptr from the map, and so the map_delete_elem() call would fail
> with (something like) -ENOENT. In general, the semantics are similar to
> std::unique_ptr::swap() in C++.
> 
> FWIW, I think KF_KPTR_GET kfuncs are the more complex / racy kfuncs to
> reason about. The reason is that we're passing a pointer to the map
> value containing a kptr directly to the kfunc (with the attempt of
> acquiring an additional reference if a kptr was already present in the
> map) rather than doing an xchg which atomically gets us the unique
> pointer if nobody else xchgs it in first. So with KF_KPTR_GET, someone
> else could come along and delete the kptr from the map while the kfunc
> is trying to acquire that additional reference. The race looks something
> like this:
> 
>    cpu0                                       cpu1
>    ----
>    v = insert_lookup_task(task)
>    kptr = bpf_task_kptr_get(&v->task);
>                                              map_delete_elem()
>                                                 put_task()
>                                                   rcu_call
>                                                      put_task_struct
>                                                        ... free  
>    if (!kptr)
>      /* In this race example, this path will be taken. */
>      return 0;
> 
> The difference is that here, we're not doing an atomic xchg of the kptr
> out of the map. Instead, we're passing a pointer to the map value
> containing the kptr directly to bpf_task_kptr_get(), which itself tries
> to acquire an additional reference on the task to return to the program
> as a kptr. This is still safe, however, as bpf_task_kptr_get() uses RCU
> and refcount_inc_not_zero() in the bpf_task_kptr_get() kfunc to ensure
> that it can't hit a UAF, and that it won't return a dying task to the
> caller:
> 
> /**
>  * bpf_task_kptr_get - Acquire a reference on a struct task_struct kptr. A task
>  * kptr acquired by this kfunc which is not subsequently stored in a map, must
>  * be released by calling bpf_task_release().
>  * @pp: A pointer to a task kptr on which a reference is being acquired.
>  */
> __used noinline
> struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
> {
>         struct task_struct *p;
> 
>         rcu_read_lock();
>         p = READ_ONCE(*pp);
> 
> 	/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> 	 * cpu1 could remove the element from the map here, and invoke
> 	 * put_task_struct_rcu_user(). We're in an RCU read region
> 	 * though, so the task won't be freed until at the very
> 	 * earliest, the rcu_read_unlock() below.
> 	 * >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> 	 */
> 
>         if (p && !refcount_inc_not_zero(&p->rcu_users))
> 		/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> 		 * refcount_inc_not_zero() will return false, as cpu1
> 		 * deleted the element from the map and dropped its last
> 		 * refcount. So we just return NULL as the task will be
> 		 * deleted once an RCU gp has elapsed.
> 		 * >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> 		 */
>                 p = NULL;
>         rcu_read_unlock();
> 
>         return p;
> }
> 
> Let me know if that makes sense. This stuff is tricky, and I plan to
> clearly / thoroughly add it to that kptr docs page once this patch set
> lands.

All correct. Probably worth adding this comment directly in bpf_task_kptr_get.
