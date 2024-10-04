Return-Path: <bpf+bounces-40897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233198FBCC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E851C22337
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A80E79F0;
	Fri,  4 Oct 2024 01:05:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAF1D5ACD;
	Fri,  4 Oct 2024 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728003944; cv=none; b=TDM2TIklc5lUMsHl8qxp/21OtU1mwlCmqzdB4OZVBe3g40cdsEPggpQ1HD4Pt1AlctGJ2u+i6GClXM6Weuzi0V+AMtPjRXpprqqK8Ei6J6z8rqhtxnJKZ3WvtZYxSrgMY7C094YR3nfnG5SbslAqxky3EKbSx4L6vm+ChO4rGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728003944; c=relaxed/simple;
	bh=mX3uLToDoFu46UosPzth5G2HEDbMZWE9muh0tDcAviU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Noy/OKv8vdN8cNRryvcyhJfSqo7IkxIjYjBcYigCn43eYim/jaOrZiW/jiNXjxLDu3fLPnBzpjksPEq2lrbTYn6kbSWL1nEN6QNHLvv1LQuddX7cpLE2CwMlFNUb9h99w0wlJmJCqASZRSTgfKSxO7mb/dVe/xLVB8uriLmD++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B2EC4CEC7;
	Fri,  4 Oct 2024 01:05:41 +0000 (UTC)
Date: Thu, 3 Oct 2024 21:06:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v1 1/8] tracing: Declare system call tracepoints with
 TRACE_EVENT_SYSCALL
Message-ID: <20241003210636.497cbb61@gandalf.local.home>
In-Reply-To: <ecd8a2fe-22f4-4340-a80b-5bf7ccd74815@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-2-mathieu.desnoyers@efficios.com>
	<20241003173225.7670a4f0@gandalf.local.home>
	<ecd8a2fe-22f4-4340-a80b-5bf7ccd74815@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 20:15:25 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Feel free to rebase on top of this patch:
> > 
> >    https://lore.kernel.org/all/20241003173051.6b178bb3@gandalf.local.home/
> >   
> 
> I will. But you realize that you could have done all this SRCU and
> rcuidle nuking on top of my own series rather than pull the rug
> under my feet and require me to re-do this series again ?

I thought I was doing you a favor! It's removing a lot of code and would
make your code simpler. ;-)

-- Steve

