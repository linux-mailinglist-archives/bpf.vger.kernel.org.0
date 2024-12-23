Return-Path: <bpf+bounces-47552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD69FB4E1
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B255B1884F0C
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0501880038;
	Mon, 23 Dec 2024 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEU5Qhpz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D811B0F16
	for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984675; cv=none; b=MCJ3BfDHgDVDjAD/Ukh1Rdg89eHKXAY9tkOr+lbAhsZGdM+m3Q+eaTwInCNZ0gjKuYj+8gFOQ92r5jhVh8BPcoNP6l/f7rqv3YOL4PsJekmQAZNOSUgZsvk+KbM0edsTWkn6vwdw7apbZZQAkGDGqF6jUisB8tlMIeaGb8I/Pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984675; c=relaxed/simple;
	bh=S0WjT23t39cqtDtBwfFUH/GDjBJ0ZvLzofp7zokPEm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtFkyzQh+othx0tnC+opdI92NtZ7gVtLPaEMsqRgHlcMwXUn2K01sJAV1oITDRmeaHSKXGGsD6XHTbQnL4IJ8LTBTmq4YqjYzoTfUWa0hOTUO9xOoDAFuBP15o1BVXJQUcMsHD8EAABfG762KOWYjmxXCrCYpiAtJ1tlNfcc4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEU5Qhpz; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso545355ab.1
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 12:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734984673; x=1735589473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjVrJfsFR03wQkDMAB9Z1JA2DNqy6FmQteOStQ3S3QU=;
        b=bEU5QhpzYhynPFad6fGWWT9e4WYSrI3KD5pQ3dFVm7L55qD95/ls5AL9zMsmxAu0RP
         5q6vHLaq2KVv5Mdlk3F0mEPBEXOOvxXqwIcNMpDF6UHfmPKW3NJnWr3Elgim3ssrLmWb
         0JhFqFTaGPP3n9XY1dFV2OK6HY1EwhPDYRG65ZQANe09gSIAosDGedems4pUcuP6sIlI
         JHP5UItzkc8iI262GfjtlGCA4y8D8YkMPlz38w2Q7mv7ISztL95sJKFCwssyMMWsn7eo
         YLkcpy6feJnW+s98OSldS1AmsPG1CcjrIwOtmlJN9en2shz+wHXCaMYHYXqjqZOospPZ
         AYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734984673; x=1735589473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjVrJfsFR03wQkDMAB9Z1JA2DNqy6FmQteOStQ3S3QU=;
        b=WVw5lSP6OzJpSw3cNQKVbUS17tNZ0B8FnAgcapBrQM4L17eg9LFIwGIBogcfsw4Rbp
         czXsuVywQhRfZsXNvzXjBZuufTPyZQFoxHLvLt3aZ+lsZh7Vbn3k4DoCGhpJUFNLLK0W
         ESV4aWpdJ1SxmYCjGuJzJv5PQqS4g4IWyfBqUwi1rnx4wBoHrb+0CqZ5Lx6v2liQ+3W4
         TipwZIiUPj6qvWYo+HPkA1p2rJmB67/vg9iQSYaovny/a20U23ZcqbqpRB4iSV2p1zN5
         8fufHVdWO51h5/LAJOeZo+pJ4fPd9TkyQFutgY8MI1HpffXne6X1nSlmvLm6H5PVvcQV
         IkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPz8xwDOJSkY4rDR+Zd5VctRRzBEyxK4wAhIotAQqL19oc+5h2sZUr1VeIUWHJY0WSkM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNWOVB5WC5q5QS3XUGqalu1+M3B3fmpbjjJ97i99BKt8IqwJa
	uSXFiIPVlrRE5DLWVMNNmgFlCTdf4k3aivMn9MHkjVStxTvey7DhAbV3dJ++7XVTC/eqHzISorl
	L5mgoeTwIpGaKUDJSbfhZZUqL7/X5kpHnsNSQ
X-Gm-Gg: ASbGncu1kD2q4f5rx00tRTzJl1wEcsr9OLOFJqCnt/EZSWM7DFxaqr3Se+6fOaiiqhP
	ZlkxHZ2+ptlLLxldRnPD/4z9h08j+kUjYxq+0nps=
X-Google-Smtp-Source: AGHT+IHI75htOB8hFPqxV/ozomZdjZErCT3ouawc44tbKhecFv3EEBCWKvXdokcqL0l99CVPm+CXPGT6Rz/bBctgyrE=
X-Received: by 2002:a05:6e02:1a0c:b0:3a7:ddbb:1b19 with SMTP id
 e9e14a558f8ab-3c331d3c38emr10279825ab.27.1734984672865; Mon, 23 Dec 2024
 12:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221192654.94344-1-irogers@google.com> <823e66dc-9ff4-4168-be54-2e800aef0b28@linaro.org>
In-Reply-To: <823e66dc-9ff4-4168-be54-2e800aef0b28@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Dec 2024 12:11:00 -0800
Message-ID: <CAP-5=fV+zVM3L9rWxisazP-+askNQvrXSk2_2jVOi9xOP+f7Tw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 7:09=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 21/12/2024 7:26 pm, Ian Rogers wrote:
> > At the RISC-V summit the topic of avoiding event data being in the
> > RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> > events being the priority when no PMU is provided so that legacy
> > events maybe supported via json. Originally Mark Rutland also
> > expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> > M? processors, but James Clark more recently tested this and believes
> > the driver issues there may not have existed or have been resolved. In
> > any case, it is inconsistent that with a PMU event names avoid legacy
> > encodings, but when wildcarding PMUs (ie without a PMU with the event
> > name) the legacy encodings have priority.
> >
> > The patch doing this work was reverted in a v6.10 release candidate
> > as, even though the patch was posted for weeks and had been on
> > linux-next for weeks without issue, Linus was in the habit of using
> > explicit legacy events with unsupported precision options on his
> > Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> > where ARM decided to call the events bus_cycles and cycles, the latter
> > being also a legacy event name. ARM haven't renamed the cycles event
> > to a more consistent cpu_cycles and avoided the problem. With these
> > changes the problematic event will now be skipped, a large warning
> > produced, and perf record will continue for the other PMU events. This
> > solution was proposed by Arnaldo.
> >
> > Two minor changes have been added to help with the error message and
> > to work around issues occurring with "perf stat metrics (shadow stat)
> > test".
> >
> > The patches have only been tested on my x86 non-hybrid laptop.
> >
> > v3: Make no events opening for perf record a failure as suggested by
> >      James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
> >      rebase.
>
> Looks like this could be interacting with the dummy event for itrace
> events which I must have missed before. Now it "fails" but the exit code
> is 0 which some of the tests rely on. I noticed "Miscellaneous Intel PT
> testing" is failing because its skip mechanism is broken:
>
> $ sudo perf record -e intel_pt/aux-action=3Dstart-paused/u
> Error:
> Failure to open event 'intel_pt/aux-action=3Dstart-paused/u' on PMU
> 'intel_pt' which will be removed.
>
> $ echo $?
> 0
>
> So the test thinks it has the aux-action feature but it doesn't.

Thanks James, there is also discussion of this here:
https://lore.kernel.org/lkml/CAP-5=3DfX8hWF-PaAE2VKHW3fk1W19xd0hyBVsP3653J9=
xw-U7VQ@mail.gmail.com/
I think in v3 I need to switch from detecting adding dummy events, to
detecting parsing of dummy events. Then if there is nothing but dummy
events and none were parsed we exit.

Thanks,
Ian

> > v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
> >      Patra who have tested on RISC-V and ARM CPUs, including the
> >      problem case from before.
> >
> > Ian Rogers (4):
> >    perf evsel: Add pmu_name helper
> >    perf stat: Fix find_stat for mixed legacy/non-legacy events
> >    perf record: Skip don't fail for events that don't open
> >    perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
> >      legacy"
> >
> >   tools/perf/builtin-record.c    | 34 ++++++++++++---
> >   tools/perf/util/evsel.c        | 10 +++++
> >   tools/perf/util/evsel.h        |  1 +
> >   tools/perf/util/parse-events.c | 26 +++++++++---
> >   tools/perf/util/parse-events.l | 76 +++++++++++++++++----------------=
-
> >   tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
> >   tools/perf/util/pmus.c         | 20 +++++++--
> >   tools/perf/util/stat-shadow.c  |  3 +-
> >   8 files changed, 156 insertions(+), 74 deletions(-)
> >
>

