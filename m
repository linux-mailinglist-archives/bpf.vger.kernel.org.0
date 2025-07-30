Return-Path: <bpf+bounces-64704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB13B16197
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 15:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C919018C839E
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD532D3756;
	Wed, 30 Jul 2025 13:32:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA52905;
	Wed, 30 Jul 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882362; cv=none; b=AIAsEWBlwTZuOq57zPvLKQlvTXxwMkqCtUoC3dXeMZPMF9JM17RfgoAGQt/NkjPli4NhFFOgmuWHJXXJjZrFBhvVUQTmTsVGBIm/g819Va5bzjiXt7gntp6QCB/pnTG4A9fpO6Q5FECgz693N7SyKfAz4bF6gQk4IIZxxRya6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882362; c=relaxed/simple;
	bh=6uFfGAQV7cgrKKnXB1JGe2mG0Z0YD47d4ZFRY0z7Ckc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brC3nvAwwIls2KOSh5/xwnrad+xEQsxsiP7vVeWaga2JJmb3OH0fQNGlDlT2uwgtCX1X/bY/ZAWyiV6wKAaAX49kLq/MBn6vIt0UHu3dcI5E4jCjfscf/EoHWWsLJ4+HFyiGd4Ozr2MDp5VaxqxQY+yKSNh30rjrKgm3fVbcLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A51191A02A4;
	Wed, 30 Jul 2025 13:32:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id ED81A6000C;
	Wed, 30 Jul 2025 13:32:32 +0000 (UTC)
Date: Wed, 30 Jul 2025 09:32:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v16 03/10] unwind_user/deferred: Add unwind cache
Message-ID: <20250730093249.4833be14@gandalf.local.home>
In-Reply-To: <e0f46e35-5152-4d0a-a2f2-54b2f83a56c7@oracle.com>
References: <20250729182304.965835871@kernel.org>
	<20250729182405.319691167@kernel.org>
	<e0f46e35-5152-4d0a-a2f2-54b2f83a56c7@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ED81A6000C
X-Stat-Signature: o3gkgf6eo17d3nki4ps63qk1wsfopo7j
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19xsM8tnGAIisXJruvhPpHwVj5oc3Osvxc=
X-HE-Tag: 1753882352-735597
X-HE-Meta: U2FsdGVkX1+tJp5TqRCHYBSniBRLbLZApCZJq89h04qR4uX/FtozNxT46TQJfSzSBnPcZ9CyVoZRo2SquhLr7e2QaUGtW9tDUaB0pLxonNodn4Bywwy/iKpj3r3DI2WuIu/Mwg6/Gd5pCNOeyVNN9Y+V5/BnBoHOmi8nEbCb1Ia22wrNa9AeDSdTuvQGfwwg8aTb/v4rKTqeE0l7xFwvH+ODlynhBtg3gv50olVFzk+WUnRKNLG5kzjhMjVE3/6p66+u7s0dZu90xIe9LqFk33NFRXwtTkotxAP5bL0b3ZNU+UTYwtqQ9Od2z16pseYnzWBGANyTj26Zfk/7vyiX0MCnwwLB29pB

On Tue, 29 Jul 2025 21:55:39 -0700
Indu Bhagat <indu.bhagat@oracle.com> wrote:

> > diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> > index a5f6e8f8a1a2..baacf4a1eb4c 100644
> > --- a/include/linux/unwind_deferred.h
> > +++ b/include/linux/unwind_deferred.h
> > @@ -12,6 +12,12 @@ void unwind_task_free(struct task_struct *task);
> >   
> >   int unwind_user_faultable(struct unwind_stacktrace *trace);
> >   
> > +static __always_inline void unwind_reset_info(void)
> > +{
> > +	if (unlikely(current->unwind_info.cache))
> > +		current->unwind_info.cache->nr_entries = 0;
> > +}  
> 
> Should the entries[] items upto nr_entries (stack trace info from the 
> previous request) also be reset to 0 here ?

This is in a critical path, there's no reason to reset to zero. The data will
just be stale. Nothing should care about anything over nr_entries.

> > diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> > index aa32db574e43..db5b54b18828 100644
> > --- a/include/linux/unwind_deferred_types.h
> > +++ b/include/linux/unwind_deferred_types.h
> > @@ -2,8 +2,13 @@
> >   #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> >   #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> >   
> > +struct unwind_cache {
> > +	unsigned int		nr_entries;
> > +	unsigned long		entries[];
> > +};
> > +  
> 
> Should we use __counted_by ?

The size of entries[] is not determined by nr_entries. It is allocated on
the first use, and not freed until the task exits. It's a fixed size
defined by:

/* Make the cache fit in a 4K page */
#define UNWIND_MAX_ENTRIES					\
	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))


-- Steve

	

