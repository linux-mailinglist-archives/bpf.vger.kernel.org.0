Return-Path: <bpf+bounces-69770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4C8BA1150
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658301C24EBD
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8F31AF2C;
	Thu, 25 Sep 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpK+qqNj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02465305E2F;
	Thu, 25 Sep 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826409; cv=none; b=ZibWypKjBGw0TXp6pPXsY6xPBgCxHIumLdPMxfp6LH46EETKbs66f0NzBYF8bjl630m9+pBSwZCm/kd1t1WX8plOGLjhB9kP41ITKQIGcxUGvWETqdvbfrO8aFWLV8chYFJqbibxFU0Gd1qbwQPhPMGsLHAFmDBk+sDHwWZaVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826409; c=relaxed/simple;
	bh=7zKuiaB9nUg1M/dbjATvmM6fNMwW/Ucy+qdkn9KlYN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECFBzUlPuGwKhkqNpuDlrkf8Tw9Ghqg6zgI4Q+WdQh6fztbT5MGNDiER9OMWkcbFQPZA1MtHHsjxxxkuULmD9ps6oGkbBE40HWJAJdjxLlmzBzzUTMF9+swAXs1sYKDdyzf8XyXcOsAO5lKEfcOkPYo0GbZToDJ5EbgHzagTIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpK+qqNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E76CC4CEF0;
	Thu, 25 Sep 2025 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758826407;
	bh=7zKuiaB9nUg1M/dbjATvmM6fNMwW/Ucy+qdkn9KlYN8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LpK+qqNjwpXKYoTbpE3NkYKtPSoOrUj88xGppoSeDZZS0DgvP7jmDumTnxA6krmDU
	 RpsiAchH+SpyYiDhUjcnNbfVByOvb87vqd7ttSCwS0Ncy6GPiIviR8g9NKOW6DdDlB
	 6Hb79DxRRYONdBl2Y2s9JrA4P9+r+Y4evHDZ47Di9smMKOojGzbLjF7nESqK1XGbLM
	 HWjJ+440zB8PqxnFn879TH1bJ6Z2bGISx5pxoGjgG1s6oLisnoCAHa9QMmLWvVdOmK
	 9BkWDK+npK8W2bc8g+pAJzsPs0n5FLufA5xqc3W5V2XVxV1jnDR8xW/aL2KBsTP3RO
	 CuLpJcqSM6t1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A9F9DCE1591; Thu, 25 Sep 2025 11:53:24 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:53:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 19/34] rcu: Update Requirements.rst for RCU Tasks Trace
Message-ID: <e65d2553-88fc-47ee-b0fa-ddfb5515a7e0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <20250923142036.112290-19-paulmck@kernel.org>
 <CAEf4BzazpB6XHL+HRO0HaegiwCUpXaTi+QSnPAxsW9BHBL=50Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzazpB6XHL+HRO0HaegiwCUpXaTi+QSnPAxsW9BHBL=50Q@mail.gmail.com>

On Thu, Sep 25, 2025 at 11:40:54AM -0700, Andrii Nakryiko wrote:
> On Tue, Sep 23, 2025 at 7:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > This commit updates the documentation to declare that RCU Tasks Trace
> > is implemented as a thin wrapper around SRCU-fast.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  .../RCU/Design/Requirements/Requirements.rst         | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > index f24b3c0b9b0dc6..4a116d7a564edc 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -2779,12 +2779,12 @@ Tasks Trace RCU
> >  ~~~~~~~~~~~~~~~
> >
> >  Some forms of tracing need to sleep in readers, but cannot tolerate
> > -SRCU's read-side overhead, which includes a full memory barrier in both
> > -srcu_read_lock() and srcu_read_unlock().  This need is handled by a
> > -Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
> > -readers.  Real-time systems that cannot tolerate IPIs may build their
> > -kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=y``, which avoids the IPIs at
> > -the expense of adding full memory barriers to the read-side primitives.
> > +SRCU's read-side overhead, which includes a full memory barrier in
> > +both srcu_read_lock() and srcu_read_unlock().  This need is handled by
> > +a Tasks Trace RCU API implemented as thin wrappers around SRCU-fast,
> > +which avoids the read-side memory barriers, at least for architectures
> > +that apply noinstr to kernel entry/exit code (or that build with
> > +``CONFIG_TASKS_TRACE_RCU_NO_MB=y``.
> 
> For my own education (and due to laziness to try to figure this out on
> my own), what's the situation where you'd want to stick to the
> old-school "heavy-weight" SRCU vs SRCU-fast variant?

There are a couple of use cases for old-school non-fast SRCU: (1) You need
to use srcu_read_lock() where RCU is not watching, and/or (2) you cannot
tolerate the latency of a pair of synchronize_rcu() calls and the IPIs
from the synchronize_rcu_expedited() calls in SRCU-fast grace periods.

But who knows?  Perhaps in time everyone will switch to SRCU-fast.

							Thanx, Paul

> >  The tasks-trace-RCU API is also reasonably compact,
> >  consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
> > --
> > 2.40.1
> >

