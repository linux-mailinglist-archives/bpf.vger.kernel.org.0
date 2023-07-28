Return-Path: <bpf+bounces-6284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33A76791B
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 01:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954E71C21104
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBCA20FB5;
	Fri, 28 Jul 2023 23:44:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5E525C;
	Fri, 28 Jul 2023 23:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A074C433C8;
	Fri, 28 Jul 2023 23:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690587872;
	bh=cWmX8dje9L/t2n0sGzkMqdIweI7HyRrXvW9fatE/XmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEVL1iBujhtX6KL8vieDNOZRit8WKLYgDPzlWjysDVvATw3dW3wMmAmqcv34C7gRX
	 ixTPaqduG6ZU+yDJxPY0C3oJHXRYtTeQkkOUf9/047ZjrYURNDRWQxHlx+8tFetvl2
	 gs+UByaUwQOUX/PxL/HkxJI+P/D5LLLhEY4Z47Iw2CkDYTcr+cSKgchC9Dlz7hUZsj
	 QKcn/9LAtdOSVe1jtA2tZfPMnMi/QT++V+KxpJ0wvSvygmtVpqvsfWgZUqK1Vq7pfT
	 lrP2XQW+jWAq9IE9uEO62ZFYFgeVg9jPpJiFVb0TnAFo2Jznnfl5w2gzg6V/begJs8
	 lhnvdL500Uy1A==
Date: Fri, 28 Jul 2023 16:44:29 -0700
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
Message-ID: <20230728234429.GA611252@dev-arch.thelio-3990X>
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
 <1687443219-11946-2-git-send-email-yangtiezhu@loongson.cn>
 <20230727213648.GA354736@dev-arch.thelio-3990X>
 <1777400a-4d9c-4bdb-9d3b-f8808ef054cc@app.fastmail.com>
 <20230728173103.GA1299743@dev-arch.thelio-3990X>
 <a2fa1a31-e8bb-4659-9631-398b564e7c2b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2fa1a31-e8bb-4659-9631-398b564e7c2b@app.fastmail.com>

On Fri, Jul 28, 2023 at 10:56:38PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 28, 2023, at 19:31, Nathan Chancellor wrote:
> > On Fri, Jul 28, 2023 at 01:00:30PM +0200, Arnd Bergmann wrote:
> >>
> >> of the uapi version. The sanity check in the kernel-side header
> >> is intended to cross-check the CONFIG_64BIT value against the
> >> __BITS_PER_LONG constant from the header.
> >> 
> >> My first guess would be that this only worked by accident if the headers
> >> defaulted to "#define __BITS_PER_LONG 32" in and #undef CONFIG_64BIT"
> >> when include/generated/autoconf.h, but now the __BITS_PER_LONG value
> >> is actually correct.
> >
> > That seems like a reasonable theory. I am still busy looking into other
> > things today but I can try to double back to this on Monday if you don't
> > make any progress.
> 
> I tried reproducing this today on arm64 Debian with linux-6.5-rc3
> and clang-14.0.6 but I don't see the problem here. With 'make V=1'
> I see command for building scripts/sorttable is
> 
> clang -Wp,-MMD,scripts/.sorttable.d -Wall -Wmissing-prototypes \
>  -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11   \
>  -I./tools/include -I./tools/arch/x86/include -DUNWINDER_ORC_ENABLED \
>  -o scripts/sorttable scripts/sorttable.c   -lpthread
> 
> which does create an arm64 executable but includes the x86 headers,
> which is clearly a bug by itself, it just doesn't trigger the problem
> for me.

I could not initially reproduce this on Debian either but I figured out
why that might be: the default include paths on Debian look different
from Fedora so just doing 'headers_install' into /usr will not reproduce
this. If I add '-H' to that GCC command, Debian shows (I highlighted the
key difference):

  . /linux-stable/scripts/sorttable.h
  .. /linux-stable/tools/arch/x86/include/asm/orc_types.h
  ... /linux-stable/tools/include/linux/types.h
  .... /usr/lib/gcc/aarch64-linux-gnu/12/include/stdbool.h
  .... /usr/lib/gcc/aarch64-linux-gnu/12/include/stddef.h
  .... /usr/include/aarch64-linux-gnu/asm/types.h
  ..... /usr/include/asm-generic/types.h
  ...... /usr/include/asm-generic/int-ll64.h
  ....... /usr/include/aarch64-linux-gnu/asm/bitsperlong.h <-
  ........ /linux-stable/tools/include/asm-generic/bitsperlong.h
  ......... /linux-stable/tools/include/uapi/asm-generic/bitsperlong.h

Whereas Fedora shows:

  . /linux-stable/scripts/sorttable.h
  .. /linux-stable/tools/arch/x86/include/asm/orc_types.h
  ... /linux-stable/tools/include/linux/types.h
  .... /usr/lib/gcc/aarch64-redhat-linux/13/include/stdbool.h
  .... /usr/lib/gcc/aarch64-redhat-linux/13/include/stddef.h
  .... /usr/include/asm/types.h
  ..... /usr/include/asm-generic/types.h
  ...... /usr/include/asm-generic/int-ll64.h
  ....... /usr/include/asm/bitsperlong.h <-
  ........ /linux-stable/tools/include/asm-generic/bitsperlong.h
  ......... /linux-stable/tools/include/uapi/asm-generic/bitsperlong.h

Running 'gcc -fsyntax-only -v -x c /dev/null' shows:

Debian:

  #include <...> search starts here:
   /usr/lib/gcc/aarch64-linux-gnu/12/include
   /usr/local/include
   /usr/include/aarch64-linux-gnu
   /usr/include
  End of search list.

Fedora:

  #include <...> search starts here:
   /usr/lib/gcc/aarch64-redhat-linux/13/include
   /usr/local/include
   /usr/include
  End of search list.

It looks like Debian installs the architecture asm files into an
architecture specific subdirectory, which headers_install does not know
about, so the new "problematic" bitsperlong.h file gets installed to the
default location but the older one actually gets used because it has
higher priority in the include search path.

https://salsa.debian.org/kernel-team/linux/-/blob/36b9562acea404ecdc2911aeb2c4539402f441a3/debian/rules.real#L334-336

If I install/manipulate the headers as Debian does, I can reproduce this
issue in a fresh Debian container.

  # make -C /linux -j$(nproc) INSTALL_HDR_PATH=/usr O=/build headers_install
  # rm -fr /usr/include/aarch64-linux-gnu/asm
  # mv -v /usr/include/asm /usr/include/aarch64-linux-gnu
  # make -C /linux-stable -j$(nproc) ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- O=/build mrproper defconfig prepare
  ...
    DESCEND objtool
  In file included from /usr/include/aarch64-linux-gnu/asm/bitsperlong.h:1,
                   from /usr/include/asm-generic/int-ll64.h:12,
                   from /usr/include/asm-generic/types.h:7,
                   from /usr/include/aarch64-linux-gnu/asm/types.h:1,
                   from /linux-stable/tools/include/linux/types.h:13,
                   from /linux-stable/tools/arch/x86/include/asm/orc_types.h:9,
                   from /linux-stable/scripts/sorttable.h:96,
                   from /linux-stable/scripts/sorttable.c:201:
  /linux-stable/tools/include/asm-generic/bitsperlong.h:14:2: error: #error Inconsistent word size. Check asm/bitsperlong.h
     14 | #error Inconsistent word size. Check asm/bitsperlong.h
        |  ^~~~~
  make[3]: *** [/linux-stable/scripts/Makefile.host:114: scripts/sorttable] Error 1
  ...

> I also noticed that your command line includes CROSS_COMPILE=x86_64-linux-
> rather than CROSS_COMPILE=x86_64-linux-gnu-

Right, as I was reproducing this with your kernel.org GCC for
CROSS_COMPILE and Fedora's GCC for HOSTCC, since I wanted to make sure
this was not some issue with clang (which it does not appear to be).

Cheers,
Nathan

