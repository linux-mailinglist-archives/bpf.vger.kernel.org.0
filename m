Return-Path: <bpf+bounces-70509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D5BC18ED
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEADC189027B
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771282E06EF;
	Tue,  7 Oct 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgdcGkRd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9267EACD;
	Tue,  7 Oct 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844850; cv=none; b=A/dSIlxS3Ek63SS9CwQxQhylbSu+mEMYnpPJtmViQidwRwZ1tEz4ccSxYsidttqDf/Sp6hv6PTKM239iukygvTsvTfnsM7pW8gDNuTS+Zho60sUFAerQWQlu2fi225892PYkL3YWOQAthZ3xU2b55Y8ZPJCCdPu0GjBLZrQo4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844850; c=relaxed/simple;
	bh=2wEizn1o5izN1HzrY1dxD7uNG+1kNE6aE6MWZ6KYfKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV93+uo3Dsj6dbXwXoRByfsYaeOxI1L5widd8wR+2Rwq7Tp0Q6LwZWTBaOWn8mK0oaT8h1pToyJ/jImicgzaMchoU6qUs+p1UYOKpwz2/HnKYmiFf2vF+deX7cHI6IwVG76RZxOo5RHmt0ANC0BJ4JmimlBNckzWVdYI5XBCs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgdcGkRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7786CC4CEF1;
	Tue,  7 Oct 2025 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759844849;
	bh=2wEizn1o5izN1HzrY1dxD7uNG+1kNE6aE6MWZ6KYfKI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kgdcGkRdLcJfs299lC/wEmiNcvnrsNlGSHlm0JxnxkkmYUVdlwAVqS5LPNHm4G00/
	 s1f5MRwNVam5FMGmgYshalbdUpVcdrszKi2ND753BqedusYylI5F3R63lOotIt1kpX
	 XsZJf2T5VkgvuGDntO7kuq9/bQvdMIEsfXGjwO4pNBqLcayNE0tPWqQ5LrgIyd0cQ1
	 z697XJ6g9G+6PIuQA8LHxTx/XyYHo+KEjm6cebHzDXWOoV/0lONWmFq3TRDjeyqKgt
	 y2nKU6asZIkvVFJxoigNPTLFu4fEUHL/fLJtc4lKMJ0qRhfYuV66UBvzySbw52/Pi9
	 C6rt+02YytHyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 174A0CE0B20; Tue,  7 Oct 2025 06:47:29 -0700 (PDT)
Date: Tue, 7 Oct 2025 06:47:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 02/21] rcu: Re-implement RCU Tasks Trace in terms of
 SRCU-fast
Message-ID: <79baf0a4-dae2-4748-a1a8-112ce1d5fa94@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
 <20251001144832.631770-2-paulmck@kernel.org>
 <aN6eQuTbdwAAhxIj@localhost.localdomain>
 <d24f3987-48de-43e3-a841-2a116ac6d5c7@paulmck-laptop>
 <aOUDQeLtfeoBEPng@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOUDQeLtfeoBEPng@localhost.localdomain>

On Tue, Oct 07, 2025 at 02:10:41PM +0200, Frederic Weisbecker wrote:
> Le Sat, Oct 04, 2025 at 02:47:08AM -0700, Paul E. McKenney a écrit :
> > On Thu, Oct 02, 2025 at 05:46:10PM +0200, Frederic Weisbecker wrote:
> > > Le Wed, Oct 01, 2025 at 07:48:13AM -0700, Paul E. McKenney a écrit :
> > > > This commit saves more than 500 lines of RCU code by re-implementing
> > > > RCU Tasks Trace in terms of SRCU-fast.  Follow-up work will remove
> > > > more code that does not cause problems by its presence, but that is no
> > > > longer required.
> > > > 
> > > > This variant places smp_mb() in rcu_read_{,un}lock_trace(), which will
> > > > be removed on common-case architectures in a later commit.
> > > 
> > > The changelog doesn't mention what this is ordering :-)
> > 
> > "The ordering that dare not be named"?  ;-)
> > 
> > How about like this for that second paragraph?
> > 
> > 	This variant places smp_mb() in rcu_read_{,un}lock_trace(),
> > 	which will be removed on common-case architectures in a
> > 	later commit.  In the meantime, it serves to enforce ordering
> > 	between the underlying srcu_read_{,un}lock_fast() markers and
> > 	the intervening critical section, even on architectures that
> > 	permit attaching tracepoints on regions of code not watched
> > 	by RCU.  Such architectures defeat SRCU-fast's use of implicit
> > 	single-instruction, interrupts-disabled, and atomic-operation
> > 	RCU read-side critical sections, which have no effect when RCU is
> > 	not watching.  The aforementioned later commit will insert these
> > 	smp_mb() calls only on architectures that have not used noinstr to
> > 	prevent attaching tracepoints to code where RCU is not watching.
> 
> Oh I see now. So basically this forces the SRCU-slow behaviour by
> restoring the full barriers that are within SRCU-slow's srcu_read_[un]lock()
> (can we add a word about that?) for those architectures due to unwatched
> RCU sections that can escape the vigilance of the synchronize_rcu() on
> the write side.

You got it!  I will add the connection to old-school srcu_read_[un]lock()
on my next rebase.

							Thanx, Paul

> Thanks.
> 
> -- 
> Frederic Weisbecker
> SUSE Labs

