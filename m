Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCE267757
	for <lists+bpf@lfdr.de>; Sat, 12 Sep 2020 04:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgILC5i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 22:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgILC5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 22:57:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0D5C061796
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 19:57:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q2so10905881ybo.5
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S4BaSChoStuXn9hUjRtFrVEEliba+K91i8IvE/c8cWU=;
        b=pbPv6LoTFW9c9cgb1mIWL4TXAnmXnBP3zMCzGQT4KcZ4LkRTO9zyobxhuDAdLt0TLE
         Nf1zhQ2urZmVZga/imCGWFsImzFGhh6+S+JaXaQcSGRYYrxkWL1AqCEbSl7KKx30WL3x
         yhOQc/Qie9pC/KVnW+0U0CiC77suqzpyNuyTROVWMr7I977yEQiJsRYTlZ/w/t4GRHKM
         ctc2pp4bDM95NZAQnaMu/6SrTSGPpk6sEFIZi27286exnQw3qHUd4zxS4cK0dP8K4PCe
         ylkq0AvTJRbEV6nXKPYGWOv358H0PRerHbQOAuA7vrcfOAFxqf3ebJ4BYlcUpRSKSHyh
         6NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S4BaSChoStuXn9hUjRtFrVEEliba+K91i8IvE/c8cWU=;
        b=Al5+on88r8eKF78Ronei8SkAs6PscXFWiYQxBZaii4Vxfz72IoQshpiBQ+eyiIdXqw
         5g+cx8268BH8t6YAH/r7eCxRyxywb+eLltuS16lQIoBi4kHnrayIZ+4x4R96kToqAhXA
         6GkE0AMbe8DZEKCc9WRQlABb5RLb1ob4j6xsNt83b01i2Wt8h/nP/p9KQzKvU8rQsR6q
         1Ccv/0xj4/3niHtavV8kV7u2p4lUgfnxi7PHgys0dKLge43KzoBZfl1ZS5wnIMOmJSAv
         V5nRBdD2H9t5xa6RzYch+E/kooQkd8et/V+zOikJFboenlhMIQBPU7KM+cZ1vSwjl2xp
         jcHQ==
X-Gm-Message-State: AOAM531aQ/iWy0H0J4ajAZH3+XduDHIy9IHmsLxLpEdNyXQaPD2B2XoX
        tDQxafE0BR/8t6mtD24PK/ByzFA4o8ws
X-Google-Smtp-Source: ABdhPJydvl5bZ5owq66oiX1WfPkpW16l0ovIc+lZVj9SuIGZawWsXOZx4KTvhzIJFWyCEUS5CSvNOxz6miJL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:5096:: with SMTP id
 e144mr5872381ybb.32.1599879422845; Fri, 11 Sep 2020 19:57:02 -0700 (PDT)
Date:   Fri, 11 Sep 2020 19:56:54 -0700
In-Reply-To: <20200912025655.1337192-1-irogers@google.com>
Message-Id: <20200912025655.1337192-4-irogers@google.com>
Mime-Version: 1.0
References: <20200912025655.1337192-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v3 3/4] perf record: Don't clear event's period if set by a term
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If events in a group explicitly set a frequency or period with leader
sampling, don't disable the samples on those events.

Prior to 5.8:
perf record -e '{cycles/period=12345000/,instructions/period=6789000/}:S'
would clear the attributes then apply the config terms. In commit
5f34278867b7 leader sampling configuration was moved to after applying the
config terms, in the example, making the instructions' event have its period
cleared.
This change makes it so that sampling is only disabled if configuration
terms aren't present.

Fixes: 5f34278867b7 ("perf evlist: Move leader-sampling configuration")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/record.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index a4cc11592f6b..ea9aa1d7cf50 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -2,6 +2,7 @@
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "evsel_config.h"
 #include "parse-events.h"
 #include <errno.h>
 #include <limits.h>
@@ -33,11 +34,24 @@ static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evl
 	return leader;
 }
 
+static u64 evsel__config_term_mask(struct evsel *evsel)
+{
+	struct evsel_config_term *term;
+	struct list_head *config_terms = &evsel->config_terms;
+	u64 term_types = 0;
+
+	list_for_each_entry(term, config_terms, list) {
+		term_types |= 1 << term->type;
+	}
+	return term_types;
+}
+
 static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *evlist)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
 	struct evsel *read_sampler;
+	u64 term_types, freq_mask;
 
 	if (!leader->sample_read)
 		return;
@@ -47,16 +61,20 @@ static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *ev
 	if (evsel == read_sampler)
 		return;
 
+	term_types = evsel__config_term_mask(evsel);
 	/*
-	 * Disable sampling for all group members other than the leader in
-	 * case the leader 'leads' the sampling, except when the leader is an
-	 * AUX area event, in which case the 2nd event in the group is the one
-	 * that 'leads' the sampling.
+	 * Disable sampling for all group members except those with explicit
+	 * config terms or the leader. In the case of an AUX area event, the 2nd
+	 * event in the group is the one that 'leads' the sampling.
 	 */
-	attr->freq           = 0;
-	attr->sample_freq    = 0;
-	attr->sample_period  = 0;
-	attr->write_backward = 0;
+	freq_mask = (1 << EVSEL__CONFIG_TERM_FREQ) | (1 << EVSEL__CONFIG_TERM_PERIOD);
+	if ((term_types & freq_mask) == 0) {
+		attr->freq           = 0;
+		attr->sample_freq    = 0;
+		attr->sample_period  = 0;
+	}
+	if ((term_types & (1 << EVSEL__CONFIG_TERM_OVERWRITE)) == 0)
+		attr->write_backward = 0;
 
 	/*
 	 * We don't get a sample for slave events, we make them when delivering
-- 
2.28.0.618.gf4bc123cb7-goog

