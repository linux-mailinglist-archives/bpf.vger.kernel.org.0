Return-Path: <bpf+bounces-38244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC87961D38
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 05:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A981C239E6
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B113E023;
	Wed, 28 Aug 2024 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2kWg83G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43D83CDA;
	Wed, 28 Aug 2024 03:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817262; cv=none; b=I8EFS1K8qBpsEVOMyy+BQMv8xME0sW6MBgI9tqha5ynA6hxmLxiBWiZzp26Z0aIomqyNWWVmFy3IQ5oVwiOlf/w5t12PUxKxpLExcuyf+Mv7uhYuJ+19nnh3nkVib/SQWKRNbE6ZSZq02mlwV6Avq9VYNA6q8Pv1C8kjXXhtNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817262; c=relaxed/simple;
	bh=jLwgxlTbmmQa0vkZUtn7hMrKGuSWWsj08lIUB9ZB8KY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FJKzL428LGSt2FMVZm6xV24t6VMjekytcZOnKf2/c5Z/FUwqlRxAsVMqexVVzDkmuCCpHgS9XcRqF6Gh3c5CZrMnX6eTVEQSNmIb39Pfhs4yXzrlSXzlQRUfbMcQwe+LCDcKdXflpF9q+zZqIVeHTlU4SusIxUeR7eG6dNJYmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2kWg83G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A49AC4FF07;
	Wed, 28 Aug 2024 03:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724817262;
	bh=jLwgxlTbmmQa0vkZUtn7hMrKGuSWWsj08lIUB9ZB8KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2kWg83GNBa7PtOrzE7svxEzT8SYZopOFOj4kIanaFLsDWy6ZVqjxMkShEkjP7xyn
	 D1yCGdgUK9aTH3T/UKSotq8DO3OJw268Jz/soCZYUfT9czpEs2maPG5ksml5byK4zL
	 JRAhBTHDJYJvUTFqniQiGmFPr5Z6pByOADpO8mNaSWHqNqQDLNzlSXJ5NVmCuMzHpu
	 9XBAtUOTZ7b7Qs8DH5arFAjpmEnsKRjp3kqyv9Nhz3DRaFAp8ImendloiNNFWUIEgb
	 WOtfpZfJrdMxgxmTcB4ApPTWUBfOtyK5vZMa97ukeQCVvS3UNoH8mfOyHmHRVr09BB
	 DRpAGpHZ0Fqlw==
Date: Wed, 28 Aug 2024 12:54:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 peterz@infradead.org, oleg@redhat.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v3] uprobes: turn trace_uprobe's nhit counter to be
 per-CPU one
Message-Id: <20240828125418.07c3c63e08dc688e62fef4d2@kernel.org>
In-Reply-To: <20240813203409.3985398-1-andrii@kernel.org>
References: <20240813203409.3985398-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 13:34:09 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> trace_uprobe->nhit counter is not incremented atomically, so its value
> is questionable in when uprobe is hit on multiple CPUs simultaneously.
> 
> Also, doing this shared counter increment across many CPUs causes heavy
> cache line bouncing, limiting uprobe/uretprobe performance scaling with
> number of CPUs.
> 
> Solve both problems by making this a per-CPU counter.
> 

Looks good to me. Let me pick it to linux-trace probes/for-next.

Thank you,


> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/trace/trace_uprobe.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c98e3b3386ba..c3df411a2684 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -17,6 +17,7 @@
>  #include <linux/string.h>
>  #include <linux/rculist.h>
>  #include <linux/filter.h>
> +#include <linux/percpu.h>
>  
>  #include "trace_dynevent.h"
>  #include "trace_probe.h"
> @@ -62,7 +63,7 @@ struct trace_uprobe {
>  	char				*filename;
>  	unsigned long			offset;
>  	unsigned long			ref_ctr_offset;
> -	unsigned long			nhit;
> +	unsigned long __percpu		*nhits;
>  	struct trace_probe		tp;
>  };
>  
> @@ -337,6 +338,12 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
>  	if (!tu)
>  		return ERR_PTR(-ENOMEM);
>  
> +	tu->nhits = alloc_percpu(unsigned long);
> +	if (!tu->nhits) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
>  	ret = trace_probe_init(&tu->tp, event, group, true, nargs);
>  	if (ret < 0)
>  		goto error;
> @@ -349,6 +356,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
>  	return tu;
>  
>  error:
> +	free_percpu(tu->nhits);
>  	kfree(tu);
>  
>  	return ERR_PTR(ret);
> @@ -362,6 +370,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
>  	path_put(&tu->path);
>  	trace_probe_cleanup(&tu->tp);
>  	kfree(tu->filename);
> +	free_percpu(tu->nhits);
>  	kfree(tu);
>  }
>  
> @@ -815,13 +824,21 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
>  {
>  	struct dyn_event *ev = v;
>  	struct trace_uprobe *tu;
> +	unsigned long nhits;
> +	int cpu;
>  
>  	if (!is_trace_uprobe(ev))
>  		return 0;
>  
>  	tu = to_trace_uprobe(ev);
> +
> +	nhits = 0;
> +	for_each_possible_cpu(cpu) {
> +		nhits += per_cpu(*tu->nhits, cpu);
> +	}
> +
>  	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> -			trace_probe_name(&tu->tp), tu->nhit);
> +		   trace_probe_name(&tu->tp), nhits);
>  	return 0;
>  }
>  
> @@ -1512,7 +1529,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
>  	int ret = 0;
>  
>  	tu = container_of(con, struct trace_uprobe, consumer);
> -	tu->nhit++;
> +
> +	this_cpu_inc(*tu->nhits);
>  
>  	udd.tu = tu;
>  	udd.bp_addr = instruction_pointer(regs);
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

