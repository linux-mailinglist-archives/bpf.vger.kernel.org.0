Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59982CB504
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgLBG2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 01:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLBG2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 01:28:39 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8691C0613CF;
        Tue,  1 Dec 2020 22:27:58 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id v3so557906ilo.5;
        Tue, 01 Dec 2020 22:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZP21scfrVgE50R5j7SIVdlWyVzodOKgwNSHKNuQhmxw=;
        b=bCYFj+rKd5vrLuz/0DegxAvsug1bKm0jNjJeos43H8ztKDCXa7etoGg5AY1w2/UBY5
         s4Af9xmcwtetvNy8J0TUdMsfHjmWwqB8nVGclDFXP741e1wAmrc5AIW7aDUMzjqpuLD0
         lVrZkZZLGjL9AVBB7S50NtF+YudVam065U8hPL/+mxQyczU8iOPDxxsx4EFglreIEQmK
         LaA0HPr1mLTWqh7Uqs7TIZDd2oQYyCdpKHtWJYepHZ9UzJClGvnmRi8tR8h92tXuEMwH
         twY2pR4ii1QnOC3MG4rxYJvreR5io4Vbe8hRXouiqpbNFCGDi0CG5ks9Rpnf0Hv/jq9c
         MUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZP21scfrVgE50R5j7SIVdlWyVzodOKgwNSHKNuQhmxw=;
        b=Gnc+XIpQl4yoxin4IU7bPPim5wD9L8D6fz0Q9YDo2AJoXT10mG5txCSlYRqnzHw+lV
         vz2z3RT+JzJvqNKkTDrAjk9NwejD6yqpZ5vHzcumrjDvo0qZV1i6mJdgQWkf5nkEVWg4
         7/gmvDTUglP2dqWZyVNkhTOIArlT1KHbiS3XmmAx/Q6JDZbmXpdKt9phJi1O4wThXI1T
         I3s0u00I+LxcBQDQo1CPs88l8HGxfH4V2WoAwmFMxVYNZO94JS7ebBipYBxZKKYdNWoB
         3LcCEC/hTBWVppg5XAM7BIsvxyLsO4wkdW1PkYhLL3splaA8AmJqtQn5rduGEzqR6Xwf
         fOdA==
X-Gm-Message-State: AOAM531hIjjKwYtzCYEnTWFg1OaMy3OEzW/j1oTjCFAwJAseCqgaY0Rk
        lll11JD0W/2VcWHXHGuEgyo=
X-Google-Smtp-Source: ABdhPJw4S6FKPKJyRgB6CBHc+RPrlvjwV+yGzm+tq0rLGe7cei9HxR5xYVEEbbGlj75qzpqaN9Ndsw==
X-Received: by 2002:a92:d20c:: with SMTP id y12mr1195869ily.178.1606890478239;
        Tue, 01 Dec 2020 22:27:58 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id k28sm444866ilg.40.2020.12.01.22.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 22:27:57 -0800 (PST)
Date:   Tue, 01 Dec 2020 22:27:48 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Message-ID: <5fc733e42f63f_15eb720841@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzY0vHvrj4jAc+qszSMcYABd0dGFVxkM-d8S=wwHoDFD=A@mail.gmail.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
 <20201129014000.3z6eua5pcz3jxmtk@ast-mbp>
 <b3903adc-59c6-816f-6512-2225c28f47f5@fb.com>
 <4fa9f8cf-aaf8-a63c-e0ca-7d4c83b01578@fb.com>
 <CAEf4BzYc=c_2xCMFAE6RjMCHKWJj2euP2B21y-jfvsNzPVkhpQ@mail.gmail.com>
 <31a67edd-4837-cfd3-c9fe-a6942ebd87bb@fb.com>
 <5fc72beede900_15eb720850@john-XPS-13-9370.notmuch>
 <CAEf4BzY0vHvrj4jAc+qszSMcYABd0dGFVxkM-d8S=wwHoDFD=A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Tue, Dec 1, 2020 at 9:53 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Yonghong Song wrote:
> > >
> > >
> >
> > [...]
> >
> > > > Great, this means that all existing valid uses of
> > > > __sync_fetch_and_add() will generate BPF_XADD instructions and will
> > > > work on old kernels, right?
> > >
> > > That is correct.
> > >
> > > >
> > > > If that's the case, do we still need cpu=v4? The new instructions are
> > > > *only* going to be generated if the user uses previously unsupported
> > > > __sync_fetch_xxx() intrinsics. So, in effect, the user consciously
> > > > opts into using new BPF instructions. cpu=v4 seems like an unnecessary
> > > > tautology then?
> > >
> > > This is a very good question. Essentially this boils to when users can
> > > use the new functionality including meaningful return value  of
> > > __sync_fetch_and_add().
> > >    (1). user can write a small bpf program to test the feature. If user
> > >         gets a failed compilation (fatal error), it won't be supported.
> > >         Otherwise, it is supported.
> > >    (2). compiler provides some way to tell user it is safe to use, e.g.,
> > >         -mcpu=v4, or some clang macro suggested by Brendan earlier.
> > >
> > > I guess since kernel already did a lot of feature discovery. Option (1)
> > > is probably fine.
> >
> > For option (2) we can use BTF with kernel version check. If kernel is
> > greater than kernel this lands in we use the the new instructions if
> > not we use a slower locked version. That should work for all cases
> > unless someone backports patches into an older case.
> 
> Two different things: Clang support detection and kernel support
> detection. You are talking about kernel detection, I and Yonghong were
> talking about Clang detection and explicit cpu=v4 opt-in.
> 

Ah right, catching up on email and reading the thread backwords I lost
the context thanks!

So, I live in a dev world where I control the build infrastructure so
always know clang/llvm versions and features. What I don't know as
well is where the program I just built might be run. So its a bit
of an odd question from my perspective to ask if my clang supports
feature X. If it doesn't support feature X and I want it we upgrade
clang so that it does support it. I don't think we would ever
write a program to test the assertion. Anyways thanks.

> For kernel detection, if there is an enum value or type that gets
> added along the feature, then with CO-RE built-ins it's easy to detect
> and kernel dead code elimination will make sure that unsupported
> instructions won't trip up the BPF verifier. Still need Clang support
> to compile the program in the first place, though.

+1

> 
> If there is no such BTF-based way to check, it is still possible to
> try to load a trivial BPF program with __sync_fech_and_xxx() to do
> feature detection and then use .rodata to turn off code paths relying
> on a new instruction set.

Right.

> 
> >
> > At least thats what I'll probably end up wrapping in a helper function.


