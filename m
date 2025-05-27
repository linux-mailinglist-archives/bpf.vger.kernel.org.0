Return-Path: <bpf+bounces-59016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E18BFAC5B71
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 22:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801091BC1532
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 20:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E12F5E;
	Tue, 27 May 2025 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOxnQWeC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F21AA782
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378376; cv=none; b=gq66pv+i87czTyWji6NQ73+CEpvAcuAZpjCxfNsvC3+sgo6kPvtlLnOwu/D8Xp/ULsCPWezTxoeM33JIrOTWdEkc3iUJ8ggMBX1ZwU7CgIzv/OMEcYomkr7TH9zULM/mTYoc7wiEcayQqslDyi0jmf59bwzCj3qS44XZj5sUa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378376; c=relaxed/simple;
	bh=9K1qlOPi3Awpjhz2tRNBvB20u2JUlbfEpuK12EzVwtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FoJdzBrM3TaZgnRnF4As0J3xddSBvradvzjl7nq9Og4iTfOM9D8WwlXr7gzi2ati4MByOO7xutjGrEaM6/AQq1KqK6fqBQUv4Zbo5xE7fjW9Nd/+oo6IzeKrrtfI6Ycz0qgahRnl58PJEVJJ/OrITWxBHPAhVZITfApvGrRm6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOxnQWeC; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3dd745f8839so40365ab.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748378374; x=1748983174; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxGFDwqRyg2W5WWt9JDFqQi7bJLxV0e0m6+5lkNnCUY=;
        b=tOxnQWeCCmb/9bEsZUP05MnZMLeNYM9Ok2N+QAhTxHPVviQN50ATJ5Lt5WaUEpty9H
         Gv/ZI5ZNjGLf/N4LPswky3ykKoRzrONV7p0TjjUtaUwu/9q6ZVKsoI5MVpLVSjIHeCDO
         6yNRW1SaTmPiGPM5KbQKl1YhV42CAsbDcsUHZykc6YNsubZFJWjXS6F0AcpZeNFWm3aC
         XA6ZZ/63S56zvb17aeTQar2+53Azl5ChBoW0lcHcT2zbG8Tewcm/1ksoUg6qUmMzrr6c
         N02lGG5J4rincUKY3VsMldjuAwoAKeX4y9L0nbltGwQDGmNyCcExYs/4yAp/wIKFEpZC
         +8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748378374; x=1748983174;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxGFDwqRyg2W5WWt9JDFqQi7bJLxV0e0m6+5lkNnCUY=;
        b=ZtqnMIFrUSyo6yVsegwZtbEHwjkLb+L82zp46ObwRnQvqiHr0o3Hb8XLF5dORQJRJt
         X+6dzzXZ1XyN1XS5IH2SVg6+mI9p5NeIPVWBeJ5azeriBQBEO8rlBM+T6H/Fs+FO4QxK
         ZjWVqOzWjTtHtjnFJWCv3OeKPtDqpEQ1twusNDjRvi391pmzb8MpFMyoJ1MjRJbf2vC9
         tuf8LX5/QXA+iY4zvjvdPIbgNBQd3Nx3gywpdXsx9K9eWHbPBWkCpRogafvQK0xNujFD
         DK4K+UVv69N+XstGiT8hM9zFbBBtUrqgEPqLB3fSNa9dIAnoqWnuv8Jbh8UZv/hOEEik
         sEfg==
X-Forwarded-Encrypted: i=1; AJvYcCX/PMYTeSGah1wE9afsis0wezdddolFY3r7ofG6wxVNbeqRnipkepSa+6pJvN5w+86tnc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7EViKjqOOughjwfYZ0AN1A8NDf7AivUJAQt3igFl3c6yucih
	b4EbhhG5aS4kSPf6msFFYxN8RwU4rVH+i41QKR9bcIbXyT+kP0+YRxzneMUR384Zr1ZtqyroPtt
	Bd5dcGy1FW2Fr2a6l/COv+8uVGBOvvS/3KNNi+cqj
X-Gm-Gg: ASbGncurjTg9bsJ+Fha1YLH/3R51/xsj2G1PvELxV+BXXWTw+dnudPMEq8XUgb79le4
	LeNpc7q9qWy1wGxzh4h6rUYmCRDTtGekH3rU28bwjRad1zkvR/jefOKXDrAJX51QiVkqBx68zDc
	bhRCk3YP15+seN8NxXrSX9EvZbusPJckZVffEUSX4tHYY+P1Ea+orRXnJlQ1WX8hxLtoR+Rxul
X-Google-Smtp-Source: AGHT+IG2icH2Y/FDLmWBOJMI54v0jKh22yxG1sb2LsUiO/EZg2xwKxpSIbO/FXeBFPngtSOnKjNsvL6ErGsQKy9C7Zo=
X-Received: by 2002:a05:6e02:1a8d:b0:3da:7c33:5099 with SMTP id
 e9e14a558f8ab-3dd89c5208dmr132745ab.13.1748378373491; Tue, 27 May 2025
 13:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 13:39:21 -0700
X-Gm-Features: AX0GCFu0vMV0uYp2KCfFVMxr8EIjrtS4vYgJCyG4a9k0iDeW-4w_Y8OZKcn1IOE
Message-ID: <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Move uid filtering to BPF filters
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 2:40=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Rather than scanning /proc and skipping PIDs based on their UIDs, use
> BPF filters for uid filtering. The /proc scanning in thread_map is
> racy as the PID may exit before the perf_event_open causing perf to
> abort. BPF UID filters are more robust as they avoid the race. The
> /proc scanning also misses processes starting after the perf
> command. Add a helper for commands that support UID filtering and wire
> up. Remove the non-BPF UID filtering support given it doesn't work.
>
> v3: Add lengthier commit messages as requested by Arnaldo. Rebase on
>     tmp.perf-tools-next.
>
> v2: Add a perf record uid test (Namhyung) and force setting
>     system-wide for perf trace and perf record (Namhyung). Ensure the
>     uid filter isn't set on tracepoint evsels.
>
> v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.=
com/

Ping. Thanks,
Ian

> Ian Rogers (10):
>   perf parse-events filter: Use evsel__find_pmu
>   perf target: Separate parse_uid into its own function
>   perf parse-events: Add parse_uid_filter helper
>   perf record: Switch user option to use BPF filter
>   perf tests record: Add basic uid filtering test
>   perf top: Switch user option to use BPF filter
>   perf trace: Switch user option to use BPF filter
>   perf bench evlist-open-close: Switch user option to use BPF filter
>   perf target: Remove uid from target
>   perf thread_map: Remove uid options
>
>  tools/perf/bench/evlist-open-close.c        | 36 ++++++++------
>  tools/perf/builtin-ftrace.c                 |  1 -
>  tools/perf/builtin-kvm.c                    |  2 -
>  tools/perf/builtin-record.c                 | 27 ++++++-----
>  tools/perf/builtin-stat.c                   |  4 +-
>  tools/perf/builtin-top.c                    | 22 +++++----
>  tools/perf/builtin-trace.c                  | 27 +++++++----
>  tools/perf/tests/backward-ring-buffer.c     |  1 -
>  tools/perf/tests/event-times.c              |  8 ++-
>  tools/perf/tests/keep-tracking.c            |  2 +-
>  tools/perf/tests/mmap-basic.c               |  2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c |  1 -
>  tools/perf/tests/openat-syscall.c           |  2 +-
>  tools/perf/tests/perf-record.c              |  1 -
>  tools/perf/tests/perf-time-to-tsc.c         |  2 +-
>  tools/perf/tests/shell/record.sh            | 26 ++++++++++
>  tools/perf/tests/switch-tracking.c          |  2 +-
>  tools/perf/tests/task-exit.c                |  1 -
>  tools/perf/tests/thread-map.c               |  2 +-
>  tools/perf/util/bpf-filter.c                |  2 +-
>  tools/perf/util/evlist.c                    |  3 +-
>  tools/perf/util/parse-events.c              | 33 ++++++++-----
>  tools/perf/util/parse-events.h              |  1 +
>  tools/perf/util/python.c                    | 10 ++--
>  tools/perf/util/target.c                    | 54 +++------------------
>  tools/perf/util/target.h                    | 15 ++----
>  tools/perf/util/thread_map.c                | 32 ++----------
>  tools/perf/util/thread_map.h                |  6 +--
>  tools/perf/util/top.c                       |  4 +-
>  tools/perf/util/top.h                       |  1 +
>  31 files changed, 150 insertions(+), 182 deletions(-)
>
> --
> 2.49.0.850.g28803427d3-goog
>

