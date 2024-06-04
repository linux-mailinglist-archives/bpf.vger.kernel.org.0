Return-Path: <bpf+bounces-31356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 159528FB9CC
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AC0B218F7
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B451494DC;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BE148820;
	Tue,  4 Jun 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520681; cv=none; b=r8bqTlEBFKhzSSXM8AZkYrPxj5ovu/40viMo8/Oiwt/PPGa4KchaLg60ZCclPpnd/tppmKGYeVycD9FnM4uG1J4DXXiwsVMTth0y/yHOIq0KDjDCVk3u3LJFVlpBerz6YITnznKwGXSM1rBsKn+xMX38h2rhYN0qpLzDo1eFlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520681; c=relaxed/simple;
	bh=LJWf3QoCZ3rFmQ9GULoPGURQSMideMDjJ/XO70462sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGJYTcz74XgEfSssw39Ku0oGib9go4QCtvpTyj8prFosoFlmQJ/5bsrxBS9F3bgVD8tIuIvZLITUbBt5noj7/w0lk+Vx84ZhkPRtYPfNo/+ZEZ6qp+DY9Gjutd+kleRBb6BQyrJ4B8QjpoCRTtj+7MmCCWpGKwuec2rTNS8ccaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F64C1042;
	Tue,  4 Jun 2024 10:04:55 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 097E53F762;
	Tue,  4 Jun 2024 10:04:27 -0700 (PDT)
Date: Tue, 4 Jun 2024 18:04:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Florent Revest <revest@chromium.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 00/27] function_graph: Allow multiple users for
 function graph tracing
Message-ID: <Zl9JFnzKGuUM10X2@J2N7QTR9R3>
References: <20240603190704.663840775@goodmis.org>
 <20240604081850.59267aa9@rorschach.local.home>
 <Zl8oWNhkEPleJ3B_@J2N7QTR9R3>
 <20240604123124.456d19cf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604123124.456d19cf@gandalf.local.home>

On Tue, Jun 04, 2024 at 12:31:24PM -0400, Steven Rostedt wrote:
> On Tue, 4 Jun 2024 15:44:40 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Hi Steve, Masami,
> > 
> > On Tue, Jun 04, 2024 at 08:18:50AM -0400, Steven Rostedt wrote:
> > > 
> > > Masami,
> > > 
> > > This series passed all my tests, are you comfortable with me pushing
> > > them to linux-next?  
> > 
> > As a heads-up (and not to block pushing this into next), I just gave
> > this a spin on arm64 atop v6.10-rc2, and running the selftests I see:
> > 
> > 	ftrace - function pid filters
> > 	(instance)  ftrace - function pid filters
> > 
> > ... both go from [PASS] to [FAIL].
> > 
> > Everything else looks good -- I'll go dig into why that's happening.
> > 
> > It's possible that's just something odd with the filesystem I'm using
> > (e.g. the wnership test failed because this lacks 'stat').
> 
> Thanks for the update. I could be something I missed in patch 13 that had
> to put back the pid code.
> 
> There may have been something arch specific that I'm unaware about. I'll
> look at that deeper.

It looks like e are lines in the trace that it doesn't expect:

	+ cat trace
	+ grep -v ^#
	+ grep 970
	+ wc -l
	+ count_pid=0
	+ cat trace
	+ grep -v ^#
	+ grep -v 970
	+ wc -l
	+ count_other=3
	+ [ 0 -eq 0 -o 3 -ne 0 ]
	+ fail PID filtering not working?

... where we expect that count_other to be 0.

I hacked in a 'cat trace' just before the 'fail' and that shows:

	+ cat trace
	# tracer: function_graph
	#
	# CPU  DURATION                  FUNCTION CALLS
	# |     |   |                     |   |   |   |
	 3) ! 143.685 us  |  kernel_clone();
	 3) ! 127.055 us  |  kernel_clone();
	 1) ! 127.170 us  |  kernel_clone();
	 3) ! 126.840 us  |  kernel_clone();

I'm not sure if that's legitimate output the test is failing to account
for or if that indicates a kernel-side issue.

Mark.

