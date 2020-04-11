Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634661A4EB3
	for <lists+bpf@lfdr.de>; Sat, 11 Apr 2020 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDKHqp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Apr 2020 03:46:45 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:53397 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgDKHqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Apr 2020 03:46:44 -0400
Received: by mail-vk1-f201.google.com with SMTP id f7so1799752vkb.20
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2020 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zcExPUIjugAT8xV6VI04RQsiRvISnNIvuUHEvy30OPQ=;
        b=gN5THPgQ/fpJjbjdfm/DtZmGGZ/YxXeX5eHtxk0f3/rFbnOANFfeIoQnQSVI3UkfjQ
         5Imq87vxYTgB9xn8E0IKF0ggj5+U2VjE6cgEy401TKWR2vPKi8QMZWixCcF5iwu9cnrH
         KmXp1/1HTKK44jL7Dtj91zNzlPO2fi5SaUjLglV7VKi9PNFus0sk53zxMCJ+gx7wBG/T
         dyh5RaZ2dyaOJBdQZ/9W24ViN+NG9JyL9ydWFrdETIfjH1qli5ELMdFtJ2a3S855sgGL
         6o5kfULhnlDICCw1eOspbcssIour1zV+3Nkc1L2dvDRR2cvJls9sUK7th8kp44wXCalh
         xqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zcExPUIjugAT8xV6VI04RQsiRvISnNIvuUHEvy30OPQ=;
        b=hdMZKBdcWHIE2ZVFzWeKImCY/WBxiBs1nTn5MdznEmiXER/rFsbsAoqlu2/CBxK/gO
         mpoL38NyshrNOsQbveLU9vxp8VdQsWMzj8xuaakGBjRZTovE/pMWvEzv8Q35fa+iH9I7
         ZRWmVeQWlqT0PyKCVZCJ0QpdO50DL9e2HMJzmouIBvYwUDl5mcgZEk1ouPfmLEFP6K6I
         3PX952FBkOgGzubwRQEQL05sjS6ZWmypVjk0lrKUUwKUcDpQgG//nCATj3DJ2n4yg+yw
         1cRG0fy6oHUjyupBu/svuJPrjPBUOYN+ibX+zM/blp+y3LbRKQCqOcSxV98a1PzkOsUh
         gPHA==
X-Gm-Message-State: AGi0PuaxuPXYjtvSqFqU2Hx1yoq8eqSebWsNu2V9BXktUHVt81cOap1X
        1oAwDcWGvWcgUU2krE3E0y7D4Hrqjxrb
X-Google-Smtp-Source: APiQypImZSRUUORCHahNEP79ULeU/nb+UVUBKDbs/ut7gZYU6ovENqVB9DHRCzNRDbaHmMXWpz9QLadczaxA
X-Received: by 2002:ab0:2248:: with SMTP id z8mr5770783uan.13.1586591203783;
 Sat, 11 Apr 2020 00:46:43 -0700 (PDT)
Date:   Sat, 11 Apr 2020 00:46:30 -0700
In-Reply-To: <20200411074631.9486-1-irogers@google.com>
Message-Id: <20200411074631.9486-4-irogers@google.com>
Mime-Version: 1.0
References: <20200411074631.9486-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v8 3/4] perf pmu: add perf_pmu__find_by_type helper
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
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

This is used by libpfm4 during event parsing to locate the pmu for an
event.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 11 +++++++++++
 tools/perf/util/pmu.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ef6a63f3d386..5e918ca740c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -869,6 +869,17 @@ static struct perf_pmu *pmu_find(const char *name)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu;
+
+	list_for_each_entry(pmu, &pmus, list)
+		if (pmu->type == type)
+			return pmu;
+
+	return NULL;
+}
+
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 {
 	/*
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5fb3f16828df..de3b868d912c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -65,6 +65,7 @@ struct perf_pmu_alias {
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
+struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-- 
2.26.0.110.g2183baf09c-goog

