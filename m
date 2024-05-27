Return-Path: <bpf+bounces-30623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE63C8CF703
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 02:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A5528178D
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 00:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D41373;
	Mon, 27 May 2024 00:32:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B0D523A;
	Mon, 27 May 2024 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769949; cv=none; b=ifWRh6tbRZD5GjnoZdodA3G8KmKo8/fgEH74fJ/Uyn2HdRZ9XnkNlPYKop6SO5bfO5lAGmtLGdN0hFtrsY87AjEX0Js4Ht9OQ3YA5Bofg2bVUkdaEV0vz7FT+fQ2kwrMQgbg3v2oVNqGkN/bTb3VzQgP8WZ3eEsAjwDrKTy9fPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769949; c=relaxed/simple;
	bh=8MPxdnHDEqNTjqYvWyVS11UPBlj8FeTQeXxpXQJDEow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLNOtyZW8K5IqKVfq/IPOql6dLzjVXR7hj5pkzHyAz6eGLHkm951a8SujHZZM6nCQuLSL3Lxd0uh9mjnZQhCaYR+PYt23hlHvC1vwHU9+7CKU1f7/HVzo7cXzIRikaLXAGF6hS4/vL7RQdXoNcTmDFGuNu4QbSYPMcpnbZK3ht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBB3C2BD10;
	Mon, 27 May 2024 00:32:26 +0000 (UTC)
Date: Sun, 26 May 2024 20:33:18 -0400
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
Subject: Re: [PATCH 20/20] function_graph: Use bitmask to loop on fgraph
 entry
Message-ID: <20240526203318.01ee176e@gandalf.local.home>
In-Reply-To: <20240527090949.70151ecb2e7d98d4f284c2c8@kernel.org>
References: <20240525023652.903909489@goodmis.org>
	<20240525023744.390040466@goodmis.org>
	<20240527090949.70151ecb2e7d98d4f284c2c8@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 09:09:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Note, we do not care about races. If a bit is set before the gops is
> > assigned, it only wastes time looking at the element and ignoring it (as
> > it did before this bitmask is added).  
> 
> This is OK because anyway we check gops == &fgraph_stub.
> By the way, shouldn't we also make "if (gops == &fgraph_stub)"
> check unlikely()?

Yeah, I'll add the unlikely() here too.

> 
> This change looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks for the review Masami!

-- Steve


