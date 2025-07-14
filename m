Return-Path: <bpf+bounces-63201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 432F5B04159
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E18E188592A
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3211524EF7F;
	Mon, 14 Jul 2025 14:19:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1C1EEE6;
	Mon, 14 Jul 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502764; cv=none; b=lPXp8CMo/uS+j096M66FriYN4PD+USmR6XabtOnJFi7kHGiwYyGVwcqwjgVK5C9ybAX14dbHuiybJ3kMQbjJd26AgQYRWX8SwJ1G7GT0G1wdiEsU2062GC/3JV/14iSVwybnXYyDnWpZf13x06Hq1mtRxcIwv+BaxQpjInwbI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502764; c=relaxed/simple;
	bh=IllrlY7YRdT4OBQJR/CP5FEYS+rw/izw4ACQ9TUbQMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDODYbkOPXjOh38vRF8J0TCBz5bUkTuxgC3n++Sqd/QFNUztv0rqiojSrUSCrDgcr5Ml/iynTGdDj3Bl2j9pe6s7eXDTUWStjgARh4HveIHB9lPlZ+8+je8WbiEKj2hLrkN0j6RhLPQLmWNJRfpe9PXvGPCsqMQnYOP8OmcgZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7D9C2C0185;
	Mon, 14 Jul 2025 14:19:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id D00A317;
	Mon, 14 Jul 2025 14:19:13 +0000 (UTC)
Date: Mon, 14 Jul 2025 10:19:19 -0400
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
Subject: Re: [PATCH v13 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250714101919.1ea7f323@batman.local.home>
In-Reply-To: <20250714132936.GB4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
	<20250708012358.831631671@kernel.org>
	<20250714132936.GB4105545@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D00A317
X-Stat-Signature: 5sdh1ceqmyoi43hp6wx1ooxfmfgtcba6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+qxoyk/2vRegVz7AUsVoovCs8+5ieuUHE=
X-HE-Tag: 1752502753-697104
X-HE-Meta: U2FsdGVkX1+Q8ZPHIBG6iJU0/wJ6FEzdtdCFIzjvnBLklDY8Ei1sPpSkZjKe1zANwzOUyvCusXZlNxYDIZZOfpfVNg33GX6fttMye1NcrzdiggTzqyT67Igq25b1n+jkOyluIzLJNWkW72u4DKYn5mV3OMhK0BLtULons8g67v/oCuw2z9HPoh4iyG06Jyxt55JdUPcCXkwUm+kStWWmiyqUim0qDREPLkYjWgDXRzoDNk+mD2ea182YmQhVCHD/Ygt6pFFOswtWkqYSGk45zw6FUnfpJfMPAY8X1Fu3lnz2LNoGZX5tnidCK9vLUU227eBFlfdi3AmxInxkSbQc8ygkwQhtKFB6Jy2D0Ma9hnQL9DptdipPT45UqiI+69E0

On Mon, 14 Jul 2025 15:29:36 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
> +#define UNWIND_NMI_SAFE 1
> +static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
> +{
> +	u32 zero = 0;
> +	return try_cmpxchg(&info->id.cnt, &zero, cnt);
> +}
> +static inline bool test_and_set_pending(struct unwind_task_info *info)
> +{
> +	return info->pending || cmpxchg_local(&info->pending, 0, 1);
> +}
> +#el

Patch 10 moves the pending bit into the unwind_mask as it needs to be
in sync with the different tracer requests. I'm not sure how this
change will interact with that.

-- Steve

