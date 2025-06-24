Return-Path: <bpf+bounces-61456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3DDAE725C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D681517CAF0
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C4225B303;
	Tue, 24 Jun 2025 22:36:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2E2586FE;
	Tue, 24 Jun 2025 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804587; cv=none; b=GhxYUVshtlhPTI8x6xUkUMHgM2RZ4lnCS/T1igHfCKvL2bVKzYF6BkM7O0gfqlqkquY99z8J1mN7PzNMDDAkEeDxkPlCPwI7oP89/c8dBSJr8riNLuZ4JmlC1UqaC4UywCnfAdsoZ5g1QCY9fxmOAanHBthXYwfVce3S/FlErpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804587; c=relaxed/simple;
	bh=7L5rEGVO3mrtPyc5RGQpu5ReOYLzXADuN7/STbDJ1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2qURzRhTuv+jEMEN4rTe5tu5WK8ycrn+XVUPa5YNWz8ol7Fpip6td4Al3Oe4UHLL78Slarafb9BlERKwKou0JkjQGCxjHr0PnjjNShMjP7yfvB/GuenL+mNyCN+ONJd5SUZ24cDBdaugt9zS5azD8h2enjax2iFIA5JU/zhxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9DB5F1D8A29;
	Tue, 24 Jun 2025 22:36:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id B628337;
	Tue, 24 Jun 2025 22:36:17 +0000 (UTC)
Date: Tue, 24 Jun 2025 18:36:16 -0400
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
Message-ID: <20250624183616.5b0a3ddc@batman.local.home>
In-Reply-To: <20250618184620.GT1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.770214773@goodmis.org>
	<20250618184620.GT1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B628337
X-Stat-Signature: 9hbaj66wbm19opkqqp641h9p5jtsypgb
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18kjCDdOfEldqCgG+Xb3ujrKQBHryBilNc=
X-HE-Tag: 1750804577-207013
X-HE-Meta: U2FsdGVkX1/qbrG10wqZmAfL6ElwAmwibtJjC1FxVLGSItuYoSR5syVwERHRqjHABd/xNiX6DA4hZCE/YhCX76No8uxwuK+g4ZPVSdvA0jJoy/gzSsd/PUCf0JOYCLHXBug0M750+oUlAIZ+577hjUTrahdgY3PlfI34CDdVfK8kDVYpxJmAsuYPY37FXjd85NVxM3hKsOn3vBf0WxFxE6Vk/EmbBb4KMSYHNDnVvKmGJBBJ7ngq42U9VfuKyqk10/xstuIIsz5CXHNvb71SLN0V6zXDjoLpp5Xxl9cAxMJG04WDTweOfRFFIdE8dsDHGGeEzQ6NwFUGI0g2jmokq3ax2DzhqCTwksqauDAv6IHhwOFMVEHXFkKsoBmL8rfx

On Wed, 18 Jun 2025 20:46:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> >  static __always_inline void unwind_exit_to_user_mode(void)
> >  {
> >  	if (unlikely(current->unwind_info.cache))
> >  		current->unwind_info.cache->nr_entries = 0;
> > +	current->unwind_info.timestamp = 0;  
> 
> Surely clearing that timestamp is only relevant when there is a cache
> around? Better to not add this unconditional write to the exit path.
> 
> >  }

Note, the timestamp could be there if the cache failed to allocate, and
we would still want to clear the timestamp. I did turn this into:

static __always_inline void unwind_reset_info(void)
{
	/* Exit out early if this was never used */
	if (likely(!current->unwind_info.timestamp))
		return;

	if (current->unwind_info.cache)
		current->unwind_info.cache->nr_entries = 0;
	current->unwind_info.timestamp = 0;
}

For this patch, but later patches will give us the bitmask to check.

-- Steve

