Return-Path: <bpf+bounces-26353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D689E8F8
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AEA1C22D7A
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 04:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3960710958;
	Wed, 10 Apr 2024 04:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjhUV3rF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041782206C;
	Wed, 10 Apr 2024 04:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723737; cv=none; b=iMNOEeZLVEsOjQ/ivcGEn5MVZOCOmlJPwJsYDIr1iUJXtsgz2e/3ybnSs50Trt51fXoF2XH+v5bSCCMk8hywOaDwV2z0/s3ZKu4N3DyBQfukFDq5PaXZXiGy4Hj5v6KYjrj/xUN4vlwtUjQtqWDe7IR5dTFOKgIkBR1lAY3jWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723737; c=relaxed/simple;
	bh=A5ocNCfCC13JQEwgLffXyCcRlMXUemMEj+WDWXuLyYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJEl6iAXGdpiNQN0YJ1sM0sVNNBkDuWMkbuywjKZonMOFnzyK6lK1844E8aZYTZ4Zt5NPbe2iRAlyrsN9jyIu8HA4G7v5RXMJgPsG9zo1dQ9Zw0AThXYASAHylv1pizgPmrkUynMjBYxo8UTaDXE1VkkiZpui9wdLfxWA4/YTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjhUV3rF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200202c1bso134338366b.0;
        Tue, 09 Apr 2024 21:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712723734; x=1713328534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jBy/6Q3rVBWhWCAM1R1P2AD92VuX8BxxvAdftUWY5s=;
        b=SjhUV3rFSb08/0JK7sa0OpEUrZuQ0vMpGmBka3TOk5Fw6Af6I4YWq/xPYoLN+PyWZJ
         dzJv0nOFVVMFXg4Uo6SV7Y98cfqxptalSMIiuXyK9/rhkvAooQ0nj/wJj/oLkELlNxCV
         Bsgb5SPwhRhkKnzFTLUKD9wzYP3Fv5rY5X6gq5AsATZkLUv24s2lZ9DW7F4aS4S6LL+g
         tfUBIp1gDlYuvJDThNvWcWeqCf0w/r5sUh2m8kIqgTzxw98Ia8OWJkgky5Vbxb1z5SpY
         Mnwn5kX1XMvx/2x3eQSC6BgxM7OeXwUdh0bzjCeAS/TCx1PMeztdQzDvn+BJwsg3eVWG
         fCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723734; x=1713328534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jBy/6Q3rVBWhWCAM1R1P2AD92VuX8BxxvAdftUWY5s=;
        b=Dhjiwf9msJ+I11I/slKAYs6GUp6/WKc5lszmWscfqD8bq1sDocNDKLArV8YvTBEPCF
         31M6g4RrlJ8H/5QtQCLyYXjA0BNHMHYYiBXxB16nQx4igtSdcwjV5hqpMLPkz6HfDE8/
         3seYLcPH7+tmUkz+TV5YCIARJwtRdAW2XSAoP2g5z7nhahfyVQ3V6SzuhurSSD8+TMoX
         tntZ9GnLnXFyIQOwvrOhtPc/IynDOMbkSgVZ6TgHN1izADoFwmcNgA9nq7djVlRuHAtR
         gpNDEjzBUndrY3ViIv3pnmIUjZ9UB3/NjELz4LcdDQfcOXEgbD2DWEEjQMvOG+8bul/K
         lHBg==
X-Forwarded-Encrypted: i=1; AJvYcCUEo4fm6r/McWlfGvRQ1nFJZ1RS4YliCQ0gzjSor/6BxIrRMz3igb8w2iFnSBkqmeaI8XNkoDnTUy3B+gxACuK99a70D7ZVGRfeDkHaS+oK+7WCMZh4VHH08Pq3QKUaJjYYUHLjIZ2y6krkClhwCELaJmUVQACTUCX1ZUZwaw5KRNEypw==
X-Gm-Message-State: AOJu0YxJKbK7w3n9cEX/QA82P258YafF6dfOUQ6SJhbRomA9RJn16bSD
	ZTbyxB73TM70yOwkYOpm9n4fkpR6nGeZThfWPnCWxvkXX8ejaLuRB7VCDwIeqM51Sg==
X-Google-Smtp-Source: AGHT+IGw3pGdJNDGc36x5yeSbeGn3X2Wfz1ITzkM/g7HGnBIi9qtAcipDvdlkr1wPsLlzku3Rvcclg==
X-Received: by 2002:a17:906:e288:b0:a52:a3a:3959 with SMTP id gg8-20020a170906e28800b00a520a3a3959mr662263ejb.23.1712723733985;
        Tue, 09 Apr 2024 21:35:33 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id an3-20020a17090656c300b00a51cfd5c6ddsm3893091ejc.9.2024.04.09.21.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:35:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 06:35:31 +0200
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
	Will Deacon <will@kernel.org>, Song Liu <song@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RESEND PATCH v5 2/4] perf/bpf: Remove unneeded
 uses_default_overflow_handler.
Message-ID: <ZhYXEzGprOoZKrGv@gmail.com>
References: <20240214173950.18570-1-khuey@kylehuey.com>
 <20240214173950.18570-3-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214173950.18570-3-khuey@kylehuey.com>


* Kyle Huey <me@kylehuey.com> wrote:

> Now that struct perf_event's orig_overflow_handler is gone, there's no need
> for the functions and macros to support looking past overflow_handler to
> orig_overflow_handler.
> 
> This patch is solely a refactoring and results in no behavior change.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Acked-by: Will Deacon <will@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
>  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
>  include/linux/perf_event.h        | 16 ++--------------
>  3 files changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index c7f54fd74d89..c8bd5bb6610c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1341,8 +1341,9 @@ extern int perf_event_output(struct perf_event *event,
>  			     struct pt_regs *regs);
>  
>  static inline bool
> -__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
> +is_default_overflow_handler(struct perf_event *event)
>  {
> +	perf_overflow_handler_t overflow_handler = event->overflow_handler;
>  	if (likely(overflow_handler == perf_event_output_forward))

Please read the CodingStyle section about variable definition blocks and 
newlines...

Also note the stray period in the title ...

How did this patch get to v5 and get acked by 3 people with such trivial 
problems still present? ...

Thanks,

	Ingo

