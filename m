Return-Path: <bpf+bounces-32329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70990BB49
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 21:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA51D1F22749
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0254B187575;
	Mon, 17 Jun 2024 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edYDSTcR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F511CAB;
	Mon, 17 Jun 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653180; cv=none; b=BYv4XG9mI+Gwi1PluslOApsOYiRxFFrU+q1fLTdA/dWcA2jTZeFdaUgfBxJwrn73tAmhOdllAU0sfW56BXJ04uPAby80eh1Bs4/0JoT8Pv65BIjkxGidv0VFNIOp7VBwy8MjimV9yWUdIL/YbsGZh5X7V7UF9D+DXLYh8w75dfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653180; c=relaxed/simple;
	bh=sZeX0jdyzcEU32N2339kQ4SjZz3qMfD5FduuPaOf1Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv1VwJpxED5lmgr35dkXURdpMf9kIYTwaomf6Y0lVIKHcqXpsCR4vnS9KiBnur+vRHMveUJj4k5ZKP+52EnXK26zUMF80JLimJm3dMnOvZdLHbGFd1OmInr3oNkjybPTOdKVN7hs6JA42syM5vIceary4VwG3DTmj+ppNxeRde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edYDSTcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627F7C2BD10;
	Mon, 17 Jun 2024 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718653180;
	bh=sZeX0jdyzcEU32N2339kQ4SjZz3qMfD5FduuPaOf1Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edYDSTcRTUpPUVFYaGYGmXm/s/NRaBpsDKA2QOlyfSWCRPQ9iwNxITLi81r4kr1oH
	 CCF1Fk41YvvJpiN3i2VjBSXZ9rwL6DG6rAr6CZLysWNzpDoDbo88ch9ZQTiYUV9cbG
	 xU8bIMS1iM7JGd3HJF6yI2HDgcAu+UxypHTtZwNT70Cw9c7WFlnBAVug1V0ivqT55O
	 tkFeY1vxsuxp9SW76cfOtdv8GeV924MUtDUIf3PgCH9w1k3f8IM2HH8CexZqKH1w0G
	 i2V34m46Zq1o8HpXETEsu8FYBHglLpCrBOzHUfw1qr3F67ZrfSwpsrKhcVn+LT1VTA
	 4gPH5mQUMRrUA==
Date: Mon, 17 Jun 2024 16:39:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>,
	llvm@lists.linux.dev
Subject: Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF kfuncs)
Message-ID: <ZnCQ-Psf_WswMk1W@x1>
References: <ZmjBHWw-Q5hKBiwA@x1>
 <20240613214019.GA1423015@thelio-3990X>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613214019.GA1423015@thelio-3990X>

On Thu, Jun 13, 2024 at 02:40:19PM -0700, Nathan Chancellor wrote:
> Hi Arnaldo,
> 
> On Tue, Jun 11, 2024 at 06:26:53PM -0300, Arnaldo Carvalho de Melo wrote:
> > 	The v1.27 release of pahole and its friends is out, supporting
> > parallel reproducible builds and encoding kernel kfuncs in BTF, allowing
> > tools such as bpftrace to enumerate the available kfuncs and obtain its
> > function signatures and return types.
> 
> After commit f632e75 ("dwarf_loader: Add the cu to the cus list early,
> remove on LSK_DELETE"), I (and others[1]) notice a crash when running
> pahole on modules built with Clang when CONFIG_LTO_CLANG is enabled:
> 
>   $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config
> 
>   $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig vmlinux crypto/cast_common.ko
>   make[3]: *** [scripts/Makefile.modfinal:59: crypto/cast_common.ko] Error 139
> 
> I've isolated this to the following commands using the files available
> at [2] (these were built with LLVM 18 but I could reproduce it with LLVM
> 17 and LLVM 19, so it appears to impact a number of versions):
> 
>   $ tar -tf clang-lto-pahole-1.27-crash.tar.zst
>   clang-lto-pahole-1.27-crash/
>   clang-lto-pahole-1.27-crash/cast_common.mod.o
>   clang-lto-pahole-1.27-crash/module.lds
>   clang-lto-pahole-1.27-crash/cast_common.o
>   clang-lto-pahole-1.27-crash/cast_common.ko.bak
>   clang-lto-pahole-1.27-crash/vmlinux
>   clang-lto-pahole-1.27-crash/cast_common.ko
> 
>   $ tar -axf clang-lto-pahole-1.27-crash.tar.zst
> 
>   $ cd clang-lto-pahole-1.27-crash
> 
>   $ LLVM_OBJCOPY="llvm-objcopy" pahole-1.26 -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func --lang_exclude=rust --btf_base vmlinux cast_common.ko
> 
>   $ cp cast_common.ko{.bak,}
> 
>   $ LLVM_OBJCOPY="llvm-objcopy" pahole-1.27 -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func --lang_exclude=rust --btf_base vmlinux cast_common.ko
>   fish: Job 1, '...' terminated by signal SIGSEGV (Address boundary error)
> 
> If there is any more information I can provide or patches I can test, I
> am more than happy to do so.

I reproduced the problem by just running 'pahole cast_common.ko", so
this isn't even related to the BTF parts, its about the DWARF loader,
I'm on it, thanks for the detailed report and for providing the files.

- Arnaldo
 
> [1]: https://gitlab.archlinux.org/archlinux/packaging/packages/pahole/-/issues/1
> [2]: https://1drv.ms/u/s!AsQNYeB-IEbqqC2F28JuLy__Q7Vd?e=KsraMU
> 
> Cheers,
> Nathan
> 

