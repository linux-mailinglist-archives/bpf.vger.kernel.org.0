Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3A1CA2D6
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 07:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgEHFgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 01:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgEHFgp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 01:36:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6D3C05BD0B
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 22:36:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d35so619132qtc.20
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 22:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C6LPLmrigRmdQi0c0CotlbbH7zK9/A+DlS6KBijVebI=;
        b=ZqcU//g/tDoNUk+BflT6oxVRhwFNlxaecUArUJq7b6DIuYviS1zPB63htx7eezcWnv
         mjpi256rFmlq5dECrbtjNuAo6W7/9W97qRDhWvk/nKbZeZYpsO+co+M5QF/9mUbppg48
         XVfHhlowBOs3xPub9CpxW8VQpZvurmYGpmzyFjYP6PXjdUNUSJjdYiVK16CmocfntkYk
         JUT3A/QV3R67vbvQsIEnGOQ8aj8juzWJ7sVOsPuY0Fvb02PNZirKIl2PmOLAUK93sHD/
         AD+d2efAnrJLmjgIxB6FUgkBXgPtdQv89cIqHhLsKdrA9woImewcPZ9LUMgB91xGexb4
         LzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C6LPLmrigRmdQi0c0CotlbbH7zK9/A+DlS6KBijVebI=;
        b=dDzyd1sIOJQsTBts5SlnURgpdfvT73v36/0h5LCR7wUd7W6/IoSw2EpvVL9Jh30E9G
         Vlmt5/RYPFHL7FvlHsN2RXn/0oGacydW8e0rNZoox4ei/E6WVAGr9SYmC1WEoohYCfbn
         yBYdDlaF748a1Hs9CpISfmWKFheN8tepZ2y4kn2QlJBn5mwMRd5ft+XU1UOAfbwMyt7h
         DL9ZTxFMThuE2uekiQe6L/RJ5S9TA8PvEAn2OzhvwWD+gmQjXmgPW4MtdbaI+CO2latl
         XYqxUqjgr+ciOH5ZgvB/5ulqCR+ZlVicFQWNCd5mvV0r6VO2TBKH6ASgMcR3ne7QheKC
         XHBg==
X-Gm-Message-State: AGi0PuayUv5Ilb9qVFZb4eAzw+ZfcWFKdyhESoyzcBFMfpFPyabgjBDi
        D3H6IW6NbrJ537TCd2K3cnKOi8tLCoFZ
X-Google-Smtp-Source: APiQypLZE8PW098KJogxnKU36FARCXl5qZ1knKN1SvWTLokDiLZbnoxoqjzSzj0//cKKJgd7zzWKn8WkT9tp
X-Received: by 2002:a05:6214:1462:: with SMTP id c2mr1086669qvy.202.1588916204234;
 Thu, 07 May 2020 22:36:44 -0700 (PDT)
Date:   Thu,  7 May 2020 22:36:21 -0700
In-Reply-To: <20200508053629.210324-1-irogers@google.com>
Message-Id: <20200508053629.210324-7-irogers@google.com>
Mime-Version: 1.0
References: <20200508053629.210324-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [RFC PATCH v3 06/14] perf evsel: fix 2 memory leaks
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
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If allocated, perf_pkg_mask and metric_events need freeing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 28683b0eb738..05bb46baad6a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1263,6 +1263,8 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
+	zfree(&evsel->per_pkg_mask);
+	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
 }
 
-- 
2.26.2.645.ge9eca65c58-goog

