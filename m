Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D074B4470F6
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 00:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhKFXXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Nov 2021 19:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhKFXXf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Nov 2021 19:23:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04BDC061570
        for <bpf@vger.kernel.org>; Sat,  6 Nov 2021 16:20:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x16-20020a17090a789000b001a69735b339so5954074pjk.5
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcVcAWMuMSbvOw005beBd3hIKeaOr7s/n/JoldgYRQA=;
        b=YeYgPTfUe3SV8aQMiKYl93WBeQWFzZHp6gvsXxU0jyL9iHARgW8P4Six0fKNWe6UIz
         XRoZakU/4irlbLHmswaqGwH9wO7ztcjV/LZow/2F0i9rJ+SiofJU/EPwYtdQMKSxu9d8
         kEW7nyORLryqu9g+lfnptTBWN+e2rCSeifUpYWQ3yT297cDX4xDMZYdnC1fB2MYITs/B
         re+ydicdgKAB3AIBCKIkWcTJlFEbiimAFgRbFWy4SwvNOfxnvieXZo6Uib+chbdzD9Md
         MYxz34B774y1qglZbFQFsYeD+NGmoiuoSmHHkxtX4ANsemiaYkK/GeNAxaq0P6bBLPtG
         Mcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcVcAWMuMSbvOw005beBd3hIKeaOr7s/n/JoldgYRQA=;
        b=t1UQ960S4Xt6nbGx14jfgy49fUK43jpbgTmCWZ6VWLBMwu4r3BW7B8ohKd/l3lQMLz
         4Knc91E3j7POusvFB8GclotqHCWLlZDyCEL9oAlSU+kkiOw3oKfcvolNpguqCsk+EBUW
         c87Mhr4iC3i14yOm9LAAJd9UG/JB7VPpfMx3YnsZNYSys3BbByD0y+uo0n0ru++RfABe
         v484VxwA4izmhsr102plE92aOpsk5TYooQ27OqJXAOAyUsnhhY8lMHUDC6FrL+zqBmp9
         M/59iAqtGqPBxJ2XLjHuDxc+j9tXipitTjCT+LKrybzgZc1bfHPVdK4r99TyLOhzN13j
         Fvbw==
X-Gm-Message-State: AOAM530x7lfo4AntkVOUeuHxZdnQLl1SSNAjJZEySjhJGVbml1qwD+tg
        /yC1IQH2sWcR/OyyX15ypHbRufJstyn322bQdwg=
X-Google-Smtp-Source: ABdhPJwEm6nR+tdyyt8KXdNRRZDvh8S77Bxbo0LXG87HgFL98qFwa8ZAtBe6P05niMnYfGNIi0J/ocUxK6aeFREyH+E=
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id
 d6-20020a170903230600b00141e52e457dmr42465862plh.3.1636240853262; Sat, 06 Nov
 2021 16:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211105234243.390179-1-memxor@gmail.com> <CAADnVQ+6D7_7WQr2OdDRHr9tp9L-4zUvSMWh09j=-t8w-1BzCQ@mail.gmail.com>
 <CAEf4BzYGG04bXBFEv-yk9jmV6amxxzGM-Zr0=0CoJAMRGxg6kA@mail.gmail.com>
In-Reply-To: <CAEf4BzYGG04bXBFEv-yk9jmV6amxxzGM-Zr0=0CoJAMRGxg6kA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 6 Nov 2021 16:20:42 -0700
Message-ID: <CAADnVQLAcgdbjOiT33ED3qD7wP-D8gnzLdHA3zxjdEmaKkipkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] Change bpftool, libbpf, selftests to
 force GNU89 mode
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 6, 2021 at 1:02 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Nov 6, 2021 at 9:34 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 5, 2021 at 6:36 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > Fix any remaining instances that fail the build in this mode.  For selftests, we
> > > also need to separate CXXFLAGS from CFLAGS, since adding it to CFLAGS simply
> > > would generate a warning when used with g++.
> > >
> > > This also cherry-picks Andrii's patch to fix the instance in libbpf. Also tested
> > > introducing new invalid usage of C99 features.
> > >
> > > Andrii Nakryiko (1):
> > >   libbpf: fix non-C89 loop variable declaration in gen_loader.c
> > >
> > > Kumar Kartikeya Dwivedi (5):
> > >   bpftool: Compile using -std=gnu89
> > >   libbpf: Compile using -std=gnu89
> > >   selftests/bpf: Fix non-C89 loop variable declaration instances
> > >   selftests/bpf: Switch to non-unicode character in output
> > >   selftests/bpf: Compile using -std=gnu89
> >
> > Please don't.
> > I'd rather go the other way and drop gnu89 from everywhere.
> > for (int i = 0
> > is so much cleaner.
>
> I agree that for (int i) is better, but it's kernel code style which
> we followed so far pretty closely for libbpf and bpftool. So I think
> this is the right move for bpftool and libbpf.

The kernel coding style is not white and black.
Certain style preferences are archaic to say the least.
It's not the right move to follow it blindly.
