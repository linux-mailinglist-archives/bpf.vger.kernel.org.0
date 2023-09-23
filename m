Return-Path: <bpf+bounces-10693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7867AC38C
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 18:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id D0E411F23C43
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99FD208B3;
	Sat, 23 Sep 2023 16:21:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205631E51C;
	Sat, 23 Sep 2023 16:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13699C433C7;
	Sat, 23 Sep 2023 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695486112;
	bh=epTBeih4MHoaHBpc48qML+P/ARMeb7d09SNlM/hQxw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofaXj1oNTs/VBLYlvMmVzGA3HsxAlJskkj7XrUmUTDzx/0RPqgkm91Z7JgVfNThA+
	 jF51Gkq+/u8f3Pl9hK1BmDVAsawYyQVDaZs6NfxlIM+VHJDmPuMKHs1TOy64LPBIRA
	 iuS6IcsT1zTuxev9K6pIMvYP5Qodr6WpU9hqxXwD4ixmanyA2+kLliocF453RBJkLn
	 2TOewMq1E/GW1XYu4R2CCfYUfUpS+zAxWOefS4IClhNx863WjbFLsgwwYry2hXBCvO
	 tH3ho75+Hir/pB3LPn6CIdrcMEvj+m5czuQ0yH+wcE6dXhoEdwLJTXJ/XABJAw1gmy
	 81I0fO8rK/6Jg==
Date: Sat, 23 Sep 2023 19:20:55 +0300
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
Subject: Re: [PATCH v3 06/13] mm/execmem: introduce execmem_data_alloc()
Message-ID: <20230923162055.GL3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-7-rppt@kernel.org>
 <CAPhsuW73NMvdpmyrhGouQSAHEL9wRw_A+8dZ-5R4BU=UHH83cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW73NMvdpmyrhGouQSAHEL9wRw_A+8dZ-5R4BU=UHH83cw@mail.gmail.com>

On Thu, Sep 21, 2023 at 03:52:21PM -0700, Song Liu wrote:
> On Mon, Sep 18, 2023 at 12:31 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> [...]
> > diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> > index 519bdfdca595..09d45ac786e9 100644
> > --- a/include/linux/execmem.h
> > +++ b/include/linux/execmem.h
> > @@ -29,6 +29,7 @@
> >   * @EXECMEM_KPROBES: parameters for kprobes
> >   * @EXECMEM_FTRACE: parameters for ftrace
> >   * @EXECMEM_BPF: parameters for BPF
> > + * @EXECMEM_MODULE_DATA: parameters for module data sections
> >   * @EXECMEM_TYPE_MAX:
> >   */
> >  enum execmem_type {
> > @@ -37,6 +38,7 @@ enum execmem_type {
> >         EXECMEM_KPROBES,
> >         EXECMEM_FTRACE,
> 
> In longer term, I think we can improve the JITed code and merge
> kprobe/ftrace/bpf. to use the same ranges. Also, do we need special
> setting for FTRACE? If not, let's just remove it.

I don't think we need to limit how the JITed code is generated because we
want to support fewer address space ranges for it. 

As for FTRACE, now it's only needed on x86 and s390 and there it happens
to use the same ranges as MODULES and the rest, but it still gives some
notion of potential semantic differences and the overhead of keeping it is
really negligible.
 
> >         EXECMEM_BPF,
> > +       EXECMEM_MODULE_DATA,
> >         EXECMEM_TYPE_MAX,
> >  };
> 
> Overall, it is great that kprobe/ftrace/bpf no longer depend on modules.
> 
> OTOH, I think we should merge execmem_type and existing mod_mem_type.
> Otherwise, we still need to handle page permissions in multiple places.
> What is our plan for that?

Maybe, but I think this is too early. There are several things missing
before we could remove set_memory usage from modules. E.g. to use ROX
allocations on x86 we at least should update alternatives handling and
reach a consensus about synchronization Andy mentioned in his comments to
v2.
 
> Thanks,
> Song
> 
> 
> >
> > @@ -107,6 +109,23 @@ struct execmem_params *execmem_arch_params(void);
> >   */
> >  void *execmem_text_alloc(enum execmem_type type, size_t size);
> >
> > +/**
> > + * execmem_data_alloc - allocate memory for data coupled to code
> > + * @type: type of the allocation
> > + * @size: how many bytes of memory are required
> > + *
> > + * Allocates memory that will contain data coupled with executable code,
> > + * like data sections in kernel modules.
> > + *
> > + * The memory will have protections defined by architecture.
> > + *
> > + * The allocated memory will reside in an area that does not impose
> > + * restrictions on the addressing modes.
> > + *
> > + * Return: a pointer to the allocated memory or %NULL
> > + */
> > +void *execmem_data_alloc(enum execmem_type type, size_t size);
> > +
> >  /**
> >   * execmem_free - free executable memory
> >   * @ptr: pointer to the memory that should be freed
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index c4146bfcd0a7..2ae83a6abf66 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -1188,25 +1188,16 @@ void __weak module_arch_freeing_init(struct module *mod)
> >  {
> >  }
> >
> > -static bool mod_mem_use_vmalloc(enum mod_mem_type type)
> > -{
> > -       return IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC) &&
> > -               mod_mem_type_is_core_data(type);
> > -}
> > -
> >  static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
> >  {
> > -       if (mod_mem_use_vmalloc(type))
> > -               return vzalloc(size);
> > +       if (mod_mem_type_is_data(type))
> > +               return execmem_data_alloc(EXECMEM_MODULE_DATA, size);
> >         return execmem_text_alloc(EXECMEM_MODULE_TEXT, size);
> >  }
> >
> >  static void module_memory_free(void *ptr, enum mod_mem_type type)
> >  {
> > -       if (mod_mem_use_vmalloc(type))
> > -               vfree(ptr);
> > -       else
> > -               execmem_free(ptr);
> > +       execmem_free(ptr);
> >  }
> >
> >  static void free_mod_mem(struct module *mod)
> > diff --git a/mm/execmem.c b/mm/execmem.c
> > index abcbd07e05ac..aeff85261360 100644
> > --- a/mm/execmem.c
> > +++ b/mm/execmem.c
> > @@ -53,11 +53,23 @@ static void *execmem_alloc(size_t size, struct execmem_range *range)
> >         return kasan_reset_tag(p);
> >  }
> >
> > +static inline bool execmem_range_is_data(enum execmem_type type)
> > +{
> > +       return type == EXECMEM_MODULE_DATA;
> > +}
> > +
> >  void *execmem_text_alloc(enum execmem_type type, size_t size)
> >  {
> >         return execmem_alloc(size, &execmem_params.ranges[type]);
> >  }
> >
> > +void *execmem_data_alloc(enum execmem_type type, size_t size)
> > +{
> > +       WARN_ON_ONCE(!execmem_range_is_data(type));
> > +
> > +       return execmem_alloc(size, &execmem_params.ranges[type]);
> > +}
> > +
> >  void execmem_free(void *ptr)
> >  {
> >         /*
> > @@ -93,7 +105,10 @@ static void execmem_init_missing(struct execmem_params *p)
> >                 struct execmem_range *r = &p->ranges[i];
> >
> >                 if (!r->start) {
> > -                       r->pgprot = default_range->pgprot;
> > +                       if (execmem_range_is_data(i))
> > +                               r->pgprot = PAGE_KERNEL;
> > +                       else
> > +                               r->pgprot = default_range->pgprot;
> >                         r->alignment = default_range->alignment;
> >                         r->start = default_range->start;
> >                         r->end = default_range->end;
> > --
> > 2.39.2
> >

-- 
Sincerely yours,
Mike.

