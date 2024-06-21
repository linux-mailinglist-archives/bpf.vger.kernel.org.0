Return-Path: <bpf+bounces-32779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E5C91305B
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 00:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58241F21918
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3A16EB6F;
	Fri, 21 Jun 2024 22:34:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8564208C4;
	Fri, 21 Jun 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009298; cv=none; b=GLg8XNmrdmPx+Yvrhs/MCYqkY0NFfnGuM6Z4aerAVbHtyHffwbs8OUSSlp/gGOtgDkplTu8dv1KX1JyzZ2Rl4TQx/v/tL1onFMmAp2dX/tG4zo7+CTaMquR1MBs6tjiOxsqsNohpRNfeot0THUGce2lAjztLpmtTUGdikcqVHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009298; c=relaxed/simple;
	bh=zgYm8XSEvUPvMbKn2+8mwq09JBRYLIZQITMP22XLbsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSoLWMAeePMviIWbpISqisfZqGTWSuarhbnvtCaQExPi4AnI+QFM1e+CqYxcJHUhi03xEOE94it/KANydNaT5ejzMoe0RCwNnlATwXofsoXfaTnbntMuWxZZ7fjevS9E/sp5VPtw9I/NGopQyulylE89W9+/Id6ZgHsdcPgiifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso1771500a12.3;
        Fri, 21 Jun 2024 15:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719009295; x=1719614095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IWpuNhQGuFo/RdmFczsMH8ijmOsAG0nFTrt9FOYt8U=;
        b=A6VM9rOOINy2IsqwXILamGpkMkRAcF7MjtBdSqpcKEOlUB8wivu6HmKMX7BAC67S1r
         kKjrOQR/H6YoGzN3v6QQA9x0TMV8ftpVOJcSNtqn+kxNMgze6+I73A1jnW1s0SxzrSJG
         ni/QOTQfli4ipI89efphI/KM0irpJ5cG13yCsIti8RAzA5KKNJaHBgH5RZu6UXX8Hi1Q
         Nv1g/wywTw11Q8GxfOI5Na+JypLupz5TTFR1Nc3ppnz3GDBF06XcVhdZRF3uFLX6VeVx
         JuIjG8eLA8yXufm5i21IU0Cv38+ehVEcRreNrPBS61M1QQKw7uFEM8oqeZvcbsT0fype
         o7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU1ISNxSLKJAi1PAI+vo+FYtO2SyEqfKUl8FRHCocH2nJ8AzfLqLdQL47dm4IK8Pxfgc7iXD8ZCrj+YToC+bjQZVci1BNIsUU5fU4VWZva2FugHT2/iQhoD9YD5wXTxyzV1p5p4tpePopNnDYEiZ/1QQBARLYk7KZg88UPAVmKQ2UNlg==
X-Gm-Message-State: AOJu0YxcuWixbF/FxmSXZ8VafpOD7EHhQHxaNy0/m4ctZ9+KMFkWYjYm
	I/3aucVsj9wtUiXrrGZ/NegfLyMWPpchN9pgSzRvpGKx1AIH3PYY7C0gelaE0rooK5fCqJkHGuk
	h2n+i3/bDIjWq/E2AW/CW0r2/zpg=
X-Google-Smtp-Source: AGHT+IEcARhlBbiGRZfC5xEromMPnH9+AkUCgppzFFSQjAmir49ujqJtA4OXYgdnK2WomsVNURlS2ZwpD7Bilkf0QVU=
X-Received: by 2002:a17:90a:fc83:b0:2a4:b831:5017 with SMTP id
 98e67ed59e1d1-2c7b5dae403mr9504425a91.48.1719009294813; Fri, 21 Jun 2024
 15:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621222357.717374-1-namhyung@kernel.org>
In-Reply-To: <20240621222357.717374-1-namhyung@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 21 Jun 2024 15:34:43 -0700
Message-ID: <CAM9d7chz7+aqmzWwRG9MRmXh_SY-YBRNPQsLDnPAfht_ECViOg@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/8] perf record: Use a pinned BPF program for
 filter (v2)
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, 
	Stephane Eranian <eranian@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ugh, forgot to CC bpf list/folks.. ;-p



On Fri, Jun 21, 2024 at 3:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This is to support the unprivileged BPF filter for profiling per-task eve=
nts.
> Until now only root (or any user with CAP_BPF) can use the filter and we
> cannot add a new unprivileged BPF program types.  After talking with the =
BPF
> folks at LSF/MM/BPF 2024, I was told that this is the way to go.  Finally=
 I
> managed to make it working with pinned BPF objects. :)
>
> v2 changes)
>  * rebased onto Ian's UID/GID (non-sample data based) filter term change
>  * support separate lost counts for each use case
>  * update the test case to allow normal users (if supported)
>
>
> This only supports the per-task mode for normal users and root still uses
> its own instance of the same BPF program - not shared with other users.
> But it requires the one-time setup (by root) before using it by normal us=
ers
> like below.
>
>   $ sudo perf record --setup-filter pin
>
> This will load the BPF program and maps and pin them in the BPF-fs.  Then
> normal users can use the filter.
>
>   $ perf record -o- -e cycles:u --filter 'period < 10000' perf test -w no=
ploop | perf script -i-
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.011 MB - ]
>         perf  759982 448227.214189:          1 cycles:u:      7f153719f4d=
0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>         perf  759982 448227.214195:          1 cycles:u:      7f153719f4d=
0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>         perf  759982 448227.214196:          7 cycles:u:      7f153719f4d=
0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>         perf  759982 448227.214196:        223 cycles:u:      7f153719f4d=
0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
>         perf  759982 448227.214198:       9475 cycles:u:  ffffffff8ee012a=
0 [unknown] ([unknown])
>         perf  759982 448227.548608:          1 cycles:u:      559a9f03c81=
c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
>         perf  759982 448227.548611:          1 cycles:u:      559a9f03c81=
c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
>         perf  759982 448227.548612:         12 cycles:u:      559a9f03c81=
c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
>         perf  759982 448227.548613:        466 cycles:u:      559a9f03c81=
c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
>
> It's also possible to unload (and unpin, of course) using this command:
>
>   $ sudo perf record --setup-filter unpin
>
> The code is avaiable in 'perf/pinned-filter-v2' branch at
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (8):
>   perf bpf-filter: Make filters map a single entry hashmap
>   perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
>   perf bpf-filter: Split per-task filter use case
>   perf bpf-filter: Support pin/unpin BPF object
>   perf bpf-filter: Support separate lost counts for each filter
>   perf record: Fix a potential error handling issue
>   perf record: Add --setup-filter option
>   perf test: Update sample filtering test
>
>  tools/perf/Documentation/perf-record.txt     |   5 +
>  tools/perf/builtin-record.c                  |  23 +-
>  tools/perf/builtin-stat.c                    |   2 +-
>  tools/perf/builtin-top.c                     |   2 +-
>  tools/perf/builtin-trace.c                   |   2 +-
>  tools/perf/tests/shell/record_bpf_filter.sh  |  13 +-
>  tools/perf/util/bpf-filter.c                 | 406 +++++++++++++++++--
>  tools/perf/util/bpf-filter.h                 |  19 +-
>  tools/perf/util/bpf_skel/sample-filter.h     |   2 +
>  tools/perf/util/bpf_skel/sample_filter.bpf.c |  75 +++-
>  tools/perf/util/evlist.c                     |   5 +-
>  tools/perf/util/evlist.h                     |   4 +-
>  tools/perf/util/python.c                     |   3 +-
>  13 files changed, 485 insertions(+), 76 deletions(-)
>
> --
> 2.45.2.741.gdbec12cfda-goog
>
>

