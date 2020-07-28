Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307382305E8
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgG1I57 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgG1I5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 04:57:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E8C0619D5
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:44 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id f59so128208qtb.22
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DFYUrKFpIGsqAKet90FwgX2FsGowqyT0mwEJnnjHWNY=;
        b=OyTvjnvLbpIimHPXiclMTfFIfKUPFUFkw1lcxkc4I39+aoZzlFU+f488poA0Q5MRSa
         TAPI+lFSlfFBVQmN0l+9WDFhhBdvQZ6fbCTxVJKvH2pKE3XMY6+HHA+ZvRLzV5S+8r/A
         R67IJ2srMRHoRlSZ9VOeq52aNVauxaN+aCl/SOYMLYn5qQul0PzhLWikc2gh4x2R4ZEP
         yJp864D6qwfJaSZxyQY0tDer1lNrui+5uCtCv6Klx2eevn0B/5k+sGBJPMxqDLVMt6LV
         88a/+Q7IX4D4fpMYlgRTb3EkVj93sKEcekI4VoyXnagVk7brPEB7GqlEap5xg6D1+TZb
         SO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DFYUrKFpIGsqAKet90FwgX2FsGowqyT0mwEJnnjHWNY=;
        b=loKxF7MNzRSfOL1Gu1Lt4d0tL+y7N3Q8WrQNxfhkpdmehwgz/sMz3Gnep93gXWhewE
         Y1hsMr0A+5uwgR7R6GpSdTMu7r0USTDYiwPA9mkGs3nVI7uhjHi/kaavKqwxiiEV0C7u
         sjnGgSSHO6+8xtG3WNJ6lFPsGuSplaHT3U/bsod4PAo8B8uupeE9cG46sQlJ0KqpV8S4
         X/7J1WOtXWdsgS1fAhVJ6kWCBL1sLuedqCU41G0fEL1UGP2LhIN1Ty6Z80ZiZi7K8bJH
         NFOrSuujQSUgKwn/cIUNbJ5ws/oUzO4EpSRUDCRXNM6TJagx7XUsnRRfxcyOG0WNqlm/
         dsJQ==
X-Gm-Message-State: AOAM530oMebjy2gcH7+Q+dYF8Wb97PLDT9KRUMPeuvaR9Mfe9BIwJc33
        Bcl1maKCKI5wK+iekh+mmiXhA0VbOOJY
X-Google-Smtp-Source: ABdhPJy6J46x+7pmazKvVxw4jKBznzkMcXfFEf5PRKVEaCFThsy2ZdiL/jc1H/MUh7dl1rvcOZyzk0oHvBkG
X-Received: by 2002:a0c:fd4b:: with SMTP id j11mr9206917qvs.227.1595926663954;
 Tue, 28 Jul 2020 01:57:43 -0700 (PDT)
Date:   Tue, 28 Jul 2020 01:57:33 -0700
In-Reply-To: <20200728085734.609930-1-irogers@google.com>
Message-Id: <20200728085734.609930-5-irogers@google.com>
Mime-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 4/5] perf record: Don't clear event's period if set by a term
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
 tools/perf/util/record.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index a4cc11592f6b..01d1c6c613f7 100644
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
@@ -38,6 +39,9 @@ static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *ev
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
 	struct evsel *read_sampler;
+	struct evsel_config_term *term;
+	struct list_head *config_terms = &evsel->config_terms;
+	int term_types, freq_mask;
 
 	if (!leader->sample_read)
 		return;
@@ -47,16 +51,24 @@ static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *ev
 	if (evsel == read_sampler)
 		return;
 
+	/* Determine the evsel's config term types. */
+	term_types = 0;
+	list_for_each_entry(term, config_terms, list) {
+		term_types |= 1 << term->type;
+	}
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
2.28.0.163.g6104cc2f0b6-goog

