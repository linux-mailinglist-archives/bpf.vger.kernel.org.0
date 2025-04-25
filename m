Return-Path: <bpf+bounces-56744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A892DA9D452
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A911C00071
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703AA23D2BA;
	Fri, 25 Apr 2025 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGn4dgkt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1637226534
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617240; cv=none; b=RRc74zvI9FTFDzMfyvtTbQ8lz44vrpRyDiaCIdoaqBgoSQC8uryhJbKj4NallvEHl1k/Hb+0eOvPTTTGxd9oFCsg8clXEpcXJOQKqsG2OLXHXaLugzFhW2/v+jUsUMVCHYR2txwgp1X6KsvxNZsgEksROhUdfhtc9NdjM20a7EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617240; c=relaxed/simple;
	bh=7sThGMlojj0XQSMAaSSVxq437bh+PNtW6kO4Ul7euls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DpmB4YYksxnGhhfsSRVkjBGq+/YO1lsjnO5ZzqamWrBbtaoDTwanUeJ1wvXku+O8rDTYcghQN64pmLW0XbmpJcfcJSrcVCBMCWL6TkcWVpawoqRY+q2pbfEEKIDhkdle64ODNtt21BQnV8jagA/KhXjg4r27k/dfI1vyjbMbg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGn4dgkt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a7aceeaso29044945ad.0
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617238; x=1746222038; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYA6AZWIK6CayNWad0cBpPxgIziApDLZVOpF/REdjOE=;
        b=zGn4dgktwNXhplfOwpqchbYpMGquja7NDLdf4FQOUjdDoUDjrwyXBulA4QXoKacZTu
         /Bxw/+j90PIGx1PksymkxeEQU2c5TWniLfp1AIyNq7a9fQ3kkem6DSmWAysP62b5FYHk
         /qbp6BGR4U804kBbyda0Fy8zuFCl0Xo3lYDzTgDTOatP/mvKBYtD++zfC2YK9HovMd6A
         CHQct2z/P6Pqx51IIhr77tCCFX4JlnwQP1qjqZ9Zw2qLB0+XdldHcUXSJcK4vOq30bdf
         qG/QWIuR534EGzClep6gwWx1RfeYzYpUidbkqlDNBiuEEu5veXOfcJWa80lXq75EnoPk
         JgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617238; x=1746222038;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYA6AZWIK6CayNWad0cBpPxgIziApDLZVOpF/REdjOE=;
        b=arAbEPMIS9NQaiIbZum4UTOKg8zyeWO4tDmlGcXObgDo5/BRaxT4aAQvfSBa+Hu+NA
         C9AM5WaGlU1ZKhAdMbgWqbEGO6/kdXlWmZGMWlUNymN447MubcuvWyf7FYleI3aHnb5R
         XsLRjhV3xgdw0T+wlLAdIs3ugiMzPZiYXBOISpDAzI7+k8DHSCXt158FB6oa5/ntI1Tw
         Cii18ZnvMI3mT5b/6rwRq9H3r4Eq6An+yW+dlCRXEIKNllIF1DfW9rrsUgcMMQXIMXJn
         kWrrACMbx/i6b1kdNPb2hmxijtx9X5TYNWTQYqQwzjTPO7Dah8Q3Eb98v+ycDlQFNZRu
         RlOg==
X-Forwarded-Encrypted: i=1; AJvYcCVYsTKvVFeAlJQfJdHDtxF+Mq6tswNyN/lZKme07SX04HmIEOzZOfJJ3byF1QznK/N9/L8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IT8Gk2+pLVce3ueZFUe3CRJKK3wC4k+FVMp8iQwDyChl/nvl
	1EgBdXJk1NJuRuwqs0jGWCKgQ5wq5UjcBKcbksCQNAdE1bSsBYcgBfZTyUJYg8JJXUTUMMcJqm5
	WcPrlxQ==
X-Google-Smtp-Source: AGHT+IHTn5fXSVdxAGo0X1DREGkpHKj96NGB51yKJovIJ4pGCfpCEajtmcoknpGd2yTacuIeqaEDrGQ2lHTV
X-Received: from pgc23.prod.google.com ([2002:a05:6a02:2f97:b0:b0b:2032:ef98])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60e:b0:224:c47:cb7
 with SMTP id d9443c01a7336-22dc6809c39mr18556825ad.0.1745617238005; Fri, 25
 Apr 2025 14:40:38 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:06 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-9-irogers@google.com>
Subject: [PATCH v3 08/10] perf bench evlist-open-close: Switch user option to
 use BPF filter
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

The existing --uid option finds user processes by scanning
/proc. Scanning /proc is inherently racy due to processes being in
/proc but then exiting before perf does the perf_event_open. When the
perf_event_open fails perf will terminate reporting errors which is a
disappointing user experience. Scanning /proc when perf starts also
cannot inform perf of new user processes starting.

The ability to filter perf events with BPF isn't new, and has been in
the perf tool for 10 years:
https://lore.kernel.org/all/1444826502-49291-8-git-send-email-wangnan0@huawei.com/
An ability to do filtering on the command line with a BPF program
that's part of perf was added 2 years ago:
https://lore.kernel.org/all/20230314234237.3008956-1-namhyung@kernel.org/
This was then extended to support uids as a way of filtering:
https://lore.kernel.org/all/20240524205227.244375-1-irogers@google.com/

This change switches the benchmark's --uid option to use the BPF
filter code to avoid the inherent race and existing failures.

Using BPF has permission issues in loading the BPF program not present
in scanning /proc. As the scanning approach would miss new programs
and fail due to the race, this is considered preferable. The change
also avoids opening a perf event per PID, which is less overhead in
the kernel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/evlist-open-close.c | 36 ++++++++++++++++------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 79cedcf94a39..bfaf50e4e519 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -57,7 +57,7 @@ static int evlist__count_evsel_fds(struct evlist *evlist)
 	return cnt;
 }
 
-static struct evlist *bench__create_evlist(char *evstr)
+static struct evlist *bench__create_evlist(char *evstr, const char *uid_str)
 {
 	struct parse_events_error err;
 	struct evlist *evlist = evlist__new();
@@ -78,6 +78,18 @@ static struct evlist *bench__create_evlist(char *evstr)
 		goto out_delete_evlist;
 	}
 	parse_events_error__exit(&err);
+	if (uid_str) {
+		uid_t uid = parse_uid(uid_str);
+
+		if (uid == UINT_MAX) {
+			pr_err("Invalid User: %s", uid_str);
+			ret = -EINVAL;
+			goto out_delete_evlist;
+		}
+		ret = parse_uid_filter(evlist, uid);
+		if (ret)
+			goto out_delete_evlist;
+	}
 	ret = evlist__create_maps(evlist, &opts.target);
 	if (ret < 0) {
 		pr_err("Not enough memory to create thread/cpu maps\n");
@@ -117,10 +129,10 @@ static int bench__do_evlist_open_close(struct evlist *evlist)
 	return 0;
 }
 
-static int bench_evlist_open_close__run(char *evstr)
+static int bench_evlist_open_close__run(char *evstr, const char *uid_str)
 {
 	// used to print statistics only
-	struct evlist *evlist = bench__create_evlist(evstr);
+	struct evlist *evlist = bench__create_evlist(evstr, uid_str);
 	double time_average, time_stddev;
 	struct timeval start, end, diff;
 	struct stats time_stats;
@@ -142,7 +154,7 @@ static int bench_evlist_open_close__run(char *evstr)
 
 	for (i = 0; i < iterations; i++) {
 		pr_debug("Started iteration %d\n", i);
-		evlist = bench__create_evlist(evstr);
+		evlist = bench__create_evlist(evstr, uid_str);
 		if (!evlist)
 			return -ENOMEM;
 
@@ -206,6 +218,7 @@ static char *bench__repeat_event_string(const char *evstr, int n)
 
 int bench_evlist_open_close(int argc, const char **argv)
 {
+	const char *uid_str = NULL;
 	const struct option options[] = {
 		OPT_STRING('e', "event", &event_string, "event",
 			   "event selector. use 'perf list' to list available events"),
@@ -221,7 +234,7 @@ int bench_evlist_open_close(int argc, const char **argv)
 			   "record events on existing process id"),
 		OPT_STRING('t', "tid", &opts.target.tid, "tid",
 			   "record events on existing thread id"),
-		OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
+		OPT_STRING('u', "uid", &uid_str, "user", "user to profile"),
 		OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
 		OPT_END()
 	};
@@ -245,15 +258,8 @@ int bench_evlist_open_close(int argc, const char **argv)
 		goto out;
 	}
 
-	err = target__parse_uid(&opts.target);
-	if (err) {
-		target__strerror(&opts.target, err, errbuf, sizeof(errbuf));
-		pr_err("%s", errbuf);
-		goto out;
-	}
-
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	opts.ignore_missing_thread = opts.target.uid != UINT_MAX || opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	opts.ignore_missing_thread = opts.target.pid;
 
 	evstr = bench__repeat_event_string(event_string, nr_events);
 	if (!evstr) {
@@ -261,7 +267,7 @@ int bench_evlist_open_close(int argc, const char **argv)
 		goto out;
 	}
 
-	err = bench_evlist_open_close__run(evstr);
+	err = bench_evlist_open_close__run(evstr, uid_str);
 
 	free(evstr);
 out:
-- 
2.49.0.850.g28803427d3-goog


