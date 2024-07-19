Return-Path: <bpf+bounces-35110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A0937C70
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1E4B215DA
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50FD1474C5;
	Fri, 19 Jul 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmla9yD2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADBA1474A2;
	Fri, 19 Jul 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413598; cv=none; b=EiIGedNP5AzqoiEflZS3NuNhhmnrc2aBNqJVTvia7JZldlxV7mt+ktezCPTNom8BGh9qrEjchdPFx5illB6a9L3qRWenOJiOkC+pepNHIKnSenF60RPNZ6DJ7d6PBryatWZZhaj/azvse1R9/onpSV1I9vg/4Uum4jUjtfbaGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413598; c=relaxed/simple;
	bh=FosQinJbiA37WI0vd+qHjJwqqu3UJhQCxmg/KE2ILbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvtnyewsNeLO3iDQj9duu8U52fHt6x7GiySpIBm6MVwdrHRhQv2E1rht6A70VyU7xAsT5SFEC//g52ikA4sy4k5N2Ys53femCfkmyR3iAq6ofI3LhHqxFAIwzOwEwWtzRKypx6HI5e7NNyuJb1nDa3z7wg1x08Vnsrvj5LIcZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmla9yD2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-71871d5e087so1640371a12.1;
        Fri, 19 Jul 2024 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721413592; x=1722018392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/4z5WGYjbp5RbcWoKnIxhAk9j+Ohb2FZw2NnZi8vBo=;
        b=fmla9yD26DP2ZLYh+8E8pKh6hDcHZn2crSZRb4eO1bCKCWbDHI9uSpuOiq4zX7Boku
         +0y1RfPm97zjoM/FjBWBNUaVTlBTnae49TcfOWwEjwqzJ1I3dJCTrI9rT+igl+oLbj+P
         MwMJhul8C5hlaU/32LG+LaQKYtGsJtFQ6K5QID5mH5nRkGMOsY7BqEdt22HAATicrKXy
         RtjPCCHprrC2KrWlywjwl/Bkpv+nZxGrMxLcVwjieHdqQQLix+BhHEN8CyCl3T8in8il
         mf4ml6oz3mGL5DIWQaSHBafqDu2JMibPWL66DbP+kPX/fQ/INV1QU5PZ26kvnN42u0W9
         E2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721413592; x=1722018392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/4z5WGYjbp5RbcWoKnIxhAk9j+Ohb2FZw2NnZi8vBo=;
        b=skzvVb21AIniFSqEtQ45oEnoE68jAgcwdRIX0U4Emdr4whOiDfl7XDypD87syLcAQR
         36C9Q7bW5nOjGaIUp4NNI1q/8xFoeYJPhRH7zajZ30fdpWOyxrls1J89OjqudC+mW6Mu
         f8xrd4rG30XZzxisOns1AzpvZG+BCEg+TN5WLK1HF87qHPPrXO92Z8n7jKKzpwaJiIIS
         V2IEfdbzhVTVdAmIi3WJaXSFG/cQOendNKpLsHEXrpyj+Y7PeJXjqwB3jtWE3dGmhmVM
         +AGSAx1EeQ6vXpRLPbOG4e5qga7NKMhVnGqSIvApjqNa60cApb+19Qg08XcqPdAAUiz+
         5JRw==
X-Forwarded-Encrypted: i=1; AJvYcCX1I2hZBUKkbA1ZyMzgIjryyP7/N+clJNeKhqMSDQCITL4oYto28JHOe33fzntxfCzAb3C/PlIFkcN+kwPVgq9nCQTy/YfLQSCvScJ41bzxhEek7sJVfah0+q3AOTSxGi8teP5t/WKI3E6C1I1KVBYtY4uN7jkdwUfVawrJain6HX44Pg==
X-Gm-Message-State: AOJu0Yw7XnDs2zyMej5Hs35c5MvMy8MQfh4ZlqDQXdGqq6ru6M1tkTD5
	APIl7VVqJ2JMMARjPtQTdYQGXTq8ESLaPPTnK8iNzDJ4VltDgGpn0j3L07uuQeRWNM3ZSbEqvve
	d4qWNqvp0WX9DsJlHvQl1vQzq/t0=
X-Google-Smtp-Source: AGHT+IH+wR4Fw/nrSfe0ufCbWQSd84tI9lwsnKgiRHj4KRiJfbwkjptt7LbtUl1dQaU5M5y3yV8cytEGmmYBUIWSDo0=
X-Received: by 2002:a05:6a20:7485:b0:1bd:18ee:f145 with SMTP id
 adf61e73a8af0-1c422855890mr1262174637.1.1721413591746; Fri, 19 Jul 2024
 11:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713044645.10840-1-khuey@kylehuey.com> <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net> <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net> <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net> <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
 <ZpYgYaKKbw3FPUpv@krava>
In-Reply-To: <ZpYgYaKKbw3FPUpv@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 11:26:19 -0700
Message-ID: <CAEf4BzZWWzio9oPe2_jS=_7CnKuJnugr2h4yd3QY1TqSF0aMXQ@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kyle Huey <me@kylehuey.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Mon, Jul 15, 2024 at 09:48:58AM -0700, Kyle Huey wrote:
> > On Mon, Jul 15, 2024 at 9:30=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
> > >
> > > > I think this would probably work but stealing the bit seems far mor=
e
> > > > complicated than just gating on perf_event_is_tracing().
> > >
> > > perf_event_is_tracing() is something like 3 branches. It is not a sim=
ple
> > > conditional. Combined with that re-load and the wrong return value, t=
his
> > > all wants a cleanup.
> > >
> > > Using that LSB works, it's just that the code aint pretty.
> >
> > Maybe we could gate on !event->tp_event instead. Somebody who is more
> > familiar with this code than me should probably confirm that tp_event
> > being non-null and perf_event_is_tracing() being true are equivalent
> > though.
> >
>
> it looks like that's the case, AFAICS tracepoint/kprobe/uprobe events
> are the only ones having the tp_event pointer set, Masami?
>
> fwiw I tried to run bpf selftests with that and it's fine

Why can't we do the most straightforward thing in this case?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ab6c4c942f79..cf4645b26c90 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9707,7 +9707,8 @@ static int __perf_event_overflow(struct perf_event *e=
vent,

        ret =3D __perf_event_account_interrupt(event, throttle);

-       if (event->prog && !bpf_overflow_handler(event, data, regs))
+       if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EVEN=
T &&
+           !bpf_overflow_handler(event, data, regs))
                return ret;


>
> jirka
>

