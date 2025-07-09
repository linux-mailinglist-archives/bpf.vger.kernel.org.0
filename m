Return-Path: <bpf+bounces-62797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D2AFEB4C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 16:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD407BFDD9
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF732E762A;
	Wed,  9 Jul 2025 14:06:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC32E7174;
	Wed,  9 Jul 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069978; cv=none; b=iGQhuz5Jc43mfbTulgmklJcSofI0qbicE0z054gKYwe1S2l8C+q2gX02sKts997pmyL7z+G0wH6tE9ieAeo+KoNwZOEi2Wu7aAQPeBl3OkfAe3rAKGKB+2VmP97ZAfncbDNbDqinAgJLXlIjQiFl3qv8hipD+ltaNfr7yNq+mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069978; c=relaxed/simple;
	bh=pyHdC3y4fKmgbNi2AlSqhcqzsL+9Y5KZ8lmnBZtA3zU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5O3nHoYdZGOOtvXQehfK7eh9RzpAID2pKRGq4AuoFyS1dYF+OZxG2rFN0HKHnVmwXUcMLase+SbmAzUDtRsP7twD+ytaCWjI1jrGqpcCy0W0JehIHM51+vCL6mpSXw+ncag+cxkwLjRs7tsU2HUQlMJU25Lb0fIDJkKSF+Cvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 08E30B7316;
	Wed,  9 Jul 2025 14:06:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id C32D534;
	Wed,  9 Jul 2025 14:06:01 +0000 (UTC)
Date: Wed, 9 Jul 2025 10:06:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
Message-ID: <20250709100601.3989235d@batman.local.home>
In-Reply-To: <7250b957-2139-4c03-9566-a6ed9713584e@efficios.com>
References: <20250708021115.894007410@kernel.org>
	<20250708021159.386608979@kernel.org>
	<d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
	<20250708161124.23d775f4@gandalf.local.home>
	<a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
	<39cf3aab-7073-443b-8876-9de65f4c315e@efficios.com>
	<7250b957-2139-4c03-9566-a6ed9713584e@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6i1j9f435rmijytqop4wa5k6katdqzd8
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C32D534
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19I3O0+Bk9PUYOSqUMnBAOfjdkfqfuBrsI=
X-HE-Tag: 1752069961-397116
X-HE-Meta: U2FsdGVkX19D6PsXx8WhUBwhbYkQ/ZahZPLIq8mjtaaIswTJA5s9v/BdJVqFI4w5ajXqEDueo4uYgg8qndcWm7TxxaxjQYhuaO0uc5fYJo8upOVr0CE7TCMqHemi6P76yXTuOc0bWPtnNTTcDAS3sVtgGS9XWk58MrVXG6Ptfjw3hTNNpHnipSb3JkoXfPPFRKcIm/8ZkZKXNpuq642YL2cGKw3e2L9BOQteIqRGSjYgVEAXUP08xjsQnEaZnL+tfz8H0KUV822NUZZVF+4uw+EXoBZAxe8huAPH1MYOCTbm39bhC7sjL/Gz8quq0WMgtt/vK6LO9JxANXuuRvfHVkRRZS5eGWxFs+HQxSV1UHbONGoLc3eduVjWWXd4oxUV

On Wed, 9 Jul 2025 09:51:09 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> One use-case for giving the "current_type" to iteration callers is to
> let end users know whether they should trust the frame info. If it
> comes from sframe, then it should be pretty solid. However, if it comes
> from frame pointers used as a fallback on a system that omits frame
> pointers, the user should consider the resulting data with a high level
> of skepticism.

That would be in the trace sent to the callback. We could add something
like the '?' if it's not trusted.

But for now, until we have a use case that we are implementing, I want
to keep this simple, otherwise it will never get done. I don't want to
add features for hypothetical scenarios.

Currently, the traceback is just an array of addresses. But this could
change in the future. What we are discussing right now is the internal
functionality of the user unwind code where I have made most of theses
functions static.

The only external functions that get called during the iteration is the
architecture specific code. If that code needs to know the difference
between sframes and frame pointers then we can modify it, but until
then, I rather keep this as is.

Jens, is there something that the architecture code needs now? If so,
then lets fix it, otherwise lets do it when there is something. This
isn't user API, it can change in the future.

-- Steve

