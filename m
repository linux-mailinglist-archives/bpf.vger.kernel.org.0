Return-Path: <bpf+bounces-22194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063DB858BCE
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 01:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18FC1F2149C
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 00:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD189171D1;
	Sat, 17 Feb 2024 00:25:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43975C8B;
	Sat, 17 Feb 2024 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129523; cv=none; b=LGwNf2IBYNlrC2JNDVAcvBD3zfCfQEu1o407kxAi9I6jkKWTVQCJbzSFXccur6cNibqlqb586zbGvX00d3FWXoED+XQD6mnbjZxThCanFYdlsMej7muaznQHe1SvBxx37WelKDRCusdRmq/QuE7vARY3TAayyriWNLSp5VplRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129523; c=relaxed/simple;
	bh=TB3RsJQOiyTR8tEs8xp9ZVxkFZri+g+5FS8M54/Voa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3YRCYAahlryNjFtsBpOqpCg9bdVXQgRsqWgEpsrPoR5gMIM+8luAYOpeC2XaUPmX9Yqm6XYCHhcR/HQpy0FbnSZVqv8MtBwPdeD1NHKXQeGS0BcYRLm15co/KhgKvOZvkKgFROxspS6jnMjpWq7NdRG91oWYni4ceh8Ew2ck9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2087790a12.0;
        Fri, 16 Feb 2024 16:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708129521; x=1708734321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gV3LRreLb1kZqKq2G0q5vBMXGxsObp5N7fG6tA3C6K8=;
        b=KOGv5NFOj4lVtbUwt6FmRVE099GCSoVBvp5B47tiZ8sbfP+u/GBhnuOSmjNGPhOC00
         WBAzX8LC+Nii9s0Y339H0K8MURKLZS3lGLBsi2gC0mj/PaDEBYzIlo6zzwtXdml/gPIp
         fJO0e6BW1Vlx8AiYe5Tn7VPSmA5Gf3olK3lMYwxjQyfIhuetAZucCv1ipIdNy1X7Db16
         FpsJ1czLwH0pcp0uihfMuD9y1OCjpMP/W1BMiHAWylLs7uAgoIfsAi6l/MtLG7LEAAEm
         OdfcczUKqUphdm4eabjE2VliQHEbexdHXQA0U729RsOP6htb/W3uRJx143kWQfXEPy2G
         AOrA==
X-Forwarded-Encrypted: i=1; AJvYcCU6cMKPk9gOhyOg8gxRfJBiye+tRXsh7z/ZheAslzddFcrZmgccVtAkF7wa22ZNAoyK51g1fy2OZtx8ptqT9m/kXFswLnPHdEznOywrSaccehpcWXmhUfZIkI5OTlwprI5XVHaaEfy2jVFRh33YBHSD8u2YtN0ApbiC0hd+0xM+gexRuA==
X-Gm-Message-State: AOJu0YzlAinW5BC3uba+kVeS2PYJ81cDBAy3FCWrPYXdtoy2lKhtMzsA
	S15MfAFavF2CoJfSGqtsJ1n5Ynljam8wghJHIU+1VpPHdSZZWQ8xfAySmITdgs4p9U5RB9Mv8Jq
	gP5ryyJNT98j6vZG0LoCaPt433Ws=
X-Google-Smtp-Source: AGHT+IEgpCI0dTfACZVpuBHoCKGcTgiO+7b7Q9T9pTbKkzbsQbncP1/gmAFLhNBzmL85pp+qTwVtCNOZYq6nrUHrEq4=
X-Received: by 2002:a05:6a21:1706:b0:19c:6a60:b433 with SMTP id
 nv6-20020a056a21170600b0019c6a60b433mr6463168pzb.3.1708129520906; Fri, 16 Feb
 2024 16:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com> <20240202234057.2085863-3-irogers@google.com>
In-Reply-To: <20240202234057.2085863-3-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 16 Feb 2024 16:25:09 -0800
Message-ID: <CAM9d7ci3VO7reyxPc8WOczdoyYYCUshxCJDMZ7wPpHknCubNXQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] libperf cpumap: Ensure empty cpumap is NULL from alloc
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
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

On Fri, Feb 2, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Potential corner cases could cause a cpumap to be allocated with size
> 0, but an empty cpumap should be represented as NULL. Add a path in
> perf_cpu_map__alloc to ensure this.
>
> Suggested-by: James Clark <james.clark@arm.com>
> Closes: https://lore.kernel.org/lkml/2cd09e7c-eb88-6726-6169-647dcd0a8101=
@arm.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/cpumap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index ba49552952c5..cae799ad44e1 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -18,9 +18,13 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, in=
t nr_cpus)
>
>  struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
>  {
> -       RC_STRUCT(perf_cpu_map) *cpus =3D malloc(sizeof(*cpus) + sizeof(s=
truct perf_cpu) * nr_cpus);
> +       RC_STRUCT(perf_cpu_map) *cpus;
>         struct perf_cpu_map *result;
>
> +       if (nr_cpus =3D=3D 0)
> +               return NULL;

But allocation failure also returns NULL.  Then callers should check
what's the expected result.

Thanks,
Namhyung

> +
> +       cpus =3D malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus=
);
>         if (ADD_RC_CHK(result, cpus)) {
>                 cpus->nr =3D nr_cpus;
>                 refcount_set(&cpus->refcnt, 1);
> --
> 2.43.0.594.gd9cf4e227d-goog
>

