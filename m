Return-Path: <bpf+bounces-66886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC2DB3ABEC
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153F2464264
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B028B7DE;
	Thu, 28 Aug 2025 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX5j6Wqp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EF28642F;
	Thu, 28 Aug 2025 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414109; cv=none; b=Vz2DKoaTHAxEsL26G+28YfABDlFoUaUsVdCytsbDQMwClPPKSkhTwv7CbwrPR1Cs0GS/2SxAl1wMytnEfljdymf56H7UkYxen2qiKw4W+MwFSTTXvJnUT7ZsT28kmQS7x381OATy8JTxYwzvWOXp9jqoM9DQD2e/Dj3uWG1O5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414109; c=relaxed/simple;
	bh=90yQS0zBgjOnbc7DME14L3i5TzWkjA+4tAxm877gJkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHUU06MtrWYwA6/1BFtK6qC/9zLOc5r+OWTz7defdnDJReEYoGviKT0Bo1BGoxkjIXSI5Dz96ogIsRJa9/AHtorMzDOBRV7kfJPRMfEecgbSwQA8JguWXD0a1OmHQ6HmZqR4UostZHmXZP4lTSTggSVj4O9z6dFoi6lv+yOj03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX5j6Wqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F45C4CEEB;
	Thu, 28 Aug 2025 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756414105;
	bh=90yQS0zBgjOnbc7DME14L3i5TzWkjA+4tAxm877gJkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bX5j6WqpIkQLCQXrcG1AS9ABERzEkxsKc+BHmmVI1aja0oFWKU/20ZBLJPE3nRkHk
	 1Eqjwl4MuGeCaUuCd2Byo7x3rK7kJsFUweoU6lKHdO9UPxCTAYxv1gP40V5a+uzzXe
	 BMohG0Zpkyi1GCNHxcAav+fYKKUpwFT62lKDD+X0DlfG4mYhUOsFsTAT+49V/IWo1g
	 3FWsxRhEiKbn0FRX9Q2AGQi8QibiRH/Lrhbgj+yh5Sn31OMmjQRVvGh16v+fS1B0d4
	 0YKbCSF6i9B0usQTqb0UILax5uRoTGIR1QLPmq+TrRbkRD2WKc3oE5Ow3AXM1inN3f
	 B0jhEukC4S/Ww==
Date: Thu, 28 Aug 2025 16:48:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Sam James
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250828164819.51e300ec@batman.local.home>
In-Reply-To: <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 13:38:33 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 28 Aug 2025 at 13:17, Steven Rostedt <rostedt@kernel.org> wrote:
> >  
> > >
> > > That should be simple and straightforward, and hashing two pointers
> > > should be simple and straightforward.  
> >
> > Would a hash of these pointers have any collisions? That would be bad.  
> 
> What? Collisions in 64 bits when you have a handful of cases around?
> Not an issue unless you picked your hash to be something ridiculous.
> 

Since I only need a unique identifier, and it appears that the
vma->vm_file->f_inode pointer is unique, would just using that be OK?

I could run it through the same hash algorithm that "%p" goes through so
that it's not a real memory address.

As getting to the path does require some more logic to get to. Not to
mention, this may later need to handle JIT code (and we'll need a way
to map to that too).

-- Steve

