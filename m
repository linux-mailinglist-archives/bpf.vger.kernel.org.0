Return-Path: <bpf+bounces-42948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CB9AD48E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52B42831F5
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2411D220E;
	Wed, 23 Oct 2024 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja7hogne"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA614658F;
	Wed, 23 Oct 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710825; cv=none; b=ftRbIehkS4KNyM8Q78Ax/OUmrG8J9sA8kBR6wBw92nX9UutPvblLtf7egw6AHXfuIc+3/7tsJQ3Y98NfgIyl4oONwUhcYX7G4D4gOlc8jLZE45guyUjnh3Qcziffof7BvbwxJ+emVtxwMW4aMGr3sLkgec0VgZscO6MP2ftwLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710825; c=relaxed/simple;
	bh=9AQgZ7+FIb1L7dgfLf3DR6hd0fpF358yKantQArKLvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfGZgmuCvP94RwCV2cPFlSxkx6ZO3AzzsEV/VWneNapWS8mgmDE5dSV+UDlXr3JgIllWxbreOJv5HhtGicf1snZHhwIT9W2zWmo3ShNQK9Pv/Be0KwRFY+SgYDtbr/BVufH0iJJ80Z78hiVVBSXIXPOH8h9h4fPOx9JrIHKXzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja7hogne; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea8de14848so77870a12.2;
        Wed, 23 Oct 2024 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729710823; x=1730315623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PhhR3wHCcsTCopqz6u1CHMxyr/88Bf0Yu3S5Jd2Hjo=;
        b=ja7hogne2UJOfrOz3ad9pugG4NOHqwP9ZLCk9SDAcN+an9AOnsneGDkjfg226ZPDEX
         S4uNP+zcgXC1xOSnIrI4u6p8tSM19mIcRGZWMvZ+1HLqREMruxuMkep2wweTfYV8oGxt
         uWFfyeN7rnfqDpqnwji7D0xZjUNGE0lS2dXNLkecYC5VlH+ycnBcloQ9IBpZ1PbQfkkP
         jCI92RkYI+kFD9zIppB7pzdmnyhOK6+tmYREjjqa7JsE7Ae1JskUe99gI8jR+oVr5kcw
         RtjYIf6T0LWy4LaMJK7ePQAqO9W0195mVOZJ+0JGg9vvOVjRPVp/HcJjkC9hLSt60jJq
         LiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729710823; x=1730315623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PhhR3wHCcsTCopqz6u1CHMxyr/88Bf0Yu3S5Jd2Hjo=;
        b=RAW9bs9fA/c84LIS3CzxsxTbbPC2huCWvfTlA/FnfO0FdLr0lvyM8sDfiEGXXkYTDM
         zm95jDpnM963dV4pRi/rhknh9aP+DCADQ79QRnUT+iTENm/k0jFsbXo+/tvgmS0Y0TB/
         5E2aFdnpB0M4obiAWDAm2T2Fb4pVumVU8fRLYYXhE7Bmv7o+X29cEd+K2yymnELMwoW8
         AZ+9QYrCR+bHyFjZz+g6YEjRtqKiFcZhxCpvGX6enSyY5MVqNLDkcZ/vINh90X69aK1f
         eSnF1MPc8wj2XATPKUELtJmcxfxghODiFrHCVbM8d003/DTOOdLImZzWOaPw95Mh3go3
         2jZw==
X-Forwarded-Encrypted: i=1; AJvYcCUO8FOO9EEPJLNm1uK4Wpt+/UW5P2iCBb2p8j4HTolF0LqwBQoJTlitb9Qi6tqmg99xsTml6bbqx8AsY0s6@vger.kernel.org, AJvYcCXUljx9+S1Ty+z7CXxGsVEhbsOQMCHgFQE79TtjBJGrCIOuo5bGCb/UtH7JM0r3fTWezzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUYeF0cmU9hErkRmQqImCJeOunzV+880Fmbltm2axSFyH4ieO
	cj2fNgDXOF51yehZxYuF8Tw9+ri8H1YkE4kRJq+DimPkBcDFtp55WNhsxvhxQK+ix3uHXhuKESv
	T3h11dUvFh3H9j43m1I8X8PuL1yc=
X-Google-Smtp-Source: AGHT+IFm91VxEFern721PUgIeGERw+98WQY1hBk9HZfCqxDSeCOujJX+cbbfpL4o2O/E12brbUtY/a2BX018hdiDR+k=
X-Received: by 2002:a05:6a21:3213:b0:1d9:15e9:97d with SMTP id
 adf61e73a8af0-1d978bd61f6mr3733857637.49.1729710823383; Wed, 23 Oct 2024
 12:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023000928.957077-1-namhyung@kernel.org> <20241023000928.957077-4-namhyung@kernel.org>
 <CAEf4BzaoWnUdO0OrmztT1NK62eVzYhFsUiD_E-hY5=oY3E-VeA@mail.gmail.com> <ZxlE2jEUzpt0WcFJ@google.com>
In-Reply-To: <ZxlE2jEUzpt0WcFJ@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 12:13:31 -0700
Message-ID: <CAEf4BzaTGSK3ftjuN9sDA7KrBfWsjj7PcGYaJy55X9cHYQT9TQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf/core: Account dropped samples from BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Kyle Huey <me@kylehuey.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:47=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Wed, Oct 23, 2024 at 09:12:52AM -0700, Andrii Nakryiko wrote:
> > On Tue, Oct 22, 2024 at 5:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Like in the software events, the BPF overflow handler can drop sample=
s
> > > by returning 0.  Let's count the dropped samples here too.
> > >
> > > Acked-by: Kyle Huey <me@kylehuey.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  kernel/events/core.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 5d24597180dec167..b41c17a0bc19f7c2 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -9831,8 +9831,10 @@ static int __perf_event_overflow(struct perf_e=
vent *event,
> > >         ret =3D __perf_event_account_interrupt(event, throttle);
> > >
> > >         if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PER=
F_EVENT &&
> > > -           !bpf_overflow_handler(event, data, regs))
> > > +           !bpf_overflow_handler(event, data, regs)) {
> > > +               atomic64_inc(&event->dropped_samples);
> >
> > I don't see the full patch set (please cc relevant people and mailing
> > list on each patch in the patch set), but do we really want to pay the
>
> Sorry, you can find the whole series here.
>
> https://lore.kernel.org/lkml/20241023000928.957077-1-namhyung@kernel.org
>
> I thought it's mostly for the perf part so I didn't CC bpf folks but
> I'll do in the next version.
>
>
> > price of atomic increment on what's the very typical situation of a
> > BPF program returning 0?
>
> Is it typical for BPF_PROG_TYPE_PERF_EVENT?  I guess TRACING programs
> usually return 0 but PERF_EVENT should care about the return values.
>

Yeah, it's pretty much always `return 0;` for perf_event-based BPF
profilers. It's rather unusual to return non-zero, actually.

> >
> > At least from a BPF perspective this is no "dropping sample", it's
> > just processing it in BPF and not paying the overhead of the perf
> > subsystem continuing processing it afterwards. So the dropping part is
> > also misleading, IMO.
>
> In the perf tools, we have a filtering logic in BPF to read sample
> values and to decide whether we want this sample or not.  In that case
> users would be interested in the exact number of samples.
>
> Thanks,
> Namhyung
>
> >
> > >                 return ret;
> > > +       }
> > >
> > >         /*
> > >          * XXX event_limit might not quite work as expected on inheri=
ted
> > > --
> > > 2.47.0.105.g07ac214952-goog
> > >

