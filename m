Return-Path: <bpf+bounces-69520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563DB98C8E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C74119C7497
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F01276058;
	Wed, 24 Sep 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/2jcezO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56734275B01;
	Wed, 24 Sep 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702046; cv=none; b=RwEZ6DfhHQ4Hb3/BAo8R+16TMWLO4C97GrnzmOLsp5ETjYNbIslN9z6RZI5hvp7ciryunfa2lyxk/WRuZr4qyR5QgnhwqVN4RzoAXmE+V+NUizC/HjE/fF9v/nFtdn+vd1MM50Phl2neSGjykU0HHJXT0jannsnkb6fREjTpHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702046; c=relaxed/simple;
	bh=OMVgMraFH2BxIgIwSSNP58DDxZoVjL8AimA5niTsHMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt/cCah9p9ltvsIslZcZYdKfHTEzz00zCyl6wZlInaQHGueWOCMlADLIfrjeo+NexnfWRn/mRzfbA50PiTZua76AdmVe5ArB+mTWtdDzeuY2LO9eQh9PoYAbytidMc+/hh/KTcoOwsivsVGQsNTImy6cG42Ap9RRifrN87iqWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/2jcezO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9901EC4CEE7;
	Wed, 24 Sep 2025 08:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758702046;
	bh=OMVgMraFH2BxIgIwSSNP58DDxZoVjL8AimA5niTsHMQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=I/2jcezO8WKzYNvURUI9PkJH5jEF2WQWuNxspv/8Q8LCn4x+sOGPLqqLoV5k7yMmD
	 YEzHXKWZU6p5EyHI+LznjgFNY4/zaavnmXbA0HTkHFmGnVn01iTShvfgJihVaYyP2W
	 tGBZ4TVMfqx9RgMGUSMuL7Da7FXRX7FKDlcytmpopp5vpLVidz/haY6anElC/SbBkP
	 UZ9npSyxcbaMtWbtFThgpJsxLD273YE9y8aA5HJZW43d4mXE+8WK2QLJOAfFMMrolm
	 yw0kr1qiQjkhLEKGxKGnWMFGG9gVqu2YrGLrLeuSHSba0JtnynrD+P7TQA75OCinsK
	 LND0PhRzD+/Jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3B75CE0B73; Wed, 24 Sep 2025 01:20:41 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:20:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/34] Implement RCU Tasks Trace in terms of SRCU-fast and
 optimize
Message-ID: <1b362ccc-fa86-404c-ab58-15370cef7240@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <CAADnVQKNxGFOWN7-HmzObYobW2y33g-i3xsNSkKicx88hqe70w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKNxGFOWN7-HmzObYobW2y33g-i3xsNSkKicx88hqe70w@mail.gmail.com>

On Wed, Sep 24, 2025 at 09:49:23AM +0200, Alexei Starovoitov wrote:
> On Tue, Sep 23, 2025 at 4:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > This series re-implements RCU Tasks Trace in terms of SRCU-fast,
> > reducing the size of the Linux-kernel RCU implementation by several
> > hundred lines of code.  It also removes a conditional branch from the
> > srcu_read_lock_fast() implementation in order to make SRCU-fast a
> > bit more fastpath-friendly.  The patches are as follows:
> >
> > 1.      Re-implement RCU Tasks Trace in terms of SRCU-fast.
> >
> > 2.      Remove unused ->trc_ipi_to_cpu and ->trc_blkd_cpu from
> >         task_struct.
> >
> > 3.      Remove ->trc_blkd_node from task_struct.
> >
> > 4.      Remove ->trc_holdout_list from task_struct.
> >
> > 5.      Remove rcu_tasks_trace_qs() and the functions that it calls.
> >
> > 6.      context_tracking: Remove
> >         rcu_task_trace_heavyweight_{enter,exit}().
> >
> > 7.      Remove ->trc_reader_special from task_struct.
> >
> > 8.      Remove now-empty RCU Tasks Trace functions and calls to them.
> >
> > 9.      Remove unused rcu_tasks_trace_lazy_ms and trc_stall_chk_rdr
> >         struct.
> >
> > 10.     Remove now-empty show_rcu_tasks_trace_gp_kthread() function.
> >
> > 11.     Remove now-empty rcu_tasks_trace_get_gp_data() function.
> >
> > 12.     Remove now-empty rcu_tasks_trace_torture_stats_print() function.
> >
> > 13.     Remove now-empty get_rcu_tasks_trace_gp_kthread() function.
> >
> > 14.     Move rcu_tasks_trace_srcu_struct out of #ifdef
> >         CONFIG_TASKS_RCU_GENERIC.
> >
> > 15.     Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs.
> >
> > 16.     Remove now-unused rcu_task_ipi_delay and TASKS_TRACE_RCU_READ_MB.
> >
> > 17.     Create a DEFINE_SRCU_FAST().
> >
> > 18.     Use smp_mb() only when necessary in RCU Tasks Trace readers.
> >
> > 19.     Update Requirements.rst for RCU Tasks Trace.
> >
> > 20.     Deprecate rcu_read_{,un}lock_trace().
> >
> > 21.     Mark diagnostic functions as notrace.
> >
> > 22.     Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.
> >
> > 23.     Create an srcu_expedite_current() function.
> >
> > 24.     Test srcu_expedite_current().
> >
> > 25.     Create an rcu_tasks_trace_expedite_current() function.
> >
> > 26.     Test rcu_tasks_trace_expedite_current().
> >
> > 27.     Make DEFINE_SRCU_FAST() available to modules.
> >
> > 28.     Make SRCU-fast available to heap srcu_struct structures.
> >
> > 29.     Make grace-period determination use ssp->srcu_reader_flavor.
> >
> > 30.     Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().
> >
> > 31.     Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().
> >
> > 32.     Require special srcu_struct define/init for SRCU-fast readers.
> >
> > 33.     Make SRCU-fast readers enforce use of SRCU-fast definition/init.
> >
> > 34.     Update for SRCU-fast definitions and initialization.
> 
> Maybe it's just me, but the patch set is too fine grained.
> These 34 patches could be squashed into a handful for better
> review. All these steps: add smp_mb(), make it conditional,
> make it more conditional, remove one field,
> remove another field is a distraction from actual logic at the end.

Fair enough!

I was quite distracted while doing this work, so did it in baby steps to
avoid having to do any sort of complex debugging.  My plan is to continue
testing it, and if the tests continue passing, restructure the patch
series, then send v2.  You are quite right, and I will (for example)
consolidate the "Remove" patches.  And at that point, the "squash"
feature of "git rebase" will be my friend.  ;-)

							Thanx, Paul

