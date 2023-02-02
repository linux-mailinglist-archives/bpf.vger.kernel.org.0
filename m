Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E26874E9
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 06:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjBBFFW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 00:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBBFFS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 00:05:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0889A70D54;
        Wed,  1 Feb 2023 21:05:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e6so707105plg.12;
        Wed, 01 Feb 2023 21:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/28sWI3Oy4sxzP6YrpEXjm5TO0C88CC0iz6gGXgbCM=;
        b=JZvW81C0nvW21mZLuJzI2vUccKQysLsAAekhbxbvRpum5MyZYoWbc8gKbKWXUyEnKZ
         12VPfbZVGiC3m5/igWxUCwXjyG66Ecw2UclNd5vL5jl1yij0FEypkZvRXe1LxTeZmhH6
         cnPySkHk/dbvf99zoQfgn/qb8w2Q8rml2IeD4eGLBsg+IGYqGIIyaWZI2ojUsQcvOXWM
         PI3wP5/UCUL+oQHzb/YpQo+MraTLs//ZdTCwaquW/fDwznY/xPRUExA0q2wQitnrwq3b
         k3wnHJblDzhA8WVdilwdgkfZwQ6tBbc20Nq3A4cFAq3rD9MGRQ0YiHImH/luWuc+g9ap
         4KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/28sWI3Oy4sxzP6YrpEXjm5TO0C88CC0iz6gGXgbCM=;
        b=jdlHqgn2S6DgPUsNEg8+rIt88GklU35J3qXAe6W7VXU8tWKzBkPdwOAaBpB/iFId8b
         +2zgcSKPcNCkyn7diwcjcFskivGNg/mhZ0b0sb+Xqth04S/LqEIbPk9t23EoS9m5dPZR
         FuO0vvE95iA7rweG8Vb7fWaWKUM4/zgrgAXCd5REOL3XflntbNKlcy3etp8QsVbxzuzp
         NZhPvMzXo2/NnQySnfYCXnWfqjGvFS0iIwbmLVQi43/HkvRDrCsJVcfqZXGSEkCX4gTD
         tfEy92rEbsrdWEmehErNUDeG5/P42a0ZLdmAUU8QFiXuOra449RbQKc4qWGv3ZlZz/Mm
         3waw==
X-Gm-Message-State: AO0yUKUisPOcE14kQh5UNTWjWJv74iFPyRe1aLuiaHzfJ0E7o5ugan/r
        MUasVNWrsHhCvH3xq5xLbzs=
X-Google-Smtp-Source: AK7set/9MkgEwHi9LVvM2cjwbZkZF598aC/idwTMP7aZu7ToVro1UuMikycSigQnR+R3472qoZJPPg==
X-Received: by 2002:a17:90b:4c81:b0:22c:69b6:2be8 with SMTP id my1-20020a17090b4c8100b0022c69b62be8mr5360687pjb.8.1675314305316;
        Wed, 01 Feb 2023 21:05:05 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:8899:7288:e54d:8b87])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090aba8300b0022bb3ee9b68sm2238374pjr.13.2023.02.01.21.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 21:05:04 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: [PATCH 4/4] perf test: Add more test cases for perf lock contention
Date:   Wed,  1 Feb 2023 21:04:55 -0800
Message-Id: <20230202050455.2187592-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230202050455.2187592-1-namhyung@kernel.org>
References: <20230202050455.2187592-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check callstack filter with two different aggregation mode.

  $ sudo ./perf test -v contention
   88: kernel lock contention analysis test                            :
  --- start ---
  test child forked, pid 83416
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  Testing perf lock contention --type-filter (w/ spinlock)
  Testing perf lock contention --lock-filter (w/ tasklist_lock)
  Testing perf lock contention --callstack-filter (w/ unix_stream)
  Testing perf lock contention --callstack-filter with task aggregation
  test child finished with 0
  ---- end ----
  kernel lock contention analysis test: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh | 66 +++++++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index b05f1b1ca6c8..be5fcafb26aa 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -128,7 +128,7 @@ test_type_filter()
 	echo "Testing perf lock contention --type-filter (w/ spinlock)"
 	perf lock contention -i ${perfdata} -Y spinlock -q 2> ${result}
 	if [ $(grep -c -v spinlock "${result}") != "0" ]; then
-		echo "[Fail] Recorded should not have non-spinlocks:" $(cat "${result}")
+		echo "[Fail] Recorded result should not have non-spinlocks:" $(cat "${result}")
 		err=1
 		exit
 	fi
@@ -139,7 +139,7 @@ test_type_filter()
 
 	perf lock con -a -b -Y spinlock -q -- perf bench sched messaging > /dev/null 2> ${result}
 	if [ $(grep -c -v spinlock "${result}") != "0" ]; then
-		echo "[Fail] Recorded should not have non-spinlocks:" $(cat "${result}")
+		echo "[Fail] BPF result should not have non-spinlocks:" $(cat "${result}")
 		err=1
 		exit
 	fi
@@ -160,7 +160,7 @@ test_lock_filter()
 	local type=$(head -1 "${result}" | awk '{ print $8 }' | sed -e 's/:.*//')
 
 	if [ $(grep -c -v "${type}" "${result}") != "0" ]; then
-		echo "[Fail] Recorded should not have non-${type} locks:" $(cat "${result}")
+		echo "[Fail] Recorded result should not have non-${type} locks:" $(cat "${result}")
 		err=1
 		exit
 	fi
@@ -171,7 +171,63 @@ test_lock_filter()
 
 	perf lock con -a -b -L tasklist_lock -q -- perf bench sched messaging > /dev/null 2> ${result}
 	if [ $(grep -c -v "${type}" "${result}") != "0" ]; then
-		echo "[Fail] Recorded should not have non-${type} locks:" $(cat "${result}")
+		echo "[Fail] BPF result should not have non-${type} locks:" $(cat "${result}")
+		err=1
+		exit
+	fi
+}
+
+test_stack_filter()
+{
+	echo "Testing perf lock contention --callstack-filter (w/ unix_stream)"
+	perf lock contention -i ${perfdata} -v -q 2> ${result}
+	if [ $(grep -c unix_stream "${result}") == "0" ]; then
+		echo "[Skip] Could not find 'unix_stream'"
+		return
+	fi
+
+	perf lock contention -i ${perfdata} -E 1 -S unix_stream -q 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] Recorded result should have a lock from unix_stream:" $(cat "${result}")
+		err=1
+		exit
+	fi
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		return
+	fi
+
+	perf lock con -a -b -S unix_stream -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] BPF result should have a lock from unix_stream:" $(cat "${result}")
+		err=1
+		exit
+	fi
+}
+
+test_aggr_task_stack_filter()
+{
+	echo "Testing perf lock contention --callstack-filter with task aggregation"
+	perf lock contention -i ${perfdata} -v -q 2> ${result}
+	if [ $(grep -c unix_stream "${result}") == "0" ]; then
+		echo "[Skip] Could not find 'unix_stream'"
+		return
+	fi
+
+	perf lock contention -i ${perfdata} -t -E 1 -S unix_stream -q 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] Recorded result should have a task from unix_stream:" $(cat "${result}")
+		err=1
+		exit
+	fi
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		return
+	fi
+
+	perf lock con -a -b -t -S unix_stream -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] BPF result should have a task from unix_stream:" $(cat "${result}")
 		err=1
 		exit
 	fi
@@ -186,5 +242,7 @@ test_aggr_task
 test_aggr_addr
 test_type_filter
 test_lock_filter
+test_stack_filter
+test_aggr_task_stack_filter
 
 exit ${err}
-- 
2.39.1.456.gfc5497dd1b-goog

