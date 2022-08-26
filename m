Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3B5A2C87
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbiHZQm3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbiHZQmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:42:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1683DFB6E
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:42:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3328a211611so33436007b3.5
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=byVpB80TV/x11qGZZj1V9Hbrrk6J+Ff/Bi0KHWzM1Uo=;
        b=W/VJ5rg3aGuizEVj60WkWyRqB0n4EBZUrHEDpDfRWvuCCWoehnJyi3Rk4VJfX4ZUDJ
         I2qBuJe2t5g52IWnleVkrQQz++kvZNpZPyFEgMwfRm+f7sF4VtcbNJOlWZTi6pCehRIr
         WCC5X6P0Vq6ehNJhHIf9a5DEEgCpOc+aebP+RNnyveFmorCqIWQu2kFfiJlYzI6iz7OI
         YYJXu/LyVg+QaqaArBg3BaR+aYN8AWMqgj9/MKglaxPcrCyRkJ9+U2ORELhlXx8IIb21
         2wnW+TFj9uBCL4tTwo7HjI9gvXNizSNw/kSNLvGjfWNm/dqGnCaCebYOMNsO2V7xYT7p
         3SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=byVpB80TV/x11qGZZj1V9Hbrrk6J+Ff/Bi0KHWzM1Uo=;
        b=Ri5Q2vXA6vDU8RtKXz03wea+NUOeXY2f2+pktBokQS8qQFs+bcVffVE5BNcZLh6TPu
         IT2ZRYPQzq9jSYPYLxys/RfbmBaiRBH5wjQKNOVUg5gmdxXBJlWKvvyw6lgZ1eikkN+i
         h+jQ6WYZUWy6LpdQO7bxA3GxK9teoZqfIYAnb9C3SA0p4MdwzJySkAwQQbfm2dYBeW8m
         A7lJg3kdlg4V5OKAs6YqSUA8B7av3xtN+MB+al9iW4EEgfhto819ktCMRnex79ouLjzf
         Vu5gLPGE7gQgvN432ABycfUEkxB6lXS+I7PVt3ReIMQToJMABCoNIdJv7XYvLWqcq1hG
         Z3wA==
X-Gm-Message-State: ACgBeo15Z8jdRyN82G2AovKqlyjabeRfQ8cx93703385ltrqPOFcas5L
        q4t19fhNhc7Llgw5y4+LnjLtDeTx53Yq
X-Google-Smtp-Source: AA6agR6t3Ar57WkibYNIjXdxikxJkwvqy8S0oMCIakUmWXO2vxiyAyZG49JLY3UVp2N9ZoitG2YIlxHWSu8N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:ba90:0:b0:68e:de4c:b2e0 with SMTP id
 s16-20020a25ba90000000b0068ede4cb2e0mr484149ybg.528.1661532132627; Fri, 26
 Aug 2022 09:42:12 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:40:14 -0700
In-Reply-To: <20220826164027.42929-1-irogers@google.com>
Message-Id: <20220826164027.42929-6-irogers@google.com>
Mime-Version: 1.0
References: <20220826164027.42929-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 05/18] perf bpf: Remove unused pthread.h include
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

No pthread usage in bpf-event.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 144a8a24cc69..1bcbd4fb6c66 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -4,7 +4,6 @@
 
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
-#include <pthread.h>
 #include <api/fd/array.h>
 #include <stdio.h>
 
-- 
2.37.2.672.g94769d06f0-goog

