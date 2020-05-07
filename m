Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64B1C8DE8
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgEGOJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgEGOI5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F559C05BD0F
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z1so3337249ybm.5
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WNLwvCLfBBjUXdSm9htdY2ZIrU9tK5abqhIDyW74dxc=;
        b=biQh+rIPaJjiWmCdpodETgccn4Y8n5FVL+Mpr1MGuwevY0+0SykmjiYjnIyHYQMSBY
         IR4+qgSztOBizqP2lGvsdWjUQzlUnfjxI9lZ8cNpebFxnizLjDTBQQ8NfHsAa93Htouv
         mrQ8GovuR/j5bV1vGV8e9R1zTUZmDbrcjuldLL2/J3s++NkilCKmBluMxqXG2cIbRqEU
         dAq/VoetqTDUKRgLyWw/0o6+WAtaMsG+6YWBCiJvb2V9KMeq3j6eLqL7LV45hnvhutcN
         j1/j0E36THBQDBgTLTFMupBXqIgInb0pLME/AOQ3nEmGnsF+BJe4lZ5MxcqCuUH015zI
         grMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WNLwvCLfBBjUXdSm9htdY2ZIrU9tK5abqhIDyW74dxc=;
        b=mMf2WmHkcrsv5p63W5h3HgpJ73o1jQ61nXdCpMnLgOZKFv1hBFxrOoCHG7vLkzC0ph
         +KK3T26pgYHhKwe4JzOPVKqileUqbXR8Ve2NJPanvuUz7REBVx7oXhb57Odc/kKZauNm
         ZRA5yG73MsLEv0g+u2KoyZdMVIKPrvBav7c4Vo6UmhFCSS6OULOhi0r3ZAcbAzUPFlif
         GbjIlay9p0deDuaWXq03jDqvGR2fCabvs3m+7kvmPUa0pn5FgnvWBoPherDFdxwxYT2p
         4nnxz707k4KHf4CastN52jNIDQLA6BlzOemYCl1kTAmgc8sGw7ojx3vdCHJ6crw5zMMK
         1T8Q==
X-Gm-Message-State: AGi0PuYbtW2RGNFjFGQLSVn9LabsFs5flGAXuuRSE/8hPlVSxp72x5LX
        6lq/5mcrYen754mwApBkPUcdqMb1MSfV
X-Google-Smtp-Source: APiQypK7cb30cBnYwkBB+E9mLL262GSv1zCyE6oU2nAP4RqCHtNPorpKhkR4Mmq+RPtTBEFQtMYEM/rnQiQh
X-Received: by 2002:a25:b951:: with SMTP id s17mr23122292ybm.205.1588860535288;
 Thu, 07 May 2020 07:08:55 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:12 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-17-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 16/23] perf evsel: fix 2 memory leaks
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
index f3e60c45d59a..d5c28e583986 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1268,6 +1268,8 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
+	zfree(&evsel->per_pkg_mask);
+	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
 }
 
-- 
2.26.2.526.g744177e7f7-goog

