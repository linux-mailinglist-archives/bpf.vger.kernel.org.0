Return-Path: <bpf+bounces-50103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56FA22884
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 06:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BEA18872C9
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 05:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B053B17ADE8;
	Thu, 30 Jan 2025 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOnpvzE4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A3166307
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214823; cv=none; b=r9b7gWQLiQaVU0qD7N/aS9lZ3j+1REYrd7Zfv+nZrYFW1mvPJf9VJOwTUD+qCV6966DKAOT7z4I4vexp83MhxBQC6xlrc3sNZZAIZmgL5yBcouaqHtUf4Bsm34Vnqz3y5Q7LIN1YTlgB3f6CYiRIEAhuESV9DUi1FCElVZUW06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214823; c=relaxed/simple;
	bh=695n3av2Ws9ME+ywo7rKvZ5On177TRKvNDuJu1tpCcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B9avmOchWHDgf0QE+KR91LfpIEqEgpqOyH4sLgEb+uaYWEU/ZPcAR2/x7Pow2TSZ06VhEFSNaq9fzRxCuBnNZBO3lkateJ6uv5ycl+6znU9pXrPjRgLiE51kFbOrAw+ohALIxNXEYmD00Gat1LyF7/dvrBdE6h58UJ7G2H6bJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iOnpvzE4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so817269a91.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 21:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738214820; x=1738819620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YAWsoPYpr8UJoLCc1UNzC9SJcWicZT0vijj00rqMygY=;
        b=iOnpvzE4HIEp3nCnq01GN0fraZM8LokbNbFhfk86F/xf2Rpj8lZ1z9G18fKBKEhxId
         V/SyRl3WAIQxuVOztUMu0hF++Y0BGZzv/9ygIG/wHvV0ErzDsQWK22luQ87cZPfOwl2x
         Dp/vNIPRKqLBqt0AIFA4ULheCcL9KClRnMS4m7xrUgYxkW0NS41M7N/enqfM+6JEZrNz
         RnlxPK5/ei15xudeuHykN2/cXUmoLplsFw27ywxemDelitbAMW+PjCXqA4XS11jkj9F5
         Jh74FuQd0z0hDH0+nyi8wcwlkhTyZLUf6EijYIbfq8HKHAiQxAj2qNGizqv18YsPBv1s
         qR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738214820; x=1738819620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAWsoPYpr8UJoLCc1UNzC9SJcWicZT0vijj00rqMygY=;
        b=LVLI11aJCNcP/cKoYfdU5dL0idSDgiS3Mp2SmN6W5LjFW7JeOAo1P95m7lgtetYR6T
         Wljramn0pqlxHHTfa6w8QG/6TsDrUa3hWdPjp0yH6yhA+9jK7DxlQkZ14zQa/ZJ3VJ2E
         tW0plFYMwpHJ7sLEklXdAj0zNIDJPO+diSTzG4FMLiOSD2HO6aIcdkm/XZamZSyhwIbC
         zi/tbHX394JB4B4FJYaIARrT5lsbxr3tFSxRITubGKUdJ2OW+iXHcMaGF+OftxEJOApl
         8EpRthDYc8AZqIJf5eV6fRLIhzkWVU0PrRyKrz3iXEWl3U3c9A4arig2gbcrOWuyfznj
         LEQA==
X-Forwarded-Encrypted: i=1; AJvYcCVOG/2SGBM3bRlGyG+TVlm125Ov1+B3E+HO0ZxkI0baeOkvt+z8mbtCOq70cL3bGdTMPfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeth0p1b97UObm54J5x+kLVo7UU3RcoxxiFru3migy0fEdZybk
	34S/ncHJ/+M9AdA34GyrF7epBdwcFIbB4l4vZzfyYiuEv+vhHkNMSW7TAvBGFg5K0Tv7+dJ2S+K
	xkQ==
X-Google-Smtp-Source: AGHT+IE5EVG9LoIyx9/H31PTLx9FbDo6YtoGlCbR299UqnZwEBWkvRmeaiXUmFgvbV74uOIhaOiGaMmIIiQ=
X-Received: from pjbns19.prod.google.com ([2002:a17:90b:2513:b0:2f8:49ad:406c])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264e:b0:2ee:bbe0:98c6
 with SMTP id 98e67ed59e1d1-2f83abb3516mr8517216a91.8.1738214819579; Wed, 29
 Jan 2025 21:26:59 -0800 (PST)
Date: Wed, 29 Jan 2025 21:21:35 -0800
In-Reply-To: <20250130052510.860318-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130052510.860318-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130052510.860318-2-ctshao@google.com>
Subject: [PATCH v4 1/5] perf lock: Add bpf maps for owner stack tracing
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
2.48.1.362.g079036d154-goog


