Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB059EEB4
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiHWWKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiHWWKX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:10:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686E73332
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:10:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334f49979a0so264120487b3.10
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=TZmRLUQ2d7TXmU69l5rNy1CTfW+D1QluUT9t1SCPaRQ=;
        b=XJdlmzgS/G5JBfz64SCGEvKo+qmDECH61tMA+nVEkvkjhvqErPn6we7JRZ3YTRjB9g
         sZBj7cabo5j8BoTz70VIH1o6q4J/BmSbQiX/1GZaCFQbtR4OR6jl27Qcflg0ASIvB2pn
         cXj5qngzepTVIfzGx+7wKUSjI+RWPVw7p6wOSURROtcw0Zz2mRmIVcYW30gyI6oDVuyA
         rBtwoxSBeWs6jGTk64xQrPsqirJPXfAZXGzwIlb3ZDEFqKuf8SnodQ3HfgnJNV6AN+KX
         Tpyp2Bq4TqzFSAROlx6kOHFRjKK0wTDXetElB7AzefGaOTXHAp8BURfCT5TkmiA8+IhR
         /ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=TZmRLUQ2d7TXmU69l5rNy1CTfW+D1QluUT9t1SCPaRQ=;
        b=g+iXaR4x9nH5ZOkt9M6DFujloyskaNrsZudz3SDxJ5OmkjDC36E46Mc98tS505vnM/
         2nhtMywrHhEtqrUq4dHlnbWimNgJfGhJJQHQGcw49mtS7C2ut53SlfQ3lr9LoTm0CA/5
         3d+YyIzaqztvOHr7KCMt9LV53oprn8kjBgcJ9iF79+ku5hstqdlDw2RLW1sIhlsJuIcO
         wkJsTH+DzC9I3silHY2TsUniMZoQ6C2qWsiblu15OrSMZN55zfv8CT2FAztJ3l1uCays
         w3RM+CkbRXBJBoxDEfsVFoKbbnmosXcYD3YT7oo+z89rFIm7TPe9S91SaDT6GOdOQ3bh
         gdHw==
X-Gm-Message-State: ACgBeo39rRp9EWcNc6+Bov5awRjWgemjU8rUHyOH5niJe5U0KHQFTGY0
        mw6Q19mdJ5NVSjjPyp+SgJ5YVUxRW5O9
X-Google-Smtp-Source: AA6agR7a0VTxMqTg4C3l82b1BpKQRn7OO5P4Ch8FMwflD77Z6ASQKHyZ78AkmQHPc0XrIuaejBrso+emaXu2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a25:2493:0:b0:695:839:3a5a with SMTP id
 k141-20020a252493000000b0069508393a5amr21422493ybk.468.1661292605692; Tue, 23
 Aug 2022 15:10:05 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:10 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-7-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 06/18] perf lock: Remove unused pthread.h include
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

No pthread usage in builtin-lock.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index dd11d3471baf..70197c0593b1 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -28,7 +28,6 @@
 #include <sys/types.h>
 #include <sys/prctl.h>
 #include <semaphore.h>
-#include <pthread.h>
 #include <math.h>
 #include <limits.h>
 
-- 
2.37.2.609.g9ff673ca1a-goog

