Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5C5906CD
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 21:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiHKSzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 14:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiHKSzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 14:55:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4459F0DF;
        Thu, 11 Aug 2022 11:55:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y1so12059669plb.2;
        Thu, 11 Aug 2022 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=A5A/jLi0WcII7JTh+ce1YUU4pX6WGLPaKY+QG9OJx+Y=;
        b=hSSvWCNT0mhtq5O8MW2RmbvXGefSAXmpNlzwEDir3msLd9VqFSyHBJnZfsZyzyA8TP
         oI+IIHJ5eIk5JofkBZuHDXKypYnccBMkYgJDAZqAGCxueTUp4InMZr2TKRzunMuu+TIW
         RnwKy42VNe3x1Y+AjS+0oPHfMFSKRlI/wOzf4/NkRehJTVPyw0vuk14J5vFqsHJ5ygvA
         WDc+6/TT+nOXvbtGJ/+6KSYkyjSUlE2/B+HuoyfU9h+plgocawo1YprSOxrZO5HmYNfh
         z+ccZFeQkqnKMdifvu+eGPgQKrYslJi5cWUWKYsC8+FhDZIuvuT0Qql1aa1H6moUnLdL
         MijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=A5A/jLi0WcII7JTh+ce1YUU4pX6WGLPaKY+QG9OJx+Y=;
        b=3Y5GCm3vMeOxN0EFQzl3SbH5TZHURZ75iR8/78+mVx4GVjsTCPBNn83oAp0aW6MNBl
         UyQKF/wm7hkm1iwcX39AcV9iDtoJD5C9D6T1n5fltOoR8N7c0QqSW6M2OV8xByYU3pSM
         5IAv9esnm2SNhrdUibHaIHpiNY0Yihqns5iLlm5wfaoN+jXd/eNQAhL5jU5nydd10w7+
         uqZLLpc4CbJ7pc6VAmcidNwxu3K55mgCfYFhRh/FDWLp9asA1lfasZR76htTQjzNGJ1W
         HPi6OY9lXGD5iqq+IR1C8I2KqwhoyWcG/NsbVsKGzqxx8ojrZJ8CfejlUok6eCtWKyTP
         3dIw==
X-Gm-Message-State: ACgBeo0qi+63sWnOetGv4G3MV9sa6yr7VcktxRaWXf7hWa6pbPidjBcn
        GqZAsyGhEZBVGd85caoWB6M=
X-Google-Smtp-Source: AA6agR4i2jONflU/i+NZC+0uurdYePRiA7PI9bX3pNhfGJJCx1FdcYBFLY8rq3Qn/qIm5DAsOQJPeA==
X-Received: by 2002:a17:902:e84d:b0:16d:c9a0:e502 with SMTP id t13-20020a170902e84d00b0016dc9a0e502mr529747plg.125.1660244108465;
        Thu, 11 Aug 2022 11:55:08 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cefb:475d:dd6d:a1e2])
        by smtp.gmail.com with ESMTPSA id r12-20020a6560cc000000b0041975999455sm66314pgv.75.2022.08.11.11.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:55:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Blake Jones <blakejones@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org
Subject: [PATCH 4/4] perf offcpu: Update offcpu test for child process
Date:   Thu, 11 Aug 2022 11:54:56 -0700
Message-Id: <20220811185456.194721-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220811185456.194721-1-namhyung@kernel.org>
References: <20220811185456.194721-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Record off-cpu data with perf bench sched messaging workload and count
the number of offcpu-time events.  Also update the test script not to
run next tests if failed already and revise the error messages.

  $ sudo ./perf test offcpu -v
   88: perf record offcpu profiling tests                              :
  --- start ---
  test child forked, pid 344780
  Checking off-cpu privilege
  Basic off-cpu test
  Basic off-cpu test [Success]
  Child task off-cpu test
  Child task off-cpu test [Success]
  test child finished with 0
  ---- end ----
  perf record offcpu profiling tests: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_offcpu.sh | 57 ++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 96e0739f7478..d2eba583a2ac 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -19,20 +19,26 @@ trap_cleanup() {
 }
 trap trap_cleanup exit term int
 
-test_offcpu() {
-  echo "Basic off-cpu test"
+test_offcpu_priv() {
+  echo "Checking off-cpu privilege"
+
   if [ `id -u` != 0 ]
   then
-    echo "Basic off-cpu test [Skipped permission]"
+    echo "off-cpu test [Skipped permission]"
     err=2
     return
   fi
-  if perf record --off-cpu -o ${perfdata} --quiet true 2>&1 | grep BUILD_BPF_SKEL
+  if perf record --off-cpu -o /dev/null --quiet true 2>&1 | grep BUILD_BPF_SKEL
   then
-    echo "Basic off-cpu test [Skipped missing BPF support]"
+    echo "off-cpu test [Skipped missing BPF support]"
     err=2
     return
   fi
+}
+
+test_offcpu_basic() {
+  echo "Basic off-cpu test"
+
   if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
   then
     echo "Basic off-cpu test [Failed record]"
@@ -41,7 +47,7 @@ test_offcpu() {
   fi
   if ! perf evlist -i ${perfdata} | grep -q "offcpu-time"
   then
-    echo "Basic off-cpu test [Failed record]"
+    echo "Basic off-cpu test [Failed no event]"
     err=1
     return
   fi
@@ -54,7 +60,44 @@ test_offcpu() {
   echo "Basic off-cpu test [Success]"
 }
 
-test_offcpu
+test_offcpu_child() {
+  echo "Child task off-cpu test"
+
+  # perf bench sched messaging creates 400 processes
+  if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
+    perf bench sched messaging -g 10 > /dev/null 2&>1
+  then
+    echo "Child task off-cpu test [Failed record]"
+    err=1
+    return
+  fi
+  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time"
+  then
+    echo "Child task off-cpu test [Failed no event]"
+    err=1
+    return
+  fi
+  # each process waits for read and write, so it should be more than 800 events
+  if ! perf report -i ${perfdata} -s comm -q -n -t ';' --percent-limit=90 | \
+    awk -F ";" '{ if (NF > 3 && int($3) < 800) exit 1; }'
+  then
+    echo "Child task off-cpu test [Failed invalid output]"
+    err=1
+    return
+  fi
+  echo "Child task off-cpu test [Success]"
+}
+
+
+test_offcpu_priv
+
+if [ $err = 0 ]; then
+  test_offcpu_basic
+fi
+
+if [ $err = 0 ]; then
+  test_offcpu_child
+fi
 
 cleanup
 exit $err
-- 
2.37.1.595.g718a3a8f04-goog

