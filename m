Return-Path: <bpf+bounces-17583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5580F763
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E9D281FD6
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100452773;
	Tue, 12 Dec 2023 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMnWj8Xh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A96FB9
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 12:03:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so2447a12.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702411384; x=1703016184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv1+Mtk2Gb5EiPRPIvE+IzzrHt4kY36IyFcki/03XAg=;
        b=zMnWj8XhLMYtIWUzrVfUFw1V40ASR+nE/TEu1+mMnvXF6w0Tm3h0WG3Fu62WhqMLNn
         AKcd4Bk2Z5Wontkn5TniSMfooYhR8b7s3z5FApYJX/ZyNg/am3lWmEtY8fY8xhtw1TPg
         TjViyhOqjyAejoa2oZOkTi+8if4XWHBZ4nNRv/3gXvKV+r7OQW0tkqkj1t7DkfEDoRPv
         R/mNPSHbdqfbH894ku7wqn/0jFpHkSm0iCb7NhbRbOb8KMseBZ4BiOrMyPuTbF5gLjWX
         2m11eIrM90jtI+fZpqS2xzcyrlUqDKLzi+ufrktfk92qR+l9MiBCTlcbxOJG97BoZGlw
         oizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411384; x=1703016184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bv1+Mtk2Gb5EiPRPIvE+IzzrHt4kY36IyFcki/03XAg=;
        b=vXEQ+YplYK+GsFFGRGAIjG0Pmpdxi5cHrCXIObX8f/jfCNsp7xZ+d/R9NIQf/6aLm/
         Drt8R2qU7owSKEt0ErnzH+r6wxumH4/yFpP5Wk+a9Yr2DCNNwLzJxpzwwU/DTkxHPhFF
         W4XFCFFs/MqtBgrJWRUAjowqOAsjv5e2K8Ysp0HfKAZLUUOnZ9gd7kjtp5f+GbGSXcqU
         XDyCYN2Kw5cZ5q6fMT99LnyVlTS78pksNELX8kiLIMC1iwQjjBhy5pdiErthJJDhVWPe
         HMH/Z/ZUYWIbHuxV30ucg7mSLjMLxxET5mLum4O4b7SVPPVzyv+UfUmpoxK09gYSuzL5
         fYWg==
X-Gm-Message-State: AOJu0YyaPrYjA4VHtNVRvxr8dcRUBqcX5aEwOCggJubLJsUpo9Lg0MkR
	7yztFsoPSIDZ0L4dSFs1FH/Cy935tJvjz+RPuUBuwQ==
X-Google-Smtp-Source: AGHT+IFxty5Rwnq+BtDPrniM4NJu3mhBKPuQvOaZ2F5HMTUvDhuTrhmlfn2DE5f/6qdWo9MdtqjM8mJL+S15eFV00h4=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr392000edj.0.1702411384344; Tue, 12 Dec
 2023 12:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com> <20231129060211.1890454-7-irogers@google.com>
 <63d7fe55-719e-43f8-531c-eb7fa30c473a@arm.com>
In-Reply-To: <63d7fe55-719e-43f8-531c-eb7fa30c473a@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Dec 2023 12:02:52 -0800
Message-ID: <CAP-5=fXenjeSDcOiQPq0xUyZSpb9PiQ_W7=FVx5oYNYd--RqCA@mail.gmail.com>
Subject: Re: [PATCH v1 06/14] libperf cpumap: Add any, empty and min helpers
To: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 6:01=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 29/11/2023 06:02, Ian Rogers wrote:
> > Additional helpers to better replace
> > perf_cpu_map__has_any_cpu_or_is_empty.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c              | 27 +++++++++++++++++++++++++++
> >  tools/lib/perf/include/perf/cpumap.h | 16 ++++++++++++++++
> >  tools/lib/perf/libperf.map           |  4 ++++
> >  3 files changed, 47 insertions(+)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 49fc98e16514..7403819da8fd 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -316,6 +316,19 @@ bool perf_cpu_map__has_any_cpu_or_is_empty(const s=
truct perf_cpu_map *map)
> >       return map ? __perf_cpu_map__cpu(map, 0).cpu =3D=3D -1 : true;
> >  }
> >
> > +bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *m=
ap)
> > +{
> > +     if (!map)
> > +             return true;
> > +
> > +     return __perf_cpu_map__nr(map) =3D=3D 1 && __perf_cpu_map__cpu(ma=
p, 0).cpu =3D=3D -1;
> > +}
> > +
> > +bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
> > +{
> > +     return map =3D=3D NULL;
> > +}
> > +
>
> Maybe it doesn't currently happen, but it seems a bit weird that the
> 'new' function can create a map of length 0 which would return empty =3D=
=3D
> false here.
>
> Could we either make this check also return true for maps with length 0,
> or prevent the new function from returning a map of 0 length?

We can add an assert or return NULL for size 0 in alloc. I think I
prefer the return NULL option. It should never happen but it feels the
right defensive thing to do.

Thanks,
Ian

> >  int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu=
 cpu)
> >  {
> >       int low, high;
> > @@ -372,6 +385,20 @@ bool perf_cpu_map__has_any_cpu(const struct perf_c=
pu_map *map)
> >       return map && __perf_cpu_map__cpu(map, 0).cpu =3D=3D -1;
> >  }
> >
> > +struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map)
> > +{
> > +     struct perf_cpu cpu, result =3D {
> > +             .cpu =3D -1
> > +     };
> > +     int idx;
> > +
> > +     perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
> > +             result =3D cpu;
> > +             break;
> > +     }
> > +     return result;
> > +}
> > +
> >  struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
> >  {
> >       struct perf_cpu result =3D {
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/incl=
ude/perf/cpumap.h
> > index dbe0a7352b64..523e4348fc96 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -50,6 +50,22 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_c=
pu_map *cpus);
> >   * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has =
the "any CPU"/dummy value.
> >   */
> >  LIBPERF_API bool perf_cpu_map__has_any_cpu_or_is_empty(const struct pe=
rf_cpu_map *map);
> > +/**
> > + * perf_cpu_map__is_any_cpu_or_is_empty - is map either empty or the "=
any CPU"/dummy value.
> > + */
> > +LIBPERF_API bool perf_cpu_map__is_any_cpu_or_is_empty(const struct per=
f_cpu_map *map);
> > +/**
> > + * perf_cpu_map__is_empty - does the map contain no values and it does=
n't
> > + *                          contain the special "any CPU"/dummy value.
> > + */
> > +LIBPERF_API bool perf_cpu_map__is_empty(const struct perf_cpu_map *map=
);
> > +/**
> > + * perf_cpu_map__min - the minimum CPU value or -1 if empty or just th=
e "any CPU"/dummy value.
> > + */
> > +LIBPERF_API struct perf_cpu perf_cpu_map__min(const struct perf_cpu_ma=
p *map);
> > +/**
> > + * perf_cpu_map__max - the maximum CPU value or -1 if empty or just th=
e "any CPU"/dummy value.
> > + */
> >  LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_ma=
p *map);
> >  LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, str=
uct perf_cpu cpu);
> >  LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
> > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > index 10b3f3722642..2aa79b696032 100644
> > --- a/tools/lib/perf/libperf.map
> > +++ b/tools/lib/perf/libperf.map
> > @@ -10,6 +10,10 @@ LIBPERF_0.0.1 {
> >               perf_cpu_map__nr;
> >               perf_cpu_map__cpu;
> >               perf_cpu_map__has_any_cpu_or_is_empty;
> > +             perf_cpu_map__is_any_cpu_or_is_empty;
> > +             perf_cpu_map__is_empty;
> > +             perf_cpu_map__has_any_cpu;
> > +             perf_cpu_map__min;
> >               perf_cpu_map__max;
> >               perf_cpu_map__has;
> >               perf_thread_map__new_array;

