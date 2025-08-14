Return-Path: <bpf+bounces-65607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD2B25CE1
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9547B455C
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF6B264F85;
	Thu, 14 Aug 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrwiNMoX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBD347DD;
	Thu, 14 Aug 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155876; cv=none; b=islyD7aC+WDQSgSjRqXWE0G3fzPuFc2wci7coWqDTgFjw99KPhS8q5nZ1NteNjiOJvixEb0HagZrk57KvtZT0pkCE71VoyfNWyHtHCWRz2TvSnxB6dUvcD3iJ/scv5aCkzYToVuNBKZVCNrZK4U2XtZS5XpcmxnZeFpUpr/iXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155876; c=relaxed/simple;
	bh=EIyS6cacRApY14N1F2b8OnYP20Qp2x8rIcLAZ9DAbzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTXSd7LsOdPhFo5uOjWVOXNdSE6n4TytokJyL9jx3aK9bh3yTzzbfsPq1R+7iZQuZnZ696ybS94Iccym0DqT8GTd0u29L3vgZpuWifNurQNjYjtuOrC52K8DqtjSsAObuaopEh/WBFzX3+ENZzFG/sKVBxGsmos4ON9GZRwHRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrwiNMoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449D0C4CEEF;
	Thu, 14 Aug 2025 07:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755155875;
	bh=EIyS6cacRApY14N1F2b8OnYP20Qp2x8rIcLAZ9DAbzA=;
	h=From:To:Cc:Subject:Date:From;
	b=TrwiNMoXyoMKvkrS226c35YlvdxW8WvwA2ksAt8tW4vvnGqiIdAHu4VMQP7C1PrLq
	 8vblQOXVas7XFPrXoF2EpbDRntdr4I8KqpSy/PGKMpazdwcA88LHagTL9O/Dk4hbLq
	 9O9wDcKXg+hWYqoA4jmUMTi/tEM4ljSYkZIraxvSao3mxT5xsdbc2z12cRhUqryMQF
	 WPdaEmLd35zRcltQcUL+F6Umyfr8FR5RPpeNSMZPHlfSbltL8VGjd1UvqMYhkv84CZ
	 TgmimChD+5QV0N0/gcpHD/3z949QXGGTEgNmGLrLPRQ8KlmZoa+uB5iPp3IaCzPuw1
	 4iwUYCsbZPnuQ==
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
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH 0/5] perf trace: Fix parallel execution
Date: Thu, 14 Aug 2025 00:17:49 -0700
Message-ID: <20250814071754.193265-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is an attempt to fix a problem Howard reported earlier [1].  Now
perf trace attaches BPF to syscall tracepoints to augment argument as
well as filter out system calls that are not interested.  But it runs
on per-tracepoint basis and can affect other (unrelated) processes too.

So we cannot simply use the return value of BPF for filtering.
Instead, it can generate output for un-augmented arguments and return
values for syscalls it wants, then no need to use tracepoint events in
the perf trace.

This change should not introduce any difference from the users point
of view.  And it should allow multiple perf trace comand run without
affecting each other.  So I updated the related test cases not to run
them exclusively anymore.

The code is also available at 'perf/trace-fix-v1' branch in my tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


[1] https://lore.kernel.org/r/20250529065537.529937-1-howardchu95@gmail.com


Jakub Brnak (1):
  perf trace: use standard syscall tracepoint structs for augmentation

Namhyung Kim (4):
  perf trace: Split unaugmented sys_exit program
  perf trace: Do not return 0 from syscall tracepoint BPF
  perf trace: Remove unused code
  perf test: Remove exclusive tag from perf trace tests

 tools/perf/builtin-trace.c                    | 231 +++++++-----------
 .../tests/shell/trace+probe_vfs_getname.sh    |   2 +-
 tools/perf/tests/shell/trace_summary.sh       |   2 +-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 101 ++++----
 tools/perf/util/bpf_skel/perf_trace_u.h       |  14 ++
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |  14 ++
 tools/perf/util/bpf_trace_augment.c           |   9 +-
 tools/perf/util/trace_augment.h               |  10 +-
 8 files changed, 196 insertions(+), 187 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/perf_trace_u.h

-- 
2.51.0.rc1.167.g924127e9c0-goog


