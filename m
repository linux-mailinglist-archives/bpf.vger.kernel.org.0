Return-Path: <bpf+bounces-60960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03668ADF17A
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C364B3AD0C4
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192291E505;
	Wed, 18 Jun 2025 15:38:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155028FA85;
	Wed, 18 Jun 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261111; cv=none; b=fUJnzXWC9OAst59j2i4s7kakv+47uZvi7Iw0Kj79DnPggh/KTY+OSdvl+UTktWSeI1mCzYG3LofVN+ThRRRDbxhTrGQ+BapS65m2MOVj0MNne/gfjNdWQA9WFt9bdk5JqidKv6Ed236ZXGDpnFfjahzCOoWWGQBHPp0aAUm8AlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261111; c=relaxed/simple;
	bh=cKSFSoxnitAjZGgvNgqUq5XLSDt0L0l7BTH00fNZQyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojpF50eljr42vqxQsuFyEJ5Q3jas6WRJB8JG4mnw9EOLcoDZjCEgskEqtY4xr0e4ucYNsN7Ps5yxUHBN3lP6sR1X4TJdEa/fZ5+EQtT9TOEDfpFjLXucwZ966nyWy865MMtjEKfR8WeMhGASUgKlS8BH6elHXEIwCyilEUxtAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 513DF8030A;
	Wed, 18 Jun 2025 15:38:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 8AC9A18;
	Wed, 18 Jun 2025 15:38:23 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:38:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250618113831.1e26bb8f@gandalf.local.home>
In-Reply-To: <20250618113706.2eb46544@gandalf.local.home>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.770214773@goodmis.org>
	<20250618142000.GS1613376@noisy.programming.kicks-ass.net>
	<20250618113706.2eb46544@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8AC9A18
X-Stat-Signature: 9iom6z8i66zini513gfg4cfdddsds1ej
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ghWbw4OhlNrQUhRvEjr4WTJdnB8xIu9E=
X-HE-Tag: 1750261103-260494
X-HE-Meta: U2FsdGVkX1+Zb3aFmTig2sc9oHDxGzoxPAPVRMMDMdGsNcMwCVfCIq9cb5qeHdR9cf1rgXOoKdMI11YFVKGsQW7Hp6dXNkA2V82gofI8VLhDAr30CUBkbuwOSuRwOP82/pPxKL+3NYChbGNQ5PMTNiIoUD+VWuaHz8vouUcyKD525ahAgre4dQ2bMdbG/VBsWaTSUx1dLIJmwWwRxUz7gfm7PcbOWclEnyCBCTODpqi2ixk9w+ohsQrpMq4Ag6dm1YzrIJiv/kVmNCfiGI1uReR03BlrLa8TCyUsPJJfHxbE3j0II8hfVVeqKSxhmgQW8uyE22llU25FLW5ANafbO6wPFjB/KqmWKOa+Q1yB6DMK4voYlIeVQeH4S0vB1ydC

On Wed, 18 Jun 2025 11:37:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > What about two CPUs managing to request an unwind at exactly the same
> > time?  
> 
> It's mapped to a task. As long as each timestamp is unique for a task it
> should be fine. As the trace can record the current->pid along with the
> timestamp to map to the unique user space stack trace.
> 
> As for resolution, as long as there can't be two system calls back to back
> within the same time stamp. Otherwise, yeah, we have an issue.

I'll add a comment that states this as a constraint.

-- Steve

