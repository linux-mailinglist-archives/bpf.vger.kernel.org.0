Return-Path: <bpf+bounces-33834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1AA926B9B
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC791C21660
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED68142651;
	Wed,  3 Jul 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REfrxaSN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C3198856;
	Wed,  3 Jul 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045841; cv=none; b=bHIsecrjIoOIrA67Cr64Vj2uCHwH7OtCCGiVooQadPGgPG3NZzYVTOw/qMlAdj799GKrDg/nDpxfyv16lolFU9X8+OHq0PVy8vofA3Mgc8H7TTfgVMoeU5wsIPCBCQT6sJY0CC22A0A9QHEHxN71vucsyMNYc9tCT20O8su76m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045841; c=relaxed/simple;
	bh=iNzyG83EiBgTHKgiUVFpdaQFHP6TuBa/IvdNw9r2DAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPPMNBMcX6E5RerHMV9L+Pl5HeMiH4pToq9IQWCCmFxFcYvSXGJrP86KrdmUf0vVWS4yaWeLVDpLPBCN+zYXH17B+urimu3peQGInUsWLIhzK9TGdKheD8lwPbYQlbO0Pt76HvNgmTYzB1dAHnYauamTFGnfgbrRWPPXliU9Gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REfrxaSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD159C4AF0F;
	Wed,  3 Jul 2024 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045841;
	bh=iNzyG83EiBgTHKgiUVFpdaQFHP6TuBa/IvdNw9r2DAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REfrxaSNaH9WPtWxsDXh8rJt4mP7rb6SmOUfTYBJvZEnHf4BIaM/OTDH5Va5FOw8e
	 V1gEYdNXvCJ9IWsXnuVTYO/5A3HQ1bJBLUKBVG2W9iWFTbiU4qUfhOTeRQxBjFQF4+
	 7isZm7ux1Xi6CYN/YvOj98+U91BOrFzOG/qwhnC3vYckFNfHThlvK3A9lX4DT0NCUW
	 OvhOrQHwFI3GhApQHTiG0x7Z3PX7I2LAou0XhbnzK1ZJlIO7pEE42ldF6z1qKcJ8a/
	 r8vYtcnrhXjg0I5rOLAjyClluusqjSEXEZWAb+UybE0UW2Mu+twa51gNs09HTL+CX+
	 JwXkpS+Nh8LIg==
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
Subject: [PATCH v3 8/8] perf test: Update sample filtering test
Date: Wed,  3 Jul 2024 15:30:35 -0700
Message-ID: <20240703223035.2024586-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240703223035.2024586-1-namhyung@kernel.org>
References: <20240703223035.2024586-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now it can run the BPF filtering test with normal user if the BPF
objects are pinned by 'sudo perf record --setup-filter pin'.  Let's
update the test case to verify the behavior.  It'll skip the test if the
filter check is failed from a normal user, but it shows a message how to
set up the filters.

First, run the test as a normal user and it fails.

  $ perf test -vv filtering
   95: perf record sample filtering (by BPF) tests:
  --- start ---
  test child forked, pid 425677
  Checking BPF-filter privilege
  try 'sudo perf record --setup-filter pin' first.       <<<--- here
  bpf-filter test [Skipped permission]
  ---- end(-2) ----
   95: perf record sample filtering (by BPF) tests                     : Skip

According to the message, run the perf record command to pin the BPF
objects.

  $ sudo perf record --setup-filter pin

And re-run the test as a normal user.

  $ perf test -vv filtering
   95: perf record sample filtering (by BPF) tests:
  --- start ---
  test child forked, pid 424486
  Checking BPF-filter privilege
  Basic bpf-filter test
  Basic bpf-filter test [Success]
  Failing bpf-filter test
  Error: task-clock event does not have PERF_SAMPLE_CPU
  Failing bpf-filter test [Success]
  Group bpf-filter test
  Error: task-clock event does not have PERF_SAMPLE_CPU
  Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
  Group bpf-filter test [Success]
  ---- end(0) ----
   95: perf record sample filtering (by BPF) tests                     : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_bpf_filter.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index 31c593966e8c..c5882d620db7 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -22,15 +22,16 @@ trap trap_cleanup EXIT TERM INT
 test_bpf_filter_priv() {
   echo "Checking BPF-filter privilege"
 
-  if [ "$(id -u)" != 0 ]
-  then
-    echo "bpf-filter test [Skipped permission]"
-    err=2
-    return
-  fi
   if ! perf record -e task-clock --filter 'period > 1' \
 	  -o /dev/null --quiet true 2>&1
   then
+    if [ "$(id -u)" != 0 ]
+    then
+      echo "try 'sudo perf record --setup-filter pin' first."
+      echo "bpf-filter test [Skipped permission]"
+      err=2
+      return
+    fi
     echo "bpf-filter test [Skipped missing BPF support]"
     err=2
     return
-- 
2.45.2.803.g4e1b14247a-goog


