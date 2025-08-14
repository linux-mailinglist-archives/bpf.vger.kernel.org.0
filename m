Return-Path: <bpf+bounces-65612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC51B25CEA
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA67E7B4772
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97D326FA58;
	Thu, 14 Aug 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1fO8XuI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309B26E16F;
	Thu, 14 Aug 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155879; cv=none; b=GKcYU9+bIfMH7MVGiP6G6lij82etxka7kzGKi57JgDroceHb4EpZGIxxksJsackZ4nyWp6Mls7XIOZpuehKS6iseN0veJXWyL7N9oAMO1IuLohi626MqSR1aC9yKBHVtKSEFEl8gmzvxGNktwlqKqjwGZ+zZKwllh+xwAsiFgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155879; c=relaxed/simple;
	bh=yfHuajUoMYm+ze2VB15y2TKSP2Ni3Z1+r9n+XCyy0AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6ZV5UYHjKEP2xh6I1rq8YnrJ8gDbd37wB2Og1CG8N+SsEhxzc8P+sl+83BgtcaXVtRPok69wenyJz8NWzLLYxUXuZxfWexBjrswPVWghdzISJ/p5hc7Ds5IB9u6eeaVg3HlxJvJW+IFdk7N9s0IbTmX4h++1oRWlLzZcho/NCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1fO8XuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC17C4CEF9;
	Thu, 14 Aug 2025 07:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755155878;
	bh=yfHuajUoMYm+ze2VB15y2TKSP2Ni3Z1+r9n+XCyy0AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1fO8XuI+3Wsd4kdRrnqoDASgVS6chLeIizcvp9lDpsck408VcePXYfyvHQSxKabU
	 013/PzOl1HnK3Xr8VpI5VbW1p9GKYF9BehgqhkYs41yEqSjEv+yUbmz5iD6h6OvmpQ
	 fRsOLdYtBohF+CIl+2bDS/V8J8rMSKaUt2l3x7g3joSW5UrLwKsw9WJYllK7G+DRPq
	 g+9oz8I41CdmiDj84TuFXlg24d4Kyjcg2OMBkpW8fjAxp8VKCP21q/z06vS4MVMfAV
	 BQmvNYN0v2j49331ccR4SuoFzo6JEuiDT27760Epw0DlzgsnSRlAV4y7naWRCILL4H
	 6hM9YE/bdlLeg==
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
Subject: [PATCH 5/5] perf test: Remove exclusive tag from perf trace tests
Date: Thu, 14 Aug 2025 00:17:54 -0700
Message-ID: <20250814071754.193265-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250814071754.193265-1-namhyung@kernel.org>
References: <20250814071754.193265-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now it's safe to run multiple perf trace commands at the same time.
Let's make them non-exclusive so that they can run in parallel.

  $ sudo perf test 'perf trace'
  113: Check open filename arg using perf trace + vfs_getname          : Skip
  114: perf trace enum augmentation tests                              : Ok
  115: perf trace BTF general tests                                    : Ok
  116: perf trace exit race                                            : Ok
  117: perf trace record and replay                                    : Ok
  118: perf trace summary                                              : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 2 +-
 tools/perf/tests/shell/trace_summary.sh           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 7a0b1145d0cd744b..ff7c2f8d41db5802 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# Check open filename arg using perf trace + vfs_getname (exclusive)
+# Check open filename arg using perf trace + vfs_getname
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
 # then use it with 'perf trace' using 'touch' to write to a temp file, then
diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 22e2651d59191676..1a99a125492955ad 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf trace summary (exclusive)
+# perf trace summary
 # SPDX-License-Identifier: GPL-2.0
 
 # Check that perf trace works with various summary mode
-- 
2.51.0.rc1.167.g924127e9c0-goog


