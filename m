Return-Path: <bpf+bounces-14390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4829E7E3A35
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 11:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F904B20D76
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A52C865;
	Tue,  7 Nov 2023 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfHMKmIU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAAFBE5;
	Tue,  7 Nov 2023 10:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF0EC433C7;
	Tue,  7 Nov 2023 10:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699353896;
	bh=6KvSSAyHzV1t/xzun1oJg0AqCmYPNZNoG1yjrk+2N5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfHMKmIUi7LClGqSTR82uTGSALdsGhooGkAQNBOKzdAx9XrKCS32CwP6rRNlINeJp
	 fTBcOh2CbrNgz5T9wN8X4IfDIz30xCLXq2htrhQAdC3JQhS9flLyk/+pf5MtKIc1uc
	 JGySGdYEdfIvLpVTQJXhgpJr9YrJTitMM+csMdn+xILBQI2oGOVjB/sYO87FSSlzde
	 FSNahA1CtFFCQyIxON1Z1I4OewRIeg1rULpA/yqisw7axPef9I0RY6dTvW/rbObEf0
	 ODLYbBKyXYy654yF6yL9+/nSFia7MKf5WBhUfT/JXvT2gH/1if2QXy5oq+hmLNVTje
	 IOMZOtUYIwdeQ==
Date: Tue, 7 Nov 2023 10:44:47 +0000
From: Will Deacon <will@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
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
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 04/13] mm/execmem, arch: convert remaining overrides
 of module_alloc to execmem
Message-ID: <20231107104446.GA19133@willie-the-truck>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-5-rppt@kernel.org>
 <20231023171420.GA4041@willie-the-truck>
 <20231026085800.GK2824@kernel.org>
 <20231026102438.GA6924@willie-the-truck>
 <20231030070053.GL2824@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030070053.GL2824@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Oct 30, 2023 at 09:00:53AM +0200, Mike Rapoport wrote:
> On Thu, Oct 26, 2023 at 11:24:39AM +0100, Will Deacon wrote:
> > On Thu, Oct 26, 2023 at 11:58:00AM +0300, Mike Rapoport wrote:
> > > On Mon, Oct 23, 2023 at 06:14:20PM +0100, Will Deacon wrote:
> > > > On Mon, Sep 18, 2023 at 10:29:46AM +0300, Mike Rapoport wrote:
> > > > > diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> > > > > index dd851297596e..cd6320de1c54 100644
> > > > > --- a/arch/arm64/kernel/module.c
> > > > > +++ b/arch/arm64/kernel/module.c
> 
> ...
> 
> > > > > -	if (module_direct_base) {
> > > > > -		p = __vmalloc_node_range(size, MODULE_ALIGN,
> > > > > -					 module_direct_base,
> > > > > -					 module_direct_base + SZ_128M,
> > > > > -					 GFP_KERNEL | __GFP_NOWARN,
> > > > > -					 PAGE_KERNEL, 0, NUMA_NO_NODE,
> > > > > -					 __builtin_return_address(0));
> > > > > -	}
> > > > > +	module_init_limits();
> > > > 
> > > > Hmm, this used to be run from subsys_initcall(), but now you're running
> > > > it _really_ early, before random_init(), so randomization of the module
> > > > space is no longer going to be very random if we don't have early entropy
> > > > from the firmware or the CPU, which is likely to be the case on most SoCs.
> > > 
> > > Well, it will be as random as KASLR. Won't that be enough?
> > 
> > I don't think that's true -- we have the 'kaslr-seed' property for KASLR,
> > but I'm not seeing anything like that for the module randomisation and I
> > also don't see why we need to set these limits so early.
> 
> x86 needs execmem initialized before ftrace_init() so I thought it would be
> best to setup execmem along with most of MM in mm_core_init().
> 
> I'll move execmem initialization for !x86 to a later point, say
> core_initcall.

Thanks, Mike.

Will

