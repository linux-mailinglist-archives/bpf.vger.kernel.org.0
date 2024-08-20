Return-Path: <bpf+bounces-37656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE49590AC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 00:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA3528542A
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A9E1C823D;
	Tue, 20 Aug 2024 22:50:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98C165EE1;
	Tue, 20 Aug 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194229; cv=none; b=QoWaJLWiekQ9FhhLhd/IN6UwUaFpDTL1vfevlEUIy6ERGkxgNQpPhSIxbic6dTBZN1oUWwYenfql0YasGpIUAmu14yjC1G/7ivQ3s8mHpRxeSJi1KK730hdvUrT7YHhG289s/csDmHLoBMJIIVaxBbVeLDwURi9T4i112P+fjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194229; c=relaxed/simple;
	bh=APy8qToyxt8ThXJZfeNg4biFZzMtXUuCvDtSbiEX9Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUlfo0/JfkuuW8/LKpXm9WyDOzHVa57vlaUCFj5LsAdSPjBvG6QbyU66iWCxdFIiR05dRQ9vQA61ysaQjJcRrJV5arqHlLHRkTQp7nsP0SBTSf5nt+ZVmZ7FIVSJ0r5JUqwfR0Ic3nHfWH5O29njfTTJjRxvld6/+F6i64Pqq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70ea2f25bfaso4508532b3a.1;
        Tue, 20 Aug 2024 15:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194227; x=1724799027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHN/wO8yVpctdkN+spahKaBSr6jjtGiy0TZ43tDVhlM=;
        b=eocO2mRBRtEmxoGcVUViryWvurZ5rdxx7vTfEhjxR+GJYPd4aAbgghPH4rJwJFYsYZ
         5HxyWCBcpudhQy6+RzO95EXNesM2Im6Z4FdXlMsc76dRDfHLfz6ObeU95aDo+vZw3Xou
         9FMXjIpF0AQ/dwxoH2tSNOMdJNlgi5hQmmk4y1ehe7jq6yqQf36O5A8Ja3U7HQMjnWl7
         dpObmVXDX9hVddEfoN16zVDJq7LvAvMjAUA/7l0THRSbnV+rwoO4m5TPtd6AZbLcklI0
         NyxvwKwt94C6qdte5A2zalUKNhWR0GpNJ8RyrcR/yY38fwZ2Bfpz5BSKaqeFvj7iyVIh
         TULg==
X-Forwarded-Encrypted: i=1; AJvYcCWXM/OPCKFOvkWbiM7vjCp2q62gRkoh9itoi+p7LK/YlZD7jxHcginY8JG8/O0rr/PKsfwNEksTx+TkLlaj@vger.kernel.org, AJvYcCXMIS0ixXKE+NC60W3G3Y08bcMdmEKRz2zeQSncVVSZFUfx/cMa7fsqZUWrgPWHbUo9lvo=@vger.kernel.org, AJvYcCXp3j1MoG5qBD4byHMmHkM5QNxLjbz20g5BkdyWorWdlfgi7sEfXeCoAjSu5kKpVFO77o0MKXc+w0BMsbUvoMmzsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHuRXi7sCX4QqYte+iPcxYTpXA5zlmPcKCQ8EyeT21B9oRR4F
	+79KsAYiE+wZzUwWwzom/Lva439J5f1KxDdr6W/dy1iVOV5ZWIBt6LMf8isx9t/6ltwT5NNITrn
	3/3e6+oO7icBWJGpxY0dE6rrz23hk9PWU
X-Google-Smtp-Source: AGHT+IFlg9jmTJqy0i2BcV0X9kftC4OVTbIhwDRjACBejMC69qjCJhLtEU7pE+52PoOdniSd2sFpT9R4xHQpw2iPZ7Q=
X-Received: by 2002:a05:6a20:ce4a:b0:1c4:c3a1:efbc with SMTP id
 adf61e73a8af0-1cad81a732amr944288637.39.1724194226651; Tue, 20 Aug 2024
 15:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820154504.128923-1-namhyung@kernel.org> <20240820154504.128923-2-namhyung@kernel.org>
 <ZsUB57VlFtdY0O0M@x1>
In-Reply-To: <ZsUB57VlFtdY0O0M@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 20 Aug 2024 15:50:15 -0700
Message-ID: <CAM9d7chUfoHgZ=uyVEua8XCi4HigzT6p0i7rsL6rZLU2N9r_ZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf tools: Print lost samples due to BPF filter
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 1:51=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Aug 20, 2024 at 08:45:03AM -0700, Namhyung Kim wrote:
> > +++ b/tools/perf/builtin-report.c
> > @@ -795,8 +795,13 @@ static int count_lost_samples_event(const struct p=
erf_tool *tool,
> >
> >       evsel =3D evlist__id2evsel(rep->session->evlist, sample->id);
> >       if (evsel) {
> > -             hists__inc_nr_lost_samples(evsel__hists(evsel),
> > -                                        event->lost_samples.lost);
> > +             struct hists *hists =3D evsel__hists(evsel);
> > +             u32 count =3D event->lost_samples.lost;
> > +
> > +             if (event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BP=
F)
> > +                     hists__inc_nr_dropped_samples(hists, count);
>
> So this is inconsistent, we call it sometimes "lost", sometines
> "dropped", I think we should make it consistent and call it "dropped",
> because its not like it was "lost" because we didn't have the required
> resources, memory, ring buffer being full, etc, i.e. the semantic
> associated with PERF_RECORD_LOST.
>
> I.e. LOST is non intentional, not expected, DROPPED is the result of the
> user _asking_ for something to be trown away, to be filtered, its
> expected behaviour, there is value in differentiating one from the
> other.

Yep, that's because it's piggybacking on PERF_RECORD_LOST_SAMPLES.
Do you want me to add a new (user) record format for dropped samples?

Thanks,
Namhyung

>
> > +             else
> > +                     hists__inc_nr_lost_samples(hists, count);
> >       }
> >       return 0;
> >  }

