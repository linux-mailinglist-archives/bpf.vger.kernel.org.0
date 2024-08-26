Return-Path: <bpf+bounces-38080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2AA95F344
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF901C214E3
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D8188017;
	Mon, 26 Aug 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5hf/Iz/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A317C989;
	Mon, 26 Aug 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680257; cv=none; b=hHTAMn9yD8bwoaQ1Yuv24Z7CSHHZXz4P1oZi2UONyhmP5CIrWdiCTM396Pfdx0rV5s1D+q8v1Idbfn9+Y690ED6FEA0iEpPCKfhvxTw1XTQSvrfLx56kXIx3YnYfk+GwDFgbywl9tHcFCZRhhfNfT8dsOJUAp/5Mrx7W+ZO0Xwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680257; c=relaxed/simple;
	bh=Ql3lLhWWb12Nad4uzA4DwuvPl7xpz9d122mTN13lt3M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrcPSyRP7MlaNneb54Aj/zKnggEP71MmSi462qacT+Ptvv7450ArDt/kXLaV9iHuekBlNuxiMwTQkFx3C1zImyYG3HMkZfuphlrEwah16VzWuJGjdTqaR3fnCQmYgNSCJIbFO1jEXRelGJsdaZjhryt2k4a7t5DSPuQfZpe/eZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5hf/Iz/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3730749ee7aso2604930f8f.2;
        Mon, 26 Aug 2024 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724680254; x=1725285054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDBC/eNBjytuJW+d+vzOhbTsHCHu3dAH80hQ3xzktl4=;
        b=J5hf/Iz/Emd7eIZxMIVc/Bn+lt/uptOOKdGMH7ZAZ9xP6VtS9iMURWbFRvxxDEDRyc
         VndsPlv22SLqRemqSsFFu12zvYBHYoLx9wXGpkpGZg4XTOEi83E7lODUvQ5l1VuZVk23
         9q8pgDZTkMH3kxTwWEL6pTzE6irG1Dm/Q9KM/5ZwMOCk+7XzQiGTp4p+cY7zdOwOMg2U
         ddvdBKinYMaiKdLclv+ZiMYOqvic59ux0FBveQmzLg8lYQWXUVA1s04/Ra7abmO2IiQF
         GjzabGix87DwVqhqv0m6lok1GT1TtO+6/TQ/GB5PPWeEYNJaAn/amlWdj9lue7a3vUXD
         o15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680254; x=1725285054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDBC/eNBjytuJW+d+vzOhbTsHCHu3dAH80hQ3xzktl4=;
        b=iGn0RDFNYdGIIra+yDDoT8oqN6dqWmc6R0pFwNZzYuQDpjn2LDJeNSzvkauTEWkJRp
         D6nuoJnHjAOAeHnlSNOqV/RQpNmyRwbBf+Chux5Sy+9Kfv2xOun7MNZ25Tx8feAhL/GB
         qZhtkIZxxbRpnSQS1TlRF4tNFGFPMzDEWr2WTLMfSMCVHuywBsgmZcvSBJoBSS0Nm7n0
         KZliE+rSdqiFBScfsi+fULm1QhYf6i59kjAVcAKTiKuZTrwBB/XarpdYwl+hEjI7GcOB
         HO0t9hup3oV74u0hBF3U/2FRT2QnHlK///PaotZm2UFciJ4/avFk7WIEdvR347cSeoCL
         aMmA==
X-Forwarded-Encrypted: i=1; AJvYcCV4KPhi0buxjzcUTZ550tYDdL6wkejwUYQu5pEXdXQ8SrjqdAFlZfg/AisR0jcubQ2aC8EE2k5emqLsKVSn@vger.kernel.org, AJvYcCWiEEO0Qq3e/slfSgnteaCy16yaQ5iTVhFXd2zCO0JCIcjZWib406HsaVWGgFLTI5PuJPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtg2WBvnC/TwtSUg4CxSaUk0dEMBlVz59qvOvo1TYJiX74qD0
	5GL7/epSFyh2rz7znIHzsBRgs4cTbcr/P5wMLuClBLOYRaE8c4OAv5bqUS6M
X-Google-Smtp-Source: AGHT+IFBBsN2W741UbmJpJpXL3MWGUWlu4fnpmjgYMtASN07/tcdSO/uip4kihga7eNBGrmHl6u5Fw==
X-Received: by 2002:a5d:4f8f:0:b0:371:846d:12b3 with SMTP id ffacd0b85a97d-3731186386amr6967035f8f.28.1724680253535;
        Mon, 26 Aug 2024 06:50:53 -0700 (PDT)
Received: from krava ([213.235.133.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c3d2sm10811517f8f.26.2024.08.26.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:50:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Aug 2024 15:50:39 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, oleg@redhat.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] uprobes: turn trace_uprobe's nhit counter to be
 per-CPU one
Message-ID: <ZsyIL7NAN3AWbgzS@krava>
References: <20240813203409.3985398-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813203409.3985398-1-andrii@kernel.org>

On Tue, Aug 13, 2024 at 01:34:09PM -0700, Andrii Nakryiko wrote:
> trace_uprobe->nhit counter is not incremented atomically, so its value
> is questionable in when uprobe is hit on multiple CPUs simultaneously.
> 
> Also, doing this shared counter increment across many CPUs causes heavy
> cache line bouncing, limiting uprobe/uretprobe performance scaling with
> number of CPUs.
> 
> Solve both problems by making this a per-CPU counter.
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

lgtm, fwiw

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

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

