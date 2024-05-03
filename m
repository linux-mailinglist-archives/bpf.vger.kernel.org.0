Return-Path: <bpf+bounces-28514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD238BAFA6
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FE61C221FB
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F03715098B;
	Fri,  3 May 2024 15:21:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9B23CB;
	Fri,  3 May 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714749674; cv=none; b=hsjnguBj+XU7iP443zJrgghWdM0KgMsjJX5teqjlwpR5+eCoMpzKxY/ZULKe6TJ6yZ213hulu08alLOBEG9aUHw/A2y9ywfZTsa5UiDVplCi3Z543fSP2nxlbZNJ/kSZIVUNcPux450V2jYK1C4vligaimIoVjRs3W7gNxIA8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714749674; c=relaxed/simple;
	bh=LWTI4eY0g7pj4neanZ6xzewg0oYTnRWR93J8/TdC8Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiCWyV5eu16sHq0O4oA8VAFt21FtEBI+nVtVKVRbuae56deWZ6zE+on1AxkeY2Y8kLOgVowDberRBpzLbAHnSTkbPPCGk+nDg2SRrX4vhGtGNMG/VquaGoVvGWEgxp2ZKr7P73Lmf9tnR/eTmdglV1DqKaAq+98FWAoIyTl4JiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5799913D5;
	Fri,  3 May 2024 08:21:36 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.34.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D103F3F73F;
	Fri,  3 May 2024 08:21:08 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Sumit Garg <sumit.garg@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, puranjay12@gmail.com
Subject: Re: [PATCH v2 1/2] arm64/arch_timer: include <linux/percpu.h>
Message-ID: <ZjUA4vRP_kLmCF6L@FVFF77S0Q05N>
References: <20240502123449.2690-1-puranjay@kernel.org>
 <7008cd0c-5b65-4289-9015-434cbe3d7e21@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7008cd0c-5b65-4289-9015-434cbe3d7e21@arm.com>

On Fri, May 03, 2024 at 02:37:45PM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/2/24 18:04, Puranjay Mohan wrote:
> > arch_timer.h includes linux/smp.h to use DEFINE_PER_CPU() and it works
> > because smp.h includes percpu.h. The next commit will remove percpu.h
> > from smp.h and it will break this usage.
> > 
> > Explicitly include percpu.h and remove smp.h
> 
> But this particular change does not seem to be necessary for changing
> raw_smp_processor_id() as current_thread_info()->cpu being done in the
> later patch ? You might still leave header <asm/percpu.h> inclusion in
> arch/arm64/include/asm/smp.h while dropping the per cpu cpu_number ?

Why would that be preferable?

The general rule is that if a file uses something explicitly, it should include
the relevant header directly rather than something that happens to transitively
include that header.

We made a mistake and included the wrong header in commit:

  6acc71ccac7187fc ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")

... so we should fix that regardless of the next patch.

The point of the next patch is to effectively revert commit:

  57c82954e77fa12c ("arm64: make cpu number a percpu variable")

... and reverting that means we should stop including <asm/percpu.h> from
<asm/smp.h>; anything depending on that is already doing something wrong, and
leaving the include there only serves to paper over bugs.

Mark.

> 
> > 
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  arch/arm64/include/asm/arch_timer.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> > index 934c658ee947..f5794d50f51d 100644
> > --- a/arch/arm64/include/asm/arch_timer.h
> > +++ b/arch/arm64/include/asm/arch_timer.h
> > @@ -15,7 +15,7 @@
> >  #include <linux/bug.h>
> >  #include <linux/init.h>
> >  #include <linux/jump_label.h>
> > -#include <linux/smp.h>
> > +#include <linux/percpu.h>
> >  #include <linux/types.h>
> >  
> >  #include <clocksource/arm_arch_timer.h>

