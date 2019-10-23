Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AEE0F79
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2019 02:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbfJWAyc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 20:54:32 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50524 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733141AbfJWAyV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 20:54:21 -0400
Received: by mail-pg1-f201.google.com with SMTP id r24so13799956pgj.17
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SBGZ2h3aJPS5SN0EQWSYu3r6PtBuafsgvwZrw927JEs=;
        b=ACzNOSjhSAZYiamU7+gIegPI+Q1tGEcVzOclcAta24FXA9bzre55G4jhXY4B3F/EOS
         QjXmegl3BtNi5CgWf0hg2RZOQ2b+hcfinMpmKHoXdCIjh5lbkoObioutFrR5TpzlGrOo
         GP6655uAvHe+yP1LlBKwQqzL0KsohokW/xV73/Wd/RGAtEXTl+a9YHAfpNU/Ne1cH8jc
         VwLRUe4ne6QB5+uskSqKMaTV7rNuhHDLUBhr+IIv4Ywo2id29V7e4aOQ4oR0Hky7wSD4
         y0bFFjYGzE6UcfyibUpAfmWf4HWqy1hZoJL62SZ7mpwM5AHN6TflHqfk8y0ynM6upPMB
         5HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SBGZ2h3aJPS5SN0EQWSYu3r6PtBuafsgvwZrw927JEs=;
        b=gbxd7gvh8cESGsNHdoaZD9RdQHcvIh+QQ4Zjqr4Uub/UHxs1uzyLLiq8hoLoTk6vHZ
         pHkcHc5OZIwGT9h87+gYtYqPtIW3XgPVtnSkLDBVaRyKPrkThOdOaUzhNrGYmYZ67QUt
         eUSBim3FXkIKVIIhsDnZ7/tfS9IduqdAhgwszXkHI9/rYqo6NDW+wAwMLTDrIg8YvNnw
         0ZO+QmhZYsiWMy0v5WLG8CDYjA8AODNJ4feAMydZ97soysjDY6BfBz4kO7r90yMvP2Eu
         TC9XeVQYamUkoK1G0uaitbRIGB1OXZSMHjTK9xPGr4wRypPpBERDoHPndX3xlTz/DfRh
         AXQQ==
X-Gm-Message-State: APjAAAX/MGsB9jLY/uITABEVRLYR0E/IC27LuYHjKJ5WO6R2YEcJRcSg
        H2AzczUK7iZg/vL40aNVFO2T6LCPqnSN
X-Google-Smtp-Source: APXvYqx2sTqLsUkmI521OZWxpQAAgcxz8e7uQh+AaUBQ+LvndCn6I2uaUNv4az8+K0JxYSw1RKpnpAIXu+7r
X-Received: by 2002:a63:fa4a:: with SMTP id g10mr6658099pgk.432.1571792059764;
 Tue, 22 Oct 2019 17:54:19 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:53:36 -0700
In-Reply-To: <20191023005337.196160-1-irogers@google.com>
Message-Id: <20191023005337.196160-9-irogers@google.com>
Mime-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com> <20191023005337.196160-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 8/9] perf tools: if pmu configuration fails free terms
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
index f7c8d0853d71..6bf64b3767cc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1400,8 +1400,15 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
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
2.23.0.866.gb869b98d4c-goog

