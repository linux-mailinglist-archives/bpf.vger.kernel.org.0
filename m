Return-Path: <bpf+bounces-76621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562BCBF3A0
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF9A3031348
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BE330D58;
	Mon, 15 Dec 2025 17:18:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD892ECE9E;
	Mon, 15 Dec 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765819119; cv=none; b=WRkoahI+guz/4hz2fmmwh+XInMnkhJDvuIbwgBRqW3f/nPE1UeSuRDnov71ZS0palxpt6i16HTVY8OOzfiLLIdY3ruxg5XLl5/ToFhuspoCZUmeZfTd0ZGC39HEGtadJxRavWqq83NupdHzbgVKt6ffR3NVla7DiR6o5jqSSDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765819119; c=relaxed/simple;
	bh=akGhccS1gMszl+f4XkMNlg53UKrPmAE8NugyIh3EHqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEMHQGjy9ivjmhw3hCaxHOwUeGBYGKGARQezUQnW8uRzv8GYmWrNh7EbBVavsJJWLWf0W1MkifxA1+/ZKeVGZQvpMJoBolZxCXW7z4sfiNNoFPTRVjnPLSEYeNBU9ZcbWCTVGDH2a/+l1SukGgPSYOBQSWY2iLNwzaZavoBHUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1vVCDP-0007vw-00; Mon, 15 Dec 2025 18:18:31 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id CF2FFC0591; Mon, 15 Dec 2025 18:16:59 +0100 (CET)
Date: Mon, 15 Dec 2025 18:16:59 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>, bpf@vger.kernel.org,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: Linux 6.19-rc1
Message-ID: <aUBCi_MPt5rHSXqs@alpha.franken.de>
References: <CAHk-=wgizos80st3bL3EoEoh0+07u9zRjsw45M+RS-js-bcwag@mail.gmail.com>
 <516deeb7-102d-42ae-b925-64bba6281f14@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516deeb7-102d-42ae-b925-64bba6281f14@roeck-us.net>

On Mon, Dec 15, 2025 at 06:46:29AM -0800, Guenter Roeck wrote:
> -----------------------------------------
> Building mips:db1xxx_defconfig ... failed
> Building mips:mtx1_defconfig ... failed
> 
> --------------
> Error log:
> In file included from include/linux/pgtable.h:6,
>                  from include/linux/mm.h:31,
>                  from arch/mips/alchemy/common/setup.c:30:
> arch/mips/include/asm/pgtable.h:608:32: error: static declaration of 'io_remap_pfn_range_pfn' follows non-static declaration
>   608 | #define io_remap_pfn_range_pfn io_remap_pfn_range_pfn
>       |                                ^~~~~~~~~~~~~~~~~~~~~~
> arch/mips/alchemy/common/setup.c:97:29: note: in expansion of macro 'io_remap_pfn_range_pfn'
>    97 | static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
>       |                             ^~~~~~~~~~~~~~~~~~~~~~
> arch/mips/include/asm/pgtable.h:607:15: note: previous declaration of 'io_remap_pfn_range_pfn' with type 'long unsigned int(long unsigned int,  long unsigned int)'
>   607 | unsigned long io_remap_pfn_range_pfn(unsigned long pfn, unsigned long size);
>       |               ^~~~~~~~~~~~~~~~~~~~~~
> 
> Probably caused by commit c707a68f9468 ("mm: abstract io_remap_pfn_range()
> based on PFN") or related patches. Still bisecting.

I've applied to patch to mips-fixes branch for that.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

