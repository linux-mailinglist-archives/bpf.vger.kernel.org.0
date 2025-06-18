Return-Path: <bpf+bounces-60959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6BEADF176
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01617A7AD1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF212EF9AF;
	Wed, 18 Jun 2025 15:37:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556328507D;
	Wed, 18 Jun 2025 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261027; cv=none; b=C1rYg9jpjzZhzHSLXsYuHS5VNBDvMZYF2CcMVRYJ89Xw1p2QCo1Uj5USJBMsnAiTYciL6ozXyisf1pfe6RtBDnTHaXHgl45dMER1C4VCDfKEMTbW6t678akOoDZfK4XM6aJMDN+fAQLvADlNgeJkVeBaxmlBSdxY8iNNLuQJSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261027; c=relaxed/simple;
	bh=H4U3Ky+IrsZIJIJLfXMmCz0/Z/sH4WWa+E0A4hZY8gM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izXjoiky8caEF4DFKADhuY8M0Hn1B+srfqkl2Q5k9W0V4i9bza9XRyY9SxQpo9FToD98rqjNgnOMw5HpfAIiAt+kWqVn6USoBemcgGrw3kMekLzRnqLQ4JQtuGMJqvK2nr0biTnw7xfedt6tPqcGysklCyfEHXTKyftYNl35JwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B1C781402DB;
	Wed, 18 Jun 2025 15:37:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id A3AD420010;
	Wed, 18 Jun 2025 15:36:58 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:37:06 -0400
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
Message-ID: <20250618113706.2eb46544@gandalf.local.home>
In-Reply-To: <20250618142000.GS1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.770214773@goodmis.org>
	<20250618142000.GS1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A3AD420010
X-Stat-Signature: je68cw8skeuwinopqsr3tb1eoid8b658
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YoKH8GuEQ0yQVJuweTy+bFYg7UncVhlQ=
X-HE-Tag: 1750261018-678897
X-HE-Meta: U2FsdGVkX19XfgmjSoFRuaBqQl+KSL0/+93MSakFfJdGRZSGhN7pEoSQsJlLVCfByRxxCGivGP4wgp10u5COPglY4NovJUFeQSFbttUk9SrRTfOlMgZ0LrPYVeIkKJcZGS+z8F9mUaP+2c968hzJvVrLWAOC9o9pgNosJa18H/jHmhtMVrBUAwQLM/KT39SHUIjpuUeaQABg0L+kGaMPBk/6Hg9nBoCKlf+4wepjjJNHMqoGzNvxWsPjSuIB5GmhM3dxznDQf+p0gVBueUkYACTOjTWMW1e1WufGgDDccZoeQ4iX7XJ4Qot5Cpykwig4piM0AeJgg5jl4GygO5ZyNFu5wa59XOAZKXFtuVYnif51p3JxgRfHcpCjnpH5unv0

On Wed, 18 Jun 2025 16:20:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > The timestamp is passed to the caller on request, and when the stacktrace is
> > generated upon returning to user space, it call the requester's callback
> > with the timestamp as well as the stacktrace.  
> 
> This whole story hinges on there being a high resolution time-stamp
> available... Good thing we killed x86 !TSC support when we did. You sure
> there's no other architectures you're interested in that lack a high res
> time source?
> 
> What about two CPUs managing to request an unwind at exactly the same
> time?

It's mapped to a task. As long as each timestamp is unique for a task it
should be fine. As the trace can record the current->pid along with the
timestamp to map to the unique user space stack trace.

As for resolution, as long as there can't be two system calls back to back
within the same time stamp. Otherwise, yeah, we have an issue.

-- Steve

