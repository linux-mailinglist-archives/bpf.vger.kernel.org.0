Return-Path: <bpf+bounces-31206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066AD8D85BE
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D5B282D33
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3799B12D75A;
	Mon,  3 Jun 2024 15:06:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F76B65F;
	Mon,  3 Jun 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427204; cv=none; b=bIK3OLEV29eTIuTrqnx/TGlQWZsWHSxKWcT2a98WaNMMAi2+pRWmx4O5yqvxB/rcCyyV7IEXHLils9hDrwMqFJB/0+v1VN/uuKgYafBPjYYpqFlCmVhmWTN/7mmQCcByF4ECr4mWjJujYPNKmIziOeyBCiaecLgXBpcxL2Q1fZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427204; c=relaxed/simple;
	bh=iUbp+NolNrOyeGaLe38w93IfAyLn+xoITcXsa+1tWFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsObjngHzkVN2KmG9jXos8dyUkh1Nw4ETMTC+R5HSiegZO97iWVygsVKgmGJa+nyuzp2jioOipC/PS76wo1y9nxqD2v6eMAs9ZBVYA0m45rPuRCnXA2Nkjd0xmqsEpa22ArkT5Q307GbQLJ6d9tr3cSZ4zL8b7p3EDyEKVHtDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78388C2BD10;
	Mon,  3 Jun 2024 15:06:42 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:07:52 -0400
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
Subject: Re: [PATCH v2 24/27] function_graph: Use static_call and branch to
 optimize entry function
Message-ID: <20240603110752.6b722aac@gandalf.local.home>
In-Reply-To: <20240603110018.1cdd6746@gandalf.local.home>
References: <20240602033744.563858532@goodmis.org>
	<20240602033834.997761817@goodmis.org>
	<20240603121107.42f98858ebb790805f75c9b1@kernel.org>
	<20240603110018.1cdd6746@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 11:00:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yes, but that gets a bit complex, and requires the changing of all archs.
> If it starts to become a problem, I rather add that as a feature. That is,
> we can always go back to it. But for now, lets keep the complexity down.

And if we were to go the route of calling a single fgraph_ops caller, I
would want it choreographed with ftrace, such that the direct caller calls
a different fgraph function only if it has only one graph caller on it and
the fgraph loop function if a function has more than one. Just like the
ftrace code does.

If we are going to go that route, let's do it right.

-- Steve

