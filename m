Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD59A30E977
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 02:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhBDBcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 20:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhBDBb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 20:31:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBCFC0613D6
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 17:31:18 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id b21so1006973pgk.7
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 17:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJqnhB5HVj5MI8qvIgTsWnsv8A6arsvgFZ5dYqMe6qM=;
        b=m+Eh59y2xsdnp+1LpDbiAgN0Kzvnz4LwOWrCOwMQg3rsSpuXecVX+c1HBeBVr6S2Ao
         9P3QyLUTCSZfNOALC3KN63xy1dyBzY4lx3oroHYhH8zaJWS2zd87L/lSPLiUIlteDF+a
         6EbAS21kqksqw6D3A84SVgapYHnnJc7SRlqThvIb35YmuckaDP3XEg5D/rumXJHIHgaK
         AcbXBhKhX4s8wev9BG72pyRux0z6Px5kp8IxBMAh41/zwu2HF6hqu8JWvt4qExAWP4/X
         0IXOSI1zLWpIF/kn98J6ibyAYEcZEVj8o0agQb2JlrsDHSJrbWybHuPDVSSxeAp5Ekp/
         RYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJqnhB5HVj5MI8qvIgTsWnsv8A6arsvgFZ5dYqMe6qM=;
        b=sOgjFEsnI5dOKcXQQ7GhopQ17hCj6wsy6cDHTega2u4yh+4l7pw+/NrH3RhPtEXGy1
         ZonD0V/xbPCWGCAiE+aGGnzikV3DLHn7UHLwxNXVCAH1+FCmLcO2AyeVUmtg/lni3YCs
         z8uXvAu9HMXvbRwm95yOWnf5YmbNlYBKuW+cjsiGu3Ha5wEjYzuwU28L5Sz/Rcz8WwXu
         dh0qW7qu0X6IS5pqfusFd93IDlW6LGKjpUZKOX7ScAd76R4eLbEcs50GCI0MTsTrtfpH
         LG+PhpMMBMIwLZyEfaNP6wZck52ZTGun1Ah0pAy6U9lVBYAsB0yRx5K+b3iNTml8yTMH
         ACwQ==
X-Gm-Message-State: AOAM533FkulE9Bz8JnkNdc62jqPCpa3CwVCnnU9kLHE6TmAc4epaf0vB
        +5ihW58Tbazj5bLvUsjBblAUNsxCz4E92TBzYYYg9A==
X-Google-Smtp-Source: ABdhPJxr3rLB/E1G8S1nW2JPZMVdN7cLT+ZjzmaMOGnRre01XJb9SALC+eAJ6fFfxsy7ER8je1Qa0RSQEYA4XtApfTg=
X-Received: by 2002:a63:7e10:: with SMTP id z16mr6561848pgc.263.1612402277804;
 Wed, 03 Feb 2021 17:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com> <20210117201500.GO457607@kernel.org>
In-Reply-To: <20210117201500.GO457607@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Feb 2021 17:31:05 -0800
Message-ID: <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 17, 2021 at 12:14 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jan 15, 2021 at 03:43:06PM -0800, Yonghong Song escreveu:
> >
> >
> > On 1/15/21 3:34 PM, Nick Desaulniers wrote:
> > > On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > >
> > > >
> > > > On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > > > > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > > > > CONFIG_DEBUG_INFO_DWARF4.
> > > > > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
> > >
> > > Can you privately send me your configs that repro? Maybe I can isolate
> > > it to a set of configs?
> > >
> > > >
> > > > I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> > > > It is not there before and adding this may suddenly break some users.
> > > >
> > > > If certain combination of gcc/llvm does not work for
> > > > CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> > > > should fix.
> > >
> > > Is there a place I should report bugs?
> >
> > You can send bug report to Arnaldo Carvalho de Melo <acme@kernel.org>,
> > dwarves@vger.kernel.org and bpf@vger.kernel.org.
>
> I'm coming back from vacation, will try to read the messages and see if
> I can fix this.

IDK about DWARF v4; that seems to work for me.  I was previously observing
https://bugzilla.redhat.com/show_bug.cgi?id=1922698
with DWARF v5.  I just re-pulled the latest pahole, rebuilt, and no
longer see that warning.

I now observe a different set.  I plan on attending "BPF office hours
tomorrow morning," but if anyone wants a sneak peak of the errors and
how to reproduce:
https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781


(FWIW: some other folks are hitting issues now with kernel's lack of
DWARF v5 support: https://bugzilla.redhat.com/show_bug.cgi?id=1922707)
-- 
Thanks,
~Nick Desaulniers
