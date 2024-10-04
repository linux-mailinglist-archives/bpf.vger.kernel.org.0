Return-Path: <bpf+bounces-40891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DE998FB76
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA600B22738
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0ED51E;
	Fri,  4 Oct 2024 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brQBChuy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6EA955;
	Fri,  4 Oct 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001051; cv=none; b=CpeUPamGCnMaVD+YRb+xAyoqlKXIvYKScIFsEsjs6cZT4rBSdVkk0eSzTpF03Y6aDOe8iv/MtaZJg/pVe9q2b57VckRbvq2QaLYmu77eQg12nNEGagqF2+L5+AhG4GgtFtGFukU/T2UA6YL7YDuZCQ+8qzDn0LhR860bvh54/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001051; c=relaxed/simple;
	bh=uAQH/D0FoMoHKemDrU0RQ8iSL3VlPrfdWfV8B4knhOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnPIsbQrfa9tlejWRpEA2H4SREGgUnnXlbJCFndknzgXvHSyGC9NFxTYmqJ4VWfehbOcOB4zZnoCNNx9phgNJMx8j15CjSshBym8kqoNRAxInKTOdKmXNINdPvBGAfrPy+ywRHYPC3gLE4HHzi9cuKr8mcmb9gLjKvcNR5wWukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brQBChuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC767C4CEC7;
	Fri,  4 Oct 2024 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728001051;
	bh=uAQH/D0FoMoHKemDrU0RQ8iSL3VlPrfdWfV8B4knhOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brQBChuyDFc3VHRJwHwg2QNSsol7E9ZDmiPX7KKc0uuT1H7XjaCbe2kMw16BqLJNK
	 dLll9aqx5H+RxbCr/b00H6zSoo7+H0e0bsHq0BqzClEZ4iNROycpOSRnNaOxTedlsF
	 Xxxrzx6r1CdjoGTHwvtjPFUjFx6X2bZvKdeg9q8V/ZY3vCIYC24GN16BKs1FLzUbPx
	 q2KrQAzQEEdpEeSGHuA6nFKDl2bAHhox8bw4Cv7X+gpdjz8eQey9DA1WwxRnFRQ5vm
	 pjcpFLHD/34X8G8FJKzBi7XNyhaI/+7hrtz6hiUnaZrGdfdHovpjka/55UyXwCqVmh
	 P+6f9JkJGdFRg==
Date: Fri, 4 Oct 2024 02:17:28 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>,
	Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v1 3/8] tracing/perf: guard syscall probe with
 preempt_notrace
Message-ID: <Zv80GJWwUVwPwvgf@pavilion.home>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-4-mathieu.desnoyers@efficios.com>
 <20241003182508.6ca76abc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003182508.6ca76abc@gandalf.local.home>

Le Thu, Oct 03, 2024 at 06:25:08PM -0400, Steven Rostedt a écrit :
> On Thu,  3 Oct 2024 11:16:33 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > In preparation for allowing system call enter/exit instrumentation to
> > handle page faults, make sure that perf can handle this change by
> > explicitly disabling preemption within the perf system call tracepoint
> > probes to respect the current expectations within perf ring buffer code.
> > 
> > This change does not yet allow perf to take page faults per se within
> > its probe, but allows its existing probes to adapt to the upcoming
> > change.
> 
> Frederic,
> 
> Does the perf ring buffer expect preemption to be disabled when used?
> 
> In other words, is this patch needed?

At least the trace events perf callback requires that because it uses
a per cpu buffer (see perf_trace_buf_alloc()).

Thanks.

