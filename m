Return-Path: <bpf+bounces-63318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39946B05A54
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0AC1A6500B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB92E03F6;
	Tue, 15 Jul 2025 12:35:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AC274670;
	Tue, 15 Jul 2025 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582901; cv=none; b=Vq6iJMj128HoiG+kh85bnvJOdVUiEEfEUfx4DCXxzKbvC+xTVHXtsYbWvEmGNlDVxqd29AI5KOCHtqErIhhIq5rXsUkLminYngWLgmIXxCpalmxVH3+aSOm5ZtmuK+6nz4rDVkGPEroZ5k01+mnDOZdu8NCGaoP0Gm+m/EHyL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582901; c=relaxed/simple;
	bh=+BZrdO9qK8EyMXdnS9svcH8zWBpti9CiTn7FyoJYg7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9uAS5lq4TLfHfRSYg7fANnFiUKQeC96qiBhurqlw+mVa6NFYVvQdJVd0mugK2tY3WdCf/5afSFtk0STLBP/RZYqSheOSNKgxRk5HU2BQLbgSF74e1dwMz6sO4CfVPf5bA+VqElXVRP2c9CVumi/JMBQ7M0GKzD4SF5HUxIXcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3E78F12DD02;
	Tue, 15 Jul 2025 12:34:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 9379420032;
	Tue, 15 Jul 2025 12:34:50 +0000 (UTC)
Date: Tue, 15 Jul 2025 08:35:06 -0400
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
Message-ID: <20250715083506.01458000@gandalf.local.home>
In-Reply-To: <20250715090955.GP1613200@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
	<20250708012358.831631671@kernel.org>
	<20250714132936.GB4105545@noisy.programming.kicks-ass.net>
	<20250714101919.1ea7f323@batman.local.home>
	<20250714150516.GE4105545@noisy.programming.kicks-ass.net>
	<20250714111158.41219a86@batman.local.home>
	<20250715090955.GP1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ct31gh6ghco7w9n1i68kjeconey74mg5
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 9379420032
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+owfZCLFT0H27JDc0RpGDEM9MNHAUJVLU=
X-HE-Tag: 1752582890-436053
X-HE-Meta: U2FsdGVkX1/b+myhqa8kmYE2rBGF4M/NqgI07kl1Bila8O+AqF1RD6ppUI6loRMxrqoU+Y1NgSHLx49SY2kbAkNorGE5zIZSUezJ5OVwhtGMUHAFeUeGB+O9eazvlB7IrCgP1gYdEdEfZv+jdCZnZys2hZLMBgxrnhQnUNwfbFWb5KUbAXx/S3nHIf+NjwHgena/inUELnViQ+AwZnjQNAXavjOqNhLD/Glbs8nxLqcBHC27omqej/8B8I+7+pf1yV5/ZMxStTgRlmwsJSKK5HKKtYLmD+i8f+PBpofeqaDt9TRAeLTgLrYwlIwraWvZZlHbaR0WXytfQ+QjUhjGw9hlE8LOT6yQj1fZC7XDE9xd/2JHnHIEckrh2IEsFPiV

On Tue, 15 Jul 2025 11:09:55 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 14, 2025 at 11:11:58AM -0400, Steven Rostedt wrote:
> > On Mon, 14 Jul 2025 17:05:16 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > Urgh; so I hate reviewing code you're ripping out in the next patch :-(  
> > 
> > Sorry. It just happened to be developed that way. Patch 10 came about
> > to fix a bug that was triggered with the current method.  
> 
> Sure; but then you rework the series such that the bug never happened
> and reviewers don't go insane from the back and forth and possibly
> stumbling over the same bug you then fix later.
> 
> You should know this.

The bug was with actually with the next patch (#8) that uses the bitmask to
know which tracer requested a callback. Patch 8 cleared the bit after the
callbacks were called. The bug that was triggered was when the tracer set
an event to do a user space stack trace on an event that is called between
the task_work and going back to user space. It triggered an infinite loop
because the bit would get set again and trigger another task_work!

I can merge patch 8 and 10, but it still would not have affected this
patch, and would have likely led to the same confusion.

> 
> I'm going to not stare at email for some 3 weeks soon; I strongly
> suggest you take this time to fix up this series to not suffer nonsense
> like this.
> 

Sure, I'll take a deep look at your review and work on the next series to
hopefully address each of your concerns.

Thanks!

-- Steve


