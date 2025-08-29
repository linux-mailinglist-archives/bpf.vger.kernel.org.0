Return-Path: <bpf+bounces-66995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C9B3C077
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AD9584FDA
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B56322DDF;
	Fri, 29 Aug 2025 16:18:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2C225416;
	Fri, 29 Aug 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484332; cv=none; b=bUUGkDIGqYzJWVfrpmYx4O3sENljARs6hcBxXyYk78P0Q1pAQc7voJfzbJzBUN7cyvGyBQaXDd+xL95+wbzh6l88s6KV0EMu7PP6/id0OfdJ0hXa/WyUklvKkn9m67rSe5j6eYeaQgTilawnfW7Tz940gMY2f/cHGUtbFUTyoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484332; c=relaxed/simple;
	bh=3kbFgNGBtnYMySoZkWEkqhK6nbpehX5M83TMsJuoAb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTBW1HkbSbBMk+b2COrnCk+Olm1dySAVASY8D8JXChwjsdXycZBg4xrP13OqQ9jSW074nPd2jfS2wZU1vxzvm1PEHNq1NEzuMdKzNkFdE52D8PnY4wkUpr3ytBKssGsyywfpSo974D1Dagrwl4Augbu2JiN7IvWkR1bM+VwvTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id BA3AE85780;
	Fri, 29 Aug 2025 16:18:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 5C7A22000D;
	Fri, 29 Aug 2025 16:18:38 +0000 (UTC)
Date: Fri, 29 Aug 2025 12:19:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250829121900.0e79673c@gandalf.local.home>
In-Reply-To: <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
	<20250828164819.51e300ec@batman.local.home>
	<CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
	<20250828171748.07681a63@batman.local.home>
	<CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
	<20250829110639.1cfc5dcc@gandalf.local.home>
	<CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sx7awj7yzord1wrm8da1wpg38btmtu37
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5C7A22000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+c1nfCCt0C1e+Deb4i5wtjqqLA9tT39nc=
X-HE-Tag: 1756484318-941862
X-HE-Meta: U2FsdGVkX1/hfne7L9q6S79jbACIquvknIGfd89XMC0+3JHyqr220r+bxyWzafHAniZmEEjy20cvsZyuuK4hBzc452jv3ts8qUJ/BKrhbSBGS/+0GWt7PwE/16IU0SLEYSLXMmrZNPkFmalRWiWqg0mvWtwBvOBLOLhEuNJ/E1m9WciT1YPMIUPV/47W74onaLsYZUMCzw/PK8VejvnwuOW7VbIEq3qTmo2SHO5zWDQ6ag6PxVL20ZDh8MM37KVx6Mmm8rh3Grs8b5hdkIFTrjZY4fjcRFPYf7A69xY7iZq+m7dPiPHG28C81VD3cb7LeokmyYzRwSmi+rDwmsB8+R5KdQud+KVEkRh4eMau8HGouS18kHsvoEEc1HBARzhs

On Fri, 29 Aug 2025 08:47:44 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> You don't even have to care about the unmap event, because that unmap
> - while it will potentially kill the lifetime of the hash if it was
> the last use of that file - also means that now there won't be any new
> stack traces with that hash any more. So you can ignore the lifetime
> in that respect: all that matters is that yes, it can get re-used, but
> you'll see a new mmap event with that hash if it is.

Basically what I need is that every time I add a file/hash mapping to the
hashtable, I really need a callback to know when that file goes away. And
then I can remove it from the hash table, so that the next time that hash is
added, it will trigger another "print the file associated with this hash".

It's OK to have the same hash for multiple files as long as it is traced.

All events have timestamps associated to them, so it is trivial to map
which hash mapping belongs to which stack trace.

The reason for the file_cache is to keep from having to do the lookup of
the file at every stack trace. But if I can have a callback for when that
vma gets changed, (as I'm assuming the file will last as long as the vma is
unmodified), then the callback could remove the hash value and this would
not be a problem.

My question now is, is there a callback that can be registered by the
file_cache to know when the vma or the file change?

-- Steve

