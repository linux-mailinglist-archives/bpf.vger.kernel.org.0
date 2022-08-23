Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF8759EEBB
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiHWWL1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiHWWK7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:10:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527C74DF2
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:10:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33352499223so260379637b3.8
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hI/abfVc/lpVnBGw0/IBypco5YlPGa9tkPSCqJ9uDZQ=;
        b=a0O0YxQ/mlClsh++0Eih5r8XCyQ2PWf4eHqbSAVf87G0uhjjV4kbUziQxWvdsEefYx
         idvXzO4xoEBWQvhOQHdXgIWgRMQZRpCedNhRsfArcBWCTGaYSh2qqeFdSQaL//ZenxmE
         bnx6vifkA68uo0CDX3CQZ+CSynMjQha/1cR514WJafX1myCBmm7/vRQkqn15p4EBevqQ
         f/SGa4Emdng/0J5qRratt4QhRZaPGGIa1R+oZftnBCVr3OWQORW0vGKyEDtPHlVaXJsa
         XzwqISY11EGfxyIVSGnS84xPYIglUGI3DCk12vMe/00OrB/Kzs2cQbbnW06pEvm+TWBu
         GWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hI/abfVc/lpVnBGw0/IBypco5YlPGa9tkPSCqJ9uDZQ=;
        b=vsBDtsyA9F1/aLoQAndH37P11IC5XSHtdJZDEIrTDiTChp2IApH2VMP/gGMxcQLmse
         FSKAcZy9chg5wThA0xbFU0XNEeSMLyXiq5xULAVDZdcLH9fitugt/MWjyM80f6D0bbZn
         AgLOppdqrI7nxGkaKoXOcKAMjAwn4Mo0g2lk714ex0YzJfLJK/TDQfbIvmB94nzgZQdU
         f/Xv+45Dp7KrjRCNls3qyM4FIShR0YRRmZIWwQFVLQ9wOXVwkhrtENJnCEOIh4Ba0Q7v
         u35u9rOl9MCMpVdRLRPeNXLkKg+we+J8awFKHyIT4CDHPeng0j/UmokK2KwvOSNwuuJh
         kZug==
X-Gm-Message-State: ACgBeo3zJi/74XNXDCiM1rJx8cCcokUyqHDiGVuJ0YJyz6W4XhBLoqo2
        1weN4oUmedSrCZD1nfIaqcxR+i/NKZw7
X-Google-Smtp-Source: AA6agR6qFYD5g1FqAqGPVeImurrh/ZkYJjB3EL0kLaZmGTBXEapeVBFxkCQ4lK/axFqO/Hk6hdUZnkE+qyBL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a81:d0d:0:b0:333:99b1:44f1 with SMTP id
 13-20020a810d0d000000b0033399b144f1mr26891746ywn.288.1661292628860; Tue, 23
 Aug 2022 15:10:28 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:14 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-11-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 10/18] perf mmap: Remove unnecessary pthread.h include
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

The comment says it is for cpu_set_t which isn't used in the header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mmap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index cd8b0777473b..cd4ccec7f361 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -9,7 +9,6 @@
 #include <linux/bitops.h>
 #include <perf/cpumap.h>
 #include <stdbool.h>
-#include <pthread.h> // for cpu_set_t
 #ifdef HAVE_AIO_SUPPORT
 #include <aio.h>
 #endif
-- 
2.37.2.609.g9ff673ca1a-goog

