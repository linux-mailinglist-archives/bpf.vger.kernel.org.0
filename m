Return-Path: <bpf+bounces-31096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7928D71A9
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 21:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5991F21A2B
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C6154C0C;
	Sat,  1 Jun 2024 19:20:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15D107A8;
	Sat,  1 Jun 2024 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717269612; cv=none; b=pZwPdF6mQLSSTAvuaEJEqLD7guK3WHTjfTE8ZIB3KTuqjGpihOqm5FrZ1je/cgYXI2SDHqYyYOPMfFWWDdhgbqd3O+QLyq5K1lAHeycSIH5Ek9SjZ98ltJF5DXZ9U0vBvZLa2Nc/05OI02U2bHkIWNKoICfs7C8l/OSv7O5uxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717269612; c=relaxed/simple;
	bh=VtvvQRnojTkqiM1zgn/KlGPwPVedGSGuzqrusnbIl/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJpjKtbyrSjrFZH7zw5WzMkEqLLlHaXvVeKpcIFmQLowDSmSzwHTQzwIfe2LxHZOqJzQxPLElSzwFSte3nB8xJMWIu6TGkGkpuTPYR6Nxvok6+T+gr1kklqcALNSMc4wNaJLOlyxJm+6ICo61OmrE7Czo8GsbhHgFJXqRFRKOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B30C116B1;
	Sat,  1 Jun 2024 19:20:06 +0000 (UTC)
Date: Sat, 1 Jun 2024 15:19:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Subject: Re: [PATCH 10/20] function_graph: Have the instances use their own
 ftrace_ops for filtering
Message-ID: <20240601151934.249a573c@rorschach.local.home>
In-Reply-To: <20240531184910.799635e8@rorschach.local.home>
References: <20240525023652.903909489@goodmis.org>
	<20240525023742.786834257@goodmis.org>
	<20240530223057.21c2a779@rorschach.local.home>
	<20240531121241.c586189caad8d31d597f614d@kernel.org>
	<20240531020346.6c13e2d4@rorschach.local.home>
	<20240531235023.a0b2b207362eba2f8b5c16f7@kernel.org>
	<20240531184910.799635e8@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 18:49:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm just cleaning it up. I'll post it tomorrow (your today).

It's going to take a little longer. I found that the rewrite broke
updating the filters while tracing is enabled. Working on fixing that
now.

-- Steve

