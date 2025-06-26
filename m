Return-Path: <bpf+bounces-61668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1760EAE9E34
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FB73BC49B
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF45E2E5407;
	Thu, 26 Jun 2025 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wd46GmJc"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9972AD11;
	Thu, 26 Jun 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943245; cv=none; b=kRYjxBsprp2enVkdb165N3u4nCDI4Y4PuErCeFl0Cba/ZhX1e8KaqwHqoUezO4eiq1fk+ttbs8Xx6d4Ky/T4TSobu4yVSKbnnNG+xRJbQqA4o3wamg2OB2eZSA37g1KZnovAt/2Ps8iSAeQnvngYVgID1I6OQ3CwU8FDVI8dk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943245; c=relaxed/simple;
	bh=oN0tXWyd2Pl7Qho5xOU8PktHj9C10fwN6NEZn0c0cK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyOa65+Zk46Dzp1Xq1sU5IhAKvprN1REgBI949CQGOe97IoF97rPsLpvn+fk5mzevS7aRjTVUqwUmsc4tVO7BJFOjI40LEsUamEZiANi/AX2uXAlc94o2S/V7pmbqRPqzngUJaZyORpMdjXZE4IfDxtrMzEDM4zGzWmuTCJJ+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wd46GmJc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J4mM+Th2cNmMlS1OHaD0inVbssW+LOr+GAf200cBoM0=; b=Wd46GmJc2meXibKUN2+7aJ1XgO
	gdm1xyUL40dpG7E4vIBavoPQOq/5TEdm/CNnKeSMOh8/7yKpLAprgQqrGHHF0y4NCstFzjZW8v52m
	w7uHVWe1/H7GC+r+rvoqYddFl9B+8XwE2U+8vbTsVgWz8DXIH2/2flAlq+IvulzSv4rIHpLPi17ka
	sHhGf7iJTh/RryhXm/hezQ6Ju6ONyoI1gB9DKuUFmuX+Pn1XhT8qCTqPzi4USvv/aUkLRgOFVeyZL
	PvDKhOg27hri5+pW+t7dhJw5dSy3GKO0eSN8zr83owni1Gy2Ddg1czrjTiYkE+NjhfzFRzUbAoDrP
	8hy3avDw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmJn-000000066Hi-1MXi;
	Thu, 26 Jun 2025 13:07:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E415630BDA9; Thu, 26 Jun 2025 15:07:05 +0200 (CEST)
Date: Thu, 26 Jun 2025 15:07:05 +0200
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
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 13/14] perf/x86: Rename and move get_segment_base()
 and make it global
Message-ID: <20250626130705.GG1613200@noisy.programming.kicks-ass.net>
References: <20250625225600.555017347@goodmis.org>
 <20250625225717.016385736@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625225717.016385736@goodmis.org>

On Wed, Jun 25, 2025 at 06:56:13PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> get_segment_base() will be used by the unwind_user code, so make it
> global and rename it to segment_base_address() so it doesn't conflict with
> a KVM function of the same name.
> 
> As the function is no longer specific to perf, move it to ptrace.c as that
> seems to be a better location for a generic function like this.
> 
> Also add a lockdep_assert_irqs_disabled() to make sure it's always called
> with interrupts disabled.

FWIW, I recently found we have a second 'copy' of all this in
insn_get_seg_base() / get_desc().

Its all subtly different, but largely the same.



