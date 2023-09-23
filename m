Return-Path: <bpf+bounces-10694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9887AC399
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 2C8981F23CA4
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EAC208B9;
	Sat, 23 Sep 2023 16:24:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C51EA7E;
	Sat, 23 Sep 2023 16:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C213C433C8;
	Sat, 23 Sep 2023 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695486280;
	bh=LPa0vOpCN9uFCJLwT0Mv83PIALUPvGiZjoSaYDcpsJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbZg7GgD8+BmM0EbIou3DUcf1HdG1quOywXNpDmhicICfIw73rq/zzU/h/vI/qZDp
	 XFUEPcYb9UPuknO3UuH9df8jDX6Y2cSrJ80wg4ZDDFpWgi05sPMcC4MzWe2C0cyCeu
	 nP6/UDcZM95kD65En58LM92KcpcWG3KRH0guTPfrV4zfxxO4soUJ8uiNt0flLBa+d0
	 BLkPfitclvMDS0vd51IsKv7CF8IIIdzK9/P0gBrSPMYS98N2ZZq1Bne2bq5a34spi2
	 CfuytAh2slWgJP4aWqKBet8FSXiJNiOrIpHAN1uhuJKdaS5HEKlew5LP5bm2Q0OAmM
	 QvG1TNKlGHcFw==
Date: Sat, 23 Sep 2023 19:23:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
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
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 08/13] riscv: extend execmem_params for generated code
 allocations
Message-ID: <20230923162340.GM3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-9-rppt@kernel.org>
 <6d686c54-078d-8d71-d4e2-c754cf92c557@ghiti.fr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d686c54-078d-8d71-d4e2-c754cf92c557@ghiti.fr>

On Fri, Sep 22, 2023 at 12:37:07PM +0200, Alexandre Ghiti wrote:
> Hi Mike,
> 
> On 18/09/2023 09:29, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > The memory allocations for kprobes and BPF on RISC-V are not placed in
> > the modules area and these custom allocations are implemented with
> > overrides of alloc_insn_page() and  bpf_jit_alloc_exec().
> > 
> > Slightly reorder execmem_params initialization to support both 32 and 64
> > bit variants, define EXECMEM_KPROBES and EXECMEM_BPF ranges in
> > riscv::execmem_params and drop overrides of alloc_insn_page() and
> > bpf_jit_alloc_exec().
> > 
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >   arch/riscv/kernel/module.c         | 21 ++++++++++++++++++++-
> >   arch/riscv/kernel/probes/kprobes.c | 10 ----------
> >   arch/riscv/net/bpf_jit_core.c      | 13 -------------
> >   3 files changed, 20 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > index 343a0edfb6dd..31505ecb5c72 100644
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -436,20 +436,39 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >   	return 0;
> >   }
> > -#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> > +#ifdef CONFIG_MMU
> >   static struct execmem_params execmem_params __ro_after_init = {
> >   	.ranges = {
> >   		[EXECMEM_DEFAULT] = {
> >   			.pgprot = PAGE_KERNEL,
> >   			.alignment = 1,
> >   		},
> > +		[EXECMEM_KPROBES] = {
> > +			.pgprot = PAGE_KERNEL_READ_EXEC,
> > +			.alignment = 1,
> > +		},
> > +		[EXECMEM_BPF] = {
> > +			.pgprot = PAGE_KERNEL,
> > +			.alignment = 1,
> 
> 
> Not entirely sure it is the same alignment (sorry did not go through the
> entire series), but if it is, the alignment above ^ is not the same that is
> requested by our current bpf_jit_alloc_exec() implementation which is
> PAGE_SIZE.
 
This literally translates vmalloc() in alloc_insn_page() to a set of
parameters, so "1" comes from there. And using alignment of 1 with
vmalloc() implicitly sets it to PAGE_SIZE.

> > +		},
> >   	},
> >   };
> >   struct execmem_params __init *execmem_arch_params(void)
> >   {
> > +#ifdef CONFIG_64BIT
> >   	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
> >   	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
> > +#else
> > +	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
> > +	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
> > +#endif
> > +
> > +	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
> > +	execmem_params.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
> > +
> > +	execmem_params.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
> > +	execmem_params.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
> >   	return &execmem_params;
> >   }
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> > index 2f08c14a933d..e64f2f3064eb 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -104,16 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >   	return 0;
> >   }
> > -#ifdef CONFIG_MMU
> > -void *alloc_insn_page(void)
> > -{
> > -	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > -				     GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
> > -				     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> > -				     __builtin_return_address(0));
> > -}
> > -#endif
> > -
> >   /* install breakpoint in text */
> >   void __kprobes arch_arm_kprobe(struct kprobe *p)
> >   {
> > diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> > index 7b70ccb7fec3..c8a758f0882b 100644
> > --- a/arch/riscv/net/bpf_jit_core.c
> > +++ b/arch/riscv/net/bpf_jit_core.c
> > @@ -218,19 +218,6 @@ u64 bpf_jit_alloc_exec_limit(void)
> >   	return BPF_JIT_REGION_SIZE;
> >   }
> > -void *bpf_jit_alloc_exec(unsigned long size)
> > -{
> > -	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> > -				    BPF_JIT_REGION_END, GFP_KERNEL,
> > -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > -				    __builtin_return_address(0));
> > -}
> > -
> > -void bpf_jit_free_exec(void *addr)
> > -{
> > -	return vfree(addr);
> > -}
> > -
> >   void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> >   {
> >   	int ret;
> 
> 
> Otherwise, you can add:
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> Thanks,
> 
> Alex
> 
> 

-- 
Sincerely yours,
Mike.

