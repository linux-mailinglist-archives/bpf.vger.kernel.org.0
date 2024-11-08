Return-Path: <bpf+bounces-44332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A51399C1664
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 07:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24621B23DE8
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 06:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91F1DC06B;
	Fri,  8 Nov 2024 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKHyKIQa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45351D63F2;
	Fri,  8 Nov 2024 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731046504; cv=none; b=evZEOPwynFKJK8OROx+ICuU3M518x7Q0reb1OEf+aD4C2GwhpJgbKz1btjFTFRMoyzM2TejHI3NV1fKThjzmfbdAphYEQiKzSvupzb6wT0F2mgbO66S9WD/3NQ5eF6MZodS3vmsJozIhG6vqW1dfHqe4jsxMP2xNWHHSZekk08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731046504; c=relaxed/simple;
	bh=XoWu5t7ykXC6lX8IpYZS4R+LySpB+CPYO7R1tC+0r7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNDBU6MBvPrWEmgXdDdrL9zSliGx+AEEMYFz+s2iZeLpClCsaR0BDcZzDLIVlLmhW2rDcgwxVvhfSd5axBnd6hPq41tuPfpKonAjPE9IXmuVgtv5XYslnstq/Hc20y7gmkkmXB91m9aj6QPgwuGfhoV95ORSBuizOUKVvKBA+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKHyKIQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73DEC4CECF;
	Fri,  8 Nov 2024 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731046504;
	bh=XoWu5t7ykXC6lX8IpYZS4R+LySpB+CPYO7R1tC+0r7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKHyKIQavGKH+eyeuEelfgTWS12OA7Nxpzw8ww1WAPSmHxzaCdzXz7ZTYrm6YZnxg
	 1ltz1tUBF8uN4VvkZkQCW9qLFu7SLKJ+7NiOAQiTdYsnkPP/X5WqzeoSJ+SdwAGXv6
	 BsHzA2p5cmL6dOXnKsegAGscIQzbH1rq6ObgdD2DnFDPcyvnfo+6WhznZ3SgWFIF++
	 gTMt92/i9HjbsN9ffMVXLHO8gG4v06a/bi/KnNI84nITsrEYhwiUTeKQZUojJJwR8k
	 ctx+TbslPTKj4tBRQ4ER0F4+6mKBQpUa1zc27K9Sw8HJiUNX3YkltIjRgw3ML5Yb/j
	 n+aqV6zcTgmtA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 4/4] perf lock contention: Handle slab objects in -L/--lock-filter option
Date: Thu,  7 Nov 2024 22:14:59 -0800
Message-ID: <20241108061500.2698340-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241108061500.2698340-1-namhyung@kernel.org>
References: <20241108061500.2698340-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to filter lock contention from specific slab objects only.
Like in the lock symbol output, we can use '&' prefix to filter slab
object names.

  root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -abl sleep 1
   contended   total wait     max wait     avg wait            address   symbol

           3     14.99 us     14.44 us      5.00 us   ffffffff851c0940   pack_mutex (mutex)
           2      2.75 us      2.56 us      1.38 us   ffff98d7031fb498   &task_struct (mutex)
           4      1.42 us       557 ns       355 ns   ffff98d706311400   &kmalloc-cg-512 (mutex)
           2       953 ns       714 ns       476 ns   ffffffff851c3620   delayed_uprobe_lock (mutex)
           1       929 ns       929 ns       929 ns   ffff98d7031fb538   &task_struct (mutex)
           3       561 ns       210 ns       187 ns   ffffffff84a8b3a0   text_mutex (mutex)
           1       479 ns       479 ns       479 ns   ffffffff851b4cf8   tracepoint_srcu_srcu_usage (mutex)
           2       320 ns       195 ns       160 ns   ffffffff851cf840   pcpu_alloc_mutex (mutex)
           1       212 ns       212 ns       212 ns   ffff98d7031784d8   &signal_cache (mutex)
           1       177 ns       177 ns       177 ns   ffffffff851b4c28   tracepoint_srcu_srcu_usage (mutex)

With the filter, it can show contentions from the task_struct only.

  root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -abl -L '&task_struct' sleep 1
   contended   total wait     max wait     avg wait            address   symbol

           2      1.97 us      1.71 us       987 ns   ffff98d7032fd658   &task_struct (mutex)
           1      1.20 us      1.20 us      1.20 us   ffff98d7032fd6f8   &task_struct (mutex)

It can work with other aggregation mode:

  root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -ab -L '&task_struct' sleep 1
   contended   total wait     max wait     avg wait         type   caller

           1     25.10 us     25.10 us     25.10 us        mutex   perf_event_exit_task+0x39
           1     21.60 us     21.60 us     21.60 us        mutex   futex_exit_release+0x21
           1      5.56 us      5.56 us      5.56 us        mutex   futex_exec_release+0x21

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                     | 35 ++++++++++++++++
 tools/perf/util/bpf_lock_contention.c         | 40 ++++++++++++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 21 +++++++++-
 tools/perf/util/lock-contention.h             |  2 +
 4 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 89ee2a2f78603906..405e95666257b7fe 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1646,6 +1646,12 @@ static void lock_filter_finish(void)
 
 	zfree(&filters.cgrps);
 	filters.nr_cgrps = 0;
+
+	for (int i = 0; i < filters.nr_slabs; i++)
+		free(filters.slabs[i]);
+
+	zfree(&filters.slabs);
+	filters.nr_slabs = 0;
 }
 
 static void sort_contention_result(void)
@@ -2412,6 +2418,27 @@ static bool add_lock_sym(char *name)
 	return true;
 }
 
+static bool add_lock_slab(char *name)
+{
+	char **tmp;
+	char *sym = strdup(name);
+
+	if (sym == NULL) {
+		pr_err("Memory allocation failure\n");
+		return false;
+	}
+
+	tmp = realloc(filters.slabs, (filters.nr_slabs + 1) * sizeof(*filters.slabs));
+	if (tmp == NULL) {
+		pr_err("Memory allocation failure\n");
+		return false;
+	}
+
+	tmp[filters.nr_slabs++] = sym;
+	filters.slabs = tmp;
+	return true;
+}
+
 static int parse_lock_addr(const struct option *opt __maybe_unused, const char *str,
 			   int unset __maybe_unused)
 {
@@ -2435,6 +2462,14 @@ static int parse_lock_addr(const struct option *opt __maybe_unused, const char *
 			continue;
 		}
 
+		if (*tok == '&') {
+			if (!add_lock_slab(tok + 1)) {
+				ret = -1;
+				break;
+			}
+			continue;
+		}
+
 		/*
 		 * At this moment, we don't have kernel symbols.  Save the symbols
 		 * in a separate list and resolve them to addresses later.
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 3f127fc6b95f8326..5ca1c7ffe4ce5073 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -112,7 +112,7 @@ static void exit_slab_cache_iter(void)
 int lock_contention_prepare(struct lock_contention *con)
 {
 	int i, fd;
-	int ncpus = 1, ntasks = 1, ntypes = 1, naddrs = 1, ncgrps = 1;
+	int ncpus = 1, ntasks = 1, ntypes = 1, naddrs = 1, ncgrps = 1, nslabs = 1;
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
 
@@ -201,6 +201,13 @@ int lock_contention_prepare(struct lock_contention *con)
 
 	check_slab_cache_iter(con);
 
+	if (con->filters->nr_slabs && has_slab_iter) {
+		skel->rodata->has_slab = 1;
+		nslabs = con->filters->nr_slabs;
+	}
+
+	bpf_map__set_max_entries(skel->maps.slab_filter, nslabs);
+
 	if (lock_contention_bpf__load(skel) < 0) {
 		pr_err("Failed to load lock-contention BPF skeleton\n");
 		return -1;
@@ -271,6 +278,36 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_program__set_autoload(skel->progs.collect_lock_syms, false);
 
 	lock_contention_bpf__attach(skel);
+
+	/* run the slab iterator after attaching */
+	run_slab_cache_iter();
+
+	if (con->filters->nr_slabs) {
+		u8 val = 1;
+		int cache_fd;
+		long key, *prev_key;
+
+		fd = bpf_map__fd(skel->maps.slab_filter);
+
+		/* Read the slab cache map and build a hash with its address */
+		cache_fd = bpf_map__fd(skel->maps.slab_caches);
+		prev_key = NULL;
+		while (!bpf_map_get_next_key(cache_fd, prev_key, &key)) {
+			struct slab_cache_data data;
+
+			if (bpf_map_lookup_elem(cache_fd, &key, &data) < 0)
+				break;
+
+			for (i = 0; i < con->filters->nr_slabs; i++) {
+				if (!strcmp(con->filters->slabs[i], data.name)) {
+					bpf_map_update_elem(fd, &key, &val, BPF_ANY);
+					break;
+				}
+			}
+			prev_key = &key;
+		}
+	}
+
 	return 0;
 }
 
@@ -396,7 +433,6 @@ static void account_end_timestamp(struct lock_contention *con)
 
 int lock_contention_start(void)
 {
-	run_slab_cache_iter();
 	skel->bss->enabled = 1;
 	return 0;
 }
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index b5bc37955560a58e..048a04fc3a7fc27d 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -100,6 +100,13 @@ struct {
 	__uint(max_entries, 1);
 } cgroup_filter SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(long));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} slab_filter SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(long));
@@ -131,6 +138,7 @@ const volatile int has_task;
 const volatile int has_type;
 const volatile int has_addr;
 const volatile int has_cgroup;
+const volatile int has_slab;
 const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
@@ -213,7 +221,7 @@ static inline int can_record(u64 *ctx)
 		__u64 addr = ctx[0];
 
 		ok = bpf_map_lookup_elem(&addr_filter, &addr);
-		if (!ok)
+		if (!ok && !has_slab)
 			return 0;
 	}
 
@@ -226,6 +234,17 @@ static inline int can_record(u64 *ctx)
 			return 0;
 	}
 
+	if (has_slab && bpf_get_kmem_cache) {
+		__u8 *ok;
+		__u64 addr = ctx[0];
+		long kmem_cache_addr;
+
+		kmem_cache_addr = (long)bpf_get_kmem_cache(addr);
+		ok = bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr);
+		if (!ok)
+			return 0;
+	}
+
 	return 1;
 }
 
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 1a7248ff388947e1..95331b6ec062410d 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -10,10 +10,12 @@ struct lock_filter {
 	int			nr_addrs;
 	int			nr_syms;
 	int			nr_cgrps;
+	int			nr_slabs;
 	unsigned int		*types;
 	unsigned long		*addrs;
 	char			**syms;
 	u64			*cgrps;
+	char			**slabs;
 };
 
 struct lock_stat {
-- 
2.47.0.277.g8800431eea-goog


