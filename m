Return-Path: <bpf+bounces-59667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15658ACE3E5
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B696C1690C3
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EEF201032;
	Wed,  4 Jun 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuSNGJaj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189BE201013
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059165; cv=none; b=Uj6SdLriKGsreXFtpwQeRZjhamlavCpNJq5ZSPMVh1x7/moxdanxLU9J1pX6KmFExLRqUB683lFVoOweMr6o7XVtN1oinBrleICjozY81uHMyNqV96NLDu/UOhXLQXJ024Pwnw+BpmAAf/xz2NFyc7uKZYRANatbFYFxKMGvgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059165; c=relaxed/simple;
	bh=S9utMSb+whrJe0gkOQTuW/1uPCjCRXWgR0gLCJmW1jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WVHH/0Z9G7D0zwrMQKt3ny+qAxWcvA2+vQWa8LFMCaCXWIeY0a1ELb7DAXKtsT4rMCHyOIKksNLwhGx+I1AUQNS4vzHjPRnDi5EZXiJqUQD4AMgrcHkmBehi6QJYlLWkkPRnS2mx+8ft9rCC5/0Pu5SHJ4m3h+Pzvzyn824TFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NuSNGJaj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234a102faa3so598805ad.0
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059163; x=1749663963; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cGGU1BmGlXJ3HaRLeYSvwuRRXCYMA0JWJw6BA2U8Uw=;
        b=NuSNGJajoRQbwMwNS70QJbC8oxVtHXg4NTcTHkAF1987wWQZoe+J0UF3/SPLFLNrpj
         YIXe+xRafzUvrzajF7RTRPJQtI+HKRcOTIax5aYnvT9B43rUc2rh8FWiPujdVSQBL2hH
         HoLT5iiWhVZ9nR7ixaWbr7h3pS93PIwLBwvvUsuAEUZySgbs1CClNxHxFQq3QCOUfdIV
         ec9dxMcGT4uBVR0LuToyxihTaJWvGChgu/SdSzT9L5HumE+m/jOoxduTz0XQzOA6eSBT
         0JRzzRJC9anLy7N/Z5pXfs8B73L9WUPy3TDufsJJyXj/MhYNfPajP4bEDFc3V9wxzXrV
         v/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059163; x=1749663963;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cGGU1BmGlXJ3HaRLeYSvwuRRXCYMA0JWJw6BA2U8Uw=;
        b=mHdIqecLdQTKcCUhv21TTJscEdTbNOOH0fJM+FmHbaWBqTlFR8o9kio5kg1P92lY3W
         L1PruCGLoq//4c2bSZKIhJakeUt63+20gR4JCNIEJ3ddSvOrVuID3ljE6BWOVHRBX0iv
         bA9Cjo3xpCAVLFFeuW4gcqIVNs4/HfIynRiptv/+b+J44lCbiKiWvwXE8fl/pHFydO/b
         xOoJ5C3GFarhKTZ8DaZ6JMEdsDg0c+qw59faPXkvWXWzbarfbgufHD1898tVmfLiFKVX
         BzrLTwWymmRfhymkEzReQe8MJVlZp+zGLzJ/98Rxli/hIEd/1f5nxCHG2FDVR0LnbDhJ
         CGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4kaXPUUNoqrUWnK+xAkb+F5fasHmJlnRxKvVpm1Xkc+CwYUtKRpfJhNEtmr97TQVaz2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwm+p1K9niLo7ZXp68vFOJ0UMwGGlFSh92uFEr6JuvubvjVvXZ
	JLyJW5SS4iFtxMrJd5nUI223wV/iE/77FSXCaSorZmGV6eow8D4LsltTQNoW9gLw/8vb4GA6TLB
	ctW7IkSf0qQ==
X-Google-Smtp-Source: AGHT+IHhRGqORi2SjAeTCWDEHvCnqLh5w62KrOnK8fc8S8eL6+gX+0p9t0Koi7Jd79p+//XZSTY0BOXW1KwQ
X-Received: from pgct1.prod.google.com ([2002:a05:6a02:5281:b0:b2c:3d70:9cd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f92:b0:226:38ff:1d6a
 with SMTP id d9443c01a7336-235e111f38fmr49110935ad.7.1749059163573; Wed, 04
 Jun 2025 10:46:03 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:37 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-4-irogers@google.com>
Subject: [PATCH v4 03/10] perf parse-events: Add parse_uid_filter helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add parse_uid_filter filter as a helper to parse_filter, that
constructs a uid filter string. As uid filters don't work with
tracepoint filters, add a is_possible_tp_filter function so the
tracepoint filter isn't attempted for tracepoint evsels.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 33 ++++++++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d96adf23dc94..7f34e602fc08 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -25,6 +25,7 @@
 #include "pmu.h"
 #include "pmus.h"
 #include "asm/bug.h"
+#include "ui/ui.h"
 #include "util/parse-branch-options.h"
 #include "util/evsel_config.h"
 #include "util/event.h"
@@ -2561,6 +2562,12 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 	return 0;
 }
 
+/* Will a tracepoint filter work for str or should a BPF filter be used? */
+static bool is_possible_tp_filter(const char *str)
+{
+	return strstr(str, "uid") == NULL;
+}
+
 static int set_filter(struct evsel *evsel, const void *arg)
 {
 	const char *str = arg;
@@ -2573,7 +2580,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT && is_possible_tp_filter(str)) {
 		if (evsel__append_tp_filter(evsel, str) < 0) {
 			fprintf(stderr,
 				"not enough memory to hold filter string\n");
@@ -2609,6 +2616,30 @@ int parse_filter(const struct option *opt, const char *str,
 					  (const void *)str);
 }
 
+int parse_uid_filter(struct evlist *evlist, uid_t uid)
+{
+	struct option opt = {
+		.value = &evlist,
+	};
+	char buf[128];
+	int ret;
+
+	snprintf(buf, sizeof(buf), "uid == %d", uid);
+	ret = parse_filter(&opt, buf, /*unset=*/0);
+	if (ret) {
+		if (use_browser >= 1) {
+			/*
+			 * Use ui__warning so a pop up appears above the
+			 * underlying BPF error message.
+			 */
+			ui__warning("Failed to add UID filtering that uses BPF filtering.\n");
+		} else {
+			fprintf(stderr, "Failed to add UID filtering that uses BPF filtering.\n");
+		}
+	}
+	return ret;
+}
+
 static int add_exclude_perf_filter(struct evsel *evsel,
 				   const void *arg __maybe_unused)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index ab242f671031..46e5a01be61c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -45,6 +45,7 @@ static inline int parse_events(struct evlist *evlist, const char *str,
 int parse_event(struct evlist *evlist, const char *str);
 
 int parse_filter(const struct option *opt, const char *str, int unset);
+int parse_uid_filter(struct evlist *evlist, uid_t uid);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
 
 enum parse_events__term_val_type {
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


