Return-Path: <bpf+bounces-31041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BAA8D664B
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4860B1F27098
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BF51586C7;
	Fri, 31 May 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKvK/ua1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193415664C;
	Fri, 31 May 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171604; cv=none; b=ewytUDEjO2R/nPuThsIXY/b4g43UCFWMTOriHLkAXyJOd39dnJbWpuWjRqWeHGbzJI1tYySjHQhaH4pcopxA5qlZwIRa0ytGZAlZs5i2/I2yU3i8Jh73e37SeOGprTK1xQjqmXaeHfofYuOWWm5vBrgu/h31lbZeviB+Xjfxrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171604; c=relaxed/simple;
	bh=z5PxXsoTgmUtXQvYDJWZ5TP/VUZ05dlcLBtZOQh3l8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQTN5u0QD8netb9JQuB7TzmWVySBWtkZUlEAuOLi6LEQ5aV3a1lSeHoemcroHH1VclbaSLuCCFH8oAlTvwBLF2iK6j3qgXV7t8W2rWO9pACD1nE0SRRUiXcsGNvS8lnZmyvPaSw7T+8DTso/DDG2f24MakC8Uq/c7wAM0MdB70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKvK/ua1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0C2C116B1;
	Fri, 31 May 2024 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717171603;
	bh=z5PxXsoTgmUtXQvYDJWZ5TP/VUZ05dlcLBtZOQh3l8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKvK/ua1ctJCfZd9jLxbEMdu9rn1O9db7rj2u/kh29J8Ylc/BtRvzD3BnpjNY354b
	 2ZCo53eYa3GzYpd216PvwKXeAW3bZv/ZtT3vi0SS9eJ3ubWJp7/1Yc2zed94rUfbTB
	 meeTEw+7W4Co466irI7SUYa6esbtnNSN6blpLKYbWpe13N+BfEsyAJ4kspqb3SPWw+
	 m6Q89rMyJZ0X+f7X5Uqgox9SChYeD/deOFWmmMBVwg+52fu3s9Gip/k7LuRUSYJ5bi
	 UCN3Xgo0ndM99EAwErFnCv4L2Yu91MA6ch+jmsU6Eiei33Bc055VcpCOljKYAGMkK0
	 n49dw51sSSNnQ==
Date: Fri, 31 May 2024 13:06:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <Zln1kZnu2Xxeyngj@x1>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>

On Fri, May 31, 2024 at 03:49:38AM -0700, Tony Ambardar wrote:
> Hello Hengqi,
> 
> On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> > Hi Tony,
> > 
> > On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > For some time now I'm seeing multiple issues during BTF generation while
> > > building recent kernels targeting mips64el, and would appreciate some help
> > > to understand and fix the problems.
> > >
> > SNIP
> > >
> > > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > > >   CC [M]  net/psample/psample.mod.o
> > > >   LD [M]  crypto/cmac.ko
> > > >   BTF [M] crypto/cmac.ko
> > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > > or DW_TAG_skeleton_unit expected got member (0xd)!

Can you check the kernel CONFIG_ variables related to DEBUG information
and post them here? I have this on fedora:

[acme@nine linux]$ grep CONFIG_DEBUG_INFO /boot/config-5.14.0-362.18.1.el9_3.x86_64 
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
[acme@nine linux]$

If you have CONFIG_DEBUG_INFO_SPLIT, CONFIG_DEBUG_INFO_COMPRESSED or
CONFIG_DEBUG_INFO_REDUCED set to 'y', please try with the values in the
fedora config.

- Arnaldo

> > The issue seems to be related to elfutils. Have you tried build from
> > the latest elfutils source ?
> > I saw the latest MIPS backend in elfutils already implemented the
> > reloc_simple_type hook.
> 
> Good idea. I tried rebuilding elfutils from the latest upstream commit:
> https://sourceware.org/git/?p=elfutils.git;a=commit;h=935ee131cf7c87296df9412b7e3370085e7c7508
> 
> I then linked this elfutils with pahole built from the latest pahole/next:
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=a9ae414fef421bdeb13ff7ffe13271e1e4f58993
> 
> I also confirmed resolve_btfids links to the new elfutils, and then rebuilt
> the kernel with the same config. Unfortunately, the warnings/errors from
> resolve_btfids and pahole still occur.
> 
> > SNIP
> > >
> > > I'd be grateful if some of the BTF/pahole experts could please review this
> > > issue and share next steps or other details I might provide.
> > >
> > > Thanks,
> > > Tony Ambardar
> > >
> > > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > > Link: https://github.com/acmel/dwarves/issues/45 [2]
> > 
> > Cheers,
> > Hengqi
> 
> Thanks for the suggestion,
> Tony

