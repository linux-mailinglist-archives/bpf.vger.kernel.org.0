Return-Path: <bpf+bounces-50108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E371A228C1
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 07:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351F13A38E2
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 06:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51F191489;
	Thu, 30 Jan 2025 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hoiodxtz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79497143888
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738216998; cv=none; b=uLHbHPy7CWfh4bC0NCPY+lBRPYjs8lvWx4dT19Nj2xdp9yEuprHpMjFgFf7xrwL94ZOFClgqB1VLKe6aO7AGw1oxQfvsRk/7dDwGBaH25R4e2RYNOi2w0GaakjkPPQnIvgWmHgs6jVoQDac+l89nT3O9Zem5IRJt3eniIK/FKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738216998; c=relaxed/simple;
	bh=oWGw9zHIGHKeMe5UKOq/ra6FucSB6XTYH8/uPHPEy7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JicroQCJdiqaOKVQlZVTk+GKS7bquncUbzJFKA9uRWirH0NRS4zrJBhbikkaytuqZhlC/f9a5MmDWj7b2fs3KaG45IBLCATdH/NERJuxP+54OZYGAQXp8ZamG1rZ/kULSeKlB0nENYSBE/jtPluf3/NNFXeRo0DCCT4Y+k/JRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hoiodxtz; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so97715ab.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 22:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738216995; x=1738821795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2Q6UcIc4PGXAsHOkvLpiqRFBRRcsEgb9coO2t90kXo=;
        b=HoiodxtzK3vEdtiFD77wegRTEUk5RXzvce2GG0hNYRnf3V81BvnVL3vx1TZKbfrV5V
         RnnRBqr0SkmQrGjeW6tfogBqae6cbqkmuW7q1IWlGRdHEJWSEAM7HYRh24IObbpfkNsM
         O8teUfveknrUaK7SpUG2rbq7ha7CKI8+huVnMJnyUgrPCYLn8nXxLFuddXSWhETyDcFF
         tgWHUvX6tom8Dy1LrHnDglSBsh2DGRgkHCobR6caIwzBLLUwfkuwa7VPfIYMC/TwUTnJ
         vdguLbXWW5T5fg0aKFQOEppUWfLzKVkTCkPkrTZsVhe4Ut38OannmN9iWiv1plZ+Qe37
         xNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738216995; x=1738821795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2Q6UcIc4PGXAsHOkvLpiqRFBRRcsEgb9coO2t90kXo=;
        b=fGQkXOTemdUgHUnRJ2M3e7CfL9N5SaA2rL8PB2EJsmr2fdoklfSKzrjK2Ge91nQ+5y
         nIRV+dk2Zb+4aFj2INDJcM1EgGWNryI0U1VzJW+/t6XlvnhZOYigFZnYCPS+FMcdBpbI
         NUDmo1Y9JljoUJ+guYzgWiFX5I5HopEdBHRlveKJiIPMRxk6xT3MTLk7uFPVrXuYa7C/
         DVImsOKolyXPcX5ZDLFNJEwxR6NMP8NdPPRQl8J1hAikWaSriuD4J6EZfWtV5sudP+O9
         jXoN2FRQv6MxT99FUkUtuuWHd1Y66JwZ2MeS6Nov2Dsk5H5ExTm2NOTT40BXZNLub2dC
         sFMA==
X-Forwarded-Encrypted: i=1; AJvYcCVqftiSNhI72Py5skYPjIu1oQf0XqSPIHjNLYPyfMFAwZ/VhR2nspevix/m04FwCBl9458=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Me9uX3Sdu2STncy18xZdjDu6v3NsUDlaZ7rYwflATzfsGghi
	k7LEZ/0a5BIUIs2+Td7Vaxi42auTI31ZEXcNSIpHAmKzp3r6igTD3JCzgowZFPMhV2WzAYsHd8s
	3k5pSY2t13a79EbKWd4DczHVZoDRSlyBpNAjr
X-Gm-Gg: ASbGncui2ODztgyzWiXEf3Rcpy8lTi4YzaXJu66PsPiWE247xGWEfJuFmyybcdfLD4Q
	pc84AhkqGO6b4edMO1HkCKIYFDHwN07jf+37qdKSkksVNH/M+fTyEgB7jlHedNeJmSuhXVuIDuQ
	==
X-Google-Smtp-Source: AGHT+IFHzVhMXvUnn9VwRutFPGkQv1pkOqgyHubMbKWWcsDCfVwiS1XBYCxqWpL1TyAKTQZ8GVoXBMEXCjw+qobWal8=
X-Received: by 2002:a05:6e02:144e:b0:3a7:e301:a1f2 with SMTP id
 e9e14a558f8ab-3d00a937f4amr1330055ab.15.1738216995337; Wed, 29 Jan 2025
 22:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-5-irogers@google.com> <Z4F3qxFaYnMTtPw7@google.com>
 <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com> <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com> <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com> <CAP-5=fV4Q-J+Coybk5Uw=Xpx9sm5MG=2b-fvRLX14K+ZJcmz5Q@mail.gmail.com>
 <Z5sLIiU7D6GwpWY1@google.com>
In-Reply-To: <Z5sLIiU7D6GwpWY1@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Jan 2025 22:03:03 -0800
X-Gm-Features: AWEUYZl872MFdgcO8clNe045ru989pjy5VODtjPfzJKZqjiort1kw_xtslpQuuA
Message-ID: <CAP-5=fXHuR37Q-1qhZx_wLeSTh6k-T1DrV0EquDuLEpwnHa21A@mail.gmail.com>
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

On Wed, Jan 29, 2025 at 9:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 29, 2025 at 05:16:58PM -0800, Ian Rogers wrote:
> > On Wed, Jan 29, 2025 at 1:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > On Wed, Jan 15, 2025 at 01:20:32PM -0800, Ian Rogers wrote:
> > > > On Wed, Jan 15, 2025 at 9:59=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > > I think the behavior should be:
> > > > >
> > > > >   cycles -> PERF_COUNT_HW_CPU_CYCLES
> > > > >   cpu-cycles -> PERF_COUNT_HW_CPU_CYCLES
> > > > >   cpu_cycles -> no legacy -> sysfs or json
> > > > >   cpu/cycles/ -> sysfs or json
> > > > >   cpu/cpu-cycles/ -> sysfs or json
> > > >
> > > > So I disagree as if you add a PMU to an event name the encoding
> > > > shouldn't change:
> > > > 1) This historically was perf's behavior.
> > >
> > > Well.. I'm not sure about the history.  I believe the logic I said ab=
ove
> > > is the historic and (I think) right behavior.
> >
> > You're wrong as you are describing the behavior post:
> > https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
> > commit a24d9d9dc096fc0d0bd85302c9a4fe4fe3b1107b from Nov 2022, but
> > somehow without legacy event fall backs which Intel added with a PMU
> > for hybrid.
> >
> > The behavior in this patch series is best for RISC-V, presumably ARM
> > (particularly for Apple M? CPUs), carries ARM and Intel's tags,
> > implements the behavior Arnaldo asked for, and solves the
> > inconsistency that I think is fundamentally wrong in the tool that PMU
> > names shouldn't matter on an event name (an inconsistency my past
> > fixes introduced). It is also part of solving other problems:
> > https://lore.kernel.org/linux-perf-users/20250127-counter_delegation-v3=
-0-64894d7e16d5@rivosinc.com/
>
> So you think the below behavior is preferred, right?
>
>   cycles -> cpu/cycles/ (or whatever PMU name) -> sysfs or json
>
> And there's no way to use legacy event encodings anymore?

This is absolutely the right thing to do! If sysfs/json knows better
than to allow a legacy event named cycles, advertises it, then perf
should select it. Not doing this was the cause of the ARM Apple M?
breakage - because their PMUs looked uncore before hybrid fixes and so
weren't known previously to accept legacy events and always used the
sysfs/json encodings in preference. Why would or not having the PMU in
the event name imply a different and sometimes known broken encoding?
And then in the perf stat uniquification we can rename the event to be
the version with a different encoding. It is madness to me.

If a user wants to force a legacy event, even though most typically
the driver is saying it knows better, they can use a raw event
encoding or in the case of cycles its alias cpu-cycles. If there
really is a use-case for using legacy encodings, we could introduce
new legacy-cpu and legacy-cache PMUs that advertise the events, but
then the wildcard behavior would be weird.

To be clear, I do not know of a single use-case where the legacy
encodings are actually wanted when sysfs/json have an encoding. The
opposite is very much true, that legacy encodings are not wanted -
hence wanting the lowering of their priority everywhere originally by
ARM to fix Apple M? and then by RISC-V.

> >
> > You've not pointed at anything wrong in the scheme that these patches
> > introduce, and are supported by vendors, except that it is a behavior
> > change. I can, and have, pointed at many issues with your proposal
> > above and the current behavior. The behavior change came about to work
> > around PMU bugs over 2 years ago but only partially did so. It makes
> > sense to remedy this and for the clean, consistent behavior this
> > series achieves. It is unfortunate that it is a behavior change, but
> > the first step for that was made 2 years ago. I think it also makes
> > sense that something self described as legacy is a lower priority and
> > of the past (wrt event naming moving forward).
>
> I want to clarify the event parsing behavior and to find the right way
> to deal with various cases.  I haven't followed the activities in this
> area closely so I missed some changes in the past.  Maybe the problem
> is that the behavior is complex and not clarified.  Hopefully we can
> write it down in a doc.

I think what is typical in the kernel is the source is the best
documentation. By simplifying event parsing, for example,
parse-events.y has been reduced from 952 lines (in v5.10) to 762 lines
- so we're about 25% simpler whilst being more correct (I've fixed all
the memory leaks, etc.) and avoiding expensive start-up costs, lazy
initialization, etc.

Having a single priority for which events are preferred, legacy vs
sysfs/json with or without PMU, will further make the code base
simpler and easy to understand.

Thanks,
Ian

