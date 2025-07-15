Return-Path: <bpf+bounces-63355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABFB065F3
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B5F566A1F
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C28B2BE641;
	Tue, 15 Jul 2025 18:26:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB928F948;
	Tue, 15 Jul 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603982; cv=none; b=IN2aYwI4K2BanO7dAhXlz2kBZbe3H5u44D4ENINQrVgDTF3fK4kPAB1Mhl0uX5E8XG5UZ/6UFwawGxCfVd/FAFZbmeQIp0FrFFXFdA5dAj6qHJlKlSFZ5avrtNBJ8gryE3odlSRldq1fj5ZCDh5BBZ2luei6MvfKU/6bcMYYTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603982; c=relaxed/simple;
	bh=d492akOQwE/nITNKQ6WXsp4Sz5y0/EdvpkqiIAEmBXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2t0QUEPt+WotjMSi+2F3cjxrPsQxlRflmqRiw75uTr5FdK0cSqNbFxAeRoxBfA5h76iL4Y14lnA02xlUs3YOpCv97mOKVojvNoxKpi2vGCfMgCEWcECa2RVtV+uHnw/+noMMQVFpCPkxyWwZz1LCwRxUTN3GEGeanBIoMToK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 89F7AB6575;
	Tue, 15 Jul 2025 18:26:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id CC22A6000A;
	Tue, 15 Jul 2025 18:26:11 +0000 (UTC)
Date: Tue, 15 Jul 2025 14:26:10 -0400
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
Message-ID: <20250715142610.2e1bb341@batman.local.home>
In-Reply-To: <20250715140650.19c0a8ed@batman.local.home>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.345060579@kernel.org>
	<20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
	<20250715084932.0563f532@gandalf.local.home>
	<20250715140650.19c0a8ed@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 99usg7ufpezufy9zhi7bi7f6cp394fk3
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CC22A6000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/W3K8oETpXrrrMPECrBZjLRieU+nnwXec=
X-HE-Tag: 1752603971-275217
X-HE-Meta: U2FsdGVkX1/rB0YRB4mWgS30gnYn0qDx+/FYMc/dZ2PNChHSq0DQzLsUn5FFj5wEIvUJ97yX0X1+XVVviFXgkcej58MuQtGdI3x85RmdJbSjzHyr46cik9t0v1bb70NivZM1pIY/xTL4uqPUHDYRwmzCt8vr0w5JVkC/MXRoLPjEg65X8JM8aO/LXjFO6Pnfm7HMNKLscX3BkkLJ+aRzwjmJ+sBt9+fSDVCK5aowcq22usFQUqy6+pn4aFrCwsyy+2oXH2PkKCPpjfYDun2Xx6xCLPKBNg1L7H6+I3pWfOGLChcgxtXauLF4e2Qj9HgnlaNFsaQfwXrMD3MuGrwcMn4JIRY/gwmkeC7kBAP32Jyp56AEn3xFP6hxWYUzpTHh

On Tue, 15 Jul 2025 14:06:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > > + * Return: 0 if the callback successfully was queued.
> > > > + *         UNWIND_ALREADY_PENDING if the the callback was already queued.
> > > > + *         UNWIND_ALREADY_EXECUTED if the callback was already called
> > > > + *                (and will not be called again)
> > > >   *         Negative if there's an error.
> > > >   *         @cookie holds the cookie of the first request by any user
> > > >   */      
> > > 
> > > Lots of babbling in the Changelog, but no real elucidation as to why you
> > > need this second return value.
> > > 
> > > AFAICT it serves no real purpose; the users of this function should not
> > > care. The only difference is that the unwind reference (your cookie)
> > > becomes a backward reference instead of a forward reference. But why
> > > would anybody care?    
> > 
> > Older versions of the code required it. I think I can remove it now.  
> 
> Ah it is still used in the perf code:
> 
> perf_callchain() has:
> 
>         if (defer_user) {
>                 int ret = deferred_request(event);
>                 if (!ret)
>                         local_inc(&event->ctx->nr_no_switch_fast);

Hmm, I guess this could work if it returned non zero for both already
queued and already executed. So it doesn't need to be two different
values.

-- Steve


>                 else if (ret < 0)
>                         defer_user = false;
>         }

