Return-Path: <bpf+bounces-31188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF688D80E9
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 13:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D75280EB5
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31583A0D;
	Mon,  3 Jun 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCifjA+M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E119E;
	Mon,  3 Jun 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413605; cv=none; b=iE7BMWXIlBfPPb/Dc61qhAYEslnTYb/iHM5YdjIboKB+clB0OkZ1YvuCqeKTc+8gUPB8tyMgSWNzsxBFQRtAsiIlOkRCUM8NTMtJktNRI7rdVOuYUOecP6aZ99XkHP+bznj4/dga/MDVBYE8IfL9+5/18Y0oC2G7F7bGFmBSBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413605; c=relaxed/simple;
	bh=3xNxXA8/qb3isjI1ZUmIYZUG59ha1dFkpWp/+BJFjV0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heg/rUO3yXXIvS9G49NCHoAxv3hxl8UTgFiAtpxDZz0USLfebuUFxhtX54wXYFuJiY616nVMxxmWihE7WqvFKt8yB59jmnszfWYr/88ZVOTOqaAXFthKBwXgg3e4CxgDYnNw4/Qv0I1Vw9C62pfmXAx1DqQDjhJ1C23KYoFQ82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCifjA+M; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7023b6d810bso2908968b3a.3;
        Mon, 03 Jun 2024 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717413604; x=1718018404; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6FkhswBXO4S1BuMvA9cU711OcEvUvlnhqtxvdxJ/9s=;
        b=mCifjA+M4fSsw/S1sIpnTwUsFBVl73QS1KTsrLmunw3F4ZDRqhIsWBPtXsF5ozDozN
         ZWAoSvTTtMeY53E7yTkosri/lkC1vYP/+IvYxJtVOChHJ1RZhrsf5B92iLoHuPnrg0JR
         6OqJjVBfjtOIQOJSroLKVldU9tUVNVejkN3U89xBAo89dNwQu95rsZr09/GFqExaQzBC
         aqwqgJAFpftJ7wNI82Ka9GZ8bZcGJr9uoTZjp9d+PwYgIGzTBxRHMw4rrnjM452NVoPp
         khHhUGH3tYEnAOGJNMHpJ4X01Pqnp0Yk7sBXGT4V2V7ll6DiS0LRxAP4ahu4ibWlXbR3
         LOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717413604; x=1718018404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6FkhswBXO4S1BuMvA9cU711OcEvUvlnhqtxvdxJ/9s=;
        b=O2cKJPN3veBHS2fsF1HteS5Vs7HUcGBLJYFkwEUzARhjat2x26yBJ4+I1GJnrmift5
         1GVKn/sBN5jMx4l1/ap8hLh0hHAc9oiHmHDHn118yZYWZsJcWPFN+oZSBhUtvEsI5W5j
         Y4jarQRtO2t/9dBSHwvyZA96ZdkAhcrOm5MF0RGR+xlQJpGy6AknHoIPIyYNdMD0VJlV
         kY707eRt4j//jJ+T5KEFSxPMDy+MXOSSIhmyOlPJ5dkItAbSF/vqWP1ogJQ7HZD9locU
         BvpusSoj0FR43DGCeckGhQqZME5Or82yCnDTviIA2Zw1JfAbHAD9hZJckh+eZeKV/L+3
         rd0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzR9aGkxUeGxoq8pyQ8Ld6Ku/yPb0245KAqjsiwNL+ZkBSHvcAIQEXhABIUyE8OCUnIb5SBSAcsXQia+tKr2HMMweQFWloRIJcWAihpEMxqc0PgLSXYeV1OXKPlQ==
X-Gm-Message-State: AOJu0YzyogModEb/3hXzzI48+xEi0zRP6PHaqxe4n0UeuFjbeRygBgF9
	fDyWb3huZdpPjlWbOlEaI9+Sxor9kKK1929e9Rxi9cnz998oh7l+15pNVQ==
X-Google-Smtp-Source: AGHT+IG8ssQGMl5tqE4F0Dr3dcCaq4LQuWSVA4Tjtk7Uol3j4c/TsTkGMtfkyRG2lCUXTNCRvBQOeA==
X-Received: by 2002:a05:6a00:3d08:b0:702:7977:2788 with SMTP id d2e1a72fcca58-70279772b03mr861625b3a.15.1717413603450;
        Mon, 03 Jun 2024 04:20:03 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7027a267be7sm624889b3a.136.2024.06.03.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 04:20:03 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 3 Jun 2024 04:20:01 -0700
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zln1kZnu2Xxeyngj@x1>

On Fri, May 31, 2024 at 01:06:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, May 31, 2024 at 03:49:38AM -0700, Tony Ambardar wrote:
> > Hello Hengqi,
> > 
> > On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> > > Hi Tony,
> > > 
> > > On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > For some time now I'm seeing multiple issues during BTF generation while
> > > > building recent kernels targeting mips64el, and would appreciate some help
> > > > to understand and fix the problems.
> > > >
> > > SNIP
> > > >
> > > > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > > > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > > > >   CC [M]  net/psample/psample.mod.o
> > > > >   LD [M]  crypto/cmac.ko
> > > > >   BTF [M] crypto/cmac.ko
> > > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > > > or DW_TAG_skeleton_unit expected got member (0xd)!
> 
> Can you check the kernel CONFIG_ variables related to DEBUG information
> and post them here? I have this on fedora:
> 
> [acme@nine linux]$ grep CONFIG_DEBUG_INFO /boot/config-5.14.0-362.18.1.el9_3.x86_64 
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_REDUCED is not set
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y
> [acme@nine linux]$
> 
> If you have CONFIG_DEBUG_INFO_SPLIT, CONFIG_DEBUG_INFO_COMPRESSED or
> CONFIG_DEBUG_INFO_REDUCED set to 'y', please try with the values in the
> fedora config.

One more useful observation: the pahole BTF generation problems appear only
for mips64. If I build the same config for mips32be I see none of those
"die__process: errors" from pahole and the processed modules load properly.

I also tried running pahole under gdb to look further, but lack knowledge
of pahole and libdw internals, so couldn't narrow things down to a pahole,
elfutils or compiler-output problem.

To help troubleshoot further, I packaged my base vmlinux, some module .ko
files showing problems, and a reproducer script. I've uploaded the tarball
here:

https://www.dropbox.com/scl/fi/3ce22fi2q861wqvbq9mwy/repro_die__process.tar.xz?rlkey=ev494phabmfl5qe55xrn1jh3t&st=vrp5mxhh&dl=0

Thanks,
Tony

> 
> - Arnaldo
> 
> > > The issue seems to be related to elfutils. Have you tried build from
> > > the latest elfutils source ?
> > > I saw the latest MIPS backend in elfutils already implemented the
> > > reloc_simple_type hook.
> > 
> > Good idea. I tried rebuilding elfutils from the latest upstream commit:
> > https://sourceware.org/git/?p=elfutils.git;a=commit;h=935ee131cf7c87296df9412b7e3370085e7c7508
> > 
> > I then linked this elfutils with pahole built from the latest pahole/next:
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=a9ae414fef421bdeb13ff7ffe13271e1e4f58993
> > 
> > I also confirmed resolve_btfids links to the new elfutils, and then rebuilt
> > the kernel with the same config. Unfortunately, the warnings/errors from
> > resolve_btfids and pahole still occur.
> > 
> > > SNIP
> > > >
> > > > I'd be grateful if some of the BTF/pahole experts could please review this
> > > > issue and share next steps or other details I might provide.
> > > >
> > > > Thanks,
> > > > Tony Ambardar
> > > >
> > > > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > > > Link: https://github.com/acmel/dwarves/issues/45 [2]
> > > 
> > > Cheers,
> > > Hengqi
> > 
> > Thanks for the suggestion,
> > Tony

