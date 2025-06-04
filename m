Return-Path: <bpf+bounces-59670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5DACE3EC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05723176CBD
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13702221F11;
	Wed,  4 Jun 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ygM3e3pH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14714212B28
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059172; cv=none; b=e+T2NoE1dcygw8+PYYwpDChUyO2zDczE6V8mvGIeQ8LweKSJc17rv0bbT/isXcx7nNNE+ZcuN+xMvStw5TF86A7BTO7iPx2E7sPdb1UIhC+QshHBVENUnGYZJ7HwvgPCoMkPAG3OoVnhsokK6ClikRYMpGVPYGA6Dsl5gkmlX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059172; c=relaxed/simple;
	bh=d9juix98O43SIeDaPmSOphkP7ZXR2ZbNDk+z7RkJZkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OTlIOoDyS1fyjLe+M+kKba9INbW58D4DGCpWtRHp4ztSoXJXqbs3uaXpGQdIucL0JV68VEi3ijz5ciqiV1XYcw+xUlJ1Eol9kdIW2gphPu8zVqtPI8woUOi44zPn/hQKsh5l9gW36OFh7agVo1NlzDz8IBocJ4mEWeOVovVs7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ygM3e3pH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-310e7c24158so102715a91.3
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059169; x=1749663969; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAlx8zNG9Ixb3Z/jfW3REJxbhMy4ISbpvyCxG91X8vI=;
        b=ygM3e3pHN/3DbEtIjcwSC1D+jhrnFVW/5+eD3pRX76HA6PBlvfK7Z+gaf2Lzb0BDAh
         qN3aFrfS1x65ka9FLPhy/iM3g/exN7cKupf/91iH3doam+h3EvDWckxZ2nX2cK/q6x3D
         KOjsJqWbYJdAUjZUk2xM+bf+9wKVKYR7nxGUFzQQNJg7ZQGi4tZ7LB1vqQpB2KKu7ueh
         f6pfV8AgLylHxBnDdM4F0h8eh+gPT5Mvl1jQL+Pp8TRQ0OUVWLY/V3DRvwRBkHxwnp6I
         DF/tp26onCW2EO3lCKtf8Z4tYwATno89mSrwb4DL93mVRbXjVGNJZ+1TJBvcxecdp8tC
         mAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059169; x=1749663969;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAlx8zNG9Ixb3Z/jfW3REJxbhMy4ISbpvyCxG91X8vI=;
        b=Wp6XL+TPYSc1PU8Yf7Fvv5p/0stdtY9hIRRF+bvz/ebsWQPaa41Vj6cQbaHcd2DZGr
         4ojm9edN+0gq2VoqLWyAgKuwhuPmGnv/FD/a2OcHRQuddmsBR/rxVKGSxEOSGQ25oaCg
         ojCWV2WeyFV2sDsaDBAKNRtZcqsqM+Jk/Z/I2AwAMqoi74DXn+r6J33n/x0Nd4Ueqx8E
         FDQv2m0/ZXh1uBIoWGpIwWB1zplacnOyWjUiHjnmlEUKl36xnzKYVRQyXAEn9W0+QAl1
         aKggiuHukaFrzesugidRiLDtlwSv7Z3Bt3oZenDx43nnhvWPjPl8vSSOKuiTkUzcJN9o
         WWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKiI4LZa3kbBUw+ummcMCvkTWmVlidG9lPD/5s841StH1Vf90LWqMzSh6/rZW2yZttJVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeXtM5vHN7cXWp9QDkfytOpNgRKe9rtvMyci9ViY7pz6eltEz
	df3Uy6XIpwZx92Iyl1w4VrwJbPMMjw0TbF+z4kFbU1AleRWGzbeXH2+XI/M1ltbIcR16RTXf6wg
	7G7b2/xjTkA==
X-Google-Smtp-Source: AGHT+IHUp4wLf3y4OcqJf4camFo5SZWceEct0rB/6bCOouHb4ABfjjX1omDtqmZJ8nOhmTxqcz04b2Rgomb8
X-Received: from pjbnb5.prod.google.com ([2002:a17:90b:35c5:b0:312:1900:72e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c12:b0:311:eb85:96f0
 with SMTP id 98e67ed59e1d1-3130cd4d794mr5696673a91.29.1749059169329; Wed, 04
 Jun 2025 10:46:09 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:40 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-7-irogers@google.com>
Subject: [PATCH v4 06/10] perf top: Switch user option to use BPF filter
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

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 22 ++++++++++++----------
 tools/perf/util/top.c    |  4 ++--
 tools/perf/util/top.h    |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7b6cde87d2af..051ded5ba9ba 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -643,7 +643,7 @@ static void *display_thread_tui(void *arg)
 	 */
 	evlist__for_each_entry(top->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
-		hists->uid_filter_str = top->record_opts.target.uid_str;
+		hists->uid_filter_str = top->uid_str;
 	}
 
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
@@ -1571,7 +1571,7 @@ int cmd_top(int argc, const char **argv)
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
 	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
-	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
+	OPT_STRING('u', "uid", &top.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
@@ -1762,15 +1762,17 @@ int cmd_top(int argc, const char **argv)
 		ui__warning("%s\n", errbuf);
 	}
 
-	status = target__parse_uid(target);
-	if (status) {
-		int saved_errno = errno;
-
-		target__strerror(target, status, errbuf, BUFSIZ);
-		ui__error("%s\n", errbuf);
+	if (top.uid_str) {
+		uid_t uid = parse_uid(top.uid_str);
 
-		status = -saved_errno;
-		goto out_delete_evlist;
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", top.uid_str);
+			status = -EINVAL;
+			goto out_delete_evlist;
+		}
+		status = parse_uid_filter(top.evlist, uid);
+		if (status)
+			goto out_delete_evlist;
 	}
 
 	if (target__none(target))
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 4db3d1bd686c..b06e10a116bb 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -88,9 +88,9 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	else if (target->tid)
 		ret += SNPRINTF(bf + ret, size - ret, " (target_tid: %s",
 				target->tid);
-	else if (target->uid_str != NULL)
+	else if (top->uid_str != NULL)
 		ret += SNPRINTF(bf + ret, size - ret, " (uid: %s",
-				target->uid_str);
+				top->uid_str);
 	else
 		ret += SNPRINTF(bf + ret, size - ret, " (all");
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 4c5588dbb131..04ff926846be 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -48,6 +48,7 @@ struct perf_top {
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
+	const char	   *uid_str;
 
 	struct {
 		struct ordered_events	*in;
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


