Return-Path: <bpf+bounces-47273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA239F6E75
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 20:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2804D16558B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69E51FBEA9;
	Wed, 18 Dec 2024 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMqbocoh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7AB156C72
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551244; cv=none; b=Gp9HgFsaikgC+ggtzdmTrQc8Kv1OBMWqOUCbAVdFTsGP/4LNEGbNyNi+yovTukNm4t/o8JZMYWTaSQYLC43s9aSbbA0scP5fLbV0S9rpFWt1sY9VQzTV7CpX42Js4Qs2knqGSjcA27Kggf2cSoxOXf/koAyfPeiw9CU7PwFi2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551244; c=relaxed/simple;
	bh=JLLZg3e+a0WIwpalzBkE8TPpMoH9GNLJox+8xsNqstk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCmkcmwSBRkmdtvidpw1FSs5VfvTk3i9n67fORPfpYfqFjKSQ5Dzq1hIJptN6rCUaFRkuLeskAdG/q75YZqr3sANW3unkS9NwhO5rKH494s32zx7Ru+XjK1Qw+G2q0CK5SgWshK1zc3+G6SVFKYsVK9D4CmyoHBy9pYOGZFlYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMqbocoh; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so17025ab.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734551241; x=1735156041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEIz13Q/pX/IO5J/PJ0QFTU3dk8boWRXFmG3LFxMs+o=;
        b=hMqbocohUI5EvhFWJPTsHbyf8Bg3c2b8FatjQbaowNQXLgAMcmgo66V7naIIPh2f7q
         iavz5oaKznHdbapQK40k+BaZobvakO+DR4UTuOJqypDBGHI4h+Et84slm20QVKflqP69
         DyLGso3Dt7Nqyxb554jxasiFE4kdBqjugrD7Mu1Z3FTKevbqj7gblXYUD3quIiJGckv5
         4uCBm/lZ5Uozaz//HT2lgjs+7aOx7HeIgZdjaQ9jF8COCJsZa3zWmof09MUp/FjHyB0c
         7D5iSlxnQ2gO/HWDiUbQgLKYudJN+9OomNld1dma02ws2pnUgI82DLTQcnDFQ63pt/nJ
         89Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734551241; x=1735156041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEIz13Q/pX/IO5J/PJ0QFTU3dk8boWRXFmG3LFxMs+o=;
        b=gusZm5N+mSZLc59mSh5veuAwlB4Eez1d3P4/997bbVRefB5qxhgRv0bsenprhOyJVc
         +eD0ftuMuVDPfFLRfRYF/qRTz4pML4i2JV0fVAq2ihDv+zV1oIhWKy18YuSpec8T0tGS
         TlMKZNkW00Z2Em1ewKUHcfAagnaSQ8G2BNNIM/7/FLQCU8FTvAbjey47h/Hh/Pd+ZpGj
         sKTm7xbIFAdkhFpX6Hy3JYxBoyemfUhsMzOaBybkAzB7YoKpL4YOWe27/9xrVtx7mOX+
         Zy9V8hBTA/147rGSzvvQAFLy/lzeX/+AYdzpozABCrpMf84wNivpggHSdSZb5iUjf53h
         rCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkpKmlDmeowA+8rqVTlscmt/hyYsS5Wv2QtX/k+bkQMuIDRhRlUGgqJJbxo7v7gHGkfYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1stzaNDIBtaHFyo2VPy8Kv7nMkk2Gum97hJP7UzmcCVGpJNL
	nsUskwnG7OjCYEKz8sM52VdQ9xLycg/vwbVColxvpYNOPv/E6WpvvhEi/5i5DC5x+D+OMQ3p/1/
	z7aAaiG0T8C74GSjrKX89uZ1VcdvRmiFefafD
X-Gm-Gg: ASbGnctEzSqyIXLd7H4QxuYmyG69VQ3evXPwffKMsncO3DZkYMdFzO7CBe5cZnC/t0A
	NjuVy8pkdPglq0pB7Noq7kZlZmBrFkSikpidmEbA=
X-Google-Smtp-Source: AGHT+IG9HMLA2DZQdt0++217X1MrHCxsIDtlyjTzOXdQZIizZh8ClUQJQcagloMoINGz2IdswyylFE3OGbzaZct2+iQ=
X-Received: by 2002:a92:dc02:0:b0:3a7:28e3:268e with SMTP id
 e9e14a558f8ab-3c0579abc0amr359345ab.12.1734551240983; Wed, 18 Dec 2024
 11:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217115610.371755-1-james.clark@linaro.org>
 <20241217115610.371755-6-james.clark@linaro.org> <CAP-5=fU7RNzvzxBcAQy3RT9Ge3YtqPhDonupNWS7Wgb8HGQkGg@mail.gmail.com>
 <8c15786c-47b6-47ff-b1dc-ecbf32d582fb@linaro.org>
In-Reply-To: <8c15786c-47b6-47ff-b1dc-ecbf32d582fb@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 11:47:09 -0800
Message-ID: <CAP-5=fXV6LXrUtvgRKuyurmu5SoSZLTf6MN=+BBXkqv7drvOjg@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf docs: arm_spe: Document new discard mode
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Graham Woodward <graham.woodward@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 2:07=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 18/12/2024 12:54 am, Ian Rogers wrote:
> > On Tue, Dec 17, 2024 at 3:56=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> Document the flag, hint what it's used for and give an example with
> >> other useful options to get minimal output.
> >>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >>   tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Do=
cumentation/perf-arm-spe.txt
> >> index de2b0b479249..588eead438bc 100644
> >> --- a/tools/perf/Documentation/perf-arm-spe.txt
> >> +++ b/tools/perf/Documentation/perf-arm-spe.txt
> >> @@ -150,6 +150,7 @@ arm_spe/load_filter=3D1,min_latency=3D10/'
> >>     pct_enable=3D1        - collect physical timestamp instead of virt=
ual timestamp (PMSCR.PCT) - requires privilege
> >>     store_filter=3D1      - collect stores only (PMSFCR.ST)
> >>     ts_enable=3D1         - enable timestamping with value of generic =
timer (PMSCR.TS)
> >> +  discard=3D1           - enable SPE PMU events but don't collect sam=
ple data - see 'Discard mode' (PMBLIMITR.FM =3D DISCARD)
> >>
> >>   +++*+++ Latency is the total latency from the point at which samplin=
g started on that instruction, rather
> >>   than only the execution latency.
> >> @@ -220,6 +221,16 @@ Common errors
> >>
> >>      Increase sampling interval (see above)
> >>
> >> +Discard mode
> >> +~~~~~~~~~~~~
> >> +
> >> +SPE PMU events can be used without the overhead of collecting sample =
data if
> >> +discard mode is supported (optional from Armv8.6). First run a system=
 wide SPE
> >> +session (or on the core of interest) using options to minimize output=
. Then run
> >> +perf stat:
> >> +
> >> +  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev=
/null &
> >> +  perf stat -e SAMPLE_FEED_LD
> >
> > Perhaps clarify this should be an ARM SPE event? It seems strange to
> > have one perf command affect a later one, the purpose of things like
> > event multiplexing is to hide the hardware limits. I'd prefer if the
> > last bit was like:
> > ```
> > Then run perf stat with an SPE event on the same PMU:
> >
> > perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/nul=
l &
> > perf stat -e arm_spe/SAMPLE_FEED_LD/
> > ``
> >
> > Thanks,
> > Ian
>
> Hi Ian,
>
> Confusingly this isn't an SPE event, it is a normal PMU event. The fact
> that one Perf command affects the other is because these events only
> count when SPE is enabled. When it's enabled it has an effect on a
> per-core level which is why in the example I made it simpler by enabling
> SPE system wide.
>
> SPE is an exclusive PMU like Coresight and some others so it can't be
> affected by multiplexing or anything like that. The SAMPLE_FEED_LD PMU
> would be, but as long as SPE stays enabled it will count the right thing
> regardless of multiplexing.

Thanks James, sorry for my SPE ignorance. I'm smiling about the use of
the word exclusive. When I was trying to make the tests run in
parallel I used a file lock - so shared and exclusive. There were a
lot of issues with that, hence switching to 2 phases in the test,
parallel then sequential but I kept the "exclusive" tag for want of a
better word. Perhaps the notion of an exclusive PMU existed previously
but maybe I've accidentally invented the term by way of a failed file
lock experiment :-)

Presumably the two PMUs side-effecting each other is a known thing. I
wonder if we can capture this in the documentation. When you say
"normal PMU event" you mean core PMU events?

Thanks,
Ian

