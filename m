Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100A9EA65B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 23:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfJ3Wfk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 18:35:40 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55285 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfJ3WfP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 18:35:15 -0400
Received: by mail-pf1-f202.google.com with SMTP id 2so2865305pfv.21
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2019 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n/kunXFB8a17/1SeufduY2AZP1in+T/Iq/GsFxRYzfY=;
        b=l05WTTftzkwYenk8bVJ16EaTRciLaUtMqRbwlXpBBRfNqUlrXbXG4d2kZVDod0qRT1
         QemSRI2R6pFqjC4xssA9CHv+kG/6uajvIMIsjgW+UAtcEE4Igy3skTCMlF98kAlD8Izb
         aQFaGZAijkQJNO1Kct0mO3IvLAquBqnGS9p01Ule3gft9yLkTaoAXn/+i9HLvlrXiDXI
         u3Z04Nw2FArAfEpqco3sOzW8OPJQt/OzNTRjyUjfjB/x4IQDvX3Z3QhuwAQ6TGeM6klG
         cFo5rdzhOyrSoDwt6GgcM3h6jfLO92wn/vckvlNJab9Bx1/4qg41pEkmJkobejSh+9hE
         xzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n/kunXFB8a17/1SeufduY2AZP1in+T/Iq/GsFxRYzfY=;
        b=acA8xSp5VzVWD9JNLyiuAkcWI3REz4+m7OYVcEWFB+DsM1eRpo71dCZqvYRBvoAO/G
         v+lNUd/h67lMHRl8/UdXCEB8xKMJVLJqtCTNFg1rDJg3ylmgwwZyuq0/J/A7lwOM6jse
         bFlcGCFL+ZEDcIneilX1t10TJlpCb0naYZUZLGO4Czqcl1CXvjW6U7EfJbct4/gLKXsf
         LyVKtyah90TGtLWVrE93/HcUUl6mw7lf2AGSYb6oYDDBNn5pzHwDn+/kicYObFY8IMRV
         jo5jOzvIpUKzBLWkC/9njVa3N9XDQizRMLuZKW5/wAY6a1euypHBw07QcGSueXnC3V36
         BX5Q==
X-Gm-Message-State: APjAAAXSwF10k1qIOk91MpUzl5DR92gspmpZbyaMd+iWWNinqZreUW/J
        HAtqvj990Op3aj3pDWmzwav107kjpsii
X-Google-Smtp-Source: APXvYqyUXDTP+AZ2NyPn5itLqJLExzhTopKCQLn1yYFozbb1JDl/bquUPF6RFStOo1v+cOvusy5TPWMDPE6z
X-Received: by 2002:a63:4b52:: with SMTP id k18mr1971001pgl.394.1572474914325;
 Wed, 30 Oct 2019 15:35:14 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:34:46 -0700
In-Reply-To: <20191030223448.12930-1-irogers@google.com>
Message-Id: <20191030223448.12930-9-irogers@google.com>
Mime-Version: 1.0
References: <20191025180827.191916-1-irogers@google.com> <20191030223448.12930-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 08/10] perf tools: if pmu configuration fails free terms
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
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Avoid a memory leak when the configuration fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 578288c94d2a..a0a80f4e7038 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1388,8 +1388,15 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (get_config_terms(head_config, &config_terms))
 		return -ENOMEM;
 
-	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error))
+	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
+		struct perf_evsel_config_term *pos, *tmp;
+
+		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
+			list_del_init(&pos->list);
+			free(pos);
+		}
 		return -EINVAL;
+	}
 
 	evsel = __add_event(list, &parse_state->idx, &attr,
 			    get_config_name(head_config), pmu,
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

