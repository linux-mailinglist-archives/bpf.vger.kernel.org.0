Return-Path: <bpf+bounces-70975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5440BDD815
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 10:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C4F4FDF68
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1431A05E;
	Wed, 15 Oct 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2GajTWI6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C015316904;
	Wed, 15 Oct 2025 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518021; cv=none; b=ioYl7bgnqT+IQc1eamLIKONxjJ26fEvFDVc1Tk+4BbkvZ+K4la6fF2YuojM0mXEeuik27ck4EPicBMLlXcyzlCMZq80/lMw6Vl0WLc67h0maIclKxS3K+tE5mOy6vXPElbyPqJOR4hoXf+Rz3SFYaMtodtQoYcL2SV4ADgSGu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518021; c=relaxed/simple;
	bh=FrHWepJ+8TvdR3frU07jDniqnzcYnUTc9jm9aMDPuzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlrenK62kf0m5jQwJpETxfBXil7IKL9ahZVW9lW5W6tADTjb9wOX6XURmm7KMHgymS1jrMJ61lf69BwJKgHgifs1vOJ69X0VrWOOPZ6adPZMHw6zhsezaRG6iwQ7QkJ5StsqUcqPy5izgMOntKjoOlGNAYX9VkqKV+T90j6Kn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2GajTWI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84504C4CEF8;
	Wed, 15 Oct 2025 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760518021;
	bh=FrHWepJ+8TvdR3frU07jDniqnzcYnUTc9jm9aMDPuzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2GajTWI6IShclxIK3xp+QleHTNrLdlEHd6vrHatCgHl0HTYmNECTWKuF7S288sa/a
	 bWWN8awwPQ+19AGfaigECrxqmT6SyLHf8RoxLJzhi/lmUhIHogltc2IBHr+GtMqx2u
	 zx+bw0eGEF3F1UgnTV1KKzNl1afJWCPlC37qgrts=
Date: Wed, 15 Oct 2025 10:46:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, Daniel Borkmann <daniel@iogearbox.net>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	linux-s390@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
Message-ID: <2025101523-foster-impotent-6649@gregkh>
References: <20251013144326.116493600@linuxfoundation.org>
 <CA+G9fYsdErtgqKuyPfFhMS9haGKavBVCHQnipv2EeXM3OK0-UQ@mail.gmail.com>
 <CA+G9fYuV-J7N0cAy30X+rLCRrER071nMkk9JC6kjDw1U0gEzJg@mail.gmail.com>
 <69b2bf4c5d3aa7fd9c5b6822a03666f616eafe13.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69b2bf4c5d3aa7fd9c5b6822a03666f616eafe13.camel@linux.ibm.com>

On Tue, Oct 14, 2025 at 04:45:11PM +0200, Ilya Leoshkevich wrote:
> On Tue, 2025-10-14 at 19:38 +0530, Naresh Kamboju wrote:
> > On Tue, 14 Oct 2025 at 16:56, Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > > 
> > > On Mon, 13 Oct 2025 at 20:38, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > This is the start of the stable review cycle for the 6.12.53
> > > > release.
> > > > There are 262 patches in this series, all will be posted as a
> > > > response
> > > > to this one.  If anyone has any issues with these being applied,
> > > > please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > >        
> > > > https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
> > > > or in the git tree and branch at:
> > > >        
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> > > > stable-rc.git linux-6.12.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > The S390 defconfig builds failed on the Linux stable-rc 6.12.53-rc1
> > > and 6.6.112-rc1 tag build due to following build warnings / errors
> > > with gcc and clang toolchains.
> > > 
> > > Also seen on 6.6.112-rc1.
> > > 
> > > * s390, build
> > >   - clang-21-defconfig
> > >   - clang-nightly-defconfig
> > >   - clang-nightly-lkftconfig-hardening
> > >   - clang-nightly-lkftconfig-lto-full
> > >   - clang-nightly-lkftconfig-lto-thing
> > >   - gcc-14-allmodconfig
> > >   - gcc-14-defconfig
> > >   - gcc-14-lkftconfig-hardening
> > >   - gcc-8-defconfig-fe40093d
> > >   - gcc-8-lkftconfig-hardening
> > >   - korg-clang-21-lkftconfig-hardening
> > >   - korg-clang-21-lkftconfig-lto-full
> > >   - korg-clang-21-lkftconfig-lto-thing
> > > 
> > > First seen on 6.12.53-rc1
> > > Good: v6.12.52
> > > Bad: 6.12.53-rc1 also seen on 6.6.112-rc1
> > > 
> > > Regression Analysis:
> > > - New regression? yes
> > > - Reproducibility? yes
> > > 
> > > Build regressions: arch/s390/net/bpf_jit_comp.c:1813:49: error:
> > > 'struct bpf_jit' has no member named 'frame_off'
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > # Build error
> > > arch/s390/net/bpf_jit_comp.c: In function 'bpf_jit_insn':
> > > arch/s390/net/bpf_jit_comp.c:1813:49: error: 'struct bpf_jit' has
> > > no
> > > member named 'frame_off'
> > >  1813 |                         _EMIT6(0xd203f000 | (jit->frame_off
> > > +
> > >       |                                                 ^~
> > > arch/s390/net/bpf_jit_comp.c:211:55: note: in definition of macro
> > > '_EMIT6'
> > >   211 |                 *(u32 *) (jit->prg_buf + jit->prg) =
> > > (op1);     \
> > >       |                                                       ^~~
> > > include/linux/stddef.h:16:33: error: invalid use of undefined type
> > > 'struct prog_frame'
> > >    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE,
> > > MEMBER)
> > >       |                                 ^~~~~~~~~~~~~~~~~~
> > > arch/s390/net/bpf_jit_comp.c:211:55: note: in definition of macro
> > > '_EMIT6'
> > >   211 |                 *(u32 *) (jit->prg_buf + jit->prg) =
> > > (op1);     \
> > >       |                                                       ^~~
> > > arch/s390/net/bpf_jit_comp.c:1814:46: note: in expansion of macro
> > > 'offsetof'
> > >  1814 |                                             
> > > offsetof(struct prog_frame,
> > >       |                                              ^~~~~~~~
> > > include/linux/stddef.h:16:33: error: invalid use of undefined type
> > > 'struct prog_frame'
> > >    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE,
> > > MEMBER)
> > >       |                                 ^~~~~~~~~~~~~~~~~~
> > > arch/s390/net/bpf_jit_comp.c:212:59: note: in definition of macro
> > > '_EMIT6'
> > >   212 |                 *(u16 *) (jit->prg_buf + jit->prg + 4) =
> > > (op2); \
> > >       |                                                          
> > > ^~~
> > > arch/s390/net/bpf_jit_comp.c:1816:41: note: in expansion of macro
> > > 'offsetof'
> > >  1816 |                                0xf000 | offsetof(struct
> > > prog_frame,
> > >       |                                         ^~~~~~~~
> > > arch/s390/net/bpf_jit_comp.c: In function
> > > '__arch_prepare_bpf_trampoline':
> > > include/linux/stddef.h:16:33: error: invalid use of undefined type
> > > 'struct prog_frame'
> > >    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE,
> > > MEMBER)
> > >       |                                 ^~~~~~~~~~~~~~~~~~
> > > arch/s390/net/bpf_jit_comp.c:212:59: note: in definition of macro
> > > '_EMIT6'
> > >   212 |                 *(u16 *) (jit->prg_buf + jit->prg + 4) =
> > > (op2); \
> > >       |                                                          
> > > ^~~
> > > arch/s390/net/bpf_jit_comp.c:2813:33: note: in expansion of macro
> > > 'offsetof'
> > >  2813 |                        0xf000 | offsetof(struct prog_frame,
> > > tail_call_cnt));
> > >       |                                 ^~~~~~~~
> > > make[5]: *** [scripts/Makefile.build:229:
> > > arch/s390/net/bpf_jit_comp.o] Error 1
> > > 
> > > The git blame is pointing to,
> > >  $ git blame -L 1813  arch/s390/net/bpf_jit_comp.c
> > >    162513d7d81487 (Ilya Leoshkevich)    _EMIT6(0xd203f000 | (jit-
> > > >frame_off +
> > > 
> > > Commit pointing to,
> > >    s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
> > >    [ Upstream commit c861a6b147137d10b5ff88a2c492ba376cd1b8b0 ]
> > 
> > Anders bisected reported regressions and also suggested the missing
> > patches.
> > 
> > Ilya Leoshkevich,
> > Is it a good idea to backport / cherry pick these two patches on the
> > 6.12 branch ?
> > 
> > b2268d550d20 ("s390/bpf: Centralize frame offset calculations")
> > e26d523edf2a ("s390/bpf: Describe the frame using a struct instead of
> > constants")
> 
> Thank you for the report and the investigation!
> 
> I think it would be a good idea to backport these.
> Both are NFC changes that went into v6.17 and there were no complaints.
> 
> For v6.6 we also need this one (also NFC):
> 
> 67aed27bcd46 ("s390/bpf: Change seen_reg to a mask")

Thanks for the info, I'll go drop the original offending commit from
both queues.  Can someone please resubmit all of the needed changes for
us to apply so that I am sure to get them all correctly?

thanks,

greg k-h

