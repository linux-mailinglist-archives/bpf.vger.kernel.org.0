Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8E1334209
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 16:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhCJPst (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 10:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhCJPsV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 10:48:21 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98662C061760;
        Wed, 10 Mar 2021 07:48:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 18so34225697lff.6;
        Wed, 10 Mar 2021 07:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0/izLC33QT8uxDOJE1OEYsC8LaFZNZhkqwpThuvR7o=;
        b=LiVARqif4ZgNCwWk6sy+OjpAE5GiT2jzbCJvJ4wKJS1RiNbprqgYMgQEGEbxXnbwe7
         KME6SXtyTmhFF9daV3WhRD4PxrU2L4vyjc12VqbM6R33Iz+B5HSMZYc6eA1q6asY4JVK
         JQMQl8cLIpgoUjLZ7whYSAmTX6T3AktcpTPyVdsFBmu6aVK0z10iaEXm1j+2A8McMFCc
         m8u/1UFX93SXCXNpE9TapvruXPSpPAFAPBoYPAIv+wz5nUgyVXcEzlq1hUliTm0vajz7
         hh1Carc5gg91iIMAwcFupUR2lo0HRnhzBy03x1XOWuD/Z1g/ec66MHjGxKp1FEmiFBoZ
         8zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0/izLC33QT8uxDOJE1OEYsC8LaFZNZhkqwpThuvR7o=;
        b=QCFEgr1vE9j2/hkYOaqjp361f1Zih6aUJmjVMcR2Cq2YeSPi7odcm97MvqeRV8DJL5
         DIxDGDLIDr/p/Y32zExlAxZ80EI87U9zgT5gMWYUM5foqX93mWc3/bXsY1BDFkXwSTGF
         c7egbYPebAmYR07Y7rFHDat1Nj2MevjEa6jmN1aDj3HWnvn/9JlZ3qH8eQdGmndm+4LJ
         XaBiC2rz/d0nWQ5SgqUiRThtvdxNlbzbjhoSJ8rx3x0sj+cwb2dODIUG1An1eokJ0B1V
         sW3XjlAjOCG+br+8uID3kUCexAXzYP5jjvTrJltffTLsA5ZStxZZNj1D3TZirWcfB8lP
         NbcA==
X-Gm-Message-State: AOAM531dPAIEGgwY+M9UGAguoOCAMRVz3jXhshp9Y4T1KvP/g+YcTmXW
        KIpDs/8Ak+cJVY9mjgVGAJnwwB093Sr9kVP39yc=
X-Google-Smtp-Source: ABdhPJx0k0Onrmoqogz+C4r9PkiCCVDeFxJ5e/UyZUi108819RV3DeGqQX2VZELkgmJtR/uVOPu/uxKmCymGfp4HAls=
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr2420918lfu.534.1615391300045;
 Wed, 10 Mar 2021 07:48:20 -0800 (PST)
MIME-Version: 1.0
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
 <20210309120519.7c6bbb97@gandalf.local.home> <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
 <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com> <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
 <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net> <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net>
 <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net> <20210310091324.0c346d5f@oasis.local.home>
 <YEjWryS/9uB2y62O@hirez.programming.kicks-ass.net>
In-Reply-To: <YEjWryS/9uB2y62O@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Mar 2021 07:48:08 -0800
Message-ID: <CAADnVQKMRWMuAJEJBPADactdKaGx4opg3y82m7fy59rRmA9Cog@mail.gmail.com>
Subject: Re: The killing of ideal_nops[]
To:     Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 6:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 10, 2021 at 09:13:24AM -0500, Steven Rostedt wrote:
> > On Wed, 10 Mar 2021 11:22:48 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > After this FEATURE_NOPL is unused except for required-features for
> > > x86_64. FEATURE_K8 is only used for PTI and FEATURE_K7 is unused.
> > >
> > > AFAICT this negatively affects lots of 32bit (DONTCARE) and 32bit on
> > > 64bit CPUs (CARELESS) and early AMD (K8) which is from 2003 and almost
> > > 2 decades old by now (SHRUG).
> > >
> > > Everything x86_64 since AMD K10 (2007) was using p6_nops.
> > >
> > > And per FEATURE_NOPL being required for x86_64, all those CPUs can use
> > > p6_nops. So stop caring about NOPs, simplify things and get on with life
> > > :-)
> >
> > Before ripping out all the ideal_nop logic, I wonder if we should just
> > force the nops you want now (that is, don't change the selected
> > ideal_nops, just "pretend" that the CPU wants p6_nops), and see if anyone
> > complains. After a few releases, if there's no complaints, then we can
> > rip out the ideal_nop logic.
>
> Nah, just rip the entire thing out. You should be happy about
> deterministic NOPs :-)

Ack for bpf bits.
I think the cleanup is good from the point of having one way to do things.
Though I won't be surprised if somebody comes along with a patch
to use different nops eventually.
When I first looked at it years ago I was wondering why segment selector
prefix is not used. afaik windows was using it, because having cs: ds: nop
makes intel use only one of the instruction decoders (the big and slow one)
which allegedly saves power, since the pipeline has bubbles.
Things could be completely different now in modern u-arches.
