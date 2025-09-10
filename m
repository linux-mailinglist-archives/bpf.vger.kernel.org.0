Return-Path: <bpf+bounces-68024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CB9B51AF1
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 17:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219131BC2730
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BD23AB8E;
	Wed, 10 Sep 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbbp+90h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090B24113D
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516438; cv=none; b=dkY4NmI3Hq97sGwoz1+6a75lX0oP0btS6U7qGAjEYhRV6ffiL7trCCSH8mIUPFScuFpuvapL/Wv66dz/BpId2MBOd6NOVrdG1BeJNzV7I+dkl8RbsoARRuM+A+bwxtWuwL07lj7hgS/32RWJy/thekbwgDhPXxNUkcWMZDe1DI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516438; c=relaxed/simple;
	bh=yyCBvmzhs/mvJ3yr3svszkOJYjpUZ5oLKLTr35nIJ88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lotCDfZbmw6RePLf7sf2ilmfF1CSte0/Bzd7vunxR1ds+Ub0brzL5CSkJyA0mKkAspBdok9SQHovaT2W5ym/kbfh5rDXVzUo8fIZuV/LPmdzP3oC8od2GBWQnPcGYHRIzr2wws7wyDD7bHUjp43IPkdhyB/di8S7AmDhPYjgwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbbp+90h; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24b2337d1bfso215555ad.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757516436; x=1758121236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weuvA194fKCjKwZnheH+7smLoUqlaZCSgWfuNlCklyM=;
        b=tbbp+90hAAohGqdgMzSkNsq8Kj6rYSZf+AEfXWOfIZgLrrL3jkjHROqzg8Ll8+sBLc
         jU62SDKbm6ztHpHySjkN/XL5d7JikLKtx0sneYH7rhCEC/gUXXnT4O5Au1SfPVxt3ZYx
         geZaH80aW+6lUOHikToRT/MMgY4jRIJu45+pO8q3AoLWOoBnKfL0+B0LFCJ9AtEjd9gq
         GmJhtDMjWR7r9aGcdT1GpYipJjraa1A63Dvb0VEGUvcE28jZXCi8HYb0IKfNwevwpqij
         a0/eJduce/JT+ExGvTOUjkD2vKcDcczIlUXUQRgFyyNfrOQnr4sS0PGH2doJ408/rP96
         Q3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516436; x=1758121236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weuvA194fKCjKwZnheH+7smLoUqlaZCSgWfuNlCklyM=;
        b=hvdceiC81E5RT/XmjQughhqDysZYVux+4S2dY+x5afE+s4vcDCauLmZpDlGrtwZTiM
         CSwa+ljnoJWytEKvPwhgt4wrjfsB7sF/e074jtIwT/O5DQe7KA9RtbSIqGwCvHQY4X9j
         H8X9UaHy/brbJhuSrVJDzQyBw/z67n3kSYPksydR5F3gDGV3ZKtGfl8YI73102iLyicp
         PvyDs30gTmm1Jukt0k+ez+KmN0ICu1SY9+8oMpBeGTwVGhr1OnZv67Pgjmrgzq4h050+
         4D+rOVPoG5SrkiQv1aq1QiwEJZrf/8uWSnTekYKpGTn48ZCYpuhOH9i2inUeeOO1qg/6
         pqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc+15nLjTzEGyOl2WnuyapHg5Y4zU6ADU3YmFCvhKEugy0yuLIjc6n9JxM2szFEGkn4Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISU5bqxLqfHmdPpiM9wjoEVDek9IYQKm474zMlbi3wAPvNehS
	t0P/zsfsmJETjPFm42Tn8NVurSjYy3IXAS+SSG0PMCvdGH9wrs32SKAtkZxMv4Dk6l5nk35vW59
	K11v+mvV4MaFY/VP0ErGDSIiyZdZ9NHGV2e3fpN7q
X-Gm-Gg: ASbGncvOv7E6OI/7xBseZhJFL8z7PYmBx2gQXRC0HZyKoo4HQliQFxDoKRte1Q2QIKf
	X67yM5joz4/pjAcrXx9EN63g4lP4YAjBVA8YTxrfgq3yqh8An4meSn2uZb29jmR45dOJ+msmS+S
	nNyHuXmbJQRjrCNqFRHI7gCvZgEXRamVso2wIiQZpzovE/SIf8hVXqSwf6CXcYkb0eAeIui7EiT
	ekWevmLoMLtq4Qv+75SDWq1a+7vXB5EUuOMME+uxbNWsGM/S6NL6nM=
X-Google-Smtp-Source: AGHT+IH1042rZlLfxKs7Y+xux3JwZNmIbzFLATrg2+c5aXZKMwyE2s3Ww9mR5fOFhPP0GiKrmdRSfEs8AtaExPp4CHc=
X-Received: by 2002:a17:902:a516:b0:24b:1b9d:58f1 with SMTP id
 d9443c01a7336-25a7f4bde70mr3189515ad.17.1757516435531; Wed, 10 Sep 2025
 08:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com> <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
In-Reply-To: <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Sep 2025 08:00:22 -0700
X-Gm-Features: Ac12FXwPnKvmnBzu34VagSylw1N28rbQG7YHbvq2KGGi5XeyvRAcKMxWmzvI_pg
Message-ID: <CAP-5=fVbtL=eL5bCFzz06g86Sk3nBsxUmgwZ3c5UY7z5hwmoLA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:14=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 28/08/2025 9:59 pm, Ian Rogers wrote:
> > Mirroring similar work for software events in commit 6e9fa4131abb
> > ("perf parse-events: Remove non-json software events"). These changes
> > migrate the legacy hardware and cache events to json.  With no hard
> > coded legacy hardware or cache events the wild card, case
> > insensitivity, etc. is consistent for events. This does, however, mean
> > events like cycles will wild card against all PMUs. A change doing the
> > same was originally posted and merged from:
> > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> > parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> > his dislike for the cycles behavior on ARM with perf record. Earlier
> > patches in this series make perf record event opening failures
> > non-fatal and hide the cycles event's failure to open on ARM in perf
> > record, so it is expected the behavior will now be transparent in perf
> > record on ARM. perf stat with a cycles event will wildcard open the
> > event on all PMUs.
>
> Hi Ian,
>
> Briefly testing perf record and perf stat seem to work now. i.e "perf
> record -e cycles" doesn't fail and just skips the uncore cycles event.
> And "perf stat" now includes the uncore cycles event which I think is
> harmless.

Thanks for confirming this.

> But there are a few perf test failures. For example "test event parsing":
>
>    evlist after sorting/fixing: 'arm_cmn_0/cycles/,{cycles,cache-
>      misses,branch-misses}'
>    FAILED tests/parse-events.c:1589 wrong number of entries
>    Event test failure: test 57 '{cycles,cache-misses,branch-
>      misses}:e'running test 58 'cycles/name=3Dname/'

I suspect the easiest fix for this is to change "cycles" to the
"cpu-cycles" legacy hardware event for this test. The test has always
had issues on ARM due to hardcoded expectations of the core PMU being
"cpu".

> The tests "Perf time to TSC" and "Use a dummy software event to keep
> tracking" are using libperf to open the cycles event as a sampling event
> which now fails. It seems like we've fixed Perf record to ignore this
> failure, but we didn't think about libperf until now.

I'm not clear on the connection here. libperf doesn't do event parsing
and so there are no changes in tools/lib/perf. If a test has an
expectation that "cycles" is a core event, again we can change it to
"cpu-cycles" as a workaround for ARM. As "cycles" will wildcard now,
we don't want that behavior in say API probing as we'll end up never
lazily processing the PMUs. That code has been altered in these
changes to specify the core PMU. For tests it is less of an issue and
so the changes are more limited.

Thanks,
Ian

