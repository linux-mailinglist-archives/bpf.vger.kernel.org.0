Return-Path: <bpf+bounces-39106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104796EF7B
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB34C1F25508
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D911C9DD9;
	Fri,  6 Sep 2024 09:37:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72091C9DC7
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615465; cv=none; b=L8pJ4SUmdzQRAwFnRRQXmY1YX05ZrsQExrU4IoF93IqAxyAp8aKP42KIFG3NiBHRSm82ZCZZuWxzXHD5QOWLaDWkMOAxVLtbqJmzB/XmL72PoTwPfKdH7JLg8gpEyD45uZAmLKbCuGFrjsOv+txYRndfg/glj9Jk2VmlJZl2IWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615465; c=relaxed/simple;
	bh=A27GPoNCqeEblNkD35Q5FEOM7mXI18FF4Q+F+Be5xBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVDS1dErWvYJmyfi6Z7t73Q9/VMoxVnDvcwFyS1gKpvrhRk/z2tJoS+47Y1eSsjrOygt4fYWU44/UGbb9dz9BZdJzSvTsBj/veBBNFNto33PB+8ftG+BlsGqgCeQQ4Y5SDL0UgNhL+BOt61YoRJYBieqNm35sQma6BP8aGwWVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0WNf1FhNz9sRs;
	Fri,  6 Sep 2024 11:37:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKy3LdL3k-CP; Fri,  6 Sep 2024 11:37:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0WNc6RQfz9sRy;
	Fri,  6 Sep 2024 11:37:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C3BE58B77C;
	Fri,  6 Sep 2024 11:37:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id of0oryN1Xdlh; Fri,  6 Sep 2024 11:37:36 +0200 (CEST)
Received: from [192.168.235.70] (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 65D348B764;
	Fri,  6 Sep 2024 11:37:34 +0200 (CEST)
Message-ID: <7c3720ff-b763-44b0-9b57-a2fbff3c7f56@csgroup.eu>
Date: Fri, 6 Sep 2024 11:37:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] execmem: add support for cache of large ROX pages
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dinh Nguyen
 <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Song Liu <song@kernel.org>, Stafford Horne <shorne@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20240826065532.2618273-1-rppt@kernel.org>
 <20240826065532.2618273-8-rppt@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240826065532.2618273-8-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2024 à 08:55, Mike Rapoport a écrit :
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Using large pages to map text areas reduces iTLB pressure and improves
> performance.
> 
> Extend execmem_alloc() with an ability to use PMD_SIZE'ed pages with ROX
> permissions as a cache for smaller allocations.

Why only PMD_SIZE ?

On power 8xx, PMD_SIZE is 4M and the 8xx doesn't have such a page size. 
When you call vmalloc() with VM_ALLOW_HUGE_VMAP you get 16k pages or 
512k pages depending on the size you ask for, see function 
arch_vmap_pte_supported_shift()

> 
> To populate the cache, a writable large page is allocated from vmalloc with
> VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> ROX.
> 
> Portions of that large page are handed out to execmem_alloc() callers
> without any changes to the permissions.
> 
> When the memory is freed with execmem_free() it is invalidated again so
> that it won't contain stale instructions.
> 
> The cache is enabled when an architecture sets EXECMEM_ROX_CACHE flag in
> definition of an execmem_range.
> 

Christophe

