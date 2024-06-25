Return-Path: <bpf+bounces-33082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4AD916F8E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6361D1F22D86
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EAC176FDB;
	Tue, 25 Jun 2024 17:48:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC44437A;
	Tue, 25 Jun 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337700; cv=none; b=bxGtKsX0fBVku7j5BlX11w/HUDbbblFOrtPrRzTMEpqiOvA2UlPpJrigXi3i1olILvcWZuFJQ4GqPTuNmMgB3H5ssnsU5sX4i2djFW84DyixjCU1Fvde88CrfMqMViqsQI6s2UAaUahx/8iEy4QJ5gInYeV9q2os7DN7lqVC1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337700; c=relaxed/simple;
	bh=FCUFi8Q0u58wW+GVe+dgRDwlEGV2MEeqC/CdwTfsCO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4ZOFNt439n322dDIhNv+ztov8qr+4RqT6WrW6NovdxFmaLEQqVowjDMktRmD0NKrq/lK6hxyoXYbIzQru8KfFqoaUrzaV2qtUK+r8gq3HLfQRCpHbFkoaK+0/kxcROHAshFJoUJcg6TDM1otmsjevW1IMQHiGInj84SlvrDqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c7a6da20f2so4525084a91.0;
        Tue, 25 Jun 2024 10:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337698; x=1719942498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xtHXiqQf1XxUxrjysf1LF5IvMCFepz3wpLAFkq/vI8=;
        b=kBw5whK+DjwJhBxpzvM7eVWfLyeW/TR6poIsy/hvgPkn+jI7EdUnbjoPLMjskayxdx
         lzuLGDm8UWZcSL85kU7hwz6yu5HWfo9Ng2ZpO67vxmvBo1lG5FynVlX+FV38etpGv+G1
         sCF3QQUg1f9oZ4e45psMWQsLYLGjrUtIoq127aJDCCHjdik9VkUltiUrxLl4Cnu8zV2F
         tjZcZvgi6Mi33ZwsIqpELU48Ssxb8h7SjVXnGfD+K3Fajzil2vhn86PzUKfYI6Ykmo51
         5sAh0xdx8IP4MmDqlarDVUY+8T7Tglum0WwHCKKeLecFRPjOI7ConUQimmswuYqSXq9x
         HYew==
X-Forwarded-Encrypted: i=1; AJvYcCVUyqi9nAxIEbpFkve7jKYWfme0MzxJ90AOgrAGPvwKnk9poUOUU9/wZwNOEnEW09IAhO2Q4YKei8ePQnbEYL5UgMgcEPznXHMjbxwTocdva12+1AfsE80KOdpj0KzupQP4Oh8AdZVpZxYZA2F4pcsy2/lv2PdgtEb5zSTc6KvITPOLwEGrNCJfrn8P91APhSWfSNRczGARiiajrHNsUMwC6oyw1NiUsrUIJ+sxZjDruz4TBvzUKaIDI/ZXuVEWCg==
X-Gm-Message-State: AOJu0YyuTqW6lzALidXcU74yhXjQwPeTxBlTSBWDKJR1/yGqYnb5jK7/
	obOCGXz4wyKrUBZNZtkP8KwU7L2eh2CZu5E9NXsa6P/117iH2+LB84TXZwtcmyGDAJG1IkZK8fW
	AQ9ZGXzgWHOOH1oIJqRpaKtr5SHo=
X-Google-Smtp-Source: AGHT+IGYzAZ+Bn0UI2LyfXB+0Uof3O9NdbXsei8hjTG9FhXGaHhlgu5/ywEXYZKH6auDRwKGOVRfEO1r10gy0evqwL8=
X-Received: by 2002:a17:90a:668a:b0:2c2:faf7:67a0 with SMTP id
 98e67ed59e1d1-2c8504f656bmr7440529a91.16.1719337698260; Tue, 25 Jun 2024
 10:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com> <20240613233122.3564730-8-irogers@google.com>
 <Znnyi2IPC79jMd9y@google.com> <1fdf637d-3571-4145-8008-f2b5f8fc8bca@arm.com>
In-Reply-To: <1fdf637d-3571-4145-8008-f2b5f8fc8bca@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 25 Jun 2024 10:48:06 -0700
Message-ID: <CAM9d7cjy8+Ys-Y_35V7O=KGQL0v3+B9z6hhytmAiKKN9pO9yow@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] perf python: Switch module to linking libraries
 from building source
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Nick Terrell <terrelln@fb.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kees Cook <keescook@chromium.org>, 
	Andrei Vagin <avagin@google.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org, coresight@lists.linaro.org, 
	rust-for-linux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 25, 2024 at 5:24=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 24/06/2024 23:26, Namhyung Kim wrote:
> > On Thu, Jun 13, 2024 at 04:31:21PM -0700, Ian Rogers wrote:
> >> setup.py was building most perf sources causing setup.py to mimic the
> >> Makefile logic as well as flex/bison code to be stubbed out, due to
> >> complexity building. By using libraries fewer functions are stubbed
> >> out, the build is faster and the Makefile logic is reused which should
> >> simplify updating. The libraries are passed through LDFLAGS to avoid
> >> complexity in python.
> >>
> >> Force the -fPIC flag for libbpf.a to ensure it is suitable for linking
> >> into the perf python module.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >> Reviewed-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/Makefile.config |   5 +
> >>  tools/perf/Makefile.perf   |   6 +-
> >>  tools/perf/util/python.c   | 271 ++++++++++++++----------------------=
-
> >>  tools/perf/util/setup.py   |  33 +----
> >>  4 files changed, 110 insertions(+), 205 deletions(-)
> >>
> >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> >> index 7f1e016a9253..639be696f597 100644
> >> --- a/tools/perf/Makefile.config
> >> +++ b/tools/perf/Makefile.config
> >> @@ -910,6 +910,11 @@ else
> >>           endif
> >>           CFLAGS +=3D -DHAVE_LIBPYTHON_SUPPORT
> >>           $(call detected,CONFIG_LIBPYTHON)
> >> +     ifeq ($(filter -fPIC,$(CFLAGS)),)
> >
> > Nitpick: mixed TAB and SPACEs.
> >
> >
> >> +           # Building a shared library requires position independent =
code.
> >> +           CFLAGS +=3D -fPIC
> >> +           CXXFLAGS +=3D -fPIC
> >> +         endif
> >
> >
> > I'm curious if it's ok for static libraries too..
> >
> > Thanks,
> > Namhyung
> >
>
> I think I tested the whole set with a static build so it should be ok.

Ok, thanks for checking that!

Namhyung

