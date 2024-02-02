Return-Path: <bpf+bounces-21109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5E847D43
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D075328B999
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7812D757;
	Fri,  2 Feb 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RE9Oql0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2A250E5
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917275; cv=none; b=mKweBBsbnIIvDciWAHZt4tQLkm8dsbbLF4v/+Zoh+O4O+zhdGnka2Vr4A25j73qtqe4BEJzv+FhapOUvI8U028b1Vn2UlM4NhjzW+OOFWJLlglWvMtyd3cWN9tAImE8Bn4VuU8YNURY+kJcwrXHYPoNd4vYKzK1acgiq7bsrcos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917275; c=relaxed/simple;
	bh=5nIG5LyKHW7GTVpxwdG8LHaYQ9yDY/AHj79BA34oOvg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XRnY54vCuLjQfjZjY8EmUrLA2uELtSTWdIIc+HvHZ4eUBpMrPvXJOvSgP0ZJo9GdXU8YitcGUnpFT1yCMfL1sLmqqm173NaZM5xuC7bjA+Af0ZWee5/Zs2JHczk25dLn2oDlg+2EO5rHqBt0HZ2JTQZcGRmpuOJTA0jBXX6p6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RE9Oql0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-603c0e020a6so39108857b3.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 15:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917272; x=1707522072; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSD742trI5qRJtx2AyB70ygbW0HL0IXuRRmpkhMUb0U=;
        b=1RE9Oql00b8bPBF3nUtfAXNGCQbTSxEVTWp1T12bs3BJpQiGm6DBZglgALGxC+P0nV
         ztrQK/V728stfHu8CfWoxgnRrIZIOjeVFjLFz3KWZk1suK5Uyw38d2wbATnGz1apj88W
         chYS/yULOLkaiHhgtNMLCy1StLX6ljs3/opYsz72tpFvW3hSs7votYj/WpgH6OkHfVWI
         lrSQEayy05D/htOuLZ8FDbLRcUspZTM28F6GGs/xwESLapxH5F7MUpkPhCgdAOZCNAO/
         ASNFwH7I2Y6O17+85IxqbjPSKD3VjmQGYigjUdblyMKZ/NSIZ3QigkvpGhVc30y1MiIB
         NTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917272; x=1707522072;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSD742trI5qRJtx2AyB70ygbW0HL0IXuRRmpkhMUb0U=;
        b=c+jL71KhzVSJ/eOQQROsiMSaz/aCokuLxzvC6KQXENpStJBgiYBx835DIi9z5+RYWZ
         zdAGrC2Hp3ukOaNvsJaEEwqhLgudtgXqXwmLb3yt5XJLQw32D3Q3kMJyK8NerkFnGuLm
         /l0q4AWOKupLWwPA4y9R2ao0w+8fISKhG92+a/8S+RAChCpt+d6U8jcCyT9DOtX5YATK
         cTFgGdkuct2/W4hamjYIqefVCOMUUizFqRWhYMkCASaVynWBuPKvJVopaumtaxXWHB8P
         ZRIjGL73uw0sDxzuR82QaSDW/Nh5qDU4JJUONntgbJkLL/cZKVMCB+OVgwysqAUm+kvC
         D4rw==
X-Gm-Message-State: AOJu0Yz1q8ttUYSe/dj1JbFB+fbIlnWYJ4P716u1QvJqZ0caLSKHhLUR
	AI8J3HqdrWKR7w8Fag17K0u8ehRRkFUgiFIcm0f8DxQKxm08xoUckUJZhEb1JIR15EfkT8fdo2B
	ihk1RRQ==
X-Google-Smtp-Source: AGHT+IFpfQ/GB+TYId1WD/szhEjcveN+IJCbuqBsttndI2uyVlYhHJ+PI+A6jwtdVpkd6bSuixIHY+dBTIMG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:690c:19:b0:600:2492:f962 with SMTP id
 bc25-20020a05690c001900b006002492f962mr1161790ywb.8.1706917271761; Fri, 02
 Feb 2024 15:41:11 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:50 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 1/8] libperf cpumap: Add any, empty and min helpers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additional helpers to better replace
perf_cpu_map__has_any_cpu_or_is_empty.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 27 +++++++++++++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h | 16 ++++++++++++++++
 tools/lib/perf/libperf.map           |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 4adcd7920d03..ba49552952c5 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -316,6 +316,19 @@ bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map)
 	return map ? __perf_cpu_map__cpu(map, 0).cpu == -1 : true;
 }
 
+bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map)
+{
+	if (!map)
+		return true;
+
+	return __perf_cpu_map__nr(map) == 1 && __perf_cpu_map__cpu(map, 0).cpu == -1;
+}
+
+bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
+{
+	return map == NULL;
+}
+
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 {
 	int low, high;
@@ -372,6 +385,20 @@ bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map)
 	return map && __perf_cpu_map__cpu(map, 0).cpu == -1;
 }
 
+struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map)
+{
+	struct perf_cpu cpu, result = {
+		.cpu = -1
+	};
+	int idx;
+
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
+		result = cpu;
+		break;
+	}
+	return result;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 228c6c629b0c..90457d17fb2f 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -61,6 +61,22 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
  * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has the "any CPU"/dummy value.
  */
 LIBPERF_API bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__is_any_cpu_or_is_empty - is map either empty or the "any CPU"/dummy value.
+ */
+LIBPERF_API bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__is_empty - does the map contain no values and it doesn't
+ *                          contain the special "any CPU"/dummy value.
+ */
+LIBPERF_API bool perf_cpu_map__is_empty(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__min - the minimum CPU value or -1 if empty or just the "any CPU"/dummy value.
+ */
+LIBPERF_API struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__max - the maximum CPU value or -1 if empty or just the "any CPU"/dummy value.
+ */
 LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
 LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 10b3f3722642..2aa79b696032 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -10,6 +10,10 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__nr;
 		perf_cpu_map__cpu;
 		perf_cpu_map__has_any_cpu_or_is_empty;
+		perf_cpu_map__is_any_cpu_or_is_empty;
+		perf_cpu_map__is_empty;
+		perf_cpu_map__has_any_cpu;
+		perf_cpu_map__min;
 		perf_cpu_map__max;
 		perf_cpu_map__has;
 		perf_thread_map__new_array;
-- 
2.43.0.594.gd9cf4e227d-goog


