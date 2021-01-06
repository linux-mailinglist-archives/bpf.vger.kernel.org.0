Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB72EC56F
	for <lists+bpf@lfdr.de>; Wed,  6 Jan 2021 22:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAFVDw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jan 2021 16:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbhAFVDw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jan 2021 16:03:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1CF62313B
        for <bpf@vger.kernel.org>; Wed,  6 Jan 2021 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609966992;
        bh=Q6xLMoT557K4CK1nMQoURYYeVLLQf+dvFEEfDFxaN9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l2U6lOwQ/MkCcZbzY7bYSPxCvWtJWHSh7+qWeFUbQkuo7Pkg51rSCVHBdLLd8lLyU
         jGiiuil3IkWpiemOoJkVWsBiPzcyvJRBTac0wQeNEf5pOb4/SpLiLOHC118vwPa6ng
         /OtPDKwH6+7aYb16LCnKKgRZqpDo6/xcoIRTruM5JzTQmTpWdlB953IHhuJeEhVXFc
         3M+z981D5P+hBlUVxu5Tk/pUK/ZOu08SOLS1o9Kf6GlqCR0QrlIRuBfweh8WVW51Om
         jr5vOP+R2lblpHiftBZiO97eztAu+kJ1CrntYcd4awc6tceKsRo9kThqhInPfj+aKC
         +yKtgItjrlPXw==
Received: by mail-lf1-f42.google.com with SMTP id b26so9671237lff.9
        for <bpf@vger.kernel.org>; Wed, 06 Jan 2021 13:03:11 -0800 (PST)
X-Gm-Message-State: AOAM531aHhK5vElItXpKYFJZVOzrm2/R44m/35kobe/6obj4k/lIWCDp
        Z0LBNlMqZwoVz7XpAujkNTw4asuFpXikAWI6p7HDPg==
X-Google-Smtp-Source: ABdhPJxSAiCa9LTFAZzFlYli1CyM8oY2WDYVvRWkjgUZrxieA6t6kapCENTcJQQ5Alx2hcsB4lDTJnCWqUlIHByH0G0=
X-Received: by 2002:a19:b4d:: with SMTP id 74mr2508765lfl.162.1609966989999;
 Wed, 06 Jan 2021 13:03:09 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com>
 <CANaYP3H0RfcRK=bnNbvnKWe7cvnf0XD36JGWJVTDNUjPtHk6Fg@mail.gmail.com> <CAADnVQKkixx3+WWqp5uQ2kxYK_AAx9NiMG38bvwKhgTKBsKWUg@mail.gmail.com>
In-Reply-To: <CAADnVQKkixx3+WWqp5uQ2kxYK_AAx9NiMG38bvwKhgTKBsKWUg@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 6 Jan 2021 22:02:59 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5CjcEJH7UywROkVSeL4RVi+fcU9fPRi-a7Nqjx_HiAOg@mail.gmail.com>
Message-ID: <CACYkzJ5CjcEJH7UywROkVSeL4RVi+fcU9fPRi-a7Nqjx_HiAOg@mail.gmail.com>
Subject: Re: BPF Kernel OOPS - NULL pointer dereference
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Gilad Reti <gilad.reti@gmail.com>, KP Singh <kpsingh@google.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 6, 2021 at 6:27 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 6, 2021 at 2:18 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> >
> > Hello all,
> >
> > Hope you had a great new year vacation.
> >
> > Sorry for bumping up the thread, but I believe that it is an important one.
>
> Thanks for bumping.
> KP, please take a look.
>
> > On Sun, Dec 20, 2020 at 12:16 PM Gilad Reti <gilad.reti@gmail.com> wrote:
> > >
> > > Hello there,
> > >
> > > During experimenting with the new inode local storage I have stumbled
> > > across an invalid pointer dereference that passed through the
> > > verifier.
> > >
> > > After investigating, I think that it happens in the
> > > bpf_inode_storage_get helper, and in particular in the following line:
> > > https://elixir.bootlin.com/linux/v5.10.1/source/include/linux/bpf_lsm.h#L32
> > >
> > > I have a single bpf lsm probe in the security_inode_rename probe, and
> > > I have called bpf_inode_storage_get on the inode of the "new_dentry"
> > > argument. This inode may be null in cases where renameat(2) is called
> > > to move a file from one path to a new path which didn't exist before.
> > >
> > > As can be seen, inode is dereferenced without first checking that it
> > > is not NULL.
> > > I don't know what should be the correct behavior, but I believe that
> > > either the helper should check the validity of passed pointers, or the
> > > verifier should treat fields of BTF pointers (PTR_TO_BTF_ID) as
> > > PTR_TO_BTF_ID_OR_NULL.

Thanks for adding me, I missed responding to this over the winter holidays.

In this case this should indeed be PTR_TO_BTF_ID_OR_NULL. I will send in a
fix.

> > >
> > > I am attaching a minimal program example, along with the kernel demsg
> > > output. To reproduce, load the probe and run "mv file1 file2" where
> > > file2 does not exist.

Thanks for sending the repro program as well! Really appreciate it!

> > >
> > > Thanks,
> > > Gilad Reti
> > >
> > > inode_oops.c:
> > >
> > > // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

[...]

> > > [Thu Dec 17 11:35:37 2020] FS:  00007fa878948740(0000)
> > > GS:ffff895cede00000(0000) knlGS:0000000000000000
> > > [Thu Dec 17 11:35:37 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [Thu Dec 17 11:35:37 2020] CR2: 0000000000000038 CR3: 0000000121f34001
> > > CR4: 00000000003706f0
