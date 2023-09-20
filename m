Return-Path: <bpf+bounces-10449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B337A819B
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 14:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B351C20CCC
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D331A6E;
	Wed, 20 Sep 2023 12:46:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050F328A2;
	Wed, 20 Sep 2023 12:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B74C433C9;
	Wed, 20 Sep 2023 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695213986;
	bh=yYUJGr1ekFJdAXZtWX62M+Gi8IxzUdobO7q5GulGG/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uo485Gx5mf+c3zsZMnQo+V8QvO2AvpeWF/UtvuAP8xnTJc93e+GJT0HcN1PefhnsM
	 s3KwnnbFAPePXiNbiwbqfUNfytSeDPR7jzkVbqRzCKcra5eEGWjTpXLKqPg1klgzB1
	 Qz5eB6lbArS6x+/aIiCYqbAp8Ex5MvBJXKpWB3Jg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Song Liu <songliubraving@fb.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Yonghong Song <yhs@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 071/110] perf test: Remove bash construct from stat_bpf_counters.sh test
Date: Wed, 20 Sep 2023 13:32:09 +0200
Message-ID: <20230920112833.087148087@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Clark <james.clark@arm.com>

[ Upstream commit c8b947642d2339ce74c6a1ce56726089539f48d9 ]

Currently the test skips with an error because == only works in bash:

  $ ./perf test 91 -v
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
  91: perf stat --bpf-counters test                                   :
  --- start ---
  test child forked, pid 44586
  ./tests/shell/stat_bpf_counters.sh: 26: [: -v: unexpected operator
  test child finished with -2
  ---- end ----
  perf stat --bpf-counters test: Skip

Changing == to = does the same thing, but doesn't result in an error:

  ./perf test 91 -v
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
  91: perf stat --bpf-counters test                                   :
  --- start ---
  test child forked, pid 45833
  Skipping: --bpf-counters not supported
    Error: unknown option `bpf-counters'
  [...]
  test child finished with -2
  ---- end ----
  perf stat --bpf-counters test: Skip

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/r/20211028134828.65774-2-james.clark@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 68ca249c964f ("perf test shell stat_bpf_counters: Fix test on Intel")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 2aed20dc22625..13473aeba489c 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -23,7 +23,7 @@ compare_number()
 
 # skip if --bpf-counters is not supported
 if ! perf stat --bpf-counters true > /dev/null 2>&1; then
-	if [ "$1" == "-v" ]; then
+	if [ "$1" = "-v" ]; then
 		echo "Skipping: --bpf-counters not supported"
 		perf --no-pager stat --bpf-counters true || true
 	fi
-- 
2.40.1




