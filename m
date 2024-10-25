Return-Path: <bpf+bounces-43194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC37C9B1329
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 01:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637961F2271F
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD6213134;
	Fri, 25 Oct 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqXBL4z2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B31CEE98;
	Fri, 25 Oct 2024 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729898811; cv=none; b=GR1lxRLMAIOu/mHX1gtgSmhTvyRIwspS+MuAvUj9I7lGkdfwSBCeLq3AtGYqJFgZe179k2bMhZDYKeR8Qv/0A/XnLoxmUHTqCgUlo6L/l8f/07xlfCo7zLnCOvpK7+nvE9VVvRtS3wbx/0VWQJBl15gIEA6WVlfCSoEPCp4ZNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729898811; c=relaxed/simple;
	bh=ZmrVA8wb7NNzPZG85RE1GMlbP3IKNvdOBUIXaz8g1HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbLvhL+KtkbUKrremdcmwiAJlRrCULQ35jrolax3YH9g8baOnS3qg0BcQi1YKVXyor9gV4p6FaUR31IGNZS7O7WntCgKB1o89t1rvnvmBVaDU2uz+RJnOkaXcLdy3pN455BvAihpnz894X7IvQd4evV9hBJ5t+uMu48i0bHbjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqXBL4z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2BFC4CEC3;
	Fri, 25 Oct 2024 23:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729898810;
	bh=ZmrVA8wb7NNzPZG85RE1GMlbP3IKNvdOBUIXaz8g1HI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JqXBL4z21li0sULGs3yYDYnWwEZ98djkKCnN6pdC9o+4A3DZyXPEr3crCWCNjWjyv
	 50y0/lADjWEIXXOU6KTp9BKOIvIkQVti2huhiC0kkpwtIK6puJox8bAxJtsHUFfiHo
	 dzXkk/RdqciQaU8HjtpkXFvKKifY8cJ+9hfbpPJ3gARIXAsk1ujAYph04IMcGsfVGL
	 LENHC0LOF8iQithnXjwK8QZPXHZOWDd2QqxaOvGBOQ2R2jsPFvJ8/eUb8m97ZFUWRf
	 87WlTEPBaRmvDFNVxweREI9u5HlY/v22IG9JVdy89b8cYquUk+Ercz4sEvfYjXwmMx
	 Z28ee17neMk5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2C00FCE0D99; Fri, 25 Oct 2024 16:26:49 -0700 (PDT)
Date: Fri, 25 Oct 2024 16:26:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, puranjay@kernel.org,
	bpf@vger.kernel.org, lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <43ecbb1e-7710-45ab-891e-575b6f562794@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zxk2wNs4sxEIg-4d@andrea>
 <daa60273-d01a-8fc5-5e26-e8fc9364c1d8@huaweicloud.com>
 <ZxuZ-wGccb3yhBAD@andrea>
 <d8aa61a8-e2fc-7668-9845-81664c9d181f@huaweicloud.com>
 <ZxugzP0yB3zeqKSn@andrea>
 <8360f999-0d64-3b4f-e4b8-8c84f7311af2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8360f999-0d64-3b4f-e4b8-8c84f7311af2@huaweicloud.com>

On Fri, Oct 25, 2024 at 03:57:29PM +0200, Hernan Ponce de Leon wrote:
> On 10/25/2024 3:44 PM, Andrea Parri wrote:
> > On Fri, Oct 25, 2024 at 03:28:17PM +0200, Hernan Ponce de Leon wrote:
> > > On 10/25/2024 3:15 PM, Andrea Parri wrote:
> > > > > > BPF R+release+fence
> > > > > > {
> > > > > >     0:r2=x; 0:r4=y;
> > > > > >     1:r2=y; 1:r4=x; 1:r6=l;
> > > > > > }
> > > > > >     P0                                 | P1                                         ;
> > > > > >     r1 = 1                             | r1 = 2                                     ;
> > > > > >     *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
> > > > > >     r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
> > > > > >     store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
> > > > > > exists ([y]=2 /\ 1:r3=0)
> > > > > > 
> > > > > > This "exists" condition is not satisfiable according to the BPF model;
> > > > > > however, if we adopt the "natural"/intended(?) PowerPC implementations
> > > > > > of the synchronization primitives above (aka, with store_release() -->
> > > > > > LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
> > > > > > condition in question becomes (architecturally) satisfiable on PowerPC
> > > > > > (although I'm not aware of actual observations on PowerPC hardware).
> > > > > 
> > > > > Are the resulting PPC tests available somewhere?
> > > > 
> > > > My data go back to the LKMM paper, cf. e.g. the R+pooncerelease+fencembonceonce
> > > > entry at https://diy.inria.fr/linux/hard.html#unseen .
> > > > 
> > > >     Andrea
> > > 
> > > I guess I understood you wrong. I thought you had manually "compiled" those
> > > to PPC litmus format (i.e., doing exactly what the JIT compiler would do). I
> > > can obviously write them manually myself, but I find this painful and error
> > > prone (I am particularly bad at this task), so I wanted to avoid this if
> > > someone else had already done it.
> > 
> > FWIW, a comprehensive collection of PPC litmus tests could be found at
> > 
> >    https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/ppc002.html
> > 
> > (just follow the link on the test pattern/variants to see the sources);
> > be aware the results of those tables date back to the PPC paper though.
> > 
> > Alternatively, remind that PPC is well supported by the herdtools7 diy7
> > generator; I see no reason for having to (re)write such tests manually.
> > 
> >    Andrea
> 
> I am particularly interested in tests using lwarx and stwcx instructions
> (this is what I understood would be used if one follows [1] to compile the
> tests in this thread).
> 
> I have not yet check the cambridge website, but due to the timeline, I don't
> expect to find tests with those instructions. The same is true with [2].
> 
> I have limited experience with diy7, but I remember that it had some
> limitations to generate RMW instructions, at least for C [3].
> 
> Hernan
> 
> [1] https://github.com/torvalds/linux/blob/master/arch/powerpc/net/bpf_jit_comp32.c
> [2] https://github.com/herd/herdtools7/tree/master/catalogue/herding-cats/ppc/tests/campaign
> [3] https://github.com/herd/herdtools7/issues/905

Please see attached for a tarball of random PPC litmus tests.

You asked for this!  ;-)

							Thanx, Paul


