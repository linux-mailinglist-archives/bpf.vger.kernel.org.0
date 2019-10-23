Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FB2E0F67
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2019 02:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfJWAyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 20:54:06 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39584 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbfJWAyG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 20:54:06 -0400
Received: by mail-pg1-f202.google.com with SMTP id m20so13819763pgv.6
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=orKMDyFq0pxDsmp0+soEOe34Z3iGwylS1aF6XcYLmDY=;
        b=dxp56W5QwoEHYr+VvlnDojJFQ2s5Jr00cBo2UlZtUhbLztqDX+v6+mFLiFTmFce6QW
         upwIV8Rb7h9vSzOV5rCKmO/VSgT7BjrhF61lxGDW61AFZDGWzaayL/+597j709GkCi0K
         5rt3aQ2QeeayYfKJQ3lcb0LVh0i6yEutFUwWaWPtq+YPMOwqkW0jf9D83dbFi9F99gdS
         KnF088Q2o6Af0a44MJQKk7o6My2hjCNyEk+VeoK2UfTTar3KkzLwaIUqUh/ZwrY3FsVW
         gMFBtHZ/psrnbjZJJYDvno+NZqro2sxpRd6v2a0VIJ/42OdJaudV25DhgeWP532RlMy7
         ycbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=orKMDyFq0pxDsmp0+soEOe34Z3iGwylS1aF6XcYLmDY=;
        b=QNzJuACCW/yJbC2s1AjwJeGnMjdk/cNbYL7cFxQHOqMNTxv8TPBkqJHdniZi8k+U4B
         VFT3XjI7inghfGLbvSp/XAfkg0bQeqaKgVH7B5rAPRr4tqurKNhwv3L72bK5IB/XX4yY
         uE2/GuuA8tXIQuz7Ol+/LtC8GiFFR70ILiFLspjvFylwkpDFFgeoGe2Zsx9iwU8XnhHg
         nRakgCDc/ybWLH0AETns2oB5FSMyixcIIqpxJDBhW+umLfTtGKcVM0AbCWgPBKg7vcFk
         ugeGMIW9u0xMDhIbdltMrC4P5lFeH4I8jH+txDAxibTR0okBFiNGn42dhL5LcV5E4owH
         GLWg==
X-Gm-Message-State: APjAAAUfj112x/1ytKCsyM+4Ss+0VukVHSQAT4V2jpu76SQTlrc2gBOQ
        IS7YZj3Nz9Ln0mP43K2uyQl6pN7RF7BK
X-Google-Smtp-Source: APXvYqzyVIwLoq+9wyp9C7zURVMoBQyLpOCJQ6F7p/ccsS8pjZFa43S0nRwH0x7KWI+lYdhQ17E8tgEaTCrC
X-Received: by 2002:a63:1904:: with SMTP id z4mr6951997pgl.413.1571792043458;
 Tue, 22 Oct 2019 17:54:03 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:53:30 -0700
In-Reply-To: <20191023005337.196160-1-irogers@google.com>
Message-Id: <20191023005337.196160-3-irogers@google.com>
Mime-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com> <20191023005337.196160-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 2/9] perf tools: splice events onto evlist even on error
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

If event parsing fails the event list is leaked, instead splice the list
onto the out result and let the caller cleanup.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4d42344698b8..a8f8801bd127 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1962,15 +1962,20 @@ int parse_events(struct evlist *evlist, const char *str,
 
 	ret = parse_events__scanner(str, &parse_state, PE_START_EVENTS);
 	perf_pmu__parse_cleanup();
+
+	if (list_empty(&parse_state.list)) {
+		WARN_ONCE(true, "WARNING: event parser found nothing\n");
+		return -1;
+	}
+
+	/*
+	 * Add list to the evlist even with errors to allow callers to clean up.
+	 */
+	perf_evlist__splice_list_tail(evlist, &parse_state.list);
+
 	if (!ret) {
 		struct evsel *last;
 
-		if (list_empty(&parse_state.list)) {
-			WARN_ONCE(true, "WARNING: event parser found nothing\n");
-			return -1;
-		}
-
-		perf_evlist__splice_list_tail(evlist, &parse_state.list);
 		evlist->nr_groups += parse_state.nr_groups;
 		last = evlist__last(evlist);
 		last->cmdline_group_boundary = true;
-- 
2.23.0.866.gb869b98d4c-goog

