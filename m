Return-Path: <bpf+bounces-30334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB78CC850
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1DEB20E9A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D0146A8C;
	Wed, 22 May 2024 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7/kSKMT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694551BF2A;
	Wed, 22 May 2024 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414978; cv=none; b=j1JbZ3g8MHLk2qcMLtpiCFUo8kPUr4bSc556w6tgB+LdNuuvnk+CSq5abBVBYqbgugmlpGN+R7ZiQ5MpjG5RvbwsKX2aMz/yPR+dyKafxoMDK9Q3r1lWQk/OIbKt3IRAGTSA/l91HN7xScaDx+cWN4QVFZHcduVV2bzyFrYcSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414978; c=relaxed/simple;
	bh=1vIOH6m5r66YlxdDfT/tB9LNZ0Lyw5wBqQXHVST2wCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MB8qf5YMxaQj7dEu4oqqR17Cf8Bf6MlloaVCtf3M6JePB5y60w4FFzJRkJLeZt26ZfiKv2a81MclF9oPjclv6oMkPklm7GZmraPbktf1e2BukdB5zZf6yWmmwBYBnCCwsLLO+trl38tjFKDGmpCpkpEPNi+jJA3VSwZ1s/4wWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7/kSKMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9EDC2BBFC;
	Wed, 22 May 2024 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716414977;
	bh=1vIOH6m5r66YlxdDfT/tB9LNZ0Lyw5wBqQXHVST2wCE=;
	h=From:To:Cc:Subject:Date:From;
	b=b7/kSKMTKaLJ79zb0GDtrhYJiH5qxIKxWy0FQP0FlJtPgt7AZZlHWvaJdWxjIzoS8
	 zAfIRxExSSVcjPSwrMzJHR+YapZkmwQe3usN2JzAh1ms5E+zbmfuVcDIS3DoBzQHxD
	 WQSUM31I2cmn6mS77XUvrQmbZp8BS42PhrQk2SfpDRlbw/lBGA0035xXf3d2d4G7HE
	 pljJ6df7fspy9jxTYUYrvX4AxBboiYar1hI23beXg75V79ImzogBzpQR6vdpnZ+2dL
	 4jsjEQnVAw6pVm31FrLrGxOFktWVT1WXQPqdX7yskWagiQyciYyqCZhULdsc2T+xak
	 dO45PQ3Sq2tXA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [RFC 0/6] perf record: Use pinned BPF program for filter (v1)
Date: Wed, 22 May 2024 14:56:10 -0700
Message-ID: <20240522215616.762195-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to support the unprivileged BPF filter for profiling per-task events.
Until now only root (or any user with CAP_BPF) can use the filter and we
cannot add a new unprivileged BPF program types.  After talking with the BPF
folks at LSF/MM/BPF 2024, I was told that this is the way to go.  Finally I
managed to make it working with pinned BPF objects. :)

But it requires the one-time setup (by root) before using it like below.

  # perf record --setup-filter pin

This will load the BPF program and maps and pin them in the BPF-fs.  Then
normal users can use the filter.

  $ perf record -o- -e cycles:u --filter 'period < 10000' perf test -w noploop | perf script -i-
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.011 MB - ]
        perf  759982 448227.214189:          1 cycles:u:      7f153719f4d0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
        perf  759982 448227.214195:          1 cycles:u:      7f153719f4d0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
        perf  759982 448227.214196:          7 cycles:u:      7f153719f4d0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
        perf  759982 448227.214196:        223 cycles:u:      7f153719f4d0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
        perf  759982 448227.214198:       9475 cycles:u:  ffffffff8ee012a0 [unknown] ([unknown])
        perf  759982 448227.548608:          1 cycles:u:      559a9f03c81c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
        perf  759982 448227.548611:          1 cycles:u:      559a9f03c81c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
        perf  759982 448227.548612:         12 cycles:u:      559a9f03c81c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)
        perf  759982 448227.548613:        466 cycles:u:      559a9f03c81c noploop+0x5c (/home/namhyung/linux/tools/perf/perf)

It's also possible to unload (and unpin, of course) using this command:

  # perf record --setup-filter unpin

The code is avaiable in 'perf/pinned-filter-v1' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  perf bpf-filter: Make filters map a single entry hashmap
  perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
  perf bpf-filter: Split per-task filter use case
  perf bpf-filter: Support pin/unpin BPF object
  perf record: Fix a potential error handling issue
  perf record: Add --setup-filter option

 tools/perf/Documentation/perf-record.txt     |   5 +
 tools/perf/builtin-record.c                  |  23 +-
 tools/perf/builtin-stat.c                    |   2 +-
 tools/perf/builtin-trace.c                   |   2 +-
 tools/perf/util/bpf-filter.c                 | 369 +++++++++++++++++--
 tools/perf/util/bpf-filter.h                 |  19 +-
 tools/perf/util/bpf_skel/sample-filter.h     |   4 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  58 ++-
 tools/perf/util/evlist.c                     |   5 +-
 tools/perf/util/evlist.h                     |   4 +-
 tools/perf/util/python.c                     |   3 +-
 11 files changed, 428 insertions(+), 66 deletions(-)


base-commit: ea558c86248b4955e5c5f3c0c921df450880605e
-- 
2.45.1.288.g0e0cd299f1-goog


