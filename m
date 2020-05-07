Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46671C8DBC
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgEGOIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgEGOIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:41 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9F1C05BD43
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:40 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id c89so6010640qva.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ew1Auf+JJ2L5arU3PyljE3NdvPut2GJPZ3Rkkz6XalQ=;
        b=JJ5GJm9HqdYdzOugzSLtwI9AsSWBWZKzE0tdn+cUIqA3aCKIQZvuruHCGe3GCSg3TK
         tZvjcBl21VXdjWAYumT34XIqMXm5v6nl2ZI+wwoAANrdsjDDO07rP7KzZXuqxVJJF0aG
         /F8asZ5Q2yofy8kEROaHB1fRHDJ2QHdTDfFWrNQ01WMMEm7bH6p1PGxmq7UxTiC12V4b
         dv14eZS1uWivH9QOUP30/IP+hxLeRi8ZpMi3bm90vWdkzzH3ABAws+Gsl7CNpOskAHv2
         0MJnHPB52IfsWjUuEj4zi4PJKtT+Pvu360/5rZcrd8TvM4F9pOhUiFmNhhsvTuRnnv/d
         l6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ew1Auf+JJ2L5arU3PyljE3NdvPut2GJPZ3Rkkz6XalQ=;
        b=EtikIPrXmkmhsd9pj4iVU27DTn6sh8Zpi8KtxrkMrRD68DO1UqC+l28/4IMHjl+q0M
         UZDB/SfrZYlRvw684U5eB4hayPKTjlGNrbyimW415T+Wf5MfJrSCSPJ7ssZqCY5SgMMt
         5jTkbThVQOPAGrz2xzW6rPtlWhnHCRSZTmDknMIF7LsZ98gsBkteabxCo+mdINiq7oec
         ZaD9kbYDl/s8gP5h4FQ6TSwiHCCPnmT3X/nU/tN1IEerZYXvJh0BQrWCNMitdN56LjJm
         K62D1lfpEXoHv/4CyoCPsmKqayDpPQNDV66x2bdQJs0vYYxpeu43E6ISVYC/8heLvG89
         i2pQ==
X-Gm-Message-State: AGi0PuZ0dsHiY+hsyKb2COGk20texC4meR4n48qDLgtO8CySCuITuH4W
        e6V+STmDj5Bgh52LG9Oswnba1FRLSS09
X-Google-Smtp-Source: APiQypJvJKA9NnfhOBmsKSvoOjMdo+d1dPOHMI0HSSVAAH72zsNS1j+NeUQeK4QYwqrfA+9aozSBGliqUofk
X-Received: by 2002:ad4:45ac:: with SMTP id y12mr13426252qvu.227.1588860519436;
 Thu, 07 May 2020 07:08:39 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:04 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-9-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 08/23] perf metrics: fix parse errors in power8 metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        "Paul A . Clarke" <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mismatched parentheses.

Fixes: dd81eafacc52 (perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/powerpc/power8/metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index bffb2d4a6420..fc4aa6c2ddc9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -169,7 +169,7 @@
     },
     {
         "BriefDescription": "Cycles GCT empty where dispatch was held",
-        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL)",
+        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "gct_empty_disp_held_cpi"
     },
-- 
2.26.2.526.g744177e7f7-goog

