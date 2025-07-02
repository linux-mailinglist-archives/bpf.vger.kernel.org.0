Return-Path: <bpf+bounces-62211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8048AF6667
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5403A4E2AE9
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 23:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259CA2566DD;
	Wed,  2 Jul 2025 23:50:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D987236A9F;
	Wed,  2 Jul 2025 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751500227; cv=none; b=sMVpSO04NIC2aIdZYmRboSzh8itdPhzMXjC/bvgHJqdwbo7sGJYt6XM/EKLp9/8X73ZN5LfodI1pAB6xNNEwtzR/ukK2Ca/S3zouJVgzfcWJCGEJ7jXE0Lw6rSbNVuW2D3KhFFcqWOeC6AHzdXho7UTwTCzQ2x42SrCVwyRM4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751500227; c=relaxed/simple;
	bh=9fXFjFp0u5b7aQ3CHWzSV0R+n2wfz/fb2lvPnZm4420=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjeGlB4mL5TOPkg3RwZd9G7nV7ZbtK/EFIm708JKzvabgubEZX1B4PW889Nv4syeT4ICJxJu8tl3T8lwy5+Q1Gg7QPB0iAf95yahBS/f6MR//qGlANh/CWBA3FB17546o7Xwu6S2H6NHN4nSvV3zvxtboP50cEWVYPr7B00Jfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 96F041D59AF;
	Wed,  2 Jul 2025 23:50:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 4699C2002A;
	Wed,  2 Jul 2025 23:50:18 +0000 (UTC)
Date: Wed, 2 Jul 2025 19:50:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
Message-ID: <20250702195058.7ebb026d@gandalf.local.home>
In-Reply-To: <a6a460e6-8cff-4353-a9e1-2e071d28e993@linux.ibm.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005450.888492528@goodmis.org>
	<CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
	<20250630225603.72c84e67@gandalf.local.home>
	<a6a460e6-8cff-4353-a9e1-2e071d28e993@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pgky877p6uhmzad4abpgywtknz5moogm
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4699C2002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+liiHbNW88bY44ao0HOvbVghxrjAl5YYI=
X-HE-Tag: 1751500218-229696
X-HE-Meta: U2FsdGVkX1/Yjr37XhakLG4Yf0lXEBaAlh80JYyBuLQrggcMNZNWeZbbDx2YajMijOqfDWrTKBj29T6lXzqhes52NRxREH/WMLLOmZ+CR1Wz2DYsJS/yBr8iWACdToyA8BBVz+hYO6qnFmRlJuMrce3o9z4KutTToOLXUMpObod92j087vF2lR6zCpOKVvcfLBzll8GU7bIxzHDuYA1g69zHxdP3VWlDC2XmW/v+I7iXbhWGH/9SBf/8mrCJMWfHni9aJJjh4FTp/n+1kp1AHK/MUpgGgCJmw6v+P/Y/upH0DQY4ZG20plBtp4wnJP6ukL0E+3tiaKAo9fAmHdc3wOQoC7tKxQ8j

On Tue, 1 Jul 2025 17:36:55 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> On s390 the prev_frame_sp may be equal to curr_frame_sp for the topmost
> frame, as long as the topmost function did not allocate any stack.  For
> instance when early in the prologue or when in a leaf function that does
> not require any stack space.  My s390 sframe support patches would
> therefore currently change above check to:
> 
> 	/* stack going in wrong direction? */
> 	if (sp <= state->sp - topmost)
> 		goto done;

How do you calculate "topmost" then?

Is it another field you add to "state"?

-- Steve

