Return-Path: <bpf+bounces-64371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D17B11E10
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 14:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0864F3BE49E
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141224293C;
	Fri, 25 Jul 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4HzcPLa"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC129241668
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444976; cv=none; b=hqRA2uR2N4Ee9rwjRTzgLTfSU0LIZkFoKdhjEIoYuNCcvekkfGz7LAMYkIVAE4hp/w0YLXZL7Hs9KoEDY3g3mDYwVhZ6iCGAGC/uLnnhIFZtZJR7/LVTeEBBXTZAUnXmALHX2IalkZXSFEZc820AFMtOD9lsERiEDFJkPOEbG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444976; c=relaxed/simple;
	bh=fqZHebi6Bkb5eNifT3yZFGVku7zV66aFMdE+I3t/4aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CB1HBVdx3sv+q6wlHm5h1Ns4BoHtgAqJ+BOYewaz5bFVm51jkI1SzxwfN64kwOxZhBwUTL7mvPoz4uCwKgDOG+GsEBeHPzq/RF+HIMj7yYUCf8BnqXVyonr2hihdYzF4KOf7RmPI+eI8FOJFHHkesv07Cmb66GTwdM/Uav6sqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4HzcPLa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753444973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbQ/CoKfRcOyF5XiIEBvtnbaZCP8pb630WPcqbF6yL0=;
	b=L4HzcPLaXVETLVdu5Q1GBPjyLXP9NDB0FfTQvi61YI6CHXPLbldl8vXQq/YnOnQlJCTRGn
	phat4HHJJMJ9wbEwVWVf/m6xsBmHe4kHyJNzs/G+jhBDNS/rhnbOOmCBN5iLSQDwbXlVv2
	oUXUJMHJO658vhF3YTRBIQ5pNkDjXls=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-kS9jXdJpPje-5sdCUtJmVA-1; Fri, 25 Jul 2025 08:02:52 -0400
X-MC-Unique: kS9jXdJpPje-5sdCUtJmVA-1
X-Mimecast-MFC-AGG-ID: kS9jXdJpPje-5sdCUtJmVA_1753444971
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae6ee7602c7so212834066b.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 05:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444971; x=1754049771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbQ/CoKfRcOyF5XiIEBvtnbaZCP8pb630WPcqbF6yL0=;
        b=joBQMgMR/6hjtYDqTGnrq0Ep8HsRbNKQb0vJ+nOOjV/iphl6Gz0Pkxk61JE2e7gBQq
         aWTg0mHBYzIPjeV6xfOgcSjxTqP/LtoU/TFIfGLUcs+sMa6ClftKi/1ZKGLEws5kdKCi
         fMs722D2bK/5zy6hAe5bbRowelH25HdbJiK1OAyPvZgUKoicVJGGkstiJBCzYGWloNAM
         Azt2tyfhJbQ9s9TIOnqLHUdNf0Zrdn/UaQSJYyx94Jv4TQnMkh9fNg7GZUOq8COP0vqr
         xYC/tnmKLhQOgVhDIuzAVsgMLbgalICrTuC4jnWmNxRf4Tj55K2BD3hs5qsX+0/coGMe
         OUPg==
X-Forwarded-Encrypted: i=1; AJvYcCVUBHlVBbwI/FC06Nm+UvkBzlSkuL2ne3eQveohA2Tu5RDP9q1GFWYCs7AiX3z65eyiYnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nm440i/oaQr5cEk02mti+Ic9C50PzzeYoTYNEsFTF5TdPNih
	bQBrI7+F2hMDuHSMoPnjTvhawjD2WSycxL/1OHwONquaryldEaJB68CSWKfhrEkGZhzBqAGLhqS
	WTO/lTKpxRYREDTsiUpDlNYlEegYdCX5c9v1/QD6ok4WU8muNpkFpbj0snKPUh7tIk9BoHD4fAh
	f7mRFLcYmPm7QyYV/RaLIJPC5p31/d
X-Gm-Gg: ASbGncuW8txLxtp6VfPzcYRLWUqYaFe3mkJ/meaccvFJXMHZY3VKFTVpS4LTNb2CpyO
	MhkiAtmAI7yddyyRr91CF5hG4n/jgWUhsdaq/miunIgCdOzWNoSrwQ5hJQ2bmRLb3clx61KOGpb
	ZMUlsfQzfY3iGTZaYT1zFyPliVQy6oCuGV44D4h5qLpEq/XN+RK1s=
X-Received: by 2002:a17:906:9fcf:b0:ae4:1149:2cbc with SMTP id a640c23a62f3a-af6191fff1bmr211863566b.46.1753444971179;
        Fri, 25 Jul 2025 05:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa3CxGIXlbxFP3lOtiuZkdJlIwaUJx81JfXJ3+HOkhXlu3QfRGy7bD/MWcI9pNg2Pb+acrpaFHuNWexg0NHk0=
X-Received: by 2002:a17:906:9fcf:b0:ae4:1149:2cbc with SMTP id
 a640c23a62f3a-af6191fff1bmr211838966b.46.1753444969189; Fri, 25 Jul 2025
 05:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701060337.648475-1-costa.shul@redhat.com>
In-Reply-To: <20250701060337.648475-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 25 Jul 2025 14:02:37 +0200
X-Gm-Features: Ac12FXwuR1pQjDETnTbqboRWzFRIjKwg3JsbDbHR5v4frWCm-lEfoXogMPmmqq8
Message-ID: <CAP4=nvQMyBMay9unMuz0TmkF7pSmHV39iwinSnc3UbuLvOVa=Q@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Consolidate common parameters into shared structure
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 1. 7. 2025 v 8:04 odes=C3=ADlatel Costa Shulyupin <costa.shul@redha=
t.com> napsal:
>
> timerlat_params and osnoise_params structures contain 17 identical
> fields.
>
> Introduce a common_params structure and move those fields into it to
> eliminate the code duplication and improve maintainability.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---

Thank you for the patch.

> +struct common_params {
> +       /* trace configuration */
> +       char                    *cpus;
> +       cpu_set_t               monitored_cpus;
> +       struct trace_events     *events;
> +       int                     buffer_size;
> +       char                    *trace_output;
> +
> +       /* Timing parameters */
> +       int                     warmup;
> +       unsigned long long      runtime;
> +       long long               stop_us;
> +       long long               stop_total_us;
> +       int                     sleep_time;
> +       int                     duration;
> +
> +       /* Scheduling parameters */
> +       int                     set_sched;
> +       struct sched_attr       sched_param;
> +       int                     cgroup;
> +       char                    *cgroup_name;
> +       int                     hk_cpus;
> +       cpu_set_t               hk_cpu_set;
> +};

Some of these could be cleaned up further. E.g. "runtime" is actually
only used by osnoise, even though it is declared in timerlat, too, and
"period" is also used by timerlat, but it's called
"timerlat_period_us" there.

Nevertheless, that is directly not related to this patch, and tests
pass. We can fix that later.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>


Tomas


