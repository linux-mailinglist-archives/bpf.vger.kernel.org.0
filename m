Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18431308B04
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 18:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhA2RJW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 12:09:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48834 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231859AbhA2RIz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 12:08:55 -0500
Received: from zn.tnic (p200300ec2f0c9a00bc6c1bcbdaab9684.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:bc6c:1bcb:daab:9684])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D3A61EC01B7;
        Fri, 29 Jan 2021 18:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611940080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6gynE/m5UUuwCga8k8q/Sc2TTu8o5jZHxq3BwRqCno=;
        b=HZ8EumBK4ro+eSLj320DKDuuco3JB/sEYzhmyZZWDxX1t7DY77Ri+rYoeCJPzXZcqoSfmf
        aiid5eTqF/V890+/hcrn282otPxqGkqCBvOI7b0VOsbDiPaC+PL+ILIeAsr+Y5+15y7w3q
        LXIloyRUvMLSf7JKXiwq9M1esiIcJ3k=
Date:   Fri, 29 Jan 2021 18:07:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, x86@kernel.org,
        Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] x86: Disable CET instrumentation in the kernel
Message-ID: <20210129170755.GF27841@zn.tnic>
References: <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <20210128165014.xc77qtun6fl2qfun@treble>
 <20210128215219.6kct3h2eiustncws@treble>
 <20210129102105.GA27841@zn.tnic>
 <20210129151034.iba4eaa2fuxsipqa@treble>
 <20210129163048.GD27841@zn.tnic>
 <20210129164932.qt7hhmb7x4ehomfr@treble>
 <fd874f37-5842-93ab-6b6b-872f028f2583@suse.com>
 <20210129170331.akmpnaqlwtfy4y6o@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210129170331.akmpnaqlwtfy4y6o@treble>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 11:03:31AM -0600, Josh Poimboeuf wrote:
> On Fri, Jan 29, 2021 at 06:54:08PM +0200, Nikolay Borisov wrote:
> > 
> > 
> > On 29.01.21 г. 18:49 ч., Josh Poimboeuf wrote:
> > > Agreed, stable is a good idea.   I think Nikolay saw it with GCC 9.
> > 
> > 
> > Yes I did, with the default Ubuntu compiler as well as the default gcc-10 compiler: 
> > 
> > # gcc -v -Q -O2 --help=target | grep protection
> > 
> > gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04) 
> > COLLECT_GCC_OPTIONS='-v' '-Q' '-O2' '--help=target' '-mtune=generic' '-march=x86-64'
> >  /usr/lib/gcc/x86_64-linux-gnu/9/cc1 -v -imultiarch x86_64-linux-gnu help-dummy -dumpbase help-dummy -mtune=generic -march=x86-64 -auxbase help-dummy -O2 -version --help=target -fasynchronous-unwind-tables -fstack-protector-strong -Wformat -Wformat-security -fstack-clash-protection -fcf-protection -o /tmp/ccSecttk.s
> > GNU C17 (Ubuntu 9.3.0-17ubuntu1~20.04) version 9.3.0 (x86_64-linux-gnu)
> > 	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.22.1-GMP
> > 
> > 
> > It has -fcf-protection turned on by default it seems. 
> 
> Yup, explains why I didn't see it:
> 
> gcc version 10.2.1 20201125 (Red Hat 10.2.1-9) (GCC)
> COLLECT_GCC_OPTIONS='-v' '-Q' '-O2' '--help=target' '-mtune=generic' '-march=x86-64'
>  /usr/libexec/gcc/x86_64-redhat-linux/10/cc1 -v help-dummy -dumpbase help-dummy -mtune=generic -march=x86-64 -auxbase help-dummy -O2 -version --help=target -o /tmp/cclBz55H.s

The fact that you triggered it with an Ubuntu gcc explains why the
original patch adding that switch:

29be86d7f9cb ("kbuild: add -fcf-protection=none when using retpoline flags")

came from a Canonical.

Adding the author to Cc for FYI.

Seth, you can find this thread starting here:

https://lkml.kernel.org/r/20210128215219.6kct3h2eiustncws@treble

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
