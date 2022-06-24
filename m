Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E280F55A4B4
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiFXXNa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 19:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiFXXNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 19:13:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221CA828BE;
        Fri, 24 Jun 2022 16:13:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so4152746pjz.1;
        Fri, 24 Jun 2022 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0OScNlE18HyHUOTZpmKwBxiKtZtKgQ8l+wOWm74zcc=;
        b=C7kKu5Nihc7Y5fIzZY6y7afxmyewZAwzewVdotTbDM0udy0OWhZ57N7cqWE9Cel1WP
         kGjQ5tbZzXFE9hSGrN3Ct1F/Vxmyr23Hug/rM57FIm8kpFFUTKOyQYGQbiloFPjv8hm5
         EBj8HWvkEUCs1vNCo398TLcz6PfV4KKiDXrbPQBh9MXsUfEdiOenmRDd48Mh5YXAnHV9
         CcmPTq25lRT2p34jbZ8Mjbgs9bO1aNzLNOWDrFZlN6u7FxLurf+WOdoHlPDc7ZxBwZ+4
         7pIjssp4pV6yhL0jUbT23OWUnaTVz2suc/Ng4noG9KMFy+lNEuywU287viUm1TzyIF5p
         KovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=e0OScNlE18HyHUOTZpmKwBxiKtZtKgQ8l+wOWm74zcc=;
        b=yKv/2TOLR032rPuifC7jbeWwHVUfBHg6Hg1e68kxxeKWNZ2Z8VEzmgft+5/Rv2U8bd
         /Zk2OCMa66clKoJajLzAezsRlFsUK3PcGDuUsdm4fMmaklfNKr/OYwKdDjT8aXKRbo0A
         0/qx9ktd0bHucvogWaaRwZNKzpRgy0zdW642/2w1pefiEILfBHjhepX6UA/cvrMGoDpY
         S/dT0+GTKSt/xXKjL/+0vpXXIbe0yVjSNg+2rwovus9ru3sAgsHpFgHQXiitINDbZ7p0
         u1/IKEUnRZKQWWOQBfMYscTajJME9JabNW2jq1mbCe1Q0bwp3Rvz7UZIGyDpMrn/VOCh
         CKGg==
X-Gm-Message-State: AJIora/L33t+/iobGIIFuLBrm0Ca60QS/+1/Y6hFWdGlzDzpEcWr7MtF
        +hW769dAyAMFFVbYzquNqsA=
X-Google-Smtp-Source: AGRyM1uoqydzUkflGUJH5vKJEZWZz6YJEGSE7lzVV7BDhDU1LHEzSotNCs+wskxUP+NX2fMmauaXjw==
X-Received: by 2002:a17:902:744c:b0:16a:1850:d055 with SMTP id e12-20020a170902744c00b0016a1850d055mr1434349plt.96.1656112402575;
        Fri, 24 Jun 2022 16:13:22 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:eeb0:3156:8fd:28f6])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b0050dc76281e0sm2242439pfe.186.2022.06.24.16.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:13:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 6/6] perf offcpu: Update offcpu test for child process
Date:   Fri, 24 Jun 2022 16:13:13 -0700
Message-Id: <20220624231313.367909-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220624231313.367909-1-namhyung@kernel.org>
References: <20220624231313.367909-1-namhyung@kernel.org>
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
index 96e0739f7478..611b2d7c779b 100755
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
+  if ! perf report -i ${perfdata} -s comm -q -n -t ';' | \
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
2.37.0.rc0.161.g10f37bed90-goog

