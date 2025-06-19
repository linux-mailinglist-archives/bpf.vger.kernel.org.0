Return-Path: <bpf+bounces-61038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63272ADFF37
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A25189EF92
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356162571C5;
	Thu, 19 Jun 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KKIK2SLb"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59584231837;
	Thu, 19 Jun 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319780; cv=none; b=H1f0WBlqfqIy8neAqCPj03mY9u+WeDQ4Kt1ucxZAFOLbP2SwG/ITIVMNYtSCyT0f4BZEFFeY1dutq9pLuHVY0GN5ngqPfiXKW/ZHqaVr6G0j9YkNJc9NEsif8N7HFFrwo9+XW3z9/RQgi+CvjaDx3rQn76E0s7SGXFVFgc2nouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319780; c=relaxed/simple;
	bh=UCfSw+yCArYJHPSyAoRS84vmU7QunFE9AYu4txg8Quo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opLrKSCWV9ViMm9EkMRoGNUG9tdn8e21j51cSfu/y2Y1pfYsSZmCJDzIGBbrF3xA+y8FrmWUJ/hqGtrUoCYWtDuOAkFpyvllDgxaN7xgDymqYpHRRqQ51m2Hfor/IxBJ6KRrPOFoBMLub1w4lKW7ekX/RtmRXA2JAXocv9xHW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KKIK2SLb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xk3lGqy9F+weq12Ohy6zQegZ0lkVzClQ/YdIVJy2EqI=; b=KKIK2SLbn3naev7zUk4Z+9u4+5
	2GkAhj3EpJauuizn7W5A9KkP6dzLw11G0j0KecXFcdv0W3pRaY4lda6sMMclwVbFu5Wn/j21ggfzW
	cZTUkYZ3CciIBw8DhDQYTv1BgKPmN23CMXbNpv2HMyUCK4fCn2ISm0KkNgvhawiHYLRKXRG26t0mw
	3LVSmLlB9EVMaEYk+v9YXqO5xXQgvP10/KwEI4ON7rQ1mLLHPVk4W82K2LaOM8+Fgmw75/PDNr95+
	4kjEOIGbQKUAV8do5KkQC4zQdt/IU67o4VzTVkgmcBMLObTK9BIRwver4nBm06FHWBK/9wceDW8z6
	PjS3iHwQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSA84-00000004NNX-1S5v;
	Thu, 19 Jun 2025 07:56:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 392CD307FB7; Thu, 19 Jun 2025 09:56:11 +0200 (CEST)
Date: Thu, 19 Jun 2025 09:56:11 +0200
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
Subject: Re: [PATCH v10 05/14] unwind_user/deferred: Add unwind cache
Message-ID: <20250619075611.GX1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.603778772@goodmis.org>
 <20250618141345.GR1613376@noisy.programming.kicks-ass.net>
 <20250618113359.585b3770@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618113359.585b3770@gandalf.local.home>

On Wed, Jun 18, 2025 at 11:33:59AM -0400, Steven Rostedt wrote:
> On Wed, 18 Jun 2025 16:13:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > > +		info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES),
> > > +				      GFP_KERNEL);  
> > 
> > And now you're one 'long' larger than a page. Surely that's a crap size
> > for an allocator?
> 
> Bah, Ingo suggested to put the counter in the allocation and I didn't think
> about the size going over the page. Good catch!
> 
> Since it can make one per task, it may be good to make this into a
> kmemcache.

Well, the trivial solution is to make it 511 and call it a day. Don't
make things complicated if you don't have to.

