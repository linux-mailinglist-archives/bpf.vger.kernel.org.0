Return-Path: <bpf+bounces-59487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF1BACC028
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 08:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05D916F119
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFD4A35;
	Tue,  3 Jun 2025 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Of4boE/n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5591482E7
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931988; cv=none; b=FAl7C1NlyWJAQEQw8zhqKMajNHuuMqkEX39ifiQqe0CmnTx8eCb6sYdkAPMMeEmVW85OQPm4DRFfgLgrClrVEF3r4o9EAykoy3LqcbwCLJiP+HMnmXnn61WYyL4/em5tuc9Ef64wxEnuhIr36wPn01Rmf4aUtTvSCbiLZCTKkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931988; c=relaxed/simple;
	bh=SwzzN68OzT7nUEHqb0hfK995uCWmM97KnuCfULC3Xf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7oZGFYaAHSTo4pvK0HOSoNpP3uEtfv6TA+Vx8sRhhcqYpwt5RiZknOzqa+5x3dXESr2/V5IabbpNVHbfzTkaXEwjVgb07mBx6EcfXIbSbdy9OnBnp5cS7w2fjmc/6yQg9tQELVayWwmNIt5NrGIrPakaVqQ4RoKmNWg2rpf6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Of4boE/n; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dd745f8839so114955ab.0
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748931986; x=1749536786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lrz1F6k8LZ4oKJgAJMIc8RLcQPs64aVnJe+NCmKgM=;
        b=Of4boE/naqZ3TnN9TajQBZ+nFCeRgHFDqBM8j+LNBaDN/ZxwaxRtVmkJv71NcjG51z
         x21ZZtnNQpl45K7NRnyvG014mrGRZtTfIibgkBz0Yjej+XyBsznJkWn95bFsDMh65K1c
         uaIDQ4x43ZvoHDtw629odFJBhQT1pb+mGA6040dMRWa7POziUjcF6cQ2ZE87p852buk0
         69MbdMNMwZcjdJAL1HIjfgwvzdTpt7JDzzVGnUyAkf5GEs6f+t0Qxu6F4o2wkE+IMtiZ
         SquVXnpuDMp+8PVtXcAlsD7x3ofzEqgkIobO6FaUYTaws1MR3e/GxGJ1UM24hasMwwHs
         mpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748931986; x=1749536786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lrz1F6k8LZ4oKJgAJMIc8RLcQPs64aVnJe+NCmKgM=;
        b=Gre2PxojikpxKdQSR+sAA9/aporb/hAD3s8oX/nbsAC9reRsBIOrMaieNXIH5ZBWv9
         JxhJg3eSjgEljvltRdGpL4h8Fbf65/iTbBZLZxH3hF+CeebbivjJ9QH5V+9zcmyiR0n/
         5G6kUYw4YXV109wDFHsvx3/yYERhAhT+YT+kxAIUsdYwhBms/pEF+BjBrztvNa0I+3WY
         ArGtQpctwB4p0lyiKunfR3hB1yebFgetYao8Wn06EvI1QZ5E6G2NWPIQTeCdONYVQGyg
         LsmNa9pXBqf2/kR5EycQMp85dxO7oiqghbTy5H+LjTG2EJxsYUh1R8vK/eQ1i8X2cvxA
         pGCw==
X-Forwarded-Encrypted: i=1; AJvYcCWhANcOh/8KUEkhT95mFphW17bkfHomIBzPvcbZEJeuZjl2dnusNJcutVCRz1dTU/wjapg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFgsO/u9ZbUQH/FW/zPV+0mioA+qzO/RFSGppmtuzpeFJy82Io
	lOLU7ZQsONiJvIKqGWKIqrM2VWouzGgCD6VgotmccXv8b70+xlBn/ulYSp+I0B946UyOH7ro4UN
	IQkbJ3hMxiXHcVVuILebq9CsjgvtWL3bL8IlxS7PX
X-Gm-Gg: ASbGncszAIH7Xv3ago+xyxwPzYP+6WRhwMbZzeyyBo+69IJa4F+CLjLtCbLKHFxp4oE
	aivgAB7lxVrBepAjBdFTbGUMGJ6nxCw+hdROh0dKnXYPRGXzPdonwY1Hl7Ogw0YNlAaBUHCZJAu
	od0uLYXCJVqrvAPoFEQjK+hWbgNTL5/n86WCS+cttsMh27gtILRnNcCok=
X-Google-Smtp-Source: AGHT+IFN3z4zf2CcZVIN0BqhrTiUFcdc3mVIGzbKuu8egvEgUfrHrtKW9hjnKZoci2OTTB/gVoIE9e44XPnIXMG/IDo=
X-Received: by 2002:a05:6e02:190f:b0:3d8:18f8:fb02 with SMTP id
 e9e14a558f8ab-3ddb78550d9mr1742315ab.17.1748931985333; Mon, 02 Jun 2025
 23:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com> <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>
 <aD586_XkeOH2_Fes@google.com>
In-Reply-To: <aD586_XkeOH2_Fes@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Jun 2025 23:26:12 -0700
X-Gm-Features: AX0GCFuCFIE-Y12sxz3tltslTrHjpttISnGjh1HG7hvbuImPXqNykVJNWvCJvMM
Message-ID: <CAP-5=fUXJ6fW4738Fnx9AK2mPeA74ZpYKv=Ui6wYLWXE3KRRTQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 9:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Tue, May 27, 2025 at 01:39:21PM -0700, Ian Rogers wrote:
> > On Fri, Apr 25, 2025 at 2:40=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Rather than scanning /proc and skipping PIDs based on their UIDs, use
> > > BPF filters for uid filtering. The /proc scanning in thread_map is
> > > racy as the PID may exit before the perf_event_open causing perf to
> > > abort. BPF UID filters are more robust as they avoid the race. The
> > > /proc scanning also misses processes starting after the perf
> > > command. Add a helper for commands that support UID filtering and wir=
e
> > > up. Remove the non-BPF UID filtering support given it doesn't work.
> > >
> > > v3: Add lengthier commit messages as requested by Arnaldo. Rebase on
> > >     tmp.perf-tools-next.
> > >
> > > v2: Add a perf record uid test (Namhyung) and force setting
> > >     system-wide for perf trace and perf record (Namhyung). Ensure the
> > >     uid filter isn't set on tracepoint evsels.
> > >
> > > v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@goo=
gle.com/
> >
> > Ping. Thanks,
>
> I'm ok with preferring BPF over /proc scanning, but still hesitate to
> remove it since some people don't use BPF.  Can you please drop that
> part and make parse_uid_filter() conditional on BPF?

Hi Namhyung,

The approach of scanning /proc fails as:
1) processes that start after perf starts will be missed,
2) processes that terminate between being scanned in /proc and
perf_event_open will cause perf to fail (essentially the -u option is
just sugar to scan /proc and then provide the processes as if they
were a -p option - such an approach doesn't need building into the
tool).

This patch series adds a test [1] and perf test has lots of processes
starting and exiting, matching condition (2) above*. If this series
were changed to an approach that uses BPF and falls back on /proc
scanning then the -u option would be broken for both reasons above but
also prove a constant source of test flakes.

Rather than give the users something both frustrating to use (keeps
quitting due to failed opens) and broken (missing processes) I think
it is better to quit perf at that point informing the user they need
more permissions to load the BPF program. This also makes the -u
option testable.

So the request for a change I don't think is sensible as it provides a
worse user and testing experience. There is also the cognitive load of
having the /proc scanning code in the code base, whereas the BPF
filter is largely isolated.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20250425214008.176100-6-irogers@google.com=
/
* rescord.sh is marked as exclusive currently, but this shouldn't
really be necessary.



> Thanks,
> Namhyung
>
>
> > > Ian Rogers (10):
> > >   perf parse-events filter: Use evsel__find_pmu
> > >   perf target: Separate parse_uid into its own function
> > >   perf parse-events: Add parse_uid_filter helper
> > >   perf record: Switch user option to use BPF filter
> > >   perf tests record: Add basic uid filtering test
> > >   perf top: Switch user option to use BPF filter
> > >   perf trace: Switch user option to use BPF filter
> > >   perf bench evlist-open-close: Switch user option to use BPF filter
> > >   perf target: Remove uid from target
> > >   perf thread_map: Remove uid options
> > >
> > >  tools/perf/bench/evlist-open-close.c        | 36 ++++++++------
> > >  tools/perf/builtin-ftrace.c                 |  1 -
> > >  tools/perf/builtin-kvm.c                    |  2 -
> > >  tools/perf/builtin-record.c                 | 27 ++++++-----
> > >  tools/perf/builtin-stat.c                   |  4 +-
> > >  tools/perf/builtin-top.c                    | 22 +++++----
> > >  tools/perf/builtin-trace.c                  | 27 +++++++----
> > >  tools/perf/tests/backward-ring-buffer.c     |  1 -
> > >  tools/perf/tests/event-times.c              |  8 ++-
> > >  tools/perf/tests/keep-tracking.c            |  2 +-
> > >  tools/perf/tests/mmap-basic.c               |  2 +-
> > >  tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
> > >  tools/perf/tests/openat-syscall-tp-fields.c |  1 -
> > >  tools/perf/tests/openat-syscall.c           |  2 +-
> > >  tools/perf/tests/perf-record.c              |  1 -
> > >  tools/perf/tests/perf-time-to-tsc.c         |  2 +-
> > >  tools/perf/tests/shell/record.sh            | 26 ++++++++++
> > >  tools/perf/tests/switch-tracking.c          |  2 +-
> > >  tools/perf/tests/task-exit.c                |  1 -
> > >  tools/perf/tests/thread-map.c               |  2 +-
> > >  tools/perf/util/bpf-filter.c                |  2 +-
> > >  tools/perf/util/evlist.c                    |  3 +-
> > >  tools/perf/util/parse-events.c              | 33 ++++++++-----
> > >  tools/perf/util/parse-events.h              |  1 +
> > >  tools/perf/util/python.c                    | 10 ++--
> > >  tools/perf/util/target.c                    | 54 +++----------------=
--
> > >  tools/perf/util/target.h                    | 15 ++----
> > >  tools/perf/util/thread_map.c                | 32 ++----------
> > >  tools/perf/util/thread_map.h                |  6 +--
> > >  tools/perf/util/top.c                       |  4 +-
> > >  tools/perf/util/top.h                       |  1 +
> > >  31 files changed, 150 insertions(+), 182 deletions(-)
> > >
> > > --
> > > 2.49.0.850.g28803427d3-goog
> > >

