Return-Path: <bpf+bounces-63346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6DFB06508
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4624E5FEC
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8152285079;
	Tue, 15 Jul 2025 17:20:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62628313F;
	Tue, 15 Jul 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600034; cv=none; b=V24wzWfhn66KKCRQcSmN22hZtb+4yK1pToD9TEoxqroJRdj55Lq0qj+dudU1mZij2jzSE2Xbq1pq7wyAIs1fYMUITdrEGWFrAEx2skHMxKqTm/+ddbn03R6tplFT/zjBOiXHLLtvVKGJz0W9Lld2qQfa/MAVqFPNKg0LH+KSD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600034; c=relaxed/simple;
	bh=As4ZjYeZV+A7j+PZ7LF6L10lkAcbZvaT3BwZhulECHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IN3DnI7G6oqMsICV11jRLuW/CrN5iOyEy2gdK4ndXOV9LphfdkopLFgeus43AQuj6KraCP14CsCi7c2+hETE7Z0M6fCpirrYHxXacY84LL3ZrW3xSGwt2B01UdKpkAdiwbnieDjLIU5ICwLtvi2f5KRwejPLjZhkuQymA5yHYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 717B78010D;
	Tue, 15 Jul 2025 17:20:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 8B72E2002D;
	Tue, 15 Jul 2025 17:20:17 +0000 (UTC)
Date: Tue, 15 Jul 2025 13:20:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to
 user space
Message-ID: <20250715132016.409b1082@batman.local.home>
In-Reply-To: <20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.345060579@kernel.org>
	<20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 45ysma5jcp6g1njkax9ky4hkd61auh69
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8B72E2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/mXTTsQPEJCbfJMJPKg+ouLCDm6Nz3w9w=
X-HE-Tag: 1752600017-573387
X-HE-Meta: U2FsdGVkX19/BcfVuEL2lJlkwg3A5yMBKie8hRlUEo8PYo0vkh9xgxLsrt2ILbm04WVKJj/Eo/gqqyjp8bzEJAYbQ4uzPOO2nCwUcaErxtB88w2icut9q7K5KmfrEZAw3T3O5MIqKapm8WnZsbWkRFkjnz6DSAKdIh5UI99Hf0K5MdmSQjsSDdGt5VDNt3eAvfNHr66DiZCvt0V37d//rdZgPkqeimhdr4PaENNc6ONjjdN7dBFivPXK+ic1LphhdxRCfK3Uiv89fOtuki2GhAPyMY1q3u2jq5Qn4yXhxdrhegX831xs9kWdZQRU6Uk/gs+bNmlb5Nx1+9wPeXQX0OYVCf0jA6SpIM7gxAF1/uptQMA9JTycv5Ty08RFyfqN

On Tue, 15 Jul 2025 12:29:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> @@ -170,41 +193,62 @@ static void unwind_deferred_task_work(st
>  int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  {
>  	struct unwind_task_info *info = &current->unwind_info;
> -	int ret;
> +	unsigned long bits, mask;
> +	int bit, ret;
>  
>  	*cookie = 0;
>  
> -	if (WARN_ON_ONCE(in_nmi()))
> -		return -EINVAL;
> -
>  	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
>  	    !user_mode(task_pt_regs(current)))
>  		return -EINVAL;
>  
> +	/* NMI requires having safe cmpxchg operations */
> +	if (WARN_ON_ONCE(!UNWIND_NMI_SAFE && in_nmi()))
> +		return -EINVAL;

I don't think we want to have a WARN_ON() here as the perf series tries
to first do the deferred unwinding and if that fails, it will go back
to it's old method.

By having a WARN_ON(), we need to make perf aware of this limitation
too. Do we want to do that?

-- Steve

