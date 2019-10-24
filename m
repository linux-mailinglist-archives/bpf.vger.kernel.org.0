Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3FE3B93
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 21:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504245AbfJXTCO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 15:02:14 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35742 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504252AbfJXTCN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 15:02:13 -0400
Received: by mail-pl1-f202.google.com with SMTP id p14so4278782plq.2
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Suz77OvPj2zse3ACt5ant97LgHIFhYaDbP1x2fdJ/qM=;
        b=Wkf8kLJ4doKtpDHeS4YU4TeKPlVTfPSlzjZQVy1btaihCSxnPHRIiRgaYjanl9P/EF
         /q2/E00TfLxsXDm/qzdA9a90yTBbb4/qddYpb3gRT+yWd3NYuySaiZEjPyPrlD+qwJnh
         ANjOJIs44qf0VigeqJ0knHNu8zN4Bk7UjWqyTwfi0PIYQ1MakLNQBqVMXSki2O7vGllK
         zoy4uAsMMdUrMmpy3X1PSF5M5hqlJ7h7Lwnxz2FkFR5Zqo5zq5Moch8/UhO+6JebGqiw
         gLr47wVdPLeyBXMXulgt1YMfEazJvE3eTrKUZDf4ihGyJCdJUS4yRSlXZzyWAKrXJGSE
         LNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Suz77OvPj2zse3ACt5ant97LgHIFhYaDbP1x2fdJ/qM=;
        b=Sc4C6ise9/GcdhgpMvEpIh8CgfoZnNvgJkuvZbwuEjM0yUQTsQHZHaIObk0Re87dbV
         YsPc3v3PKLJbr/wfSjd9X7WoRRTwBEluwGBSxtG5+ZtF4yohqbfYV8AJUHlFQ8cqLbiQ
         VmCu2kx6BP79uy+N9VUvxcXoVHc6ODAPSK/8+Jw/Y7tR82aA65+nh4V2yYqLS9c1Y+Cq
         cnzNzJe3dEF4Yrbw423U/JYLNKCLllIk0Z9Z+KTwDmiQspZ0A1frZjAr94IHU0fdSXFe
         ATayTMhRIN2bf37+Ee8TdCHmVrS0QVQE2LRJ5XMeJWTyZ0nu34msYTV0nQP6PQz9ThYJ
         iveg==
X-Gm-Message-State: APjAAAU3v14PJt8DgAn8WdPNmgcWDRA/IgDVv+E1KfEtwcbNKgxsuaMN
        TdhMvH0q2R+Zzz8WmWx0mxUrZHL7JwxK
X-Google-Smtp-Source: APXvYqzE0YLcEtfJD5+y6FsT1a6u7MmXUky94H8cSOwI2hLGViFXlxCW8maOBgQEx701pR+olbLa+qMoDtVo
X-Received: by 2002:a63:748:: with SMTP id 69mr18596734pgh.109.1571943732499;
 Thu, 24 Oct 2019 12:02:12 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:01:55 -0700
In-Reply-To: <20191024190202.109403-1-irogers@google.com>
Message-Id: <20191024190202.109403-3-irogers@google.com>
Mime-Version: 1.0
References: <20191023005337.196160-1-irogers@google.com> <20191024190202.109403-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v3 2/9] perf tools: splice events onto evlist even on error
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

An example input for parse_events found by libFuzzer that reproduces
this memory leak is 'm{'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index edb3ae76777d..f0d50f079d2f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1968,15 +1968,20 @@ int parse_events(struct evlist *evlist, const char *str,
 
 	ret = parse_events__scanner(str, &parse_state, PE_START_EVENTS);
 	perf_pmu__parse_cleanup();
+
+	if (!ret && list_empty(&parse_state.list)) {
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

