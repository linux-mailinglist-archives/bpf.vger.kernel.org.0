Return-Path: <bpf+bounces-66852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25307B3A66E
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E88166627
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16C335BC4;
	Thu, 28 Aug 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvNRYI0Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB9334701
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398777; cv=none; b=GAZN/7Ck78YyB3u7q4WjAs7mL91nYeOjiJTIEMFLGDy4vUJDmC7dPZSSL+fOH7eE7R7vVcg/V2nVkaP4KnbhnBCDRxoszS5OvcWKoB0jTuguui14V/qsl4Fx+6KfxrFftABRGLTQM29JwL0/h0omunyYMHANWaLO2/wy+grfO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398777; c=relaxed/simple;
	bh=6M/n0XXHy2hGdhKMTu56srwq5hUKw+WlCrLmyUaBgBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=G1FLvDiPydOKgd1AKwtVL+lswXa+LobflhIAhNtkygJS1Ueg5mrCC6LVW7d1PqV2ulDZ6Q+Swo/IDNAd+aPPxSglchZ281uHlycJyah4WHLQqYavB70NAlXJDVaELur328NwOZdUmPUtn+E+xMCfVxh2khtpgmXupGeFSM1f2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvNRYI0Z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e8ae86ab3so1122121b3a.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398775; x=1757003575; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjkFycRsxbrAmO7Lh8J7FZ1U8pAgbkvfTh4/hV23zuQ=;
        b=QvNRYI0ZC/0wO/WnEbPNCeqDFyEsXkZOb+him849jS1H/f40X5t704IaqDBWlcj9fO
         sqte+XS/B7MPO714c4Ux1OnvpD1abAXVkd0XZZsl5PTTYH7nxbd7aOTdfAFsekM84Dov
         owamItiK3iXNCkuMzGdQZhgpYxeb9jNBzlgNruCv+yMPKoA6imEnSxOCNiTPg8fxPGAm
         pFzUZZViZysMuKbqUfwLzvz1psDQS4RcBD/WDeYW2WvmNQ09Tt7sGapwrXuaLmQdPSa0
         WulKxa9hXTLCm+N+Fz+XF1AZq2pPgVRrKzdHKI2JARwSdl4MoZ8rcub9QaF4aHK0xqmZ
         iuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398775; x=1757003575;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjkFycRsxbrAmO7Lh8J7FZ1U8pAgbkvfTh4/hV23zuQ=;
        b=uBqdmLhEHx3k0/+YuJjuzdLC4hMG8K9u5M799gxiICsLs2ShO21iNeFeX0kAoojngO
         TpAWu7zntc1aTjDFjYIQN55y70KSjXo0U9TW73+8UcgbxFVDzoB2yQIQ+UIse4IP6RM6
         x2Zzg7EmHtV1g4YjYBCRe3DiUSS+qYWc6/umzc+Q70l2Q3QBsdYM2G/SI1ymmuBcp60E
         ndRoaGWbC/Q+LfouHsGbACOdHL2sOD99dJDDYct2290ugDSiVfdvvfTGGMKAaLRWToM6
         trsjpFmR+ugRmZYysoBRfesOVr8eoB5tEO0CzDGNWMlw35ZZ9d+CoFveRFzCLVc0ziNT
         6kkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP3fQboIBPVX/zB2f8XTz+EfXK+kH2LlrA7HRnVv4rtGAZdS/sVhMKsr58oDoJKZ+XsmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCnSs77zdbaD0Nebksdeo9cNVmNbSy+6v7atzTNSChifMurXn
	UyeW7GMe+INPjR8ry81HbQJ8PdFR4ehfaNw/wtrmDf+bIhOF6+wMFLnJzuh1MUcID+peGakj3OP
	kf6qu9q90yQ==
X-Google-Smtp-Source: AGHT+IHsORvyv0TAh48JbXi0leWOjxBlRQSmMto8Dly4W3Ugo+rL4wp5kP4AihEkB4OcOtD2hM0G2rEgzmcF
X-Received: from pfbij10.prod.google.com ([2002:a05:6a00:8cca:b0:76b:c5af:cd3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3bdd:b0:76b:ffd1:7728
 with SMTP id d2e1a72fcca58-7702faac8c2mr30462374b3a.17.1756398774677; Thu, 28
 Aug 2025 09:32:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:17 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-8-irogers@google.com>
Subject: [PATCH v2 07/15] perf pmu: Use fd rather than FILE from new_alias
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
Content-Type: text/plain; charset="UTF-8"

The FILE argument was necessary for the scanner but now that
functionality is not being used we can switch to just using
io__getline which should cut down on stdio buffer usage.

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
2.51.0.268.g9569e192d0-goog


