Return-Path: <bpf+bounces-34257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3792BEF1
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C7F282D86
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA419D8B3;
	Tue,  9 Jul 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTSSEdLc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78419D072;
	Tue,  9 Jul 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540608; cv=none; b=ljQmzzwBLkG/irTT0FObMJh68QkOgLMYY9tZ2FbgqyStLJeVaFEVyVjt6MEAbSjAk3m6WbWp7SwSEXtwVLN3tiGn1Gy/PzFuc0KF8zBRJGHEzhhO1h8OsHpy24A3ux6wxHdbvgJiRjRKesovWnHF4SXGWOslWjyABJxD5CBkn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540608; c=relaxed/simple;
	bh=7QDmkH9dU/DwLIoWyMJ6ELPOYRMutG6ZVvgVUh6sV+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPc7IzhLdF0fofdnfPKXmjIcRAddtiZk7+AxNyrLAI2XQNbk2kyb5U2umsX7hTRzQ6eQL42oyBkkLpKtgSQ/fZWOxZy0kiJwqtwBALRWYLOr40KYymVkF0GbI1mbW2bl9lNzEML6KjvCQj90a2F4tELnZS3zW7l5gr3LNqdnjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTSSEdLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD9C3277B;
	Tue,  9 Jul 2024 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720540607;
	bh=7QDmkH9dU/DwLIoWyMJ6ELPOYRMutG6ZVvgVUh6sV+Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nTSSEdLcK70FpPyPZo/K52yKYgyJ/m/2ElJh2sivBjsvzu92ayHYaeVlMMsncpRD1
	 TYEOIrZ08hDZnIdvTFcdUyunZ1XYOghvF32BvYFUj+BWj3HLtqLb5TcozY+qY4VldH
	 CuoAxsBOc7bYpjHgcmDR3wCF2R+AnWzlF7H24cZf3ez3E+hbyM7msS9NOuvBRd/SwO
	 y80RWMfzy8Uo4xnwKpk1N1kMB4ZcMRNIASpp90QdpXTkh9whlXWSWGcHahFlEV/pww
	 OjAx2/G2OuTmzZ2ZqhuDYfyh84c5CxETD5REAM85hqpZcDJvKSTSJIAlYECNlme5x4
	 8dt3wK83CCkPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63B78CE0A45; Tue,  9 Jul 2024 08:56:47 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:56:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>, willy@infradead.org
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <7505621f-23ce-4b50-9e0d-84c9e7754444@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <445aed81-a845-4f5d-8b20-70eced3ce4f8@paulmck-laptop>
 <20240709153132.GR27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709153132.GR27299@noisy.programming.kicks-ass.net>

On Tue, Jul 09, 2024 at 05:31:32PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 09, 2024 at 07:36:41AM -0700, Paul E. McKenney wrote:
> 
> > > Per VMA refcounts or per VMA locks are a complete fail IMO.
> > 
> > Not even to allow concurrent updates of the address space by different
> > threads of a process?
> 
> Well, I'm sure it helps some workloads. But for others it is just moving
> the problem.

From where I sit, helping a wide range of workloads is a good thing.  ;-)

> > For me, per-VMA locking's need to RCU-protect the VMA is a good step
> > towards permitting RCU-protected scans of the Maple Tree, which then
> > gets lockless lookup.
> 
> Right, the question is if the VMA lock is required to be stable against
> splitting. If that is the case, we're hosed :/

Let's just say that VMA splitting and merging has consumed much time
and effort from the usual suspects over the past while.

> At the time I added a seqcount for that, but I'm also remembering that's
> one of the things people complained about for single threaded
> performance.

Sequence locks are lighter weight these days, but again, this has been
very much a long-term whack-a-mole exercise with odd regressions.

							Thanx, Paul

