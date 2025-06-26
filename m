Return-Path: <bpf+bounces-61675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F35AEA1B3
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 17:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36961C60323
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85392F2716;
	Thu, 26 Jun 2025 14:49:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975D2ECE81;
	Thu, 26 Jun 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949347; cv=none; b=PPd/WwtjfL+fcTKmhGlWm15tVpl0PRUI36TulMwcZiye7JnDOeQtlB0VBRk+3NQJvlpHN/aQZ7s460VpjDt+aJFe0hFiW9RncwTMc3h+HKyRHcvgmrZTd59/+mYLuov6o8AIoHvhc2v9REPXn99NVHl78FK95PIbyvaoHySSdqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949347; c=relaxed/simple;
	bh=ALLIIAA++rbzUWCk9xIGTTo6bFs8gHSw2AvD9wAHFDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfQPDD4AnvB/h7B/LPDnIkS9wK4/qHKO4+9sS1bb4zEtMhdeLQDRjdHGZS9PgA2rjFV18Lcl80duJmKK7ambqdXmspNoIp4cqF+rNksh3YhsMISvxIdv8PZ+bXQIN3mTscGFCOH+huJ8UXj5dla7OsjosCViuzBAhzSejHoOFhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1F96E80265;
	Thu, 26 Jun 2025 14:49:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 154C820028;
	Thu, 26 Jun 2025 14:48:57 +0000 (UTC)
Date: Thu, 26 Jun 2025 10:49:19 -0400
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
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 00/11] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250626104919.6591c2b9@gandalf.local.home>
In-Reply-To: <20250625231541.584226205@goodmis.org>
References: <20250625231541.584226205@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5mfy4rbrug9wco81dhw73a8hmxt1ozgt
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 154C820028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/m+Nr0XPIxU/L+9sJu4DhD9Lf9WaHGuCg=
X-HE-Tag: 1750949337-214274
X-HE-Meta: U2FsdGVkX19FnPyiZUCeDf4tox13wQA/4MuEEERmjaxMRF2fxYTjZBpAlIYUfigWaE7cZtZwfKmwcL2NoHGZ4joH/QI67TAdUeVczRJCIc/Dhhj+9hMorn278r/qJ/uxtJK3V0KvOU2GcLeVefBgZf9mN4lDOSbBh1HczVAtA7NHsjhwgROvYU2DyQlbkEx6cyYzJR5U57fUFuUzh59q+Sq+WAYmJy5uRM6kIN7Vij2Pt9WGitr0Pki+t10w3tAmqGjqimfTOMoPyKgyaVEDIUMTbbug7xzov2ERSxU/n0A4pwKsKpx48ORKqr9ZLM/71MVjD8nfAzc5tXNnPCk/X/rBCD8/41J6rRPodXD26umoJt+N/KLxDqdUt/aoEs5U

On Wed, 25 Jun 2025 19:15:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Namhyung Kim (4):
>       perf tools: Minimal CALLCHAIN_DEFERRED support
>       perf record: Enable defer_callchain for user callchains
>       perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
>       perf tools: Merge deferred user callchains

For some reason, quilt send mail dropped the last two patches.

I'll send them manually.

-- Steve

