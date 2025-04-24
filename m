Return-Path: <bpf+bounces-56640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E23A9B913
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 22:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC9A4A594F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA7F2185A6;
	Thu, 24 Apr 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhsY8quE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC721CC7C
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526315; cv=none; b=HLc59/YfkNvxaQHa+LQ5UDmBw40zYvvS1Y7qin7f/oFeCbn1tOXA548xjAQsf0NQHTIY3sVN/COk7vx55A5opYceoaPx5PbeGUlOE2EuYa8QWMJ8xM/2fumlRcTxpB+fCe4/4+MrWvpPrAHzjsiS6xpEGKyJ17AVO+LyM3TcZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526315; c=relaxed/simple;
	bh=fafVTpiamEHy/uMqhecPP6xoPwLgHu181eBWDrBjYPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=L8JW+3PJwzhtpvBdQoKwUQu17N1q1Tytb8riQU2QV8tDpxiHDFCJQvMXB1d1udK7CLDdMekILCfZvSAUPRDLK818VFPB1G8LiY9rpcPCnCVWm3P4FNBO+suCYR//M0KqxjweEncnGFL6Ljt9nQpIeTjUImFwLBvopBbLRBILBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhsY8quE; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d8c4222fc9so33145ab.0
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745526312; x=1746131112; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CCui5nQ+UD3eYDY+CSYEAL46oUEZP2/pCYzQHZplJA=;
        b=rhsY8quE+x6XCcUMEvyYo2kBnHIjwJ4zDJguPSukBp0zoSdxZHNVt7r1jXCQpKlXKg
         vzbN6BcBC5JEex9hHBj2jiWOrfJcpv1ll1ly6nZJecAztvMThUFNpDxzXvQeOEWLQLrR
         FKKr/ynrfg8rMaHxXYgI97QRjlWpVQ8HwSxpkSSwuIeN3g+jGzJht3YNhCBA0ggWwYWC
         rxbjGEs4o1tYWvN888ZDjknagwODLBx0ReimvwAl6YaqfoCQcslPc+otNbhB+BHn9B5P
         adc2X6DhK9O9lmM9GXWhw4YoejUVwefUYlBeCiIxP2D14ASjZrvQCm5eCEG3nbyVrTgo
         u1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526312; x=1746131112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CCui5nQ+UD3eYDY+CSYEAL46oUEZP2/pCYzQHZplJA=;
        b=vSQrqDtJP38oAqutIhAYfXGWn4KL88EU3v8KGD253mlTULdkZB7PfTKGLhCu6BSegI
         2CAKMExD4xfLPR633HTGAkMT777+xiKwAdRQBjyX+wDqtlUNunI246r2nhLb87sr1BVx
         CqA+c1V4HqmHKjepgwCxQW7V1NR3ItUR4GvxoOVmVdUFZXMYHodQBamE2Ojy2FhpKwTi
         eZbMBYUAUpKDq90q4n06XmAcLcnnZVdDegRAtMIrQ2QONiM4VllGb7im5d1y+2+TQiMK
         t/uY5rEJyEqD5Hq6ZciAagBdteeJxiV71TGxG46Gt5DHryguPWuSGlxo4Gkx2AdSefYz
         iTLw==
X-Forwarded-Encrypted: i=1; AJvYcCUFxvbSb1HB49f1bgyMi0FO72JF0macB14xKNdO+TiX7HF5A6ROQ1dFiG5nTVgO0kdworQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZtOC8bXXqBJJ448YyvMrfZzHZ3T1+LyeiDYW1SO/xpPJ4F2+
	SOcP9wdKBvvfIWXH/h7/YiL6monLOPst3UKMS9fAHaMHQ6IMMPbSWd5GsOD7TLTDCRfz5wfWVVq
	KorMaLQtBYGRllTyt6OaJCG/LuSTDFDp2lUF+
X-Gm-Gg: ASbGncsaZqiOUEvaTFFSstKH9UPPtMVNnsGxVSk0lJIVC1qs6fVOZW5K4vwGiVgP2O7
	McawQx4zx2NTe+J4CKqZ/kGzNojBg+3Fi3Pqq1yKaI1r+dhKeIVIIfdT4ym8qHpzyFHclWnTrOs
	0u4e2NSJUkQRByHKMJCbGUIjmzEaEEyCrunE59b07p5roh5FQItbM=
X-Google-Smtp-Source: AGHT+IE/sZKvnBNnWmKMWKbj4vT6Y3NTAhyE5RSAQ8RfFq17ESLSBVd85E820ZoDdX0XVKsiJSHpcAtlqZT6XpX1ED8=
X-Received: by 2002:a05:6e02:19cf:b0:3d9:2a76:94be with SMTP id
 e9e14a558f8ab-3d939823ce2mr714415ab.14.1745526312287; Thu, 24 Apr 2025
 13:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Apr 2025 13:25:00 -0700
X-Gm-Features: ATxdqUH0pzpE_olqwsX6H8de4juHukePstPSl5KesBuzVOEbeWOE41P_uOGuzjE
Message-ID: <CAP-5=fUM7TgwehAPb3e1_v_-R4h4eeetrSpYAGLP=aEXzchNAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Move uid filtering to BPF filters
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

On Thu, Apr 10, 2025 at 10:36=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Rather than scanning /proc and skipping PIDs based on their UIDs, use
> BPF filters for uid filtering. The /proc scanning in thread_map is
> racy as the PID may exit before the perf_event_open causing perf to
> abort. BPF UID filters are more robust as they avoid the race. Add a
> helper for commands that support UID filtering and wire up. Remove the
> non-BPF UID filtering support given it doesn't work.
>
> v2: Add a perf record uid test (Namhyung) and force setting
>     system-wide for perf trace and perf record (Namhyung). Ensure the
>     uid filter isn't set on tracepoint evsels.
>
> v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.=
com/

Ping.

Thanks,
Ian

> Ian Rogers (12):
>   perf tests record: Cleanup improvements
>   perf bench evlist-open-close: Reduce scope of 2 variables
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
>  tools/perf/bench/evlist-open-close.c        | 76 ++++++++++++---------
>  tools/perf/builtin-ftrace.c                 |  1 -
>  tools/perf/builtin-kvm.c                    |  2 -
>  tools/perf/builtin-record.c                 | 27 +++++---
>  tools/perf/builtin-stat.c                   |  4 +-
>  tools/perf/builtin-top.c                    | 22 +++---
>  tools/perf/builtin-trace.c                  | 27 +++++---
>  tools/perf/tests/backward-ring-buffer.c     |  1 -
>  tools/perf/tests/event-times.c              |  8 +--
>  tools/perf/tests/keep-tracking.c            |  2 +-
>  tools/perf/tests/mmap-basic.c               |  2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c |  1 -
>  tools/perf/tests/openat-syscall.c           |  2 +-
>  tools/perf/tests/perf-record.c              |  1 -
>  tools/perf/tests/perf-time-to-tsc.c         |  2 +-
>  tools/perf/tests/shell/record.sh            | 36 ++++++++--
>  tools/perf/tests/switch-tracking.c          |  2 +-
>  tools/perf/tests/task-exit.c                |  1 -
>  tools/perf/tests/thread-map.c               |  2 +-
>  tools/perf/util/bpf-filter.c                |  2 +-
>  tools/perf/util/evlist.c                    |  3 +-
>  tools/perf/util/parse-events.c              | 33 ++++++---
>  tools/perf/util/parse-events.h              |  1 +
>  tools/perf/util/python.c                    | 10 +--
>  tools/perf/util/target.c                    | 54 ++-------------
>  tools/perf/util/target.h                    | 15 +---
>  tools/perf/util/thread_map.c                | 32 +--------
>  tools/perf/util/thread_map.h                |  6 +-
>  tools/perf/util/top.c                       |  4 +-
>  tools/perf/util/top.h                       |  1 +
>  31 files changed, 178 insertions(+), 204 deletions(-)
>
> --
> 2.49.0.604.gff1f9ca942-goog
>

