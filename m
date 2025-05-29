Return-Path: <bpf+bounces-59331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E6AAC84D2
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 01:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3355175A32
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 23:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866321D3D2;
	Thu, 29 May 2025 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0AYzsTex"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE821D3D9
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560167; cv=none; b=OMjRd0MWd8R1i48RntIJNIlKij2m4hFEGNYTJNFukOpk50UpSbm3BUpFgvrYnYFiIA1dgafMsbe3Lw5SpDZXdW9RHNMFUtrMSj76wVsl7eaxBEa04HRgY8HCzriKfNDIBzgcxWsEDx20bUxYw4J3Rx6ElFrJPubLJBMu5Vve1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560167; c=relaxed/simple;
	bh=GajOjrak31hz+z4NbE6saOyWhweppL99J6iTMsMMSE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOQRfapczI+FWaJlxkZM/bpte2PN33ZUfJPTnKacYUW3DakauMG7AvNBr00lnuTLa6+u+j9OBMcEOzJn9vugUeLd72dvMbWj4W2xkJ1046VMsuAEWyBuQyTB6zBbqkMygyqyTDx/oShAr/58G8T6Jv7zAsWv60S/7bnsoB8cQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0AYzsTex; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e59012c7eeso923023137.1
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748560164; x=1749164964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GajOjrak31hz+z4NbE6saOyWhweppL99J6iTMsMMSE8=;
        b=0AYzsTexr72+7FI7h2T4HR1aJm2NeGVt+RYnaJ3QGYoSj4eK+OHPa22V+iEEut6hC1
         QzTZ1oY6z7De8+7QWkLXpjVYcHmMwX3R6J47+hVxMl96wdZUJ+AU+lmgDqWOJbwCKpHc
         8RVZ86EVWc2oXsg3C+za0hHfCpObsWvtIgcmgx7tb736tygMhxb7Hkvz2S+lBjC0EhhF
         dbqXLrLQCNrWT5ms1UoQqvyKseORHKm1JeTGchv+RTLmV5nsGqYr9/Gy+KMP4qvw6h7F
         bWGrxwUBXA1bgIEls/gfEoWSP/4uhtlepeuCvBh8kXWaSxOJpjUYM1pVUpkmffI5Xsos
         rWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748560164; x=1749164964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GajOjrak31hz+z4NbE6saOyWhweppL99J6iTMsMMSE8=;
        b=ii/MXwwYUN29YUaQHRnN4OjjWiWSEV8hB0kM2meN8whDyBT962Ut3BO2rQxeinzQqO
         9zEmY44zClS3Jgel4QkizoHxLzfhbHoS43u+VhHRlLvdRdK8ZBZAq7zB7X92tONffmZE
         zfRwtEHAjTfr1NwIFAK+leq3tkEMUGZH8ocJFjgN9CplqHfdrVgONUmIwiw0KG1dAjMT
         OQPtVSq4NM++asWu97uD0YT1m2ZZ+ZcmIHSjEEBYoEz1psZyF49IhTglGkBhqsq1KukJ
         p2wA44DdHqMQfUt3jNHkifSwVdaKvRtp6eExuIQp4o8TMWyfcB9jLK5qvqOdW5kzWX7y
         2+9g==
X-Forwarded-Encrypted: i=1; AJvYcCUOGt2dzWeFJvsSpyHMhghH1QwYK+Y2a9RVUttOhv7EFIqdPgE8LxiAjfIpvutOSnFl3vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyN6LgtzUWoAMPYFXB2AobUurXPICRKRkqNthAJHARl+MW2zcH
	82uElkbVgokOX0kV/Xrj7s8Cwy/6MjVP4aKp7B1NRoJJfYX71JX8DyfFmv6c1YEI5rVVqVGh+NC
	2MQAa7uRRA2dsu+vjSJZ10w86fv9dAlHNFz340pRd
X-Gm-Gg: ASbGnctthDBxuiUzPG8u5fdUI7fwdt+gt2N4UIfl9QHp4kFfBPg0XKD8dcYOTNWC2wJ
	W1gz6J8myrpfpBAzA1s4O9m7jvd3BJWhSZJ9Dk+bpy0RrNmdI7h6LJsTsyVpwokpIl2iRCiJdjT
	e4EEwr2zPejyhtukd6cE/KGx+uF1/sqCNx83a71jrSTUm5mA23IgJ31ASh4jpCxrSaozQRjoVqi
	g==
X-Google-Smtp-Source: AGHT+IG6BQA0I630mRZfaOvWCCUcIMdbtiue7trw5etAjQ+fq0zA+UtWqiz/UuEf1zqxPU9NUikhqGT7EEBX4W6fxqU=
X-Received: by 2002:a05:6102:38c8:b0:4e4:f503:6675 with SMTP id
 ada2fe7eead31-4e6e41a8063mr1697324137.18.1748560163881; Thu, 29 May 2025
 16:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-4-blakejones@google.com> <CAP-5=fWZG-N8ZzRh6h1qRuEgFbxTCyEwGu1sZZy+YmnSeGgSSw@mail.gmail.com>
In-Reply-To: <CAP-5=fWZG-N8ZzRh6h1qRuEgFbxTCyEwGu1sZZy+YmnSeGgSSw@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Thu, 29 May 2025 16:09:13 -0700
X-Gm-Features: AX0GCFuGir3GW6UHq3oIxIPaTP0vr6jrzzbbxjveLO3-Hr0ZfzoynVlNv6aTEO4
Message-ID: <CAP_z_Ch2SKwVcSV7ffV1Lbp=6TuKLyofSs1gpfBPMf6mV9-wHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf: collect BPF metadata from new programs, and
 display the new event
To: Ian Rogers <irogers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

Thanks for your comments!

On Thu, May 29, 2025 at 11:12=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> On Wed, May 21, 2025 at 3:27=E2=80=AFPM Blake Jones <blakejones@google.co=
m> wrote:
> > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/=
util/bpf_skel/sample_filter.bpf.c
> > [...]
> > +// This is used by tests/shell/record_bpf_metadata.sh
> > +// to verify that BPF metadata generation works.
> > +const int bpf_metadata_test_value SEC(".rodata") =3D 42;
>
> This is a bit random.

Yeah, that's fair. I added it because it was a straightforward way to relia=
bly
get a known value that I could observe from tests/shell/test_bpf_metadata.s=
h.

> For the non-BPF C code we have a build generated
> PERF-VERSION-FILE that contains something like `#define PERF_VERSION
> "6.15.rc7.ge450e74276d2"`. I wonder having something like
]> [...]
> would be more useful/meaningful. Perhaps the build could inject the
> variable to avoid duplicating it all the BPF skeletons.

I could do this if you'd like. It would make it harder for my test to check
that it was reporting the right value, because the PERF-VERSION-FILE define=
s
PERF_VERSION in a way that's useful for C programs but not shell scripts.
I'd just have the test check that it was reporting some string (maybe one
with at least one dot in it, if I can stably make that assumption). WDYT?

> nit: I wonder for testing it would be interesting to have 0 and >1
> metadata values tested too. We may want to have test programs
> explicitly for that, in tools/perf/tests.

My testing right now depends pretty heavily on the fact that perf will load
sample_filter.bpf.o for me; this seems much better than trying to load a
BPF program manually from a test.

If I could find other perf invocations that would load other BPF programs
automatically, I could potentially test the "0 metadata" and ">1 metadata"
cases. That would involve more BPF-program-specific modifications, though,
which would be closer to the thing you objected to above. So to me this
doesn't seem worth the effort.

Blake

