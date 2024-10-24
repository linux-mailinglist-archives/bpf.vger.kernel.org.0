Return-Path: <bpf+bounces-43008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4E9ADADA
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C710F1C21AEB
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3FF16D9B8;
	Thu, 24 Oct 2024 04:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLJvND4l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983222EED;
	Thu, 24 Oct 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729743941; cv=none; b=KRe+mhyxk92Qw5JKu1y1m/03mBafPy7QRVH2C/jmpD700zttiDh7nhtRCJ9r1TgCRGl1ucYrvgXILCdvJbrnNkdF81U8Yr7qMWGhS/0I9PNZ2w0Plltr4HAWmx0iLVZzThETxo+25hnQHpuuygEOtcAJ+eheMWeYAjwzxO6Qxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729743941; c=relaxed/simple;
	bh=0MM5LDYxFthhIc4WNzguyAyibX+ea7PYax8n2zwG03A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy4gCdJZg+emIk8vcBEQPWx61fCFhbZ4T7k/5OPhbLl+2SK0bJiNmoXiLpyvNTAORivsjEUix2oNm56w30w+KRudi80Eqq5KrrOr3n3TX0tUhbfl1GHLkEuePh+W68iwtmZQ+T/FzW0pfFa6ASd/FMgOS5Jxy3llEZPt8o46Icw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLJvND4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C25FC4CEC7;
	Thu, 24 Oct 2024 04:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729743941;
	bh=0MM5LDYxFthhIc4WNzguyAyibX+ea7PYax8n2zwG03A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BLJvND4l4EDGi/kP16ESgcNC5YJM6uFvQ4ATrsrWM/EHzNcxNyQ0eUfpkNaWLAe4L
	 vC1IyZR3yNOt7GDoOrdoNPfDxpNDqaI9gFvZ/B+zRPrmLMYrk4WWd0fWdXngrxs0Hy
	 rYJ16PEED3qBna5C57LgqnLJXhI/0QgApK+XG3eXxfIChIlXjNDGCijA/5Yb3OifjP
	 79sj3s1pZoBHlY7vsB7rtEofzFvrCOU5xxb1vWRmgONP2Q+9KT0rjqk5hQHDe6mK6M
	 UrSUz7HvMQP0rsEDONyG07klOQkmevePOvppln6eNpVx2qDZf3B4lL/TkZEPUozRJ7
	 rxkadJJZJfn9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8813CE0BB1; Wed, 23 Oct 2024 21:25:40 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:25:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: puranjay@kernel.org, bpf@vger.kernel.org, lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <13f60db0-b334-4638-a768-d828ecf7c8d0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zxk2wNs4sxEIg-4d@andrea>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxk2wNs4sxEIg-4d@andrea>

On Wed, Oct 23, 2024 at 08:47:44PM +0300, Andrea Parri wrote:
> Hi Puranjay and Paul,
> 
> I'm running some experiment on the (experimental) formalization of BPF
> acquire and release available from [1] and wanted to report about some
> (initial) observations for discussion and possibly future developments;
> apologies in advance for the relatively long email and any repetition.
> 
> 
> A first and probably most important observation is that the (current)
> formalization of acquire and release appears to be "too strong": IIUC,
> the simplest example/illustration for this is given by the following
> 
> BPF R+release+fence
> {
>  0:r2=x; 0:r4=y;
>  1:r2=y; 1:r4=x; 1:r6=l;
> }
>  P0                                 | P1                                         ;
>  r1 = 1                             | r1 = 2                                     ;
>  *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
>  r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
>  store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
> exists ([y]=2 /\ 1:r3=0)
> 
> This "exists" condition is not satisfiable according to the BPF model;
> however, if we adopt the "natural"/intended(?) PowerPC implementations
> of the synchronization primitives above (aka, with store_release() -->
> LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
> condition in question becomes (architecturally) satisfiable on PowerPC
> (although I'm not aware of actual observations on PowerPC hardware).

Yes, you are quite right, for efficient use on PowerPC, we need the BPF
memory model to allow the above cycle in the R litmus test.  My bad,
as I put too much emphasis on ARM64.

> At first, the previous observation (validated via simulations and later
> extended to similar but more complex scenarios ) made me believe that
> the BPF formalization of acquire and release could be strictly stronger
> than the corresponding LKMM formalization; but that is _not_ the case:
> 
> The following "exists" condition is satisfiable according to the BPF
> model (and it remains satisfiable even if the load_acquire() in P2 is
> paired with an additional store_release() in P1).  In contrast, the
> corresponding LKMM condition (e.g load_acquire() --> smp_load_acquire()
> and atomic_fetch_add() --> smp_mb()) is not satisfiable (in fact, the
> same conclusion holds even if the putative smp_load_acquire() in P2 is
> "replaced" with an smp_rmb() or with an address dependency).
> 
> BPF Z6.3+fence+fence+acquire
> {
>  0:r2=x; 0:r4=y; 0:r6=l;
>  1:r2=y; 1:r4=z; 1:r6=m;
>  2:r2=z; 2:r4=x;
> }
>  P0                                         | P1                                         | P2                                 ;
>  r1 = 1                                     | r1 = 2                                     | r1 = load_acquire((u32 *)(r2 + 0)) ;
>  *(u32 *)(r2 + 0) = r1                      | *(u32 *)(r2 + 0) = r1                      | r3 = *(u32 *)(r4 + 0)              ;
>  r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) |                                    ;
>  r3 = 1                                     | r3 = 1                                     |                                    ;
>  *(u32 *)(r4 + 0) = r3                      | *(u32 *)(r4 + 0) = r3                      |                                    ;
> exists ([y]=2 /\ 2:r1=1 /\ 2:r3=0)

And again agreed, we do want to forbid Z6.3.

> These remarks show that the proposed BPF formalization of acquire and
> release somehow, but substantially, diverged from the corresponding
> LKMM formalization.  My guess is that the divergences mentioned above
> were not (fully) intentional, or I'm wondering -- why not follow the
> latter (the LKMM's) more closely? -  This is probably the first question
> I would need to clarify before trying/suggesting modifications to the
> present formalizations.  ;-)  Thoughts?

Thank you for digging into this!

I clearly need to get my validation work going again, but I very much
welcome any further help you would be willing to provide.

							Thanx, Paul

>   Andrea
> 
> 
> [1] https://github.com/puranjaymohan/herdtools7/commits/bpf_acquire_release/

