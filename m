Return-Path: <bpf+bounces-10233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A120E7A3A04
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 21:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562AE281825
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123F7461;
	Sun, 17 Sep 2023 19:57:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34D56FA7;
	Sun, 17 Sep 2023 19:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E55BC433C8;
	Sun, 17 Sep 2023 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1694980676;
	bh=+5KquvfLRnhi0sY4tQvF7EFjkRW7FL8PiQ2vPPKCTb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wjX0uB9jF8kQ9h//GOuTdwMoNhL2KpaDzbrb1i2wI8EeOVa3Y7VxBh7kP/mD9udqj
	 hqmS5ESP9mFz2aOz2Sr7TxSc0mX2EwluSCz8/Q0xUQJnTPFlOJ68cXFIWsA099INE0
	 AHqEN1MGWa/kYWdquyMW2fOhfCbD7WBuqzCzJ9ZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Song Liu <song@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.5 234/285] perf test shell stat_bpf_counters: Fix test on Intel
Date: Sun, 17 Sep 2023 21:13:54 +0200
Message-ID: <20230917191059.518477143@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

commit 68ca249c964f520af7f8763e22f12bd26b57b870 upstream.

As of now, bpf counters (bperf) don't support event groups.  But the
default perf stat includes topdown metrics if supported (on recent Intel
machines) which require groups.  That makes perf stat exiting.

  $ sudo perf stat --bpf-counter true
  bpf managed perf events do not yet support groups.

Actually the test explicitly uses cycles event only, but it missed to
pass the option when it checks the availability of the command.

Fixes: 2c0cb9f56020d2ea ("perf test: Add a shell test for 'perf stat --bpf-counters' new option")
Reviewed-by: Song Liu <song@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230825164152.165610-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/shell/stat_bpf_counters.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,10 +22,10 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-if ! perf stat --bpf-counters true > /dev/null 2>&1; then
+if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
 	if [ "$1" = "-v" ]; then
 		echo "Skipping: --bpf-counters not supported"
-		perf --no-pager stat --bpf-counters true || true
+		perf --no-pager stat -e cycles --bpf-counters true || true
 	fi
 	exit 2
 fi



