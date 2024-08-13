Return-Path: <bpf+bounces-37064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA13950B34
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8843C280A92
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8879F1A38C3;
	Tue, 13 Aug 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSWMfKR6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2EF1A01C5;
	Tue, 13 Aug 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568861; cv=none; b=M9+2FR2lUwTsuCG486Tuv/S4VXQMiTX3VCcn1sQcAO5VwJNp42TqkBAeZ3RBoAGcR9jW7dZmGXcbDpsCjZp74P7FpsezoG59iDHgp3O2kTFWuuTJxXDE7jL58mSdpeX84s43RuzzXbcPReri4ehymtacWpgZpMfBStulRbOlkOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568861; c=relaxed/simple;
	bh=2UTRpyixsnI2Mt3H9E3lwr3skLjqQavuwS+t2Y5B5ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aquWXHSTXhVy0+iHmzW+gUfXYZ8tbVWWtJb8J5WGArEJpJEZSooObR2A5jZ/mOsDsF/8M/DxrHJuWlEY/c3a6/wtd3xgqkqwg4fEcM1mPGJggEhndvBxnLQyAqejvQbtGvEvsc7cHwEZ78TlRF7MVLHkdNleXmrxSocXnd6nH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSWMfKR6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093efbade6so3872816a34.2;
        Tue, 13 Aug 2024 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723568859; x=1724173659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqDQdMqa6edkrhtgWmvvQHLQOD3Y1jZC7HmcMHP1B7Y=;
        b=LSWMfKR6TO0cQN3x6ScNmj3uvtJUXvzP1czlaGX3XKPUQcRq9uyIvkrq9tWXVePZs3
         YZGFjuBIotwHzzp3NJCqRUGtv2Oopj3aIPX5oE3Gk4nmnwuM7XN2tOla6ixIFHCNalrs
         UnF98INbkkP3Ze+ChqVFOhim5tzKw/ARVdEBEcj+/mFCrogwzoqaX7TWS6/jvimjtkyO
         UJIEp5gEECr7U8tmGIZkrGRqQauWYg5pZr1nVubGkfuHcSpOQ1G68EF3T+rVqwdkFAGl
         WS2ZPYePybqjnv6rLcDdlobEM0UTwhOlWhnk2v/7fhHgGgOvNLZI/rQ6p7BpdyQEQctA
         /Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568859; x=1724173659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqDQdMqa6edkrhtgWmvvQHLQOD3Y1jZC7HmcMHP1B7Y=;
        b=gsfYm7lYly/uSCs1/hSd0eHECYtAgsAYi41vCTuYBuAicUmSLZ8WoSHiY7GjgmAsn7
         vjZE7RQmB58DgSXRFkXGOYshbqy6BSsF10KZl4xiqiU4P9xbKm2dElB+Ev941P2vQkrc
         DVR2Ox7ZR7KKVnwrfmdTOCcTnxjy04bFLSoRHjsHVB52AxERKddMuFHQXorrv4u7ejC9
         gBqXwy4cr018AoDl+A+4yrVv+Jl6UjON8Wfk68swBShMVFUTJb3CD2yJoW2x6BQYh91E
         iHzLrbhYDVQ8W5WTwa98SXus/OkZr4Rb99/wee6fEYBeM/PrxaTG2d/Exz803zqdTSUP
         v6HA==
X-Forwarded-Encrypted: i=1; AJvYcCW6LcDQF+zMWpZTacuUkLR4vUwUmuddX8JAs7gEL+o/pRlzmciquhH+lLQ9rzoaG1mkkyy/h1ZyCfA4A6/AlQxTqnbXKEj2jYSPq7tPWiv2jXVCW2xg6aP6gFZvHnUc9FFqsDboBM6w8doPq/WQbC9J0XXUIj1cuYP2
X-Gm-Message-State: AOJu0YwKWjMBFJ2deErCqVun/ZBW8NitSo69AWlEJDvIsg7EIgyftQlO
	CyqNKvXs240s0SqvWiO1pWOq9I+P/ynLrzGPnAed0UelKdLva4B9hpcCdaYwcXyLeZeG3iniH6P
	GrG6zl8vB8wkhLV2ikSWLNlpH6+9NtITh
X-Google-Smtp-Source: AGHT+IHbYc4Q+YiQBykiM0mnghoF6UZNPJpC/R2FJZoiqWDI4lIHR+ADHM5+gVZ6JC123rB3oqYm4s/9Xh1rty1ofbg=
X-Received: by 2002:a17:90a:c84:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2d3aaa7af67mr200689a91.3.1723568847980; Tue, 13 Aug 2024
 10:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813151727.28797-1-jdamato@fastly.com>
In-Reply-To: <20240813151727.28797-1-jdamato@fastly.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Aug 2024 10:07:15 -0700
Message-ID: <CAEf4Bza1C1X+t7xbU1rRAMG1+oy=UoZyyGPaBkFJ4_tVQMJQsw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/bpf: Don't call bpf_overflow_handler() for
 tracing events
To: Joe Damato <jdamato@fastly.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, peterz@infradead.org, andrii@kernel.org, 
	mhiramat@kernel.org, olsajiri@gmail.com, me@kylehuey.com, 
	Kyle Huey <khuey@kylehuey.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:17=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> From: Kyle Huey <me@kylehuey.com>
>
> The regressing commit is new in 6.10. It assumed that anytime event->prog
> is set bpf_overflow_handler() should be invoked to execute the attached b=
pf
> program. This assumption is false for tracing events, and as a result the
> regressing commit broke bpftrace by invoking the bpf handler with garbage
> inputs on overflow.
>
> Prior to the regression the overflow handlers formed a chain (of length 0=
,
> 1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
> bpf_overflow_handler() to that chain, while perf_event_attach_bpf_prog()
> (the tracing case) did not. Both set event->prog. The chain of overflow
> handlers was replaced by a single overflow handler slot and a fixed call =
to
> bpf_overflow_handler() when appropriate. This modifies the condition ther=
e
> to check event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT, restoring the
> previous behavior and fixing bpftrace.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Reported-by: Joe Damato <jdamato@fastly.com>
> Closes: https://lore.kernel.org/lkml/ZpFfocvyF3KHaSzF@LQ3V64L9R2/
> Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through ov=
erflow machinery")
> Cc: stable@vger.kernel.org
> Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
> ---
> v2:
>   - Update patch based on Andrii's suggestion
>   - Update commit message
>

LGTM, thanks.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aa3450bdc227..c973e3c11e03 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9706,7 +9706,8 @@ static int __perf_event_overflow(struct perf_event =
*event,
>
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
> -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> +       if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> +           !bpf_overflow_handler(event, data, regs))
>                 return ret;
>
>         /*
> --
> 2.25.1
>

