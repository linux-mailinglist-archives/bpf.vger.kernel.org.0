Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6740552CA45
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 05:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiESDUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 23:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiESDUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 23:20:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22156C3C
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 20:20:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fecc57ec14so35478437b3.11
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 20:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vw3KOirpyKTYToukj5eB9PrIoaDLrka25Tzs+xxN/h8=;
        b=Z2zErAYQFBvOZsDLGgCVtdKnayqjrK54AFt8EP2E2Oh158l/ncAdDQG5+nkAH0QlIV
         w7DnPDdy3FXOINVtVZBSOzvkUEgdfz4/+VoRyMyoOLgsr994CrD1CRg/RdsxA/GvT/Hz
         bm+Zf9z8iRcc0HpGKykfpNTndP5y04D6WwiZYddS+fKufM6Lx5V09WN5tsvU1ge+HQzY
         /qhqa3u9ZpQtKhRgjOGtsCLskUfiTO7Em0DfZMhyWFHgyQZhLF2WpF9G8TQvNeRMQtSK
         +CiaQJsSHY3iz9Kx8ES9aAG0WeS3ryGXwQ4Mkd0cqEVT1HYxMXCyp8t5FehS8WYhnB68
         Q8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vw3KOirpyKTYToukj5eB9PrIoaDLrka25Tzs+xxN/h8=;
        b=RqVz4KwdniEZBjI1L0QcPyI54ky7X19k5GwGvjicybPCSnysSidamIsfWy+USG7BQm
         5M8kqsc0ROiYaMX0tJxcpVOSDOykuE6xJSKOOpXCYb1zCMLCnswTyaX9vIGFzcYdstIU
         LC+lNR5mqC9ZPTIobvoPXXs3C4pl3y65zEnebqeNVQQGkMDOYvUMWynVrd+b/maL3A/p
         2bZ9RLRL14KCYjq56aaQGZ4k3e2Kelk3Z0Eew4v9G3HjX4kzmNxx5HuaO0FNIGMN63eU
         oCBBL49mgVX+R7JwIToRl8QFQp1ZFDpWrv4cSef1V9CTo65y1kRoWXfBsGcUNaXEw+7s
         U09g==
X-Gm-Message-State: AOAM5336sFcULafZdIkmPE2ltz4t28/jNuugl3wKacvVHnA2FQj5GFpk
        WOARnw30YFJsexfMoBxBWpUsvVaEQvV+
X-Google-Smtp-Source: ABdhPJyaaIVriNuy73np/4IMrVPFn3NEblefL3EEPUZ7Ayeru4qkvqLGkIUzJ87NJEh8n9bjaM+xtdCjwHRq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a233:bf3c:6ac:2a98])
 (user=irogers job=sendgmr) by 2002:a25:2d67:0:b0:64d:a9b9:4954 with SMTP id
 s39-20020a252d67000000b0064da9b94954mr2547523ybe.5.1652930418306; Wed, 18 May
 2022 20:20:18 -0700 (PDT)
Date:   Wed, 18 May 2022 20:20:03 -0700
In-Reply-To: <20220519032005.1273691-1-irogers@google.com>
Message-Id: <20220519032005.1273691-4-irogers@google.com>
Mime-Version: 1.0
References: <20220519032005.1273691-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 3/5] perf cpumap: Add perf_cpu_map__for_each_idx
From:   Ian Rogers <irogers@google.com>
To:     Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

A variant of perf_cpu_map__for_each_cpu that just iterates index values
without the corresponding load of the CPU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/cpumap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 4a2edbdb5e2b..24de795b09bb 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -31,4 +31,7 @@ LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_c
 	     (idx) < perf_cpu_map__nr(cpus);			\
 	     (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
 
+#define perf_cpu_map__for_each_idx(idx, cpus)				\
+	for ((idx) = 0; (idx) < perf_cpu_map__nr(cpus); (idx)++)
+
 #endif /* __LIBPERF_CPUMAP_H */
-- 
2.36.1.124.g0e6072fb45-goog

