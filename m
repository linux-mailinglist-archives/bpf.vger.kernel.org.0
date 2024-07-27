Return-Path: <bpf+bounces-35897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D87893FBC2
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FE6B245E3
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7E189F42;
	Mon, 29 Jul 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="si/D5Nw5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10577188CDF
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271578; cv=none; b=l7NCb8WfCA4MFretpdRKSKFT2BcY6pIagmbCNqmjxS//gAX6FxkjZ81obR7igDXsXytAsqVsRQbotFFnjnpavAVvcdfOUwKjOYaS8Nr6nl/X0eavEnxaFUSjGYXAJ0io53c3it8GP1N/THNJy0lhtg1UsiuRVi8W3Pc9pLkcdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271578; c=relaxed/simple;
	bh=etOVA7exvPfFTzoKY8Fso7Jdm7CkckVi5SBT4zKGBQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXF9vSl1O392BLPPllfABiKE2LnjCtPyLGhy3zQNUSZTzZG6qsH1xAbhPbjvC7+fcPc5SmScwU+ebZyjuFDM8lmEkJVL9J2pOwxWHlVYevv5CHI79U+gimvdoGofeVzpXvzU8rAicCw6vmC5/iRHRfUmHfSIOLfP6amJ76peSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=si/D5Nw5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd66cddd07so21148295ad.2
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271576; x=1722876376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiJ7fM85IMGMjgBBVYYw2ZNteCJKvpwjrHE2P481mUM=;
        b=si/D5Nw5bXzZWCnofDgsL7pgSb1ARcMF2ZLz8CGawwrDXFSeujISVWosTh1pWrwwgi
         Y5SLPzHYOEIbdm8DA56jrh2iGxIy6gr3J2fi0DQDhUy6/pugFDg4pRZa/QTstt2prcE5
         1LELcbFNQy+dBWO1/Os5CFWfOjRP5TKdzcpZ529TX7PxotrQhoMTnew07+/LzswPEdPp
         R2woQPlsInLrY1WJEbLfM1a8zBltJ8OLvwN2QFP5q+Mi7BJJOoLNN1qI/2M7EPs6a7hj
         +frRa4BkHh1Ngzw7N+CKCdEpoSyoKMDbavgj9LT9b8+vWUj/YuQE1DQrlZYpua2wSmrF
         TwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271576; x=1722876376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiJ7fM85IMGMjgBBVYYw2ZNteCJKvpwjrHE2P481mUM=;
        b=cN5mbeK9kbUwsUnQuQpzVDkWrVS9a0eYOcifikl/K/ihTp5wN9ZHIHElaCJH7Wx/mH
         j3Hv1WlNlFZ4zGill+JDt7w5CiQl4lH5RVsjMWxSBJobG+daBpVvvpvgmyeXu/yoU+NC
         vFbK6OFm39abWjUHiKQuZBn+3FcaHRd7eCWOsXdUYzB/zCdak7fq7VM00KgReVJGJtOx
         nECErDgcidcy/na+Cg1eWg/Thj9FNPqNYBlSn2gZfRasbpCIm0Sus1mZ1ZAgCbrAUdMy
         loeuAM+Kg0HBtqy3XaGz6RA1cMyyA9Ex7PEUJ3Z8xO2HkIXf5ub/CXG5IK12TGJyEJd2
         K0lw==
X-Forwarded-Encrypted: i=1; AJvYcCUH95V8w3Dd8ezFsnr+aP4DsjXFG6NYEA1KrfV/ZezWIy7aBJO6ic00hOHT5AUil+jnpJk0zEANvebkFDpQzFoZIPFx
X-Gm-Message-State: AOJu0YzxC4a3+BZY/1jlZ9Gwt+3yjmwkPgKMJUKZ52tvXowzu99/yFC6
	VT0857L498wYukOdnq9/2AtHbmu2U6IXuyNyAjPlaBzMVukbsoNt0JrBREtmYy0=
X-Google-Smtp-Source: AGHT+IFhuipRzGKQii+jATiqJQQJZtOk5vz10sHKaqUAKhBj4Dqb4RoBXjOU9eIeu9ns2+sh073puA==
X-Received: by 2002:a17:903:1245:b0:1fb:3e8c:95a6 with SMTP id d9443c01a7336-1ff048e59c8mr60825725ad.40.1722271576219;
        Mon, 29 Jul 2024 09:46:16 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:15 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:36 -0700
Subject: [PATCH v2 6/8] libperf: Add perf_evsel__{refresh, period}()
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-6-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=6171;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=aVBjIsxJT8LS4fAGhXq/xpQCeYcYwi9ufo4Vs2pLLv0=;
 b=4ordREpvBQFF9nRLjzkG5AYtTDom9kp+2J+geJhO9Yp6HMv/+UWcHQtAxs9+iatyKJaqco8NC
 SpRNHVe7k69ClWIp01TemQTm7dk2bf/Zfb5bcN84iq/MmtiCHsCmzla
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Add the following functions:

  perf_evsel__refresh()
  perf_evsel__period()

to set the over flow limit and period.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 46 ++++++++++++++++++++++++++------
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  2 ++
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index f1bfe6b6e78a..aac764e63db6 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -162,6 +162,8 @@ SYNOPSIS
   int perf_evsel__disable(struct perf_evsel *evsel);
   int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd);
+  int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
+  int perf_evsel__period(struct perf_evsel *evsel, int period);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 6b98cba6eb4f..063498fc52f2 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -418,7 +418,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 	return 0;
 }
 
-static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
+static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, unsigned long arg,
 			     int cpu_map_idx, int thread)
 {
 	int *fd = FD(evsel, cpu_map_idx, thread);
@@ -430,7 +430,7 @@ static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
 }
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg,
+				 int ioc, unsigned long arg,
 				 int cpu_map_idx)
 {
 	int thread;
@@ -447,7 +447,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 
 int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
@@ -457,7 +457,7 @@ int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
 	int err;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
-		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
+		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, idx, thread);
 		if (err)
 			return err;
 	}
@@ -471,13 +471,13 @@ int perf_evsel__enable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, i);
 	return err;
 }
 
 int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
@@ -486,7 +486,37 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i);
+	return err;
+}
+
+int perf_evsel__refresh(struct perf_evsel *evsel, int refresh)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH, refresh, i);
+	return err;
+}
+
+int perf_evsel__period(struct perf_evsel *evsel, __u64 period)
+{
+	struct perf_event_attr *attr;
+	int i;
+	int err = 0;
+
+	attr = perf_evsel__attr(evsel);
+
+	for (i = 0; i < xyarray__max_x(evsel->fd); i++) {
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
+					    (unsigned long)&period, i);
+		if (err)
+			return err;
+	}
+
+	attr->sample_period = period;
+
 	return err;
 }
 
@@ -497,7 +527,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 	for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter, i);
+				     (unsigned long)filter, i);
 	return err;
 }
 
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 77816a35c383..613a63790346 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -63,6 +63,8 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
+LIBPERF_API int perf_evsel__period(struct perf_evsel *evsel, __u64 period);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index f68519e17885..12bdf2f43993 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -35,6 +35,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__munmap;
 		perf_evsel__mmap_base;
 		perf_evsel__read;
+		perf_evsel__refresh;
+		perf_evsel__period;
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;

-- 
2.44.0


