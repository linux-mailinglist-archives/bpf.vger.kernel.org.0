Return-Path: <bpf+bounces-61036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA419ADFF21
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642AC3AC776
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CD823BCF2;
	Thu, 19 Jun 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHL1ioCg"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0D21D3C5;
	Thu, 19 Jun 2025 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319473; cv=none; b=SoVyz6SQsKGKLVjJJkDzi+VDfE4YM+Ec2ObUDr0PWSJ031IUVV0ro6DQbzlmVyd/0BOeiIz++9r+Z508hfUO9iwZU5NsdAYWtmyP/93bpJK5VeJ3ofE1HlhzSdv4ctI7kd0AxBRA2de9wbM2W9giuqMB9XISx64nolBavlZfJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319473; c=relaxed/simple;
	bh=irOtMSTe18Nj09WUURiqFn7bJc2qntAyYH0FgwppccE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foS4jk1cFkQMECCfDha3Q17usvFHcl60av0y8bBcOMouTsKDTJVNvmLp6JW8cwmiWopgRuzOH0JVx8YLCclxupVXnjk8RgxDLQZPCbF7s7uLUngEVprOc9pcgUUJb6h5gvB1KU9XYO7OBZc36ceNklsyRMVrHCPhcg/QwCkJjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hHL1ioCg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h6iVXO5KbYXdSc5S3Hf3L8++PkcBN/CgVnLY1g8EcyI=; b=hHL1ioCgzjArqd4YP/LoPeLWB0
	yTxZ5UB/w3Jlv19XgSk0QS3Z7n0UVw0RsfAzzvTSBSpxGXupcNaKq/Eb7hd9T03xFmCQOSpzzhxTY
	gph+gB/bxs1pgeW9Yz21aW0m18KHRzJC/iZTvG+ht9a9GRJID3zWpCx44RAP4Pz6YlmvJ/+G7UGsD
	ErSH+pEE2SvJ+2BZFcc6F4XSef1uZ/CkmexP3l3Z83deYVNf4cNiGmn3EwC7rZoXMshBsJEBHsko+
	Je4wG5QwBLey/EVpqBJO41rgDcC1kUx5Tf385J+YJcKmURlQSFBhPwDPrGuyoFiRVA/pwEJ7i7djE
	3gLQ8jFQ==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSA36-00000004NLc-2jLK;
	Thu, 19 Jun 2025 07:51:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B7993088F2; Thu, 19 Jun 2025 09:51:03 +0200 (CEST)
Date: Thu, 19 Jun 2025 09:51:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer
 support
Message-ID: <20250619075103.GV1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.261095906@goodmis.org>
 <20250618134758.GK1613376@noisy.programming.kicks-ass.net>
 <20250618111840.24a940f6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618111840.24a940f6@gandalf.local.home>

On Wed, Jun 18, 2025 at 11:18:40AM -0400, Steven Rostedt wrote:
> On Wed, 18 Jun 2025 15:47:58 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Jun 10, 2025 at 08:54:24PM -0400, Steven Rostedt wrote:
> > 
> > > +#ifndef arch_unwind_user_init
> > > +static inline void arch_unwind_user_init(struct unwind_user_state *state, struct pt_regs *reg) {}
> > > +#endif
> > > +
> > > +#ifndef arch_unwind_user_next
> > > +static inline void arch_unwind_user_next(struct unwind_user_state *state) {}
> > > +#endif  
> > 
> > The purpose of these arch hooks is so far mysterious. No comments, no
> > changelog, no nothing.
> 
> I'll add comments.

How about you introduce the hooks when they're actually needed instead?

