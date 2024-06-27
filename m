Return-Path: <bpf+bounces-33214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56180919CF0
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 03:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3F0284390
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 01:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CC0291E;
	Thu, 27 Jun 2024 01:24:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E5A3D;
	Thu, 27 Jun 2024 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719451495; cv=none; b=j29R6V5/WLLJt0i048y6usAUyo/b7/L1btSiYSy1k81MePBEImmpJY93DXu2uFK2aQIKRBE9xWuihadzjGzs0SX1MvtS3V9IZXNpjT5Cln8wwXIYP3wb7Tug5TKlUAM9HkEBkI3ufEQdYMlri9kdnXe/eiqLOZQvzAVlOm1Cmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719451495; c=relaxed/simple;
	bh=eCcW2No5XbxILKW+EWUGDLfrqWLS2anbMyb+KdL1Ljg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fq1F9Cwn3XdYV7EB5rm0TThT3FRm9Dgdhrs8poOFhHr49UsL1oNP5gfkjH9S+qRn8d17ugX4v308qcnaHszIg4tyNIk8A52OVxK+RaeR8WsnquoFTLws6quw7vzz5G76ymXz0OowKFeaQMva7eB5OOoOZOmglt1Fv+YPPU1QYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EA8C116B1;
	Thu, 27 Jun 2024 01:24:53 +0000 (UTC)
Date: Wed, 26 Jun 2024 21:25:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, Joel Fernandes
 <joel@joelfernandes.org>
Subject: Re: [PATCH v5 0/8] Faultable Tracepoints
Message-ID: <20240626212543.7565162d@gandalf.local.home>
In-Reply-To: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
References: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 14:59:33 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Wire up the system call tracepoints with Tasks Trace RCU to allow
> the ftrace, perf, and eBPF tracers to handle page faults.
> 
> This series does the initial wire-up allowing tracers to handle page
> faults, but leaves out the actual handling of said page faults as future
> work.
> 
> I have tested this against a feature branch of lttng-modules which
> implements handling of page faults for the filename argument of the
> openat(2) system call.
> 
> This v5 addresses comments from the previous round of review [1].

Hi Mathieu,

Can you resend this and Cc linux-trace-kernel@vger.kernel.org?

That would put it into our patchwork and makes it work with our workflow.

 https://patchwork.kernel.org/project/linux-trace-kernel/list/

Thanks,

-- Steve


> 
> Steven Rostedt suggested separating tracepoints into two separate
> sections. It is unclear how that approach would prove to be an
> improvement over the currently proposed approach, so those changes were
> not incorporated. See [2] for my detailed reply.
> 
> In the previous round, Peter Zijlstra suggested use of SRCU rather than
> Tasks Trace RCU. See my reply about the distinction between SRCU and
> Tasks Trace RCU [3] and this explanation from Paul E. McKenney about the
> purpose of Tasks Trace RCU [4].
> 
> The macros DEFINE_INACTIVE_GUARD and activate_guard are added to
> cleanup.h for use in the __DO_TRACE() macro. Those appear to be more
> flexible than the guard_if() proposed by Peter Zijlstra in the previous
> round of review [5].
> 
> This series is based on kernel v6.9.6.

