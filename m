Return-Path: <bpf+bounces-21937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98185414F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F801F22A97
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA8566D;
	Wed, 14 Feb 2024 01:40:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741772563;
	Wed, 14 Feb 2024 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874851; cv=none; b=NTAp4vwROsyZ9ny1DkAVQMHR4qPRrDtR+fCupUeTLFwg/6MWQGG96Jupzd36A3lnom2eo400Ha0zHRVK+3b9NdHY3tgXId/GUwJ+t+2eFdgnCwRcyGmcUH9yL7dwYfzIcI5JKIAT+GKSfQxxiRCSrBG4Hs/qSv/gHsWV1+uREt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874851; c=relaxed/simple;
	bh=g3TFwkiBMAVIaASrpmNEdFi6d151GFSpVImlNWOWpKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9L2S97MnbBzkR3Tr0TVZ2lyqKQfMz0swxQ7lHRoggdM2nO1Mb4isEWu+4kj77mx8iw50X8zneYxwW6lgEV6aHE/JO0N5v1Me508l0WC9HPhfKTHWWClJ1FgHfNg5KuoVFHdHI/vY2qBsev8WyK/2iL/f0SIOuOX9cNCnQ/DRBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB03C433F1;
	Wed, 14 Feb 2024 01:40:49 +0000 (UTC)
Date: Tue, 13 Feb 2024 20:42:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20240213204218.0673fbb0@gandalf.local.home>
In-Reply-To: <170723216124.502590.13855631208872523552.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723216124.502590.13855631208872523552.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:09:21 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Pass the fgraph_ops structure to the function graph callbacks. This will
> allow callbacks to add a descriptor to a fgraph_ops private field that wil
> be added in the future and use it for the callbacks. This will be useful
> when more than one callback can be registered to the function graph tracer.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - cleanup to set argument name on function prototype.
> ---
>

This patch fails to compile without this change:

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index e35a941a5af3..47b461b1cf7e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -381,7 +381,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		if (gops == &fgraph_stub)
 			continue;
 
-		if (gops->entryfunc(&trace))
+		if (gops->entryfunc(&trace, gops))
 			bitmap |= BIT(i);
 	}
 


-- Steve

