Return-Path: <bpf+bounces-38952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2B96CDA4
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 06:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BC61C2248A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20F14E2E6;
	Thu,  5 Sep 2024 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="HSwXM8pM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884848CCC
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509857; cv=none; b=BTr/CqKWk4exkDh/7MW9W/l6YmwMvZE6Ck+KpopUZ1FMm8gsubbgy0aNc+MVe8RyaOsswPWdxO28K+E1G6wl6CwRyEkTsS8/Exxjwqkf6X4NK4BuPR9iFOi7zPcy3o0p0dDhRA5TS4uVPFqXnPpMwUVTuoSgNSKksFn9zWiFV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509857; c=relaxed/simple;
	bh=Fqd5O56HcItsOWd+CIxphksTg7QoKAyjJrEQgL7KOdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlHjZY0azYK+J64p8f8aQBn6WeeXAhmVu4OXrneHyZHLzbFflBDL/Y6rkdcjHvQb7skqNV7/mEWQLUxHcf9G0xMFYbQ3PJEtqAsMWyJ2S9ThYzXU/aunoSBiYaOSqS1n86BfeL/AykGV6ek+OPAupN8TmCGVczo1OjyfAbma9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=HSwXM8pM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f51e5f0656so2855981fa.1
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 21:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1725509854; x=1726114654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZdaH3PSCdfXqojPbX1szrhoVgPytj7gd3rO+WjcE80=;
        b=HSwXM8pMdHb8sh9Hlu5zuOzQGNrzYgZu5Y2Q7nDXbtzZeN2thqqSd+kQQnYtM/DTJg
         NR3DAq8Sy07l3NOCXFszyy8wUnY5sa5qwln+y02v+jk5hgccXbZ3ka0MLA4/UR49HNS5
         ht/SyeezqV/vt1l41Jwn9Q+ul8Y9JJTD6CV5BebnZM7p5MM8bSPNAFZ89FyxR8blhsnT
         FP0DSTLUYIMUwi7r5Nt93XoTFNDMXJOmNEkvQGZY+8PNGgvO+VR32ySBDTZXAFt0zZim
         TmibVnhlDiWsPId0mUCw1q0THChjawUODCQOtbr3/hVElEgCZyBOxkKBs4leCyKR+POS
         MoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509854; x=1726114654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZdaH3PSCdfXqojPbX1szrhoVgPytj7gd3rO+WjcE80=;
        b=KXL5uD3vjUEl0CUCAHURY5ThkzvPHiW/uSUa26WED1Fq7w9W7tC1o9+Y049X6lugsS
         iqacZnCF82X8NFAHEhx6+Hjy1cYLc2ws8XAcc9gkIR9BqdyCoTMi6QDZOtw46xzb4ggc
         H20VZE8vLM3hvdOU3X+jfrME8VeU5QquCpxDZ23DJ2Ul9dVbd0s4bUz80poB6pfXH1lv
         ZQmknIkdPbdJqg10QoMc9peLbq9nm/I3QW2jjcGwxkDbxrr+5b61I2jCeULOj1a+HPsz
         vT5gl4ntSmFENeurVBnsL1XxEJLp9im6vMxcBPlUC1BnJmfcWrhHz1jQcAinIm2Wo68K
         dFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiAqzydBnNrXpsUzxRz+pCbzXK4jmrR/F2PpEO0M/mrRnhQ9pb3CfeuFJFhcxA8p/qbDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMCYb3b9SbM7tHMPDICFddw8GsB/lLNIaSx/Jk43BlmTj3/+g
	HUW3EGcqEXn7NO5n8riKy5vhyGJWTKiHSddUmoffNzIsgUlXUGEXw9334RTGn6DDkoff2cRr4vP
	Nkcke9UhGoCXfWMUZMNhCzxaadNyBLOCLxNI7
X-Google-Smtp-Source: AGHT+IE73Ld+RvK+KL878z4MoxnyKJHscGUwUvnaaZmXyON2fN5Wq13RRHi88y8AHu+BjAgfFxuSSsTRy+y6fOjCcPY=
X-Received: by 2002:ac2:4c53:0:b0:533:d3e:170a with SMTP id
 2adb3069b0e04-53546b92ddbmr14763907e87.38.1725509853875; Wed, 04 Sep 2024
 21:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905031027.2567913-1-namhyung@kernel.org> <20240905031027.2567913-4-namhyung@kernel.org>
In-Reply-To: <20240905031027.2567913-4-namhyung@kernel.org>
From: Kyle Huey <me@kylehuey.com>
Date: Wed, 4 Sep 2024 21:17:21 -0700
Message-ID: <CAP045Arcn_zrQvzv+4ihCXOPgcsuMVe_VdgR-cny63POaT5g-w@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf/core: Account dropped samples from BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Like in the software events, the BPF overflow handler can drop samples
> by returning 0.  Let's count the dropped samples here too.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Kyle Huey <me@kylehuey.com>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8250e76f63358689..ba1f6b51ea26db5b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9808,8 +9808,10 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
> -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> +       if (event->prog && !bpf_overflow_handler(event, data, regs)) {
> +               atomic64_inc(&event->dropped_samples);
>                 return ret;
> +       }
>
>         /*
>          * XXX event_limit might not quite work as expected on inherited
> --
> 2.46.0.469.g59c65b2a67-goog
>

lgtm

- Kyle

