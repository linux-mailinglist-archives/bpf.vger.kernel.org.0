Return-Path: <bpf+bounces-62660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E06AFCBDC
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F2A7B2286
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8EF2DEA9A;
	Tue,  8 Jul 2025 13:24:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794272DC34F;
	Tue,  8 Jul 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981041; cv=none; b=houRbCw2Ez3JIWkMCyo5k+nEfJX2jWBIgxXk5AG+Z1iXMVzB3Ep7rAEjjkNjWhNCdHAvMmqVP3maUZYPVrUUY78tiKyFg+wyEB1XB4dhXddBSmCQ2i5252Si4BIKKvGr42uJ9kjv34BD4w0niqXP5M7KqqFqoCejKqo+SKqY1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981041; c=relaxed/simple;
	bh=7monKkYWpbsiwqmcPJ9ewRBgJ6OuWduYqF1PGNpRsbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxrjfnpdaFzgLTUfcX8qJByKkH7p0JdpPLO6inzgBZQlQbYp1gGaseDqM2tEEBIWITivN9uxkpby79yWdYFbiYLgaZ7cWaRv+Jltv4gjOo+AHZNbqZfUqa5tDxk5q30bat8/QSXWjMH+C9CG+zYWboC53hYzvJWCmxIearXhNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 9768810B47C;
	Tue,  8 Jul 2025 13:23:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 2A3112002B;
	Tue,  8 Jul 2025 13:23:51 +0000 (UTC)
Date: Tue, 8 Jul 2025 09:23:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in
 uaccess regions
Message-ID: <20250708092351.4548c613@gandalf.local.home>
In-Reply-To: <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
References: <20250708021115.894007410@kernel.org>
	<20250708021200.058879671@kernel.org>
	<CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dc4xdpf4z87w6szwu9dypej9kfpddoyi
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2A3112002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+57oX9VAnEecWyeiP8Yv6pObwlrH3aVvE=
X-HE-Tag: 1751981031-844406
X-HE-Meta: U2FsdGVkX1/w1JlnuOsbVF2S/OVXwPY8+3db7fI/ABcC5i1TfeJIuYFXajKcdC4OG0lOuY8YXF0+VmapkgFecGjFtv3euyock0XZjulJFEYrJpa4v5OrvyQZ13hdvfNCuAb3QYzk8WIaaFTyZ/E9eAye71wMEAB1o7RzSDWhvtX7XCduFeIZ6zpYgLYoIEdqRglTnBZnd7zsa/0LGQbs2QL4EynTw9p3vJaJjtg8XGLxAhhz4fjTG7gl4O23Z4cB29w56uaKetrgjJeTMIab75/hzbD28QVZR7AFXwllZBpjUnrB/8Kdk+CMFTFFQ+oUB8zmgQH2secpUAKn2dCP+C3TR3RKMEAH8NHhaxeMjI4huJSGMkY7+nitPjS48z8LLJeY+cIiWJxp7Dg/Uiy4Nw==

On Mon, 7 Jul 2025 20:38:35 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 7 Jul 2025 at 19:12, Steven Rostedt <rostedt@kernel.org> wrote:

> This patch is disgusting, in other words. It's wrong. STOP IT.
> 

No problem, I can easily drop it.

I just took Josh's PoC patches and posted them. This particular series
still needs a bit of work. That's one of the reasons I split it out of the
other series. The core series is at the stage for acceptance and looking
for feedback from other maintainers. This series is still a work in
progress. Others have asked me to post them so they can start playing with
it.

We still need to come up with a system call with a robust API to allow the
dynamic linker to tell the kernel where the SFrames are for the libraries
it loads. Hence the "DO NOT APPLY" patch at the end (which I just noticed the
subject text got dropped when I pulled it into git from patchwork and sent
out this version, at least the change long still suggest it shouldn't be
applied).

But I will remove this patch from the queue. I never even used this
debugging. What I did was inject trace_printk() all over the place to make
sure it was working as expected.

Thanks,

-- Steve

