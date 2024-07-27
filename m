Return-Path: <bpf+bounces-35891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60293FBB6
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527BB1C228BA
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3211741D9;
	Mon, 29 Jul 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nNxJxq15"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55416D4C3
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271569; cv=none; b=fPJfbeFvyrpq70Wjq/7/08X6W4Q+xrKETOESN5B9vxxOF6QKrvftrCGAnL4zBFFo49xqPKaHlhAOu8/UbMas7/XwCE0rkA8xCM6iIPdfch8dnJQ0NJMlQgrczBTMehs+NkjnnuEtxdy8Wb5e/FpVfnFOo0Xu2qM2omQBJnGeCOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271569; c=relaxed/simple;
	bh=wNvqt1xvuMD0pHy+ZTcuN/4GhZ2p2a/Hb6rfsGPujGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jJDbgsQoye3vGrkoA66cU9enxVQyNUUaWiuC6bSlprS0kQRpIKS/8QZaTTT85xygmXaam9HcxrJnK4OQ5+KJ1fGz8CeGy/PGAEBmvAWVJoLZ5TCdkUIjeI6O5DuEUS2DaJxxiYEwKAzn7FRIgh5COfYn/52b0VSkJ1+zi+BUSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nNxJxq15; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc6a017abdso19282405ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271566; x=1722876366; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kviHpjNAUi5B7kpuc65zsq7f4mxJO5hSE3q4QPsnoQ=;
        b=nNxJxq15f56yDrWt5P7BDhUq89DNeeM3SFOFR80LGM1OgrMjWFJL8n+4tp57dbTRv9
         jq3CrvdZUsVPEFDh8ZB1iD1N1OAaUxs7MQZrdD4xwXdw8oxw7HDAB/bXwPDmVgfa0RKW
         RlAOqb7gn8QFTCGSp0Qcpujp/3eoL2lwDPhZG+xzaC7FbYsR2f1I4qmuFuggxgN3Gsdp
         4nI/C6bqoODr3zq6cHURe7RUYuVoB776JoNf5j337jk+0oeSs9o1Mnd0zc6cnU31lN5d
         t5LLPPurvjq7A93/lyT3zd0q2fx0Odnf8u/X3vyPwZGndtfleCNVkzFx+sxJnPK/Lp6F
         TCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271566; x=1722876366;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kviHpjNAUi5B7kpuc65zsq7f4mxJO5hSE3q4QPsnoQ=;
        b=VIeh3pQa54fGfgujcdKrmDNlWhLPhmUWhZSAcP91f/YB5W3o8uFXESvzSvSdvE7bQZ
         s5vt2a3538ztkQcszjgWhL2uRKshbk071DfRQQAwKylQMAE1ouJ6fYnYqma6WN+J+laA
         TTcR+0H8zQAoURvatOxmkt9xMPfhpmD8urWb1j4n+GlH3aoyXiKukJzX7sr7xqoKBmMv
         Of8GLBzhjKa83lXko0q8VDLqBz5aBMv+v2DehrmpaTJS1sjQBK5uBJvmJC48YdGJoBnh
         hcrW+f6k34DcWjAdbABu9ApYDDd0QFsvpjZMTH9e9O7nVlZZFoswBkqm84ETYIiyjars
         hUqw==
X-Forwarded-Encrypted: i=1; AJvYcCW9L67MYDkOig6hujZmPRywaeXNGBvvZpVAVBqQn4ZaksIgT3k9zwPmrYh7O3hepBhJZw76Xt2R+tJNHtve9tMmlqkA
X-Gm-Message-State: AOJu0YxSo9t7rJS+X/7OPo1ZSvLjwcnmJ3jHaiYkfGPfHDjVzuct7+HJ
	lz4GvWvuEcARk2c3PifcU22sIUjnrFSq7fAYQHKiwIDmMXsvPudd8siorUrAtNk=
X-Google-Smtp-Source: AGHT+IEqfgg9K3tkn+AB81uDLY3sOHsM9ebG79PIdI/mdENlVn5qemW73G2meb4IA0mrZqN8jjItFQ==
X-Received: by 2002:a17:902:d3c9:b0:1fb:6616:9cd4 with SMTP id d9443c01a7336-1ff04854376mr56208365ad.38.1722271566097;
        Mon, 29 Jul 2024 09:46:06 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:05 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/8] libperf: Add interface for overflow check of
 sampling events
Date: Fri, 26 Jul 2024 22:29:30 -0700
Message-Id: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALqFpGYC/x2MQQqAIBAAvxJ7TiiRkr4SEaZrLoWKQgXh35OOM
 zDzQsZEmGFqXkh4UabgK/C2Ae2U35GRqQy846Ib+cDChcme4V61Q32sJ22xCialMr0QRhitoMY
 xoaXnH89LKR9e5qTbaAAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=4073;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=wNvqt1xvuMD0pHy+ZTcuN/4GhZ2p2a/Hb6rfsGPujGQ=;
 b=FdQ9KN3+e83hrpLxZcZ6n3PLWI6MPr9FY9nv9pCOlvEiq3JGXcclYvvBxB0PCTclrKFqn9JJy
 qHmNcAOOxouAO82eOp8fzg99RZhqq7nB/D9HczDgVx2e9Uc9JzYf/fY
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

I was going to send a similar series but after looking through the
mailing list found this approach which fits my use-case exactly. I have
rebased the series and applied the suggestions from Namhyung. The
original cover letter with minor changes follows.

This patch series adds interface for overflow check of sampling events
to libperf.

First patch move 'open_flags' from tools/perf to evsel::open_flags.

Second patch extracts out the opts used by BPF into a common header to
be used by perf.

Third patch introduce perf_{evsel, evlist}__open_opt() with extensible
structure opts.

Fourth patch adds support for overflow handling of sampling events.

Fifth patch adds a interface to check overflowed events.

Sixth patch adds a interface to perform IOC_REFRESH and IOC_PERIOD.

Seventh and eighth patch adds tests.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Previous version at:
https://lore.kernel.org/lkml/20220422093833.340873-1-nakamura.shun@fujitsu.com/

Changes in v2:
- Rebase onto v6.10
- Add a patch to move BPF opts helpers into a global include
- Renamed flags to fcntl_flags
- Changed signal type to int
- Add comment to owner_type member
- Add _cpu to perf_evsel__run_fcntl
- Rename sig to sigact
- Remove "!" from owner.type check
- Removed _GNU_SOURCE addition
- Removed null check for perf_evsel__attr()
- Make timeouts consistent between test-evlist.c and test-evsel.c

Changes in v1:
 - Move initialization/reference of evsel->open_flags from the first
   patch to the second patch
 - Move signal-related handling and related fields of the opts
   structure from the second patch to the third patch
 - Move _GNU_SOURCE from test-evlist.c to Makefile
 - Delete *_cpu() function
 - Refactor the fourth patch
 - Fix test to use real-time signals instead of standard signals

Changes in RFC v2:
 - Delete perf_evsel__set_close_on_exec() function
 - Introduce perf_{evsel, evlist}__open_opt() with extensible structure
   opts
 - Fix perf_evsel__set_signal() to a internal function
 - Add bool type argument to perf_evsel__check_{fd, fd_cpu}() to indicate
   overflow results

---
Charlie Jenkins (1):
      libbpf: Move opts code into dedicated header

Shunsuke Nakamura (7):
      libperf: Move 'open_flags' from tools/perf to evsel::open_flags
      libperf: Introduce perf_{evsel, evlist}__open_opt with extensible struct opts
      libperf: Add support for overflow handling of sampling events
      libperf: Add perf_evsel__has_fd() functions
      libperf: Add perf_evsel__{refresh, period}() functions
      libperf test: Add test_stat_overflow()
      libperf test: Add test_stat_overflow_event()

 tools/include/tools/opts.h               |  68 +++++++++++++
 tools/lib/bpf/bpf.c                      |   1 +
 tools/lib/bpf/btf.c                      |   1 +
 tools/lib/bpf/btf_dump.c                 |   1 +
 tools/lib/bpf/libbpf.c                   |   3 +-
 tools/lib/bpf/libbpf_internal.h          |  48 ---------
 tools/lib/bpf/linker.c                   |   1 +
 tools/lib/bpf/netlink.c                  |   1 +
 tools/lib/bpf/ringbuf.c                  |   1 +
 tools/lib/perf/Documentation/libperf.txt |  17 ++++
 tools/lib/perf/Makefile                  |   1 +
 tools/lib/perf/evlist.c                  |  20 ++++
 tools/lib/perf/evsel.c                   | 169 +++++++++++++++++++++++++++++--
 tools/lib/perf/include/internal/evsel.h  |   2 +
 tools/lib/perf/include/perf/evlist.h     |   3 +
 tools/lib/perf/include/perf/evsel.h      |  30 ++++++
 tools/lib/perf/libperf.map               |   5 +
 tools/lib/perf/tests/test-evlist.c       | 112 +++++++++++++++++++-
 tools/lib/perf/tests/test-evsel.c        | 107 +++++++++++++++++++
 tools/perf/util/evsel.c                  |  16 +--
 tools/perf/util/evsel.h                  |   1 -
 21 files changed, 541 insertions(+), 67 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240726-overflow_check_libperf-88ad144d4dca
-- 
- Charlie


