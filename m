Return-Path: <bpf+bounces-38556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE9966300
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B189028459E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99CD1ACE00;
	Fri, 30 Aug 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkpICsdy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC681ACDE2;
	Fri, 30 Aug 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024853; cv=none; b=Nyxn+9snJI6ADdsRlWlR2Kpgupt2BLdiLpszPsa2MsStgGS7D8ureMOvu2PCSS/lh9V+2m+jU67qb4drsUe+fUy1IIRtq/ZvT4IUNv9p9A6Yt5NEbdW5pebfOzVAMgy7KZn/jM31lqexbmHT6vCIietJA2ffLkTHdHRLJrEHb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024853; c=relaxed/simple;
	bh=BHFptugNbsYLlUhG1W7t+vp3rzZraIR5G+WJT7koLf0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfpOgcumI0NLF1eTU3fzvsWtIbUtDXY7D+8rQnHNq7RdTE+L5nJPdY7ero+itcV94dAon3w/+VqjfO2bJNrwbWyNOUyc1m3Jtr367VtaiQrSUVmDOAZHPngrkdSfOoeSMKSnqm+KZZ4k1cMZPAtwr7fDYYlrAVzIH+dgThgBiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkpICsdy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e1915e18so15492505e9.1;
        Fri, 30 Aug 2024 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725024850; x=1725629650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFsn5tchlGZTR9jfDj5d/Srf29xh4nviRAQZ9P6lQME=;
        b=jkpICsdy78rCIHgmyDn36vomlU+Yb8r9lqDF/WU+cMMCtYAhiC5VaLA+UU136fyp1/
         ncCJ65tAjuL8Ux67u6DIkqG2pRgWfQDzJaCPiRq7CeZpbJFfpLardFEQL323QSLIJG+g
         51cN9X7X1HoVLEQdugpvkd5sozvHlyYjLc5vH1rIgN0ZrqPq6UGfyvU2oMlTwHeiptyv
         RDta6sLXnfN84+Sbi9iHy9lit4zm05TT3p4c5DVbxYF6g6pISzY3lntfLFwqJGt56UE4
         petX59XhMs+cY46YsdcvEefYGzgpbUEHDyb55iq0KtfWE+loHshbwFnWD2ZnPl0Hsd2P
         0LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725024850; x=1725629650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFsn5tchlGZTR9jfDj5d/Srf29xh4nviRAQZ9P6lQME=;
        b=hh8s8pc9D9HQ+miK8XtCfFQ50zdQhAFe9/rvVCBU9AHyzCR3eRrI2N5LdUvKUtw84a
         kEPxt/IrXNKs21TUHacqZmr/9xMPCv/+gzG9l/PWXI8oEMF94mzCfVyWEI5FD2sS5U7h
         GSW9qhKvawPhpHNQ+Xh/87oz0T2Uw378MBqmnvn7CxiV105JiI9OvbYYuY18FVsZDJCe
         OzslYjtUhf/HLzUQeSRrJOF6LKZzdIyO4iRJAiV/C11npHuP4R0sMZHXVKvHqjR4S1Ce
         SKjvEG4OjmFnyiLBJXH8cbG7apZAvh5I3dKT6cKh2hZtc/Vmv4/sNtEv20vKbuTDUOAo
         ADWA==
X-Forwarded-Encrypted: i=1; AJvYcCXVpuZvI0JVVy2Jocf+EuHByMNMZf9CRsUBBXp+yKwDGStfit9+l9xN63E4O2sthEtjJpnCFiKsRL7MhH8GJ1ZTWVss@vger.kernel.org, AJvYcCXjZDy9nP5uHv7oLdaK+VlftF60fuDk8Y4mV0QM6nMAPCQdSTbLAJZa0nbwN4etc+oinLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxtusOym6Zv+Gy/fgvvofCBwZK+hYrsP4ZTNCBWOYY2LL6YKT
	GYbZi3UWeXAJT7f7STU8X5mhR6IPJ5A18BNTTFQrvi8kbWemDKsT
X-Google-Smtp-Source: AGHT+IExFEB3mP6i/ck7PmFBvaJEAnmRqVHA2ZIC/9hpRf8SZm653D9AUhU3dS2R2r9lmkq5DllCbQ==
X-Received: by 2002:a05:600c:3596:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-42bb0307864mr50130475e9.17.1725024849336;
        Fri, 30 Aug 2024 06:34:09 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efaf35asm4023484f8f.90.2024.08.30.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:34:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Aug 2024 15:34:06 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tianyi Liu <i.pear@outlook.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jordan Rome <linux@jordanrome.com>, ajor@meta.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <ZtHKTtn7sqaLeVxV@krava>
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240830101209.GA24733@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830101209.GA24733@redhat.com>

On Fri, Aug 30, 2024 at 12:12:09PM +0200, Oleg Nesterov wrote:
> The whole discussion was very confusing (yes, I too contributed to the
> confusion ;), let me try to summarise.
> 
> > U(ret)probes are designed to be filterable using the PID, which is the
> > second parameter in the perf_event_open syscall. Currently, uprobe works
> > well with the filtering, but uretprobe is not affected by it.
> 
> And this is correct. But the CONFIG_BPF_EVENTS code in __uprobe_perf_func()
> misunderstands the purpose of uprobe_perf_filter().
> 
> Lets forget about BPF for the moment. It is not that uprobe_perf_filter()
> does the filtering by the PID, it doesn't. We can simply kill this function
> and perf will work correctly. The perf layer in __uprobe_perf_func() does
> the filtering when perf_event->hw.target != NULL.
> 
> So why does uprobe_perf_filter() call uprobe_perf_filter()? Not to avoid
> the __uprobe_perf_func() call (as the BPF code assumes), but to trigger
> unapply_uprobe() in handler_chain().
> 
> Suppose you do, say,
> 
> 	$ perf probe -x /path/to/libc some_hot_function
> or
> 	$ perf probe -x /path/to/libc some_hot_function%return
> then
> 	$perf record -e ... -p 1
> 
> to trace the usage of some_hot_function() in the init process. Everything
> will work just fine if we kill uprobe_perf_filter()->uprobe_perf_filter().
> 
> But. If INIT forks a child C, dup_mm() will copy int3 installed by perf.
> So the child C will hit this breakpoint and cal handle_swbp/etc for no
> reason every time it calls some_hot_function(), not good.
> 
> That is why uprobe_perf_func() calls uprobe_perf_filter() which returns
> UPROBE_HANDLER_REMOVE when C hits the breakpoint. handler_chain() will
> call unapply_uprobe() which will remove this breakpoint from C->mm.

thanks for the info, I wasn't aware this was the intention

uprobe_multi does not have perf event mechanism/check, so it's using
the filter function to do the process filtering.. which is not working
properly as you pointed out earlier

> 
> > We found that the filter function was not invoked when uretprobe was
> > initially implemented, and this has been existing for ten years.
> 
> See above, this is correct.
> 
> Note also that if you only use perf-probe + perf-record, no matter how
> many instances, you can even add BUG_ON(!uprobe_perf_filter(...)) into
> uretprobe_perf_func(). IIRC, perf doesn't use create_local_trace_uprobe().
> 
> ---------------------------------------------------------------------------
> Now lets return to BPF and this particular problem. I won't really argue
> with this patch, but
> 
> 	- Please change the subject and update the changelog,
> 	  "Fixes: c1ae5c75e103" and the whole reasoning is misleading
> 	  and wrong, IMO.
> 
> 	- This patch won't fix all problems because uprobe_perf_filter()
> 	  filters by mm, not by pid. The changelog/patch assumes that it
> 	  is a "PID filter", but it is not.
> 
> 	  See https://lore.kernel.org/linux-trace-kernel/20240825224018.GD3906@redhat.com/
> 	  If the traced process does clone(CLONE_VM), bpftrace will hit the
> 	  similar problem, with uprobe or uretprobe.
> 
> 	- So I still think that the "right" fix should change the
> 	  bpf_prog_run_array_uprobe() paths somehow, but I know nothing
> 	  about bpf.

to follow the perf event filter properly, bpf_prog_run_array_uprobe should
be called in perf_tp_event after the perf_tp_event_match call, but that's
already under preempt_disable, so that's why it's called before that

jirka

