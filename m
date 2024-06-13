Return-Path: <bpf+bounces-32134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D9907E47
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD082B26C0E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0672145B0B;
	Thu, 13 Jun 2024 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msosOGth"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC671747;
	Thu, 13 Jun 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314822; cv=none; b=PRhp1bElNsqkVcP/LY/BqOgnV5zu+JndiuWTVZyK4LyfbtKZnYUjPgTPmyb9Np90CsoN0E3QpvSop3vgCHrY5zFIB8W3T/jGeWkTvjhvXHpOUOtcO3AHXf84oijfxMQ5QoDum0ZK1yGSwJ2nyh4lKadhY4R/u62hCPQ4gNoWIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314822; c=relaxed/simple;
	bh=q+yRfUm4ZJKgJ+oDFldXAPnhT6dMYw/cyPge3ciy1sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4d0/ZD9w5W3tgN77WdZvEPpQXRSu1T0XjAFe2eQMgG7EY/AF/Tj/pfysC8MvSRhhLJoT185xihIfeEsXD8Zd1cmCaqMJ0+BSAbawwLW0mIlf2ldAGeJKTR0FDDR0bEpOffQ1CPnJyuh9kdcgEvmhbMowsVVzmMIT6gcWk9ek+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msosOGth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF892C2BBFC;
	Thu, 13 Jun 2024 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718314821;
	bh=q+yRfUm4ZJKgJ+oDFldXAPnhT6dMYw/cyPge3ciy1sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msosOGthX/ZaxkCU22Nz753vSrVuiW7w78ubG6pAKgYeXt1kVsu1JffstQexv9gNq
	 5Qs3VMb7mn6OKy7u8RabikVuxcGm1dpon7/GBLOtpmxkjZubbqFbTovl0wkoZRCIJD
	 +MadUFrtUqqzYhUm+g2ayXeNu1G74rlYmBGJbL9ICE3zk3huB1n8PxrjdiPhpHwVe7
	 FEC1SmB0awSdGPUkOk8+zIyhSYzeq+hRDrCLN3YgMItDDz4y2Xv6pB6k0T6HVlXYB1
	 R8P7syBsUuVfl+qfZuGQ0uNcUPj2MbTxDaxAZ6XuvHj2FsvfnKRzF0XrlYYobW5P7F
	 s7kNUQIabsOeg==
Date: Thu, 13 Jun 2024 14:40:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20240613214019.GA1423015@thelio-3990X>
References: <ZmjBHWw-Q5hKBiwA@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmjBHWw-Q5hKBiwA@x1>

Hi Arnaldo,

On Tue, Jun 11, 2024 at 06:26:53PM -0300, Arnaldo Carvalho de Melo wrote:
> 	The v1.27 release of pahole and its friends is out, supporting
> parallel reproducible builds and encoding kernel kfuncs in BTF, allowing
> tools such as bpftrace to enumerate the available kfuncs and obtain its
> function signatures and return types.

After commit f632e75 ("dwarf_loader: Add the cu to the cus list early,
remove on LSK_DELETE"), I (and others[1]) notice a crash when running
pahole on modules built with Clang when CONFIG_LTO_CLANG is enabled:

  $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config

  $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig vmlinux crypto/cast_common.ko
  make[3]: *** [scripts/Makefile.modfinal:59: crypto/cast_common.ko] Error 139

I've isolated this to the following commands using the files available
at [2] (these were built with LLVM 18 but I could reproduce it with LLVM
17 and LLVM 19, so it appears to impact a number of versions):

  $ tar -tf clang-lto-pahole-1.27-crash.tar.zst
  clang-lto-pahole-1.27-crash/
  clang-lto-pahole-1.27-crash/cast_common.mod.o
  clang-lto-pahole-1.27-crash/module.lds
  clang-lto-pahole-1.27-crash/cast_common.o
  clang-lto-pahole-1.27-crash/cast_common.ko.bak
  clang-lto-pahole-1.27-crash/vmlinux
  clang-lto-pahole-1.27-crash/cast_common.ko

  $ tar -axf clang-lto-pahole-1.27-crash.tar.zst

  $ cd clang-lto-pahole-1.27-crash

  $ LLVM_OBJCOPY="llvm-objcopy" pahole-1.26 -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func --lang_exclude=rust --btf_base vmlinux cast_common.ko

  $ cp cast_common.ko{.bak,}

  $ LLVM_OBJCOPY="llvm-objcopy" pahole-1.27 -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func --lang_exclude=rust --btf_base vmlinux cast_common.ko
  fish: Job 1, '...' terminated by signal SIGSEGV (Address boundary error)

If there is any more information I can provide or patches I can test, I
am more than happy to do so.

[1]: https://gitlab.archlinux.org/archlinux/packaging/packages/pahole/-/issues/1
[2]: https://1drv.ms/u/s!AsQNYeB-IEbqqC2F28JuLy__Q7Vd?e=KsraMU

Cheers,
Nathan

