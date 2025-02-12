Return-Path: <bpf+bounces-51315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49392A33297
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D53164D3D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9D20459F;
	Wed, 12 Feb 2025 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IF0brA+Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986C202F67
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399380; cv=none; b=d4Oi+KKUH7Kim73rIIF46No675l3SXZbuSsFpiHsmOnX537HVqQ/THXIOTxNfxN71S01qVRrj5YXuXW+WmmfyRELF33VG3S0Haxvs5LNe0pjqV+t9MH2bTbBijenWWyOi37+/cOgJ8enJRgJkDeKXCFPks9Ua/qxy9fNGot9XYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399380; c=relaxed/simple;
	bh=OWCpQfV15fjfs91X5TWsuZAUowIODtiQVMeIkdX4org=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sovv6ssLrkxXqtJmfj/uaylDptaOdkyEb0lYMUjis0XeZcOUkcg1vs6AZ1MK6g+31tAFjLD0Gk/mXUATJIEC4XBfync34aKt1xNo2zNre85t00ONSwKTx6VE+f+9TAXcx20f348Klsf43x90NVSS1hJulyrEz2iE2nn9OsbzHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF0brA+Z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220c86b3ef3so13955435ad.1
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 14:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399378; x=1740004178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9bMfrQLSuEn1cesD7grG9bYwMcsNdAGFS2Zv9IEeA=;
        b=IF0brA+Zd65etVDoaHi5ADqKjNjD8E31MTNFg1mVhO3CJeWL4u53PgPlSI4hQhz02E
         CgAeq5ZsJts3DjjorUdMYL/xn3CC45FV5qZGrEsWClZr8jChCFfwHw9ppGASstQxO5CG
         kzt2j8XG+DfmgzjbbHTBLR15of+EKtFbdKzxfaYBHNI0s2pkNGafS319VFaYoxSdk/3R
         QTGIgl+ytQPvOEHLnCbv4/4+fFiywqixua5Z1cOUnNG1RLtdr0lVGtwBH3eZkc8/fa2I
         zuget0tsLbX/6+c8mAJfW8/JdCiwlKMLyXQaE3EWkhZB0mSje+Hifku50B922LIsWtp+
         cewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399378; x=1740004178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9bMfrQLSuEn1cesD7grG9bYwMcsNdAGFS2Zv9IEeA=;
        b=BGtkIc1wzO9djOAZtvumYKBTB1uzGFvBJnU2Ep4Cies0ehfte3C3X0QdlQDRbS23tU
         jzAkJJPxN0rT+lWtwdc8b0SENIB0+S1H92XLAwC5aMibEtVi+gST5PTCgddXeGKz+BOH
         nkRzetT61/msvwqdvuRep+4M2ZaEh01KrOpUDiLjJhls0vFz65wNWm154ea8rRIuavfm
         wAp7uq9NuW9cm6BXVEJ5oblYlRMnFlGQgCOFwc/8bV6Z+wuNDn66AkCWeCGKwqt3QLpl
         90X8+DXvYXu5vW9JkLprW41OZ9SGHa+D6qs/dIsLoWkr2K/b54XSd3Ws8FEPBDnQiuSH
         oslw==
X-Forwarded-Encrypted: i=1; AJvYcCVLA7s7cZtzi1vJYG1qPEbYNqqKjmUwALi+JUQJg6IEN8VVdO4xm8MbNtxeCzP38V8y8eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhiiud43SkcXmaGr6Eb2LcR5A9HhS31j7UTvvE1yKVbojuwjSs
	nKKwuaBePWuls3WulKItwcIx1P3lrRNM28xyQ2ssgwdQMGLqH08PzC/nWyVWvXwlnDaHrksU4hF
	t/Q==
X-Google-Smtp-Source: AGHT+IGH91oQbQqQOltRzwNzcwjx/9c8q5oX8zM6hIaW2Mk5foDZ/RclC94i5ELe3GWDZVuHmetFFqhI8es=
X-Received: from pgbcr7.prod.google.com ([2002:a05:6a02:4107:b0:ad5:55c3:4034])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cb:b0:1ee:64c0:aa85
 with SMTP id adf61e73a8af0-1ee6c619d45mr958280637.6.1739399378557; Wed, 12
 Feb 2025 14:29:38 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:52 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-2-ctshao@google.com>
Subject: [PATCH v5 1/5] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a struct and few bpf maps in order to tracing owner stack.
`struct owner_tracing_data`: Contains owner's pid, stack id, timestamp for
  when the owner acquires lock, and the count of lock waiters.
`stack_buf`: Percpu buffer for retrieving owner stacktrace.
`owner_stacks`: For tracing owner stacktrace to customized owner stack id.
`owner_data`: For tracing lock_address to `struct owner_tracing_data` in
  bpf program.
`owner_stat`: For reporting owner stacktrace in usermode.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/bpf_lock_contention.c         | 14 ++++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 33 +++++++++++++++++++
 tools/perf/util/bpf_skel/lock_data.h          |  7 ++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index fc8666222399..76542b86e83f 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -131,10 +131,20 @@ int lock_contention_prepare(struct lock_contention *con)
 	else
 		bpf_map__set_max_entries(skel->maps.task_data, 1);
 
-	if (con->save_callstack)
+	if (con->save_callstack) {
 		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
-	else
+		if (con->owner) {
+			bpf_map__set_value_size(skel->maps.stack_buf, con->max_stack * sizeof(u64));
+			bpf_map__set_key_size(skel->maps.owner_stacks,
+						con->max_stack * sizeof(u64));
+			bpf_map__set_max_entries(skel->maps.owner_stacks, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_data, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_stat, con->map_nr_entries);
+			skel->rodata->max_stack = con->max_stack;
+		}
+	} else {
 		bpf_map__set_max_entries(skel->maps.stacks, 1);
+	}
 
 	if (target__has_cpu(target)) {
 		skel->rodata->has_cpu = 1;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 6533ea9b044c..23fe9cc980ae 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -27,6 +27,38 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+/* buffer for owner stacktrace */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 1);
+} stack_buf SEC(".maps");
+
+/* a map for tracing owner stacktrace to owner stack id */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // owner stacktrace
+	__uint(value_size, sizeof(__s32)); // owner stack id
+	__uint(max_entries, 1);
+} owner_stacks SEC(".maps");
+
+/* a map for tracing lock address to owner data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // lock address
+	__uint(value_size, sizeof(struct owner_tracing_data));
+	__uint(max_entries, 1);
+} owner_data SEC(".maps");
+
+/* a map for contention_key (stores owner stack id) to contention data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(struct contention_key));
+	__uint(value_size, sizeof(struct contention_data));
+	__uint(max_entries, 1);
+} owner_stat SEC(".maps");
+
 /* maintain timestamp at the beginning of contention */
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -143,6 +175,7 @@ const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
 const volatile int use_cgroup_v2;
+const volatile int max_stack;
 
 /* determine the key of lock stat */
 const volatile int aggr_mode;
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index c15f734d7fc4..15f5743bd409 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -3,6 +3,13 @@
 #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
+struct owner_tracing_data {
+	u32 pid; // Who has the lock.
+	u32 count; // How many waiters for this lock.
+	u64 timestamp; // The time while the owner acquires lock and contention is going on.
+	s32 stack_id; // Identifier for `owner_stat`, which stores as value in `owner_stacks`
+};
+
 struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
-- 
2.48.1.502.g6dc24dfdaf-goog


