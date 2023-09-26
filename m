Return-Path: <bpf+bounces-10859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63257AE756
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 10:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 953631C208F5
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2B125A3;
	Tue, 26 Sep 2023 08:05:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA02906;
	Tue, 26 Sep 2023 08:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB07C433C7;
	Tue, 26 Sep 2023 08:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695715524;
	bh=+Amk36a0CBOiKu5+FtjGQvFX395/lzfG991XVrUkCKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLx2TLWKtN7VAMAOy6Z+yt+5L2H3WvCxgk6fo3xEAFTVDZv0mPqQm9oryMdet+1qZ
	 obrB5TY2nE/qbUSfaI1uId3y2yRK2qnxEYYQpqf8IMXRqLpaWcyp6r1h8W5YGqDDxg
	 /Ipk9rb4CjRrT7bowSHMduOUAEuaFMTD7nXxu83iUI+O1xmmOj2PJsMoiGARKNDMsM
	 m8lXDTJPRNGVXjXTr34wm+BzlG4p+UzrUM7cd5TVxTprWIBaR+mK3IXevwTFE0yWC2
	 SIHL7mRKLFjL2iR5rLVY4OdrYFjdV9kMecllhx3OCPX+UXN+tAGab3AHw/soEZdxZb
	 tvxNd43ZGN+BA==
Date: Tue, 26 Sep 2023 11:04:22 +0300
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
Message-ID: <20230926080422.GP3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-3-rppt@kernel.org>
 <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com>
 <20230923153808.GI3303@kernel.org>
 <CAPhsuW6TxG87ZBwQ_027iiE+_UmXweZEPh8wKHkHo7wA+qXZUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6TxG87ZBwQ_027iiE+_UmXweZEPh8wKHkHo7wA+qXZUg@mail.gmail.com>

On Sat, Sep 23, 2023 at 03:36:01PM -0700, Song Liu wrote:
> On Sat, Sep 23, 2023 at 8:39 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Sep 21, 2023 at 03:34:18PM -0700, Song Liu wrote:
> > > On Mon, Sep 18, 2023 at 12:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > >
> > > [...]
> > >
> > > > diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> > > > index 42215f9404af..db5561d0c233 100644
> > > > --- a/arch/s390/kernel/module.c
> > > > +++ b/arch/s390/kernel/module.c
> > > > @@ -21,6 +21,7 @@
> > > >  #include <linux/moduleloader.h>
> > > >  #include <linux/bug.h>
> > > >  #include <linux/memory.h>
> > > > +#include <linux/execmem.h>
> > > >  #include <asm/alternative.h>
> > > >  #include <asm/nospec-branch.h>
> > > >  #include <asm/facility.h>
> > > > @@ -76,7 +77,7 @@ void *module_alloc(unsigned long size)
> > > >  #ifdef CONFIG_FUNCTION_TRACER
> > > >  void module_arch_cleanup(struct module *mod)
> > > >  {
> > > > -       module_memfree(mod->arch.trampolines_start);
> > > > +       execmem_free(mod->arch.trampolines_start);
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -510,7 +511,7 @@ static int module_alloc_ftrace_hotpatch_trampolines(struct module *me,
> > > >
> > > >         size = FTRACE_HOTPATCH_TRAMPOLINES_SIZE(s->sh_size);
> > > >         numpages = DIV_ROUND_UP(size, PAGE_SIZE);
> > > > -       start = module_alloc(numpages * PAGE_SIZE);
> > > > +       start = execmem_text_alloc(EXECMEM_FTRACE, numpages * PAGE_SIZE);
> > >
> > > This should be EXECMEM_MODULE_TEXT?
> >
> > This is an ftrace trampoline, so I think it should be FTRACE type of
> > allocation.
> 
> Yeah, I was aware of the ftrace trampoline. My point was, ftrace trampoline
> doesn't seem to have any special requirements. Therefore, it is probably not
> necessary to have a separate type just for it.

Since ftrace trampolines are currently used only on s390 and x86 which
enforce the same range for all executable allocations there are no special
requirements indeed. But I think that explicitly marking these allocations
as FTRACE makes it clearer what are they used for and I don't see downsides
to having a type for FTRACE.
 
> AFAICT, kprobe, ftrace, and BPF (JIT and trampoline) can share the same
> execmem_type. We may need some work for some archs, but nothing is
> fundamentally different among these.

Using the same type for all generated code implies that all types of the
generated code must live in the same range and I don't think we want to
impose this limitation on architectures.

For example, RISC-V deliberately added a range for BPF code to allow
relative addressing, see commit 7f3631e88ee6 ("riscv, bpf: Provide RISC-V
specific JIT image alloc/free").
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.

