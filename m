Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E104DBED3
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 06:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiCQF5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 01:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiCQF5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 01:57:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C22CB1BC
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 22:27:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g17so7229646lfh.2
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 22:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWCvtSY49jrATJVKLtY7XWKvLRYtcrtJulzN8PQtMog=;
        b=Vs6ynCpyhbU779uH+L2k5LCsEycwm1QDMxRRvXsL481aAttWJAfZ4mPjSOS38h47st
         Sivp5oexEJakruiv6ieqadzvt8M3kcWEyOTL8wRepPYqVXBCRVQ1Bhw4W0y9XvYJ+F6f
         jeRUgkMNQe3VFkYTQix7fZb+EWPWuL7F8zHyrWjQjCQAxPXQTTyhkBY7iC/Yavx1t41c
         WrlIY76bczmTZFdi01F2UuPQEEgQBrPCopmOZNxJw0y3j7OY0rtrOkBCNbWl/gjVLCj+
         M26EoBJ1RedFMj74aF2ErMujAAPbbeN8EoHVxB3EPCbrRKcGYtF5eVUHSOe1CLnknFhq
         hr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWCvtSY49jrATJVKLtY7XWKvLRYtcrtJulzN8PQtMog=;
        b=uGC/FH56vz2z3wgP9tnLgJiFZO40ytdSmY3L36Nbujh3pGmRjwZ+3XHsJEUdgqROGX
         L38ITmQqOVWzMrz8y6IRACLAjIDyMUSDDGiYdy2acfr8EfDnOnMNe9yHI9dIHUIwrNL3
         WvDEnd1T216DdA9gYS0exn05g2MP1myFxHgJ40yS4j33MBJbbLWPDD5nXHJ/2H0Q/krq
         5o4ZAh+Rkfbjrw2ysq0Wci+N9wq0X3QBB5qWh1wHjyX3gM8u1t8nNGQ5v1goSGIaNmtJ
         qrTYIOGOdr9Aq2ArapPVq0/hy8eZ4KJsmaShq8IFQW5s2rbpqV7TTOrWRWM7rkWMIgG6
         VCjQ==
X-Gm-Message-State: AOAM532I3yoM6RJ64bJEn8htUR3BI7xIAzhPIXOCp3zUvQlvefudi0lf
        /hh57ISXub2V8450ziHDXFXdrxBZ4WjAqQ7mUE4=
X-Google-Smtp-Source: ABdhPJwbW/HXxTKvr4CIhe8IDyQhaqCQBLvRorpb6YN2fxNDmKxNm+wyZduPNxb7+/ImzbliSoCenjCKMrnrK6wdfXY=
X-Received: by 2002:a05:6512:2292:b0:448:b7b7:a5d with SMTP id
 f18-20020a056512229200b00448b7b70a5dmr1821156lfu.288.1647494828413; Wed, 16
 Mar 2022 22:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220316195400.2998326-1-joannekoong@fb.com> <20220317022329.7wpltaqviw45qabl@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220317022329.7wpltaqviw45qabl@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 16 Mar 2022 22:26:57 -0700
Message-ID: <CAJnrk1Z=hX_zayU084mJjd_UDqw4dBkTgoRy+9xGeGoSYfL1TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Enable non-atomic allocations in local storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 7:23 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Mar 16, 2022 at 12:54:00PM -0700, Joanne Koong wrote:
> > From: Joanne Koong <joannelkoong@gmail.com>
> >
> > Currently, local storage memory can only be allocated atomically
> > (GFP_ATOMIC). This restriction is too strict for sleepable bpf
> > programs.
> >
> > In this patch, the verifier detects whether the program is sleepable,
> > and passes the corresponding GFP_KERNEL or GFP_ATOMIC flag as a
> > 5th argument to bpf_task/sk/inode_storage_get. This flag will propagate
> > down to the local storage functions that allocate memory.
> >
> > Please note that bpf_task/sk/inode_storage_update_elem functions are
> > invoked by userspace applications through syscalls. Preemption is
> > disabled before bpf_task/sk/inode_storage_update_elem is called, which
> > means they will always have to allocate memory atomically.
> >
> > The existing local storage selftests cover both the GFP_ATOMIC and the
> > GFP_KERNEL cases in bpf_local_storage_update.
> >
> > v2 <- v1:
> > * Allocate the memory before/after the raw_spin_lock_irqsave, depending
> > on the gfp flags
> > * Rename mem_flags to gfp_flags
> > * Reword the comment "*mem_flags* is set by the bpf verifier" to
> > "*gfp_flags* is a hidden argument provided by the verifier"
> > * Add a sentence to the commit message about existing local storage
> > selftests covering both the GFP_ATOMIC and GFP_KERNEL paths in
> > bpf_local_storage_update.
>
> [ ... ]
>
> >  struct bpf_local_storage_data *
> >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > -                      void *value, u64 map_flags)
> > +                      void *value, u64 map_flags, gfp_t gfp_flags)
> >  {
> >       struct bpf_local_storage_data *old_sdata = NULL;
> > -     struct bpf_local_storage_elem *selem;
> > +     struct bpf_local_storage_elem *selem = NULL;
> >       struct bpf_local_storage *local_storage;
> >       unsigned long flags;
> >       int err;
> > @@ -365,6 +366,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >                    !map_value_has_spin_lock(&smap->map)))
> >               return ERR_PTR(-EINVAL);
> >
> > +     if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
> > +             return ERR_PTR(-EINVAL);
> > +
> >       local_storage = rcu_dereference_check(*owner_storage(smap, owner),
> >                                             bpf_rcu_lock_held());
> >       if (!local_storage || hlist_empty(&local_storage->list)) {
> > @@ -373,11 +377,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >               if (err)
> >                       return ERR_PTR(err);
> >
> > -             selem = bpf_selem_alloc(smap, owner, value, true);
> > +             selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
> >               if (!selem)
> >                       return ERR_PTR(-ENOMEM);
> >
> > -             err = bpf_local_storage_alloc(owner, smap, selem);
> > +             err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
> >               if (err) {
> >                       kfree(selem);
> >                       mem_uncharge(smap, owner, smap->elem_size);
> > @@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >               }
> >       }
> >
> > +     if (gfp_flags == GFP_KERNEL) {
> > +             selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
> I think this new path is not executed by the existing
> "progs/local_storage.c" test which has sleepable lsm prog.  At least a second
> BPF_MAP_TYPE_TASK_STORAGE map (or SK_STORAGE) is needed?
> or there is other selftest covering this new path that I missed?
Thanks for your feedback. I think I'm misunderstanding how the
progs/local_storage.c test and/or local storage works then. Would you
mind explaining why a second map is needed?

This is my (faulty) understanding of what is happening:
1) In "local_storage.c" in "SEC("lsm.s/inode_rename")" there is a call
to bpf_inode_storage_get with the BPF_LOCAL_STORAGE_GET_F_CREATE flag
set, which will call into bpf_local_storage_update (which will create
the local storage + the selem, and put it in the RCU for that
inode_storage_map)

2) Then, further down in the "local_storage.c" file in
"SEC("lsm.s/bprm_committed_creds")", there is another call to
bpf_inode_storage_get on the same inode_storage_map but on a different
inode, also with the BPF_LOCAL_STORAGE_GET_F_CREATE flag set. This
will also call into bpf_local_storage_update.

3) In bpf_local_storage_update from the call in #2, it sees that there
is a local storage associated with this map in the RCU, it tries to
look for the inode but doesn't find it, so it needs to allocate with
GFP_KERNEL a new selem and then update with the new selem.

I just tried out some debug statements locally to test, and it looks
like my analysis of #3 is wrong. I will debug this some more tomorrow
>
> Others lgtm.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
>
> > +             if (!selem)
> > +                     return ERR_PTR(-ENOMEM);
> > +     }
> > +
> >       raw_spin_lock_irqsave(&local_storage->lock, flags);
> >
> >       /* Recheck local_storage->list under local_storage->lock */
