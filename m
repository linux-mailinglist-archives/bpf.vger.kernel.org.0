Return-Path: <bpf+bounces-10695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C92F7AC3A3
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 18:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 253E1281E06
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B13208C2;
	Sat, 23 Sep 2023 16:26:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F91F163;
	Sat, 23 Sep 2023 16:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE71FC433C7;
	Sat, 23 Sep 2023 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695486404;
	bh=2piJOAc4UtCWCg8jsg4cD2ZIAtKbobPaZdza3lM1trU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1TXhCaOUKwD4i9ywBsaA7fqhllTiUUEop2bqUBzfEeLiBK0GMJal6TZCH02gcByL
	 753jvJ06wYTsHa9bNjwSyI/D53kLiYdlB1AiITQEZl13j1+ufZspu8eHeVKiSfnDPa
	 Xnzc94p2Es7bJABHatU5GnvCNtXzBwLW/ClIG+R90OCKZCTnz4sBwhPKehiv0ITJJM
	 +UjHKGlf0w5d8TT9nGbQtF1BeBR/tDz6eSth+IHkKyRVTlF1gKubvNuOjqYZN8sC6v
	 yInZcSWBoyftCQIH5y4EX0l+ogMUchapNByEIoCoBWaItl9SpqS6bxW8Fm8jrgT5Hv
	 hjgDbZyqE8rAA==
Date: Sat, 23 Sep 2023 19:25:47 +0300
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
Subject: Re: [PATCH v3 09/13] powerpc: extend execmem_params for kprobes
 allocations
Message-ID: <20230923162547.GN3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-10-rppt@kernel.org>
 <CAPhsuW5Vg7yDn8zb5ez4JY4efoQ6aW+vYm9OL+Xr0NJnLfMYHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5Vg7yDn8zb5ez4JY4efoQ6aW+vYm9OL+Xr0NJnLfMYHg@mail.gmail.com>

On Thu, Sep 21, 2023 at 03:30:46PM -0700, Song Liu wrote:
> On Mon, Sep 18, 2023 at 12:31 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> [...]
> > @@ -135,5 +138,13 @@ struct execmem_params __init *execmem_arch_params(void)
> >
> >         range->pgprot = prot;
> >
> > +       execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
> > +       execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_END;
> 
> .end = VMALLOC_END.

Thanks, this should have been

	execmem_params.ranges[EXECMEM_KPROBES].start = range->start;
	execmem_params.ranges[EXECMEM_KPROBES].end = range->end;

where range points to the same range as EXECMEM_MODULE_TEXT.

 
> Thanks,
> Song
> 
> > +
> > +       if (strict_module_rwx_enabled())
> > +               execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
> > +       else
> > +               execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
> > +
> >         return &execmem_params;
> >  }
> > --
> > 2.39.2
> >
> >

-- 
Sincerely yours,
Mike.

