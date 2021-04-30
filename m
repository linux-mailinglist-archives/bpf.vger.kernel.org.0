Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A74B36FBDE
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 16:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhD3OFN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 10:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhD3OFM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 10:05:12 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE46C06174A
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 07:04:24 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id w24so11686286vsq.5
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmoDdyrZ77i1psGcL2skgMqfivFbiqR08eLVr0v6rqw=;
        b=aQ/Q2hwt9HrdI7qvPn9ICVa8n9/jnPN76uFH3emYH4ZWeeBzgblWy7GHo4NBYlRCFH
         3R/pVCwNpvadbhgDEpznK62Qi2e2ZDVilwrMED+/plxjN8r1OruuuCep7J+WIWN+2Okp
         BaGh6M0HXLdOfIlYnvR/+HlbWeOLUYzsBNfY3xLu8dyqz9EjoGojJLx7W0YJK1A9OTPl
         v6V1p+S7VX7iCZ8jrFO37clUfxuLSlsx82onAetwsaNy3OEx9miRiRxeGu7IK5gilpcg
         BgihMlD1lGmnn9kGqYbFqtjpU9Pb4IW6VOzIRUyb5BWZDL69w7oFER/EVEPE4WhcfJJ/
         WGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmoDdyrZ77i1psGcL2skgMqfivFbiqR08eLVr0v6rqw=;
        b=D4ZO6vmvszXuSpCdx0FoTXjc458aUTCwJ3YDZLLQgnwkij33/VEg8vcxyiPANJRwvM
         VgyPUvnKun6T3MIPnKCSL7nekHBxGUrf5lHLeKlISfoLXhHDC6Pjp9RbGwJ/cKhRQyw2
         4son0vHiPWptYkmYAvSWuaHSJH87A1LtTvDdHkwexYVuWe/BN5I/BfQpZGEUKAoPmBjG
         1HL0SYdXZt5UJP/r1Hngq37XzI4eM+/pITKHMPQ5exiH/zb0I90Cw3Ij6Il0YfkAHzk5
         +OMfQr0CnqH71SIFVbT1mfWeJpHpkgBfmacPNPHtFaU/wmWE2sbBHNMes9eIEH8fkGDU
         3Zaw==
X-Gm-Message-State: AOAM533Jide/LYCM37e3OsqmO41kNzNqt4y5ldRvXkEuohh96hfsbFtu
        WNZFJ6XlSWp1KQyx9W5ipLPJBBfR6mPcf1RRCDOm3b9XApKCrRVjaf4=
X-Google-Smtp-Source: ABdhPJwh33cgMLcaB69Xqhr9KOhpcOIrHktR9HNf2FJL2Jyg8UQMN2h92ycl39y9E1ZKv7Q3PNr0RF+i4IX0mbgvohk=
X-Received: by 2002:a05:6102:38d:: with SMTP id m13mr6263140vsq.25.1619791463405;
 Fri, 30 Apr 2021 07:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com> <877dkkd7gp.fsf@meer.lwn.net>
In-Reply-To: <877dkkd7gp.fsf@meer.lwn.net>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 30 Apr 2021 10:04:12 -0400
Message-ID: <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 29, 2021 at 6:57 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> grantseltzer <grantseltzer@gmail.com> writes:
>
> > This series of patches is meant to start the initiative to document libbpf.
> > It includes .rst files which are text documentation describing building,
> > API naming convention, as well as an index to generated API documentation.
>
> So I'm totally in favor of documenting libbpf...
>
> > The generated API documentation is enabled by Doxygen, which actually
> > parses the code for documentation comment strings and generates XML.
> > A tool called Sphinx then reads this XML with the help of the breathe
> > plugin, as well as the above mentioned .rst files and generates beautiful
> > HTML output.
> >
> > The goal of this is for readthedocs.io to be able to pick up that generated
> > documentation which will be made possible with the help of readthedoc's
> > github integration and libbpf's official github mirror. Minor setup
> > is required in that mirror once this patch series is merged.
>
> ...but I do have to wonder why you are doing something outside of the
> kernel's documentation system, which just happens to be based on a tool
> called Sphinx.  It would be Really Nice to have this documentation part
> of our doc tree; it would also be good to not bring in yet another tool
> for building kernel docs.
>
> Do you really need to do your own thing here?

Hm, yes I do agree that it'd be nice to use existing tooling but I
just have a couple concerns for this but please point me in the right
direction because i'm sure i'm missing something. I was told to ask on
the linux-doc mailing list because you'd have valuable input anway.
This is based on reading
https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#including-kernel-doc-comments

1. We'd want the ability to pull documentation from the code itself to
make it so documentation never falls out of date with code. Based on
the docs on kernel.org/doc it seems that we'd have to be explicit with
specifying which functions/types are included in an .rst file and
submit a patch to update the documentation everytime the libbpf api
changes. Perhaps if this isn't a thing already I can figure out how to
contribute it.

2. Would it be possible (or necessary) to separate libbpf
documentation from the kernel readthedocs page since libbpf isn't part
of the kernel?

Thanks so much,
Grant

> Thanks,
>
> jon
