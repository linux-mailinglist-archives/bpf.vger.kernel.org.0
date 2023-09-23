Return-Path: <bpf+bounces-10700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A97AC5B9
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 00:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 03F8C281D7E
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3330208CF;
	Sat, 23 Sep 2023 22:36:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1ECC8CC;
	Sat, 23 Sep 2023 22:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0672C433A9;
	Sat, 23 Sep 2023 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695508575;
	bh=p6KwkG6gIDCpi+5ECOWCYMC6fT/RtPXwryMv7tZb+xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sdoueq4M4QTiFNPfWfSloC8UKyAofVMUXLdmfW+XAUHMMD2LvJyRaeus5UjoSPFlr
	 88Wh6CmBckFHEhnxKycvXUfGgEmVhnkNg21KC23xUdnnlxkbYasPjPKkQlrcNAebr5
	 9pHynRgrmwdFQyLAu3/g4ssd40NJcoo3KIo3EFZJ61BFYwbJKaub/jIgdHGDYqoLbp
	 CkKxHqxZ+lcZkLuiQ0SW3Jhlx3Q2UF/lc1lkzKluKqJLT3FIFmzOl5wuIzY8rKKn7h
	 rcNc8n7xzQhAsBwvPQXPLNwkEJiEajEWMRQOGpAKemjtGyymfK7KXS5SUzAoMHpafQ
	 UD9dEvhoDjHEA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9338e4695so68340991fa.2;
        Sat, 23 Sep 2023 15:36:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx6003vTGJetNVXAgkTYYVPsm5O353i0/nhni2wWF7WYIoBOkST
	G0c0ytrTg/9PMRl6Vn8n4baU5RCn+09TRgWJah8=
X-Google-Smtp-Source: AGHT+IHGEMyzPMP0PdtKXqSKknw0oXHfeYEIvmKQhWxGVhq9jrC3LZkcXvNIlQvBWHbanSZQKP0MnXe/fed+WldiSzw=
X-Received: by 2002:a05:6512:250d:b0:4fb:90c6:c31a with SMTP id
 be13-20020a056512250d00b004fb90c6c31amr2958776lfb.14.1695508573892; Sat, 23
 Sep 2023 15:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-3-rppt@kernel.org>
 <CAPhsuW5-=H1V=VXUYxyGnUdJuNUpRt44QmpwjkDUD=9i0itjuw@mail.gmail.com> <20230923153808.GI3303@kernel.org>
In-Reply-To: <20230923153808.GI3303@kernel.org>
From: Song Liu <song@kernel.org>
Date: Sat, 23 Sep 2023 15:36:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6TxG87ZBwQ_027iiE+_UmXweZEPh8wKHkHo7wA+qXZUg@mail.gmail.com>
Message-ID: <CAPhsuW6TxG87ZBwQ_027iiE+_UmXweZEPh8wKHkHo7wA+qXZUg@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] mm: introduce execmem_text_alloc() and execmem_free()
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nadav Amit <nadav.amit@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2023 at 8:39=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Sep 21, 2023 at 03:34:18PM -0700, Song Liu wrote:
> > On Mon, Sep 18, 2023 at 12:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org=
> wrote:
> > >
> >
> > [...]
> >
> > > diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> > > index 42215f9404af..db5561d0c233 100644
> > > --- a/arch/s390/kernel/module.c
> > > +++ b/arch/s390/kernel/module.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/moduleloader.h>
> > >  #include <linux/bug.h>
> > >  #include <linux/memory.h>
> > > +#include <linux/execmem.h>
> > >  #include <asm/alternative.h>
> > >  #include <asm/nospec-branch.h>
> > >  #include <asm/facility.h>
> > > @@ -76,7 +77,7 @@ void *module_alloc(unsigned long size)
> > >  #ifdef CONFIG_FUNCTION_TRACER
> > >  void module_arch_cleanup(struct module *mod)
> > >  {
> > > -       module_memfree(mod->arch.trampolines_start);
> > > +       execmem_free(mod->arch.trampolines_start);
> > >  }
> > >  #endif
> > >
> > > @@ -510,7 +511,7 @@ static int module_alloc_ftrace_hotpatch_trampolin=
es(struct module *me,
> > >
> > >         size =3D FTRACE_HOTPATCH_TRAMPOLINES_SIZE(s->sh_size);
> > >         numpages =3D DIV_ROUND_UP(size, PAGE_SIZE);
> > > -       start =3D module_alloc(numpages * PAGE_SIZE);
> > > +       start =3D execmem_text_alloc(EXECMEM_FTRACE, numpages * PAGE_=
SIZE);
> >
> > This should be EXECMEM_MODULE_TEXT?
>
> This is an ftrace trampoline, so I think it should be FTRACE type of
> allocation.

Yeah, I was aware of the ftrace trampoline. My point was, ftrace trampoline
doesn't seem to have any special requirements. Therefore, it is probably no=
t
necessary to have a separate type just for it.

AFAICT, kprobe, ftrace, and BPF (JIT and trampoline) can share the same
execmem_type. We may need some work for some archs, but nothing is
fundamentally different among these.

Thanks,
Song

