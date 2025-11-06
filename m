Return-Path: <bpf+bounces-73883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2518C3CBC0
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF6E1894CDE
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A934D917;
	Thu,  6 Nov 2025 17:10:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C3242D84;
	Thu,  6 Nov 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449019; cv=none; b=KpzoCrEut02460JsGDRWUDqxQ91q54616P0e0NwYzGqNi1V7UdKpbrOvN5jbLrtOGiGZ6S59HQfAxxc4kDW11LOCR1DfS+xhTjQLcsqBuLmPSqEeSeiQ3wNemMi2eB6CaFWGkmy2AW0UQo9ekYdI8XzgfipkjnzDr7RU7lbo8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449019; c=relaxed/simple;
	bh=5ucxmab8Lnmq1UWSzk6BYjvOan85ga1kRoY9hCZvgTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8vtTtm/7eZb5WgEfcT3/ZFmRHMFCm8gqUZ/isi0SK/RWuIMGEnxZqRTDur1H1UbslpfCDWuU8zj0ZYpRU8uY4fihsZU3swWk4vtOWKx7gZFVXdorldq4iV0YDo7pPnIMB1loKiBTuhmz21OvBBgZao93qj4qnIv5sud3CVLG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6BD19535C5;
	Thu,  6 Nov 2025 17:10:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 76FB020029;
	Thu,  6 Nov 2025 17:10:06 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:10:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251106121005.76087677@gandalf.local.home>
In-Reply-To: <522b01cf-0cb6-4766-9102-2d08a3983d8a@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
	<20251105203216.2701005-10-paulmck@kernel.org>
	<20251106110230.08e877ff@batman.local.home>
	<522b01cf-0cb6-4766-9102-2d08a3983d8a@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 76FB020029
X-Stat-Signature: g9ewkjshygs6urjbmnzwhwe413z4pszx
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19lvO1dk902l+gpXe7PJIH/wgh8D4MBBBI=
X-HE-Tag: 1762449006-740227
X-HE-Meta: U2FsdGVkX195THmePf1i2pCYkYQF/PnTwlzGgMWbfGrHan8pKMbnvuQeaBh6mU2eSLIL0ZV1fgCFYt9ainwuzOgvvvpplR9QX85CjoZY609kzMbskj3jq7OeFdzSlOwHUSONfwHe2caR8qAyEIQrc46kskBfu2RKN8R/bxIGIL+dicleTaPuU/Cp/bAvjCEjVRfoqZkY25NVT7aiRX+Bwo+nHsx3Z56IGLptAf40JYyenFgtVSbqYXpyYMjzi1UQ56Jc9PBvJHiSBYR4I9ADSFtKI+pS5npU9hWNXL77gYuvOMMt9Ie2BYLVTNzKDHyH6qTqIdqxA+ws6MXguvZ1w627PipE42cI

On Thu, 6 Nov 2025 09:01:30 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, Nov 06, 2025 at 11:02:30AM -0500, Steven Rostedt wrote:
> > On Wed,  5 Nov 2025 12:32:10 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:  
> > > 
> > > The current commit can be thought of as an approximate revert of that
> > > commit, with some compensating additions of preemption disabling pointed
> > > out by Steven Rostedt (thank you, Steven!).  This preemption disabling  
> >   
> > > uses guard(preempt_notrace)(), and while in the area a couple of other
> > > use cases were also converted to guards.  
> > 
> > Actually, please don't do any conversions. That code is unrelated to
> > this work and I may be touching it. I don't need unneeded conflicts.  
> 
> OK, thank you for letting me know.  Should I set up for the merge window
> after this coming one (of course applying your feedback below), or will
> you be making this safe for PREEMPT_RT as part of your work?

Just don't convert the open coded preempt_disable() to a guard(). That's
the code I plan on touching. The rest is fine (with my suggestions ;-)

-- Steve

