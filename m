Return-Path: <bpf+bounces-69332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89059B94317
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD127B3208
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD93276027;
	Tue, 23 Sep 2025 04:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QB5lOC7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9D286439
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601154; cv=none; b=TcaQjJZoKdjeQ69PHoQRnuhWXnH0hLmv3a0Im8rsdEGuqFr4vTiRTXTARshAaiEAcNQzfd8voqrhIKjqh6Gg7hjGdly7mjBBI5O27hRdptFRwfiK97xOxLk/u3t6O7mhsGjB4OZYHUa7141ctyQo7jJOoFVwEllb8UPiFjZRyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601154; c=relaxed/simple;
	bh=fhZD2x+QrbMHd5jK5/8z7VUbaCBpxouok13Arc5QqCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XsvVfQdV/oJIkNNPvBW+uV+sV69/xCMidSwox/UJFZRtfjZfevLl7mqXi7o9nKHQwjH6XVARerasbtkACHQfO4m6y7/Nnxxmkb2XCuvq0TM1oRe90YsayCHYefiukTVjH510h7WZuZeNFPqsHD973mFdRACQ9CdW9HAadu1JdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QB5lOC7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581953b8so62057755ad.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601152; x=1759205952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEk7FNa9nXQCoNVr0+NbUtahRyTYRTOvJePFmmjLMWQ=;
        b=4QB5lOC7xD/M679NhtWKhFebtlSUkNYnU1kzzcOz3pEIWlI9HBGtjAFMgrdypcFLsw
         mg0FlYj5eHVkevmqoaZZzL1X8KP2JLaLJrfYqPPXYjGWED15znza9bOzvZDc9fgRmjnT
         9iyPV2lPvl2jbJDjz3P6P4ShX0EZP4Ez+Fj9+AhIYMkC2w2EphqIYo0NmAHcLHlq1e4w
         h7RdvHjcPfe3TRDR25wF4Pk71QXnIQJcfJLHmhrW1RTd4bSUgsKLmy/sui9WgYBh4rWO
         cCz2hgo8Y0j11/qXo/OY20hBVH/l4ekffuZAMyoqmlLGvg2fXhAgS455Tfrzs6Y1Nc7C
         uxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601152; x=1759205952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEk7FNa9nXQCoNVr0+NbUtahRyTYRTOvJePFmmjLMWQ=;
        b=sNkYK1415qa4DzwIq36cL4pBkQp4SZoy9p6l9ndWt3s1zBuju/8Q3XbSnYWEVUBNNk
         5QI7mR4rmfff7/BONwBo1iIZuOJPklXyDBStVVPET49ImLkrdvRm7OPopOrX65IO8mIB
         NPXMCJ5pCIuuP1ExJ8uClfgVS/9BCihyPRJgE5KOeXV4gv2NFI9hBh2ndmPLwcg2qfFQ
         zwC409ewgJX0q7YLfdbCpGMyTVwKgeh0T7Us7eDY0W8y84uGZKA2H9jPNmjZWds0KIJ3
         rgnCc6gaNC+8AXVhwkv/Xi66zF1DX7CcYLctdQBi3Fa2L40JIKMQbIULspOsxPn/j/SV
         xz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/jQRqT7HuDFs9LHa2ekjx2lGNa4iCy8iJezq2jgz7mmCe0evXhnrbPqR+8iJTCQtPpTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmkpfcQUghN1PK+/EQfav0yOlA+/KCgkfBd4hb4PbaczXgCxv
	nmbRiseQFwSEiIS2YI/iRvYbSb38X+ZysMzxea/JqLL5V8gNG58vFX2WpzhAWBObEepQrvALSej
	QJ8cRrWk32g==
X-Google-Smtp-Source: AGHT+IEfHLs/LVHDpEL+40h9oXVIEc6MjnYTnmseXnInIHaebYVfqSpwkAuopcX397GEEJWtLXiM4fNb6Imx
X-Received: from pjbsl14.prod.google.com ([2002:a17:90b:2e0e:b0:330:49f5:c0a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d512:b0:278:daab:7940
 with SMTP id d9443c01a7336-27cc1e1acf3mr19251745ad.17.1758601152289; Mon, 22
 Sep 2025 21:19:12 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:30 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-12-irogers@google.com>
Subject: [PATCH v5 11/25] perf jevents: Add legacy json terms and default_core
 event table helper
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

Add json LegacyConfigCode and LegacyCacheCode values that translate to
legacy-hardware-config and legacy-cache-config event terms
respectively.

Add perf_pmu__default_core_events_table as a means to find a
default_core event table that will later contain legacy events.

In situations like hypervisors it is more likely that tables will be
NULL. Rather than testing in the calling PMU code, early exit in the
pmu-event.c routines.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 26 +++++++++++++++++++
 tools/perf/pmu-events/jevents.py         | 32 ++++++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h       |  1 +
 3 files changed, 59 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 041c598b16d8..2393b3a7a4c9 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -461,6 +461,8 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     pmu_event_iter_fn fn,
                                     void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -482,6 +484,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -502,6 +506,8 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 {
         size_t count = 0;
 
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -580,6 +586,8 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 int ret = pmu_metrics_table__for_each_metric_pmu(table, &table->pmus[i],
                                                                  fn, data);
@@ -596,6 +604,8 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
                                  pmu_metric_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -707,6 +717,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
+const struct pmu_events_table *perf_pmu__default_core_events_table(void)
+{
+        int i = 0;
+
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+
+                if (!map->arch)
+                        break;
+
+                if (!strcmp(map->cpuid, "common"))
+                        return &map->event_table;
+        }
+        return NULL;
+}
+
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
         struct perf_cpu cpu = {-1};
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 168c044dd7cc..1f3917cbff87 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -325,6 +325,8 @@ class JsonEvent:
       eventcode |= int(jd['ExtSel']) << 8
     configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
     eventidcode = int(jd['EventidCode'], 0) if 'EventidCode' in jd else None
+    legacy_hw_config = int(jd['LegacyConfigCode'], 0) if 'LegacyConfigCode' in jd else None
+    legacy_cache_config = int(jd['LegacyCacheCode'], 0) if 'LegacyCacheCode' in jd else None
     self.name = jd['EventName'].lower() if 'EventName' in jd else None
     self.topic = ''
     self.compat = jd.get('Compat')
@@ -370,6 +372,10 @@ class JsonEvent:
       event = f'config={llx(configcode)}'
     elif eventidcode is not None:
       event = f'eventid={llx(eventidcode)}'
+    elif legacy_hw_config is not None:
+      event = f'legacy-hardware-config={llx(legacy_hw_config)}'
+    elif legacy_cache_config is not None:
+      event = f'legacy-cache-config={llx(legacy_cache_config)}'
     else:
       event = f'event={llx(eventcode)}'
     event_fields = [
@@ -951,6 +957,8 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     pmu_event_iter_fn fn,
                                     void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -972,6 +980,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -992,6 +1002,8 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 {
         size_t count = 0;
 
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -1070,6 +1082,8 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 int ret = pmu_metrics_table__for_each_metric_pmu(table, &table->pmus[i],
                                                                  fn, data);
@@ -1086,6 +1100,8 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
                                  pmu_metric_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -1197,6 +1213,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
+const struct pmu_events_table *perf_pmu__default_core_events_table(void)
+{
+        int i = 0;
+
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+
+                if (!map->arch)
+                        break;
+
+                if (!strcmp(map->cpuid, "common"))
+                        return &map->event_table;
+        }
+        return NULL;
+}
+
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
         struct perf_cpu cpu = {-1};
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index ea022ea55087..e0535380c0b2 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -125,6 +125,7 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
 				   void *data);
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
+const struct pmu_events_table *perf_pmu__default_core_events_table(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
-- 
2.51.0.534.gc79095c0ca-goog


