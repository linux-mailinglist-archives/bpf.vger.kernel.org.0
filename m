Return-Path: <bpf+bounces-17729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69D8122D6
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749871F21A3A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097377B41;
	Wed, 13 Dec 2023 23:29:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5992A3;
	Wed, 13 Dec 2023 15:29:35 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6da3a585c29so588655a34.1;
        Wed, 13 Dec 2023 15:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510175; x=1703114975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFIP83rhoE54Gnfznyg7yyjOyDv3wFcoz+vENWGRUZI=;
        b=bf3PeOrEXQwMs0p2nrdyAyG/Focu5z5f2vhlBFivL95ukXkxMfkqUQoKZEEPATPbfo
         0qwKibD7ZzWDCKeYtEruE7gzKzv7H5jnu623pBrvcLcoh6ow4bVQoUN0u3EHd1SHIYdj
         yqlfpcVmpppEZ/D0zuo3cCe2wHKBPsGG/K+tZjQ/kbMiKrSFyzotVh2qFq4vDbTd03w1
         ElU4F//LPTWLPvCnRgkMjSCLVon1ImyR1XUWFieGNqblVDFv7dhCO+nBP21W0glvPsIL
         aDIFf3+gxLZAaSgskyXhg3fIUoq5Opu5LFnKdLWzhyb03DjODk+8zbMGdQg8koSITnsY
         rnqQ==
X-Gm-Message-State: AOJu0YxLAnHvK48EAYD+NRjmY5cN90GA/iZSLvcGXf4putmKOdbAx9Bq
	SrN0edskYDI26EO1XEybCyLDEpYfulrAMFr7JIo=
X-Google-Smtp-Source: AGHT+IHYXoKUY8HypDLCxFSc4JvpVA0U4rkGcaFt5Oi3aDkjeXkr1M1Z1rZLnA3oUB/rtZ4u71yp8AlNVdV6J9c19Jg=
X-Received: by 2002:a05:6830:1e38:b0:6d8:7ded:6cc5 with SMTP id
 t24-20020a0568301e3800b006d87ded6cc5mr9225960otr.41.1702510174811; Wed, 13
 Dec 2023 15:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 13 Dec 2023 15:29:23 -0800
Message-ID: <CAM9d7civJ00iRmJ3CFfFcKteOLDaBY9tFkMTLi8vgjHipuBB1g@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] Clean up libperf cpumap's empty function
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

On Tue, Nov 28, 2023 at 10:02=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Rename and clean up the use of libperf CPU map functions particularly
> focussing on perf_cpu_map__empty that may return true for maps
> containing CPUs but also with an "any CPU"/dummy value.
>
> perf_cpu_map__nr is also troubling in that iterating an empty CPU map
> will yield the "any CPU"/dummy value. Reduce the appearance of some
> calls to this by using the perf_cpu_map__for_each_cpu macro.
>
> Ian Rogers (14):
>   libperf cpumap: Rename perf_cpu_map__dummy_new
>   libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
>   libperf cpumap: Rename perf_cpu_map__empty
>   libperf cpumap: Replace usage of perf_cpu_map__new(NULL)
>   libperf cpumap: Add for_each_cpu that skips the "any CPU" case
>   libperf cpumap: Add any, empty and min helpers
>   perf arm-spe/cs-etm: Directly iterate CPU maps
>   perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
>     use
>   perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
>   perf top: Avoid repeated function calls
>   perf arm64 header: Remove unnecessary CPU map get and put
>   perf stat: Remove duplicate cpus_map_matched function
>   perf cpumap: Use perf_cpu_map__for_each_cpu when possible
>   libperf cpumap: Document perf_cpu_map__nr's behavior

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

