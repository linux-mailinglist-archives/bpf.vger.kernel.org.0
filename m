Return-Path: <bpf+bounces-34722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23899303B7
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 06:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D111C226BE
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 04:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4A1A270;
	Sat, 13 Jul 2024 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="ahK9aHoY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0B18030
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720846088; cv=none; b=HTyuuwxXvSbRXEQaPF4L5IYsmfEyvm2ajAczq7W1vufUZRGeHv6y8+HXcWDSp0iMVl2bk3JQ6zXuQjEQmxMKXn0Nxma+zpxXpgbYTK3ANg41VbMd7hoApqS9RsktoUuUPurYTqIJuKkRoXXLddSo+QsMX+otUMScZyxcBsEQgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720846088; c=relaxed/simple;
	bh=UijJmrOo4ZD2uvZrUYYwQPAaTVEbfzSehJxIGarFJpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CyZ+ujOiBGwSmIQ/1pCQpN/NNhU32KP64Oua3kR9uSdUJVD3WFggIN5+BrM2FoxpO5vQAzU+Obg7r424RjX+gITs+jHbAUJwmkvY4k89wcJKN8ztPiOC9uwqwNmNDjku32kZJ+fFjiST44p4+9IreNCHMu6+gkXnpUOzWP0W0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=ahK9aHoY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so33372181fa.3
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 21:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1720846085; x=1721450885; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6hu/qr0AvU5O+DQMWgrZwZe/xsx8zdzsw60vWw30Fo=;
        b=ahK9aHoYSKErrbvs8tZtOwaixEzdWegcPVo3ZV6Aytlws0J53PVD/0n36HvIoKVoMD
         xYw/vw14I6OMYjNCxeipnSmlO65YIug9b+XRWy3u7U4aT6/NJSlyNP14hn0Sbt6KdeEQ
         qKmcCd6iRM8EaCkoNR+UJVOF8bhlmYUzcoBEgyFsQ+t3cobzSOetDF+5qkMpvdj5KeAA
         dSSf9WjQ6cYsYHnDcTnZnZnFGLxUCmW6+JGu6DADDsoQe4MNiQLNn4lS4g4oZSPP5so5
         HCL8KwEy9DSFFAEopmlg6ED1BGRVLrCgoBMg1FMPirBy1n+hA+It6P30efZo5yh5zRmE
         dkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720846085; x=1721450885;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6hu/qr0AvU5O+DQMWgrZwZe/xsx8zdzsw60vWw30Fo=;
        b=hAHuAoeePvcegJUSuTgAAhFrRQZ7ePdHG1geaJsWCibSb1+tSir4a/JvsxtGUYzNLU
         a1JNNgLUJQBVFz75jB/IkAT3sBlyQ/fW+X+rSoSQ4MyLVWmMZPyLmDs+72j6Oo1rd0B/
         MR7e2SSJe/z6gudboBnswbvL3X/pAa97doQo6e/lXQc0R5ltFgZt8LBp/ar1Sog/nWPw
         WA0Qp/KD5/pU86/bHtL/jhBL+OXn4IYbxJM4A4grIBZrGJAGEP06u5iP3Xj7wC+m4G9H
         iEP2HDNfvtFwWzDwO5mHwplKWkQB/5A1YX193Bj21lkqoOlq1yxSyrtiuzwpRu7rRrnn
         bCoA==
X-Forwarded-Encrypted: i=1; AJvYcCWpIb+6069nbjWFo8bXoux9mcvHcTdZENqi2dT9pXVyNdbNOrCiJgAJyRxn58f+2aHuVK3wV7o988ZF5SIe4/YMLg0P
X-Gm-Message-State: AOJu0YzVz9KSWWh0Gtm0z+O7ijKARiHDNP8lT7B8qWJ019Nth9pP4uwj
	JBQXdqY2DcEkOtsj1t3otRNxYhE8qLetvSGSPss1XVlhDIr1gN8zTNhYLS1jRooTWSmIUXo2bTF
	NTpQ4iBcRIqas/ae1jc1KLPqhaS3pjERytr/6
X-Google-Smtp-Source: AGHT+IExodKhWYEfarw1gh6skTTSLZwAi9xw81nKZqkKgixkPu0uBZdaEFwstoKovnEYxh0LY4nADJE0WOp//9PpA8M=
X-Received: by 2002:a2e:9b07:0:b0:2ec:422:126 with SMTP id 38308e7fff4ca-2eeb30fd474mr83286111fa.30.1720846085055;
 Fri, 12 Jul 2024 21:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2> <ZpGrstyKD-PtWyoP@krava>
 <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com>
 <CAP045ApsNDc-wJSSY0-BC+HMvWErUYk=GAt6P+J_8Q6dcdXj4Q@mail.gmail.com>
 <CAP045AqqfU3g2+-groEHzzdJvO3nyHPM5_faUao5UdbSOtK48A@mail.gmail.com> <ZpHOQoyEE7Rl1ky8@LQ3V64L9R2>
In-Reply-To: <ZpHOQoyEE7Rl1ky8@LQ3V64L9R2>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 12 Jul 2024 21:47:51 -0700
Message-ID: <CAP045Apejcgz4A7jkevts25hKzzxYCzGeKgkbSZUwpC24YY4YA@mail.gmail.com>
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
To: Joe Damato <jdamato@fastly.com>, Kyle Huey <me@kylehuey.com>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	acme@kernel.org, andrii.nakryiko@gmail.com, elver@google.com, 
	khuey@kylehuey.com, mingo@kernel.org, namhyung@kernel.org, 
	peterz@infradead.org, robert@ocallahan.org, yonghong.song@linux.dev, 
	mkarsten@uwaterloo.ca, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 5:45=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Fri, Jul 12, 2024 at 04:30:31PM -0700, Kyle Huey wrote:
> > Joe, can you test this?
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 8f908f077935..f0d7119585dc 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9666,6 +9666,8 @@ static inline void
> > perf_event_free_bpf_handler(struct perf_event *event)
> >   * Generic event overflow handling, sampling.
> >   */
> >
> > +static bool perf_event_is_tracing(struct perf_event *event);
> > +
> >  static int __perf_event_overflow(struct perf_event *event,
> >                   int throttle, struct perf_sample_data *data,
> >                   struct pt_regs *regs)
> > @@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_even=
t *event,
> >
> >      ret =3D __perf_event_account_interrupt(event, throttle);
> >
> > -    if (event->prog && !bpf_overflow_handler(event, data, regs))
> > +    if (event->prog &&
> > +        !perf_event_is_tracing(event) &&
> > +        !bpf_overflow_handler(event, data, regs))
> >          return ret;
> >
> >      /*
> > @@ -10612,6 +10616,11 @@ void perf_event_free_bpf_prog(struct perf_even=
t *event)
> >
> >  #else
> >
> > +static inline bool perf_event_is_tracing(struct perf_event *event)
> > +{
> > +    return false;
> > +}
> > +
> >  static inline void perf_tp_register(void)
> >  {
> >  }
> >
>
> Thank you!
>
> I've applied the above patch on top of commit 338a93cf4a18 ("net:
> mctp-i2c: invalidate flows immediately on TX errors"), which seems
> to be latest on net-next/main.
>
> I built and booted that kernel on my mlx5 test machine and re-ran
> the same bpftrace invocation:
>
>   bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] =3D count(); }'
>
> I then scp-ed a 100MiB zero filled file to the target 48 times back
> to back (e.g. scp zeroes target:~/ && scp zeroes target:~/ && ... )
> and the bpftrace output seems reasonable; there are no negative
> numbers and the values output *look* reasonable to me.
>
> The patch seems reasonable, as well, with the major caveat that I've
> only hacked on drivers and networking stuff and know absolutely
> nothing about bpf internals.
>
> All that said:
>
> Tested-by: Joe Damato <jdamato@fastly.com>

Thanks, I've sent a patch formally.

Hopefully this can slip into 6.10 before it ships.

- Kyle

