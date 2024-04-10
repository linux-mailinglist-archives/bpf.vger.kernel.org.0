Return-Path: <bpf+bounces-26352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B14D289E8E6
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D38B2416B
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 04:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232F99468;
	Wed, 10 Apr 2024 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVLg6fXH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466910A09;
	Wed, 10 Apr 2024 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723523; cv=none; b=G3HSDW16qzi4q0POyCNYB6UXB39Y8euXlgK6w297SkBCdwHrHZ4lvfro5MlNC/r+AZ45UEwqZlU5g2D1vtrxKgcDIkS8XJSEwxc1meLkNz452iZdnmwyW1cpDP3AoPx2T3EJ2j0X/wsCKaqjo/UYR0s4FdK2KD0d4j3F+O9FTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723523; c=relaxed/simple;
	bh=rMVm9URc9I8cVqvGGbdYnQEP4nxrZ957jULQWF63OlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCBZI6KzPc4wiqy+soxvw8sWyETW/+J2ousyWBIws/a/S9BjS5fxIMPVfCL2PJsQ35o1eJOxm/4FksB22pWDDnyL/K34RpZiIPg2S8sksfYtirQs4iQRNqV9mU8sLecs4zk29gTUKRvfk3vjdvyOL5OQSS7jsb4q1/poqgwlxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVLg6fXH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51c8274403so420889266b.1;
        Tue, 09 Apr 2024 21:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712723520; x=1713328320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNrSwE+dolE2QA8qHvdLe8vM7FO2G4niuceuaP/S8AE=;
        b=OVLg6fXHFIWZErKmVfCiM1MKvWZsrWNKL/7OqSft/IhpQzSlR/Q+I0pHGK1Xbu3RAu
         K8lNKMYTRXVf+TfUZC9QbGYoPw2bwguJeck8OQtLygXB9JjSgGvSoIacQd9hEXEXw27u
         WLEOPZF6NJTLL1f94UCGRnL4YOMVh3T7tU0Mgm5VhK3mPwCKARC6SWwHbkCTdeylWLmD
         GMZE4lqm28/qsLQckxEHKSw/gAr9IU6MtTdMnrDWKfrlblX9v/m8YMkftcn2x5kKyERR
         yhrC6yl3FYXiCubKISZTTKwjVKkO2juVJ7ZknYVpT5e63o1w/UorIZDBOenGE0EH/4dX
         YiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723520; x=1713328320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNrSwE+dolE2QA8qHvdLe8vM7FO2G4niuceuaP/S8AE=;
        b=TL7pTOFnhQxJUXi/rGaKGfQOBdLbwRRdHCZuxkQxTAsL6Aes764AphE/l37ToXdT6m
         DeKA8jHfN3sBZnvwnln5gjz5WIyH2SB79rFH6Rjm5fNQKdV8+u1XI0VGZg+djWQWvxfw
         tyGsLFJBK0Eb5DEPmsqSZw94i+rt3xZhtGUJJmJGcc3WfK85RabAefpUvpgE4bZ+5CfU
         2LHGSylhL3XjpjpPW/43vSTFQLgeLZ4SKjuDAHPWfc70g+zh7dW9Qooqz703DUfhZMxJ
         yyBINs9P96QBLbWaNb2pKvtr15eFtb1SBf9AlQhc2GJFvvL638fCl/GY1jJ6wjTRtjxQ
         Ry/w==
X-Forwarded-Encrypted: i=1; AJvYcCUA9vIO8aNisIoxtN7m2qA46R1XwlAA/PWIqgZ5FbYxOB02IYiP0waNUh+cRZwF5ksXAJ9ZxbIDHFWr6VrvFTGX4IksXFxUS/IHW7+xkyJDDt0+vnBu8Rio43ZlNsxg99hUWE2uuNt+r0OAoep8e+D3ZBhG4KhRhqyM8HI+SnBZKQrtuQ==
X-Gm-Message-State: AOJu0YxXp1xEAnTUmZTXFK1QBdMk+Kf26NfCsJveNA9j3nnJ/EdaFgLZ
	0xSNaNilQnQAIOfqRqO5cYvD76FaWAwTaGWyRME/iVvGxsMnTvfs
X-Google-Smtp-Source: AGHT+IEFsrpybLrAxP55MzTpaSrenlWTPHzaVeLem3lu9vpNOhH0S2cMYNX2Xn5nmDfbQ8RsQjL+Bw==
X-Received: by 2002:a17:906:7192:b0:a51:c191:c0a0 with SMTP id h18-20020a170906719200b00a51c191c0a0mr693725ejk.43.1712723519698;
        Tue, 09 Apr 2024 21:31:59 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709070b1300b00a51971dd79csm6586263ejl.143.2024.04.09.21.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:31:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 06:31:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Robert O'Callahan <robert@ocallahan.org>,
	Song Liu <song@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RESEND PATCH v5 1/4] perf/bpf: Call bpf handler directly, not
 through overflow machinery
Message-ID: <ZhYWPGX0RzamxOHx@gmail.com>
References: <20240214173950.18570-1-khuey@kylehuey.com>
 <20240214173950.18570-2-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214173950.18570-2-khuey@kylehuey.com>


* Kyle Huey <me@kylehuey.com> wrote:

> To ultimately allow bpf programs attached to perf events to completely
> suppress all of the effects of a perf event overflow (rather than just the
> sample output, as they do today), call bpf_overflow_handler() from
> __perf_event_overflow() directly rather than modifying struct perf_event's
> overflow_handler. Return the bpf program's return value from
> bpf_overflow_handler() so that __perf_event_overflow() knows how to
> proceed. Remove the now unnecessary orig_overflow_handler from struct
> perf_event.
> 
> This patch is solely a refactoring and results in no behavior change.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/perf_event.h |  6 +-----
>  kernel/events/core.c       | 28 +++++++++++++++-------------
>  2 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a..c7f54fd74d89 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -810,7 +810,6 @@ struct perf_event {
>  	perf_overflow_handler_t		overflow_handler;
>  	void				*overflow_handler_context;
>  #ifdef CONFIG_BPF_SYSCALL
> -	perf_overflow_handler_t		orig_overflow_handler;
>  	struct bpf_prog			*prog;
>  	u64				bpf_cookie;
>  #endif

Could we reduce the #ifdeffery please?

On distros CONFIG_BPF_SYSCALL is almost always enabled, so it's not like 
this truly saves anything on real systems.

I'd suggest making the perf_event::prog and perf_event::bpf_cookie fields 
unconditional.

> +#ifdef CONFIG_BPF_SYSCALL
> +static int bpf_overflow_handler(struct perf_event *event,
> +				struct perf_sample_data *data,
> +				struct pt_regs *regs);
> +#endif

If the function definitions are misordered then first do a patch that moves 
the function earlier in the file, instead of slapping a random prototype 
into a random place.

> -	READ_ONCE(event->overflow_handler)(event, data, regs);
> +#ifdef CONFIG_BPF_SYSCALL
> +	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> +#endif
> +		READ_ONCE(event->overflow_handler)(event, data, regs);

This #ifdef would go away too - on !CONFIG_BPF_SYSCALL event->prog should 
always be NULL.

Please keep the #ifdeffery reduction and function-moving patches separate 
from these other changes.

Thanks,

	Ingo

