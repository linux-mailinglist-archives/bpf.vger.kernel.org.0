Return-Path: <bpf+bounces-31272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093868FA634
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 01:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348BE1C22061
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1513CABC;
	Mon,  3 Jun 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2HQh+OK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD482D9C;
	Mon,  3 Jun 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456144; cv=none; b=CDOSLoVJkqym3iowgQeN1vZXbQqgHS81RZPn0aMc8csb8MZP77h+/io4t5rrZ4vaSlrUp9UpCbOBfFG6zSqUfhJSfOvas3ofQnS9eQG6YT8OOLUZBoM+vL1QNWBAS7Yft3twjCa4fdR5WMuDn3YYja/S9pgcb5lcmcgt03K8aNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456144; c=relaxed/simple;
	bh=TkGrcacicUpf19NCeKE9v06+R11FzRDylFAvCUhQn8g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XjWSaje5lBwWTWguSAgjjaswY785nooKc8Ocm+VPw/CO08AImUgnkAlP8ov2kXvVq/MiZGn4EOw4OK16XBTWILIEBpP2oIyTtzW4IwtcP/YT3tz9qoY+B9NikiphDdbUmTyyE/CbIZAUFaiBiJB6fSbUhw8lXz8O+n3Tg1c2+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2HQh+OK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1B1C2BD10;
	Mon,  3 Jun 2024 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456143;
	bh=TkGrcacicUpf19NCeKE9v06+R11FzRDylFAvCUhQn8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P2HQh+OKV93phMVsrP7ajqPOu8NfBDjSsGVzBJ+bbC3qW7hdgzdABzrqXgJnkcYjZ
	 4lQxkbQQC46IKdaEYdA15eSXciAGQgO67eLQznVKHAEUhYoAsEHZoUkqi8DFJhNJ8h
	 qwRbXstS89bkkpVW/L5wuj/re6lXbZahODUvcRA0EW7x/5jLtRDVb77wGV1/7wCyzX
	 LiQFegSuuaraJuuMLa5rQ1tZyVWGMKHT0SAwi6uYEyBPVrqbQ9YPUbSJlfGX+HppPq
	 7iHqONwGSHHmv6lSNcIIvlWbTjZR36H/7raUcO24hEp+ECWMD6g3SoJS5gTP8mcVRd
	 Dtx41+2/ayMAw==
Date: Tue, 4 Jun 2024 08:08:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2 24/27] function_graph: Use static_call and branch to
 optimize entry function
Message-Id: <20240604080856.907194a1fc3106be0cc94fa0@kernel.org>
In-Reply-To: <20240603110752.6b722aac@gandalf.local.home>
References: <20240602033744.563858532@goodmis.org>
	<20240602033834.997761817@goodmis.org>
	<20240603121107.42f98858ebb790805f75c9b1@kernel.org>
	<20240603110018.1cdd6746@gandalf.local.home>
	<20240603110752.6b722aac@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 11:07:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 3 Jun 2024 11:00:18 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Yes, but that gets a bit complex, and requires the changing of all archs.
> > If it starts to become a problem, I rather add that as a feature. That is,
> > we can always go back to it. But for now, lets keep the complexity down.
> 
> And if we were to go the route of calling a single fgraph_ops caller, I
> would want it choreographed with ftrace, such that the direct caller calls
> a different fgraph function only if it has only one graph caller on it and
> the fgraph loop function if a function has more than one. Just like the
> ftrace code does.
> 
> If we are going to go that route, let's do it right.

Yes, that is what I expect. ftrace_ops has a callback for loop and subops
has another direct callbacks, and the ftrace_ops has a flag to direct subops
assign. In this case ftrace will assign the subops's direct callback for
single subops entries.

But anyway, this optimization can be done afterwards. Especially this feature
is important for fprobes on fgraph, until that, the current implementation is
enough.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

