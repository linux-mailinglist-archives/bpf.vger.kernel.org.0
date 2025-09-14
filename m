Return-Path: <bpf+bounces-68327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D44B56B0E
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 20:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BED17ADAE
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198052E0B77;
	Sun, 14 Sep 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqyYrMxy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1162E0927
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873502; cv=none; b=ja7WW65/eWVzGleHM2mWd0cKxuZfz6f88LS9XtCzM3pv1ObN2NbbuFWmxikKMJPqQGm+l1OepYFgsB6mfNVd1xghceT8KdfY53B78QHc9ctfjpa/vPjujLxtisqDqNVSuq9H20HnoO+oTc2MsaahUDcv61GpQBsViqJSetPSSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873502; c=relaxed/simple;
	bh=0M7aW9rM47C2xbliRkt1WBQcuZbGSqN6pmVDVEqndoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t0QHMFKS8xMitdNIYnNqHj7FuDkTatWmnTzO4Mymnxh0k/VgD7bwmLhfYXq2GXfm915aFuTV1yqFzMhGDMuyYcEpalz7yW9/9f/70TIrs3i6JclC+WFv2QW0FTqlfBwoaVP3dq3pcuQFfaavz921M97HwnTB8CAfVgcJlXWrOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqyYrMxy; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-81312a26ea3so945656485a.0
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873500; x=1758478300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThdZBfrv8r4vr3+Q/T08HR89wWumtwD0SICjKhnd2P4=;
        b=XqyYrMxyhuK9yBUO/mNfHNF/TIta3GGbCil3QmAR6Ceb6PqbXT86PAOUvLww6KGKso
         Bp5iGeT2t/FEzZlvmM8ijGg0VDhj2olB2QAsogrVb02g4XnzKT5UiFoiTpAq+qtijWMd
         bnb4yBoBXqQ+cPzUhwmlF1OjExbF8SzDTF/QpdpZ4H+vVuOK4GfX8PinC4076kqgM+if
         ePr+oeHXOIUeaKwBLMVIG+gHb9JP3Sf7X795S6zffEyNl+UuECRz6QqTFPNBXwWTeVfy
         78a5e6VG2meKRDymJmVg48qOM29BR1Sp+LE5mjusWeDZoIJmbIfqveTQYlkdglwf6dKB
         /EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873500; x=1758478300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThdZBfrv8r4vr3+Q/T08HR89wWumtwD0SICjKhnd2P4=;
        b=wbLA32u/JBINBQYsDRKAXI6ocju90A+7BtCR6YIaemnPBLimNXfMkFj96nWLijt6ix
         +17lf7Uv7+ysHJ1Utc67KAL9/NIjdUcCeManciIamdq075TYbJRtXSLCxRaoBx6hcaeL
         DGNIpX41xikvSwggKfPSQS/E09hVBkLY1Y6gZwCd+Mrjbx6G8qNcjNPa1PE1fPtOoZBC
         xexYay944a3KSOeH60roUhShqieAM/zJdD2N7pCcFpflJ4HMg8rpjNHJBJ8qB4yNMTWy
         NU7rEKRrF0Gv7Sfc6ESSTAoiQ7XJ35QsdTdKdYZTYly+w6mwe4sHc431hXLa2oDITSg+
         VZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXC6VHU9WhpJFIOiVRct2UGgKgHqT+ZYzcCSu6y1lkRpcb40crFTLIS1V56UJ0qGw8gkTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkjwXr3urQHGh+N6eWJrfvgZPeKcHWqmLW04RmDL4sw5fVDpa
	ttz4/naCyif0cZnKVpsUG+zf1Ivsh+IrLQ8/nAyl1C9Xsy6QK6m7ChVTPOZzuztYs2xgng64Row
	HRK3uHnfFJQ==
X-Google-Smtp-Source: AGHT+IFDwkqSbiN7IYvNr7SaniQ+/COuM/pa6CJNpLEEeITYyqBhgRXpoDtvg1D5B8WAecnwYYWjAOAkjWtQ
X-Received: from qkbdx11.prod.google.com ([2002:a05:620a:608b:b0:80b:4507:33])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:7087:b0:800:c495:48ad
 with SMTP id af79cd13be357-824013d62aemr1229951685a.59.1757873499799; Sun, 14
 Sep 2025 11:11:39 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:07 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-8-irogers@google.com>
Subject: [PATCH v4 07/21] perf pmu: Use fd rather than FILE from new_alias
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

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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
2.51.0.384.g4c02a37b29-goog


