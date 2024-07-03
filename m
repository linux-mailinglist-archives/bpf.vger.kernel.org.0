Return-Path: <bpf+bounces-33826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA7926B8C
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7E282EBA
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3207191F69;
	Wed,  3 Jul 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNxacDm9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423ED747F;
	Wed,  3 Jul 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045837; cv=none; b=uEgQKZnK0LABJFgOPXGW6QfJ+qDT6tTjjlQo5ciwMfpvVnbTImmZigyQnAIwG08Hpgiq9VG1OE31Oh3+zp8eq0k5xSOnhBaH+MTOeFZYwBmHcnVBCXS6IxbsH3HTH5rb+8N5I7i+Bsp5pWcSARH4hrEuylY7gJc1d1mkkvIEcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045837; c=relaxed/simple;
	bh=Dx6OyW5Hl4QcI/eWRPm1F3xDwECEG0/TAYkzbF3rzXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imvcqqPULCtlGQm9Zfh2nPdlTQ75vO2wenGPcEs/uRZyCnGfFOH2EaEYJiRDA1i1AkDNJ6PGLqJ3nKa3XXgo8UooWli4zYQ+SdM8nVv8DnW7PN0eSfc3EMASazyYv+EOPIk+hk1AKidzwJdSwXsK0IQdGTF4mv+QLEsk7Qzojzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNxacDm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E452C2BD10;
	Wed,  3 Jul 2024 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045836;
	bh=Dx6OyW5Hl4QcI/eWRPm1F3xDwECEG0/TAYkzbF3rzXY=;
	h=From:To:Cc:Subject:Date:From;
	b=iNxacDm9NTNG6fJPdXTE9cCiYUEQ8imsgkZRa87MKF48OGj8GkpkCK3RlBSky2MVn
	 vSX2W2vwPWXw3L1M2TMF6LBevAaD+dbJA3YkVWanTXT8sZjzpjcP6gotw0x9BFxLWW
	 FwymwOaSyOceeKaqBzY1biVY+D3nPt5PXBFfKgl/KJJ1NYoexgpoDC3d749WSy5otQ
	 dTVvryMUTL2SkdyOOT+XPfRqso2dE9k4wR4KTmqwzOWGM6Do9gwJAbJI/JnlwIPeZC
	 D+EIjHohHmBCpgOqKOFIyRQwOc8cpmU/geGa4kNI9AcJyvGbG/zlv2Sktb71yruPjU
	 wiCgZ3AxoczAw==
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
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: [PATCHSET v3 0/8] perf record: Use a pinned BPF program for filter
Date: Wed,  3 Jul 2024 15:30:27 -0700
Message-ID: <20240703223035.2024586-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
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

v3 changes)
 * rebased onto latest perf-tools-next

v2 changes)
 * rebased onto Ian's UID/GID (non-sample data based) filter term change
 * support separate lost counts for each use case
 * update the test case to allow normal users (if supported)


This only supports the per-task mode for normal users and root still uses
its own instance of the same BPF program - not shared with other users.
But it requires the one-time setup (by root) before using it by normal users
like below.

  $ sudo perf record --setup-filter pin

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

  $ sudo perf record --setup-filter unpin

The code is avaiable in 'perf/pinned-filter-v3' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (8):
  perf bpf-filter: Make filters map a single entry hashmap
  perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
  perf bpf-filter: Split per-task filter use case
  perf bpf-filter: Support pin/unpin BPF object
  perf bpf-filter: Support separate lost counts for each filter
  perf record: Fix a potential error handling issue
  perf record: Add --setup-filter option
  perf test: Update sample filtering test

 tools/perf/Documentation/perf-record.txt     |   5 +
 tools/perf/builtin-record.c                  |  23 +-
 tools/perf/builtin-stat.c                    |   2 +-
 tools/perf/builtin-top.c                     |   2 +-
 tools/perf/builtin-trace.c                   |   2 +-
 tools/perf/tests/shell/record_bpf_filter.sh  |  13 +-
 tools/perf/util/bpf-filter.c                 | 406 +++++++++++++++++--
 tools/perf/util/bpf-filter.h                 |  19 +-
 tools/perf/util/bpf_skel/sample-filter.h     |   2 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  75 +++-
 tools/perf/util/evlist.c                     |   5 +-
 tools/perf/util/evlist.h                     |   4 +-
 12 files changed, 483 insertions(+), 75 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


