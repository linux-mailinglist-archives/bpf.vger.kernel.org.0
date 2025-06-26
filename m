Return-Path: <bpf+bounces-61685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08655AEA3BE
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 18:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7822E4E3325
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC02EBB86;
	Thu, 26 Jun 2025 16:48:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E52EAB7D;
	Thu, 26 Jun 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956519; cv=none; b=V7AyWdUkCRGwfz1/jhNCAjKfEUcBxUy+k9hGRaRjP4AMtH4A4atUywCZsMXFGVXdXJMnAooQE7rHoAi3izpTP/1GWlL2iG6W9ve+P6i/8aaCdX8YX/qrJ0TL2UYC20LRBhuvx189nhuInnpDY4vbCxYB19FVd2PdymTg9yB+Wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956519; c=relaxed/simple;
	bh=y57ov1HPON+7RblMpng15MaR78IYc0SQnNTkR4ODTQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwQ4OYhqa4zFpnQpfdUd0TKMdFiQrlh4Q9gUDXX71BQtF5xPfyvvTtZqfur6RBKmFuzaNUTmbY3Vj0KagYN644bRTq4vjCjzBzBsfQVUdO1TJqYy0SBJvg3FVMbEji39QP6LNfSBlX3tv4su5hNpXeqCGl4Z5QHulV/VQeNF9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8A1E3140328;
	Thu, 26 Jun 2025 16:48:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 63E5560016;
	Thu, 26 Jun 2025 16:48:29 +0000 (UTC)
Date: Thu, 26 Jun 2025 12:48:55 -0400
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
Subject: Re: [PATCH v11 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250626124855.116ef37d@gandalf.local.home>
In-Reply-To: <20250625225715.825831885@goodmis.org>
References: <20250625225600.555017347@goodmis.org>
	<20250625225715.825831885@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7ot81a5mikoo8gjr6whkszf3pmtfff9m
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 63E5560016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+8u65s6mdvyn/bxtW51CRa4c+qOBayZ4I=
X-HE-Tag: 1750956509-146722
X-HE-Meta: U2FsdGVkX1/IV85kqIhmgvrBHUWfRrAiQq5kVJP/UBsRHt/vVFyJ6vGrppW+cwarjS6EdksjPJFRKJejl/ryM+Jm71O6QEil0DyZMzWKfChvk5tyZ65SQiyhjy+k5zPM3Awgsevu8T7jksfwDdQJMiLP4KPoXBPGHAnYegiG0OySbP9m6o8+8ek/GSsAoZMtkQHK1nsLCraR2HP8MqFWca9CTbOFsxDXyamBPCjBOp9Y1iMAjIsL3sYrlaUUzmf/LrFLIlOWJZXZjt7547Q+LOBSNEjlcTLCsRb+fVXMLclVFfMJNflsRALfMK07wkJB0fGT9FAx6eRAHeIdaMdWK5HcSUa6LCdpHqH8nbtuE/+4Zm79dMAIv1svNBqNkEa+

On Wed, 25 Jun 2025 18:56:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>  static __always_inline void unwind_reset_info(void)
>  {
> -	if (unlikely(current->unwind_info.cache))
> +	/* Exit out early if this was never used */
> +	if (likely(!current->unwind_info.timestamp))
> +		return;

I found that this breaks the use of perf using the unwind_user_faultable()
directly and not relying on the deferred infrastructure (which it does when
it traces a single task and also needs to remove the separate in_nmi()
code). Because this still requires the nr_entries to be set to zero.

The clearing of the nr_entries has to be separate from the timestamp. To
prevent unneeded writes after the cache is allocated, should we check the
nr_entries is set before writing zero?

	if (current->unwind_info.cache && current->unwind_info.cache->nr_entries)
  		current->unwind_info.cache->nr_entries = 0;

?

-- Steve

> +
> +	if (current->unwind_info.cache)
>  		current->unwind_info.cache->nr_entries = 0;
> +	current->unwind_info.timestamp = 0;
>  }

