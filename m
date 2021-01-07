Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A792ED754
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 20:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbhAGTQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 14:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGTQK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 14:16:10 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFBCC0612F4
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 11:15:30 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id r63so7127310ybf.5
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 11:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VaT2Nxd1TyI28ATE+9kLNP/DurxPHkteeXJgEwF3qA=;
        b=oFeHxPXWHJIzsvI50r9SnVo8MWUuCZ5tytmC5sq46e7twY0HjFRl0QkoK0hFgGjwgb
         cKpBbJy4mAWk1hDhI2Ch1gMP19FREbabUH+EgmZudWXIhfLSF5QbNy5QHRqlihyUdTtP
         bZBeh68/5MlCzK7lpKJdMHeyMuultSAX0kUzR4II0aJHYnF4OTrCbCkEut1KHgYO0PgF
         vrZO8ey9djUyfHu14klHUqpUbwnCkCfTjcbIsu8HMPf6zU2NYtEaqGtnQ0xMWWpoeIqB
         2ytsczqfcnXUyyRwVUFD8RSCvEcdiJ/EcPI586fQ0042ruKi4DcxlBRQPjywDEKehW5r
         XMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VaT2Nxd1TyI28ATE+9kLNP/DurxPHkteeXJgEwF3qA=;
        b=Uwx+jd0qiGsWXlHWUJAl97mvkQW/V/S1tV/7I0NLGHs1YHRf6ZHsEO2skN68Eoy+o/
         w2vRy+BVUnxFpoziEoPo9UkaxwQcnhQWnxxWQOGdwa5ZZdoZKQG37R7bov8CVG1lyJA/
         ng3PWGbOtVnztqvxLl3flrh523QET0OYKWuiw/FW/CYs10JC8YI4JOxYMsJ2pQacHfgl
         8KVOa5J9fOM1mna8UQmY0wpu6p2lEdnnM7weC0dSsjHsnZMTBgh2/DUMhpcN8l1EE6l1
         dCKAXRLmAJhrrgKgbz8QnEc2K2KvKi5Cu/VNRIOZubTk57O6WPgTM6JWISp9f3YQFayX
         BNuQ==
X-Gm-Message-State: AOAM531DgHLwCYQoEXY121nflMelFn5BMtR6sQXwWy9q0TvBx50pRKsi
        +ZWz5fHy3S7ghykvIAEFv/jTGghLnGBfqIV1L0xe9+H4
X-Google-Smtp-Source: ABdhPJx6DbQ5kvPimxo99NKsl+zmu1iNHM12v6labeVylzBAFR2VKMeGnjVEsGv5VE3XFpKF6ynO1hX7b8EfLayYb/g=
X-Received: by 2002:a25:d44:: with SMTP id 65mr431370ybn.260.1610046929892;
 Thu, 07 Jan 2021 11:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20210107173729.2667975-1-kpsingh@kernel.org> <CAEf4BzbxVtR+kaTFyHiH0tz3npr_vnpOidmG=t4sQAtaNE95UA@mail.gmail.com>
In-Reply-To: <CAEf4BzbxVtR+kaTFyHiH0tz3npr_vnpOidmG=t4sQAtaNE95UA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Jan 2021 11:15:18 -0800
Message-ID: <CAEf4BzYjSYBTocYAWv1FDiyRFTmy_XqcE-DvZfZw5K2qoL9Z+Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: local storage helpers should check nullness of
 owner ptr passed
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 11:07 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 7, 2021 at 9:37 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > The verifier allows ARG_PTR_TO_BTF_ID helper arguments to be NULL, so
> > helper implementations need to check this before dereferencing them.
> > This was already fixed for the socket storage helpers but not for task
> > and inode.
> >
> > The issue can be reproduced by attaching an LSM program to
> > inode_rename hook (called when moving files) which tries to get the
> > inode of the new file without checking for its nullness and then trying
> > to move an existing file to a new path:
> >
> >   mv existing_file new_file_does_not_exist
>
> Seems like it's simple to write a selftest for this then?
>
> >
> > The report including the sample program and the steps for reproducing
> > the bug:
> >
> >   https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com
> >
> > Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
> > Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
> > Reported-by: Gilad Reti <gilad.reti@gmail.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  kernel/bpf/bpf_inode_storage.c | 5 ++++-
> >  kernel/bpf/bpf_task_storage.c  | 5 ++++-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > index 6edff97ad594..dbc1dbdd2cbf 100644
> > --- a/kernel/bpf/bpf_inode_storage.c
> > +++ b/kernel/bpf/bpf_inode_storage.c
> > @@ -176,7 +176,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> >          * bpf_local_storage_update expects the owner to have a
> >          * valid storage pointer.
> >          */
> > -       if (!inode_storage_ptr(inode))
> > +       if (!inode || !inode_storage_ptr(inode))
>
> would it be bad to move !inode check inside inode_storage_ptr itself?
> same for task_storage_ptr() below.

And for deletes, inode_storage_delete calls into
inode_storage_lookup(), which also seems like a reasonable place to
check for null? Even better, inode_storage_lookup() shares logic with
inode_storage_ptr(), so if we make sure that all code calls
inode_storage_ptr(), then we need to check for NULL just in
inode_storage_ptr().

I totally might be missing some subtleties, of course.

>
> >                 return (unsigned long)NULL;
> >
> >         sdata = inode_storage_lookup(inode, map, true);
> > @@ -200,6 +200,9 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> >  BPF_CALL_2(bpf_inode_storage_delete,
> >            struct bpf_map *, map, struct inode *, inode)
> >  {
> > +       if (!inode)
> > +               return -EINVAL;
> > +
> >         /* This helper must only called from where the inode is gurranteed
>
> Gmail highlights a typo in "gurranteed" ;)
>
> >          * to have a refcount and cannot be freed.
> >          */
> > diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> > index 4ef1959a78f2..e0da0258b732 100644
> > --- a/kernel/bpf/bpf_task_storage.c
> > +++ b/kernel/bpf/bpf_task_storage.c
> > @@ -218,7 +218,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> >          * bpf_local_storage_update expects the owner to have a
> >          * valid storage pointer.
> >          */
> > -       if (!task_storage_ptr(task))
> > +       if (!task || !task_storage_ptr(task))
> >                 return (unsigned long)NULL;
> >
> >         sdata = task_storage_lookup(task, map, true);
> > @@ -243,6 +243,9 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> >  BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
> >            task)
> >  {
> > +       if (!task)
> > +               return -EINVAL;
> > +
> >         /* This helper must only be called from places where the lifetime of the task
> >          * is guaranteed. Either by being refcounted or by being protected
> >          * by an RCU read-side critical section.
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
