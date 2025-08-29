Return-Path: <bpf+bounces-67006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C9B3C123
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A11558611C
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B3334702;
	Fri, 29 Aug 2025 16:49:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017DC2EF;
	Fri, 29 Aug 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486151; cv=none; b=l4VaMoAzsdqjZQ3MNfTsBHr1QtTMT0vXzNpY4/Wuj7NqpIhZQG9CR+NvgogR7+P08w5NtXjLp8Hh6YqxAdtqghQ8JkDFyXAHygeHHtYkNFW0or3VbJBI2vFxIlNZuTCuDEBKF0eP7KKd34CmSf4IevfqV5t+zN3djCUdaG1pJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486151; c=relaxed/simple;
	bh=dCt30wKbDCQm0FDUqIsPulV9rLmOk3zea0Iq/3zuSvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3gVqJVDoDswbULCY7NylmFX5C3mgN40cuaXgldHV7AN4EJWPgosBk8Lt5q+Jzn+RVpkHaqvaf4mMjCTvuSX4OGpOzqkyW9vb8f9wVaNwW9+7Ed3OgZ0ORhaMCKktfF5HpUrLKGnasGTHfkxhmXm2gHYTcg03970AigOWzDGnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 55B7E5B7B5;
	Fri, 29 Aug 2025 16:49:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 0A34A2D;
	Fri, 29 Aug 2025 16:48:59 +0000 (UTC)
Date: Fri, 29 Aug 2025 12:49:22 -0400
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
Message-ID: <20250829124922.6826cfe6@gandalf.local.home>
In-Reply-To: <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
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
	<20250829121900.0e79673c@gandalf.local.home>
	<CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0A34A2D
X-Stat-Signature: 6r13j6g1rjbjafbgxk1xyumyxequ7g1i
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+biBp7yBNj+yTwKZOEmDrCWXtoHjQUIWM=
X-HE-Tag: 1756486139-237950
X-HE-Meta: U2FsdGVkX1/yXWtVRqXL0E+MDqAeLakcKFAdXF9+Rjg3+CbYP4whJQGI+kzqpWaRJ6ugBxbYai870PuGvFouVBPpPbCVv1VrSkiYgE3uz/IiB1SzzzG0jDxbbEhAvvC2MxfIQ62pKkIVQnsB3a+auZ+h2sG+hVHZI9yxqxc2GBNVKBUKlv5t3N+/HRETswvj6S7vkp0cGPLs7XkwGFQ7v3TdDqrMbhGcR+31BM/qgDBgyrNGCQPpw92S1IjZm2U5ozh/PDc/h3J1N7OGdXusnSt85KCFsAh5TYPOdueERel+uDTCNWZRFf0JsN9SmB7IwcQQBpXa+v5INlGhsIW/dGtGDyj0qkNP4V9MFUQk1H4DMaPCut/Jm715BoxMgDWh

On Fri, 29 Aug 2025 09:28:41 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> Don't try to "reuse" hashes. Just treat them as opaque numbers.

What do I use to make the hash?

One thing this is trying to do is not have to look up the path name for
every line of a stack trace.

I could just have every instance do the full look up, make a hash from the
path name and build id, and pass the hash to the caller. My worry is the
time it takes to generate that.

Perhaps I could have a hash that maps the pid with the vma->vm_start, and
if that's unique, get the path and build-id and create the hash for that
and send it back to the user. Save the hash for that mapping in the
rhashtable with the pid/vm_start as the key.

Then the code that adds the vma, will see if the pid/vma->start exists, if
it does, return the hash associated with that, if it does not, add it and
trigger the event that a new address has been created.

-- Steve

