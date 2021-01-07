Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7E2EE6CD
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 21:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhAGU0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 15:26:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbhAGU0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 15:26:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF68C23447
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610051161;
        bh=zbq0K9qNV4yNMs35NjsT83POd1w29oUvij+8kKKFr4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZFfR+G2yh6MS3eooevOXUR5fND/zK/a5n/mTk/2MiTwgKcH3SQpveFRrJrzF/tfyZ
         aL6TqtYWxhEMMYPwCQf71A+xh8efKlPpHJiZY8U5HHN6PMLSa8a83FKZVfBuLaxeVw
         vYxiZEg9JktEPUucO/VqKudN+85MchJ6zyXeTouvoMIB5kx7mxCC/c5wZtgILj55H4
         +mkQuM4dWEDH+KZ3rwULBJJGz185xmJjrYuoR6Xc6dXlBlmerim6q+/WzVwPHU/4uO
         A3ILsmjPPrAnm3/OQq4GgNbQjG5e9q9YZJRwvNt+MBBv8agm+zmbD60ZzzgrQi/AEi
         kbJ2y7Hn9fV3A==
Received: by mail-lf1-f46.google.com with SMTP id 23so17594333lfg.10
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 12:26:00 -0800 (PST)
X-Gm-Message-State: AOAM532CsSlg3gpsFP6twLmyIarGicZ05zktWH4QQH8TpW4onSCnHRxg
        G7NzT16uUnRKo9Uig2ahM9CzTwS4ivQbw0gGNhZWaQ==
X-Google-Smtp-Source: ABdhPJwN5XL2vIOIi0yHM8BYfzEqn1Y3ZTGX8rO82ywJSL0Wicf+/ggKbzxt6YRYZvdqOnTgzysu+qgbGVX19HQhgdE=
X-Received: by 2002:a2e:b5dc:: with SMTP id g28mr93615ljn.112.1610051158938;
 Thu, 07 Jan 2021 12:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20210107173729.2667975-1-kpsingh@kernel.org> <CAEf4BzbxVtR+kaTFyHiH0tz3npr_vnpOidmG=t4sQAtaNE95UA@mail.gmail.com>
 <CAEf4BzYjSYBTocYAWv1FDiyRFTmy_XqcE-DvZfZw5K2qoL9Z+Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYjSYBTocYAWv1FDiyRFTmy_XqcE-DvZfZw5K2qoL9Z+Q@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 7 Jan 2021 21:25:48 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7OCLAfg2OAnvpvexHpaQ8MzntibE79Gf18V++Nc1O0PA@mail.gmail.com>
Message-ID: <CACYkzJ7OCLAfg2OAnvpvexHpaQ8MzntibE79Gf18V++Nc1O0PA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: local storage helpers should check nullness of
 owner ptr passed
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 8:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 7, 2021 at 11:07 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jan 7, 2021 at 9:37 AM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > The verifier allows ARG_PTR_TO_BTF_ID helper arguments to be NULL, so
> > > helper implementations need to check this before dereferencing them.
> > > This was already fixed for the socket storage helpers but not for task
> > > and inode.
> > >
> > > The issue can be reproduced by attaching an LSM program to
> > > inode_rename hook (called when moving files) which tries to get the
> > > inode of the new file without checking for its nullness and then trying
> > > to move an existing file to a new path:
> > >
> > >   mv existing_file new_file_does_not_exist
> >
> > Seems like it's simple to write a selftest for this then?

Sure, I will send in a separate patch for selftest and also for the typo.

> >
> > >
> > > The report including the sample program and the steps for reproducing
> > > the bug:
> > >
> > >   https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com
> > >
> > > Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
> > > Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
> > > Reported-by: Gilad Reti <gilad.reti@gmail.com>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  kernel/bpf/bpf_inode_storage.c | 5 ++++-
> > >  kernel/bpf/bpf_task_storage.c  | 5 ++++-
> > >  2 files changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > > index 6edff97ad594..dbc1dbdd2cbf 100644
> > > --- a/kernel/bpf/bpf_inode_storage.c
> > > +++ b/kernel/bpf/bpf_inode_storage.c
> > > @@ -176,7 +176,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> > >          * bpf_local_storage_update expects the owner to have a
> > >          * valid storage pointer.
> > >          */
> > > -       if (!inode_storage_ptr(inode))
> > > +       if (!inode || !inode_storage_ptr(inode))
> >
> > would it be bad to move !inode check inside inode_storage_ptr itself?
> > same for task_storage_ptr() below.
>
> And for deletes, inode_storage_delete calls into
> inode_storage_lookup(), which also seems like a reasonable place to
> check for null? Even better, inode_storage_lookup() shares logic with
> inode_storage_ptr(), so if we make sure that all code calls
> inode_storage_ptr(), then we need to check for NULL just in
> inode_storage_ptr().
>
> I totally might be missing some subtleties, of course.

All these are good candidates for nullness checks too (I also thought
about bpf_inode and
bpf_task having a null check).

I kind of like the explicit check / input validation in the helper
before it does anything with the pointer.
It's a reminder that the value cannot be assumed to be NULL.

FWIW, we do a similar explicit check in the socket storage code as well.

[...]

> >
> > Gmail highlights a typo in "gurranteed" ;)

Thanks, and thanks gmail ;)

> >
> > >          * to have a refcount and cannot be freed.
> > >          */
> > > diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> > > index 4ef1959a78f2..e0da0258b732 100644
> > > --- a/kernel/bpf/bpf_task_storage.c
> > > +++ b/kernel/bpf/bpf_task_storage.c
> > > @@ -218,7 +218,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > >          * bpf_local_storage_update expects the owner to have a
> > >          * valid storage pointer.
> > >          */
> > > -       if (!task_storage_ptr(task))
> > > +       if (!task || !task_storage_ptr(task))
> > >                 return (unsigned long)NULL;
> > >
> > >         sdata = task_storage_lookup(task, map, true);
> > > @@ -243,6 +243,9 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > >  BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
> > >            task)
> > >  {
> > > +       if (!task)
> > > +               return -EINVAL;
> > > +
> > >         /* This helper must only be called from places where the lifetime of the task
> > >          * is guaranteed. Either by being refcounted or by being protected
> > >          * by an RCU read-side critical section.
> > > --
> > > 2.30.0.284.gd98b1dd5eaa7-goog
> > >
