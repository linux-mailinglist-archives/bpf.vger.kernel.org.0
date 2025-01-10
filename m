Return-Path: <bpf+bounces-48514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE6DA08646
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 05:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9253D7A3E9F
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 04:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77FA2063C1;
	Fri, 10 Jan 2025 04:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUWqwRsP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0111FE452
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736484294; cv=none; b=NKljd80IEt9e9QNLQWwe+YZI6sB6XsaFI9P9jRzj+vLoteUJZvPbtLj55v0NbAWDUL7GMCvoN/F3R1wsi+0Z0aNozEN8KnyqwKGH5YukfSLVz3Sfaq0SM71GH4pdWcHRnpwYSDFXvBeJUjdyFoE3qishNa+J2rRQpUshfBu2uTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736484294; c=relaxed/simple;
	bh=rhc9WoBcCrj3Xv6WbD4jAxuacJRXfXMgdndMFT/i/SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLwXMx6sK9/+USvPVnnBP/X/rMN8eDuZ6ib4H8SxWIcU24jWrwk2cPgxYXbVs2THeHSvXxZFWNCx1b2pBD3BAWsY5wQL99qJFaka07p4gv2n/yBOhlwnE3Z/A+zbMfzpzM2s+tbrHA5wLF3sxRja/CNIJ/IewGQ3HwJemSWECek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUWqwRsP; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so82475ab.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 20:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736484292; x=1737089092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhc9WoBcCrj3Xv6WbD4jAxuacJRXfXMgdndMFT/i/SA=;
        b=VUWqwRsPQpQBfN5lXN+2gaGa4wzJZeoYkXuoi9MJ3Eimn/1lxUpyWk/oCmohChFNrV
         a/IuBNuyEAHTqDWoS1+1iEgAzbbAtfS02ACD8P+J5W9+lzFfyxQ0TR/kg8kmSajvcUhl
         LpqpJ7vw0Ed9lSvvT0jHoREW+iXoqdLbBK3MPRdqbLbg6VTgBGUuI5mLUg3Xz/26C+P9
         JnNh2q1EPGDEVcK4GII2AcGkUc6ZWmL3ErA6qmEQSJFrIptXY2955oP5RasFNx8xOXBg
         Nca/OZZP0/manE7ZFmOklvdTQhOIbCnR1PwHXNoP/p+XnCpwYimdD03Xpp529gaxESKh
         p5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736484292; x=1737089092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhc9WoBcCrj3Xv6WbD4jAxuacJRXfXMgdndMFT/i/SA=;
        b=YuUeklUyxnzAGnYeMk77KDM++T/eg+kAwEhrGN1M1kzZurBqrpjfcK7tBWn/ROAhDE
         1neLMNfIHVAPdYCIF9AcVjldSq7v/4hxiCgMsvDI+8kl6WV5z1E0sQcttOGC/E3EZCso
         8EVCcKF0U3TRbB7C2kz/BYevSoIc+OPMuFk3/lG3LMCQ5Y7cYjJN8ElgT8uq8YfWMzck
         jAJpaIVFIwYyZpT7WAd/mDodSsOIX8XWPNl9noNtXsQg+pQiI+BeC5ge7JqLBoNDx55e
         OzsCRHJCSnB9x+OpihHMHEJyrxzObw3mQyAfR0k1JCczn5ZmWHItanuLx71dXdQkSosj
         AHng==
X-Forwarded-Encrypted: i=1; AJvYcCUUtkvWAbe3af4Zw75HlQqJTvyuxGlwfxInVNnvBI74LKMYVSWHwEVCIr0ZJvvPMfC5zDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUc1SuW3BPyxLUI5Hco6GVBaOJGbnZuPDQwSHGqj6QukpRCKhD
	B4S815D5wvyQmjgMeqDc4qSNIcJSz7LctcwB+MiYctPeU1gRdQ71Z6KKJGiPxG6B/PqB6YDJk9E
	Lvrvf48feuiyLD/A3CMaOYHk1ByGyDyCtm7PF
X-Gm-Gg: ASbGnctwN1/yT7Fzsn5G1T0JDLbY3tKl74MdZ9yCiABlsttdcndSfdSr5xDMfgcYQLF
	1dsiYyWSq9YwB8EoCdHjTBE70FvriZTPmFWQrIiQ=
X-Google-Smtp-Source: AGHT+IHgBTic5uczvh33A44/10usj/9leA+TWY4Mw590l5OXMqFj7OBGqzZvOu0Le88oZP6mKnGbJzVnLarQPWsieUs=
X-Received: by 2002:a05:6e02:2165:b0:3a7:6edb:a87f with SMTP id
 e9e14a558f8ab-3ce56c22a8dmr1971555ab.6.1736484291604; Thu, 09 Jan 2025
 20:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com>
In-Reply-To: <Z4B279zu_8Kz5N6u@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Jan 2025 20:44:38 -0800
X-Gm-Features: AbW1kvbUzsdIQK4Em_2EoveZDwRfmIi5IlVOp3G93xJpjZVLLtz2riQb_Xue4jQ
Message-ID: <CAP-5=fUSfbZGNaUttM3UCzcrMzkkFAJVA8mheMKQ0nxNH_KuTg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that don't open
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 5:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > Whilst for many tools it is an expected behavior that failure to open
> > a perf event is a failure, ARM decided to name PMU events the same as
> > legacy events and then failed to rename such events on a server uncore
> > SLC PMU. As perf's default behavior when no PMU is specified is to
> > open the event on all PMUs that advertise/"have" the event, this
> > yielded failures when trying to make the priority of legacy and
> > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > legacy event user on ARM hardware may find their event opened on an
> > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > such events which this patch implements. Rather than have the skipping
> > conditional on running on ARM, the skipping is done on all
> > architectures as such a fundamental behavioral difference could lead
> > to problems with tools built/depending on perf.
> >
> > An example of perf record failing to open events on x86 is:
> > ```
> > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > Error:
> > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' wh=
ich will be removed.
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) f=
or event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> >
> > Error:
> > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' wh=
ich will be removed.
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) f=
or event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> >
> > Error:
> > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be re=
moved.
> > The LLC-prefetch-read event is not supported.
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
>
> I'm afraid this can be too noisy.

The intention is to be noisy:
1) it matches the existing behavior, anything else is potentially a regress=
ion;
2) it only happens if trying to record on a PMU/event that doesn't
support recording, something that is currently an error and so we're
not motivated to change the behavior as no-one should be using it;
3) for the wildcard case the only offender is ARM's SLC PMU and the
appropriate fix there has always been to make the CPU cycle's event
name match the bus_cycles event name by calling it cpu_cycles -
something that doesn't conflict with a core PMU event name, the thing
that has introduced all these problems, patches, long email exchanges,
unfixed inconsistencies, etc.. If the errors aren't noisy then there
is little motivation for the ARM SLC PMU's event name to be fixed.

Thanks,
Ian

