Return-Path: <bpf+bounces-34714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 147DB9302D5
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 02:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EF4B23E4D
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9E9457;
	Sat, 13 Jul 2024 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bqX3/N98"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DB748F
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831560; cv=none; b=VJ3JdX8alVdw2l+5EBPfqCtpJr0G8R/Uion5TNm8NLykv4CYEmf9UeSECXDVD3rM1b9ywP5AaAuDdISAl6Vk/R1RDdCuIFpur6rq/7ku2VQy1q0pYW1fQSYqNtqFWoHmo9996ZtrNLJcKLmy57k6pKaGy5D2yH/GrnG7mTFTOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831560; c=relaxed/simple;
	bh=fIeC+An8Bolk7ryUxH57g7EED4R3JHcxo9Xw3ewYCag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU6tfjIdbb/kygPCxjVtBzNhj0lNJ9O5ODd8mZnJLSKCASmrySrtF3xwQbu3Qv9D6K79RgwAoc+dG+FCt4CdhSSx+13wmTkPd9NOC6Lc0XVHuS/HbqiQwCJEnfie5pgM7dJgUsXwVfIvy/ArcfmCqIJ2jiuy6u0Z8KMJqPbMn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bqX3/N98; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so1703210b3a.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1720831558; x=1721436358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dW4zTFHOtzR/wwPx1Zay5ljlIiuZLQskqd4uueA0+2Y=;
        b=bqX3/N98t+U/N9aESe4MeB4CFUyQ49wotzpLFJgKHHZGuRJWJlg+fkJZdJm+q4YAa2
         K2FVaAkxBk6ZfSGIsRdUAMWFydmmuhf3+BgWJqSmBR70LSLPho/4f7kFCRjiJZYKhDRX
         6qWAYgOP7Dm/En6SKS2fQCsgXRZixxtW6teUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720831558; x=1721436358;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dW4zTFHOtzR/wwPx1Zay5ljlIiuZLQskqd4uueA0+2Y=;
        b=qXpAi2Yg1NoerKXxPYZUhuif4rK/L+85sF8X2Wp/9SpEd5+jjrDRrBhjUhlEPctww9
         Dd9PIbnKPP8bZH44AK9oHfuwJI8NdyA1mW81T3HelhtXtnjwy0fpE/yCPQzaryWlrr3n
         VcE/Ga7asnUorQbY8O1QzF9NFCd3puW+CNrRUaZ7YjhcDBPC21+sPdBqRfrWUQf4GshX
         WD0oXr+sn+nR7WG4tuat8Ty8eZkVUTzYOALJ7PjqlhFGMlaEIcxva0Zk7ZSlXsr2DySm
         10pdUd385z4M9YfettO6DdchuNFg31lADO7aN+e6sWb6WObTww63gzLuEuoBRkeneTzV
         mKYg==
X-Forwarded-Encrypted: i=1; AJvYcCV49pE1e4eol7W8HC8TtKLagWgVG/Hf4BZf55B5Upe0hGvNRRfXHWAYsEFpiNu6tNSEm8F0JMN55ZnkPFAPzX0TTWTZ
X-Gm-Message-State: AOJu0YwnfT4Apr8vZAv6J2xYl3DQWxYFuxPzG/9yB7KiBP4qzw0wkGZX
	Ws6WY4vr77XFX04M+ujvcnoxPw22IdZFSUF1qknFXC8rZKkllVe1zlCt9L9PN1A=
X-Google-Smtp-Source: AGHT+IHoPtn3Alyl3FZi++726JDLvsj5bOjq0G1Q9EoK3jyg4rB7GE4Kv5UyyYhw1tM2Dc6MPFlM8A==
X-Received: by 2002:a62:e915:0:b0:705:cc7d:ab7d with SMTP id d2e1a72fcca58-70b6c884c43mr5316300b3a.5.1720831557735;
        Fri, 12 Jul 2024 17:45:57 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e226sm145706b3a.27.2024.07.12.17.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 17:45:57 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:45:54 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kyle Huey <me@kylehuey.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, netdev@vger.kernel.org, acme@kernel.org,
	andrii.nakryiko@gmail.com, elver@google.com, khuey@kylehuey.com,
	mingo@kernel.org, namhyung@kernel.org, peterz@infradead.org,
	robert@ocallahan.org, yonghong.song@linux.dev,
	mkarsten@uwaterloo.ca, kuba@kernel.org
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
Message-ID: <ZpHOQoyEE7Rl1ky8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kyle Huey <me@kylehuey.com>, Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, acme@kernel.org, andrii.nakryiko@gmail.com,
	elver@google.com, khuey@kylehuey.com, mingo@kernel.org,
	namhyung@kernel.org, peterz@infradead.org, robert@ocallahan.org,
	yonghong.song@linux.dev, mkarsten@uwaterloo.ca, kuba@kernel.org
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2>
 <ZpGrstyKD-PtWyoP@krava>
 <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com>
 <CAP045ApsNDc-wJSSY0-BC+HMvWErUYk=GAt6P+J_8Q6dcdXj4Q@mail.gmail.com>
 <CAP045AqqfU3g2+-groEHzzdJvO3nyHPM5_faUao5UdbSOtK48A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045AqqfU3g2+-groEHzzdJvO3nyHPM5_faUao5UdbSOtK48A@mail.gmail.com>

On Fri, Jul 12, 2024 at 04:30:31PM -0700, Kyle Huey wrote:
> Joe, can you test this?
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8f908f077935..f0d7119585dc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9666,6 +9666,8 @@ static inline void
> perf_event_free_bpf_handler(struct perf_event *event)
>   * Generic event overflow handling, sampling.
>   */
> 
> +static bool perf_event_is_tracing(struct perf_event *event);
> +
>  static int __perf_event_overflow(struct perf_event *event,
>                   int throttle, struct perf_sample_data *data,
>                   struct pt_regs *regs)
> @@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_event *event,
> 
>      ret = __perf_event_account_interrupt(event, throttle);
> 
> -    if (event->prog && !bpf_overflow_handler(event, data, regs))
> +    if (event->prog &&
> +        !perf_event_is_tracing(event) &&
> +        !bpf_overflow_handler(event, data, regs))
>          return ret;
> 
>      /*
> @@ -10612,6 +10616,11 @@ void perf_event_free_bpf_prog(struct perf_event *event)
> 
>  #else
> 
> +static inline bool perf_event_is_tracing(struct perf_event *event)
> +{
> +    return false;
> +}
> +
>  static inline void perf_tp_register(void)
>  {
>  }
>

Thank you!

I've applied the above patch on top of commit 338a93cf4a18 ("net:
mctp-i2c: invalidate flows immediately on TX errors"), which seems
to be latest on net-next/main.

I built and booted that kernel on my mlx5 test machine and re-ran
the same bpftrace invocation:

  bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] = count(); }'

I then scp-ed a 100MiB zero filled file to the target 48 times back
to back (e.g. scp zeroes target:~/ && scp zeroes target:~/ && ... )
and the bpftrace output seems reasonable; there are no negative
numbers and the values output *look* reasonable to me.

The patch seems reasonable, as well, with the major caveat that I've
only hacked on drivers and networking stuff and know absolutely
nothing about bpf internals.

All that said:

Tested-by: Joe Damato <jdamato@fastly.com>

