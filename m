Return-Path: <bpf+bounces-69166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E00B8E998
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 01:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5973B7593
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23ED26E6E2;
	Sun, 21 Sep 2025 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ8Xs+dW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6119CC02;
	Sun, 21 Sep 2025 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758497773; cv=none; b=XwJk5z45xXtr1Qci5RAGo9KOQjoaWJy5FVygugLK+LSpUSwqBjxVB1LbrGd9iHnYy3hdWz1WihEFeWxR9pLLYcHZqTwbPqIReA5gfgYa/kfp85AUoP0IpAJFIYRQo0jWVvpmM10OQt0jOHBf3OuncSJxWuE6pcF6R2wjjzK1Tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758497773; c=relaxed/simple;
	bh=5qclvg+RTTDCY2aG31t+BbC/ehJkz4xWs2Doc8Xel1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io7+0cX8ReN9RUPsosguHLRJsATLkNf/XL6sq6fPcWoVJmgx7uFFkaCtieAwmNbbPneGRBoZVo6asoEAkI5Jtu4A4p+xFMATxLjs64J5oGhfk5RVyinEB46wOXHpaAYysnZg9he0HI4igP36gfeBGhiXK7iEo0TVHsWN16Jh4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ8Xs+dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC045C4CEE7;
	Sun, 21 Sep 2025 23:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758497772;
	bh=5qclvg+RTTDCY2aG31t+BbC/ehJkz4xWs2Doc8Xel1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJ8Xs+dWndk9AnUHu3uivN9RWNE8rs5+DTbm1KKkWTFiAovL7nLYPNs6aEDUzIxpa
	 WuoDggudJI+DpEoBhni6XFnzlPAMva4jMgFEGDHHkoXXkO5GebV1fee/lalqvMFvc+
	 kKrbmdwCpvw6CvszNOGfh/MZewsZt5v7lw9D+BvzoWQMv8b/b/GtQYqiBulenChH+4
	 +jYfMtcZ1zkRBEKhl8jL8lfxwg4JMDumOwwfKXc4rXyXED2b3pIXz9iUAQZj+m7Lg+
	 hAOJfy841d39FOWOaySFWzspzXWEV5gB6YTH+XHvW06YubxYJB1I28lJeXG6hbHkz1
	 lioSDbqF0iusg==
Date: Sun, 21 Sep 2025 19:35:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v16 09/10] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <20250921193527.4fef26ec@batman.local.home>
In-Reply-To: <cic4dekp3h5fduzsar5lydynzambabar26zjzogdbn26dxiabh@g2eaji3bqlct>
References: <20250729182304.965835871@kernel.org>
	<20250729182406.331548065@kernel.org>
	<cic4dekp3h5fduzsar5lydynzambabar26zjzogdbn26dxiabh@g2eaji3bqlct>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 17:31:15 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Tue, Jul 29, 2025 at 02:23:13PM -0400, Steven Rostedt wrote:
> > @@ -230,6 +232,14 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
> >  	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
> >  		return -EINVAL;
> >  
> > +	/* Do not allow cancelled works to request again */
> > +	bit = READ_ONCE(work->bit);
> > +	if (WARN_ON_ONCE(bit < 0))
> > +		return -EINVAL;  
> 
> The local 'bit' variable is unsigned long, so this will never be < 0.
> 
> Should be "bit == -1"?
> 

Yeah, that needs to be fixed. Thanks!

-- Steve

