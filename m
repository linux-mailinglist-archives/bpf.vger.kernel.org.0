Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375B92BBE47
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 10:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgKUJtA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Nov 2020 04:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgKUJs7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Nov 2020 04:48:59 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC5C061A49
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2020 01:48:57 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so16989508lfc.4
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2020 01:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQiLNTLnW3SLtn0YsnDFKEJnLKO+RrQeEC1pO6DUX3I=;
        b=NDK1nLAguE/ieGaWEY+FmLBnFzKQ+keiUbLA87fRWbeoBl0TUnxoIWidngljNw3njr
         T9o8cTivwQ/PNTS8SRA8GGOH3lhovcdXa7KS3UtRt1obJiBdyCZZl9Xlfw4rzkmyGOTd
         uLGvEZ1QZa5J6Tp8nfw/NzJd+K1nkbMjtRkcCChOxm0B7P2+fVxhLjJYZYL3Q7DkFqaR
         T3AKSwfY5cZnPoVzlZ66HzscshjnesEaQzqHuuFTVW0GRzwo5rZ75HFGKONmKLB103Am
         QO3KboK3J0HYVm4pMpi2LzNDqw5WjPohXcC1BMna74BqabedOAZCTbSZTqUHiUTJ5sWr
         xRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQiLNTLnW3SLtn0YsnDFKEJnLKO+RrQeEC1pO6DUX3I=;
        b=Pmqwtd/m8N/5Bvm05kaWg1PVofr5R7vLFvQVkw0SAv5luUFzJSH8M/O0mQJNtn1dMR
         q3PeTkWVgrQL9/5agEeyycu4SZOhZkeF1ygSNrHaHEvqHkFuMAUmF7eNm+Rj94/Tcg2J
         TtT6p9X760F/Hhmgq/vXJ/mFNLH0OblVBdY3VxWSqZWRhPhhYek41PmlV0MsJAjDpI8f
         +DvRIYm7ei/FZYK9vZkMpeD1A5WttgxZNLiVlT6RY6DY+7hUA3qix9Q6Q3qmb46oKg1k
         uOVCnwWWVARaiB0nu/XwHkbnJzwyZhp+wuOvqe8MPiXQ0gHLY8X6PKgazQrZlKONwAAx
         PqGQ==
X-Gm-Message-State: AOAM531BijshdVN+cUQKCZ1NH7azcEn6JvNM917CLlsN0L25Z1lHP/t9
        3VbS5Fk1Yt//6D4zBasaX8ea2ce5Yj8IoKtxjFypBQ==
X-Google-Smtp-Source: ABdhPJxud8h9+Zsb7MJedEB+VgeNBdrfewqkbrhXLdc6jkC62nTrXEoFHkJAkLhxgIShY2CKy1qJr682LJJZVeaTVL4=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr9769828lfg.167.1605952135886;
 Sat, 21 Nov 2020 01:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20201119085022.3606135-1-davidgow@google.com> <CAEf4BzY4i0fH34eO=-4WOzVpifgPmJ0ER5ipBJWB0_4Zdv0AQg@mail.gmail.com>
In-Reply-To: <CAEf4BzY4i0fH34eO=-4WOzVpifgPmJ0ER5ipBJWB0_4Zdv0AQg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 21 Nov 2020 17:48:44 +0800
Message-ID: <CABVgOSn10kCaD7EQCMJTgD8udNx6fOExqUL1gXHzEViemiq3LA@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: preload: Fix build error when O= is set
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 21, 2020 at 3:38 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 12:51 AM David Gow <davidgow@google.com> wrote:
> >
> > If BPF_PRELOAD is enabled, and an out-of-tree build is requested with
> > make O=<path>, compilation seems to fail with:
> >
> > tools/scripts/Makefile.include:4: *** O=.kunit does not exist.  Stop.
> > make[4]: *** [../kernel/bpf/preload/Makefile:8: kernel/bpf/preload/libbpf.a] Error 2
> > make[3]: *** [../scripts/Makefile.build:500: kernel/bpf/preload] Error 2
> > make[2]: *** [../scripts/Makefile.build:500: kernel/bpf] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [.../Makefile:1799: kernel] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:185: __sub-make] Error 2
> >
> > By the looks of things, this is because the (relative path) O= passed on
> > the command line is being passed to the libbpf Makefile, which then
> > can't find the directory. Given OUTPUT= is being passed anyway, we can
> > work around this by explicitly setting an empty O=, which will be
> > ignored in favour of OUTPUT= in tools/scripts/Makefile.include.
>
> Strange, but I can't repro it. I use make O=<absolute path> all the
> time with no issues. I just tried specifically with a make O=.build,
> where .build is inside Linux repo, and it still worked fine. See also
> be40920fbf10 ("tools: Let O= makes handle a relative path with -C
> option") which was supposed to address such an issue. So I'm wondering
> what exactly is causing this problem.
>
[+ linux-um list]

Hmm... From a quick check, I can't reproduce this on x86, so it's
possibly a UML-specific issue.

The problem here seems to be that $PWD is, for whatever reason, equal
to the srcdir on x86, but not on UML. In general, $PWD behaves pretty
weirdly -- I don't fully understand it -- but if I add a tactical "PWD
:= $(shell pwd)" or use $(CURDIR) instead, the issue shows up on x86
as well. I guess this is because PWD only gets updated when set by a
shell or something, and UML does this somewhere?

Thoughts?

Cheers,
-- David

> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > Hi all,
> >
> > I'm not 100% sure this is the correct fix here -- it seems to work for
> > me, and makes some sense, but let me know if there's a better way.
> >
> > One other thing worth noting is that I've been hitting this with
> > make allyesconfig on ARCH=um, but there's a comment in the Kconfig
> > suggesting that, because BPF_PRELOAD depends on !COMPILE_TEST, that
> > maybe it shouldn't be being built at all. I figured that it was worth
> > trying to fix this anyway.
> >
> > Cheers,
> > -- David
> >
> >
> >  kernel/bpf/preload/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
> > index 23ee310b6eb4..39848d296097 100644
> > --- a/kernel/bpf/preload/Makefile
> > +++ b/kernel/bpf/preload/Makefile
> > @@ -5,7 +5,7 @@ LIBBPF_A = $(obj)/libbpf.a
> >  LIBBPF_OUT = $(abspath $(obj))
> >
> >  $(LIBBPF_A):
> > -       $(Q)$(MAKE) -C $(LIBBPF_SRCS) OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
> > +       $(Q)$(MAKE) -C $(LIBBPF_SRCS) O= OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
> >
> >  userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
> >         -I $(srctree)/tools/lib/ -Wno-unused-result
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
