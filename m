Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B805F2EC856
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 03:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAGCwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jan 2021 21:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbhAGCwM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jan 2021 21:52:12 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16867C0612EF
        for <bpf@vger.kernel.org>; Wed,  6 Jan 2021 18:51:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 23so11237248lfg.10
        for <bpf@vger.kernel.org>; Wed, 06 Jan 2021 18:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pEZWzaEG6s1Ycb+1MMWKsFEm735pZ138JlbfPo9Cx4=;
        b=NxQl2Xj8und1rF8a0cl39BdQVsWTvUJglyj0DCpQtWJK18F7Jk/PV52B2Ut0F7rTsT
         zc1fNwQKGpGgsKbLJ601WCbxjBnm5sAOwiOZNoioA6ad7QzYie+I/TowoPshanL+bOhS
         Q2mZHUvJGzftpvdfEKgynUsMHEfBoDPf3PE7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pEZWzaEG6s1Ycb+1MMWKsFEm735pZ138JlbfPo9Cx4=;
        b=Eixi5fq9W33MKUcnbYeJs0esCVxLwxNl0JLUPERCzPtvvE7735CpJwjJCJCCB7z7yT
         8sR61v/Utw4BUROSw5hq1dSiGH1EWMOg+MCeyUKoj/IQ0Z9I5MM95km2xFl2DYupU8Un
         6myRlz9rUatV3eem0vLTco2f0SP6+7IR+9Rux4o+nyNoY8/YFbZJ4TfyEYhgle+5gz8J
         koVjEUG3htn21kCCpTcLTons3eksbU6URFlN7mCU6qRaPbhkCafPiDq8H8cTvmOH4OPv
         D0/qARbVloD/1EAg9JsgzuK/FhxkGdR2Lc15K9QtoIIALVd62PQO2iR5dw5eEqG4fS85
         8Yfg==
X-Gm-Message-State: AOAM533f4y25UUozFElfYk4wJwls8CKHEYns4uJmswQTYSw2+mTWWbET
        9COv2Z2S8ZsBQu/I4nUvPyFxtsjxEYa29fFwHYFLFg==
X-Google-Smtp-Source: ABdhPJxYbrje1PZP0igTnaWv8UW0pVJdI3jzXCJYgA/nxSuUBa6A5j1IiSAgFC5ecJRCTjtZ/gkU69bMR8OvQkzevKQ=
X-Received: by 2002:a19:641:: with SMTP id 62mr3017079lfg.424.1609987890584;
 Wed, 06 Jan 2021 18:51:30 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com>
 <CANaYP3H0RfcRK=bnNbvnKWe7cvnf0XD36JGWJVTDNUjPtHk6Fg@mail.gmail.com>
 <CAADnVQKkixx3+WWqp5uQ2kxYK_AAx9NiMG38bvwKhgTKBsKWUg@mail.gmail.com> <CACYkzJ5CjcEJH7UywROkVSeL4RVi+fcU9fPRi-a7Nqjx_HiAOg@mail.gmail.com>
In-Reply-To: <CACYkzJ5CjcEJH7UywROkVSeL4RVi+fcU9fPRi-a7Nqjx_HiAOg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 7 Jan 2021 03:51:19 +0100
Message-ID: <CACYkzJ55X8Tp2q4+EFf2hOM_Lysoim1xJY1YdA3k=T3woMW6mg@mail.gmail.com>
Subject: Re: BPF Kernel OOPS - NULL pointer dereference
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Gilad Reti <gilad.reti@gmail.com>, KP Singh <kpsingh@google.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 6, 2021 at 10:02 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Wed, Jan 6, 2021 at 6:27 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jan 6, 2021 at 2:18 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> > >
> > > Hello all,
> > >
> > > Hope you had a great new year vacation.
> > >
> > > Sorry for bumping up the thread, but I believe that it is an important one.
> >
> > Thanks for bumping.
> > KP, please take a look.
> >
> > > On Sun, Dec 20, 2020 at 12:16 PM Gilad Reti <gilad.reti@gmail.com> wrote:
> > > >
> > > > Hello there,
> > > >
> > > > During experimenting with the new inode local storage I have stumbled
> > > > across an invalid pointer dereference that passed through the
> > > > verifier.
> > > >
> > > > After investigating, I think that it happens in the
> > > > bpf_inode_storage_get helper, and in particular in the following line:
> > > > https://elixir.bootlin.com/linux/v5.10.1/source/include/linux/bpf_lsm.h#L32
> > > >
> > > > I have a single bpf lsm probe in the security_inode_rename probe, and
> > > > I have called bpf_inode_storage_get on the inode of the "new_dentry"
> > > > argument. This inode may be null in cases where renameat(2) is called
> > > > to move a file from one path to a new path which didn't exist before.
> > > >
> > > > As can be seen, inode is dereferenced without first checking that it
> > > > is not NULL.
> > > > I don't know what should be the correct behavior, but I believe that
> > > > either the helper should check the validity of passed pointers, or the
> > > > verifier should treat fields of BTF pointers (PTR_TO_BTF_ID) as
> > > > PTR_TO_BTF_ID_OR_NULL.
>
> Thanks for adding me, I missed responding to this over the winter holidays.
>
> In this case this should indeed be PTR_TO_BTF_ID_OR_NULL. I will send in a

Okay so I dug in a little more...We don't really need this

"PTR_TO_BTF_ID points to a kernel struct that does not need to be null
checked by the BPF program. This does not imply the pointer is _not_
null and in practice this can easily be a null pointer when reading
pointer chains. The assumption is program context will handle null
pointer dereference typically via fault handling. The verifier must
keep this in mind and can make no assumptions about null or non-null
when doing branch analysis.
Further, when passed into helpers the helpers can not, without
additional context, assume the value is non-null."

So all we need to do is to check the null-ness of the pointer in the
helper code, the helpers cannot simply assume that the pointer
will be non NULL.

This does the trick, I will send in a patch tomorrow:

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 6edff97ad594..92a59b283316 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -168,6 +168,9 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map
*, map, struct inode *, inode,
 {
        struct bpf_local_storage_data *sdata;

+       if (!inode)
+               return (unsigned long)NULL;
+
        if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
                return (unsigned long)NULL;

@@ -200,6 +203,9 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map
*, map, struct inode *, inode,
 BPF_CALL_2(bpf_inode_storage_delete,
           struct bpf_map *, map, struct inode *, inode)
 {
+       if (!inode)
+               return -EINVAL;
+
        /* This helper must only called from where the inode is gurranteed
         * to have a refcount and cannot be freed.
         */

- KP

> fix.
>
> > > >
> > > > I am attaching a minimal program example, along with the kernel demsg
> > > > output. To reproduce, load the probe and run "mv file1 file2" where
> > > > file2 does not exist.
>
> Thanks for sending the repro program as well! Really appreciate it!
>
> > > >
> > > > Thanks,
> > > > Gilad Reti
> > > >
> > > > inode_oops.c:
> > > >
> > > > // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>
> [...]
>
> > > > [Thu Dec 17 11:35:37 2020] FS:  00007fa878948740(0000)
> > > > GS:ffff895cede00000(0000) knlGS:0000000000000000
> > > > [Thu Dec 17 11:35:37 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [Thu Dec 17 11:35:37 2020] CR2: 0000000000000038 CR3: 0000000121f34001
> > > > CR4: 00000000003706f0
