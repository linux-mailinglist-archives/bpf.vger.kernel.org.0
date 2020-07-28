Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384D42305E0
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgG1I5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgG1I5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 04:57:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97DC0619D2
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 7so22003252ybl.5
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nX/1NZr6qGhnB5fWEWRCVFU3/TmZaNj5LyMINF6iah8=;
        b=C4tiQ/JT4wpELCImOIwKNla4CWq4rVq7GmsYOkdbWLzvQnBGSN4ijrmKf5muLUqYz8
         QmG3Ayk33QBbjyPb8paRmHGAXlk/hn8rTu2TrBDgLGf53y3CBIIn3egYYyyp+RfznFcS
         7w1/DVrHHiSuzQSLMyA19FiSV4WSuMIlXwjMuP7HrY2nnYMhRu/Wa4qxV9Ll8rcKj5YX
         00SJozfC5ObsHV1GrOM2Nz0HnrTvx0sFZVhLI2JSDo1ZBaZ/EiEvQRhdJXW2zIfhGPbG
         ZK3CalcCoZpL09BOij3aGTD+Kg+X1MnMthWMyx6FOQjinVuoC35As1iBvJqRZ5zVk561
         Jh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nX/1NZr6qGhnB5fWEWRCVFU3/TmZaNj5LyMINF6iah8=;
        b=RfUFzZn1hxnWwEP5gFKKzHce6USct+ZOpGaM0ZvMMa8mtX6pOMFG7M2J1FQFcqJDSA
         5UVeVhDVPdvVNin9G/AJGNJcIPUdiuo8zQvyi//53BmEPJFUuKDeUX5I9OM8uM89DMnl
         UiHt22xhVaeud7OMzIcArQtOS4HbXgA4atBqcsArTLro4qupufdNyflr0vrBHOKzGbE6
         aWRBnIJRLbSIzsxFzPWXrObDHSzopXYxUC++AdoQ178ktxBCy+qT2dQjqVY75J2YPfP7
         t6MeOfnCWf2u47DRDj65JZ+1bLZ6hMld26SFgS5GAqdiFW8NwyRpxYAtMNr1BwCX75eL
         u0MQ==
X-Gm-Message-State: AOAM530f+eFDbbydES33oH2enxD/4G2wszrKj7OvnwIOH+Sc4w3las++
        kpIIGxa4ICWErQ6NMeYll3dapSZyvurg
X-Google-Smtp-Source: ABdhPJx8NSGF6mLTqzK5ekC5JPY7ACRycIrYng7z5LWrxFWN5dAz7vMCOxEpNCM7jbecgVk7PHTKckyA7kiD
X-Received: by 2002:a25:d745:: with SMTP id o66mr19987184ybg.116.1595926660128;
 Tue, 28 Jul 2020 01:57:40 -0700 (PDT)
Date:   Tue, 28 Jul 2020 01:57:31 -0700
In-Reply-To: <20200728085734.609930-1-irogers@google.com>
Message-Id: <20200728085734.609930-3-irogers@google.com>
Mime-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 2/5] perf record: Prevent override of attr->sample_period
 for libpfm4 events
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

From: Stephane Eranian <eranian@google.com>

Before:
$ perf record -c 10000 --pfm-events=cycles:period=77777

Would yield a cycles event with period=10000, instead of 77777.

This was due to an ordering issue between libpfm4 parsing
the event string and perf record initializing the event.

This patch fixes the problem by preventing override for
events with attr->sample_period != 0 by the time
perf_evsel__config() is invoked. This seems to have been the
intent of the author.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 811f538f7d77..8afc24e2ec52 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -976,8 +976,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 * We default some events to have a default interval. But keep
 	 * it a weak assumption overridable by the user.
 	 */
-	if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
-				     opts->user_interval != ULLONG_MAX)) {
+	if (!attr->sample_period) {
 		if (opts->freq) {
 			attr->freq		= 1;
 			attr->sample_freq	= opts->freq;
-- 
2.28.0.163.g6104cc2f0b6-goog

