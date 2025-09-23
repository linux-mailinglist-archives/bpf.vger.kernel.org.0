Return-Path: <bpf+bounces-69492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDEBB97C7E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 01:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622963A4EC0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 23:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541C30FF29;
	Tue, 23 Sep 2025 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2Qew5BK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883830FC18;
	Tue, 23 Sep 2025 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668846; cv=none; b=ZL+DoOZBPLCeHlXYJbuN4XN1/Rd2MrCt7hrwlvWE9GHxA5KaHK1icfaYJkRFWfEVWnTdjq1fyic7q5VD/FzFW+HvyJaTrHeGBFocJNXNL/GUMwUe3J1vTUoO6MUaZeQsUC1sHm8rTijbtmkMMcUK1QcCxBtLIWbhCamliZnjOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668846; c=relaxed/simple;
	bh=/wwR3ED/mCbX9z2pdXihUtvGg8rUhL2CF0R+Fqf4BOw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kjf4hB0P95awsYKWe3g9JG/4cMIcjF85YGQihoSOH91XLMD3icxs9ezEZZhlt0BPoK1hfzcGjcOdF8szZ/e1+xEHKaRCNUAyOdV67LMZRJiQQccGawQz3ZA72CPYCYFdRJTFYRR/5tQtU+aA4C2ukt+jaeyDxyzf/m+QrUT8aj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2Qew5BK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8B6C4CEF5;
	Tue, 23 Sep 2025 23:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758668845;
	bh=/wwR3ED/mCbX9z2pdXihUtvGg8rUhL2CF0R+Fqf4BOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M2Qew5BKPl8vgTTp03c2TFtF+oT/irvjoCzuP/eAyhPGkodlTkPHVdZdDvz755lmg
	 24hUdSdXgalh6pjYWt1ibMEoDcmaD7k3D9iRK4VHawGbxOxACr3B5DDq6KTCi44YCp
	 RDbNBpaB4WB2Q6NyXYS37xJB+ge7+qBH+Ytm3WIZvEp3Mgf5LkohEErrnFZB7VZ5i+
	 QxK1NKsWK8a1kPddgolmtjtFyiDZme/cpouqsWPJqh/O8I2HuV/HfMaHnLfOGFQbLZ
	 d+fcqAG+l7OtcRcyzDCiIqNolzKuJbOQPWQorNA+JsUA5swgo2oxcvjE6yft/axhHY
	 H0HvMBH99z6KQ==
Date: Wed, 24 Sep 2025 08:07:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: fprobe: rename fprobe_entry to
 fprobe_fgraph_entry
Message-Id: <20250924080722.c05ac758a018be619d01b6a9@kernel.org>
In-Reply-To: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 17:20:00 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> The fprobe_entry() is used by fgraph_ops, so rename it to
> fprobe_fgraph_entry to be more distinctive.

Sorry, NAK. fprobe is based on fgraph by design.
So "fprobe_fgraph" sounds redundant.

Thanks,

> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/fprobe.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 6a205903b1ed..1785fba367c9 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -254,8 +254,8 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
>  	return ret;
>  }
>  
> -static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> -			struct ftrace_regs *fregs)
> +static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> +			       struct ftrace_regs *fregs)
>  {
>  	unsigned long *fgraph_data = NULL;
>  	unsigned long func = trace->func;
> @@ -340,7 +340,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;
>  }
> -NOKPROBE_SYMBOL(fprobe_entry);
> +NOKPROBE_SYMBOL(fprobe_fgraph_entry);
>  
>  static void fprobe_return(struct ftrace_graph_ret *trace,
>  			  struct fgraph_ops *gops,
> @@ -379,7 +379,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  NOKPROBE_SYMBOL(fprobe_return);
>  
>  static struct fgraph_ops fprobe_graph_ops = {
> -	.entryfunc	= fprobe_entry,
> +	.entryfunc	= fprobe_fgraph_entry,
>  	.retfunc	= fprobe_return,
>  };
>  static int fprobe_graph_active;
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

