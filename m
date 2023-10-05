Return-Path: <bpf+bounces-11419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8F07B9AE8
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 07:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 67EEB1C209FC
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 05:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF23F4A31;
	Thu,  5 Oct 2023 05:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbpCpY2Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4C1FA3;
	Thu,  5 Oct 2023 05:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2146C43391;
	Thu,  5 Oct 2023 05:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696483656;
	bh=hXymtCmkQgS1mz4WN4LARQgIXsgfg8oCoZqTgfgSt/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbpCpY2Q0zEwY41GucwBsBZTdMge6AGCY7bXU/clMyyCXKJTV0EDLKXZQhP6Gmvyb
	 i7tzzZViGYUX1/BLXHrp9MgUNcssHkKZ+E07sMIo2XQd9Xhgj8wBFQLGyOjD2kEs17
	 PxOhx0u+oKdQ8lrzOhlumXDQrrVIpZHitXF+j0a79GixClpVIz2eZl61qc1UDcG73I
	 FDMmfOiG2H8IzEuKKw/M7PogaSgM8X2WZc5kjl+Dp1+hjjwCugO78vBqHSBJRgrtI8
	 iiiR0aNTydrnms7VNPMV5M6X+tEx0k+2XJsejW9H5dww52kR9ESsW7JTvRKWQR81qv
	 y9fkPnEwbon1w==
Date: Thu, 5 Oct 2023 08:26:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"deller@gmx.de" <deller@gmx.de>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"nadav.amit@gmail.com" <nadav.amit@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"puranjay12@gmail.com" <puranjay12@gmail.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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
Message-ID: <20231005052622.GD3303@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-4-rppt@kernel.org>
 <607927885bb8ca12d4cd5787f01207c256cc8798.camel@intel.com>
 <00277a3acb36d2309156264c7e8484071bc91614.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00277a3acb36d2309156264c7e8484071bc91614.camel@intel.com>

On Wed, Oct 04, 2023 at 03:39:26PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-10-03 at 17:29 -0700, Rick Edgecombe wrote:
> > It seems a bit weird to copy all of this. Is it trying to be faster
> > or
> > something?
> > 
> > Couldn't it just check r->start in execmem_text/data_alloc() path and
> > switch to EXECMEM_DEFAULT if needed then? The execmem_range_is_data()
> > part that comes later could be added to the logic there too. So this
> > seems like unnecessary complexity to me or I don't see the reason.
> 
> I guess this is a bad idea because if you have the full size array
> sitting around anyway you might as well use it and reduce the
> exec_mem_alloc() logic.

That's was the idea, indeed. :)

> Just looking at it from the x86 side (and
> similar) though, where there is actually only one execmem_range and it
> building this whole array with identical data and it seems weird.

Right, most architectures have only one range, but to support all variants
that we have, execmem has to maintain the whole array.

-- 
Sincerely yours,
Mike.

