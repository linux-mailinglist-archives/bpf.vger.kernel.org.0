Return-Path: <bpf+bounces-56739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BDDA9D44B
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29B93BB9C1
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66264227E82;
	Fri, 25 Apr 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdLYba0l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075E229B32
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617232; cv=none; b=sBqYG4oKltH3DItQCGf4IyXKN6hCAra4kwbtvgVlOF+sALq+ECXL/xS6b5JiUvWpqdgH/kQHbmCcZXK6aVznsjAAg7gsyi4HRYBYxOzMcapZD/hIB0wGZmcKtQUGZXQPKZyNCh8CaNfCKgHQsZxGFg9Ti1vT5XYOYAT1jksBu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617232; c=relaxed/simple;
	bh=gbjo4h3GHQFtFeOpJumdcLDVg3ih8INOSDQkXhcieIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GPiKvHxERcw7XDmn+qipO8PSqg6WBaESB7OSYHh1YqLi7wwFX8CvYFu3x7D6sK0bQA5jMTk4MpJJluHa+9sUJg6dAhMwR38sulQZd8HkRmdlJCBsOhj9u7s5ABJUfqAewJldtXzmfU79EY90jfATZnKVhkDR6loddbloSzo5tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdLYba0l; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7369c5ed395so3034598b3a.0
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 14:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617228; x=1746222028; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR45kodXZkA7EQ9UBPLhC24dTzfJslYN2Nb1yPoIsJQ=;
        b=XdLYba0l+X8n6rkMQT8Xj350nyZz6Qg78/3VH2nwTepRw+Kw4qqsq3hFQkZO+ex+Xu
         C59ILn0/o5H8xOA5er286nwcUglG81PHsDEzuFywVNMg/elUx1SLFrFhv46WuL6kTvfP
         CLsQjNFsEy+xdmFLFU/QWdHXa/t9oBAZRXC4DQbL4Tbe0dkvGFN3JK2DfYVT76w3hc+/
         k+rxf3ZfmAPJ0eocXMq5ifELflQpueyMbnUb5Lmc1lku2ZVq/ot3OrjPBfSr8ZJqqOrh
         gUsx2zr7Xn3eJEtwDtCQJys4DkCZ0Ks3YztQ1HKg0nCU8ts+t6zGw2+aftF8/sKuvCer
         tRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617228; x=1746222028;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR45kodXZkA7EQ9UBPLhC24dTzfJslYN2Nb1yPoIsJQ=;
        b=Su3szCHNPYy6H9OUMSrWAbtdLrI6dixAMiQbLOVL3tJbKQxIDOzMgwuuotomb8XkNK
         mVa6FL1mfH1eZO2ygpjAtZub1RWx/QWTmrh27UAbOexHZ2gwZ5z9IxH6pBkdoKTVXTFA
         UWxnX55EgXgJILfY6Ih/GNHA72amMoNRIm3yZ8wC5uJ2NRsvKQBUWlBzRceIJv4QKink
         HEeKyuxzbfdxpHQDcmIqqhXrjgwrbCrB53VkZOxtmIe3yW+lSqzA8i/ZyBtGV5oeJ72L
         1q2pisa9E/gVq9o+XIsx8Xfx/WxIuLeGTcGcgrrSZOF4l769di7CIKR41SzM8O5bvIl5
         PY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKf5+HkB7qkI8XG+FVZIj9vaMFWf9GQmheTIVOmc/QkkxKpZ047zVIkshi75Um0i/L/9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+ZacFAPMFnsnJQ6YuE6oMc/i3g3uuy+Hb9ySc90WT8vrsYOM
	k1NBunBDe8lEHYfVr2d+4e9hRFtA7UZPx/Aem86CjSV/cIMbpOU8OmgZuxTMUJy3MTbSbb/FXXD
	S26DfMA==
X-Google-Smtp-Source: AGHT+IHu6jNsVxg2hinctPs3rIG3x23hifof5G2en1Olm7EYab4lBNXfdy6kgi4Gh069LsoL9yjCAM48VRnS
X-Received: from pgbcl20.prod.google.com ([2002:a05:6a02:994:b0:af2:7bd1:57e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12c4:b0:1ee:ef0b:7bf7
 with SMTP id adf61e73a8af0-2046a57d131mr1026446637.19.1745617227918; Fri, 25
 Apr 2025 14:40:27 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:01 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-4-irogers@google.com>
Subject: [PATCH v3 03/10] perf parse-events: Add parse_uid_filter helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add parse_uid_filter filter as a helper to parse_filter, that
constructs a uid filter string. As uid filters don't work with
tracepoint filters, add a is_possible_tp_filter function so the
tracepoint filter isn't attempted for tracepoint evsels.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 19 ++++++++++++++++++-
 tools/perf/util/parse-events.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2a60ea06d3bc..540864fc597c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2460,6 +2460,12 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
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
@@ -2472,7 +2478,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT && is_possible_tp_filter(str)) {
 		if (evsel__append_tp_filter(evsel, str) < 0) {
 			fprintf(stderr,
 				"not enough memory to hold filter string\n");
@@ -2508,6 +2514,17 @@ int parse_filter(const struct option *opt, const char *str,
 					  (const void *)str);
 }
 
+int parse_uid_filter(struct evlist *evlist, uid_t uid)
+{
+	struct option opt = {
+		.value = &evlist,
+	};
+	char buf[128];
+
+	snprintf(buf, sizeof(buf), "uid == %d", uid);
+	return parse_filter(&opt, buf, /*unset=*/0);
+}
+
 static int add_exclude_perf_filter(struct evsel *evsel,
 				   const void *arg __maybe_unused)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e176a34ab088..289afd42d642 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -45,6 +45,7 @@ static inline int parse_events(struct evlist *evlist, const char *str,
 int parse_event(struct evlist *evlist, const char *str);
 
 int parse_filter(const struct option *opt, const char *str, int unset);
+int parse_uid_filter(struct evlist *evlist, uid_t uid);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
 
 enum parse_events__term_val_type {
-- 
2.49.0.850.g28803427d3-goog


