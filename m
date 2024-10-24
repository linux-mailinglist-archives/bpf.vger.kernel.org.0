Return-Path: <bpf+bounces-43043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B15A9AE37F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30BEB216EA
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92F176AAD;
	Thu, 24 Oct 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9VeDnPQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677781C761C;
	Thu, 24 Oct 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768448; cv=none; b=QV54qFFmLeac12O/G0TvR5KFncRJlhoI6I+uHO1ccqP52ZNOVz4Tggow7xpNqptXhdHSv9LB0tGG0tuYSwtvUCWD64yre0AXj7E+i03HY5LRSzPOcfEa75aGIenrHI8id3aY2yeVuJyYwXUnsGJVYaIPXiV3mUkmLn0gJe1cUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768448; c=relaxed/simple;
	bh=lony7HcHEUlOAmxn07kOoTMbSPJMvn/r3Jso+FxlXPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adkblNHq+swKME2B5Zw3TlmSDmY/66b88vQxMtAzYnEBY7kbw1pbTQ6vwjVNsG+Y29UPDVrG3IPZplKRltWJiQyQAFnltxd7l421bFE2i8vH3MqfXOtq+YNnU4lrAsPzPh0S3R40Aa7+Cs2Rv6EcPXBN8KYzmBgqbQ+52SPr8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9VeDnPQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so98289066b.3;
        Thu, 24 Oct 2024 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729768445; x=1730373245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqToYBI47uumi/dFF+fWrS/U9utWn5J0Y7eTU5Cm8IA=;
        b=B9VeDnPQrAh5F6SlcwC6rW7yLyE5gX0OU4QJNkJImzH0Jh41n6C0nhSACS4hp/M9qz
         1FiRSRyVc08MDv3/xNAyJbtlSKcj7aQjDfzzlFLJjZoB+BEuXg4+bkwRUMvvlVqtekjl
         iHC2JwR6mC+Nk4TR7TOV7NjuemkawvisP1tYcUhHeLcxmPwB11OUwswl+W0bFBkzUFcc
         IE6wJO4MVbAtP8ZvloBl9fHNVbeOMWMbjOhMtx16M9kqgTgjuQOPcjEaZUXcxZ4stO89
         jH/2pEVmuy4tEOh9RPRf5dnZ7XAxGWVesSbJv3wd7cBmQBMt3o9SxxOQW8u8X+FpedPM
         9NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729768445; x=1730373245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqToYBI47uumi/dFF+fWrS/U9utWn5J0Y7eTU5Cm8IA=;
        b=XY9yIXWnC0JfAqF3Ue3w6vgwRQllaUp6mVrD45vb4uhlzQVRVVZROJjTdwByB58ek8
         LGtuCgnJX0bL45vz16JdCGQ2t0mtTCJ8RXlatvpaYaDbQuB/V6gc+5WqhsVm53HXA1h7
         MD4qJUY+WhlpYqbQuyjFY/yqljudZMeCRZdV2Th49vP2XAysvfmOuWPAgFqK8sEXPur2
         O7p0H+Jk+PFM7UHtpx/mgeKnjxLBLrotIZxR2cvdDYr4Qu/sLCniJg897dpFMOOQWY6W
         l54a8RmpLWx9z7xV9XsJytB5GBDIT9Ge5BXQnYq1iSvkGCIt5tdk0dWG35Ky7Gvttpeb
         4CuA==
X-Forwarded-Encrypted: i=1; AJvYcCWVEbrWnZds8iwivVOkhwJsc/NqdySpvqGvtRHav/3rG8MMShhPLlMEgXKn8Sg/bZmeiQY=@vger.kernel.org, AJvYcCWdLqAh1AnRm+t0IzA5F0xsjrja8sUaA6NoOLuxvIV/+D6lCtTWEF8/JU8VvibnaLpAJVCSz9rggc8nA9v3@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvwMUxNtK418v6UQbijF35/LwPsbBqw31YrFd8A21ZQOOt6EY
	QIQSmr7nnImeThHhvTkCrT6BdQZAoV/GjKEQEFYu5DXxYAslHq8VapB+EhGICFw=
X-Google-Smtp-Source: AGHT+IGCTDa5YSt1JVXSw15FKX85vMm/LPJHRhKpKlIjG4hjhIJxxYz0pGcyAADkEomx7uRX1roMOQ==
X-Received: by 2002:a17:907:9624:b0:a99:4f40:3e82 with SMTP id a640c23a62f3a-a9abf84cf8cmr609473766b.7.1729768444371;
        Thu, 24 Oct 2024 04:14:04 -0700 (PDT)
Received: from andrea ([2a01:5a8:300:22d3:899d:b864:b090:8064])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91573645sm595674966b.182.2024.10.24.04.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:14:04 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:13:55 +0300
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: puranjay@kernel.org, bpf@vger.kernel.org, lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <Zxor8xosL-XSxnwr@andrea>
References: <Zxk2wNs4sxEIg-4d@andrea>
 <13f60db0-b334-4638-a768-d828ecf7c8d0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f60db0-b334-4638-a768-d828ecf7c8d0@paulmck-laptop>

On Wed, Oct 23, 2024 at 09:25:40PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 23, 2024 at 08:47:44PM +0300, Andrea Parri wrote:
> > Hi Puranjay and Paul,
> > 
> > I'm running some experiment on the (experimental) formalization of BPF
> > acquire and release available from [1] and wanted to report about some
> > (initial) observations for discussion and possibly future developments;
> > apologies in advance for the relatively long email and any repetition.
> > 
> > 
> > A first and probably most important observation is that the (current)
> > formalization of acquire and release appears to be "too strong": IIUC,
> > the simplest example/illustration for this is given by the following
> > 
> > BPF R+release+fence
> > {
> >  0:r2=x; 0:r4=y;
> >  1:r2=y; 1:r4=x; 1:r6=l;
> > }
> >  P0                                 | P1                                         ;
> >  r1 = 1                             | r1 = 2                                     ;
> >  *(u32 *)(r2 + 0) = r1              | *(u32 *)(r2 + 0) = r1                      ;
> >  r3 = 1                             | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) ;
> >  store_release((u32 *)(r4 + 0), r3) | r3 = *(u32 *)(r4 + 0)                      ;
> > exists ([y]=2 /\ 1:r3=0)
> > 
> > This "exists" condition is not satisfiable according to the BPF model;
> > however, if we adopt the "natural"/intended(?) PowerPC implementations
> > of the synchronization primitives above (aka, with store_release() -->
> > LWSYNC and atomic_fetch_add() --> SYNC ; [...] ), then we see that the
> > condition in question becomes (architecturally) satisfiable on PowerPC
> > (although I'm not aware of actual observations on PowerPC hardware).
> 
> Yes, you are quite right, for efficient use on PowerPC, we need the BPF
> memory model to allow the above cycle in the R litmus test.  My bad,
> as I put too much emphasis on ARM64.
> 
> > At first, the previous observation (validated via simulations and later
> > extended to similar but more complex scenarios ) made me believe that
> > the BPF formalization of acquire and release could be strictly stronger
> > than the corresponding LKMM formalization; but that is _not_ the case:
> > 
> > The following "exists" condition is satisfiable according to the BPF
> > model (and it remains satisfiable even if the load_acquire() in P2 is
> > paired with an additional store_release() in P1).  In contrast, the
> > corresponding LKMM condition (e.g load_acquire() --> smp_load_acquire()
> > and atomic_fetch_add() --> smp_mb()) is not satisfiable (in fact, the
> > same conclusion holds even if the putative smp_load_acquire() in P2 is
> > "replaced" with an smp_rmb() or with an address dependency).
> > 
> > BPF Z6.3+fence+fence+acquire
> > {
> >  0:r2=x; 0:r4=y; 0:r6=l;
> >  1:r2=y; 1:r4=z; 1:r6=m;
> >  2:r2=z; 2:r4=x;
> > }
> >  P0                                         | P1                                         | P2                                 ;
> >  r1 = 1                                     | r1 = 2                                     | r1 = load_acquire((u32 *)(r2 + 0)) ;
> >  *(u32 *)(r2 + 0) = r1                      | *(u32 *)(r2 + 0) = r1                      | r3 = *(u32 *)(r4 + 0)              ;
> >  r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) | r5 = atomic_fetch_add((u32 *)(r6 + 0), r5) |                                    ;
> >  r3 = 1                                     | r3 = 1                                     |                                    ;
> >  *(u32 *)(r4 + 0) = r3                      | *(u32 *)(r4 + 0) = r3                      |                                    ;
> > exists ([y]=2 /\ 2:r1=1 /\ 2:r3=0)
> 
> And again agreed, we do want to forbid Z6.3.
> 
> > These remarks show that the proposed BPF formalization of acquire and
> > release somehow, but substantially, diverged from the corresponding
> > LKMM formalization.  My guess is that the divergences mentioned above
> > were not (fully) intentional, or I'm wondering -- why not follow the
> > latter (the LKMM's) more closely? -  This is probably the first question
> > I would need to clarify before trying/suggesting modifications to the
> > present formalizations.  ;-)  Thoughts?
> 
> Thank you for digging into this!
> 
> I clearly need to get my validation work going again, but I very much
> welcome any further help you would be willing to provide.

Thanks for the confirmation.

The BPF tests above (and other I have) were all hand-written, but I'm
working towards improving such automation/validation; I won't keep it
a secret should I find something relevant/interesting.  :-)

But the subset of the LKMM which deals with "strong fences" and Acq &
Rel (limited to so called marked accesses) seems relatively contained
/simple:  its analysis could be useful, if not determining, in trying
to resolve the above issues.

  Andrea

