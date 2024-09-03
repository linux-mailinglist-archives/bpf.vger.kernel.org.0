Return-Path: <bpf+bounces-38846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4566B96ABED
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 00:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FD11C24678
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C531D88B8;
	Tue,  3 Sep 2024 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwt+dUH7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC63A267;
	Tue,  3 Sep 2024 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401621; cv=none; b=JTb5cXB+l476B4YeChQQi9TZgbkx+Ok+j4s/t/YiTtwB1wz8DiHj9JN0jXJiRutVAZSa+tA5MCYeSWLgQb76edXvfnkWQeX8WNKWTYlz17SLPJjLQ10OwsSSDsbzXBhRKwyGRjRVKJ4Vi+Cvkd8smIa3APs4t3J6hRMxHxCtCqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401621; c=relaxed/simple;
	bh=BFwV4XFqWWCv3stbm+yoKdUNt7HYzxBOKF2GDUHAz+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dm3CDuCiL/QPdtdyVHojwMzYDMxTdzBZmofzeyuAh+BEfHf1mgsffwRGlLgSMWYySBKwBu6kRBrq0zEgfYpq4w/2Q/vz4rY0xgGQncFh96iY1nZKBW9oNW6HXiP1i4aaTQMkiVNNa6bqJOqeZFUB7OSpEmLo/77TKOesC0xIahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kwt+dUH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A03AC4CEC5;
	Tue,  3 Sep 2024 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725401621;
	bh=BFwV4XFqWWCv3stbm+yoKdUNt7HYzxBOKF2GDUHAz+Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Kwt+dUH7Z6nYBlPxIBkm0Vvf1XFwD5P0V3tSz9ut1EJukXQpHy14Hts52T5rNQh7y
	 TUh3GV1D55sqi22iRQf3N3WGxXD9HgfnbqIObA5owK+MJfR+Yt0i0CM4YebON97PzQ
	 U+DhWrkFHthwv/F7l0AwjvTSitEVrh7yFgWBpeSqChvs+P2PGVxrExHR5nv2ujNt3P
	 dHrHLuezZSLoZEA50uXqto9tzvGPdndeJUfAvLVhF0CKh8erVWmWcmNhSTwx9bVVuT
	 HL3iAj5f8KSrpJ/aqNjXOA4kJ+KftdDorimy0nJF2wBV0Ag6mOoGwvs85EUBkIo/LS
	 QGK/q5Wq/A65A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D3B16CE1257; Tue,  3 Sep 2024 15:13:40 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:13:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 0/11] Add light-weight readers for SRCU
Message-ID: <0359b3a4-b6db-45d9-9957-b304b4a85865@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
 <gbar5cxixgq4jtxgtzv7xjipabhqqbwdwyrtahkkws3tregdvo@edqb7ku2uhk2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gbar5cxixgq4jtxgtzv7xjipabhqqbwdwyrtahkkws3tregdvo@edqb7ku2uhk2>

On Tue, Sep 03, 2024 at 05:38:05PM -0400, Kent Overstreet wrote:
> On Tue, Sep 03, 2024 at 09:32:51AM GMT, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series provides light-weight readers for SRCU.  This lightness
> > is selected by the caller by using the new srcu_read_lock_lite() and
> > srcu_read_unlock_lite() flavors instead of the usual srcu_read_lock() and
> > srcu_read_unlock() flavors.  Although this passes significant rcutorture
> > testing, this should still be considered to be experimental.
> 
> This avoids memory barriers, correct?

Yes, there are no smp_mb() invocations in either srcu_read_lock_lite()
or srcu_read_unlock_lite().  As usual, nothing comes for free, so the
overhead is moved to the update side, and amplified, in the guise of
the at least two calls to synchronize_rcu().

> > There are a few restrictions:  (1) If srcu_read_lock_lite() is called
> > on a given srcu_struct structure, then no other flavor may be used on
> > that srcu_struct structure, before, during, or after.  (2) The _lite()
> > readers may only be invoked from regions of code where RCU is watching
> > (as in those regions in which rcu_is_watching() returns true).  (3)
> > There is no auto-expediting for srcu_struct structures that have
> > been passed to _lite() readers.  (4) SRCU grace periods for _lite()
> > srcu_struct structures invoke synchronize_rcu() at least twice, thus
> > having longer latencies than their non-_lite() counterparts.  (5) Even
> > with synchronize_srcu_expedited(), the resulting SRCU grace period
> > will invoke synchronize_rcu() at least twice, as opposed to invoking
> > the IPI-happy synchronize_rcu_expedited() function.  (6)  Just as with
> > srcu_read_lock() and srcu_read_unlock(), the srcu_read_lock_lite() and
> > srcu_read_unlock_lite() functions may not (repeat, *not*) be invoked
> > from NMI handlers (that is what the _nmisafe() interface are for).
> > Although one could imagine readers that were both _lite() and _nmisafe(),
> > one might also imagine that the read-modify-write atomic operations that
> > are needed by any NMI-safe SRCU read marker would make this unhelpful
> > from a performance perspective.
> 
> So if I'm following, this should work fine for bcachefs, and be a nifty
> small perforance boost.

Glad you like it!

> Can I give you an account for my test cluster? If you'd like, we can
> convert bcachefs to it and point it at your branch.

Thank you, but I will pass on more accounts.  I have a fair amount of
hardware at my disposal.  ;-)

							Thanx, Paul

