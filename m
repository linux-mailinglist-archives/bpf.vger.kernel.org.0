Return-Path: <bpf+bounces-52702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E46A4704A
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 01:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B78816DF1E
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 00:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E10E545;
	Thu, 27 Feb 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/+ebxt1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E7C2C9
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616502; cv=none; b=Tj/YebE7jw/k+FlPB2VjsxYjo2Gw+0Uyk8wkjB8jlRev8/n4MX70Q4fOmLetnkKjVl/hN5OjXdEnNVNGVSh8uFKHjSLyXIeetovxXulxs4+QsN0gwxfdGpDp+IMt8DmduybPhAgtemuElbqXZFFfKdOmoWiO4PlSrOCjhMoIeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616502; c=relaxed/simple;
	bh=uMnqvAw20MjO8y1DkOGmvKZ76yZAmQWMHc3q5tVE6c4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t5l2u7ic97w5D0+sR2Uijn8jJGKu8IE1tAw2JqNC/FjiR1cO75++IZb/dWrZ5Jp2ll63NkohU4nCaQ/I5XdkLDyHIYuFz4+AGSqER6GJxZ0kVfGUxhvapVvaSWn5Ar5Xz3A2AmjP+KCB4a+yKdaYe7twJUXzTRQaWYnBbxvlX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/+ebxt1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6cb3097bso7262365ad.3
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 16:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616500; x=1741221300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LIHL/AK+Ozu93SKs05RSuuBRbA8GccmzuqZN2pzdx8=;
        b=d/+ebxt1taEkk7kAsAi0BQufMNbg9dO/Ct8hz7uqfxpMYdOBTjRARCN+JWwxMSA1KI
         ypjlnyH1XOBvfji3SeQmHfk9nH/1U6FJX1ZBaY2C1HoZ8qLAmPFxCqKAbyuNzjItb7J5
         QrCwYkrsoa88IYOamutKr3wezcnLhd7IMggB9Fpq7UfQLRDUML3YGi5dioTIpAqBk+Vr
         KfGTeWmuGElQUNLtML4gk+Qq4BZWVTG0A+nOQvwIljePIyA6eK5/tbSTIAyTmXj3uUF4
         f84y6g6UHworGlIJUQFXjzszdGQa28PFvzhWV9qqU+1cKa8grFmxb9Cg/LlSQazE0jFG
         vbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616500; x=1741221300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LIHL/AK+Ozu93SKs05RSuuBRbA8GccmzuqZN2pzdx8=;
        b=N6tren7wqJTcBWAdduJkVtXEHzNw8/WgZ+M0QmA7AXutN0O4YlY5ki3eZPkp80o6il
         30wGoN7AbtcWJYYUnnLbPeAlO8kCTIyIgnXycIsAnFoKZIAy2n8PuvUP5UVaSZwUGZPx
         O4dMMu7jG7vz7Tb5oOE716BerTIDmEEF0PKB6IbtrnJrmJyizGeDVIfj6KZOBgrUlvNC
         tyTyw++An9Ji1xl/GsOrSdp7TW1nXvZ66m1fGJgiPVMLnpfdhNx9qgIWz8ALf7TxZqWY
         9Cj+fHlqxU4Mb+ZSpegnYBJXOhzQ32bUZvFwcgZEGgj4QOoz34K74SDNvvZ0MSaFpQoD
         ID/g==
X-Forwarded-Encrypted: i=1; AJvYcCUHK9zHnMSZR5JDI1GLOREWXveA0ExEmVftq6S9VVBryQivUAnwz2LDKPIx+W02f/UF8gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7VXQbOVODeSBhDu6sscQkb0JvmzYtV7a4NH2Thvy6Rsg+GAq
	iKiFQOnDt0JC+bFBYfHuSgKpEwXg7zhmzLkSoQBfKIGF3mvBeZbPXOXjIBZlYm9gpwyumWUrHXH
	asg==
X-Google-Smtp-Source: AGHT+IGzqpdRIlXGVg5tN41iPkn8q/I+EgwjsABLkG5nK/bxhoYAQCfVKFZZej6m6MOjXo0szVKcrocvD50=
X-Received: from plbje3.prod.google.com ([2002:a17:903:2643:b0:223:4e55:d29a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f92:b0:220:e896:54e1
 with SMTP id d9443c01a7336-221a10de4fdmr348252035ad.26.1740616498752; Wed, 26
 Feb 2025 16:34:58 -0800 (PST)
Date: Wed, 26 Feb 2025 16:28:53 -0800
In-Reply-To: <20250227003359.732948-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003359.732948-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003359.732948-2-ctshao@google.com>
Subject: [PATCH v8 1/4] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
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
2.48.1.658.g4767266eb4-goog


