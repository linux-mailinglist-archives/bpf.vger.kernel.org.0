Return-Path: <bpf+bounces-48516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC5A08665
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 06:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239761886590
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 05:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8202063F5;
	Fri, 10 Jan 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHFYvfl3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F6205E26
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486070; cv=none; b=a7Bqpqr4FVkd/6AaAWRfJvqqgnAobzfkuI+X/w5g1teoy+Nj4PVlgCXMcIBPCbdjSAmtC8m3+Oj6qVvx95+54drIg8Gki7hzc9KRFSdBQebWA+MjtWNo5LQaThrWyxgdOcNqOVW3aVpqi6ynwlsYmFlJV4Ki0WwbmR082lJnCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486070; c=relaxed/simple;
	bh=PdTe3jFnoCLWzm3kmTMuOUCvtR+GmRocsG2mc9gfwJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NaKMttshhezJq3YVt2Yj2t07KJNfg7u/Q7w/JPJPWp5MmLwsM2FTCY4MPRTF9kAfemtJnfJ44Cq2t/5H+q3aCYVAkwZ7ab2eIMAQWgrIkHpal4zslOk77M3o4fUMZYKlzDMWY18pQLOcdBh4tbYzUSGtsq39nfhsHz2rWjiZnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHFYvfl3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so4842858a91.3
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 21:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736486066; x=1737090866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOc+Zq7RKw8PAGfDRJz3cORnG4jrHFHNhA/YUYdk0Pc=;
        b=LHFYvfl3V1gDzJs4PIWHBPrlpESBCy1eCeHgBGDqVYxpsVR3+TJxomewZlexba9Ldg
         v6d3gasSmzMxDvRAeAcqnb59gLGJK7KflGP6oCCajLNpicBS3yeoOK5penqOawViWQg1
         rS2GBD/gSZWXdEX7tyLTGZXm9NQSzYs5iU0q8TAvt8IFlHzERi4kH37+n3gkqxwaUk2B
         MBPKr4tiGu9sogeYZxHOeORoH2lpNT6l1qnF/pyL+cOeRW05foAEaTqgzwsO5EcL+9F/
         2k/3iFdPjUiI+V8S94KnsSRmM9h8ZXKwTDbFkErRR4WDjQtsb1CuCUE3lxRMQ9wYBk1z
         i0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736486066; x=1737090866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOc+Zq7RKw8PAGfDRJz3cORnG4jrHFHNhA/YUYdk0Pc=;
        b=Pv4NFdkBu89wCdve0yuvo4PODEAPfzGWjJzV+fhTQa+1aHhbnZ62vh9qpmq4ZDSl/R
         wgzhLzC8hXoHsd4vNieVhbk24XA8TWKW8zERyHpmxSADTBqpaq79pd2vNBwM8pomDZGJ
         bBRScNCaf+tW1D9g0VcZ1EAWmrC0Mu+z6CSsBuAqrklFbpdl2279wQogr4bvr7Z76x9x
         Of2xxxqYlxPkbI27Ss+JivsZDWiocpejHUlMEdqvS7FXgLIYYZKdgedRZcaPtE7uOLKk
         bSd6J5/oVg4nT77DBKn3ntBun6eEjAgrNlBDk6tDf0gq0e3lz2rDyOLSCQgn4kRIIcNc
         SWPA==
X-Forwarded-Encrypted: i=1; AJvYcCVaA+8D6jmCVCcgIF4D5ZAGnqnbt0MTqyTmCJ9Zzu+pljoh1s8muIi6LCtA1Hv5Am2Sjl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2Ygfmd3vQgO1zY69ihOup9x/0CliH74Fh36Jmo8S52nY6uW8
	/vKqM4zsfHlJ+hJKgIO3G0xYdED/iGMB9DZ9ueQKt7sle0VPomXgPcoYSZFiKFISvVR7XU4PJU3
	q5Q==
X-Google-Smtp-Source: AGHT+IE0+PBeuwxpnzTELFvbH/TuHAsee1m+fOwEkUQNielCR8eFWLWwsp0ClZTyWE2gxhBLCgqSGXk/TAw=
X-Received: from pffk11.prod.google.com ([2002:aa7:88cb:0:b0:72b:2f6b:c0a3])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:170a:b0:725:d64c:f113
 with SMTP id d2e1a72fcca58-72d21f18064mr14061211b3a.3.1736486066382; Thu, 09
 Jan 2025 21:14:26 -0800 (PST)
Date: Thu,  9 Jan 2025 21:11:41 -0800
In-Reply-To: <20250110051346.1507178-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110051346.1507178-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250110051346.1507178-2-ctshao@google.com>
Subject: [PATCH v1 1/4] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add few bpf maps in order to tracing owner stack.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/bpf_lock_contention.c         | 17 ++++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 40 +++++++++++++++++--
 tools/perf/util/bpf_skel/lock_data.h          |  6 +++
 3 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 41a1ad087895..c9c58f243ceb 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -41,9 +41,20 @@ int lock_contention_prepare(struct lock_contention *con)
 	else
 		bpf_map__set_max_entries(skel->maps.task_data, 1);
 
-	if (con->save_callstack)
-		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
-	else
+	if (con->save_callstack) {
+		bpf_map__set_max_entries(skel->maps.stacks,
+					 con->map_nr_entries);
+		if (con->owner) {
+			bpf_map__set_value_size(skel->maps.owner_stacks_entries,
+						con->max_stack * sizeof(u64));
+			bpf_map__set_value_size(
+				skel->maps.contention_owner_stacks,
+				con->max_stack * sizeof(u64));
+			bpf_map__set_key_size(skel->maps.owner_lock_stat,
+						con->max_stack * sizeof(u64));
+			skel->rodata->max_stack = con->max_stack;
+		}
+	} else
 		bpf_map__set_max_entries(skel->maps.stacks, 1);
 
 	if (target__has_cpu(target)) {
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 1069bda5d733..05da19fdab23 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -19,13 +19,37 @@
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
 
-/* callstack storage  */
+ /* tmp buffer for owner callstack */
 struct {
-	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(__u32));
 	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 1);
+} owner_stacks_entries SEC(".maps");
+
+/* a map for tracing lock address to owner data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // lock address
+	__uint(value_size, sizeof(cotd));
 	__uint(max_entries, MAX_ENTRIES);
-} stacks SEC(".maps");
+} contention_owner_tracing SEC(".maps");
+
+/* a map for tracing lock address to owner stacktrace */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // lock address
+	__uint(value_size, sizeof(__u64)); // straktrace
+	__uint(max_entries, MAX_ENTRIES);
+} contention_owner_stacks SEC(".maps");
+
+/* owner callstack to contention data storage */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(struct contention_data));
+	__uint(max_entries, MAX_ENTRIES);
+} owner_lock_stat SEC(".maps");
 
 /* maintain timestamp at the beginning of contention */
 struct {
@@ -43,6 +67,14 @@ struct {
 	__uint(max_entries, 1);
 } tstamp_cpu SEC(".maps");
 
+/* callstack storage  */
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, MAX_ENTRIES);
+} stacks SEC(".maps");
+
 /* actual lock contention statistics */
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -126,6 +158,7 @@ const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
 const volatile int use_cgroup_v2;
+const volatile int max_stack;
 
 /* determine the key of lock stat */
 const volatile int aggr_mode;
@@ -436,7 +469,6 @@ int contention_end(u64 *ctx)
 			return 0;
 		need_delete = true;
 	}
-
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 	if ((__s64)duration < 0) {
 		__sync_fetch_and_add(&time_fail, 1);
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index de12892f992f..1ef0bca9860e 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -3,6 +3,12 @@
 #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
+typedef struct contention_owner_tracing_data {
+	u32 pid; // Who has the lock.
+	u64 timestamp; // The time while the owner acquires lock and contention is going on.
+	u32 count; // How many waiters for this lock.
+} cotd;
+
 struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
-- 
2.47.1.688.g23fc6f90ad-goog


