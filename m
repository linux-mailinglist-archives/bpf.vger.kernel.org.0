Return-Path: <bpf+bounces-60975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE3DADF2A8
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228114A3A46
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F9F2F363C;
	Wed, 18 Jun 2025 16:26:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623962F0C71;
	Wed, 18 Jun 2025 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263973; cv=none; b=PricAYfXcDL0SEtjnswixXXW6le3PON9H4OJgP6SqGOVbbDN3Nj6Dq2+11/3pzTeI6bMkMfCIkowzexf+bYlI47V1Wyd//czdKhQVTWublXpEmtch2N6kSz0bmbogtasdpimqdgbcl1ORD+fkN70WY4qIMTNmEzutKed/nsB9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263973; c=relaxed/simple;
	bh=D+Qku83705SirzEPM9r8Pk0Ogn4u/n3GmhVFtbHUaeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsCiDhPrgod2okZ5c2coy0iTXfQgXqS6r5MierPQ4W7h58CqW64Pm+7Ay1yuSkHiKpXd4fEEcX1cDN/viWqmVmZL7Fyl+0+kDjDExAERsJXJYWw0p3K+9eUMkcyWlRZJjPMszTA3YXd0lLmW/29jLVVrZUKfznpH4NhdzW3z0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C979D593AB;
	Wed, 18 Jun 2025 16:26:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id D298A20020;
	Wed, 18 Jun 2025 16:26:02 +0000 (UTC)
Date: Wed, 18 Jun 2025 12:26:10 -0400
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
Subject: Re: [PATCH v10 04/14] unwind_user/deferred: Add
 unwind_deferred_trace()
Message-ID: <20250618122610.6ba25735@gandalf.local.home>
In-Reply-To: <20250618112015.56507e6f@gandalf.local.home>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.433111891@goodmis.org>
	<20250618135907.GO1613376@noisy.programming.kicks-ass.net>
	<20250618112015.56507e6f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D298A20020
X-Stat-Signature: x4tdc5hqxfo9xxf98xh3h6tgxohhbp49
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Qym2J4G82XsIefTlvshJlZS5PiF4xJag=
X-HE-Tag: 1750263962-794289
X-HE-Meta: U2FsdGVkX1/RkiojAEr++IjGeZNqMK5NPmDnKCsDySmLXMjLE8pFM6iSm3/wVgR2zFjlFRaAoZuGhBEQj/O1QOkOibGSFEIH+pLrWVSnQd5DK8GVmLv41Nz49/1mK/VHJVnahQxuez5XmTmaQ+W9KX9gLipJH0XZD4/AnAgewMF0f3V1u9ohfClEc85e2qTEgZNOwGkuWyEAm830HELMFq4wZoKMz9uPF6/o8zoRvobUq1PHI3wfU0vn2mvhhvz7h2tn6cnvTFn0L7Hj8NJwUjt9Rz9PuMThJiqu0Iqov7dFS+Aps04zSI9tcmzWfu/Fh3K/ERzBKJpDxW7lM3vUSyg69+o13weRkRmJInaeQsCA/4h2X7lb588It7jJM0Lb

On Wed, 18 Jun 2025 11:20:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > +++ b/kernel/unwind/Makefile
> > > @@ -1 +1 @@
> > > - obj-$(CONFIG_UNWIND_USER) += user.o
> > > + obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o    
> > 
> > We really needed that extra whitespace? :-)  
> 
> Oops, I have no idea how that happened. Especially since emacs doesn't do
> tabs well.

I will replace the two tabs with a single tab which will still add space,
as it replaces a single space with a tab. But tabs appear to be more
consistent with other Makefiles.

-- Steve

