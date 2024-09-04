Return-Path: <bpf+bounces-38871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AEF96B958
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 12:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2022EB26674
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7431CF7A4;
	Wed,  4 Sep 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/ih1hOv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56713AD22;
	Wed,  4 Sep 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447259; cv=none; b=jtf4FyYhGu1sCveBsdBzAidqRt0Dgwgm/ZNljorzdryHzh5NMdplDGRUfJFDF0OvrfsdWECjHHuwKNrso8rf6cAh+f34t7ZARn6OB40fH7eEqdZRKIrVyyvtrHBXPNX4nDFVsA3H/HZalCVH922nnFL6cQVG2NXYFk8GYvdpVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447259; c=relaxed/simple;
	bh=HhQvuwZmWKAr/jdvLk3yTQm7CYTgzuoOEywfGNZucU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UynMmN1AAZfdLQTxRZb/xOqP+Hdt+pfzhKZ4sZ+pk+YiF0aOSIFZeZ4EdAKSfVQiuSptc73tay8VBNBdkrCvGwOvM3efYP7sPuLboe9f3Veaf7Xa25kezcvE3Y0oPdGwlMUTEXXmPQhnkmF1rQCoiPLunJm5tFD9SNk+7ghQUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/ih1hOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA162C4CEC2;
	Wed,  4 Sep 2024 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447258;
	bh=HhQvuwZmWKAr/jdvLk3yTQm7CYTgzuoOEywfGNZucU8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Y/ih1hOvsulHiROzZk3z2FWpfbA4oQBP7lR97UxDecbdVhnsLRJxqZLfNTTUxgC4b
	 7U2ZnFdiAi2at9+qGoZYr5H+0NP0fgV5vwXD9ZpsQTr8qQD49nECEI/19plEfa/C/a
	 zwLsZI+0Pm9WI5DP/JTlze5JdLAvMZnfIWEtedj2FOSHVwzAvKECLcHJwbaoRY4hBN
	 3HnaY6kQ/jJekojbifC1XhcJPTrctuW5xI7LsD8XrXo3yJNh4c2Ar2EOfSGowasw35
	 5zI8ZXVDJ1d3Ac6GjrckDvBb/B1TWRzOcsvzQtUXshY9TMAxO9m8nboUsEP5j1dVJH
	 JUNRHfoC8N3WQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80515CE0D32; Wed,  4 Sep 2024 03:54:18 -0700 (PDT)
Date: Wed, 4 Sep 2024 03:54:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 0/11] Add light-weight readers for SRCU
Message-ID: <0ae7d150-7b92-4e8e-98ea-b28c3b824e11@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
 <gbar5cxixgq4jtxgtzv7xjipabhqqbwdwyrtahkkws3tregdvo@edqb7ku2uhk2>
 <0359b3a4-b6db-45d9-9957-b304b4a85865@paulmck-laptop>
 <f4nkwsbqvpaxxqph3iucohfqy5zwn7j7u5uwppp7rp4mnx2eqj@lqxwtgboskik>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4nkwsbqvpaxxqph3iucohfqy5zwn7j7u5uwppp7rp4mnx2eqj@lqxwtgboskik>

On Tue, Sep 03, 2024 at 07:03:53PM -0400, Kent Overstreet wrote:
> On Tue, Sep 03, 2024 at 03:13:40PM GMT, Paul E. McKenney wrote:
> > On Tue, Sep 03, 2024 at 05:38:05PM -0400, Kent Overstreet wrote:
> > > On Tue, Sep 03, 2024 at 09:32:51AM GMT, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > This series provides light-weight readers for SRCU.  This lightness
> > > > is selected by the caller by using the new srcu_read_lock_lite() and
> > > > srcu_read_unlock_lite() flavors instead of the usual srcu_read_lock() and
> > > > srcu_read_unlock() flavors.  Although this passes significant rcutorture
> > > > testing, this should still be considered to be experimental.
> > > 
> > > This avoids memory barriers, correct?
> > 
> > Yes, there are no smp_mb() invocations in either srcu_read_lock_lite()
> > or srcu_read_unlock_lite().  As usual, nothing comes for free, so the
> > overhead is moved to the update side, and amplified, in the guise of
> > the at least two calls to synchronize_rcu().
> > 
> > > > There are a few restrictions:  (1) If srcu_read_lock_lite() is called
> > > > on a given srcu_struct structure, then no other flavor may be used on
> > > > that srcu_struct structure, before, during, or after.  (2) The _lite()
> > > > readers may only be invoked from regions of code where RCU is watching
> > > > (as in those regions in which rcu_is_watching() returns true).  (3)
> > > > There is no auto-expediting for srcu_struct structures that have
> > > > been passed to _lite() readers.  (4) SRCU grace periods for _lite()
> > > > srcu_struct structures invoke synchronize_rcu() at least twice, thus
> > > > having longer latencies than their non-_lite() counterparts.  (5) Even
> > > > with synchronize_srcu_expedited(), the resulting SRCU grace period
> > > > will invoke synchronize_rcu() at least twice, as opposed to invoking
> > > > the IPI-happy synchronize_rcu_expedited() function.  (6)  Just as with
> > > > srcu_read_lock() and srcu_read_unlock(), the srcu_read_lock_lite() and
> > > > srcu_read_unlock_lite() functions may not (repeat, *not*) be invoked
> > > > from NMI handlers (that is what the _nmisafe() interface are for).
> > > > Although one could imagine readers that were both _lite() and _nmisafe(),
> > > > one might also imagine that the read-modify-write atomic operations that
> > > > are needed by any NMI-safe SRCU read marker would make this unhelpful
> > > > from a performance perspective.
> > > 
> > > So if I'm following, this should work fine for bcachefs, and be a nifty
> > > small perforance boost.
> > 
> > Glad you like it!
> > 
> > > Can I give you an account for my test cluster? If you'd like, we can
> > > convert bcachefs to it and point it at your branch.
> > 
> > Thank you, but I will pass on more accounts.  I have a fair amount of
> > hardware at my disposal.  ;-)
> 
> Well - bcachefs might be a good torture test; if you patch bcachefs to
> use the new API point me at a branch and I'll point the CI at it

I am sorry, but I am getting on a plane today, am short of time, and
won't be responsive for the inevitable issues.

But this is a very simple change, just change srcu_read_lock() and
srcu_read_unlock() into srcu_read_lock_lite() and srcu_read_unlock_lite().

Would one of your bcachefs early adopters be up for this task?

							Thanx, Paul

