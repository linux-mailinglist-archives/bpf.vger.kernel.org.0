Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C109B31007C
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 00:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBDXHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 18:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhBDXHF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 18:07:05 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D68C06178B;
        Thu,  4 Feb 2021 15:06:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id s61so4913439ybi.4;
        Thu, 04 Feb 2021 15:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2lQIk70QFd6n9YzDSNyVdJpE7exaIuav69xSQ3986U=;
        b=F/+qM05hj6/LKAW/h4nkFrTSjp7t/fa9KTSi01wfoU67CjDHPI3aN+n77INkrMfhkR
         72nqjT8mibxrdz/h10iF+5ccbppczfeIvV1tqP6bm9N+D8AiSdwMlUN3y8AhGoe1x/Xk
         qel5VRyoggHK4MH9mge4A1rR8Ixc0nQKREz2Pc9HZhBchj95mR6BuMZ4cK2Sh0BTctxK
         grdqWSuz0SOaBJLepLx+8ysHuIK1zrpKl9RaMWWWmWQvzDRal04SEBDxgKnQSmNqIvWs
         Vxovlga4qbFavXwsweexigJY+FPJtPKNFiXpbTkt8prCjQtfH8zdiY0obv0RS3b+3cWH
         /kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2lQIk70QFd6n9YzDSNyVdJpE7exaIuav69xSQ3986U=;
        b=Ju53w3TPuuRiNnsYMKwOYyRxCLCsFRikna3rByQg5rZJp6VApImE0Zpcx+7paKcmZS
         9ioC/SR+b4gTGrhcTSgkaEE9HwpxinWQe3kgMzM4tUYraBTusj9VvTADkbObkhPKCJPf
         QC0vuQFQaQvZwjjRnDIf9ahvImtXulQ/f+TgNdJnKNIZ+46i7BjEkFoExtl096mGExNT
         D50oGdZCodIeMii7IU43fb8Al851UWy6BIY/Ya6d5CkZa4K4NtlvhRJ2o4k/C4Ik9Rr8
         rr559WW0EH14I8iKxk0X4JOB9IQjquCj0etwHN7+ix93dFlYCn8mPZ18ShTF3EI526gE
         cB8A==
X-Gm-Message-State: AOAM531hqdZj+LNlOduAXZ6iWCFS4OzyaAiYSkI4pRjqsLDeZ3j97UXs
        8PQXsaXnNsr1RV2Qq69qu9ut5hFROJ31orY+yGY=
X-Google-Smtp-Source: ABdhPJz07sCxdAmM4/eggXhRo/VNPmpJa3Qj+/AtWgfk2ts0KMjSsozs8psaoJxBH/PzLSFVdEBuUm5D4DwEe0LmJCY=
X-Received: by 2002:a25:d844:: with SMTP id p65mr2113021ybg.27.1612479984732;
 Thu, 04 Feb 2021 15:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-3-gprocida@google.com>
 <CAEf4BzY_xk2H1Eh9h_WiXbqP3O-afiZnmpWf=MtCrqdJeNW+ag@mail.gmail.com> <CAGvU0HmHR0AXKT2=LyD6HWdr79JM9kWjLTZhajjUJx+p2QB0tA@mail.gmail.com>
In-Reply-To: <CAGvU0HmHR0AXKT2=LyD6HWdr79JM9kWjLTZhajjUJx+p2QB0tA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Feb 2021 15:06:13 -0800
Message-ID: <CAEf4BzYwNVnT_9d2sRxRtOMihfFuK+R5Adxx87iArDv_Rr7dbg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 2/4] btf_encoder: Manually lay out updated ELF sections
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 10:34 AM Giuliano Procida <gprocida@google.com> wrote:
>
> Hi.
>
> On Thu, 4 Feb 2021 at 04:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Feb 1, 2021 at 9:26 AM Giuliano Procida <gprocida@google.com> wrote:
> > >
> > > pahole -J needs to do the following to an ELF file:
> > >
> > > * add or update the ".BTF" section
> > > * maybe update the section name string table
> > > * update the Section Header Table (SHT)
> > >
> > > libelf either takes full control of layout or requires the user to
> > > specify offset, size and alignment of all new and updated sections and
> > > headers.
> > >
> > > To avoid libelf moving program segments in particular, we position the
> >
> > It's not clear to me what's wrong with libelf handling all the layout.
> > Even if libelf will move program segments around, what's the harm?
> > Does it break anything if we just let libelf do this?
> >
>
> It doesn't hurt the userspace case I care about. I've no idea what it
> means in terms of vmlinux.
>
> However, I wrote that text before I discovered that pahole -J isn't
> actually used to modify kernel images.
>
> One thing I haven't tried is to try to make .BTF loadable but leave
> placement to libelf.

I'd concentrate on getting rid of llvm-objcopy dependency first.
Making .BTF loadable is even riskier change and there is no use case
that relies on that today, so definitely worth to split that out.


>
> > > ".BTF" and section name string table (typically named ".shstrtab")
> > > sections after all others. The SHT always lives at the end of the file.
> > >
> > > Note that the last section in an ELF file is normally the section name
> > > string table and any ".BTF" section will normally be second last.
> > > However, if these sections appear earlier, then we'll waste some space
> > > in the ELF file when we rewrite them.
> > >
> > > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > > ---
> > >  libbtf.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 62 insertions(+), 2 deletions(-)
> > >
> >
> > [...]
