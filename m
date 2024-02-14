Return-Path: <bpf+bounces-21969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9AA854A7D
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 14:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF09281DE0
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D795E54745;
	Wed, 14 Feb 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKyYENnD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02429437;
	Wed, 14 Feb 2024 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917293; cv=none; b=cTCXfJGaFy3U5Na88XpRIJvhcPwHThoMZ2zklPbZu10TII9D1bNqFbIXX5eHIiBsgrQ6OGZyrYQa4XURUimiseFQgl8XK1U43JItt/dNIP8J7vUW2os3Y/R0dX00b7Cy0NxuCmo/bSWS6e/VV90+QR0DqWlZG6Ip5oQW2P5a/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917293; c=relaxed/simple;
	bh=dr4fZY5Udf3n038yhYLKk5netrjQQ8WRTOzQbrzRkN0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u1lnbzRAYwDFeshH4lVK2x/QYMKgORntMUxDmZXI5H8uNPtnB5QTblpw/nsq7GCe08CVbgptWxtB+pEfZD1VplCI7yqbi2Shr7xZ2/fRBUbLHbS35yuvCdUL3wNkcCFdkqU6TFIBCWkYCxlW3JH2YHGscYE8Jt+qtan+pVRs1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKyYENnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC5DC433C7;
	Wed, 14 Feb 2024 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707917292;
	bh=dr4fZY5Udf3n038yhYLKk5netrjQQ8WRTOzQbrzRkN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iKyYENnDmyT7TVOrWZ0E6ri4G6N+j6LRxKcG4JKbe95j6S1iSABYaXNkelw41t0Lz
	 4mcjPsXhAG/kX6LMBrjKSpzFXQnK7G8Ud93esV1p6C2Ik/q8Nb6GhlG9g8SkkC9u3N
	 C8MmXPHqMpaCBDf/Cb82cFU43Sy/noljjun5SNW6znjuu887+1bPy1Bf+fG7w1pejO
	 7i4vrSR/WhqSOIEo05C/pu+qOp0cUVYv6bCLlclcEDeuHx2eeNvP+g9zDyWKsdDmJe
	 9i2rRyUoEXCrVqiUVY8ojubWx35cS35mvWT6EQckvlnCDfbIkhljOdubqQuffqEyp8
	 egkIQIvtd/SIA==
Date: Wed, 14 Feb 2024 22:28:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 10/36] ftrace/function_graph: Pass fgraph_ops to
 function graph callbacks
Message-Id: <20240214222806.0eaf984d4e56f791a3e1a697@kernel.org>
In-Reply-To: <20240213204218.0673fbb0@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723216124.502590.13855631208872523552.stgit@devnote2>
	<20240213204218.0673fbb0@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 20:42:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:09:21 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Pass the fgraph_ops structure to the function graph callbacks. This will
> > allow callbacks to add a descriptor to a fgraph_ops private field that wil
> > be added in the future and use it for the callbacks. This will be useful
> > when more than one callback can be registered to the function graph tracer.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - cleanup to set argument name on function prototype.
> > ---
> >
> 
> This patch fails to compile without this change:

Thanks for pointing it out! Let me fix this in next version.

> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index e35a941a5af3..47b461b1cf7e 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -381,7 +381,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  		if (gops == &fgraph_stub)
>  			continue;
>  
> -		if (gops->entryfunc(&trace))
> +		if (gops->entryfunc(&trace, gops))
>  			bitmap |= BIT(i);
>  	}
>  
> 
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

