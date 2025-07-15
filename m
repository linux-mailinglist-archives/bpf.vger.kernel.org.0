Return-Path: <bpf+bounces-63309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1425B055EB
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 11:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8087AB30E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB73B2D5423;
	Tue, 15 Jul 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WCEmIKao"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0A23C8C7;
	Tue, 15 Jul 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570612; cv=none; b=DwJFLksVbYSAKlm/BoHdoY8tAnHAyy7qIOpqi/mc70EXMJcxcP1eN29jDbrZg+lq7hDOsRbSuHdpdkB0pqMi1rJ75J10gZgyuNkVRJpnLBiKGZqnFywb41rxy+asHaRKPAdo8I+/FB6KvKL79eSq8c1URhde6SCHai9a+aNxt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570612; c=relaxed/simple;
	bh=qLrKfX0ZBO8alZEOE65+uBiUUrqvs2pz0+3KbaN7E00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9Jm2T95rVfPu8Qa4LEobyIr9HNW1tpoVboFwus9WBvDfytAD5PeTNdgYjRBPMRW8NvKrFK8a2+DSRFYnYST0HldymKBExi/mHdLzRLm7zkqrPksw/kQ7waI52gUbprpkV1TU+oUolCzTugAeakZuMZcggSwTaUQUxQKldQ8v3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WCEmIKao; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=01rNQb63ptE9QSTfqmkP9iEp/OrX4ZghKbDPnKTvdzc=; b=WCEmIKaoclUOlMvqahdyT9LUks
	8lhhpOM5gIeKV76LuQN135e0mX9T8h40f+Oyy3QGI8Ov8ZCWXnZH+PVEaiX9+zvuN5fRJLjfVghN5
	TFFaiCiGkSWFFiO16lQEuw48JKFNesJYsll64UDY0mQmdp/5N0z5IL5BaKmVGJsV0uxFIDHj+n5X/
	oMlrP9HiB3P34CmxG84vQETOda26wXKrxgNRLP6G8y5wp3kfcj6f21VNicxKy1odNNGe/G3PW/EdY
	0nd1l5YFRWqGu7mOq4DhHhgc/6Wc1j5se2KDRCzuMilQpMdlgmTgTmdlkCllSbQdKFZHbY1mOvVnL
	SCbbX8fw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubbfg-00000009rR1-3Hmu;
	Tue, 15 Jul 2025 09:09:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 984B33001AA; Tue, 15 Jul 2025 11:09:55 +0200 (CEST)
Date: Tue, 15 Jul 2025 11:09:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250715090955.GP1613200@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012358.831631671@kernel.org>
 <20250714132936.GB4105545@noisy.programming.kicks-ass.net>
 <20250714101919.1ea7f323@batman.local.home>
 <20250714150516.GE4105545@noisy.programming.kicks-ass.net>
 <20250714111158.41219a86@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714111158.41219a86@batman.local.home>

On Mon, Jul 14, 2025 at 11:11:58AM -0400, Steven Rostedt wrote:
> On Mon, 14 Jul 2025 17:05:16 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Urgh; so I hate reviewing code you're ripping out in the next patch :-(
> 
> Sorry. It just happened to be developed that way. Patch 10 came about
> to fix a bug that was triggered with the current method.

Sure; but then you rework the series such that the bug never happened
and reviewers don't go insane from the back and forth and possibly
stumbling over the same bug you then fix later.

You should know this.

I'm going to not stare at email for some 3 weeks soon; I strongly
suggest you take this time to fix up this series to not suffer nonsense
like this.



