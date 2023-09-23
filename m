Return-Path: <bpf+bounces-10696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB127AC3AF
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 40E3C2821AD
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191C0208CC;
	Sat, 23 Sep 2023 16:28:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884351EA7E;
	Sat, 23 Sep 2023 16:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98403C433C7;
	Sat, 23 Sep 2023 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695486519;
	bh=RqAizeoAgpyrjTuWTc3EPt+00fz0GKOYt3wgiu3ilxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdX7uAUn5A/nOh6b98KyxWdk9fFgHiJgriB/fwuK77YQxwt85ckYKTY9t3fBf62wY
	 OdfH5+weEeIpqZEmVKOTk/M6qPAq6DbFmu80HRazp/dQJOGu5Fdotg7Z2IUrfIcHFK
	 CzwEzww+QWurkfb1eX0LPowGymg+QANEOY5nujQK9DRlmOgfq/CMbzYwknq+dY7tnp
	 PeA7IOMb8Twk1q2cqZZhCdVsAByDQXH6HWv6/P0+r3F48yu28WNKT0AH75egCCxIj0
	 rSO4bYh3+oBADB8dkFnn9uQPpZxQXif883hCwsCk2af3dw5oO2O8+odTCE6fZmVuyX
	 JCGFYC8Rtz+ZQ==
Date: Sat, 23 Sep 2023 19:27:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 09/13] powerpc: extend execmem_params for kprobes
 allocations
Message-ID: <20230923162742.GO3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-10-rppt@kernel.org>
 <1cb41761-29d0-5d33-b7c1-0ca3acaa810d@csgroup.eu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb41761-29d0-5d33-b7c1-0ca3acaa810d@csgroup.eu>

Hi Christophe,

On Fri, Sep 22, 2023 at 10:32:46AM +0000, Christophe Leroy wrote:
> Hi Mike,
> 
> Le 18/09/2023 à 09:29, Mike Rapoport a écrit :
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > powerpc overrides kprobes::alloc_insn_page() to remove writable
> > permissions when STRICT_MODULE_RWX is on.
> > 
> > Add definition of EXECMEM_KRPOBES to execmem_params to allow using the
> > generic kprobes::alloc_insn_page() with the desired permissions.
> > 
> > As powerpc uses breakpoint instructions to inject kprobes, it does not
> > need to constrain kprobe allocations to the modules area and can use the
> > entire vmalloc address space.
> 
> I don't understand what you mean here. Does it mean kprobe allocation 
> doesn't need to be executable ? I don't think so based on the pgprot you 
> set.
> 
> On powerpc book3s/32, vmalloc space is not executable. Only modules 
> space is executable. X/NX cannot be set on a per page basis, it can only 
> be set on a 256 Mbytes segment basis.
> 
> See commit c49643319715 ("powerpc/32s: Only leave NX unset on segments 
> used for modules") and 6ca055322da8 ("powerpc/32s: Use dedicated segment 
> for modules with STRICT_KERNEL_RWX") and 7bee31ad8e2f ("powerpc/32s: Fix 
> is_module_segment() when MODULES_VADDR is defined").
> 
> So if your intention is still to have an executable kprobes, then you 
> can't use vmalloc address space.

Right, and I've fixed the KPROBES range to uses the same range as MODULES.
The commit message is stale and I need to update it.
 
> Christophe
> 
> > 
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >   arch/powerpc/kernel/kprobes.c | 14 --------------
> >   arch/powerpc/kernel/module.c  | 11 +++++++++++
> >   2 files changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> > index 62228c7072a2..14c5ddec3056 100644
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -126,20 +126,6 @@ kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offse
> >   	return (kprobe_opcode_t *)(addr + offset);
> >   }
> >   
> > -void *alloc_insn_page(void)
> > -{
> > -	void *page;
> > -
> > -	page = execmem_text_alloc(EXECMEM_KPROBES, PAGE_SIZE);
> > -	if (!page)
> > -		return NULL;
> > -
> > -	if (strict_module_rwx_enabled())
> > -		set_memory_rox((unsigned long)page, 1);
> > -
> > -	return page;
> > -}
> > -
> >   int arch_prepare_kprobe(struct kprobe *p)
> >   {
> >   	int ret = 0;
> > diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
> > index 824d9541a310..bf2c62aef628 100644
> > --- a/arch/powerpc/kernel/module.c
> > +++ b/arch/powerpc/kernel/module.c
> > @@ -95,6 +95,9 @@ static struct execmem_params execmem_params __ro_after_init = {
> >   		[EXECMEM_DEFAULT] = {
> >   			.alignment = 1,
> >   		},
> > +		[EXECMEM_KPROBES] = {
> > +			.alignment = 1,
> > +		},
> >   		[EXECMEM_MODULE_DATA] = {
> >   			.alignment = 1,
> >   		},
> > @@ -135,5 +138,13 @@ struct execmem_params __init *execmem_arch_params(void)
> >   
> >   	range->pgprot = prot;
> >   
> > +	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
> > +	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_END;
> > +
> > +	if (strict_module_rwx_enabled())
> > +		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
> > +	else
> > +		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
> > +
> >   	return &execmem_params;
> >   }

-- 
Sincerely yours,
Mike.

