Return-Path: <bpf+bounces-26844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845D88A5852
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E12C281D33
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7C82C7E;
	Mon, 15 Apr 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tusoZvZb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE498249B
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200358; cv=none; b=aj9EhmxrwoKTmhu7+nVd9RcGbBPeVjJFrUjE5s072dB8A3ykpgTp4KoOTQdbi76A6KW5nzh+xunamY7LZKMDs6m+Q3ye1rvIZtazDutHJVRmeLFBKksOhfS+3bK/MEokKLIdTB5zGWpw7/ZIe6AwHAhuP8SO0aDABFRZfGJpoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200358; c=relaxed/simple;
	bh=h/VKgYZeWQnV48tMKbUZGNBLB4TAFR12aWgeBSIN/oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F9nH6pYBqCA6dXJ2toijtJHsfcXbgMcwbk39MUhcZsRfo8sH1if8ZyeXpThXd+UZx/33P9ASTY1pgYporeHDS/s0b4ceyJnLg42n7qbiq7htDWWDvLh39AexYyS9gxI35AlGS/veWjvmlMvWnsoc42bqsKoHS7KY2T3dhJCUPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tusoZvZb; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36b0a277e4dso3765ab.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713200355; x=1713805155; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEib3GfoMjSsGAGLxyonIryZVPQ97O3Yy2s2kSrwbjg=;
        b=tusoZvZbej9Psx4dmuAx+x3Afx0MB4zdp5kXmlkaWeuQZ6PscxC0Ocn3IAXzsTt7Wa
         9DwRPRsFW2b0HCavwtcxTTmlRNVxoxE4LylJjglbS+4ZnULnEYnWBaSwM68O2ujnw6pX
         Qxl1Bzu0mlVm1p/pn/gc7Ch+7lZfcnnLCwaVx7AQdNgyVVQDoqJxEdNf/sKtVO8GgsLH
         Fy/3PQ/TdNApqOQba8um+udBo+fjjONCT3Fmgg1FogDXRZB6E9paUt+LZ87yeZynBkJ4
         NM731VnZpD0kHlZUn14xBHB+qG2rw2Rk3qNA5EqfPiB5X4kWk6j6JxQsz6Xkj0f2Qjt+
         t0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200355; x=1713805155;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEib3GfoMjSsGAGLxyonIryZVPQ97O3Yy2s2kSrwbjg=;
        b=pmIJHEnwXBf/02AdkoDd6ZA3Qg93808hByc/gQl38noVj/5WLIZ9L+lMnPAEDYZhNJ
         +MOckaQTeaENhTfgyBY70mKhrbY63g3XAoq17dzWBBWj0/15HDTDr/lbYAEJE/I340bH
         39me7JKz7P8AJY9QW4v5gfAOl8TIIakFFwtdr2hfA2zv8YwLrCH1S6of5oSEbPIKFRWd
         ThpMASLFSYNrQ/FUH2xc7gjxQyMrcd3XXUHkA5TUun5RCFglPnE0w/zKuE3ETz8rvAV0
         ol6o8/xyXXOHNT3Xb9D7yrDdWcLAuYdmfvaxPLkg/y7UMkC1YemkUybOqGu3OuT43zPP
         Ld5A==
X-Forwarded-Encrypted: i=1; AJvYcCUpIAZA1JXDpecqp4DYbhMJWiP8CZXXxFBNv3N3sdv+DryVWucNJDXRvK02HUbdxiKusA3icp6zLou+vwOdxHsvNLIz
X-Gm-Message-State: AOJu0Yyu/eHKGqvpX5m/eJOS3vl4SkeSr6eNOwFWI6A0yTnS/0s4m/Kp
	uojFBjoud1zibzz5rqzV1Wb9k3WTWf8/oiWW1RsO5p/Nr+Uo6xpvtnljeQUUHir7TagxZ54lEpk
	OpdQjhprpAMKrB3hpiFEV+WpLctrerNe11eMa
X-Google-Smtp-Source: AGHT+IHk3Q1DJ27BgyWaA1tZ68jUswiQUBjNiPkdLY2pHmnY2/6xbO2ks9X9CrEfiHqM0rpPNqR4Dkwl29fBB23MtN8=
X-Received: by 2002:a05:6e02:591:b0:36a:fcc9:64eb with SMTP id
 c17-20020a056e02059100b0036afcc964ebmr425184ils.5.1713200354212; Mon, 15 Apr
 2024 09:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Apr 2024 09:59:00 -0700
Message-ID: <CAP-5=fWhPTWiRjiUW7vRCetm26fYgOWfHzV4Qig3rSfe-x5VLQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Consistently prefer sysfs/json events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 11:36=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> As discussed in:
> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com=
/
> preferring sysfs/json events consistently (with or without a given
> PMU) will enable RISC-V's hope to customize legacy events in the perf
> tool.
>
> Some minor clean-up is performed on the way.

A side-effect of prioritizing sysfs/json events over legacy hardware
events is that the hard coded metric logic in stat-shadow fails:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-shadow.c?h=3Dperf-tools-next#n100
This is because the hard coded metrics assume that legacy events will
be used. Rather than make the hard coded metrics match sysfs/json I
think it is better to remove the hard coded metrics. This is because
the hard coded metrics lack checks on things like grouping that rather
than fix should be transitioned to json metrics. My preference for the
json metrics is to generate them using the python generation scripts
that are out for review.

Thanks,
Ian

> Ian Rogers (9):
>   perf parse-events: Factor out '<event_or_pmu>/.../' parsing
>   perf parse-events: Directly pass PMU to parse_events_add_pmu
>   perf parse-events: Avoid copying an empty list
>   perf pmu: Refactor perf_pmu__match
>   perf tests parse-events: Use branches rather than cache-references
>   perf parse-events: Legacy cache names on all PMUs and lower priority
>   perf parse-events: Handle PE_TERM_HW in name_or_raw
>   perf parse-events: Constify parse_events_add_numeric
>   perf parse-events: Prefer sysfs/json hardware events over legacy
>
>  tools/perf/tests/parse-events.c |   6 +-
>  tools/perf/util/parse-events.c  | 201 ++++++++++++++++++++++----------
>  tools/perf/util/parse-events.h  |  16 +--
>  tools/perf/util/parse-events.l  |  76 ++++++------
>  tools/perf/util/parse-events.y  | 166 +++++++++-----------------
>  tools/perf/util/pmu.c           |  27 +++--
>  tools/perf/util/pmu.h           |   2 +-
>  7 files changed, 262 insertions(+), 232 deletions(-)
>
> --
> 2.44.0.683.g7961c838ac-goog
>

