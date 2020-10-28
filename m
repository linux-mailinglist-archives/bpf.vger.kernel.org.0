Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB6629CD6E
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 02:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgJ1BiT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 21:38:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42851 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833076AbgJ1AGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 20:06:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id x13so1866821pfa.9
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SkTc2vk73nmebVshjgjHKREV7i/15yy96aB46LsoBJM=;
        b=jq2lkcWdmOTv8Lyx6yvybZKderM4WXlS2x5SBBIvdhQC/Hadg0P/Asbj5KmjCOTFJW
         b/5r/M8+iPrJTWUBXb1TpZz1FSZE9Wh3YyzP9ty15mnJxMgQl+mm7WMRmhYiQZc1bFhD
         kE4RwvzkUp3hEXlMoBodJdAcAXdxgbK7pYOyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SkTc2vk73nmebVshjgjHKREV7i/15yy96aB46LsoBJM=;
        b=cZADaEbNkJv6DfuOmNl+2DjFEN2hk6TxsJaziYbJBeafYBBYvDS4gvfJzPG5tC68Dp
         dhyuAPQ1+TS9YCNOytWjzO5e/0hqQGjvD/0YfGRHtSKkS2qOzhSCtE0euAlf7aX6LLD2
         fgsitMdf9go3hbsLBxkQz6xXUmA260sQkYBtFF83gziSsAU4KQgstRbS5TqMvE060mYC
         xBolbYVPR0lQFw4wXa01bKr8/dbNFTMaWx9S0+6iXftRvJIt/EdWjLWFN0JWKZwZCcDJ
         o46ZRRwav5ZkpeIEGApbje9YMfxsNM5foBENN5y+8C5p8ih3+X9inFKF0Sj/qEkv3/+G
         QmIQ==
X-Gm-Message-State: AOAM533G9qeVbT6si45QeXt/W58oep6zpxAdPOTAeiRrhj5HeHFWkGYm
        OCWdBJYtHWugHc/NHCDxcoVbXA==
X-Google-Smtp-Source: ABdhPJwkntKG+LnH43OBYo1mCeJ2Eb7oSC1DQiZMoYaqhPnztVbnQQPjzDgbtBZac+mXdy1h1HBdYQ==
X-Received: by 2002:aa7:9ad7:0:b029:160:948:44a6 with SMTP id x23-20020aa79ad70000b0290160094844a6mr4533190pfp.25.1603843611476;
        Tue, 27 Oct 2020 17:06:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm3688285pfw.36.2020.10.27.17.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 17:06:50 -0700 (PDT)
Date:   Tue, 27 Oct 2020 17:06:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 1/6] seccomp: Move config option SECCOMP to
 arch/Kconfig
Message-ID: <202010271653.B6D7D6B@keescook>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <9ede6ef35c847e58d61e476c6a39540520066613.1600951211.git.yifeifz2@illinois.edu>
 <CAMuHMdXTLKr6pvoE+JAdn_P5kVxL6gx8PJ8mqfXcS+SF+pRbkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXTLKr6pvoE+JAdn_P5kVxL6gx8PJ8mqfXcS+SF+pRbkQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 10:52:39AM +0100, Geert Uytterhoeven wrote:
> Hi Yifei,
> 
> On Thu, Sep 24, 2020 at 2:48 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > From: YiFei Zhu <yifeifz2@illinois.edu>
> >
> > In order to make adding configurable features into seccomp
> > easier, it's better to have the options at one single location,
> > considering easpecially that the bulk of seccomp code is
> > arch-independent. An quick look also show that many SECCOMP
> > descriptions are outdated; they talk about /proc rather than
> > prctl.
> >
> > As a result of moving the config option and keeping it default
> > on, architectures arm, arm64, csky, riscv, sh, and xtensa
> > did not have SECCOMP on by default prior to this and SECCOMP will
> > be default in this change.
> >
> > Architectures microblaze, mips, powerpc, s390, sh, and sparc
> > have an outdated depend on PROC_FS and this dependency is removed
> > in this change.
> >
> > Suggested-by: Jann Horn <jannh@google.com>
> > Link: https://lore.kernel.org/lkml/CAG48ez1YWz9cnp08UZgeieYRhHdqh-ch7aNwc4JRBnGyrmgfMg@mail.gmail.com/
> > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> 
> Thanks for your patch. which is now commit 282a181b1a0d66de ("seccomp:
> Move config option SECCOMP to arch/Kconfig") in v5.10-rc1.
> 
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -458,6 +462,23 @@ config HAVE_ARCH_SECCOMP_FILTER
> >             results in the system call being skipped immediately.
> >           - seccomp syscall wired up
> >
> > +config SECCOMP
> > +       def_bool y
> > +       depends on HAVE_ARCH_SECCOMP
> > +       prompt "Enable seccomp to safely compute untrusted bytecode"
> > +       help
> > +         This kernel feature is useful for number crunching applications
> > +         that may need to compute untrusted bytecode during their
> > +         execution. By using pipes or other transports made available to
> > +         the process as file descriptors supporting the read/write
> > +         syscalls, it's possible to isolate those applications in
> > +         their own address space using seccomp. Once seccomp is
> > +         enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
> > +         and the task is only allowed to execute a few safe syscalls
> > +         defined by each seccomp mode.
> > +
> > +         If unsure, say Y. Only embedded should say N here.
> > +
> 
> Please tell me why SECCOMP is special, and deserves to default to be
> enabled.  Is it really that critical, given only 13.5 (half of sparc
> ;-) out of 24
> architectures implement support for it?

That's an excellent point; I missed this in my review as I saw several
Kconfig already marked "def_bool y" but failed to note it wasn't _all_
of them. Okay, checking before this patch, these had them effectively
enabled:

via Kconfig:

parisc
s390
um
x86

via defconfig, roughly speaking:

arm
arm64
sh

How about making the default depend on HAVE_ARCH_SECCOMP_FILTER?

These have SECCOMP_FILTER support:

arch/arm/Kconfig:       select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
arch/arm64/Kconfig:     select HAVE_ARCH_SECCOMP_FILTER
arch/csky/Kconfig:      select HAVE_ARCH_SECCOMP_FILTER
arch/mips/Kconfig:      select HAVE_ARCH_SECCOMP_FILTER
arch/parisc/Kconfig:    select HAVE_ARCH_SECCOMP_FILTER
arch/powerpc/Kconfig:   select HAVE_ARCH_SECCOMP_FILTER
arch/riscv/Kconfig:     select HAVE_ARCH_SECCOMP_FILTER
arch/s390/Kconfig:      select HAVE_ARCH_SECCOMP_FILTER
arch/sh/Kconfig:        select HAVE_ARCH_SECCOMP_FILTER
arch/um/Kconfig:        select HAVE_ARCH_SECCOMP_FILTER
arch/x86/Kconfig:       select HAVE_ARCH_SECCOMP_FILTER
arch/xtensa/Kconfig:    select HAVE_ARCH_SECCOMP_FILTER

So the "new" promotions would be:

csky
mips
powerpc
riscv
xtensa

Which would leave only these two:

arch/microblaze/Kconfig:        select HAVE_ARCH_SECCOMP
arch/sparc/Kconfig:     select HAVE_ARCH_SECCOMP if SPARC64

At this point, given the ubiquity of seccomp usage (e.g. systemd), I
guess it's not unreasonable to make it def_bool y?

I'm open to suggestions!

-- 
Kees Cook
