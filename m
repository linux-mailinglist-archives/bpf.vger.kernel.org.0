Return-Path: <bpf+bounces-37898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46FF95C046
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 23:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9C51C2323E
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3991D174A;
	Thu, 22 Aug 2024 21:35:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14CA933;
	Thu, 22 Aug 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362545; cv=none; b=MCLfBfwdCL4thZyFdnoGf8hEe52ixO5ZuO/nWc2co20JQvZYqKRxK1v3UiRLeygPSDolEVQOVAmQOg2DoCcUvgxT+DxydbDvruHdaVmJjTP+m3yrrsttzclDx5bEEZ1DqNvLsh5+hVoQMakkkiLnX/x4aKoHFQdRMrWsqn6lL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362545; c=relaxed/simple;
	bh=A6Ig3DIj20iSmms1/sNE5z9cyEcEk2xGv4yIfHNffXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYUy6/QSZy5pDE2FoEaXkVaF/8Hgs+ahU62s6kBBojSD9vwOScW0xCbfw+0NnkoNTHfyHVJHoiO9jRcRsvS6vvw/6i5SUWehzr4HEY4ZJoGK7cnApkU6G5fjz6cZvcyaQABtflkpGogSrgw+NoNSNRXH/W/YT5Db7/tP0zwXSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d41b082ab8so968877a91.3;
        Thu, 22 Aug 2024 14:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724362544; x=1724967344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9wr4Okb0X4f99n+dpYBp3cuqpqdb5cSoZFZz5Yzys=;
        b=Tg41TJhNg/7ApMJ28InkQKFpmpcKf1gS3FmPWmQMWlgpv4yozfBM2ngHEakJ3tCuKl
         Ly3KOOAj+aF51/V69OGogqQUtqGySQbpnf35NSIL6D6vew68GcoPnFOZLvvltQ46tls8
         9OFfiZvivZ9gbur7/ofrYDK50xvix9q57Jc2LYfoWGvpEDO2PAARdB9Kordg8fXKrHev
         OdI0fx2gvTGKFVc4ieSUxAg+hku74psFeVRlAbXb6ZQo0r3h0o0cXxTP28PDpjUARW1y
         l0rzDHmLjuJeFQ6nyYrpAf0AVK086rLcCqMJ+xVAP3gtuLb20z7vvgEU7g7R6LCIazGb
         hojg==
X-Forwarded-Encrypted: i=1; AJvYcCUyprQTyjjDvonXwLrW0w5aFAUHPhNpB+t1FBdCN8BUEt7GkM8+FxnY5xkHo/kbAS8oW+Pnh6JMIRj7Q/zt2PIHfg==@vger.kernel.org, AJvYcCVNkrKdDa9qRiUawjm2TzUcYwSSKSNCW4sPdsJlo2AeXrkqyMwe+MrTULwoN9EeUv6PUW1nGSn1bcoFXcOy@vger.kernel.org, AJvYcCXKy8qSjlHLXzGGiiDwm7ak6OwNN7iAAq8kM0Ki38tp9/wtLXtOxZzot8zgc68/Cwhgzng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudbqnWPRNqyqX99kz8K1NRunxIz9fEimerurlJ2+8DnPSVC3Q
	hTy4XCnrQQ2Pjto08ujCgueKae5oOPh6AaqFRKpAFOmNTmJkrJk+nfjS0YAupkQzCpBJnuDHUgQ
	ia5CMYZUywWQGKf5SVXTBxWzBaV0=
X-Google-Smtp-Source: AGHT+IEJKbmFokzgoavY7n974YSn4Suu2Erwxe3CdPc+gdQf0oBf7ZMv3X7CHg926U7CDuKfJ64EHOiOOU+C3mWYPNE=
X-Received: by 2002:a17:90b:3ecd:b0:2c4:e333:35e5 with SMTP id
 98e67ed59e1d1-2d646d6db7dmr6211a91.36.1724362543468; Thu, 22 Aug 2024
 14:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820154504.128923-1-namhyung@kernel.org> <20240820154504.128923-2-namhyung@kernel.org>
 <ZsUB57VlFtdY0O0M@x1> <CAM9d7chUfoHgZ=uyVEua8XCi4HigzT6p0i7rsL6rZLU2N9r_ZA@mail.gmail.com>
In-Reply-To: <CAM9d7chUfoHgZ=uyVEua8XCi4HigzT6p0i7rsL6rZLU2N9r_ZA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 22 Aug 2024 14:35:32 -0700
Message-ID: <CAM9d7chPsZUMAraWzyf5z7OjCxWUxMz-ufntr1x34c=wRVt3XQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf tools: Print lost samples due to BPF filter
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Aug 20, 2024 at 1:51=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Aug 20, 2024 at 08:45:03AM -0700, Namhyung Kim wrote:
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -795,8 +795,13 @@ static int count_lost_samples_event(const struct=
 perf_tool *tool,
> > >
> > >       evsel =3D evlist__id2evsel(rep->session->evlist, sample->id);
> > >       if (evsel) {
> > > -             hists__inc_nr_lost_samples(evsel__hists(evsel),
> > > -                                        event->lost_samples.lost);
> > > +             struct hists *hists =3D evsel__hists(evsel);
> > > +             u32 count =3D event->lost_samples.lost;
> > > +
> > > +             if (event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_=
BPF)
> > > +                     hists__inc_nr_dropped_samples(hists, count);
> >
> > So this is inconsistent, we call it sometimes "lost", sometines
> > "dropped", I think we should make it consistent and call it "dropped",
> > because its not like it was "lost" because we didn't have the required
> > resources, memory, ring buffer being full, etc, i.e. the semantic
> > associated with PERF_RECORD_LOST.
> >
> > I.e. LOST is non intentional, not expected, DROPPED is the result of th=
e
> > user _asking_ for something to be trown away, to be filtered, its
> > expected behaviour, there is value in differentiating one from the
> > other.
>
> Yep, that's because it's piggybacking on PERF_RECORD_LOST_SAMPLES.
> Do you want me to add a new (user) record format for dropped samples?

Ok, I have a related issue with AMD IBS.  I'll start a new discussion
in a different thread.  I think you can take patch 1 and 3 in this series
as they are not controversial, right?

Thanks,
Namhyung

