Return-Path: <bpf+bounces-48786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2BDA10A4A
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 16:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC50C3A28F7
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B215A843;
	Tue, 14 Jan 2025 15:05:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A21157485;
	Tue, 14 Jan 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867154; cv=none; b=V2azyBfv6dkH7bM0POdLVyXtsw7jOV3hrJ2WjUQXLwhF5MWWMI1pPcTmdzzKsLT94cwv3OyBZ0d2+DTkp4135WcgOrp05AZK44owXB0FoSQTq8znUkZBN8CGteR3QbQTEijBPckFCgTI60yP7iIzHiytuffbcopFeZPved05VK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867154; c=relaxed/simple;
	bh=+jqnW9djanRisFz6+BHjrC/L/SpcxdAgs3fjocY/Vjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lhh3Ix1nhHWYQ2P16BScR33MLRTIJOYoWvlOanVe8qfJWikK/S7XrmafTueEhqaBtonbceA0o+pZMFrXgXF6jMwpJbag9wydMy/dtdZDU9daZ0Ox94nJ87fvIE3nabMGbz7AQck3tKVGkrZnj/NRG6ZVN2qsl6/4svztS/RKMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578B9C4CEE3;
	Tue, 14 Jan 2025 15:05:52 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:05:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: Move trace_clock_local() for return time to
 function_graph tracer
Message-ID: <20250114100552.21b28c99@gandalf.local.home>
In-Reply-To: <20250114101806.b2778cb01f34f5be9d23ad98@kernel.org>
References: <Z3aSuql3fnXMVMoM@krava>
	<173665959558.1629214.16724136597211810729.stgit@devnote2>
	<20250113195449.72ab5d81@gandalf.local.home>
	<20250114101806.b2778cb01f34f5be9d23ad98@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 10:18:06 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I'd rather just nuke the calltime and rettime from struct ftrace_graph_ret.  
> 
> Yeah, this one is good to me. But this will make a slightly different time
> for the same function when we enable multiple function graph tracer on
> different instances (mine records it once and reuse it but this will record
> on each instance). We may need to notice it on the document. :)

And I believe it's separate for each instance now anyway, so I was going to
send this to Linus as well:

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 272464bb7c60..2b74f96d09d5 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -810,6 +810,12 @@ Here is the list of current tracers that may be configured.
 	to draw a graph of function calls similar to C code
 	source.
 
+	Note that the function graph calculates the timings of when the
+	function starts and returns internally and for each instance. If
+	there are two instances that run function graph tracer and traces
+	the same functions, the length of the timings may be slightly off as
+	each read the timestamp separately and not at the same time.
+
   "blk"
 
 	The block tracer. The tracer used by the blktrace user


> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

-- Steve


