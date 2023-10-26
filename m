Return-Path: <bpf+bounces-13303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584617D7EA9
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074921F22902
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB81CAAF;
	Thu, 26 Oct 2023 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRC27PQC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022911C9F;
	Thu, 26 Oct 2023 08:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6AFC433C8;
	Thu, 26 Oct 2023 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698309661;
	bh=CKweGyf2oPo/e/UZLG1WYH3zEQnVvPRR68BdbBl/TGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRC27PQC2plQ2QFtxeYNcapuTdKaVmbmEUR0m69y9zSqXieqEvU2U8HaibfItzWZF
	 yERD96v5VwCZUJZD6El6ZorfVxYGGBw2vENxYrzOh3JNxfzIcWV8Hyo/98RmvjYp1O
	 Ink1QwB6gOI9hZMPLodFMqMmfk4UUgDFD2PT2vR0MIfYSLtLLeyvF4ch6/DBDJ+K3Z
	 0bfW6e3KP7yJWPzCmJpvtwgF2RV+VsKMprb/vimV6IovW84by85aPvP9y1WYUJyow3
	 BUjvGbMWEhiJ9hRAr+vd5AhVyyu5+qGt0miVwVbaUWHgtUSofxp310DRt0OzuziAvf
	 CCAilLzZ675cA==
Date: Thu, 26 Oct 2023 11:40:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"deller@gmx.de" <deller@gmx.de>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"nadav.amit@gmail.com" <nadav.amit@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"puranjay12@gmail.com" <puranjay12@gmail.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"will@kernel.org" <will@kernel.org>,
	"dinguyen@kernel.org" <dinguyen@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"song@kernel.org" <song@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 03/13] mm/execmem, arch: convert simple overrides of
 module_alloc to execmem
Message-ID: <20231026084039.GJ2824@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-4-rppt@kernel.org>
 <607927885bb8ca12d4cd5787f01207c256cc8798.camel@intel.com>
 <00277a3acb36d2309156264c7e8484071bc91614.camel@intel.com>
 <20231005052622.GD3303@kernel.org>
 <b26d0a201bf631831a956450ebbccc3c16521133.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26d0a201bf631831a956450ebbccc3c16521133.camel@intel.com>

Hi Rick,

Sorry for the delay, I was a bit preoccupied with $stuff.

On Thu, Oct 05, 2023 at 06:09:07PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2023-10-05 at 08:26 +0300, Mike Rapoport wrote:
> > On Wed, Oct 04, 2023 at 03:39:26PM +0000, Edgecombe, Rick P wrote:
> > > On Tue, 2023-10-03 at 17:29 -0700, Rick Edgecombe wrote:
> > > > It seems a bit weird to copy all of this. Is it trying to be
> > > > faster
> > > > or
> > > > something?
> > > > 
> > > > Couldn't it just check r->start in execmem_text/data_alloc() path
> > > > and
> > > > switch to EXECMEM_DEFAULT if needed then? The
> > > > execmem_range_is_data()
> > > > part that comes later could be added to the logic there too. So
> > > > this
> > > > seems like unnecessary complexity to me or I don't see the
> > > > reason.
> > > 
> > > I guess this is a bad idea because if you have the full size array
> > > sitting around anyway you might as well use it and reduce the
> > > exec_mem_alloc() logic.
> > 
> > That's was the idea, indeed. :)
> > 
> > > Just looking at it from the x86 side (and
> > > similar) though, where there is actually only one execmem_range and
> > > it
> > > building this whole array with identical data and it seems weird.
> > 
> > Right, most architectures have only one range, but to support all
> > variants
> > that we have, execmem has to maintain the whole array.
> 
> What about just having an index into a smaller set of ranges. The
> module area and the extra JIT area. So ->ranges can be size 3
> (statically allocated in the arch code) for three areas and then the
> index array can be size EXECMEM_TYPE_MAX. The default 0 value of the
> indexing array will point to the default area and any special areas can
> be set in the index point to the desired range.
> 
> Looking at how it would do for x86 and arm64, it looks maybe a bit
> better to me. A little bit less code and memory usage, and a bit easier
> to trace the configuration through to the final state (IMO). What do
> you think? Very rough, on top of this series, below.

I like your suggestion to only have definitions of actual ranges in arch
code and index array to redirect allocation requests to the right range.
I'll make the next version along the lines of your patch.

> As I was playing around with this, I was also wondering why it needs
> two copies of struct execmem_params: one returned from the arch code
> and one in exec mem. 

No actual reason, one copy is enough, thanks for catching this.

> And why the temporary arch copy is ro_after_init,
> but the final execmem.c copy is not ro_after_init?

I just missed it, thanks for pointing out.
 
-- 
Sincerely yours,
Mike.

