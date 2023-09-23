Return-Path: <bpf+bounces-10687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58E07AC351
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CED7A1C209EA
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE361F19F;
	Sat, 23 Sep 2023 15:39:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500561D544;
	Sat, 23 Sep 2023 15:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2139BC433C8;
	Sat, 23 Sep 2023 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695483543;
	bh=44aW6DcKJaHGXelf02UJMtFK5RbIa4QmGjb00e/7p/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fw2A/tcOcobQiglJay8dvPT5bEfVdzbbmq0FwMYYkRDEvMMNze6l5vdxXC61b2ule
	 JFCwMCsxrAuMW6D9gVnh2enWSeUtDeXGmVEjWBDuVv9KbPW1MRt9tzybn9NNKJQMj2
	 y3Lc/W+nmmCK2KsTrqRVvz29GuwFbt1mGULYw6jBfPPwRcYXpuSga9okI5ya4zHkUD
	 tynDeAbBph8ozw0L4VOesv/AFGSBeSrp7QqXSV98fLRWfSHzHFilN6nNqox4/XsFqb
	 GBdnrmPrEZw+uXG8gLcDpColobXRcu9WsCK8bgQKX9ms+oqH3fV0ph2eOZh795NWNU
	 moLZ9gWnlnDaA==
Date: Sat, 23 Sep 2023 18:38:08 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
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
	Russell King <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH v3 02/13] mm: introduce execmem_text_alloc() and
 execmem_free()
Message-ID: <20230923153808.GI3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-3-rppt@kernel.org>
 <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com>

On Thu, Sep 21, 2023 at 03:34:18PM -0700, Song Liu wrote:
> On Mon, Sep 18, 2023 at 12:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> 
> [...]
> 
> > diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> > index 42215f9404af..db5561d0c233 100644
> > --- a/arch/s390/kernel/module.c
> > +++ b/arch/s390/kernel/module.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/moduleloader.h>
> >  #include <linux/bug.h>
> >  #include <linux/memory.h>
> > +#include <linux/execmem.h>
> >  #include <asm/alternative.h>
> >  #include <asm/nospec-branch.h>
> >  #include <asm/facility.h>
> > @@ -76,7 +77,7 @@ void *module_alloc(unsigned long size)
> >  #ifdef CONFIG_FUNCTION_TRACER
> >  void module_arch_cleanup(struct module *mod)
> >  {
> > -       module_memfree(mod->arch.trampolines_start);
> > +       execmem_free(mod->arch.trampolines_start);
> >  }
> >  #endif
> >
> > @@ -510,7 +511,7 @@ static int module_alloc_ftrace_hotpatch_trampolines(struct module *me,
> >
> >         size = FTRACE_HOTPATCH_TRAMPOLINES_SIZE(s->sh_size);
> >         numpages = DIV_ROUND_UP(size, PAGE_SIZE);
> > -       start = module_alloc(numpages * PAGE_SIZE);
> > +       start = execmem_text_alloc(EXECMEM_FTRACE, numpages * PAGE_SIZE);
> 
> This should be EXECMEM_MODULE_TEXT?

This is an ftrace trampoline, so I think it should be FTRACE type of
allocation.
 
> Thanks,
> Song
> 
> >         if (!start)
> >                 return -ENOMEM;
> >         set_memory_rox((unsigned long)start, numpages);
> [...]

-- 
Sincerely yours,
Mike.

