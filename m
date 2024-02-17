Return-Path: <bpf+bounces-22199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF3858C7E
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 02:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A0428331E
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 01:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA81D537;
	Sat, 17 Feb 2024 01:04:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33C1B80F;
	Sat, 17 Feb 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131854; cv=none; b=pCu+rKMVl+Z/OxgFSwfbRdsPG1UMmWH9xCvktTpC6X4z9UDX70k/swEg+4w8/ohbtITFW1LFjVE950/GH8ltTHbB5TqJiOq0wIgN7akvv2uJ5b8ohlixPzfg+AuW1Ta3iVr9kjHS82G06k/Rkcuyil3WZfXz1140pYBT+Pbk/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131854; c=relaxed/simple;
	bh=fDxclCaSupPXRNu51PlBmR/SJ4Ajiu5GVSt0QfQMLFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8zCk28hbe0ycYz1wJBL3SMwE0e9Tu4VFDzVkI+LruxHVYZPTe+3O4++rE82aGRJram/Zk12CVLcotoU85eOf/QbsHUXiIjpxN5JNV2O+21xNn8gFGODhpNPpgwMoqpJ2n2DMgxCV2B2zstXtUpW/UECAqNCF4qaVmYhbqYe3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so2108091a91.2;
        Fri, 16 Feb 2024 17:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131852; x=1708736652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFIQ3pkHQmdaVe39SLDFjOJN8P18A7ehY0Fp/CyADS4=;
        b=tQaT5wIWA+u4s+YuCNT5CpmLEu68TEw4LTfpXUvIQjMfoc8MEfNOPRlaLafoDkU3J1
         +343bICmiVib4AysgOpRsf/QsG3jjpcc7s9FH3wZF4xupXG8wqQe5xVR6e4LA8RTYyWr
         ui3kcjRF8ntrXjdABwOF+1s5G0dsxC8Pg+btX+3pzyj14sDJe0XLoSStE9VUgYT1Lbgj
         kfCJi5cWMv5W40g/GrGgsqOdLZ8NrJgfxt2thA3kWmX3jcN8jgOSmWh+C7po+6VM50be
         Qa3qcE6EppJAMvTNa+dy0HGx7i2n3Q9D04zEg3P1E6q21Kaqt9cMXqiMgUBsFze56OVG
         CrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkQW1iyvJbFa+xFmV2uTUJmQ7pZ+sTR6ynadEB8+a9/YFp/sKnvCwLRHvzgpecRd1rSnZZ70d5P+rvD8cTt8sc7yzf8MiuiHYJus+xBLZ4cN51wFWJu3O0/x3ohcxUzcYj5nYkFEpRahP+hMWwjsEEZsR3gy5GGq0fSbFztKKbTIIewA==
X-Gm-Message-State: AOJu0YyDShfc22Lu6Wp1zRFZ+TEu0ut+xwRitF6Y0K1oMWacR1pNL2NT
	qMDMKSl1wIOfgfQ1WiYQNbDhesNP+Tq96rq1Og/W5uZaXbSosN8UquTV3dB8EvgnzsBCvi3kye9
	6S6JEej6K+t+At6YeYuVk7/NGgEw=
X-Google-Smtp-Source: AGHT+IGoh7lmz+EcIMtg0X0XRqi8GKL9cy+mqlpDSRzny2NjPCRXV3K1Q1CBF5lzqtp5Qc+dmZEV+9b+bOGmUHY2hgw=
X-Received: by 2002:a17:90b:14c:b0:298:e3aa:c2e0 with SMTP id
 em12-20020a17090b014c00b00298e3aac2e0mr5940601pjb.13.1708131852153; Fri, 16
 Feb 2024 17:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com> <CAP-5=fVjAHqAHHLqE=3v2bP6S6k98psiuZds7TUTFCT7RgMFdQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVjAHqAHHLqE=3v2bP6S6k98psiuZds7TUTFCT7RgMFdQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 16 Feb 2024 17:04:01 -0800
Message-ID: <CAM9d7ciPYMd4zckrcgnPtradZ_bvaNOHji1tkkYQu_TTF5=eYw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Clean up libperf cpumap's empty function
To: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
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
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:03=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Feb 2, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Rename and clean up the use of libperf CPU map functions particularly
> > focussing on perf_cpu_map__empty that may return true for maps
> > containing CPUs but also with an "any CPU"/dummy value.
> >
> > perf_cpu_map__nr is also troubling in that iterating an empty CPU map
> > will yield the "any CPU"/dummy value. Reduce the appearance of some
> > calls to this by using the perf_cpu_map__for_each_cpu macro.
> >
> > v3: Address handling of "any" is arm-spe/cs-etm patch.
> > v2: 6 patches were merged by Arnaldo. New patch added ensure empty
> >     maps are allocated as NULL (suggested by James Clark). Hopefully a
> >     fix to "perf arm-spe/cs-etm: Directly iterate CPU maps".
> >
> > Ian Rogers (8):
> >   libperf cpumap: Add any, empty and min helpers
> >   libperf cpumap: Ensure empty cpumap is NULL from alloc
> >   perf arm-spe/cs-etm: Directly iterate CPU maps
> >   perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
> >     use
> >   perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
> >   perf arm64 header: Remove unnecessary CPU map get and put
> >   perf stat: Remove duplicate cpus_map_matched function
> >   perf cpumap: Use perf_cpu_map__for_each_cpu when possible
>
> Ping. Thanks,
> Ian

Adrian and James, are you ok with this now?

Thanks,
Namhyung

