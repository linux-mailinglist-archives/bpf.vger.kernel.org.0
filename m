Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726C236FF87
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhD3Rb5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3Rb5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 13:31:57 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40286C06174A
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 10:31:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b131so8608893ybg.5
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIVgTpDzC2LJOPNC1YMi/4UBALGtaH8FG8n3+mHuD+4=;
        b=B3PYRj1Dhu75AnMFjY20muHOBRlIzI67tHX22UtjO9pqEajmA/lgKqEOQX/ijGoRXf
         P3x+TXUGQPp4Av5fGuK6GzrpzRgwZahmYAgkissJkoab8g89j47Cblr7q9IBVAajYzRQ
         WBOf240HqVn6iyCu9hvVlDiTlzx4xEM7RIu0dkdi5/Uuou+H2xTD4t9T1f2bMdZClarS
         soy8nfBBnwl0mRB7d1gn8k1MpV4QFoqlQ8TsX/4lOPN+PaAS0VTDNd4u9xbEHFDqLff/
         P4XNz0sLNaYYVH6Qy7LPak2c4bg7gLgGce/YYOvnYF6DYurEYYFIshzo5j6kcri5ivCU
         Sg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIVgTpDzC2LJOPNC1YMi/4UBALGtaH8FG8n3+mHuD+4=;
        b=WRPXVKXGo5MUrQ7idAVmyNIUwk6lJ6OlbjjLE46ImCZqJQjgEMHxs1OObCin9bu5iQ
         PH+TYc5Y+4TKK8t1B9A1t3T14lug4i05ubOd8N8MXOyhQYRMMpB7PXrGS5Q7Uh8YHi+g
         WLKTXasANPLHdJPvuVagvZ1S+znfiROdwdPii/sYPeEu4VyVEBM3nBDyPSJ5p33e+Wfm
         hzAjA3pE0p4sf41m1lm/A4tFFFsFY5hPa4Bdj+NuxvVCBJ/trR/8nWrNF3vQiPM6IaZK
         GNZ/77oUpFN1Ok+QFFgPhdBgCwfkjgdNnB19b6uqcG0swd08AlkZ+lRFKFSeSRuDAK7c
         xMxw==
X-Gm-Message-State: AOAM531Ox6DWJs9RBQh3hoAQJOHr61NnbjadYoUDwK7tw47CjR7Le78E
        4x7CitVtWX9AARIhn/atqnDTAkVC/lz0VcldY5E=
X-Google-Smtp-Source: ABdhPJyOmiON3UZmFHsKMyn5lodSnzJoB2RBE/yq2krv/ImHLORGArlw2+NiEVfzb7rovNnlw5sEfpENVKbLwY2V5ls=
X-Received: by 2002:a25:9942:: with SMTP id n2mr8863646ybo.230.1619803867434;
 Fri, 30 Apr 2021 10:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
In-Reply-To: <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Apr 2021 10:30:56 -0700
Message-ID: <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 30, 2021 at 7:27 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Fri, Apr 30, 2021 at 10:22 AM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > Grant Seltzer Richman <grantseltzer@gmail.com> writes:
> >
> > > Hm, yes I do agree that it'd be nice to use existing tooling but I
> > > just have a couple concerns for this but please point me in the right
> > > direction because i'm sure i'm missing something. I was told to ask on
> > > the linux-doc mailing list because you'd have valuable input anway.
> > > This is based on reading
> > > https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#including-kernel-doc-comments
> > >
> > > 1. We'd want the ability to pull documentation from the code itself to
> > > make it so documentation never falls out of date with code. Based on
> > > the docs on kernel.org/doc it seems that we'd have to be explicit with
> > > specifying which functions/types are included in an .rst file and
> > > submit a patch to update the documentation everytime the libbpf api
> > > changes. Perhaps if this isn't a thing already I can figure out how to
> > > contribute it.
> >
> > No, you can tell it to pull out docs for all of the functions in a given
> > file.  You only need to name things if you want to narrow things down.
>
> Alright, I will figure out how to do this and adjust the patch
> accordingly. My biggest overall goal is making it as easy as possible
> to contribute documentation. I think even adding just one doc string
> above an API function is a great opportunity for new contributors to
> familiarize themselves with the mailing list/patch process.
>
> >
> > > 2. Would it be possible (or necessary) to separate libbpf
> > > documentation from the kernel readthedocs page since libbpf isn't part
> > > of the kernel?
> >
> > It could certainly be built as a separate "book", as are many of the
> > kernel books now.  I could see it as something that gets pulled into the
> > user-space API book, but there could also perhaps be an argument made
> > for creating a new "libraries" book instead.
>
> Yea if I can figure this out for the libbpf API it'd be great to
> replicate it for any API!

It would be great if it was possible to have this libbpf
auto-generated documentation as part of the kernel documentation, but
also be able to generate and export it into our Github mirror to be
pulled by readthedocs.io. If that can be done, it would be the best of
both kernel and external worlds. We have a sync script that already
auto-generates and checks in BPF helpers header, so we have a
precedent of checking in auto-generated stuff into Github. So it's
mostly about figuring out the mechanics of doc generation.

>
> >
> > Thanks,
> >
> > jon
