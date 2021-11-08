Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC6449E9D
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 23:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhKHWSP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 17:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhKHWSO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 17:18:14 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB3C061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 14:15:29 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v138so47578465ybb.8
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWS8xGn+r5iynYEcWwAQHKC1izH4WazCE4jXdTe4qZ0=;
        b=ngYIr6BExHuxaDfe1x9O/iojp4EPZrtnhZKw72ZSDFLFNPbkEYF/lYMqwnfZikHLAx
         0gvUzKLxW8EPx8M7EhQKpv7kuAIalHjkweogcnEx7KSkG4aEQVACrJBQOUEqaOTPbN5z
         VuoXn1TVyYwQVk6sR+dDw2t5BMi2KWU/h76qaJ3mfcr+D+Bk3dOiCPN6DoW+IrITeGzh
         dStsNF0heMloX+p/iMjmTG5x4vIEwUrJcvcfHYKpTOBp2X0XnQ8XEeCqT4PPT/uRK9X2
         HK/vbPWJ0JF+focogDhXk3FxK0sX1zA22yW/nL04YsrCJvpVaFthnwi/AyDJ7k5gZaPc
         Lw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWS8xGn+r5iynYEcWwAQHKC1izH4WazCE4jXdTe4qZ0=;
        b=g7EliAFiNvgEmFyjMHVHMwGBb/Z+78XHk0H9S3bw7FEBnjG/BqJncb8tRV8/fsi3p1
         a9RnBIjV1hZCw2jStGb6k0X/6Z/xcLBcVCJuaXRvHEUkKKsUidqaHID5/rWH/66VeWJs
         +22OxL8IFaRyG63BCV/cDVTFxiv6zOCe0+9/kD25Z8yS3yZDwAmyIfjuVsHZSb1tjwuV
         bQEzTo2H2+Gm+d6CzgCHBZYmry81TTp2wM60MnoAkbNSjEQS1V08t+UDmzoLhpu4Y5Jl
         ejD2oEfEnGPGxaKIJtgMtfq1ePKw2byb4AgLEsBLYea5VqyPiiRImXuRpWtdP26qCRlZ
         A0uA==
X-Gm-Message-State: AOAM530hf3Ohn8m3Ct+CBSaY/Lkk97TtInbz8Ix0OxW2d9KcFIHdjSe3
        iCoUJQ7LRUYHvB28eGsqjOQOO+qye7pfJq1mZQU=
X-Google-Smtp-Source: ABdhPJyjUkr9p18dHSt5+cC7eKPA7OobXupE1GnLQ8WPzoZ8XyK8iuYSEza9b6votHym9E0nEcHoNW9wesgC3ycyZlA=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr3113953ybf.114.1636409729073;
 Mon, 08 Nov 2021 14:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20211105234243.390179-1-memxor@gmail.com> <CAADnVQ+6D7_7WQr2OdDRHr9tp9L-4zUvSMWh09j=-t8w-1BzCQ@mail.gmail.com>
 <CAEf4BzYGG04bXBFEv-yk9jmV6amxxzGM-Zr0=0CoJAMRGxg6kA@mail.gmail.com> <CAADnVQLAcgdbjOiT33ED3qD7wP-D8gnzLdHA3zxjdEmaKkipkA@mail.gmail.com>
In-Reply-To: <CAADnVQLAcgdbjOiT33ED3qD7wP-D8gnzLdHA3zxjdEmaKkipkA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Nov 2021 14:15:18 -0800
Message-ID: <CAEf4BzYJhCjQFLOdmjK5tHFkCxuB2XmqAmnYHPmsNuKz0B7WHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] Change bpftool, libbpf, selftests to
 force GNU89 mode
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 6, 2021 at 4:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 6, 2021 at 1:02 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Nov 6, 2021 at 9:34 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Nov 5, 2021 at 6:36 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > >
> > > > Fix any remaining instances that fail the build in this mode.  For selftests, we
> > > > also need to separate CXXFLAGS from CFLAGS, since adding it to CFLAGS simply
> > > > would generate a warning when used with g++.
> > > >
> > > > This also cherry-picks Andrii's patch to fix the instance in libbpf. Also tested
> > > > introducing new invalid usage of C99 features.
> > > >
> > > > Andrii Nakryiko (1):
> > > >   libbpf: fix non-C89 loop variable declaration in gen_loader.c
> > > >
> > > > Kumar Kartikeya Dwivedi (5):
> > > >   bpftool: Compile using -std=gnu89
> > > >   libbpf: Compile using -std=gnu89
> > > >   selftests/bpf: Fix non-C89 loop variable declaration instances
> > > >   selftests/bpf: Switch to non-unicode character in output
> > > >   selftests/bpf: Compile using -std=gnu89
> > >
> > > Please don't.
> > > I'd rather go the other way and drop gnu89 from everywhere.
> > > for (int i = 0
> > > is so much cleaner.
> >
> > I agree that for (int i) is better, but it's kernel code style which
> > we followed so far pretty closely for libbpf and bpftool. So I think
> > this is the right move for bpftool and libbpf.
>
> The kernel coding style is not white and black.
> Certain style preferences are archaic to say the least.
> It's not the right move to follow it blindly.

Can we at least add -std=gnu89 for the libbpf? It's a library, so
being conservative with compiler versions and language features makes
sense there. I'll add a similar flag to Github's Makefile. I'd rather
catch this at patch submission time rather than at the Github sync
time.
