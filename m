Return-Path: <bpf+bounces-6231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123B0767367
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411A41C210D9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6015F156EB;
	Fri, 28 Jul 2023 17:31:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77614AA6;
	Fri, 28 Jul 2023 17:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F788C433C8;
	Fri, 28 Jul 2023 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690565466;
	bh=NXz5tKNsoYH5b9t6PkGaSvdNnq8EVbDx7LLDtyBWDIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEKS+ghKaHqzJ/CeAVUmffgp1syROs6M7poM0tlpzGzihFWzpmfvi2K85PgFarbuo
	 RkBcIe75tLMn7XoYUUPhEjXBxGbvzFW6xn32Qzg/SEPgRlqNJ7ZV00NbZfU5yRRyZa
	 jn3bpdlEYETGcDum4z742lJd6KwcgDw+lIfr6otYHl7RO8ePAuI1taZ3cPwmxE/PwJ
	 wKJJvTonQcslSnqjiqKIy+MtAH0nqvGjUK5Hyzlni78cWnO89ixENQFj5Bae9AcGEH
	 K6Fi4h9QSZCy9nrcmCfp6Y1ClZF8Pg2Q4KYKwIAlrtDzm85paoRya48V4qF09hybvv
	 7Sg5khTe78XFA==
Date: Fri, 28 Jul 2023 10:31:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 1/2] asm-generic: Unify uapi bitsperlong.h for arm64,
 riscv and loongarch
Message-ID: <20230728173103.GA1299743@dev-arch.thelio-3990X>
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
 <1687443219-11946-2-git-send-email-yangtiezhu@loongson.cn>
 <20230727213648.GA354736@dev-arch.thelio-3990X>
 <1777400a-4d9c-4bdb-9d3b-f8808ef054cc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1777400a-4d9c-4bdb-9d3b-f8808ef054cc@app.fastmail.com>

On Fri, Jul 28, 2023 at 01:00:30PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 27, 2023, at 23:36, Nathan Chancellor wrote:
> > Hi Tiezhu and Arnd,
> >
> > On Thu, Jun 22, 2023 at 10:13:38PM +0800, Tiezhu Yang wrote:
> >> Now we specify the minimal version of GCC as 5.1 and Clang/LLVM as 11.0.0
> >> in Documentation/process/changes.rst, __CHAR_BIT__ and __SIZEOF_LONG__ are
> >> usable, it is probably fine to unify the definition of __BITS_PER_LONG as
> >> (__CHAR_BIT__ * __SIZEOF_LONG__) in asm-generic uapi bitsperlong.h.
> >> 
> >> In order to keep safe and avoid regression, only unify uapi bitsperlong.h
> >> for some archs such as arm64, riscv and loongarch which are using newer
> >> toolchains that have the definitions of __CHAR_BIT__ and __SIZEOF_LONG__.
> >> 
> >> Suggested-by: Xi Ruoyao <xry111@xry111.site>
> >> Link: https://lore.kernel.org/all/d3e255e4746de44c9903c4433616d44ffcf18d1b.camel@xry111.site/
> >> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> >> Link: https://lore.kernel.org/linux-arch/a3a4f48a-07d4-4ed9-bc53-5d383428bdd2@app.fastmail.com/
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> 
> >
> > I think this change has backwards compatibility concerns, as it breaks
> > building certain host tools on the stable releases (at least 6.4 and
> > 6.1, as that is where I noticed this). I see the following error on my
> > aarch64 system:
> >
> >   $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- 
> > mrproper defconfig prepare
> >   In file included from /usr/include/asm/bitsperlong.h:1,
> >                    from /usr/include/asm-generic/int-ll64.h:12,
> >                    from /usr/include/asm-generic/types.h:7,
> >                    from /usr/include/asm/types.h:1,
> >                    from tools/include/linux/types.h:13,
> >                    from tools/arch/x86/include/asm/orc_types.h:9,
> >                    from scripts/sorttable.h:96,
> >                    from scripts/sorttable.c:201:
> >   tools/include/asm-generic/bitsperlong.h:14:2: error: #error 
> > Inconsistent word size. Check asm/bitsperlong.h
> >      14 | #error Inconsistent word size. Check asm/bitsperlong.h
> >         |  ^~~~~
> 
> Thanks for the report. I'm still struggling to figure out what
> exactly is going wrong here, and if this is a bug in the patch
> I merged, or an existing bug that now causes a build failure instead
> of some other problem.

Totally understandable, I was really confused at first too.

> > A reverse bisect of 6.4 to 6.5-rc1 points to this patch. This Fedora
> > rawhide container has kernel-headers 6.5.0-0.rc2.git0.1.fc39 and the
> > error disappears when I downgrade to 6.4.0-0.rc7.git0.1.fc39. I have not
> > done a ton of triage/debugging so far, as I am currently hunting down
> > other regressions, but I figured I would get an initial report out,
> > since I noticed it when validating LLVM from the new release/17.x
> > branch. If there is any additional information I can provide or patches
> > I can test, I am more than happy to do so.
> 
> One thing I think is going wrong here is that scripts/sorttable.c is
> meant to run on the host (arm64) but includes the target (x86)
> orc_Types.h header and the kernel-internal asm/bitsperlong.h instead

Right. I will note sorttable is not the only utility that has this
issue, I see the same problem coming from several files in
tools/lib/subcmd when building several different architectures and
arch/x86/entry/vdso/vdso2c.c at the very least.

> of the uapi version. The sanity check in the kernel-side header
> is intended to cross-check the CONFIG_64BIT value against the
> __BITS_PER_LONG constant from the header.
> 
> My first guess would be that this only worked by accident if the headers
> defaulted to "#define __BITS_PER_LONG 32" in and #undef CONFIG_64BIT"
> when include/generated/autoconf.h, but now the __BITS_PER_LONG value
> is actually correct.

That seems like a reasonable theory. I am still busy looking into other
things today but I can try to double back to this on Monday if you don't
make any progress.

Cheers,
Nathan

