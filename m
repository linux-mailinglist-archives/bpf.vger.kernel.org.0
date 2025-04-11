Return-Path: <bpf+bounces-55708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68631A85309
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 07:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522DC4A056D
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1306B27CCD2;
	Fri, 11 Apr 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+ordTYK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529A27CB1D
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744349202; cv=none; b=ojXCBo9dsUrVi6JOBnJ3FcbbezJXE71gaL3KMVTcVF/SP6jH5W52k22NAwdFvWzlO/QaGxTBsvfn+EeqUPkEMD29e1a6NMgOo7YKffQ5ZCdafz4wDVcS8lMY56Tc5dQBNqM+kFAqG7ybkt1vXApg6Ndf0V6PNbEFXWMe4EWWNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744349202; c=relaxed/simple;
	bh=A+el4cpdw/DhRuCXHAdR6mgrmqbbrV0NpjVlr1loDPc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OMG9QEvLRwPrlMoDkszZyRff2e6RQ3Y0DhV6t3Wr6NhiPbB1QmwyDlbDBXdE2X2+0CylSa11kBx5YCQaR6E5gIl48VL2fTlP4CYERlhOXlRnCfYuaIdM7GlkMQX2GiwFYVldI6k0sustQTJjJietQl0Aa2ITxDLULKtUMowkxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+ordTYK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-227ed471999so14378295ad.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 22:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349200; x=1744954000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GFJBxRHU0RjyStMVHhHodlZr7xNoOo3rThfX4oypk9I=;
        b=O+ordTYKlhF7PiDYiEbU6p+dTQ6Khx7pFhH9qZWxzPIMyeia6TH4nqNF8zbRhV2gaZ
         mZEZSzxDGHtNvWK7DqPp4awfHEtQazdylR21QCd6LZx2oP/pcpqLhN8dNvwKm2yNvfqX
         QWiUjHRZOlHHxt8d/kNLBLg9TakSCnR16UecvPlR7lU0dCCQDlCTToRFU9KejCzaqewq
         fiw8MzDsTWWmFA5c1tc4++DplrsQEbQuMgqjKUyoNQPk9Jz8+cCyOkSttbdNy3ifAYy3
         8qVkAoC3sVBURkjxc/hdIJwB6tRHyZ9sf7/RExOSZMjJw8KRabyUZZCErSVf8n2rOMte
         oDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349200; x=1744954000;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFJBxRHU0RjyStMVHhHodlZr7xNoOo3rThfX4oypk9I=;
        b=NSnSs9yXLYxiBGioopsr7J28t7ChBGxSo7EL4PFUIFv4zdPCdU2RAvYHMAGX8eVEdr
         ZuC9g4HrzYRR3GzChJW1l220CHR5T6IcTFwJzDMZVo/yP5M+MJzqaYDrDbOpOD+l+Eea
         uaBbdrM9trV1nNm00krrxK+LFXhpdZnNrQVBheTRpNby7RSYp48UEFOCgDJoz1DQbWL6
         2+MiSffgejKlQxG2M07wXeCiBhe4XHbnIsgJOGIYE2HyLHDoYglrRoJDtJTVWy3ORcgG
         wB7np99LqL2VlR90LrHG9qT8OtTY46M/ySmGsTSSF21pfbuwwQEVbG1RpwthPtMokSua
         OYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUgXiQiHtG1l0DjHJiXxwSQYlCLtFmj+Oh3VMbS5pK7yzGixnZYW+scoZtzbAmv23pKvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WZGLtRffE+4KxRu6RJdXcnS1/r7zZ0zaa2fQAGUxk6bVyfTn
	Erkap9fyA8BypCufJqSiZcGktekOr63jKttT1if+H/p2wpLWq8+pQTSCJUmDXr6rrMAktnbFOGX
	9jw==
X-Google-Smtp-Source: AGHT+IH9Q5mYNu3CzERsko0z+dCQEZ1FE++BBu5zXD3RNKjtAxnHlvIt9cA6peJ0Qhv/dqlZ2hXZbRZYJpo=
X-Received: from plblv12.prod.google.com ([2002:a17:903:2a8c:b0:223:58e2:570d])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0e:b0:223:66bb:8995
 with SMTP id d9443c01a7336-22bea4ab827mr17319935ad.20.1744349200338; Thu, 10
 Apr 2025 22:26:40 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:24:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411052548.2089332-1-ctshao@google.com>
Subject: [PATCH v1] perf lock: Add --duration-filter option
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch introduces the `--duration-filter` option, allows users to
exclude lock contention samples with durations shorter than the
specified filter value.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt        |  3 +++
 tools/perf/builtin-lock.c                     |  3 +++
 tools/perf/util/bpf_lock_contention.c         | 22 ++++++++++++++-----
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  7 ++++++
 tools/perf/util/lock-contention.h             |  1 +
 5 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 859dc11a7372..1f57f5fc59e0 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -216,6 +216,9 @@ CONTENTION OPTIONS
 --cgroup-filter=<value>::
 	Show lock contention only in the given cgroups (comma separated list).
 
+--duration-filter=<value>::
+  Filter out lock contention samples which durations less than the specified
+  value (default: 0). The unit is nanoseconds (ns).
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 05e7bc30488a..d7b454e712bf 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -60,6 +60,7 @@ static int stack_skip = CONTENTION_STACK_SKIP;
 static int print_nr_entries = INT_MAX / 2;
 static const char *output_name = NULL;
 static FILE *lock_output;
+static int duration_filter;
 
 static struct lock_filter filters;
 
@@ -2004,6 +2005,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.save_callstack = needs_callstack(),
 		.owner = show_lock_owner,
 		.cgroups = RB_ROOT,
+		.duration_filter = duration_filter,
 	};
 
 	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
@@ -2580,6 +2582,7 @@ int cmd_lock(int argc, const char **argv)
 	OPT_BOOLEAN(0, "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
 	OPT_CALLBACK('G', "cgroup-filter", NULL, "CGROUPS",
 		     "Filter specific cgroups", parse_cgroup_filter),
+	OPT_INTEGER(0, "duration-filter", &duration_filter, "Filter samples by duration"),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 5af8f6d1bc95..7b982a3e4000 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -203,6 +203,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->rodata->aggr_mode = con->aggr_mode;
 	skel->rodata->needs_callstack = con->save_callstack;
 	skel->rodata->lock_owner = con->owner;
+	skel->rodata->duration_filter = con->duration_filter;
 
 	if (con->aggr_mode == LOCK_AGGR_CGROUP || con->filters->nr_cgrps) {
 		if (cgroup_is_v2("perf_event"))
@@ -568,12 +569,23 @@ struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
 	if (stack_trace == NULL)
 		goto out_err;
 
-	if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
-		goto out_err;
+	/*
+	 * `owner_stacks` contains stacks recorded in `contention_begin()` that either never reached
+	 * `contention_end()` or were filtered out and not stored in `owner_stat`. We skip if we
+	 * cannot find corresponding `contention_data` in `owner_stat` with the given `stack_id`.
+	 */
+	while (true) {
+		if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
+			goto out_err;
+
+		bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
+		ckey.stack_id = stack_id;
+		if (bpf_map_lookup_elem(stat_fd, &ckey, &cdata) == 0)
+			break;
 
-	bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
-	ckey.stack_id = stack_id;
-	bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
+		/* Can not find `contention_data`, delete and skip. */
+		bpf_map_delete_elem(stacks_fd, stack_trace);
+	}
 
 	st = zalloc(sizeof(struct lock_stat));
 	if (!st)
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 69be7a4234e0..26ddc0f21378 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -176,6 +176,7 @@ const volatile int stack_skip;
 const volatile int lock_owner;
 const volatile int use_cgroup_v2;
 const volatile int max_stack;
+const volatile int duration_filter;
 
 /* determine the key of lock stat */
 const volatile int aggr_mode;
@@ -457,6 +458,9 @@ static inline void update_contention_data(struct contention_data *data, u64 dura
 
 static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
 {
+	if (duration < duration_filter)
+		return;
+
 	struct contention_key key = {
 		.stack_id = id,
 		.pid = 0,
@@ -707,6 +711,9 @@ int contention_end(u64 *ctx)
 		}
 	}
 skip_owner:
+	if (duration < duration_filter)
+		goto out;
+
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
 		key.stack_id = pelem->stack_id;
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index b5d916aa49df..97042e6d8b10 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -149,6 +149,7 @@ struct lock_contention {
 	int owner;
 	int nr_filtered;
 	bool save_callstack;
+	int duration_filter;
 };
 
 struct option;
-- 
2.49.0.604.gff1f9ca942-goog


