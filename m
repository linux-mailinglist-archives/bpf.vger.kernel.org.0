Return-Path: <bpf+bounces-3429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF6373DBE3
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81916280DC7
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DCD7487;
	Mon, 26 Jun 2023 09:54:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED97464;
	Mon, 26 Jun 2023 09:54:17 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB99B;
	Mon, 26 Jun 2023 02:54:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b4826ba943so40168211fa.0;
        Mon, 26 Jun 2023 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687773253; x=1690365253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkJiT0hPCVGufk3wfK9OYfFQLFeH4WpXrH92jiyy/So=;
        b=LI5UZd6nWq3K7Pk9RsvstakVLfRy9rPrPfGF9Jxi7xqsukDqd54gYlmkO8NO2qWlHY
         laEGLm0NqwaArg2B0U1mb2ZrqnQ9DVwimD6R9fGkz1Yd2PDLrxg65lZLZigg5lTSIx2l
         56OJh1znTXpgfq6PeFjAtc4vfilcMyYO/Wyxt9uZPzTfS51DnEEvSczgbxwfbCIBHHC0
         7ypRQx2o2pgmpeEfRoHRRO1a/N4rztkHAi5QRE7HA32OEPIVtwvl4zPvnFeZBbFS9Pc3
         +XHYPCfQMMO7KjwgAec1IpnT5/TZoHL4STHkcCNJVmExNECcWBSghyv+4KQ48cIUrCZM
         M6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687773253; x=1690365253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkJiT0hPCVGufk3wfK9OYfFQLFeH4WpXrH92jiyy/So=;
        b=h/ytM4r15EXzkLlLP9BWwqS1EzNlZDiH9pFRp4U5/vIFMQse0ELN2FDxdoK7OfmHnZ
         SLCkAlYve22PQlgbF7cbXzHrQ7Op0n1rbEmGgOtVdACNpUxmU3RDo+dK96eTvOdLjEgP
         I4P5VNH5R1TvkR+c6vkQEPZ9v4SEM58b+fGRBdE6vuj51CXqtx+zeX49EGoBKxr43vcN
         2aDGSR6QRAe3D/4r10Fc3DCHitICPWkoUWN6jzeGr9Iejv9bXGXtCzOhGvzVwEsYrLgG
         vkssWe3DlXo3l67yw9Gq4+VNLvVPL5jhZ+IToqIyyyABW150naACnQMW3qUkA55i+Jcb
         ktrg==
X-Gm-Message-State: AC+VfDzuN2YpesW80J6m8oucIyo8m+OVaHJDvfp4fAe6o+a8GlY+zAlV
	TAKWNeaR+LXz7PMmk+yrNpqbYrjfRE713M/iLh07NeXCn3S/tjDD
X-Google-Smtp-Source: ACHHUZ67jMr16NDRNLWv9518HCJB3Am5wfZo0UzBIm/hvCg0LmCzdDMhboQHv94rDq5VEGtQPY2hBiRv+xQ6CfYSFdg=
X-Received: by 2002:a2e:9183:0:b0:2b4:6e21:637e with SMTP id
 f3-20020a2e9183000000b002b46e21637emr13282046ljg.16.1687773253077; Mon, 26
 Jun 2023 02:54:13 -0700 (PDT)
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
 <20230625180741.jrrtkq55c4jrqh3t@moria.home.lan> <CAPhsuW45gmtCVgA0mg6X87x5EOzSmVqq3SCMSR6agyiukiJvEQ@mail.gmail.com>
In-Reply-To: <CAPhsuW45gmtCVgA0mg6X87x5EOzSmVqq3SCMSR6agyiukiJvEQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 26 Jun 2023 11:54:02 +0200
Message-ID: <CANk7y0jcakmuF4e9x8z7ZUra=MPx-=xxb0JZ3RrJ+S9Eb9-0_g@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] mm: introduce execmem_text_alloc() and jit_text_alloc()
To: Song Liu <song@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Kees Cook <keescook@chromium.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nadav Amit <nadav.amit@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 8:13=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sun, Jun 25, 2023 at 11:07=E2=80=AFAM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Sun, Jun 25, 2023 at 08:42:57PM +0300, Mike Rapoport wrote:
> > > On Sun, Jun 25, 2023 at 09:59:34AM -0700, Andy Lutomirski wrote:
> > > >
> > > >
> > > > On Sun, Jun 25, 2023, at 9:14 AM, Mike Rapoport wrote:
> > > > > On Mon, Jun 19, 2023 at 10:09:02AM -0700, Andy Lutomirski wrote:
> > > > >>
> > > > >> On Sun, Jun 18, 2023, at 1:00 AM, Mike Rapoport wrote:
> > > > >> > On Sat, Jun 17, 2023 at 01:38:29PM -0700, Andy Lutomirski wrot=
e:
> > > > >> >> On Fri, Jun 16, 2023, at 1:50 AM, Mike Rapoport wrote:
> > > > >> >> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > > >> >> >
> > > > >> >> > module_alloc() is used everywhere as a mean to allocate mem=
ory for code.
> > > > >> >> >
> > > > >> >> > Beside being semantically wrong, this unnecessarily ties al=
l subsystems
> > > > >> >> > that need to allocate code, such as ftrace, kprobes and BPF=
 to modules
> > > > >> >> > and puts the burden of code allocation to the modules code.
> > > > >> >> >
> > > > >> >> > Several architectures override module_alloc() because of va=
rious
> > > > >> >> > constraints where the executable memory can be located and =
this causes
> > > > >> >> > additional obstacles for improvements of code allocation.
> > > > >> >> >
> > > > >> >> > Start splitting code allocation from modules by introducing
> > > > >> >> > execmem_text_alloc(), execmem_free(), jit_text_alloc(), jit=
_free() APIs.
> > > > >> >> >
> > > > >> >> > Initially, execmem_text_alloc() and jit_text_alloc() are wr=
appers for
> > > > >> >> > module_alloc() and execmem_free() and jit_free() are replac=
ements of
> > > > >> >> > module_memfree() to allow updating all call sites to use th=
e new APIs.
> > > > >> >> >
> > > > >> >> > The intention semantics for new allocation APIs:
> > > > >> >> >
> > > > >> >> > * execmem_text_alloc() should be used to allocate memory th=
at must reside
> > > > >> >> >   close to the kernel image, like loadable kernel modules a=
nd generated
> > > > >> >> >   code that is restricted by relative addressing.
> > > > >> >> >
> > > > >> >> > * jit_text_alloc() should be used to allocate memory for ge=
nerated code
> > > > >> >> >   when there are no restrictions for the code placement. Fo=
r
> > > > >> >> >   architectures that require that any code is within certai=
n distance
> > > > >> >> >   from the kernel image, jit_text_alloc() will be essential=
ly aliased to
> > > > >> >> >   execmem_text_alloc().
> > > > >> >> >
> > > > >> >>
> > > > >> >> Is there anything in this series to help users do the appropr=
iate
> > > > >> >> synchronization when the actually populate the allocated memo=
ry with
> > > > >> >> code?  See here, for example:
> > > > >> >
> > > > >> > This series only factors out the executable allocations from m=
odules and
> > > > >> > puts them in a central place.
> > > > >> > Anything else would go on top after this lands.
> > > > >>
> > > > >> Hmm.
> > > > >>
> > > > >> On the one hand, there's nothing wrong with factoring out common=
 code. On
> > > > >> the other hand, this is probably the right time to at least star=
t
> > > > >> thinking about synchronization, at least to the extent that it m=
ight make
> > > > >> us want to change this API.  (I'm not at all saying that this se=
ries
> > > > >> should require changes -- I'm just saying that this is a good ti=
me to
> > > > >> think about how this should work.)
> > > > >>
> > > > >> The current APIs, *and* the proposed jit_text_alloc() API, don't=
 actually
> > > > >> look like the one think in the Linux ecosystem that actually
> > > > >> intelligently and efficiently maps new text into an address spac=
e:
> > > > >> mmap().
> > > > >>
> > > > >> On x86, you can mmap() an existing file full of executable code =
PROT_EXEC
> > > > >> and jump to it with minimal synchronization (just the standard i=
mplicit
> > > > >> ordering in the kernel that populates the pages before setting u=
p the
> > > > >> PTEs and whatever user synchronization is needed to avoid jumpin=
g into
> > > > >> the mapping before mmap() finishes).  It works across CPUs, and =
the only
> > > > >> possible way userspace can screw it up (for a read-only mapping =
of
> > > > >> read-only text, anyway) is to jump to the mapping too early, in =
which
> > > > >> case userspace gets a page fault.  Incoherence is impossible, an=
d no one
> > > > >> needs to "serialize" (in the SDM sense).
> > > > >>
> > > > >> I think the same sequence (from userspace's perspective) works o=
n other
> > > > >> architectures, too, although I think more cache management is ne=
eded on
> > > > >> the kernel's end.  As far as I know, no Linux SMP architecture n=
eeds an
> > > > >> IPI to map executable text into usermode, but I could easily be =
wrong.
> > > > >> (IIRC RISC-V has very developer-unfriendly icache management, bu=
t I don't
> > > > >> remember the details.)
> > > > >>
> > > > >> Of course, using ptrace or any other FOLL_FORCE to modify text o=
n x86 is
> > > > >> rather fraught, and I bet many things do it wrong when userspace=
 is
> > > > >> multithreaded.  But not in production because it's mostly not us=
ed in
> > > > >> production.)
> > > > >>
> > > > >> But jit_text_alloc() can't do this, because the order of operati=
ons
> > > > >> doesn't match.  With jit_text_alloc(), the executable mapping sh=
ows up
> > > > >> before the text is populated, so there is no atomic change from =
not-there
> > > > >> to populated-and-executable.  Which means that there is an oppor=
tunity
> > > > >> for CPUs, speculatively or otherwise, to start filling various c=
aches
> > > > >> with intermediate states of the text, which means that various
> > > > >> architectures (even x86!) may need serialization.
> > > > >>
> > > > >> For eBPF- and module- like use cases, where JITting/code gen is =
quite
> > > > >> coarse-grained, perhaps something vaguely like:
> > > > >>
> > > > >> jit_text_alloc() -> returns a handle and an executable virtual a=
ddress,
> > > > >> but does *not* map it there
> > > > >> jit_text_write() -> write to that handle
> > > > >> jit_text_map() -> map it and synchronize if needed (no sync need=
ed on
> > > > >> x86, I think)
> > > > >>
> > > > >> could be more efficient and/or safer.
> > > > >>
> > > > >> (Modules could use this too.  Getting alternatives right might t=
ake some
> > > > >> fiddling, because off the top of my head, this doesn't match how=
 it works
> > > > >> now.)
> > > > >>
> > > > >> To make alternatives easier, this could work, maybe (haven't ful=
ly
> > > > >> thought it through):
> > > > >>
> > > > >> jit_text_alloc()
> > > > >> jit_text_map_rw_inplace() -> map at the target address, but RW, =
!X
> > > > >>
> > > > >> write the text and apply alternatives
> > > > >>
> > > > >> jit_text_finalize() -> change from RW to RX *and synchronize*
> > > > >>
> > > > >> jit_text_finalize() would either need to wait for RCU (possibly =
extra
> > > > >> heavy weight RCU to get "serialization") or send an IPI.
> > > > >
> > > > > This essentially how modules work now. The memory is allocated RW=
, written
> > > > > and updated with alternatives and then made ROX in the end with s=
et_memory
> > > > > APIs.
> > > > >
> > > > > The issue with not having the memory mapped X when it's written i=
s that we
> > > > > cannot use large pages to map it. One of the goals is to have exe=
cutable
> > > > > memory mapped with large pages and make code allocator able to di=
vide that
> > > > > page among several callers.
> > > > >
> > > > > So the idea was that jit_text_alloc() will have a cache of large =
pages
> > > > > mapped ROX, will allocate memory from those caches and there will=
 be
> > > > > jit_update() that uses text poking for writing to that memory.
> > > > >
> > > > > Upon allocation of a large page to increase the cache, that large=
 page will
> > > > > be "invalidated" by filling it with breakpoint instructions (e.g =
int3 on
> > > > > x86)
> > > >
> > > > Is this actually valid?  In between int3 and real code, there=E2=80=
=99s a
> > > > potential torn read of real code mixed up with 0xcc.
> > >
> > > You mean while doing text poking?
> >
> > I think we've been getting distracted by text_poke(). text_poke() does
> > updates via a different virtual address which introduce new
> > synchroniation wrinkles, but it's not the main issue.
> >
> > As _think_ I understand it, the root of the issue is that speculative
> > execution - and that per Andy, speculative execution doesn't obey memor=
y
> > barriers.
> >
> > I have _not_ dug into the details of how retpolines work and all the
> > spectre stuff that was going on, but - retpoline uses lfence, doesn't
> > it? And if speculative execution is the issue here, isn't retpoline wha=
t
> > we need?
> >
> > For this particular issue, I'm not sure "invalidate by filling with
> > illegal instructions" makes sense. For that to work, would the processo=
r
> > have to execute a serialize operation and a retry on hitting an illegal
> > instruction - or perhaps we do in the interrupt handler?
> >
> > But if filling with illegal instructions does act as a speculation
> > barrier, then the issue is that a torn read could generate a legal but
> > incorrect instruction.
>
> What is a "torn read" here? I assume it is an instruction read that
> goes at the wrong instruction boundary (CISC). If this is correct, do
> we need to handle torn read caused by software bug, or hardware
> bit flip, or both?

On ARM64 (RISC), torn reads can't happen because the instruction fetch
is word aligned. If we replace the whole instruction atomically then there
won't be half old - half new instruction fetches.

Thanks,
Puranjay

