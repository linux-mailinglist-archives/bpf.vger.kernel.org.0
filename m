Return-Path: <bpf+bounces-11420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0360B7B9AED
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 07:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9D278281D9A
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A404C6D;
	Thu,  5 Oct 2023 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htbvcSdK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252827FA;
	Thu,  5 Oct 2023 05:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBD6C433CC;
	Thu,  5 Oct 2023 05:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696483777;
	bh=0Btg3YXrlgdZvN9c5GBtYXuhH18hqWIB+5O6R7ueqJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htbvcSdKFwWteJskCo57Zoc+HETH4Yk4itDoLxeJ1ZG4lHI/6dRpo8c5g9SXm397o
	 Eun4d3xnthNfZVwdWsofKvM4QWBVN4HTm3hLqzLiQBrntUL8UgEGY5xtChyLJeLSvA
	 +kiu09tPGlxznwtPobf/uLurpuN8CBF2/SLMhDWs179ymyb2Urny866sSuGF/ojv6+
	 iWewEluv5jVsvROGeyy57su15Hs4TbNbwzhji63ZqwBfc3BmxOSDIm1/YBjJDN2t9v
	 ZHq7tnS5BF0NS66xJ3m6K4ABlSRKqepeLUIUEhNo390B9QIPXevXF5ZN3BxZUTA4Ed
	 Ef2zRBvRZ4gnQ==
Date: Thu, 5 Oct 2023 08:28:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"deller@gmx.de" <deller@gmx.de>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"nadav.amit@gmail.com" <nadav.amit@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"puranjay12@gmail.com" <puranjay12@gmail.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"will@kernel.org" <will@kernel.org>,
	"dinguyen@kernel.org" <dinguyen@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"song@kernel.org" <song@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 04/13] mm/execmem, arch: convert remaining overrides
 of module_alloc to execmem
Message-ID: <20231005052824.GE3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-5-rppt@kernel.org>
 <3483c4712306060ac56f07f5db9b146d69fc7e9e.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3483c4712306060ac56f07f5db9b146d69fc7e9e.camel@intel.com>

On Wed, Oct 04, 2023 at 12:29:36AM +0000, Edgecombe, Rick P wrote:
> On Mon, 2023-09-18 at 10:29 +0300, Mike Rapoport wrote:
> > diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> > index 5f71a0cf4399..9d37375e2f05 100644
> > --- a/arch/x86/kernel/module.c
> > +++ b/arch/x86/kernel/module.c
> >
> > -void *module_alloc(unsigned long size)
> > +struct execmem_params __init *execmem_arch_params(void)
> >  {
> > -       gfp_t gfp_mask = GFP_KERNEL;
> > -       void *p;
> > -
> > -       if (PAGE_ALIGN(size) > MODULES_LEN)
> > -               return NULL;
> > +       unsigned long module_load_offset = 0;
> > +       unsigned long start;
> >  
> > -       p = __vmalloc_node_range(size, MODULE_ALIGN,
> > -                                MODULES_VADDR +
> > get_module_load_offset(),
> > -                                MODULES_END, gfp_mask, PAGE_KERNEL,
> > -                                VM_FLUSH_RESET_PERMS |
> > VM_DEFER_KMEMLEAK,
> > -                                NUMA_NO_NODE,
> > __builtin_return_address(0));
> > +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
> > +               module_load_offset =
> > +                       get_random_u32_inclusive(1, 1024) *
> > PAGE_SIZE;
> 
> Minor:
> I think you can skip the IS_ENABLED(CONFIG_RANDOMIZE_BASE) part because
> CONFIG_RANDOMIZE_MEMORY depends on CONFIG_RANDOMIZE_BASE (which is
> checked in kaslr_enabled()).

Thanks, I'll look into it.

-- 
Sincerely yours,
Mike.

