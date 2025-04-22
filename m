Return-Path: <bpf+bounces-56410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9616A96D3E
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C4B17C432
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E14281537;
	Tue, 22 Apr 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeuNrF4j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79127CCEF;
	Tue, 22 Apr 2025 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329429; cv=none; b=W9xVT8c4IL1TT0TisVPbO8OrsyV/oCsSeWFuXzWGte6NOaPyo0/707e/8gpYyFvr7Kxswov096+bWLNOM0Rc/8a8IBmgB1XFdvkVZpWSFu90OTg4O3OpmlG3+/ofTvLZswLZwnzxAr+o/zwR7IAePNUbDMo23SWYTb3LBvbGa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329429; c=relaxed/simple;
	bh=uZ2Q3BSmyxrkcTQQzx/xqj4AZF+9c/VelamhldB4ruY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByCcKIphfz1oGfcf8CdulndlgOQmL2XFf1TjmBED62lf5FDSx1kt4kcxyfg6WH47lZ7f0COHdOUqtgpGgaaR514a1DkzoJUqhBjLCkziV/XLZ7ilhnIVYe1AhvNOppnGTtmVYuStR2fP8yXWHpWH+a7XlqPZyoYRMdfQGgy6fTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeuNrF4j; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so6581825a12.2;
        Tue, 22 Apr 2025 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745329426; x=1745934226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPh+Jq2Ed9hv9WRoSx2FsqzJMvYtffRf+L562svlF6w=;
        b=jeuNrF4jnJfayb8YgPn5XJdkNkMFDnXFRRCL7r/ztWdtmhyRpw+ZJLRPynCqKMaZJQ
         caTcjsCSk4PbS7tXtW7++flj0UrxRztI24EDiaTxICnINFJJ0EkvgHBjnyULWm0SAAsk
         sNzeDJGy/SNuphRPHie+/zZsRA3EJUqg9WhVhE1woIQHALzannDtdPmftdUOGhxzos3E
         V9tJbXDUstV0UV1XjFbK5r1kJ7lNUFYyMEEgazHbbfKvNh8y88Xns1oQF/jM4AU129s7
         ogD35GGx+MDjMhaKO2xs/eFVrEIaZgMkF88jiSPKw/bsimjgbr76XDDNZyGUggJzwvZC
         uAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329426; x=1745934226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPh+Jq2Ed9hv9WRoSx2FsqzJMvYtffRf+L562svlF6w=;
        b=oSOQ9H8uliyHUAjsttcv6O8116rVRRn77Yf7+QY1ZpCZJE4GKsVE1L3brUL+RrDtTA
         ziVKfMRhC6yGc1OwqhdViTTwMrvg0QkGoY9RoqN3ctTwVKaTBYmkXnbwSRNxIUjT+lgI
         NHuHq02sNzYb4HxTV2MNnPKsFssH2zDOQujddXzkP6oso0nYE0qn6GXOzlJiEJwX6kJQ
         LYG49tHwlpZC+qMFCPbJSyZTAwPUm6ssOFBs8VymrBE9aeYbKtE78rYS5fFen7+1+/Di
         31w9fVO4rtQ8Nh8MJvUOWvd1XSBiH5+JZMCKG5FoRIsCr0i8TYr2+nN8WFskAKK12YIz
         bUsA==
X-Forwarded-Encrypted: i=1; AJvYcCUb8clD1FvRVWZDSwyy0kI6KBv7bqHjsMuSf1fmYzF/p3HzgQs2YHtJ0a7D00+q3TWoifIOZgt9stmPHWmS@vger.kernel.org, AJvYcCWUqF+YsjzlETxNnHJ/TxxXIx4hRTUbVvj4z3EFNxxghjyCF1pRVx4IqZPHqFVM1enT4t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+5/U+L+JeB0mGM5Ye5ywbBX+sAYUnlyJgKvI/3FOSAUe3z77
	wEpPTc4fqi/7XsB3HH+9+5+/Yw0HI6gVtKntPZpZzkwngX60RkMN
X-Gm-Gg: ASbGnctquizshAtenExnfCTJqXFyS5vfjGZGwNDB17VjdbmwgvFxFqIHKJj+fAoS9DN
	ncBFXcQ2DnsawkG9VfAF7rDxqghQIvsaKE8gwy3U42y+UqQlNDxK8L4GR50BYbHnoDFYU33bE8U
	w8ZwEDBW83yHor2jztGK4XXkzNU4pzdQlFKTl/CeLscoKUtbRraNsWXgvh+VpltIBR2ajK6/Vpf
	D5a7z0iKqYSynet5kFHSRNfS6KwXOiA7QqxyxvZDyYYCZPqDWp2vSvYY8hC0j53bb1ZC+V2xnAg
	+FBYRusqSm03dGH0pTXATIyTsWE=
X-Google-Smtp-Source: AGHT+IETzaBi2r+DApEGo3LSk3kyXl2a34FzYwVlS9+QlOduwg0hhVNboZbTpFT9+VgpALYAqDUk/g==
X-Received: by 2002:a05:6402:51cb:b0:5f4:c20d:4984 with SMTP id 4fb4d7f45d1cf-5f6285d5426mr13704677a12.30.1745329425480;
        Tue, 22 Apr 2025 06:43:45 -0700 (PDT)
Received: from krava ([83.148.32.128])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f62594985bsm5966324a12.74.2025.04.22.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:43:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 22 Apr 2025 15:43:43 +0200
To: Tao Chen <chen.dylane@linux.dev>, Namhyung Kim <namhyung@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next] libbpf: remove sample_period init in
 perf_buffer
Message-ID: <aAedDw7fWAF2ej1f@krava>
References: <20250422091558.2834622-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422091558.2834622-1-chen.dylane@linux.dev>

On Tue, Apr 22, 2025 at 05:15:58PM +0800, Tao Chen wrote:
> It seems that sample_period no used in perf buffer, actually only
> wakeup_events valid about events aggregation for wakeup. So remove
> it to avoid causing confusion.

I don't see too much confusion in keeping it, but I think it
should be safe to remove it

PERF_COUNT_SW_BPF_OUTPUT is "trigered" by bpf_perf_event_output,
AFAICS there's no path checking on sample_period for this event
used in context of perf_buffer__new, Namhyung, thoughts?

thanks,
jirka


> 
> Fixes: fb84b8224655 ("libbpf: add perf buffer API")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da5172..1830e3c011a5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13306,7 +13306,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>  	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>  	attr.type = PERF_TYPE_SOFTWARE;
>  	attr.sample_type = PERF_SAMPLE_RAW;
> -	attr.sample_period = sample_period;
>  	attr.wakeup_events = sample_period;
>  
>  	p.attr = &attr;
> -- 
> 2.43.0
> 

