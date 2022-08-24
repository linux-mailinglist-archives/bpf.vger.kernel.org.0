Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3959FE8F
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiHXPki (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiHXPke (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:40:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF473B97F
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-335420c7bfeso297808207b3.16
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hI/abfVc/lpVnBGw0/IBypco5YlPGa9tkPSCqJ9uDZQ=;
        b=K4WvIteHQst8sUIrt3X5+g4N8dsRBlJV60qYviWW+eMsHJ+U/ObLuAAap2dexoauAb
         s/UA7XKXWt2EJTsFv88NSfbk5guMt0c5q5JOTx6MfYaYYcf/JzEwWUR2c6H+xVuUl0mi
         LeACmtO26T4rGZeLzGlY9R3O8EtizzsRGrN3nafORfohlOQTfaOhqbujhjdYDOORZzyF
         R0dPZN41uT2mVMwX1fACOC7ci7/hlz95LNTad6coKPZjT+JPrntiM46wRlqqjd4+jJyq
         C+1IuWl04hjzAowCHFH9FYl2KediyaQVj8gybEHlxXAEY763BVn9NSLKYbYOAjzheTEi
         fuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hI/abfVc/lpVnBGw0/IBypco5YlPGa9tkPSCqJ9uDZQ=;
        b=2ytevEku22W0Dz3dVssohi/Qes0Yl55zqh6QnQtvrzkwbqGZrYGReLjcPde5ioRxjB
         d3eCt7Km4fK+Qwly56uYnaLA3hvrg+Z8+nu70PM1x9o7emngKtH0g4TkCYlmAXvcKb2n
         S0pBMT3h/llAfZ6P2qCI/jRQ7czqeD6gRoU3ZUrt2z3v9Kq6Qb9RgJ/3Ndii3viiXFzb
         GOu0RwFBYP8ExuKsIovvRaKFTT+wSkD/gvfR+ULhl/9m99ipnLS0PE88vnZXgUhon6QS
         Q0YMxnU+mTrR0jv0gVPsrnQEp+H/y7WoDd4mjJPfBSf0k2tIh5vCTmH1eehU437FPxm9
         d+vg==
X-Gm-Message-State: ACgBeo1/xcID8ylebYlGJHxM39a0LikpmOQyRwGPDk4If0jPRe7L+hbe
        ZLzlF9PlfKX0weK71RbpVrcdBJRQ1uUs
X-Google-Smtp-Source: AA6agR5amzTbKyhRl0hgVmQH85dfCOg717/9dh29bBkhIeffqhKeAJVU23zxWfna7TU9km3Q8eUuILFDgFkW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a05:6902:1101:b0:695:ce92:a857 with SMTP
 id o1-20020a056902110100b00695ce92a857mr12311995ybu.337.1661355628312; Wed,
 24 Aug 2022 08:40:28 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:53 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-11-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 10/18] perf mmap: Remove unnecessary pthread.h include
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

