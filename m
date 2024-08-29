Return-Path: <bpf+bounces-38459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8996503A
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CD11C20B75
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F501BDA97;
	Thu, 29 Aug 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYdT+heh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1501BC9ED;
	Thu, 29 Aug 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960795; cv=none; b=tPgiGe4S7gJU75OsfJqTXtj8sL4aD6n3LRHuQPIbx455VKsAoZ90g4zjPWkZluhEB1oHEbIoef/fe7QVM7dHS95CSCDc8TxafbtVaWpeq+3J9moK4cl39r1mYS+Wz8MxDJOL5ZEsY34smwBaLJ2xerGPPi39bPU7ke5DTVK0fYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960795; c=relaxed/simple;
	bh=kSKIJM+ZkFtvcMzZuWgU0edkekPpcAE1D9VScgc0tmY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GokigguerzR3ybhLbjqaY1b8sZNxmakm0sUwK50irqZYIKSRn/ttfUdMfVwhJ0uOH7684uDmU2Ha2LvUlZcn32UbEM9J//UDD7v9V6gowrhHaV4xnpVPdAeHzFrtyL/JfrrwC7loxkYrEBefKanIV9Htjye41STV08PCoQqFI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYdT+heh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso778953f8f.2;
        Thu, 29 Aug 2024 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724960791; x=1725565591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DbO5BGKjG9tb39+SvI3tyQ9zhNKOte0pvwUl4A4jE8=;
        b=PYdT+hehu8NaR2QQ/qiEp8CGJAu84tP1d0Qx6ty6e97B3lagKXQ0L9cnUFJYpcKZBD
         Ha0g+EeD6OjW0lD1YWBRpq8sho7/fFnZeLH0e90lxx7v4MIAbntmtxjkK+iVM39DgsTA
         TO+Enr2PU1c6sHn2RGBW54o1vWq3zs8ljQjjQSjATALDrF/xHMOKCXsF+fkGPBGE9d+y
         UqzE0iy9qbJu8DHqITuidtkD3VWwhkyL8Md4ExGPaEt7+1N4o6jYCyIpOlGVQDdUgDK/
         MTaNA+4oFffoXnPl277uPgLlB9EvL9p6qhG1Xp4rT8x+LPAYzfwDGWHQDQavodavf/Ds
         eyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960791; x=1725565591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DbO5BGKjG9tb39+SvI3tyQ9zhNKOte0pvwUl4A4jE8=;
        b=b3AGaDO/bo9RNIcs3bGLTwc85KNDVkb0iJ8TA5RetRs/FCmIAbBgGEtSfOzh60+Yy8
         ix+uGREaCz1Om3eici+/eo2xqp/FiAo4cCr1WA0V/rI1HAMzAZq823qzMIne6ElRyxe9
         nvSN1eU/x6eO5diirTIIjbpphgLupBM/cqrXfUiSfHlE73rrAVUwHOkVJsTaHyqxYv3o
         fIVpxQpTPx9+RWbDXwEKk594p4hg0BMAaDGeoaywKXK7+42HJpGEVsOLIavIdFbHXt7s
         fFG4SsCzHMbK2wh3+5wBLDDGoEBVxQ08MxTRapV+X0kpWQ5W6C4JlCKe/a9lUeGQ4P3q
         g8fw==
X-Forwarded-Encrypted: i=1; AJvYcCXRWPJHTtFeXzAwI4m3+hrMznTZUQWFbywKuvtYrCobOoCq8r5KB0Eu7YDM61R/mgqG5OI=@vger.kernel.org, AJvYcCXel/sGLojEhSmFIRYV6wLvfTCyY7iW4Pw8wUbeCseEiJ5TS5Y7GAuJg8hcKs8+q/2/G1iQ4eTXMzTpKqRRkx3wSZfR@vger.kernel.org
X-Gm-Message-State: AOJu0YzBqBgm3CZt/nj0sJN+0xANp9HEero/CF7b0XX75p/3F8Orv/Jj
	llAQea+dcSt8yNY+ofOZjgCIpQEvom4rbzl8hmZ6oGruX9REZ20u
X-Google-Smtp-Source: AGHT+IHWTLvEDzjTtPztef87V+QDQ14fhwlqoyFAqtoZWJsX4QwBgEtVrInR/UXbeZ4xKOqLT5lALg==
X-Received: by 2002:a5d:6406:0:b0:371:9377:8cb5 with SMTP id ffacd0b85a97d-3749b54869dmr2792155f8f.14.1724960790164;
        Thu, 29 Aug 2024 12:46:30 -0700 (PDT)
Received: from krava (37-188-180-165.red.o2.cz. [37.188.180.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm2187256f8f.62.2024.08.29.12.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:46:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Aug 2024 21:46:25 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <ZtDQEVN1-BAfWuMU@krava>
References: <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
 <Zs3PdV6nqed1jWC2@krava>
 <20240827201926.GA15197@redhat.com>
 <Zs8N-xP4jlPK2yjE@krava>
 <20240829152032.GA23996@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829152032.GA23996@redhat.com>

On Thu, Aug 29, 2024 at 05:20:33PM +0200, Oleg Nesterov wrote:

SNIP

> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index f7443e996b1b..e4eaa0363742 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1364,7 +1364,7 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc, struct mm_struct *mm)
>  	return ret;
>  }
>  
> -static void __uprobe_perf_func(struct trace_uprobe *tu,
> +static int __uprobe_perf_func(struct trace_uprobe *tu,
>  			       unsigned long func, struct pt_regs *regs,
>  			       struct uprobe_cpu_buffer **ucbp)
>  {
> @@ -1375,6 +1375,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  	void *data;
>  	int size, esize;
>  	int rctx;
> +	int ret = 0;
>  
>  #ifdef CONFIG_BPF_EVENTS
>  	if (bpf_prog_array_valid(call)) {
> @@ -1382,7 +1383,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  
>  		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
>  		if (!ret)
> -			return;
> +			return -1;
>  	}
>  #endif /* CONFIG_BPF_EVENTS */
>  
> @@ -1392,12 +1393,13 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  	size = esize + ucb->dsize;
>  	size = ALIGN(size + sizeof(u32), sizeof(u64)) - sizeof(u32);
>  	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE, "profile buffer not large enough"))
> -		return;
> +		return -1;
>  
>  	preempt_disable();
>  	head = this_cpu_ptr(call->perf_events);
>  	if (hlist_empty(head))
>  		goto out;

right.. if the event is not added by perf_trace_add on this cpu
it won't go pass this point, so no problem for perf

but the issue is with bpf program triggered earlier by return uprobe
created via perf event and [1] patch seems to fix that

I sent out the bpf selftest that triggers the issue [2]

thanks,
jirka


[1] https://lore.kernel.org/linux-trace-kernel/ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM/
[2] https://lore.kernel.org/bpf/20240829194505.402807-1-jolsa@kernel.org/T/#u


> +	ret = 1;
>  
>  	entry = perf_trace_buf_alloc(size, NULL, &rctx);
>  	if (!entry)
> @@ -1421,6 +1423,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  			      head, NULL);
>   out:
>  	preempt_enable();
> +	return ret;
>  }
>  
>  /* uprobe profile handler */
> @@ -1439,7 +1442,15 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
>  				struct pt_regs *regs,
>  				struct uprobe_cpu_buffer **ucbp)
>  {
> -	__uprobe_perf_func(tu, func, regs, ucbp);
> +	struct trace_uprobe_filter *filter = tu->tp.event->filter;
> +	struct perf_event *event = list_first_entry(&filter->perf_events,
> +					struct perf_event, hw.tp_list);
> +
> +	int r = __uprobe_perf_func(tu, func, regs, ucbp);
> +
> +	pr_crit("HANDLER pid=%d consumers_target=%d stored=%d\n",
> +		current->pid, event->hw.target ? event->hw.target->pid : -1, r);
> +
>  }
>  
>  int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
> 

