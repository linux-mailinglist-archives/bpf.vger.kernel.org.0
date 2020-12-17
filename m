Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54862DCE18
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 10:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgLQJHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 04:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgLQJHF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 04:07:05 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F6C061285
        for <bpf@vger.kernel.org>; Thu, 17 Dec 2020 01:06:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u18so55474709lfd.9
        for <bpf@vger.kernel.org>; Thu, 17 Dec 2020 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAO/2/47mbhlLw+965PNTisNKeQzGGv2Q/ZDNBlq8ho=;
        b=ug3HU0/BD5jHUI6DBI3tUcGDLe5Vi0dADf7CQjmuw/ZLMEvO78n6LoGbJVJ9/LH/oY
         02XfSpETFlVPf2/TuFtgteUxWs4gqgZd8XpPPXZqFJ+3W7fYS2Mo4+z/BVYuNpus6vtz
         pyZo35hXAxYxPKHwOWQEa28G/ws1llfu1/sO/dgTA2sCj2CHq+PjFNtbH5wP9b92HQTt
         CUhhGqnd82VO3vyy5jObExl/xwXUQsiT+DVOkAQGGLq1JmbCb+tOKMnYVsNUdxnvshLX
         AD/iJCQ8RHOTiwU9+j7lRaeJCvbkpPvketTDkElKJfk82Cv9xmcLl4GgDQXxLVZm4TIP
         EXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAO/2/47mbhlLw+965PNTisNKeQzGGv2Q/ZDNBlq8ho=;
        b=J6AzuzGCZKhXafO+Fu11Zj7MkasaQbW6zYEFVwhQvT6Mv5m/EWvGYfHfVjjYau/S9r
         mJYIS+r2cXnzSxemBXitQBUHbZgBy6y1QTYeJaa58wzTNcsX8AUErLCbL86hBG2cCQ8K
         tZn9iOWa1Xzo3+d5zr4lTyzFDs0sOnmuY+NIxj7PirT8KNZFF//t/1M35DqJwvXb65Jm
         2mhhAXXUuW1n8kAUIAFetEduSdVCSywmbyWkx0n9MNbuNDwRHlJNMwq47sXJKENpfnd2
         wp5WbY097aRplzwYfpAsvAMey3BhY39JIuUkIjIQfLQ7zgaOK+NYOz7AxFI/NODu8q1f
         3k0w==
X-Gm-Message-State: AOAM531K8ies/TSR6iUb04rBlcg4GOojH4VyfdY8HIHrHZegtvC1ddHi
        /MSR/6fKEFxVS5xwbJnqpoATbdGcY8WhZdlt8a0hRA==
X-Google-Smtp-Source: ABdhPJxsq2p+kthVsRGDbdBPYMJuYG963MsSL6IXTPPE/fUcPdixmm5ttc1CfxGFCERB7fPnA+WDEJZLkKAp9rbYRAA=
X-Received: by 2002:a05:6512:30a:: with SMTP id t10mr911692lfp.124.1608195972094;
 Thu, 17 Dec 2020 01:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20201119085022.3606135-1-davidgow@google.com> <CAEf4BzY4i0fH34eO=-4WOzVpifgPmJ0ER5ipBJWB0_4Zdv0AQg@mail.gmail.com>
 <CABVgOSn10kCaD7EQCMJTgD8udNx6fOExqUL1gXHzEViemiq3LA@mail.gmail.com> <3678c6eb-3815-a360-f495-fc246513f0f5@isovalent.com>
In-Reply-To: <3678c6eb-3815-a360-f495-fc246513f0f5@isovalent.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 17 Dec 2020 17:05:59 +0800
Message-ID: <CABVgOSmRrtHQ_6n43kFk6MFYCpf+cS-E=TOiwS=__v6wGNeMNQ@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: preload: Fix build error when O= is set
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Wed, Dec 16, 2020 at 10:53 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> 2020-11-21 17:48 UTC+0800 ~ David Gow <davidgow@google.com>
> > On Sat, Nov 21, 2020 at 3:38 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Thu, Nov 19, 2020 at 12:51 AM David Gow <davidgow@google.com> wrote:
> >>>
> >>> If BPF_PRELOAD is enabled, and an out-of-tree build is requested with
> >>> make O=<path>, compilation seems to fail with:
> >>>
> >>> tools/scripts/Makefile.include:4: *** O=.kunit does not exist.  Stop.
> >>> make[4]: *** [../kernel/bpf/preload/Makefile:8: kernel/bpf/preload/libbpf.a] Error 2
> >>> make[3]: *** [../scripts/Makefile.build:500: kernel/bpf/preload] Error 2
> >>> make[2]: *** [../scripts/Makefile.build:500: kernel/bpf] Error 2
> >>> make[2]: *** Waiting for unfinished jobs....
> >>> make[1]: *** [.../Makefile:1799: kernel] Error 2
> >>> make[1]: *** Waiting for unfinished jobs....
> >>> make: *** [Makefile:185: __sub-make] Error 2
> >>>
> >>> By the looks of things, this is because the (relative path) O= passed on
> >>> the command line is being passed to the libbpf Makefile, which then
> >>> can't find the directory. Given OUTPUT= is being passed anyway, we can
> >>> work around this by explicitly setting an empty O=, which will be
> >>> ignored in favour of OUTPUT= in tools/scripts/Makefile.include.
> >>
> >> Strange, but I can't repro it. I use make O=<absolute path> all the
> >> time with no issues. I just tried specifically with a make O=.build,
> >> where .build is inside Linux repo, and it still worked fine. See also
> >> be40920fbf10 ("tools: Let O= makes handle a relative path with -C
> >> option") which was supposed to address such an issue. So I'm wondering
> >> what exactly is causing this problem.
> >>
> > [+ linux-um list]
> >
> > Hmm... From a quick check, I can't reproduce this on x86, so it's
> > possibly a UML-specific issue.
> >
> > The problem here seems to be that $PWD is, for whatever reason, equal
> > to the srcdir on x86, but not on UML. In general, $PWD behaves pretty
> > weirdly -- I don't fully understand it -- but if I add a tactical "PWD
> > := $(shell pwd)" or use $(CURDIR) instead, the issue shows up on x86
> > as well. I guess this is because PWD only gets updated when set by a
> > shell or something, and UML does this somewhere?
> >
> > Thoughts?
> >
> > Cheers,
> > -- David
>
> Hi David, Andrii,
>
> David, did you use a different command for building for UML and x86? I'm
> asking because I reproduce on x86, but only for some targets, in
> particular when I tried bindeb-pkg.

I just ran "make ARCH={x86,um} O=.bpftest", with defconfig + enabling
BPF_PRELOAD and its dependencies. UML fails, x86 works. (Though I can
reproduce the failure if I make bindeb-pkg on x86).

(It also shows up when building UML with the allyesconfig-based KUnit
alltests option by running "./tools/testing/kunit/kunit.py run
--alltests", though this understandably takes a long time and is less
obvious)
>
> With "make O=.build vmlinux", I have:
> - $(O) for "dummy" check in tools/scripts/Makefile.include set to
> /linux/.build
> - $(PWD) for same check set to /linux/tools
> - Since $(O) is an absolute path, the "dummy" check passes
>
> With "make O=.build bindeb-pkg", I have instead:
> - $(O) set to .build (relative path)
> - $(PWD) set to /linux/.build
> - "dummy" check changes to /linux/.build and searches for .build in it,
> which fails and aborts the build
>
> (tools/scripts/Makefile.include is included from libbpf's Makefile,
> called from kernel/bpf/preload/Makefile.)
>
> I'm not sure how exactly the bindeb-pkg target ends up passing these values.

Yeah: I haven't been able to find where uml is changing them either:
I'm assuming there's something which changes directory and/or spawns a
shell/recursive make to change $(PWD) or something.

> For what it's worth, I have been solving this (before finding this
> thread) with a fix close to yours, I pass "O=$(abspath .)" on the
> command line for building libbpf in kernel/bpf/preload/Makefile. It
> looked consistent to me with the "tools/:" target from the main
> Makefile, where "O=$(abspath $(objtree))" is passed (and $(objtree) is ".").

Given that there are several targets being broken here, it's probably
worth having a fix like this which overrides O= rather than trying to
hunt down every target which could change $(PWD). I don't particularly
mind whether we use O= or O=$(abspath .), both are working in the UML
usecase as well.

Does anyone object to basically accepting either this patch as-is, or
using O=$(abspath .)?


Cheers,
-- David
