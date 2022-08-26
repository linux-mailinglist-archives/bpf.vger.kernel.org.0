Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63A5A2C7A
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbiHZQly (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245014AbiHZQlw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:41:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A826439B9F
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:41:51 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b25-20020aa78119000000b00536a929d8e4so1125944pfi.1
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Rgaq1z5LOjS10FPCONzKodXjmm6pDD9DpzwInFEM770=;
        b=l9z24DGW/UZdaRz4WmYq7mUxmdOhXgs/8B15A1/MyJN9SClrTUIouPNLenH+KPCZBu
         415RaIrka9LtQNEpc+x9hmH1Kp1R7Y8mEWHmqAPgjGcN1tglfllMpXwdpTPuxFL6oDek
         mAljhv1vJOa/dK83ZL1CdKButPmHeTUkVMzvlc3MDd9NV4GSP97sHsDuPmaEPIah/kRN
         YXivVl12NCTK3cAQReRNPck/+6Y6CqeVtDZj+qilg7LhF+v+3iEhZqi9sA06T2vXKFp7
         MUAnRhRWSwAZTZFw7oSHGDEP//a+pMhmbQb4nAFE8y+kfS+NGoFtC9JMfbj3MZChTwpb
         fUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Rgaq1z5LOjS10FPCONzKodXjmm6pDD9DpzwInFEM770=;
        b=PLAmlrPAojlxBnNvbdr68YApKsCQ/KHlbvh1x3MYje7dEDmwymOb0RLZLseSBRbXfp
         ts2vNPts1HAMJpPtgPczPAYpqPSA9EOn5CX8816dyVgmgakjXOcUm47xxfAbYkdQt4Kr
         JPzCTj5Nu37Esinb/dMkshq2giVmnrHWDHP2ctenO1QFOGePFndrYjfw28BJjKjG7AuX
         Fxgw/H/ZrULlUsXpGAtXGDhqb9zZ85Ek9AREOFbYUFhpmdfeVb4j2nKUzT1+tm6xx/Vm
         RLiSwfC2aEseOV/YWNlGr6/iyCncFZ3PbVPc1futxj0Adc/7/SRsYi6Iy10f06Sr9YWu
         oaDg==
X-Gm-Message-State: ACgBeo3A/nBwBM3c2QX0efzvY3XyREp56a/Rjeb/itimkPk/2mCC7Hvk
        C6Y+VKuhzuuoZfe9Md87t62ggeNpbWrr
X-Google-Smtp-Source: AA6agR6ptdzioUCsRnk9xJ0hEpFXIBMIduN02It/wYRD9oRSHsyzjmR3Ps1o0O8uTEDU361DqA3T9lX8qNkV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a17:902:b60e:b0:173:104b:45f7 with SMTP id
 b14-20020a170902b60e00b00173104b45f7mr4326598pls.67.1661532111109; Fri, 26
 Aug 2022 09:41:51 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:40:12 -0700
In-Reply-To: <20220826164027.42929-1-irogers@google.com>
Message-Id: <20220826164027.42929-4-irogers@google.com>
Mime-Version: 1.0
References: <20220826164027.42929-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 03/18] perf tests: Avoid pthread.h inclusion
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pthread.h is being included for the side-effect of getting sched.h and
macros like CPU_CLR. Switch to directly using sched.h, or if that is
already present, just remove the pthread.h inclusion entirely.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c              | 2 --
 tools/perf/tests/openat-syscall-all-cpus.c | 2 +-
 tools/perf/tests/perf-record.c             | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index dfb6173b2a82..21b5e68179d7 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
-/* For the CLR_() macros */
-#include <pthread.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
 
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 90828ae03ef5..f3275be83a33 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -2,7 +2,7 @@
 #include <errno.h>
 #include <inttypes.h>
 /* For the CPU_* macros */
-#include <pthread.h>
+#include <sched.h>
 
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 6a001fcfed68..b386ade9ed06 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -2,8 +2,6 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/string.h>
-/* For the CLR_() macros */
-#include <pthread.h>
 
 #include <sched.h>
 #include <perf/mmap.h>
-- 
2.37.2.672.g94769d06f0-goog

