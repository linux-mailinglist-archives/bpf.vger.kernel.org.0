Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC35A2C96
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbiHZQne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344593AbiHZQnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:43:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9755DFB52
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:43:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33daeaa6b8eso33327807b3.7
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Rgaq1z5LOjS10FPCONzKodXjmm6pDD9DpzwInFEM770=;
        b=nl+Qh97XZk1KJ88OfXW9aPzIUNFMYSiDtZHMv5SvJstTLcntVJ2oztHnY+KiRHT3kT
         kxGubUgo9pIyre3cM28oumxGadAhesrLufKNV1+HtDxEgNUhRpm4iN7xGRfPUl4cu7jk
         ak7a9kqiKgvE60a2HYuzHY/wd6xhkb42GJM+0/6r9Xu9UBtFowN98FQkkedSH/sLywPk
         gd9Z5Iw7DYOeow252llFAVKTfJkJVWPUSR6mW6LXHwnLl2obc6JW8y8d/qAkWUt0IUIL
         Kyv4xDs+CIsRZl65hn6ylB3VKdry3X7THPwDevdSrKWj9BtbykigQ01iMx2KWt//AO0s
         c5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Rgaq1z5LOjS10FPCONzKodXjmm6pDD9DpzwInFEM770=;
        b=ZEfRxAYT34qOwqfsZzy+NECtYmLDHhRoXsFsp3d3KZuNVRjWugeJX6Wlw9Frwhm0My
         QgdQl+7kAj1FYuCi3t3fj7SUd5JwVJlXJQF4PT76o7pCyyn67bzJ0zXu5oE0omBTJuYY
         k8rXlOc09g+VX5eOI9fVZzYafwu/xVcg9Ux76CKM0OTgQEZrtzM/qfV90p2SxpQtQQ5J
         NDCwkh6ZGZBgl5mGvmsQyLTHh4gEDk3yBenEZpjKhJQ4UOtGgnSY4iZ8I+gFu8CvnuH9
         qaPw4ZpTFqIpCPeztOkwQS6PeRWkckpoaeg6MQPb4qsSUzQRCtIJfIcjykleJTsD1IVm
         +G2Q==
X-Gm-Message-State: ACgBeo0c1perSU2KFTHywEYzMHj0WuELH6re0uBNwxIzlQFab0KblLGz
        aPeEbyZlXnVq8lCYseEwSby0UvVh3ZAm
X-Google-Smtp-Source: AA6agR7rr4cAm33WV7u+4zxKPqfDoUFhcdJ/w+TdWr0NJw63hF42lS3uIKi5UTfG/JnaYn5DASu62tOLWAIv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a05:6902:1449:b0:67b:3ea:e49d with SMTP id
 a9-20020a056902144900b0067b03eae49dmr480144ybv.511.1661532194250; Fri, 26 Aug
 2022 09:43:14 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:27 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-4-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
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

