Return-Path: <bpf+bounces-3418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A773D7A5
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AE61C20837
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 06:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AE31116;
	Mon, 26 Jun 2023 06:13:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBDED3;
	Mon, 26 Jun 2023 06:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A6C433D9;
	Mon, 26 Jun 2023 06:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687760010;
	bh=tIDPiX4oZCQnSjoJrRmXYm4/HW+kneyQ9COWSK2/0ZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kqp3cvsRJ3zrwxvYCz0cNhvxJ+ddOQlZbdAd6MYB7hpQfGaPjaEWx4XRgumHA3asl
	 2pfxaCvJsapTma27TczMyDfkLmZLMX4LxIpbXhwpJJZRXNZyd0yCBPciRDI7IG26pW
	 ZofYK78Vy6+X23yGoPjG4iHaIJX3xZk1Cf5VyXONw4g0+lhwJyZb3QOZc9UC1abgeN
	 JpHRigJrpulMhEXYrJrzp6iqFIELQ33QjiEoR3RKROk8Rgf0ZADCCTCGDDgSsfyqIA
	 PxNsesDEzXoQ4yNdH5/98H+JDv2HJQTHEWa2ob8wVV0DOdBO7Eu/aKKZ0U8efnWun+
	 0ZC+zZqTlmuaA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so3627446e87.2;
        Sun, 25 Jun 2023 23:13:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDx3RS1tSDV4GnIXUXfaas/h7pEg6GTeJf56cXwb5ntnihtFlMH2
	4eNkqPkScdfHuPfCm6ZyZQyYLXmlruTm9AAJST8=
X-Google-Smtp-Source: ACHHUZ7Z1BsryLRBJgwSdFpXVYEgN5RfTaOqmCtmT2+wVlbf2QTe+Yf05nZb1BtwYAaKvRHJWuEELQy+6WhHrJTYCe0=
X-Received: by 2002:a05:6512:705:b0:4f9:ec5e:d624 with SMTP id
 b5-20020a056512070500b004f9ec5ed624mr1614382lfs.38.1687760008514; Sun, 25 Jun
 2023 23:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-3-rppt@kernel.org>
 <f9a7eebe-d36e-4587-b99d-35d4edefdd14@app.fastmail.com> <20230618080027.GA52412@kernel.org>
 <a17c65c6-863f-4026-9c6f-a04b659e9ab4@app.fastmail.com> <20230625161417.GK52412@kernel.org>
 <90161ac9-3ca0-4c72-b1c4-ab1293e55445@app.fastmail.com> <20230625174257.GL52412@kernel.org>
 <20230625180741.jrrtkq55c4jrqh3t@moria.home.lan>
In-Reply-To: <20230625180741.jrrtkq55c4jrqh3t@moria.home.lan>
From: Song Liu <song@kernel.org>
Date: Sun, 25 Jun 2023 23:13:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW45gmtCVgA0mg6X87x5EOzSmVqq3SCMSR6agyiukiJvEQ@mail.gmail.com>
Message-ID: <CAPhsuW45gmtCVgA0mg6X87x5EOzSmVqq3SCMSR6agyiukiJvEQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] mm: introduce execmem_text_alloc() and jit_text_alloc()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nadav Amit <nadav.amit@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, 
	"the arch/x86 maintainers" <x86@kernel.org>, pjt@google.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 11:07=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Sun, Jun 25, 2023 at 08:42:57PM +0300, Mike Rapoport wrote:
> > On Sun, Jun 25, 2023 at 09:59:34AM -0700, Andy Lutomirski wrote:
> > >
> > >
> > > On Sun, Jun 25, 2023, at 9:14 AM, Mike Rapoport wrote:
> > > > On Mon, Jun 19, 2023 at 10:09:02AM -0700, Andy Lutomirski wrote:
> > > >>
> > > >> On Sun, Jun 18, 2023, at 1:00 AM, Mike Rapoport wrote:
> > > >> > On Sat, Jun 17, 2023 at 01:38:29PM -0700, Andy Lutomirski wrote:
> > > >> >> On Fri, Jun 16, 2023, at 1:50 AM, Mike Rapoport wrote:
> > > >> >> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > >> >> >
> > > >> >> > module_alloc() is used everywhere as a mean to allocate memor=
y for code.
> > > >> >> >
> > > >> >> > Beside being semantically wrong, this unnecessarily ties all =
subsystems
> > > >> >> > that need to allocate code, such as ftrace, kprobes and BPF t=
o modules
> > > >> >> > and puts the burden of code allocation to the modules code.
> > > >> >> >
> > > >> >> > Several architectures override module_alloc() because of vari=
ous
> > > >> >> > constraints where the executable memory can be located and th=
is causes
> > > >> >> > additional obstacles for improvements of code allocation.
> > > >> >> >
> > > >> >> > Start splitting code allocation from modules by introducing
> > > >> >> > execmem_text_alloc(), execmem_free(), jit_text_alloc(), jit_f=
ree() APIs.
> > > >> >> >
> > > >> >> > Initially, execmem_text_alloc() and jit_text_alloc() are wrap=
pers for
> > > >> >> > module_alloc() and execmem_free() and jit_free() are replacem=
ents of
> > > >> >> > module_memfree() to allow updating all call sites to use the =
new APIs.
> > > >> >> >
> > > >> >> > The intention semantics for new allocation APIs:
> > > >> >> >
> > > >> >> > * execmem_text_alloc() should be used to allocate memory that=
 must reside
> > > >> >> >   close to the kernel image, like loadable kernel modules and=
 generated
> > > >> >> >   code that is restricted by relative addressing.
> > > >> >> >
> > > >> >> > * jit_text_alloc() should be used to allocate memory for gene=
rated code
> > > >> >> >   when there are no restrictions for the code placement. For
> > > >> >> >   architectures that require that any code is within certain =
distance
> > > >> >> >   from the kernel image, jit_text_alloc() will be essentially=
 aliased to
> > > >> >> >   execmem_text_alloc().
> > > >> >> >
> > > >> >>
> > > >> >> Is there anything in this series to help users do the appropria=
te
> > > >> >> synchronization when the actually populate the allocated memory=
 with
> > > >> >> code?  See here, for example:
> > > >> >
> > > >> > This series only factors out the executable allocations from mod=
ules and
> > > >> > puts them in a central place.
> > > >> > Anything else would go on top after this lands.
> > > >>
> > > >> Hmm.
> > > >>
> > > >> On the one hand, there's nothing wrong with factoring out common c=
ode. On
> > > >> the other hand, this is probably the right time to at least start
> > > >> thinking about synchronization, at least to the extent that it mig=
ht make
> > > >> us want to change this API.  (I'm not at all saying that this seri=
es
> > > >> should require changes -- I'm just saying that this is a good time=
 to
> > > >> think about how this should work.)
> > > >>
> > > >> The current APIs, *and* the proposed jit_text_alloc() API, don't a=
ctually
> > > >> look like the one think in the Linux ecosystem that actually
> > > >> intelligently and efficiently maps new text into an address space:
> > > >> mmap().
> > > >>
> > > >> On x86, you can mmap() an existing file full of executable code PR=
OT_EXEC
> > > >> and jump to it with minimal synchronization (just the standard imp=
licit
> > > >> ordering in the kernel that populates the pages before setting up =
the
> > > >> PTEs and whatever user synchronization is needed to avoid jumping =
into
> > > >> the mapping before mmap() finishes).  It works across CPUs, and th=
e only
> > > >> possible way userspace can screw it up (for a read-only mapping of
> > > >> read-only text, anyway) is to jump to the mapping too early, in wh=
ich
> > > >> case userspace gets a page fault.  Incoherence is impossible, and =
no one
> > > >> needs to "serialize" (in the SDM sense).
> > > >>
> > > >> I think the same sequence (from userspace's perspective) works on =
other
> > > >> architectures, too, although I think more cache management is need=
ed on
> > > >> the kernel's end.  As far as I know, no Linux SMP architecture nee=
ds an
> > > >> IPI to map executable text into usermode, but I could easily be wr=
ong.
> > > >> (IIRC RISC-V has very developer-unfriendly icache management, but =
I don't
> > > >> remember the details.)
> > > >>
> > > >> Of course, using ptrace or any other FOLL_FORCE to modify text on =
x86 is
> > > >> rather fraught, and I bet many things do it wrong when userspace i=
s
> > > >> multithreaded.  But not in production because it's mostly not used=
 in
> > > >> production.)
> > > >>
> > > >> But jit_text_alloc() can't do this, because the order of operation=
s
> > > >> doesn't match.  With jit_text_alloc(), the executable mapping show=
s up
> > > >> before the text is populated, so there is no atomic change from no=
t-there
> > > >> to populated-and-executable.  Which means that there is an opportu=
nity
> > > >> for CPUs, speculatively or otherwise, to start filling various cac=
hes
> > > >> with intermediate states of the text, which means that various
> > > >> architectures (even x86!) may need serialization.
> > > >>
> > > >> For eBPF- and module- like use cases, where JITting/code gen is qu=
ite
> > > >> coarse-grained, perhaps something vaguely like:
> > > >>
> > > >> jit_text_alloc() -> returns a handle and an executable virtual add=
ress,
> > > >> but does *not* map it there
> > > >> jit_text_write() -> write to that handle
> > > >> jit_text_map() -> map it and synchronize if needed (no sync needed=
 on
> > > >> x86, I think)
> > > >>
> > > >> could be more efficient and/or safer.
> > > >>
> > > >> (Modules could use this too.  Getting alternatives right might tak=
e some
> > > >> fiddling, because off the top of my head, this doesn't match how i=
t works
> > > >> now.)
> > > >>
> > > >> To make alternatives easier, this could work, maybe (haven't fully
> > > >> thought it through):
> > > >>
> > > >> jit_text_alloc()
> > > >> jit_text_map_rw_inplace() -> map at the target address, but RW, !X
> > > >>
> > > >> write the text and apply alternatives
> > > >>
> > > >> jit_text_finalize() -> change from RW to RX *and synchronize*
> > > >>
> > > >> jit_text_finalize() would either need to wait for RCU (possibly ex=
tra
> > > >> heavy weight RCU to get "serialization") or send an IPI.
> > > >
> > > > This essentially how modules work now. The memory is allocated RW, =
written
> > > > and updated with alternatives and then made ROX in the end with set=
_memory
> > > > APIs.
> > > >
> > > > The issue with not having the memory mapped X when it's written is =
that we
> > > > cannot use large pages to map it. One of the goals is to have execu=
table
> > > > memory mapped with large pages and make code allocator able to divi=
de that
> > > > page among several callers.
> > > >
> > > > So the idea was that jit_text_alloc() will have a cache of large pa=
ges
> > > > mapped ROX, will allocate memory from those caches and there will b=
e
> > > > jit_update() that uses text poking for writing to that memory.
> > > >
> > > > Upon allocation of a large page to increase the cache, that large p=
age will
> > > > be "invalidated" by filling it with breakpoint instructions (e.g in=
t3 on
> > > > x86)
> > >
> > > Is this actually valid?  In between int3 and real code, there=E2=80=
=99s a
> > > potential torn read of real code mixed up with 0xcc.
> >
> > You mean while doing text poking?
>
> I think we've been getting distracted by text_poke(). text_poke() does
> updates via a different virtual address which introduce new
> synchroniation wrinkles, but it's not the main issue.
>
> As _think_ I understand it, the root of the issue is that speculative
> execution - and that per Andy, speculative execution doesn't obey memory
> barriers.
>
> I have _not_ dug into the details of how retpolines work and all the
> spectre stuff that was going on, but - retpoline uses lfence, doesn't
> it? And if speculative execution is the issue here, isn't retpoline what
> we need?
>
> For this particular issue, I'm not sure "invalidate by filling with
> illegal instructions" makes sense. For that to work, would the processor
> have to execute a serialize operation and a retry on hitting an illegal
> instruction - or perhaps we do in the interrupt handler?
>
> But if filling with illegal instructions does act as a speculation
> barrier, then the issue is that a torn read could generate a legal but
> incorrect instruction.

What is a "torn read" here? I assume it is an instruction read that
goes at the wrong instruction boundary (CISC). If this is correct, do
we need to handle torn read caused by software bug, or hardware
bit flip, or both?

Thanks,
Song

