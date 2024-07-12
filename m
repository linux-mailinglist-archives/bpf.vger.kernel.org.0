Return-Path: <bpf+bounces-34705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BE930212
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 00:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821061F22E07
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62861FD7;
	Fri, 12 Jul 2024 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjTegZnc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E21BDC3;
	Fri, 12 Jul 2024 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822713; cv=none; b=q5fFff2CxGuM6KYeigSy+dzSmkOH7ixf0vqivvyEs73NXSYcnql3ASaHGNOrEI1UB6VEeQpcfntOLsJ227I3ouakKbJzDZnY1sXlITRHYLjPmMbpvsKnBlsH5tGyPZ+6iZLMgzx3al7CyP68hYscseCsCKEyJslBIS46CBrGPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822713; c=relaxed/simple;
	bh=3Yd8//CkFdri8ix2BgzZkcKGGDyp6VbpdPgbhhaFr5Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhIBm60cSnUI0RqH7yDnrbCleKOlPT0YKistM9SNYrNdbrDrN/6huOzxrdATnkyOT0B5fVz7Fe8Ls3QHVowm/FKi2im1YbFWsMx/Zv36ahpmggkke1novoVFP26ecqHvRCVZWKsPs8Y3BJIKhslqfE41wWK617Bs1Hpv+TeB4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjTegZnc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4277a5ed48bso17832155e9.2;
        Fri, 12 Jul 2024 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720822709; x=1721427509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gp997xfVUy47LFNuWEWNS+olZrom40X4hD1oREeaYw=;
        b=GjTegZncTbnEywxJttSRz7WGAv/9JHT6BF1ciCjegPMJnI1LC3VoAkATj/g5J3LU5y
         9WcnplEBK8UsJMWmAcjWTsGhWOZiE71/ps9Sm3/WO7YewWmBJccdocA5CBJ5VbimpTBX
         NcWL0rPAIlmqIJTQru99buZbbRj2OsdkLl+r1HPJz++s9CfafPpDTScjDJkkx4e/fEb/
         euR+8DxDt6udam4Qegsqn/xv1mANIFjHs1Pv6jOEmX+1ZfYtXSn9yIkCUSDfVv8lcRfN
         /XfDrWBkna1CV1WS+32EugLH4i+cTTlcKNjDIMhQ7KUzg/MoALRA2R8WZIC+voAAbhFo
         Jqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720822709; x=1721427509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gp997xfVUy47LFNuWEWNS+olZrom40X4hD1oREeaYw=;
        b=vi/I37c+dP2x6h2NJU5XR8l7lXHjEfvpa5Y32LcnsD4cny5CNUT7QjNpmyVORtsqLa
         ZpUJtTy5ECQRC0wFbcM6WcPvDK+23olJQY2nz6iOyZvsOU9G+56LNGQSsqK/ePpBCdEs
         5gNk+jOx1l0Xnw52j+h3J0yJNf/G8SllVwUZ2oYGdvKPKVaW+3E71I3wao3hPalCsZrX
         oEQDf5BwnS6ezsn49XzFAf023upgvagt51HcVTb/DcO+HuB5AFjndM34U7zpG/R0uZEi
         Dd+Rb837ZH6pkJx/u4G3kipLs03aT/y9BbX5r1eOJzicQhqBmJ/iDYe36PpW34QszPMb
         BOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCXwTMQfnKbbzw3+uEtyWD/8CBh/KRcUDAizSFIgomhHd0cv1paXaBjlF68rManxE9XkQtDSViZ9wkTie6Urh3rlWZ8skdcSeOA4QGUd6kHQO5iGmHBz5OjEx5
X-Gm-Message-State: AOJu0YzGHTqgCY68WkREpWsuoqxLe9dkS9JNsZYs2JIg44Q44sD1sYCw
	JHAZUA99d8Cs+H7TRJ3syb3itYTCxuW9Vdb0eq7Edy7FwNHfON8Z
X-Google-Smtp-Source: AGHT+IFLpQM4YiEssHHVafXpVRO0//qzed86MvSdeVDSAkWApnTdHqlYS9RY2Uvh2+XC5IqgqUYtYA==
X-Received: by 2002:a05:600c:2284:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-426707f81a5mr81179955e9.26.1720822709159;
        Fri, 12 Jul 2024 15:18:29 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa067dsm11124788f8f.78.2024.07.12.15.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 15:18:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 13 Jul 2024 00:18:26 +0200
To: Joe Damato <jdamato@fastly.com>, Kyle Huey <me@kylehuey.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, acme@kernel.org, andrii.nakryiko@gmail.com,
	elver@google.com, khuey@kylehuey.com, mingo@kernel.org,
	namhyung@kernel.org, peterz@infradead.org, robert@ocallahan.org,
	yonghong.song@linux.dev, mkarsten@uwaterloo.ca, kuba@kernel.org
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
Message-ID: <ZpGrstyKD-PtWyoP@krava>
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpFfocvyF3KHaSzF@LQ3V64L9R2>

On Fri, Jul 12, 2024 at 09:53:53AM -0700, Joe Damato wrote:
> Greetings:
> 
> (I am reposting this question after 2 days and to a wider audience
> as I didn't hear back [1]; my apologies it just seemed like a
> possible bug slipped into 6.10-rc1 and I wanted to bring attention
> to it before 6.10 is released.)
> 
> While testing some unrelated networking code with Martin Karsten (cc'd on
> this email) we discovered what appears to be some sort of overflow bug in
> bpf.
> 
> git bisect suggests that commit f11f10bfa1ca ("perf/bpf: Call BPF handler
> directly, not through overflow machinery") is the first commit where the
> (I assume) buggy behavior appears.

heya, nice catch!

I can reproduce.. it seems that after f11f10bfa1ca we allow to run tracepoint
program as perf event overflow program 

bpftrace's bpf program returns 1 which means that perf_trace_run_bpf_submit
will continue to execute perf_tp_event and then:

  perf_tp_event
    perf_swevent_event
      __perf_event_overflow
        bpf_overflow_handler

bpf_overflow_handler then executes event->prog on wrong arguments, which
results in wrong 'work' data in bpftrace output

I can 'fix' that by checking the event type before running the program like
in the change below, but I wonder there's probably better fix

Kyle, any idea?

> 
> Running the following on my machine as of the commit mentioned above:
> 
>   bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] = count(); }'
> 
> while simultaneously transferring data to the target machine (in my case, I
> scp'd a 100MiB file of zeros in a loop) results in very strange output
> (snipped):
> 
>   @[11]: 5
>   @[18]: 5
>   @[-30590]: 6
>   @[10]: 7
>   @[14]: 9
> 
> It does not seem that the driver I am using on my test system (mlx5) would
> ever return a negative value from its napi poll function and likewise for
> the driver Martin is using (mlx4).
> 
> As such, I don't think it is possible for args->work to ever be a large
> negative number, but perhaps I am misunderstanding something?
> 
> I would like to note that commit 14e40a9578b7 ("perf/bpf: Remove #ifdef
> CONFIG_BPF_SYSCALL from struct perf_event members") does not exhibit this
> behavior and the output seems reasonable on my test system. Martin confirms
> the same for both commits on his test system, which uses different hardware
> than mine.
> 
> Is this an expected side effect of this change? I would expect it is not
> and that the output is a bug of some sort. My apologies in that I am not
> particularly familiar with the bpf code and cannot suggest what the root
> cause might be.
> 
> If it is not a bug:
>   1. Sorry for the noise :(

your report is great, thanks a lot!

jirka


>   2. Can anyone suggest what this output might mean or how the
>      script run above should be modified? AFAIK this is a fairly
>      common bpftrace that many folks run for profiling/debugging
>      purposes.
> 
> Thanks,
> Joe
> 
> [1]: https://lore.kernel.org/bpf/Zo64cpho2cFQiOeE@LQ3V64L9R2/T/#u

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c6a6936183d5..0045dc754ef7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9580,7 +9580,7 @@ static int bpf_overflow_handler(struct perf_event *event,
 		goto out;
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
-	if (prog) {
+	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT) {
 		perf_prepare_sample(data, event, regs);
 		ret = bpf_prog_run(prog, &ctx);
 	}

