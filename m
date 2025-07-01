Return-Path: <bpf+bounces-61936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF7AEEC97
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB3E17F1A7
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29911DC994;
	Tue,  1 Jul 2025 02:55:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9278F5D;
	Tue,  1 Jul 2025 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751338538; cv=none; b=WFxHFoGBS4i6+K7iC0j7GZuRyzChPUquM8TZ/MWvjkgqGlMtjWjrY82gFINJmuPD6IoZ23IfEmY6fqGICNdhc3JneJW4Y/IxykECSFpHNkYmKwQdZIDw4xXynRcmR5ciKI4L6Sq9m/6gD/XhDWqj1LoQjs9iDqyXmIW9mJXEgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751338538; c=relaxed/simple;
	bh=j8mvDC9ShxcbStXL1aZdO5mHCD7KxGG/dV5WZmv+KBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XR4EAQJ9iGXD13FThN5DpFlZ6UscOCb2a4E13y9rqvbsZiR02SsKiskPksoav97MWXiR4y9UUABdYtoJvXIOVzI9dnbS4fEaA3VsfJktvCk7VVqJXtaAlJWGA8M3BPYnyKPDWl55IIam4c1d5YlOmCa9LBWVk3+PWmZY+dzDfuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B9C931D3506;
	Tue,  1 Jul 2025 02:55:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 8C86E6000B;
	Tue,  1 Jul 2025 02:55:27 +0000 (UTC)
Date: Mon, 30 Jun 2025 22:56:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
Message-ID: <20250630225603.72c84e67@gandalf.local.home>
In-Reply-To: <CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005450.888492528@goodmis.org>
	<CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uxdqmqi3mkftdm3kkxodbidb8rjbd1u8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8C86E6000B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/DhGnpR+zUD75ZuNKjF+V9XwX8hjqOjNg=
X-HE-Tag: 1751338527-525059
X-HE-Meta: U2FsdGVkX1+5SmoCvb2Vcbzey9cRTVgntfEmEbwJO9W59eah++685e1pnXPH9dzoRae6PmUVDEstvcGyXEOIxd6Pdy2gLOm1ySSusqHIzqmjO16HiYhIKII8crc+9TbhKYYcoOHq8bAERyk7LNkWQaMvk/q5YuAty0OBvTJqKfbQGF6uypUOpvBtnJSKGcJ2/g3DnFAwT5yPHQ6fdWlUAlLsrp/FDH4aYWWNF/E9ioCgBMPTjvQsLP+BmzHFoenovpj1sQANw/LTXcRBAKnl1SB8psqy3esHh1ecNPuMa7wGIxFXkcDoIWyfYPD2vUAr+WWYG+IzQ/JPWlPK/b2Kq5NnVNLWl1irf2tI50g7qb0w99RyAf3WHnVCGb90Hjbs4JlXoVOt7nXsU+xeGcZZpXYtB+bhyg8FLFXTAB/89uVrkt3itqFTNsQa4bmjVxuv

On Mon, 30 Jun 2025 19:10:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > +       /* stack going in wrong direction? */
> > +       if (cfa <= state->sp)
> > +               goto done;  
> 
> I suspect this should do a lot more testing.

Sure.

> 
> > +       /* Find the Return Address (RA) */
> > +       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> > +               goto done;
> > +
> > +       if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> > +               goto done;  
> 
> .. and this should check the frame for validity too.  At a minimum it
> should be properly aligned, but things like "it had better be above
> the current frame" to avoid having some loop would seem to be a good
> idea.

Makes sense.

> 
> Maybe even check that it's the same vma?

Hmm, I call on to Jens Remus and ask if s390 can do anything whacky here?
Where something that isn't allowed on other architectures may be allowed
there? I know s390 has some strange type of stack usage.

-- Steve

