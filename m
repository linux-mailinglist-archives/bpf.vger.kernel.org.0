Return-Path: <bpf+bounces-34743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59A293074A
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA191C21142
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926E1448DC;
	Sat, 13 Jul 2024 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+z2Iev2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295F1B7F7;
	Sat, 13 Jul 2024 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720902734; cv=none; b=Bjh3YDl4BxHjREafXNgzj8j9WCLLYTwJ+Zc15PuNIebJq3rCpGp1mhkF21G8a8MsRm1S9OzJGx3wvHi1Fbo47xtim3EJ4oyz3xBln7pqEqm+bFU8Z7JHh3zHyajTlcDvAkWZU8/dblAji/UiaCOy80K3v8Tgv5FmTIB04KW7KEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720902734; c=relaxed/simple;
	bh=r9iCqwPKFeEq4XaYE5TgYjpO1aWrALFO8KJSblYuYso=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGqTaOH18T+ZrKFM7XCptl5a24EYBn1Q2McI29K7gKB2APwwdAQNlWUnO4kW/SWI++mqoD8TzWQXWdPG0zR/WNko1vHx01XTZcEvDYhnEAbZXxI1z4Rke5ubtvMF2r4a8pz3MR6Djm1vdVtNtyfQ1YbQQPiEQ9A+tpF9r6oGGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+z2Iev2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266f344091so22614475e9.0;
        Sat, 13 Jul 2024 13:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720902731; x=1721507531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5DNDmXPAmgW9kVg8XW05xA3u29f8Ptemy4YLsZF/M4=;
        b=M+z2Iev2ctbiKSK315Fite9/Ivs9GbktJi1Rqj3cO2h93vT/GPRJlxcoyECWbkpEjz
         Fsz/k3eGJMUuzz3w28p8ppMfNWo7eo1Aq5thkoxySHDstYiOx4mt3jxdwTj/csone924
         BvN8RzBq9/24uthbKKy3Xuvqb117Sq760OSakT7fRC7Fs+wOHhryx5sZP8Zu744fsRTO
         iDunV/6X8gRuOh415ISyXLFFfChmPkVNcgh/Z2d5l+i52fLvBWAKXgQ2IDGAj+FEOsFC
         20uPFqJccR5co84BWeBJSJUZFKNhcdOv7KqMQ8cUanpPo2i0+B5P6BEZJAvdUF+V/70F
         fAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720902731; x=1721507531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5DNDmXPAmgW9kVg8XW05xA3u29f8Ptemy4YLsZF/M4=;
        b=JVJDIuWiUx2AnVaK292INo6mrZyD+4qi+pG88w8vcNmo5OSD9MFBuPJTSgrg7XaugC
         wHMdjyiAVRH287EzZ2X8OEYvC0klh7TfKypYg2hADnPg7M3dvSMmuxy+5Z9F2VS4bd9a
         8xTDTn+EwBUMDuCXBDRjkTJBcXhNJXTIAC1VDIGsVVIXp4Fhdoa0Oi0hXTCA3zeu42cQ
         sZgYWTfRf6xfbOKhClnunoueDcQXIv5Zjf8o0Zoq4oyuG8Bk0/IKHWC6CH5sIKLXmux1
         1ceebyW7q54Y6qb+Qo95sLUJ64KKfY+TNgE4Ub2/B4BrC0c8vDIdm1oFYYVcJ3f+m2PK
         Qznw==
X-Forwarded-Encrypted: i=1; AJvYcCXDEu9ZAGo14JKyFfEWYMuuR6ETMCbXbep049m27Nt1WWJVHOAfdox/ALWEGSKzwj2IBC0iADyuL/skVAm9IoP/j0PSmY5mibYCtpDSqPSQg35a+zOxmCZCZTNe/e7OuwDRa9aolPqD+Yi6IXAJOGIoE54Qpz5kFaEO5hX0bSR/KYbICw==
X-Gm-Message-State: AOJu0YwG+Jz4TnYUGHUWBXReVca/avrwNeVIOGvqcxL2ZRqaSMqZICBG
	gGsvKvFwv7P3NGFKJVUdhNn5/Kf4Y1s72HRV/O53rv5nUqJvRplo
X-Google-Smtp-Source: AGHT+IHxnPHvtE4COhsW3Fj3Ierhve95HFHnV1cTCOZebQOM8qY2hur7zTq0uCm/7mszmQgfk4BagQ==
X-Received: by 2002:a05:600c:3b12:b0:426:66fb:fcd6 with SMTP id 5b1f17b1804b1-426706c64b5mr86446525e9.3.1720902730484;
        Sat, 13 Jul 2024 13:32:10 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e7751asm32313555e9.3.2024.07.13.13.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 13:32:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 13 Jul 2024 22:32:07 +0200
To: Kyle Huey <me@kylehuey.com>
Cc: khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing
 events
Message-ID: <ZpLkR2qOo0wTyfqB@krava>
References: <20240713044645.10840-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713044645.10840-1-khuey@kylehuey.com>

On Fri, Jul 12, 2024 at 09:46:45PM -0700, Kyle Huey wrote:
> The regressing commit is new in 6.10. It assumed that anytime event->prog
> is set bpf_overflow_handler() should be invoked to execute the attached bpf
> program. This assumption is false for tracing events, and as a result the
> regressing commit broke bpftrace by invoking the bpf handler with garbage
> inputs on overflow.
> 
> Prior to the regression the overflow handlers formed a chain (of length 0,
> 1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
> bpf_overflow_handler() to that chain, while perf_event_attach_bpf_prog()
> (the tracing case) did not. Both set event->prog. The chain of overflow
> handlers was replaced by a single overflow handler slot and a fixed call to
> bpf_overflow_handler() when appropriate. This modifies the condition there
> to include !perf_event_is_tracing(), restoring the previous behavior and
> fixing bpftrace.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Reported-by: Joe Damato <jdamato@fastly.com>
> Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
> Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
> Tested-by: Kyle Huey <khuey@kylehuey.com> # bpf overflow handlers
> ---
>  kernel/events/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8f908f077935..f0d7119585dc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9666,6 +9666,8 @@ static inline void perf_event_free_bpf_handler(struct perf_event *event)
>   * Generic event overflow handling, sampling.
>   */
>  
> +static bool perf_event_is_tracing(struct perf_event *event);
> +
>  static int __perf_event_overflow(struct perf_event *event,
>  				 int throttle, struct perf_sample_data *data,
>  				 struct pt_regs *regs)
> @@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_event *event,
>  
>  	ret = __perf_event_account_interrupt(event, throttle);
>  
> -	if (event->prog && !bpf_overflow_handler(event, data, regs))
> +	if (event->prog &&
> +	    !perf_event_is_tracing(event) &&
> +	    !bpf_overflow_handler(event, data, regs))
>  		return ret;

ok makes sense, it's better to follow the perf_event_set_bpf_prog condition

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

>  
>  	/*
> @@ -10612,6 +10616,11 @@ void perf_event_free_bpf_prog(struct perf_event *event)
>  
>  #else
>  
> +static inline bool perf_event_is_tracing(struct perf_event *event)
> +{
> +	return false;
> +}
> +
>  static inline void perf_tp_register(void)
>  {
>  }
> -- 
> 2.34.1
> 

