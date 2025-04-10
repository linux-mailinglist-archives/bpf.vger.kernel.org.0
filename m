Return-Path: <bpf+bounces-55678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FFA84B2C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AFA97AEB75
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6548628FFFE;
	Thu, 10 Apr 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLl9qcOo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D028F95F
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306616; cv=none; b=HbVjd9YwXa9eIPzaSp5CykzPBOkPsIG+1dTlrMbhjSj9N+3KLjwMU+3xh0W5zxbUe2b0ndEPh2zPPztoPzNLfpDcfPjCixIPc70COMrJZMJnjY2FrNgEa9TcYLHBsaoNHsF0cgjNcyg4PtFMx25BFTHaF7fjFF4PKwzG9olV1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306616; c=relaxed/simple;
	bh=adtWm6LLbIn1NEAvhqeF9pcSrgZi/NasO8jt5hVXwak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=h9xKpY/QCgXQPqIkZb9TpBHYRSSMjnOCK6XU3MOwYNU4cQDwhlz+v3Hg5fXBrhIIzpVV6WcoYMqiX/8Jep59vX7NMmaLtRHEMZ5iXnChipk3qruwgw96y6sEAsstBQNgSvejjkTXSpEYUuHWPNKzorqYCwcpYD+kyPSTJzFRyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLl9qcOo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af59547f55bso662604a12.0
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306613; x=1744911413; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJlUHd00POlACtSKnVs2Xq2hei3Qf2bYPIcfv/IAydE=;
        b=mLl9qcOob07t95izV0aZO10hW/pu/fazq1HHNtNDSvMpMfAhLMC/+hLHCmTHGzKODO
         SCatDrWqdO9SeY61MKVT18BnKAx9HhFZ3U+y1tg+Tpm5Bo8zsirvNz1xOTkbZlbfhhpt
         ha4yWlckvhnwhjGGvRyrqjI8C58b1o/AXyu/q6sMTdXQpBy/biN3ws4A2qUmTtn8EH18
         gzL0b3KEYc5BtEDxJp+mjXWtJrsWSVOLWBYFS+nq+UQgMkCCZgmcfwBW3hMqQ/UI5E8X
         c1vGTyTdz0MsZi4fms5o7av1ePIiQmlfLhn9uJ5AmWORf/Lep7Vm0qh/Ci696JDAXdP9
         4RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306613; x=1744911413;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJlUHd00POlACtSKnVs2Xq2hei3Qf2bYPIcfv/IAydE=;
        b=l4qEuRJpDoSlpIwSxKcY1sFM5qf9KonJZBO8q2aO3pvi9D2sz1tLwVCI3Zyjef6M+i
         1EAohI3pKKTF/AR9LrujYkZatl+2o0yetEv9w2o6Y4iAiNgjt1O+oLEYnD7miygoajWL
         aT5AXGag0kwo4ItWpxhdSI3I4PlFi1hcEhTOSn4sHJMIbhFKqFZ6DaV/Cco244GzvRXq
         KYhyk8dcA5WXOH84fb0SLrF3WijaQysAJKjemAJOGW4+XTOHAJx6syUW3Y7AQB/JVUJs
         HcJYO8hFyqh2aoXyrmdeO8nZrHj81FVxrQaRJzY51GC+/zes8GnXf9KTJCaxM+7brdJy
         hOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs7zPhlwJkFHskA/6h0mFSe2aVt1kNEo7VRf1HCH+bLgehE9YEehGqxelaMeWyAyMbGZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrb7wKOIoXCXLfxJRRUl4z5vejagLhvxfhl+Z+416da5rj/e5
	tRdO+71IOJb7vxkEBNYIkrMFgbt7F6z43Mza+aS8yxCmshnR4NAh4iMGLiru8Srx3X/q+rMReMQ
	HHbzU1Q==
X-Google-Smtp-Source: AGHT+IGQm8EhNAjZDoDuAti/4OrUKsoaJ3Ygj5yBP/JzVbozppHAIIUQwLauKHLJyFwsGg53JlS/NHqxxMQX
X-Received: from pjd15.prod.google.com ([2002:a17:90b:54cf:b0:2ff:5344:b54])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a81:b0:2ff:6fc3:79c4
 with SMTP id 98e67ed59e1d1-3072ba14733mr4841179a91.27.1744306613560; Thu, 10
 Apr 2025 10:36:53 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:24 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-6-irogers@google.com>
Subject: [PATCH v2 05/12] perf parse-events: Add parse_uid_filter helper
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
index ad5b40843b18..08ade3d70bc1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2456,6 +2456,12 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
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
@@ -2468,7 +2474,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT && is_possible_tp_filter(str)) {
 		if (evsel__append_tp_filter(evsel, str) < 0) {
 			fprintf(stderr,
 				"not enough memory to hold filter string\n");
@@ -2504,6 +2510,17 @@ int parse_filter(const struct option *opt, const char *str,
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
2.49.0.604.gff1f9ca942-goog


