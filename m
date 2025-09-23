Return-Path: <bpf+bounces-69329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B5B94308
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DFE480361
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB942848B1;
	Tue, 23 Sep 2025 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JF14p8xy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988392820A4
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601148; cv=none; b=VUg4hZgciHE/Dl005OAIk75Kl1SCrGtrSwIO1FybWKrvuD+AShlnzmxNPr1mffMY9JJFNmfM8WN8USgd7FJ65fWTnDneP1qfz9fuWecFJb3mGFE/h+C9i5zSbGF3/arU0aSwICB5OO1v7qSkILFlX23/xE3wv5ijXtH3Q6MwBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601148; c=relaxed/simple;
	bh=A7ME6lBRxNDqwUqz8g1s1XDCmohN7azXW8DlDooqfI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YukJr2zOHqKnwEkiS9GRbPUPvJZEt4LOBm0nVGXcN7pZqIT9Ys5RE9LWJWoSAyraChRpWSFT7bWq748JkzDFCA+Qy/fS5BoqLs/+w0kyeQEl37otkmqFgt+47u+h9AhI6u4BoPrZYQ3710nPGg7LyiUOkDe76jbCkU/dGjHH7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JF14p8xy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27c62320f16so7959385ad.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601146; x=1759205946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmM+YDTHkakrcbqR3dL1OE9HXiYEwJsKu0xmPObyyj0=;
        b=JF14p8xyheuRbFWQ4/8pHNNYGwepOIx3zAtZ2KQ8uos8JUGrgoCcBsKNUxQDhnYwct
         h9Wsce+VNjqxxmtBusgv4YxIH3oTmgXmC6yJGXeGkcatXqy0Pfr5baXTmMEbRSy/qFxc
         N+joTeJeZcOjKkkYbLRiTszxrZPwTAPpcY4fnNKzgxgrWF7rvl3mibpcqpp0osQi0gXp
         qk+WFuVqHJusLSdL0IMVPlKBOJ3EorEWew2nmQpMc2/fSs5OD+BC8FYiLZn71QnbDmpX
         vi1ZhDi/omoksDZ7T/jjyztch5qz1rv17fQC8TJzgmi95a9PjL6H9o1s/wdlEFaXvYpG
         ErGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601146; x=1759205946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmM+YDTHkakrcbqR3dL1OE9HXiYEwJsKu0xmPObyyj0=;
        b=Rnvr53ylMkRuwOWWboMshXS47+5eqrKgy9PkrP4F4emFKXZZMcO/hY5IdpDl5WpkvB
         gHPZbpGyVJu/Os1C4ZFwkMMf58NCWRjfdxIQJdiAwrECWARHpIWeTjBm2aTlhJqeDipw
         r68p6yT2B5mulx/C0eTIjhfZlNJCIxL8ocuglBP95uMgFNeQuFA00VtGf1gyNpTi8YHZ
         OrDJrwiJrAapWbreFlCiBiUE4EumJ1O1xgXugpyu0ELWNHNHqHNT+0o+eugcdPRp/5NP
         py4zNfRA+L8lsmxR6xEC+mcD8nx3lzjEdNWiUDrs+wWoEQiwEx+L6tRPZhtpUvCAsySh
         Dr2w==
X-Forwarded-Encrypted: i=1; AJvYcCWS9Jxyk7ODDbsh/sAiaxO+2jbypEW8taoHoyByjZ6wuJnOuq7w5QyUVhm8N9jmTmTF6vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjtdegUcJzTqI9AUVYvfEkjt2m1/HkI1I4l6+tN64Fdthm77X
	v3ZdID2KzbW76VMz87ycvbiL3FLk98bv7sYLky5huC3Sus5Moi8tiXTu3Jw8N5D722dsVkScttx
	cVlIAd2Mq3A==
X-Google-Smtp-Source: AGHT+IFbh1jkZfZ2v/I9g7Flj1gfah00Au8YTQI4DY9zWwtoBXbQPLmiSsrhR7z1uJsUQorfbOMfPRzfa5SM
X-Received: from plmd22.prod.google.com ([2002:a17:903:ed6:b0:268:cfa:6a80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea05:b0:245:f7f3:6760
 with SMTP id d9443c01a7336-27cc9d715c8mr14002435ad.55.1758601145907; Mon, 22
 Sep 2025 21:19:05 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:27 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-9-irogers@google.com>
Subject: [PATCH v5 08/25] perf pmu: Use fd rather than FILE from new_alias
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The FILE argument was necessary for the scanner but now that
functionality is not being used we can switch to just using
io__getline which should cut down on stdio buffer usage.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b44dfe4c73fc..818be59db2c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -563,7 +563,7 @@ static int update_alias(const struct pmu_event *pe,
 }
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-				const char *desc, const char *val, FILE *val_fd,
+				const char *desc, const char *val, int val_fd,
 			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias, *old_alias;
@@ -614,12 +614,15 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (ret)
 		return ret;
 
-	if (!val_fd) {
+	if (val_fd < 0) {
 		alias->terms = strdup(val);
 	} else {
+		char buf[256];
+		struct io io;
 		size_t line_len;
 
-		ret = getline(&alias->terms, &line_len, val_fd) < 0 ? -errno : 0;
+		io__init(&io, val_fd, buf, sizeof(buf));
+		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
 		if (ret) {
 			pr_err("Failed to read alias %s\n", name);
 			return ret;
@@ -698,7 +701,6 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
-		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
@@ -714,17 +716,12 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 			pr_debug("Cannot open %s\n", name);
 			continue;
 		}
-		file = fdopen(fd, "r");
-		if (!file) {
-			close(fd);
-			continue;
-		}
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, file, /*pe=*/ NULL,
+					/*val=*/ NULL, fd, /*pe=*/ NULL,
 					EVENT_SRC_SYSFS) < 0)
 			pr_debug("Cannot set up %s\n", name);
-		fclose(file);
+		close(fd);
 	}
 
 	pmu->sysfs_aliases_loaded = true;
@@ -1041,7 +1038,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ -1,
 			    pe, EVENT_SRC_CPU_JSON);
 	return 0;
 }
@@ -1090,7 +1087,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				pe->name,
 				pe->desc,
 				pe->event,
-				/*val_fd=*/ NULL,
+				/*val_fd=*/ -1,
 				pe,
 				EVENT_SRC_SYS_JSON);
 	}
-- 
2.51.0.534.gc79095c0ca-goog


