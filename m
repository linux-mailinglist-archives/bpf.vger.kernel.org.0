Return-Path: <bpf+bounces-61972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49452AF037A
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B91486072
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CF328134F;
	Tue,  1 Jul 2025 19:17:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1DE245029;
	Tue,  1 Jul 2025 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397447; cv=none; b=YMAHh6jFPdzxDqnezffNG6EeYkDE58ywKO44ZcInhHSPD5NLvjCbl4W3H4OAbiXvaPUyIXPJVryx6AB79zidVJt4M567fBsC6vtAoOhUDPVUQFTTWnbzZa9R7BchI63+ttuknIRZrnjzwDvatAFcFCH9Tey/RWwiR1i7ZRuRoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397447; c=relaxed/simple;
	bh=Hma+KxtpRKk/H7egh/thhO7nSPGV5JBWPc+D58RUl80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkiuWbjSEKBtDH3CGbQzgNbt68d5v4dN42vF9w39iygjD+1jyE2k9GVcnjayLJmvpgiia/UNXoZXiADhgwceXzBKcM08Sl1kdbO+kIeu3XD0HLXj5SulotXjBqGhhonIAWBUMvDCM9eezk7BruOdc9LH1xsNiTWJ4yO6HW627tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8F36F106D84;
	Tue,  1 Jul 2025 19:17:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 1F9DD2000D;
	Tue,  1 Jul 2025 19:17:17 +0000 (UTC)
Date: Tue, 1 Jul 2025 15:17:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, helpdesk@kernel.org
Subject: Re: [PATCH v12 00/11] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250701151715.5eb5f8b9@batman.local.home>
In-Reply-To: <20250701180410.755491417@goodmis.org>
References: <20250701180410.755491417@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f9sr99csx4g4j46ztd99gtoqr6qz9n4g
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1F9DD2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NzI4bU/Mrds9DY1SbXjrKzE82bFYHyOI=
X-HE-Tag: 1751397437-805747
X-HE-Meta: U2FsdGVkX18/xSeZ9LSnPh4AsPTxO3z2zNJrTLjTEVC4jiPUPYKMRlM2nqKAuRM8uWBM0zmlhH/g199odVKWpAHkGaS59w6tDjTi0aitoRbmWhKl+4Nqofr5HI446EBtd/QlcFsmlgRyb1qCJN1/I1zwJ/jWN9U94kzGrdqVTqtE6sS4IIGw26ZsK00wCL2EwX1JQfe7+9kVPuW56FyqA3E7yij7++s1UrIdegs6EOwqKggKZO9UlCbm4XBiqAiEFYId9QEl2Rq9qJNgmNnTrT8kMLkJ/ux500g0Raw9tLr2xzbycB5vO+f9gjBL5C/Wt3YEncIvYwF0CJWJgCc9AJab0T5HOEc3we5vc+P9ffR11lGpdB0HlA6tTD2dp5xChtKtsXCDw3FcHZ21B5453ADkY67eNcylJf7eT31bZNY=

On Tue, 01 Jul 2025 14:04:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Josh Poimboeuf (5):
>       perf: Remove get_perf_callchain() init_nr argument
>       perf: Have get_perf_callchain() return NULL if crosstask and user are set
>       perf: Simplify get_perf_callchain() user logic
>       perf: Skip user unwind if the task is a kernel thread
>       perf: Support deferred user callchains
> 
> Namhyung Kim (4):
>       perf tools: Minimal CALLCHAIN_DEFERRED support
>       perf record: Enable defer_callchain for user callchains
>       perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
>       perf tools: Merge deferred user callchains
> 
> Steven Rostedt (2):
>       perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
>       perf: Support deferred user callchains for per CPU events

Hmm, patches 5-11 seemed to be dropped, and I sent out 12 patches of
the latest sframe work that I can't find anywhere. I think my ISP is
thinking I'm spamming so it dropped the emails. That's all I can figure.

I originally used kernel.org as my smtp server, but gmail starting
putting my emails into spam because kernel.org can't validate
goodmis.org with DKIM (my DNS has kernel.org set for SPF, but that's
not enough these days :-p).

So I went back to my ISP (hover.com) as my SMTP server, but now I think
it doesn't like my scripts that sends out a series of patches to a lot
of people. It likely thinks I'm a spam bot (although maybe I am!).

I guess I'll change my scripts to use rostedt@kernel.org to send and go
back to using kernel.org as the SMTP server for my scripts. :-/

Expect a resend. Sorry for all the noise.

-- Steve

