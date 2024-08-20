Return-Path: <bpf+bounces-37643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7AD958B8D
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8842864C7
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED819E7E9;
	Tue, 20 Aug 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHJCunT2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A0196455;
	Tue, 20 Aug 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168708; cv=none; b=Pwh04J2HeehBVN1LtCyGVUsGOx7LNL+cHxr9FeeCsGQ5WOmem+/Irb4Hf1KOKTkKnC2brltWNJYood64AcYwGXkObHP7jnQGkq4ZGzSW6X0OvMwQ8FYHfrD0ZJfxIKuyphgMViYuD2hJT6RwUr1d+ff202wSHlEWDWtqbmeDfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168708; c=relaxed/simple;
	bh=3lZq+3aA0aSLWeTq4y2s63WnDT4KOzjeUyOfnfwx8WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMuvztnyTdP2rMJ7T2z/lEXmo9Sgi6Ti6YLFaLf2RN1lIuJANMR/LwjuKxKr5UeYid9hqpRWrBVQ5boEbcUT4MwRMYVcszkDQckuTvE4bOALdahcyzBMTUUxw2xoq7xOMnIIKwSSEo6DOOmYIOizMji4LuyI93pfm5FlomRv8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHJCunT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2690C4AF1A;
	Tue, 20 Aug 2024 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724168708;
	bh=3lZq+3aA0aSLWeTq4y2s63WnDT4KOzjeUyOfnfwx8WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHJCunT2VfHvMlGs7JRJJah3iyDnnk/xUL+T9z/RsOGlSFBD+AU3+vl0a4tl7HJ4P
	 kfWNWvZS3mZROZurSwSUJAxwbFdMgMEmkq7sGAHHe3qnaRA8U1ejo4YP42yBw9rA5T
	 psjgthBsVm/6EcPCI5tNegLBH+VUlegxhahFrltin71yUQdWizZyODjyZz+G+KqKc8
	 FEAkOd4daiRcHIF6qY6XCQOBeRiCRH2PioVn5nS8c5sDiPygmZZT1y9RJoixDqJJ1y
	 zfSHpTRe2UGMLBK2DdPFV2eJlKR+uY3h4mwCH0SIxays28GB/ErVyimULKEufYX29u
	 FV04BwCmFPB0g==
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
	bpf@vger.kernel.org
Subject: [PATCH v3 3/3] perf test: Update sample filtering tests with multiple events
Date: Tue, 20 Aug 2024 08:45:04 -0700
Message-ID: <20240820154504.128923-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240820154504.128923-1-namhyung@kernel.org>
References: <20240820154504.128923-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Multiple bpf-filter test for two or more events with filters.
It uses task-clock and page-faults events with different filter
expressions and check the perf script output

  $ sudo ./perf test filtering -vv
   96: perf record sample filtering (by BPF) tests:
  --- start ---
  test child forked, pid 2804025
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
  Multiple bpf-filter test
  Multiple bpf-filter test [Success]
  ---- end(0) ----
   96: perf record sample filtering (by BPF) tests                     : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_bpf_filter.sh | 34 +++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index c5882d620db7..4df33c15bfa7 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -116,6 +116,36 @@ test_bpf_filter_group() {
   echo "Group bpf-filter test [Success]"
 }
 
+test_bpf_filter_multi() {
+  echo "Multiple bpf-filter test"
+
+  if ! perf record -e task-clock --filter 'period > 100000' \
+       -e page-faults --filter 'ip < 0xffffffff00000000' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Multiple bpf-filter test [Failed record]"
+    err=1
+    return
+  fi
+
+  if ! perf script -i "${perfdata}" -F period,event | grep task-clock | \
+	  awk '{ if (int($1) <= 100000) { print $0; exit(1); } }'
+  then
+    echo "Multiple bpf-filter test [Failed task-clock period]"
+    err=1
+    return
+  fi
+
+  if perf script -i "${perfdata}" -F event,ip | grep page-fault | \
+	  grep 'ffffffff[0-9a-f]*'
+  then
+    echo "Multiple bpf-filter test [Failed page-faults ip]"
+    err=1
+    return
+  fi
+
+  echo "Multiple bpf-filter test [Success]"
+}
 
 test_bpf_filter_priv
 
@@ -131,5 +161,9 @@ if [ $err = 0 ]; then
   test_bpf_filter_group
 fi
 
+if [ $err = 0 ]; then
+  test_bpf_filter_multi
+fi
+
 cleanup
 exit $err
-- 
2.46.0.184.g6999bdac58-goog


