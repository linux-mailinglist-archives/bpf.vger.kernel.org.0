Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FF96513B1
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 21:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiLSUSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 15:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiLSURr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 15:17:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F0D64ED;
        Mon, 19 Dec 2022 12:17:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v23so5007547pju.3;
        Mon, 19 Dec 2022 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/YKT1JJIPuRoA7Hx7R8arjPSGFufHSp1KclETKmED4=;
        b=HVbC+Iu6DOauKYKAjXJ43ZOUiX8W5s0QydrESBi85TvL2VmyDCJR/2ymPdVYq/iDf/
         IO6JdGU4dwlAukwN6rby4URhzT7owcP4jlDE7KILweEbgmvaWh+tGJlJzYD1tXTVYGSc
         LWNHMvXZrUg5P/xm50ZkS7+tQkGNaKPvYW9Zn2vDbBdFSpLQ4WgcFx3BMgkEqaEOeGis
         jWD0VFpNiPZQg5fT8EfCEAdwmkBJFsP4/GCJSNA9Dq1G7InW2qzihT9tyIqEZHighyhM
         DI/RyyArd/3wL6L81SseIQT4GhJscNZJGGQ+Ozj6E5HBWubdlQs2B2YNCaYU0m9UzYI/
         /Epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/YKT1JJIPuRoA7Hx7R8arjPSGFufHSp1KclETKmED4=;
        b=X7XX/EOCfQbmZeg0Dnr/Oq/qtZc2UMRxaFSQwqe3QkjSewv4gcNcx9/zhtqf4O6NCC
         5TXdof5GJh+qAMzcnXAdXnbdMCXFzI63M86OmbMKiaOU5LzGmckqPWsj3/1E2wfoGTZ6
         0EUWuA/YoVD4q5pEXVLsCSdpCzRCWb9i98jVpg4J/+0RSElAyc8A3C0RofvfH0+nh1Wr
         1qymH484eP7hEVVs7qXQqCoJR2G/aWrC5F7VHQKE/Z2i0ULKMDgtsQh5EhNpmkLh12cW
         ABBCp6/CB9TQp85x5Wxxpqma6Ssp7XXc/x8lBJ9yO1/UY5D2+f53ETjF8IBXgvtz+8PC
         t+4Q==
X-Gm-Message-State: ANoB5pmZd8DZ19gwS+zUqY1UYv8o9XrY/sIfcBefOtYazmpidil+Rptn
        Ma29RzfaflyQQaGyNm7EAZs=
X-Google-Smtp-Source: AA0mqf61SP7/nZq9TfSNMMcb4bbYVKQVTkKEFue+8KZXn3Lu9cPuwaVOSuM5ZwGEwLEZzSwFMg1C/A==
X-Received: by 2002:a17:90b:2d83:b0:219:e002:1ba3 with SMTP id sj3-20020a17090b2d8300b00219e0021ba3mr46689926pjb.9.1671481065326;
        Mon, 19 Dec 2022 12:17:45 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:735a:2805:e706:5164])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b00219220edf0dsm6324260pju.48.2022.12.19.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:17:44 -0800 (PST)
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
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: [PATCH 6/6] perf test: Update perf lock contention test
Date:   Mon, 19 Dec 2022 12:17:32 -0800
Message-Id: <20221219201732.460111-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221219201732.460111-1-namhyung@kernel.org>
References: <20221219201732.460111-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add more tests for the new filters.

  $ sudo perf test contention -v
   87: kernel lock contention analysis test                            :
  --- start ---
  test child forked, pid 412379
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  Testing perf lock contention --type-filter
  Testing perf lock contention --lock-filter
  test child finished with 0
  ---- end ----
  kernel lock contention analysis test: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh | 58 ++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index cc9ceb9e19ca..b05f1b1ca6c8 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -115,7 +115,7 @@ test_aggr_addr()
 	fi
 
 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -t -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -l -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
 	if [ $(cat "${result}" | wc -l) != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" $(cat "${result}" | wc -l)
 		err=1
@@ -123,6 +123,60 @@ test_aggr_addr()
 	fi
 }
 
+test_type_filter()
+{
+	echo "Testing perf lock contention --type-filter (w/ spinlock)"
+	perf lock contention -i ${perfdata} -Y spinlock -q 2> ${result}
+	if [ $(grep -c -v spinlock "${result}") != "0" ]; then
+		echo "[Fail] Recorded should not have non-spinlocks:" $(cat "${result}")
+		err=1
+		exit
+	fi
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		return
+	fi
+
+	perf lock con -a -b -Y spinlock -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ $(grep -c -v spinlock "${result}") != "0" ]; then
+		echo "[Fail] Recorded should not have non-spinlocks:" $(cat "${result}")
+		err=1
+		exit
+	fi
+}
+
+test_lock_filter()
+{
+	echo "Testing perf lock contention --lock-filter (w/ tasklist_lock)"
+	perf lock contention -i ${perfdata} -l -q 2> ${result}
+	if [ $(grep -c tasklist_lock "${result}") != "1" ]; then
+		echo "[Skip] Could not find 'tasklist_lock'"
+		return
+	fi
+
+	perf lock contention -i ${perfdata} -L tasklist_lock -q 2> ${result}
+
+	# find out the type of tasklist_lock
+	local type=$(head -1 "${result}" | awk '{ print $8 }' | sed -e 's/:.*//')
+
+	if [ $(grep -c -v "${type}" "${result}") != "0" ]; then
+		echo "[Fail] Recorded should not have non-${type} locks:" $(cat "${result}")
+		err=1
+		exit
+	fi
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		return
+	fi
+
+	perf lock con -a -b -L tasklist_lock -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ $(grep -c -v "${type}" "${result}") != "0" ]; then
+		echo "[Fail] Recorded should not have non-${type} locks:" $(cat "${result}")
+		err=1
+		exit
+	fi
+}
+
 check
 
 test_record
@@ -130,5 +184,7 @@ test_bpf
 test_record_concurrent
 test_aggr_task
 test_aggr_addr
+test_type_filter
+test_lock_filter
 
 exit ${err}
-- 
2.39.0.314.g84b9a713c41-goog

