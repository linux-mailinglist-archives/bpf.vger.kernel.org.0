Return-Path: <bpf+bounces-48596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA392A09DA2
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D07A188D1CE
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879B213E84;
	Fri, 10 Jan 2025 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpnXdv+E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16920A5C7
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547334; cv=none; b=ai6UkJAcBHifN32Q4CXOzvs7oQ5PpX+wE3fS49gufwX+DPSGDUhIvjVhssGPHJDe6lsTeDBDWDdnHKRa1LkXO//hgxe/UULLkjrhoTyeRtZqG+H05VsAgbKcRCbuDkFerwu3NrjxXFgyFFMSYPqT76jhOcVVWR39HjJdahoJIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547334; c=relaxed/simple;
	bh=Pbw6rr0ldA6M5FV1qyS9494wBAnh++0ucfBKORWl74Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6uotADxF25M95hZrt5WcqNpIRWlwIOsMVA1vw912jKJ6A8nhitdl8C3n4JoQ7+aUoS8f16Mq2v/jccdwT9ULtcfA9RGtw90lvxOiYe7TY1MfLyPc9J+1uF+Lfgg0Aig7cXXg4X2C/vWk81DpNfXru/L+ItX4II1gmDkIKg7jgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpnXdv+E; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a814c54742so36895ab.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736547331; x=1737152131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyf17ZT9slE7/aTobYnyZK2ZPH/yXI9i1sP5jC8kVzw=;
        b=UpnXdv+E5DtwkIjOCQGQ0tuXj6QbLmDfPyRmyJzeAYWgXhwHnsE7u8tn8XYw6e/QYL
         exCidXde6JEipHXYOC00UgzJCbtdaEkWm9vnlyQ/1ZVHuORF8zgAOhu7X1aVqfA3Wl4v
         8rsnbHFJBXBZBd9GF2igW9j9EBPHIhHPTx34GwxOUh8dBp9atamXAeaORZxqrgHdxDKW
         3Bk8swqasHcqG/MFEmiaSN19uwgmZiqtZJ7OWzl9zkG3v8qUNrur9RZm16o8PVfve1G6
         ylGK1JUmDEZcR37kfEOcfPfDd31o9pLBJotyn2b2uFRi2p9XKysrH5Mfv3NsSDYB2g9V
         S+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547331; x=1737152131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyf17ZT9slE7/aTobYnyZK2ZPH/yXI9i1sP5jC8kVzw=;
        b=nhn4USyPFYTYTQAhtnhlGUKyjnETrfCpGY/LFN1P+HZw7q6hT/7Igi03qgBQMezPyQ
         fp0Lp3Yiqs15qHr8qOXNvL/39HDIXzxOG1edVRmPnRvQXwbCy9uuKxE4nEVmxfKsgyN0
         WD1EPmHDCD6olRQ12Ig3qEFwb2/M/1eUqzHvitPjamPm7Q/+NRaeptQ4K1cM1M0/t/cS
         lXaTu4inkCorrRREiJzm/7Fs4B6BNmhiOyqSz/hWkvnMa9axL4gxX0HfkwSRfecuCO1u
         okDlJIZMYaQ7k/r7P/6xpUF/HETpTlP8JpM1DZ419Z8vgb87EmiUlFOBgcKpC8xgMrvL
         Plbw==
X-Forwarded-Encrypted: i=1; AJvYcCXfcZG9SGulzJYllKFXNs+IADIKHFxDfOM7uC1nK4cLNXRzMitCyigUggawk9aVV2yPyBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzqoYYcrVD2UABSms0kUCf2tJaMhaMBF8CUUkVbNBxKNDbn5A
	7tFmBITyyklc+vymydAVrx1fe9nE4neG2dPhSGdxB4rqDsNLdoNC5KUqlRlw6VbmftWPbti5gEo
	ct/M6B71QyqsIMEPk37oqmjx7so7MDZyJjGG5
X-Gm-Gg: ASbGncu/ngP3IJa6PlnOZKCSDqLK5wXEw0YkpFOBhIlQMxmuK7Tj4/883ker/EUBA7N
	YUXFjTJb8aG1sQ5KuC0jIlf7/9DttU5lZHPG5Nr0st78kblOA3JFG3Q2yyvzuZ/KG542MKQ==
X-Google-Smtp-Source: AGHT+IEL2R5yiLpoxdMkXtaQmYeERswzLOkBxw35xegyRNt4Srohdo0xhUoQmrH1tbE6Sr7n1azpu9sn8Fd/9X1QBsk=
X-Received: by 2002:a05:6e02:1889:b0:3a7:7d6e:fef9 with SMTP id
 e9e14a558f8ab-3ce58940c0fmr3815535ab.27.1736547329856; Fri, 10 Jan 2025
 14:15:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com>
In-Reply-To: <Z4F3qxFaYnMTtPw7@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 Jan 2025 14:15:18 -0800
X-Gm-Features: AbW1kvYjNVbCbiervK0hlM-K3dZs4T2o5kLS5RO58s8hIauUaHysPv7YXJMtqlY
Message-ID: <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 11:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Jan 09, 2025 at 02:21:09PM -0800, Ian Rogers wrote:
> > Originally posted and merged from:
> > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > This reverts commit 4f1b067359ac8364cdb7f9fda41085fa85789d0f although
> > the patch is now smaller due to related fixes being applied in commit
> > 22a4db3c3603 ("perf evsel: Add alternate_hw_config and use in
> > evsel__match").
> > The original commit message was:
> >
> > It was requested that RISC-V be able to add events to the perf tool so
> > the PMU driver didn't need to map legacy events to config encodings:
> > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.c=
om/
> >
> > This change makes the priority of events specified without a PMU the
> > same as those specified with a PMU, namely sysfs and JSON events are
> > checked first before using the legacy encoding.
>
> I'm still not convinced why we need this change despite of these
> troubles.  If it's because RISC-V cannot define the lagacy hardware
> events in the kernel driver, why not using a different name in JSON and
> ask users to use the name specifically?  Something like:
>
>   $ perf record -e riscv-cycles ...

So ARM and RISC-V are more than able to speak for themselves and have
their tags on the series, but let's recap why I'm motivated to do this
change:

1) perf supported legacy events;
2) perf supported sysfs and json events, but at a lower priority than
legacy events;
3) hybrid support was added but in a way where all the hybrid PMUs
needed to be known, assumptions about PMU were implicit and baked into
the tool;
4) metric support for hybrid was going in a similar implicit direction
and I objected, what would cycles mean in a metric if the core PMU was
implicit? Rather than pursue this the hybrid code was overhauled, PMUs
became more of a thing and we added a notion of a "core" PMU which
would support legacy events;
5) ARM core PMUs differ in naming, etc. than just about every other
platform. Their core events had been being programmed as if they were
uncore events - ie without the legacy priority. Fixing hybrid, and
fixing ARM PMUs to know they supported legacy events, broke perf on
Apple-M? series due to a PMU driver issue with legacy events:
https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st=
/
"Perf broke on all Apple ARM64 systems (tested almost everything), and
according to maz also on Juno (so, probably all big.LITTLE) since
v6.5."
6) sysfs/json events were made the priority over legacy to unbreak
perf on Apple-M? CPUs, but only if the PMU is specified:
https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
   Reported-by: Hector Martin <marcan@marcan.st>
   Signed-off-by: Ian Rogers <irogers@google.com>
   Tested-by: Hector Martin <marcan@marcan.st>
   Tested-by: Marc Zyngier <maz@kernel.org>
   Acked-by: Mark Rutland <mark.rutland@arm.com>

This gets us to the current code where I can trivially get an
inconsistency. Here on Intel with no PMU in the event name:
```
$ perf stat -vv -e cpu-cycles true
Using CPUID GenuineIntel-6-8D-1
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0 (PERF_COUNT_HW_CPU_CYCLES)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 752915  cpu -1  group_fd -1  flags 0x8 =3D 3
cpu-cycles: -1: 1293076 273429 273429
cpu-cycles: 1293076 273429 273429

 Performance counter stats for 'true':

         1,293,076      cpu-cycles

       0.000809752 seconds time elapsed

       0.000841000 seconds user
       0.000000000 seconds sys
```

Here with a PMU event name:
```
$ sudo perf stat -vv -e cpu/cpu-cycles/ true
Using CPUID GenuineIntel-6-8D-1
Attempt to add: cpu/cpu-cycles=3D0/
..after resolving event: cpu/event=3D0x3c/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             136
  config                           0x3c (cpu-cycles)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 752839  cpu -1  group_fd -1  flags 0x8 =3D 3
cpu/cpu-cycles/: -1: 1421235 531150 531150
cpu/cpu-cycles/: 1421235 531150 531150

 Performance counter stats for 'true':

         1,421,235      cpu/cpu-cycles/

       0.001292908 seconds time elapsed

       0.001340000 seconds user
       0.000000000 seconds sys
```

That is the no PMU event is opened as type=3D0/config=3D0 (legacy) while
the PMU event is opened as type=3D4/config=3D0x3c (sysfs encoding). Now
let's cross our fingers and hope that in the driver they are really
the same thing. I take objection to the idea that there should be two
different priorities for sysfs/json and legacy depending on whether a
PMU is or isn't specified in the event name. The priority could be
legacy then sysfs/json, or it could be sysfs/json then legacy, but it
should be the same regardless of whether the PMU is put in the event
name. The PMU in the event name should be optional, for example we may
or may not show it in the stat output. The encoding being consistent
was the case prior to the Apple-M? fix and this patch aims to make it
consistent once more. Given the ARM bug mentioned above it should also
fix specifying or not the PMU on Apple-M? CPUs as it will avoid the
same legacy event issue that may only exist on old kernels. RISC-V is
motivated because of not wanting hard coded legacy events in the
driver for all potential vendors and models.

Thanks,
Ian

