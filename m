Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587804DD085
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 23:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiCQWJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 18:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCQWJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 18:09:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1186F329AE
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 15:08:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b28so11303664lfc.4
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGamtKyrfgLFxbZY8oE7yL8f+PF1XMRWIA3JmZfK0lE=;
        b=AdzgWooYjKs6NDZJrVV9aMMb2PbZ0Thk9xk2yeF9W5EWWdMJSI0yxx2mXXvw0ne+dO
         4VGgXqclQ21sAjAFZIAtKlW6xW9rCO+hjrTOBompuKD08VXVcqo4HNqC+7+spagJMjW8
         bH8edRj/wob9oy2ePviH+2NED+3aWm3aE8q9eHnEF5EZSVoqEOqnMlZKKNhaoUq4CnPV
         Ih4K5JxmrI1s+Qsfe4S3gIiYlSRW4WlOXxy//RZQoLg1bn3OXfsvyBnCQwp7WqKMOJGu
         05hmElD+Q8b2US4dzdv+xlbHQDikmmfc3+7sxez//Lg9g+Z28J1H55L65Ik9F5dUqddx
         7rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGamtKyrfgLFxbZY8oE7yL8f+PF1XMRWIA3JmZfK0lE=;
        b=DhhJQS1yftuvXtzF+/5nmWdha5MOeiHlmgLb61vic5B/K3GrgNXDchDm1jGBnY5Ni8
         gsPUBpYOCYAcO6AuN73EbiScP4ib2an4KmMxOo+y2Pfe6zVoeNVoAtzw80GXytx/aPDt
         QXzr9gkvcQjpl2n6OeJBlaNLsFF9nGCwtOu727/CUjt2zf6Nfkf/CZS/a14u0Qtsyguf
         nCKsyde8g/2WBxIJ+6gTfZ/mJVWVkCm8RzsmHV1KtbWOVLe6UqJihv6/9+F0wk4n2Pc5
         4b7West+4rp1fvMylY0mbQhY6ORW1ZnORY54xGm9x5IXzS9oaIZV9+cAxQX3UjcUatQB
         3+aA==
X-Gm-Message-State: AOAM530Ze+sJ9VL5yKhOe381NGT5JBtT/CRTs9B0wFy4UdLS1/NYzqlJ
        NJBUxqTOlMCVhzqLoXJgEmc+xsekjd5uFrCiuS8=
X-Google-Smtp-Source: ABdhPJxB1hfHAIiCZZIX5gfUSRu4K7rCAqdb848EXu0hAir7PSmnwZ7ZVXKCneSxK3INBAoc+ScGhW9dj7qDS1m5upg=
X-Received: by 2002:a05:6512:36d4:b0:449:f469:2353 with SMTP id
 e20-20020a05651236d400b00449f4692353mr3670508lfs.437.1647554897167; Thu, 17
 Mar 2022 15:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220316195400.2998326-1-joannekoong@fb.com> <20220317022329.7wpltaqviw45qabl@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1Z=hX_zayU084mJjd_UDqw4dBkTgoRy+9xGeGoSYfL1TQ@mail.gmail.com> <20220317180431.nfdo27ux65w53xlv@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220317180431.nfdo27ux65w53xlv@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 17 Mar 2022 15:08:06 -0700
Message-ID: <CAJnrk1YtwjWCZFOYNZNx9nxWyukk9z7tPGEzXVDLeKoP6xhSyg@mail.gmail.com>
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

On Thu, Mar 17, 2022 at 11:04 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Mar 16, 2022 at 10:26:57PM -0700, Joanne Koong wrote:
> > On Wed, Mar 16, 2022 at 7:23 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Wed, Mar 16, 2022 at 12:54:00PM -0700, Joanne Koong wrote:
> > > > From: Joanne Koong <joannelkoong@gmail.com>
> > > >
> > > > Currently, local storage memory can only be allocated atomically
> > > > (GFP_ATOMIC). This restriction is too strict for sleepable bpf
> > > > programs.
> > > >
> > > > In this patch, the verifier detects whether the program is sleepable,
> > > > and passes the corresponding GFP_KERNEL or GFP_ATOMIC flag as a
> > > > 5th argument to bpf_task/sk/inode_storage_get. This flag will propagate
> > > > down to the local storage functions that allocate memory.
> > > >
> > > > Please note that bpf_task/sk/inode_storage_update_elem functions are
> > > > invoked by userspace applications through syscalls. Preemption is
> > > > disabled before bpf_task/sk/inode_storage_update_elem is called, which
> > > > means they will always have to allocate memory atomically.
> > > >
> > > > The existing local storage selftests cover both the GFP_ATOMIC and the
> > > > GFP_KERNEL cases in bpf_local_storage_update.
> > > >
> > > > v2 <- v1:
> > > > * Allocate the memory before/after the raw_spin_lock_irqsave, depending
> > > > on the gfp flags
> > > > * Rename mem_flags to gfp_flags
> > > > * Reword the comment "*mem_flags* is set by the bpf verifier" to
> > > > "*gfp_flags* is a hidden argument provided by the verifier"
> > > > * Add a sentence to the commit message about existing local storage
> > > > selftests covering both the GFP_ATOMIC and GFP_KERNEL paths in
> > > > bpf_local_storage_update.
> > >
> > > [ ... ]
> > >
> > > >  struct bpf_local_storage_data *
> > > >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > -                      void *value, u64 map_flags)
> > > > +                      void *value, u64 map_flags, gfp_t gfp_flags)
> > > >  {
> > > >       struct bpf_local_storage_data *old_sdata = NULL;
> > > > -     struct bpf_local_storage_elem *selem;
> > > > +     struct bpf_local_storage_elem *selem = NULL;
> > > >       struct bpf_local_storage *local_storage;
> > > >       unsigned long flags;
> > > >       int err;
> > > > @@ -365,6 +366,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > >                    !map_value_has_spin_lock(&smap->map)))
> > > >               return ERR_PTR(-EINVAL);
> > > >
> > > > +     if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
> > > > +             return ERR_PTR(-EINVAL);
> > > > +
> > > >       local_storage = rcu_dereference_check(*owner_storage(smap, owner),
> > > >                                             bpf_rcu_lock_held());
> > > >       if (!local_storage || hlist_empty(&local_storage->list)) {
> > > > @@ -373,11 +377,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > >               if (err)
> > > >                       return ERR_PTR(err);
> > > >
> > > > -             selem = bpf_selem_alloc(smap, owner, value, true);
> > > > +             selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
> > > >               if (!selem)
> > > >                       return ERR_PTR(-ENOMEM);
> > > >
> > > > -             err = bpf_local_storage_alloc(owner, smap, selem);
> > > > +             err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
> > > >               if (err) {
> > > >                       kfree(selem);
> > > >                       mem_uncharge(smap, owner, smap->elem_size);
> > > > @@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > >               }
> > > >       }
> > > >
> > > > +     if (gfp_flags == GFP_KERNEL) {
> > > > +             selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
> > > I think this new path is not executed by the existing
> > > "progs/local_storage.c" test which has sleepable lsm prog.  At least a second
> > > BPF_MAP_TYPE_TASK_STORAGE map (or SK_STORAGE) is needed?
> > > or there is other selftest covering this new path that I missed?
> > Thanks for your feedback. I think I'm misunderstanding how the
> > progs/local_storage.c test and/or local storage works then. Would you
> > mind explaining why a second map is needed?
> >
> > This is my (faulty) understanding of what is happening:
> > 1) In "local_storage.c" in "SEC("lsm.s/inode_rename")" there is a call
> > to bpf_inode_storage_get with the BPF_LOCAL_STORAGE_GET_F_CREATE flag
> > set, which will call into bpf_local_storage_update (which will create
> > the local storage + the selem, and put it in the RCU for that
> > inode_storage_map)
> From reading the comment above the bpf_inode_storage_get(BPF_LOCAL_STORAGE_GET_F_CREATE):
> "new_dentry->d_inode can be NULL", so it is expected to fail.
> Meaning no storage is created.
>
> >
> > 2) Then, further down in the "local_storage.c" file in
> > "SEC("lsm.s/bprm_committed_creds")", there is another call to
> > bpf_inode_storage_get on the same inode_storage_map but on a different
> > inode, also with the BPF_LOCAL_STORAGE_GET_F_CREATE flag set. This
> > will also call into bpf_local_storage_update.
> I belive this is the inode and the storage that the second
> bpf_inode_storage_get(..., 0) in the "inode_rename" bpf-prog is supposed
> to get.  Otherwise, I don't see how the test can pass.
>
> >
> > 3) In bpf_local_storage_update from the call in #2, it sees that there
> > is a local storage associated with this map in the RCU, it tries to
> > look for the inode but doesn't find it, so it needs to allocate with
> > GFP_KERNEL a new selem and then update with the new selem.
> Correct, that will be the very first storage created for this inode
> and it will go through the "if (!local_storage || hlist_empty(&local_storage->list))"
> allocation code path in bpf_local_storage_update() which is
> an existing code path.
>
Ah, I see. I mistakenly thought inodes shared local storages if you
passed in the same map.
Thanks for the clarification!

> I was talking specifically about the "if (gfp_flags == GFP_KERNEL)"
> allocation code path.  Thus, it needs a second inode local storage (i.e.
> a second inode map) for the same inode.  A second inode storage map
> and another "bpf_inode_storage_get(&second_inode_storage_map, ...
> BPF_LOCAL_STORAGE_GET_F_CREATE)" should be enough.
>
> It seems it needs a re-spin because of the sparse warning.
> I don't see an issue from the code, just thinking it will
> be useful to have a test to exercise this path.  It
> could be a follow up as an individual patch if not in v3.

I will submit a v3 that fixes the sparse warning and adds a case to
exercise this path.
Thanks for reviewing this, Martin!
