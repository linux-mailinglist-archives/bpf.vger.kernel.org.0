Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE5630C5C
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 07:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKSGKE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 01:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKSGKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 01:10:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066DA93CF7;
        Fri, 18 Nov 2022 22:10:02 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n17so6767272pgh.9;
        Fri, 18 Nov 2022 22:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNWPUzqWClcq8YGuZn2xHMN0XYPui4Gcalwq6mVzr6k=;
        b=ROHX98a67Z2lzG4+rEaA+HZFUdjushZKfgnMy+htaDCZfYKYGqbJbAJZ/JRD+KnDPx
         2FQRnMPuw5d4etiJNX9UUOK9ApF2V81UKVeK9V40LZR0DHyyYR72rDCoJ3qVQrvSnjyB
         vJ3isk6AKCXZGCu0w3L8YcAD8sCw1FyfcHoju0PAad8Nz5/F9W5yvZwHLWNUARgNWupJ
         a/tPjCsbuUDczz+yc4W/w+QfFMi8oUQPCA8KYMSmJc1r6Uep59n5+tlbbjl0zpJGAT2O
         n6QBHS7qsOpyhQb5rvKki3rL3j/Q0hVqb1FrukI5nmM0+k59+V9qTkAYfcrtNh5o6Rqg
         BVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NNWPUzqWClcq8YGuZn2xHMN0XYPui4Gcalwq6mVzr6k=;
        b=z054LI2XYbGgs2w26ExcEKS44F51mrdTNxkOSpH8Mtaoz8wfVFqjGJZ4yzQBZpeaC2
         qgcAKKw+pbGb4MEjiBF78RpZBB4YvnA48XYp+dI+Wqm7Xb7CNJS3IG7HivbDgUgVm7qN
         eDgi/cw0xHQxmksTPxCMMgHVTnzX31Z0OZI+jIp+SUdyZ6+cd6IuOcpgnxSLl5GKF9fl
         HP1mGpicYbDb/JVtqvKTmkvdajXBkgSPCUH5g7guFk28pomHP5X8tcMdHrRgjsVfof4Q
         q1XEjqOgsFRPnZ2cA9bd7Q/sV1R3tILf7Zxuj34ndNQ7Hhb/wYQKzxns/qLQxMilUba0
         kRCw==
X-Gm-Message-State: ANoB5pnOJVUnTriJ66AJ69lyfFykaZmz40dCYROnAI+XX5sykAYK3BrQ
        NSgB/SJMPbOyDcwsL05QKeWxdlcU088=
X-Google-Smtp-Source: AA0mqf4abuPfHqWQGgr+xyPTYwWXh2eVUPCUX1/HFNhZVPUTuLReldXLnkoHzXMGybEcr3NRPb12bw==
X-Received: by 2002:a62:79c8:0:b0:56e:827d:dcce with SMTP id u191-20020a6279c8000000b0056e827ddccemr11082997pfc.51.1668838201335;
        Fri, 18 Nov 2022 22:10:01 -0800 (PST)
Received: from localhost ([2605:59c8:6f:2810:4972:c93:8645:24f2])
        by smtp.gmail.com with ESMTPSA id s2-20020a632142000000b00460a5c6304dsm3638868pgm.67.2022.11.18.22.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 22:10:00 -0800 (PST)
Date:   Fri, 18 Nov 2022 22:09:59 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, memxor@gmail.com, yhs@fb.com,
        song@kernel.org, sdf@google.com, kpsingh@kernel.org,
        jolsa@kernel.org, haoluo@google.com, tj@kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Message-ID: <637873372bf8d_656da2081@john.notmuch>
In-Reply-To: <20221118183113.ftsafchmurs7copl@MacBook-Pro-5.local>
References: <20221117032402.2356776-1-void@manifault.com>
 <6376a1b12bb4d_4101208d@john.notmuch>
 <Y3atifGs0DM9to8z@maniforge.lan>
 <6376b7822f4df_8c7a208f7@john.notmuch>
 <Y3biwxIq8B5oYdOS@maniforge.lan>
 <6377206bed37e_2063d20878@john.notmuch>
 <Y3ef3Mlzd96iANLm@maniforge.lan>
 <20221118183113.ftsafchmurs7copl@MacBook-Pro-5.local>
Subject: Re: [PATCH bpf-next v7 0/3] Support storing struct task_struct
 objects as kptrs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Fri, Nov 18, 2022 at 09:08:12AM -0600, David Vernet wrote:
> > On Thu, Nov 17, 2022 at 10:04:27PM -0800, John Fastabend wrote:
> > 
> > [...]
> > 
> > > > > And last thing I was checking is because KF_SLEEPABLE is not set
> > > > > this should be blocked from running on sleepable progs which would
> > > > > break the call_rcu in the destructor. Maybe small nit, not sure
> > > > > its worth it but might be nice to annotate the helper description
> > > > > with a note, "will not work on sleepable progs" or something to
> > > > > that effect.
> > > > 
> > > > KF_SLEEPABLE is used to indicate whether the kfunc _itself_ may sleep,
> > > > not whether the calling program can be sleepable. call_rcu() doesn't
> > > > block, so no need to mark the kfunc as KF_SLEEPABLE. The key is that if
> > > > a kfunc is sleepable, non-sleepable programs are not able to call it
> > > > (and this is enforced in the verifier).
> > > 
> > > OK but should these helpers be allowed in sleepable progs? I think
> > > not. What stops this, (using your helpers):
> > > 
> > >   cpu0                                       cpu1
> > >   ----
> > >   v = insert_lookup_task(task)
> > >   kptr = bpf_kptr_xchg(&v->task, NULL);
> > >   if (!kptr)
> > >     return 0;
> > >                                             map_delete_elem()
> > >                                                put_task()
> > >                                                  rcu_call
> > >   do_something_might_sleep()
> > >                                                     put_task_struct
> > >                                                       ... free  
> 
> the free won't happen here, because the kptr on cpu0 holds the refcnt.
> bpf side never does direct free of kptr. It only inc/dec refcnt via kfuncs.
> 
> > >   kptr->[free'd memory]
> > >  
> > > the insert_lookup_task will bump the refcnt on the acquire on map
> > > insert. But the lookup doesn't do anything to the refcnt and the
> 
> lookup from map doesn't touch kptrs in the value.
> just reading v->kptr becomes PTR_UNTRUSTED with probe_mem protection.
> 
> > > map_delete_elem will delete it. We have a check for spin_lock
> > > types to stop them from being in sleepable progs. Did I miss a
> > > similar check for these?
> > 
> > So, in your example above, bpf_kptr_xchg(&v->task, NULL) will atomically
> > xchg the kptr from the map, and so the map_delete_elem() call would fail
> > with (something like) -ENOENT. In general, the semantics are similar to
> > std::unique_ptr::swap() in C++.
> > 
> > FWIW, I think KF_KPTR_GET kfuncs are the more complex / racy kfuncs to
> > reason about. The reason is that we're passing a pointer to the map
> > value containing a kptr directly to the kfunc (with the attempt of
> > acquiring an additional reference if a kptr was already present in the
> > map) rather than doing an xchg which atomically gets us the unique
> > pointer if nobody else xchgs it in first. So with KF_KPTR_GET, someone
> > else could come along and delete the kptr from the map while the kfunc
> > is trying to acquire that additional reference. The race looks something
> > like this:
> > 
> >    cpu0                                       cpu1
> >    ----
> >    v = insert_lookup_task(task)
> >    kptr = bpf_task_kptr_get(&v->task);
> >                                              map_delete_elem()
> >                                                 put_task()
> >                                                   rcu_call
> >                                                      put_task_struct
> >                                                        ... free  
> >    if (!kptr)
> >      /* In this race example, this path will be taken. */
> >      return 0;
> > 
> > The difference is that here, we're not doing an atomic xchg of the kptr
> > out of the map. Instead, we're passing a pointer to the map value
> > containing the kptr directly to bpf_task_kptr_get(), which itself tries
> > to acquire an additional reference on the task to return to the program
> > as a kptr. This is still safe, however, as bpf_task_kptr_get() uses RCU
> > and refcount_inc_not_zero() in the bpf_task_kptr_get() kfunc to ensure
> > that it can't hit a UAF, and that it won't return a dying task to the
> > caller:
> > 
> > /**
> >  * bpf_task_kptr_get - Acquire a reference on a struct task_struct kptr. A task
> >  * kptr acquired by this kfunc which is not subsequently stored in a map, must
> >  * be released by calling bpf_task_release().
> >  * @pp: A pointer to a task kptr on which a reference is being acquired.
> >  */
> > __used noinline
> > struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
> > {
> >         struct task_struct *p;
> > 
> >         rcu_read_lock();
> >         p = READ_ONCE(*pp);
> > 
> > 	/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > 	 * cpu1 could remove the element from the map here, and invoke
> > 	 * put_task_struct_rcu_user(). We're in an RCU read region
> > 	 * though, so the task won't be freed until at the very
> > 	 * earliest, the rcu_read_unlock() below.
> > 	 * >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > 	 */
> > 
> >         if (p && !refcount_inc_not_zero(&p->rcu_users))
> > 		/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > 		 * refcount_inc_not_zero() will return false, as cpu1
> > 		 * deleted the element from the map and dropped its last
> > 		 * refcount. So we just return NULL as the task will be
> > 		 * deleted once an RCU gp has elapsed.
> > 		 * >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > 		 */
> >                 p = NULL;
> >         rcu_read_unlock();
> > 
> >         return p;
> > }
> > 
> > Let me know if that makes sense. This stuff is tricky, and I plan to
> > clearly / thoroughly add it to that kptr docs page once this patch set
> > lands.
> 
> All correct. Probably worth adding this comment directly in bpf_task_kptr_get.

Yes also agree thanks for the details. Spent sometime trying to break
it this event, but didn't find anything.

Thanks.
