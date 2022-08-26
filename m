Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3A5A2C9E
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbiHZQpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbiHZQoo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:44:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F146DFB54
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:43:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dbfb6d2a3so33516067b3.11
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ACInBWBwNvRh9+ZIkz7xZW+D59fAbxI1HNUoQj5EwTw=;
        b=A0ERzChba5qfQmN7t7ZnM+aWwRGaH2/CrJK4ga0h0ake/rNiQ1IkyR3JmXhJrMT9a2
         KnHqRjX6PAnDpWoIkW8DOomTPRLzc1TyRbC3t+/4APWQ++yOkmcb7vZpIh864xKc8YkK
         TXueOMvwyqUW3p/H3jsDEaZeJ+ManaFKIw162zxrEZglv7KFe53adPbLvLotwONtq3m/
         VkC4OmR/ajX51K4DFiENSlLRlXTjnnPJs3yS3cx54uVvE0IWijCmALy9ppEdFbi335dQ
         oYkX423X1tMjhhM+hPZBMshXdSCABfYwEL8duHu/C0YW0phgba8d6AjJngM2mSDJoJtU
         Qqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ACInBWBwNvRh9+ZIkz7xZW+D59fAbxI1HNUoQj5EwTw=;
        b=fLdSwm5r+fA4TTY8uKW9XsNYgila/Hv7suFjxreIArhTPwPQV+wRBT1mUEBdstfK5p
         X9B2R9GM55gg4t/BWhslQnKqrHWShkiMj+8qF05ddi7SC5JohLY9TGz5Lgv/hodcAYbP
         lQw8CVcfhASgFn42OtXB+zAM105r+0/7LY+gTjNeJX4o8Z8e5x22agpUypXLfqQAvPs9
         yG5jesPXZnj3HABczyru1dwy1Yg6nX+L8Gx6ye+p8a8FwawpeZZjVwC1fZD0MXAKuW4U
         2iLDrrrLO4IrCX3gpBUQsPeRTDI3Wphq5TTcdN1m9u+kln4sdnYZwMK7F+gljZwa6IxO
         /sZA==
X-Gm-Message-State: ACgBeo0qEyhwBoparv2xaamGrcs5hbqXR+0nV/PiB24M0QRw4qKDpK3D
        Se3wsNhxGctClkzGcnu2NEmhMpQditNk
X-Google-Smtp-Source: AA6agR674nFvhyZ8kZZpDZ9P2qEjEXJiLqOtFWE4EU1fMUMemGrNgewnTe7bwqftGS+iFizSaZUFrMd6XEEw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a5b:6c7:0:b0:66e:3713:9929 with SMTP id
 r7-20020a5b06c7000000b0066e37139929mr535950ybq.34.1661532237966; Fri, 26 Aug
 2022 09:43:57 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:30 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-7-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 06/18] perf lock: Remove unused pthread.h include
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
2.37.2.672.g94769d06f0-goog

