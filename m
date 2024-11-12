Return-Path: <bpf+bounces-44667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8686F9C616F
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 20:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538E8283836
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E672194BD;
	Tue, 12 Nov 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTlcs1i3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE991FEFCB;
	Tue, 12 Nov 2024 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439654; cv=none; b=AwEPJ5CcwQj9hci85gsKDmIC1eDoTsRFGlPlDI9cSHOlLl/LBdmHl9ZFIpBwGQjPsefo4CaJ49GiSlHvC4eJ2mgqSO20ozC0FlJBDYTqxFrYuCkbyhYpshA8FbAi4+XF5peNRnfT2r21dEC4fFrgb72Ep+4AVgqvajqxmpWAERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439654; c=relaxed/simple;
	bh=2PvJnInDZ0fL0OD5iSF2Lsc8bhSqcL47V7QRFi8bQl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NotIyGYhoeH7DMXdWEVtNa6SyVBq98uTuqM4YGUy95F6clwhu9ofFok7RczGTiqOje8gJ5KwagQ8wILBMC6bfhGcjdpaM+4pm7PNSUQ/GXraIbLFHgDGKoyamPAEdzkmvD/R2uTEm8dTNmmZYJi22xm1HMcFzKUVUBlE+eE9+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTlcs1i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FD3C4CECD;
	Tue, 12 Nov 2024 19:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439653;
	bh=2PvJnInDZ0fL0OD5iSF2Lsc8bhSqcL47V7QRFi8bQl8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HTlcs1i3lY2MOuOUk4hXeUqEXceB3P/U/Kte3QaaqBnl4gU+OHeP1BYMYJW+3xILz
	 WSlW7WilXMKtpsLL9d49oPv69QICSD84aiYtYy+M9qI2KpYO/ZQkgGGyeyB3ZfekAr
	 5kVjpXPj9az/zktOXdSJbW9cDR1gYlGGiciV0lZ6WeDkUlXKE+Ff9L4ql5I+C74yju
	 6pk//65jqvDbmy3OaF2t5FvNkJoLy0zAyrinoBAeT5EDXPHzX+Hh8i0VUY8Zb9iKvv
	 1l62HjBMQT26prDqhDg5u44BQL0WfXjCod29XOTh2VHfwpd5ThjJkbBvAhrDFwLXZQ
	 lO56OrL1/813A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 261CCCE0D89; Tue, 12 Nov 2024 11:27:33 -0800 (PST)
Date: Tue, 12 Nov 2024 11:27:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 11/15] rcutorture: Add reader_flavor parameter for
 SRCU readers
Message-ID: <d27da29c-7499-4f08-b582-a2bbb9b3c1c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-11-paulmck@kernel.org>
 <c48c9dca-fe07-4833-acaa-28c827e5a79e@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48c9dca-fe07-4833-acaa-28c827e5a79e@amd.com>

On Tue, Nov 12, 2024 at 10:12:40AM +0530, Neeraj Upadhyay wrote:
> On 10/15/2024 9:41 PM, Paul E. McKenney wrote:
> > This commit adds an rcutorture.reader_flavor parameter whose bits
> > correspond to reader flavors.  For example, SRCU's readers are 0x1 for
> > normal and 0x2 for NMI-safe.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  8 +++++
> >  kernel/rcu/rcutorture.c                       | 30 ++++++++++++++-----
> >  2 files changed, 30 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 1518343bbe223..52922727006fc 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5426,6 +5426,14 @@
> >  			The delay, in seconds, between successive
> >  			read-then-exit testing episodes.
> >  
> > +	rcutorture.reader_flavor= [KNL]
> > +			A bit mask indicating which readers to use.
> > +			If there is more than one bit set, the readers
> > +			are entered from low-order bit up, and are
> > +			exited in the opposite order.  For SRCU, the
> > +			0x1 bit is normal readers and the 0x2 bit is
> > +			for NMI-safe readers.
> > +
> >  	rcutorture.shuffle_interval= [KNL]
> >  			Set task-shuffle interval (s).  Shuffling tasks
> >  			allows some CPUs to go into dyntick-idle mode
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index f96ab98f8182f..405decec33677 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -111,6 +111,7 @@ torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disab
> >  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
> >  torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
> >  torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
> > +torture_param(int, reader_flavor, 0x1, "Reader flavors to use, one per bit.");
> >  torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
> >  torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
> >  torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
> > @@ -644,10 +645,20 @@ static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
> >  
> >  static int srcu_torture_read_lock(void)
> >  {
> > -	if (cur_ops == &srcud_ops)
> > -		return srcu_read_lock_nmisafe(srcu_ctlp);
> > -	else
> > -		return srcu_read_lock(srcu_ctlp);
> > +	int idx;
> > +	int ret = 0;
> > +
> > +	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7)) {
> 
> Minor: Maybe use macros in place of 0x1, 0x2, 0x7 as a cleanup later.

Hmmm...

I could move SRCU_READ_FLAVOR_* to include/linux/srcu.h and make
rcutorture use those.  Plus have a combined mask for the instances of 0x7.

Or is there a better way?

							Thanx, Paul

> - Neeraj
> 
> > +		idx = srcu_read_lock(srcu_ctlp);
> > +		WARN_ON_ONCE(idx & ~0x1);
> > +		ret += idx;
> > +	}
> > +	if (reader_flavor & 0x2) {
> > +		idx = srcu_read_lock_nmisafe(srcu_ctlp);
> > +		WARN_ON_ONCE(idx & ~0x1);
> > +		ret += idx << 1;
> > +	}
> > +	return ret;
> >  }
> >  
> 

