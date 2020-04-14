Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588D81A887D
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407802AbgDNSEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 14:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407793AbgDNSEf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 14:04:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9558C061A0E
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 11:04:33 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l40so12871227pjb.8
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zcExPUIjugAT8xV6VI04RQsiRvISnNIvuUHEvy30OPQ=;
        b=HfKnbKOLaWKtekBBcx+Z+GtVfjaSYTroUWjlxilDWDzfmYPSZk59O8SE+IJciqKHVf
         fufD5nAwSCHuU3+8Nxxg/s/6pKui4wWczDXrggZqPcNPcTWtxmoPrw3jhN4ahrroxlXy
         MrjSt7V+nOlvluQhJmfCkWXnsBMT/D0kCvsO5GNndfz3NkrXp0ZuDUN0DJMXqFqmTvwN
         43yX3BZUrkb1FHQ6vAk7WPFfshwyUKDyf8up4vIhhY+hDOqwxiyZaSF7i+ixxPzLJh8x
         1H2GIL6TGwewddo7seRKJLQxyFZqHbj3GzXBxBBM6M9Ik4cIpZGuWrT2jr6sZyYlFSuP
         kJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zcExPUIjugAT8xV6VI04RQsiRvISnNIvuUHEvy30OPQ=;
        b=OdXp7pu9KwKCdZ3xHEyv0j09HeYPjAks0CX+bVcoG7jmAhVPkVoY/TKyI041S9Ya3b
         wIcG9RS6BosLDg9VZAtjTgg2DB0TRDg5syZaRpt9kh5zeimK4VVTJagWOoWWvfGjGDZ2
         bBlCKPP9YJZgy9XymY2No8YkpVi83Jlp0MtTTE4DPFdf5g2KsNKBvvFOEvpXNvZKIuyu
         yYjXxL+/1aejgAF2rqAg7rWG2Js4/JwE04VFZ6pzeyb76S5BFFunxxVw0KDXQ0VzXZOi
         WcIvMB+DnXrEph4og1bH7HQ6iy/+e9zs48Ps8QOjiS5hwQxBMuHtF7SFod3IvDlbQIqH
         nFsA==
X-Gm-Message-State: AGi0Pubre8rpPgXXcdzvH6kNDErJNwx3VehEYWW4/fvHJBs3gF3QAqtO
        O5vFPTcR8a1v+G9PkjLQ76d56oOhul7P
X-Google-Smtp-Source: APiQypIwBsvHhx3R02hzQNaxE1lGw3YgC65YuUTUFdJUC1RhOyxqGP5d1zmwW3NbANczU7EPD8Gh+ukdK6eH
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr1410766pju.169.1586887473287;
 Tue, 14 Apr 2020 11:04:33 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:04:18 -0700
In-Reply-To: <20200414180419.14398-1-irogers@google.com>
Message-Id: <20200414180419.14398-4-irogers@google.com>
Mime-Version: 1.0
References: <20200414180419.14398-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v9 3/4] perf pmu: add perf_pmu__find_by_type helper
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

