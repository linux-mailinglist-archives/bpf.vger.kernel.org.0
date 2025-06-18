Return-Path: <bpf+bounces-60956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68364ADF152
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEA0175F6F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE22EF9D3;
	Wed, 18 Jun 2025 15:23:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B022EE99E;
	Wed, 18 Jun 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260235; cv=none; b=FHyIo492Xlstv679HnJ09oMdoetF/93p/B4Ty+z6MviQpleySkzW9gfFVExz2M6qnFjXSIChWQ27DjA/NqWHgt3/j2Qkovg+ggJf43g5EjSrH5QYBaKqhSLzKvPAjINPQBz0qKZfW8kQYp23ibTVGISGe9SrW+PDxA2YbEmYEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260235; c=relaxed/simple;
	bh=SX5OHD/d/ITogClcMTplzdS9fgFMBWy9hG0cbMhULFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxgWT2rXUr4kj2wKtLGN6qedTqppBLZGzMaYfrJtFpmYpU6Td2fwYFxoqoepnccXSAyv3+5f92va32flt9xkZZlU4ELPdzD9jHbYOvwSkj1FrSgsu7AgW0ew8hN/0ZitG5qLecaBgf1/aLEttv9J4btL+wi5dpd2oF2hh2yHgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id AD49E1A02C0;
	Wed, 18 Jun 2025 15:23:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id CEFF460009;
	Wed, 18 Jun 2025 15:23:47 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:23:55 -0400
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
Subject: Re: [PATCH v10 04/14] unwind_user/deferred: Add
 unwind_deferred_trace()
Message-ID: <20250618112355.47ed62e6@gandalf.local.home>
In-Reply-To: <20250618140111.GP1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.433111891@goodmis.org>
	<20250618140111.GP1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CEFF460009
X-Stat-Signature: y6mrjqrdyr9rapdufpodsd89snn3sdx5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18tgXEdbs5iaqcKTWUAIktxWeEKoKyWLcY=
X-HE-Tag: 1750260227-738225
X-HE-Meta: U2FsdGVkX1/KV2XbzLVp5QcwT2vO3ZLzoSiV6kHNCKriq0j6j3wN3uT2MlIILhcOLnJYbZ3FjZx+/wpAU5eA2HHloPA5QZFEfP5JfxHC+Pk2mHDT4EKm1RerOLiM+MiqRbxR9uXfm4ApdFiskOo0+MW/PVEZj90xsuo5re27rSmFWPu39//amkYt7FtknfJqGDKq3IvfBhN4LXUojnSVXKpKpwGwEermIf6Jn9ugmc8YkDWr4bcktSZjnk1iNld2Vau2gC9VLcf0YH5Gmxxk5TK0+YjCvtCOjwp1Cu6PqTox+UxBarr5Pk9aMea9CecOiIT1M7A4Zu/20o11sOkt7mcpqli69dEyqvqRF4ERNGTHZRr/qUVekIwG/y3hTMhN

On Wed, 18 Jun 2025 16:01:11 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 10, 2025 at 08:54:25PM -0400, Steven Rostedt wrote:
> 
> > +#define UNWIND_MAX_ENTRIES 512  
> 
> The reason this is 512 is so that you end up with a whole page below?

Possibly. We could probably even make that configurable. Perhaps just use
sysctl_perf_event_max_contexts_per_stack ?


Josh, any comments about why you picked this number?

-- Steve

> 
> > +int unwind_deferred_trace(struct unwind_stacktrace *trace)
> > +{
> > +	struct unwind_task_info *info = &current->unwind_info;
> > +
> > +	/* Should always be called from faultable context */
> > +	might_fault();
> > +
> > +	if (current->flags & PF_EXITING)
> > +		return -EINVAL;
> > +
> > +	if (!info->entries) {
> > +		info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> > +					      GFP_KERNEL);  
> 


