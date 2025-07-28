Return-Path: <bpf+bounces-64539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8D9B13FAD
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BB216AC8E
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC52741C6;
	Mon, 28 Jul 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1D+6kzh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69391E9B28;
	Mon, 28 Jul 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719348; cv=none; b=RNF5w0vhEYgcXQRzxKz48dW9mCDTPejdlw69tgLTOypJR5HKcawSBN9UPfdXZ8CbE/mGDfodXQQMK04b2+RBGv6VTqrbJTFERsjc8U/R70sVV4rSF/1jd1Pl02QO9+MJ4mSmtzdjmFXtZoStL/qK+Z4dUVrS6San9lEi26qsFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719348; c=relaxed/simple;
	bh=fbuqAJszbf2AyvtcRsvbMiJsUhKn/DpI54qOjKmeZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TD9y+rCWj2g2eu3HiN/gpsMP0aEbGXN/a8ZNanvBdQYJmygZjUNB9lWqFHIHXlYuakPdSztcd9NOgW3I/jkaC5h9xKKUB+6mXLiOMdiUaS5q0Yb7hFTs6PK0OV4RQbP9ABQsDiYhtCjM4qPhT1kLKmohxwBsQGr8+y+BkgEWIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1D+6kzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C146EC4CEEF;
	Mon, 28 Jul 2025 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719347;
	bh=fbuqAJszbf2AyvtcRsvbMiJsUhKn/DpI54qOjKmeZYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a1D+6kzhD/8fTEbMIcFmE2J8AHiBj+Tu6cIiYN5Ty02xYjc0RE4DSYSc5AJKEEU0Q
	 tEIBIeHfOEI0x42z32arNXb5ZwiwfhOtv1k0zRJ7px979FSQtGkK00OO4gXEnug/Az
	 8tuX5dzDVCfBuihftHpt9r843HHpvv8MnVUs0QZVDodfcJLmio6jo3wsQl69OSkDEk
	 PvDUzRmJCDn1usZJsW2l6FO0647hSvcxbXRXtHG77JUDftX8m26q4DOTK4Ax7eBg1A
	 aFhintQGcCqPOHbdgGq0M/gGSWWDMuq3CSVSCWQjEf+9eiR3bHpSWaOlY/1qogMtZk
	 sjol2OUBSwckw==
Date: Mon, 28 Jul 2025 12:15:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v15 03/10] unwind_user/deferred: Add unwind cache
Message-ID: <20250728121543.7aaa75eb@batman.local.home>
In-Reply-To: <a0f9a3ef-f32a-4bff-8ab1-4181ad61780f@linux.ibm.com>
References: <20250725185512.673587297@kernel.org>
	<20250725185739.573388765@kernel.org>
	<a0f9a3ef-f32a-4bff-8ab1-4181ad61780f@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 17:46:42 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> On 25.07.2025 20:55, Steven Rostedt wrote:
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> > Cache the results of the unwind to ensure the unwind is only performed
> > once, even when called by multiple tracers.
> > 
> > The cache nr_entries gets cleared every time the task exits the kernel.
> > When a stacktrace is requested, nr_entries gets set to the number of
> > entries in the stacktrace. If another stacktrace is requested, if
> > nr_entries is not zero, then it contains the same stacktrace that would be
> > retrieved so it is not processed again and the entries is given to the
> > caller.
> > 
> > Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>

Thanks.

> 
> > diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c  
> 
> > +	cache = info->cache;
> > +	trace->entries = cache->entries;
> > +
> > +	if (cache->nr_entries) {
> > +		/*
> > +		 * The user stack has already been previously unwound in this
> > +		 * entry context.  Skip the unwind and use the cache.
> > +		 */
> > +		trace->nr = cache->nr_entries;
> > +		return 0;
> > +	}
> > +
> >  	trace->nr = 0;
> > -	trace->entries = info->entries;
> >  	unwind_user(trace, UNWIND_MAX_ENTRIES);
> >  
> > +	cache->nr_entries = trace->nr;
> > +  
> 
> Would the following alternative to above excerpt be easier to read?

Not to me ;-)

I looked at this and read it a couple of times, but had to go back to
see what it was replacing before I understood it.

I prefer the original. It's logic is, "if this was already done, just
return the cache", where as the below logic is "Assign everything, if
it hasn't been done, do it now".

Maybe it's just my own preference, but I'm more comfortable with the
"if it's already been done, exit out early" than the "set everything
up, and do it if it hasn't been done" approach.

-- Steve


> 
> 	/* Use the cache, if the user stack has already been previously
> 	 * unwound in this entry context.  If not this will initialize
> 	 * trace->nr to zero to trigger the unwind now.
> 	 */
> 	cache = info->cache;
> 	trace->nr = cache->nr_entries;
> 	trace->entries = cache->entries;
> 
> 	if (!trace->nr) {
> 		unwind_user(trace, UNWIND_MAX_ENTRIES);
> 		cache->nr_entries = trace->nr;
> 	}
> 
> >  	return 0;
> >  }  
> 
> Regards,
> Jens


