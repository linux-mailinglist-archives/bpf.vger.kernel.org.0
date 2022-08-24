Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E659FE87
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiHXPkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiHXPkA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:40:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F09A442
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:39:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3345ad926f2so298186807b3.12
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=gT8uGhkPz2QVnzj86f2E281NRyIthHuKkag96DoN/yw=;
        b=U+0X/kZRQHBs+6EtDK9G1mX43K8ZAL3xn0/TBI+PnH4qGB93szqa60OnaP41kr8dzw
         9QxineCg1olwLiYSqDFtsZ/DL3qt5W6eR5TCTrDzlgG3t20vGrl7TtoTaTPJqh4ejp+V
         fOBK2QoavsAeGxc7ZOPJaBPfbn80gRsXO59+l5v0lcwdEKd7o+h2LPa4qhnAKzksgMVp
         ALL9gtkdn2WUP3jETGiY5QAO1PyxVdYdDQa49bK9WeoWn4gACgU7UhjQ1Dlnp3z9npl2
         34gO4ZNZnH69GdlCJG3fu7eOy9UXPpE5LPOovQZYlMf6sex3WDh4WqxhHDj1zxBHDbcA
         ANMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=gT8uGhkPz2QVnzj86f2E281NRyIthHuKkag96DoN/yw=;
        b=qquKktpy73WJ5T5nDACU6FIra4pO+ikTkCkFl0SIYjL35MYKls/dGHlER8Dn3jJCKi
         o3A0gtWu/8oMjZpTMdXv44tHMAMMXt07wvt4cZcBOxoH/sLK7iNaMOb76Rwko0hMTf51
         3gm5nw+V+il3zVZEoD7/r+WEH7L/N1kU/CGRHKJy7yROU19l8KHowv1jq6bfO1jBCwjK
         h9z6BVv6d+gDQZ+Va5S1b7FkmN4CauFe3bUxkKkll55XLxqIEMo2lSFirm70Et6XewZx
         fxdWaJAW4Z4mAPQIMchUxffPMesgvgP6ZyvCf56QPayhzuC96HG7OwYn+JpF057vP6R2
         0iiQ==
X-Gm-Message-State: ACgBeo3Xj8p5IkxMCMtE8RvW2iI6kx38GHeji+RMZX0g7Q9TFP+PSBIP
        7JxKMLNPDv1S2A7G6Bk2bYfGs3fv0bsc
X-Google-Smtp-Source: AA6agR5ogga8EEBaYLPmvldmteYhwwTHUME0yqOv74tlcAU5d3CrXbpxfPBzolFdoMRAia3otbb1SmJYRf3r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:84cd:0:b0:67a:699e:4e84 with SMTP id
 x13-20020a2584cd000000b0067a699e4e84mr27914790ybm.407.1661355595376; Wed, 24
 Aug 2022 08:39:55 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:48 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-6-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 05/18] perf bpf: Remove unused pthread.h include
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
2.37.2.609.g9ff673ca1a-goog

