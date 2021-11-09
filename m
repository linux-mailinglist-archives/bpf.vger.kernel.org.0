Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EA44B944
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 00:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhKIXTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 18:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhKIXTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 18:19:02 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1DC061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 15:16:16 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e136so1569669ybc.4
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJdV8y3xTH1HXXlNWpUudjZrsACMvwKH+03eQsVnZoo=;
        b=gTFLuNz1VDOjxgkgkyPfv6VC2Zz93YIP08ewaTWwEos4xKTBOFlDXicl8jPpNrNV0X
         AaBDlHAHlkYEsq4kWmlzvvDeQlJdTOxaExzZofeiwcERpoULvzmD7zwRM/kf5yZQpR9X
         pO09AFV4CcamvJ9UAs947aHilH51sTLg3ZogpGoEvrfK/uy2Ej7FrX7DEtZ4+mJ2BsXe
         Sun4Qeg68sFaj/hcr+ghmCe89cAjEhcTXnHTWf7rZTE6xPlxs+Wgd9ZL29uyUivDPVHF
         P9BSLNq6VEAWHQjOCpR7sA2197roar1UbyziLD5xiDan1Pr2/3NbeiLGI36QdHyafocg
         SEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJdV8y3xTH1HXXlNWpUudjZrsACMvwKH+03eQsVnZoo=;
        b=X300RU13ESWdDrJ19G6vyef6utz268/qjh6xmK0Vx+azEqSHzTLd+6eti2eTwJOAuO
         v2p2SRlQK7LycnEVoXzAGOLdQpDUMqxbAsc0ghKQIZwRWu28Lds4vEB+0WgxSD91qid+
         yiTHHFHDWu8eG/3UOtwvBfRFZkBRzoci/A5Q4K01uR1o6y4CmbUIkMHbE+X3kNFpzmZt
         AuRc47VS6wrhIsQpvdNjSvf/zaLRtpB1NE2oz2+H8ADMN5I4v/LVl4C+wbqkj8INxKIS
         8oSI7cwqPw1VxKSLKkT+Zmhz7R7D50ukhW4e8emq8NQVA+dGhER1R0dLxXE3ysB1NVvA
         uzcQ==
X-Gm-Message-State: AOAM530kTLvM4E77KUzGnazZUbJdQyNLUbypi/9Kp/OmkPWk78FHwbKe
        4uEXFyHv79r1tvvkD4RjdREeadfRSBBAS11dQq6aGQEV
X-Google-Smtp-Source: ABdhPJz8kY05BwiHT6Qkj/3Zx3ybT+Wx6J3zhhGfJvXil92AMEhS7asXM+7esfVcF//a4w06NyOMCNz5AKSn0I+PSQ4=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr11525892ybj.433.1636499775293;
 Tue, 09 Nov 2021 15:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20211105234243.390179-1-memxor@gmail.com> <CAADnVQ+6D7_7WQr2OdDRHr9tp9L-4zUvSMWh09j=-t8w-1BzCQ@mail.gmail.com>
 <CAEf4BzYGG04bXBFEv-yk9jmV6amxxzGM-Zr0=0CoJAMRGxg6kA@mail.gmail.com>
 <CAADnVQLAcgdbjOiT33ED3qD7wP-D8gnzLdHA3zxjdEmaKkipkA@mail.gmail.com>
 <CAEf4BzYJhCjQFLOdmjK5tHFkCxuB2XmqAmnYHPmsNuKz0B7WHA@mail.gmail.com> <CAADnVQJ6hoNPXyg7bGMqthSUZnZU3O_yQRZSGkKPnvbNPQpLHg@mail.gmail.com>
In-Reply-To: <CAADnVQJ6hoNPXyg7bGMqthSUZnZU3O_yQRZSGkKPnvbNPQpLHg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 15:16:03 -0800
Message-ID: <CAEf4BzZfe_dfGDrBrYtEDFAU8ZVTacXr6t5wUtRFqYNxukaeWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] Change bpftool, libbpf, selftests to
 force GNU89 mode
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 1:40 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 8, 2021 at 2:15 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Nov 6, 2021 at 4:20 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Nov 6, 2021 at 1:02 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sat, Nov 6, 2021 at 9:34 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Nov 5, 2021 at 6:36 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > > > >
> > > > > > Fix any remaining instances that fail the build in this mode.  For selftests, we
> > > > > > also need to separate CXXFLAGS from CFLAGS, since adding it to CFLAGS simply
> > > > > > would generate a warning when used with g++.
> > > > > >
> > > > > > This also cherry-picks Andrii's patch to fix the instance in libbpf. Also tested
> > > > > > introducing new invalid usage of C99 features.
> > > > > >
> > > > > > Andrii Nakryiko (1):
> > > > > >   libbpf: fix non-C89 loop variable declaration in gen_loader.c
> > > > > >
> > > > > > Kumar Kartikeya Dwivedi (5):
> > > > > >   bpftool: Compile using -std=gnu89
> > > > > >   libbpf: Compile using -std=gnu89
> > > > > >   selftests/bpf: Fix non-C89 loop variable declaration instances
> > > > > >   selftests/bpf: Switch to non-unicode character in output
> > > > > >   selftests/bpf: Compile using -std=gnu89
> > > > >
> > > > > Please don't.
> > > > > I'd rather go the other way and drop gnu89 from everywhere.
> > > > > for (int i = 0
> > > > > is so much cleaner.
> > > >
> > > > I agree that for (int i) is better, but it's kernel code style which
> > > > we followed so far pretty closely for libbpf and bpftool. So I think
> > > > this is the right move for bpftool and libbpf.
> > >
> > > The kernel coding style is not white and black.
> > > Certain style preferences are archaic to say the least.
> > > It's not the right move to follow it blindly.
> >
> > Can we at least add -std=gnu89 for the libbpf? It's a library, so
> > being conservative with compiler versions and language features makes
> > sense there. I'll add a similar flag to Github's Makefile. I'd rather
> > catch this at patch submission time rather than at the Github sync
> > time.
>
> Sure. Applied Kumar's patch 3.
> With CO-RE in the kernel the pieces of libbpf will be part
> of the kernel for real, so for libbpf as a whole would make sense
> to conform to the language standards as parts of libbpf have to do.
> As far as other parts of kernel git the language standard
> can be decided whichever way.
> perf and libsubcmd (part of objtool) have no issue using 'for (int'
> while being part of the kernel tree.
> We can adopt strong gnu89 in bpftool, but I'd rather not rush
> such a decision right now.
> selftests are certainly not gnu89.
> All bpf programs are written in C-2021 "standard".
> Lots of C extensions in there.

sgtm
