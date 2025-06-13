Return-Path: <bpf+bounces-60583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C52AD83FF
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 09:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325D6189AFE4
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323342C327C;
	Fri, 13 Jun 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzP4zUrz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EB2C325F
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799314; cv=none; b=AZXnEyVCF1V3svdmljd5xCA4g/YVHbUN4l1Siv0TB3FWp6mdFG1xC6T/DUzq/so3TEHNMc9aXYI+sUe9FZUr/CyGT2tPba1kLScZ7LsmXhbvlTR/5FGcdOtuvqDn3+KIXZW8eIRZys3BYRXZ1c7NvwzxWyGqoWXKp8fwLyrrNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799314; c=relaxed/simple;
	bh=uMpoufwuPHS3USeK0PjpjGMsperMs76Y5WRtPBIRmZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeT277lDrquFHqBTi/ib5TO8WftUMDI++MZ9UX4Uh6d+ieThBzIjHevJ7d1E7gMK694P7ULdC5qv6GDcSqs6eoSjWdtYjhBBdp13UuhY9evbzA7yIs8bsFa1BrEh3hqaXhHmiFZoebj3wGWdNuVyX+rWg1eJNGIbhPSVCim/RrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzP4zUrz; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e817b40d6e7so1691775276.1
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749799311; x=1750404111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nOyjSFCRjLHIsUQxMhNqYBWFyuqVJ90Pe96xu0DIaM=;
        b=SzP4zUrzHpd5SiFJeqqrjPhM8KCpTWdkSAWaTW0zFEU18YP04HacRs76bewplFi5xu
         g0y3h8JP5jSEE4mOVkk5Dphz77BacroKE8HPEkJCfzZLuz1nFg99UW8VDN+w15CpuzeM
         jKiNthcBVf6yK5mHuhlck7hoa7VKB48XInKlH4msAq+7eSXB0rLRwDPi3JnfCoVvQd6u
         lw7TewGepBaay6YqRcBThp5wL6vvInehIiTcJj8RAGE5m4syIFyYftzUSD7NWEaD09e4
         MNlQ/FMiGWjQl2X07D3u16IuJjAMjxuyqCKEzYEksGfawv+5VOv2UTAI9bie3wL1vlxR
         eZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749799311; x=1750404111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nOyjSFCRjLHIsUQxMhNqYBWFyuqVJ90Pe96xu0DIaM=;
        b=nYgs3AzbwQVZXQ9svNZW4Bj3CeD8xpVMa2QBhX0PyYFgsiDcNLjMrF8ZQCwj+KjTTy
         meAgCxgZfDfdaPSnhJ/55xN3G595i31FcKz2h6LAAA25v6ZHFTi0BP/wUKw2EsoSGDF1
         dDOpBkvjWXib/rFJEIgHh9S4SLSodIbh8WXXtatXPnOag74CTV8uAPpRuNwNWP/TUR7e
         yDSC7Uod/AHadktRZN/k/EsdVGEqhj8MNXw/ucdHyYaZqX805h8+eB+4RvhJN9VdgEDc
         srnQT/FYYEMUy6oj9uU8z6kFDO73MgL3f/0m2NY+Uotp5Oz6e/AEJdD85/F6ERdzJ5j1
         ryRA==
X-Gm-Message-State: AOJu0YzLNyVijzoC/I/4z6/A4nrrlLqSUwhoY1pKOcZX+t0mfUqdJayq
	64PlZbEdssTso3nwJkpW4T38Kv3tO3DLMfv+5/8/AfgwFjolKyl1d+S2Rz0aFLmm
X-Gm-Gg: ASbGncvoWl7Ck802bGZXeM616RS+xYQcRvCbiL9e/bxO3yK+JrcdY2hnOU2O4rtVEJI
	6sGJqxkKNlncB26ml+5/97rH1fNGEB2YtaNoj5j/V2N8N6SN5U8cdAtBBIlcnh483JpXY7l0/Qg
	JuIXIwzea19lnlDfU9/ZftuVzvJuKCQugdZYYsY2uB0gWQxnZKh91UAYZtcKu3qYrHxskbepDGP
	CgUHzrwqmd1PfGNyVMK2bY7xGnthg0zxmq/NOrDUWezH/WA4udW8ZaWAWwu5eteYqUJf9XLOhxo
	tZAIGuwrUfFU38DfHo9Vw906T1bDY5qQuHNBUD5U2Od2wb90Hcxo
X-Google-Smtp-Source: AGHT+IHH8nXznI6GKWsNCXZ6sapDDWwhqgTxsyXBVt6NbTb+sCp33Bd/pl6wb0x7Of1xoSNlJjKwTg==
X-Received: by 2002:a05:6902:10ca:b0:e81:20c5:cd04 with SMTP id 3f1490d57ef6-e821c31e0d1mr2436146276.46.1749799311427;
        Fri, 13 Jun 2025 00:21:51 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e2be2easm929717276.34.2025.06.13.00.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:21:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next v3 2/2] veristat: memory accounting for bpf programs
Date: Fri, 13 Jun 2025 00:21:47 -0700
Message-ID: <20250613072147.3938139-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613072147.3938139-1-eddyz87@gmail.com>
References: <20250613072147.3938139-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a new field mem_peak / "Peak memory (MiB)" field to a
set of gathered statistics. The field is intended as an estimate for
peak verifier memory consumption for processing of a given program.

Mechanically stat is collected as follows:
- At the beginning of handle_verif_mode() a new cgroup is created
  and veristat process is moved into this cgroup.
- At each program load:
  - bpf_object__load() is split into bpf_object__prepare() and
    bpf_object__load() to avoid accounting for memory allocated for
    maps;
  - before bpf_object__load():
    - a write to "memory.peak" file of the new cgroup is used to reset
      cgroup statistics;
    - updated value is read from "memory.peak" file and stashed;
  - after bpf_object__load() "memory.peak" is read again and
    difference between new and stashed values is used as a metric.

If any of the above steps fails veristat proceeds w/o collecting
mem_peak information for a program, reporting mem_peak as -1.

While memcg provides data in bytes (converted from pages), veristat
converts it to megabytes to avoid jitter when comparing results of
different executions.

The change has no measurable impact on veristat running time.

A correlation between "Peak states" and "Peak memory" fields provides
a sanity check for gathered statistics, e.g. a sample of data for
sched_ext programs:

Program                   Peak states  Peak memory (MiB)
------------------------  -----------  -----------------
lavd_select_cpu                  2153                 44
lavd_enqueue                     1982                 41
lavd_dispatch                    3480                 28
layered_dispatch                 1417                 17
layered_enqueue                   760                 11
lavd_cpu_offline                  349                  6
lavd_cpu_online                   349                  6
lavd_init                         394                  6
rusty_init                        350                  5
layered_select_cpu                391                  4
...
rusty_stopping                    134                  1
arena_topology_node_init          170                  0

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile   |   8 +
 tools/testing/selftests/bpf/veristat.c | 248 ++++++++++++++++++++++++-
 2 files changed, 249 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cf5ed3bee573..dd598ca771c5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -841,6 +841,14 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
+# This works around GCC warning about snprintf truncating strings like:
+#
+#   char a[PATH_MAX], b[PATH_MAX];
+#   snprintf(a, "%s/foo", b);      // triggers -Wformat-truncation
+ifeq ($(LLVM),)
+$(OUTPUT)/veristat.o: CFLAGS+=-Wno-format-truncation
+endif
+
 $(OUTPUT)/veristat.o: $(BPFOBJ)
 $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 	$(call msg,BINARY,,$@)
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2bb20b00952..0a3be1282402 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -49,6 +49,7 @@ enum stat_id {
 	STACK,
 	PROG_TYPE,
 	ATTACH_TYPE,
+	MEMORY_PEAK,
 
 	FILE_NAME,
 	PROG_NAME,
@@ -208,6 +209,9 @@ static struct env {
 	int top_src_lines;
 	struct var_preset *presets;
 	int npresets;
+	char orig_cgroup[PATH_MAX];
+	char stat_cgroup[PATH_MAX];
+	int memory_peak_fd;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -219,6 +223,22 @@ static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va
 	return vfprintf(stderr, format, args);
 }
 
+#define log_errno(fmt, ...) log_errno_aux(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+__printf(3, 4)
+static int log_errno_aux(const char *file, int line, const char *fmt, ...)
+{
+	int err = -errno;
+	va_list ap;
+
+	va_start(ap, fmt);
+	fprintf(stderr, "%s:%d: ", file, line);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, " failed with error '%s'.\n", strerror(errno));
+	va_end(ap);
+	return err;
+}
+
 #ifndef VERISTAT_VERSION
 #define VERISTAT_VERSION "<kernel>"
 #endif
@@ -734,13 +754,13 @@ static int append_file_from_file(const char *path)
 }
 
 static const struct stat_specs default_csv_output_spec = {
-	.spec_cnt = 14,
+	.spec_cnt = 15,
 	.ids = {
 		FILE_NAME, PROG_NAME, VERDICT, DURATION,
 		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
 		MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
 		SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
-		STACK,
+		STACK, MEMORY_PEAK,
 	},
 };
 
@@ -781,6 +801,7 @@ static struct stat_def {
 	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
 	[PROG_TYPE] = { "Program type", {"prog_type"}, },
 	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
+	[MEMORY_PEAK] = { "Peak memory (MiB)", {"mem_peak", }, },
 };
 
 static bool parse_stat_id_var(const char *name, size_t len, int *id,
@@ -1278,16 +1299,214 @@ static int max_verifier_log_size(void)
 	return log_size;
 }
 
+static bool output_stat_enabled(int id)
+{
+	int i;
+
+	for (i = 0; i < env.output_spec.spec_cnt; i++)
+		if (env.output_spec.ids[i] == id)
+			return true;
+	return false;
+}
+
+__printf(2, 3)
+static int write_one_line(const char *file, const char *fmt, ...)
+{
+	int err, saved_errno;
+	va_list ap;
+	FILE *f;
+
+	f = fopen(file, "w");
+	if (!f)
+		return -1;
+
+	va_start(ap, fmt);
+	errno = 0;
+	err = vfprintf(f, fmt, ap);
+	saved_errno = errno;
+	va_end(ap);
+	fclose(f);
+	errno = saved_errno;
+	return err < 0 ? -1 : 0;
+}
+
+__scanf(3, 4)
+static int scanf_one_line(const char *file, int fields_expected, const char *fmt, ...)
+{
+	int res = 0, saved_errno = 0;
+	char *line = NULL;
+	size_t line_len;
+	va_list ap;
+	FILE *f;
+
+	f = fopen(file, "r");
+	if (!f)
+		return -1;
+
+	va_start(ap, fmt);
+	while (getline(&line, &line_len, f) > 0) {
+		res = vsscanf(line, fmt, ap);
+		if (res == fields_expected)
+			goto out;
+	}
+	if (ferror(f)) {
+		saved_errno = errno;
+		res = -1;
+	}
+
+out:
+	va_end(ap);
+	free(line);
+	fclose(f);
+	errno = saved_errno;
+	return res;
+}
+
+static void destroy_stat_cgroup(void)
+{
+	char buf[PATH_MAX];
+	int err;
+
+	close(env.memory_peak_fd);
+
+	if (env.orig_cgroup[0]) {
+		snprintf(buf, sizeof(buf), "%s/cgroup.procs", env.orig_cgroup);
+		err = write_one_line(buf, "%d\n", getpid());
+		if (err < 0)
+			log_errno("moving self to original cgroup %s\n", env.orig_cgroup);
+	}
+
+	if (env.stat_cgroup[0]) {
+		err = rmdir(env.stat_cgroup);
+		if (err < 0)
+			log_errno("deletion of cgroup %s", env.stat_cgroup);
+	}
+
+	env.memory_peak_fd = -1;
+	env.orig_cgroup[0] = 0;
+	env.stat_cgroup[0] = 0;
+}
+
+/*
+ * Creates a cgroup at /sys/fs/cgroup/veristat-accounting-<pid>,
+ * moves current process to this cgroup.
+ */
+static void create_stat_cgroup(void)
+{
+	char cgroup_fs_mount[PATH_MAX];
+	char buf[PATH_MAX];
+	int err;
+
+	env.memory_peak_fd = -1;
+
+	if (!output_stat_enabled(MEMORY_PEAK))
+		return;
+
+	err = scanf_one_line("/proc/self/mounts", 2, "%*s %4095s cgroup2 %s",
+			     cgroup_fs_mount, buf);
+	if (err != 2) {
+		if (err < 0)
+			log_errno("reading /proc/self/mounts");
+		else if (!env.quiet)
+			fprintf(stderr, "Can't find cgroupfs v2 mount point.\n");
+		goto err_out;
+	}
+
+	/* cgroup-v2.rst promises the line "0::<group>" for cgroups v2 */
+	err = scanf_one_line("/proc/self/cgroup", 1, "0::%4095s", buf);
+	if (err != 1) {
+		if (err < 0)
+			log_errno("reading /proc/self/cgroup");
+		else if (!env.quiet)
+			fprintf(stderr, "Can't infer veristat process cgroup.");
+		goto err_out;
+	}
+
+	snprintf(env.orig_cgroup, sizeof(env.orig_cgroup), "%s/%s", cgroup_fs_mount, buf);
+
+	snprintf(buf, sizeof(buf), "%s/veristat-accounting-%d", cgroup_fs_mount, getpid());
+	err = mkdir(buf, 0777);
+	if (err < 0) {
+		log_errno("creation of cgroup %s", buf);
+		goto err_out;
+	}
+	strcpy(env.stat_cgroup, buf);
+
+	snprintf(buf, sizeof(buf), "%s/cgroup.procs", env.stat_cgroup);
+	err = write_one_line(buf, "%d\n", getpid());
+	if (err < 0) {
+		log_errno("entering cgroup %s", buf);
+		goto err_out;
+	}
+
+	snprintf(buf, sizeof(buf), "%s/memory.peak", env.stat_cgroup);
+	env.memory_peak_fd = open(buf, O_RDWR | O_APPEND);
+	if (env.memory_peak_fd < 0) {
+		log_errno("opening %s", buf);
+		goto err_out;
+	}
+
+	return;
+
+err_out:
+	if (!env.quiet)
+		fprintf(stderr, "Memory usage metric unavailable.\n");
+	destroy_stat_cgroup();
+}
+
+/* Current value of /sys/fs/cgroup/veristat-accounting-<pid>/memory.peak */
+static long cgroup_memory_peak(void)
+{
+	long err, memory_peak;
+	char buf[32];
+
+	if (env.memory_peak_fd < 0)
+		return -1;
+
+	err = pread(env.memory_peak_fd, buf, sizeof(buf) - 1, 0);
+	if (err <= 0) {
+		log_errno("pread(%s/memory.peak)", env.stat_cgroup);
+		return -1;
+	}
+
+	buf[err] = 0;
+	errno = 0;
+	memory_peak = strtoll(buf, NULL, 10);
+	if (errno) {
+		log_errno("%s/memory.peak:strtoll(%s)", env.stat_cgroup, buf);
+		return -1;
+	}
+
+	return memory_peak;
+}
+
+static int reset_stat_cgroup(void)
+{
+	char buf[] = "r\n";
+	int err;
+
+	if (env.memory_peak_fd < 0)
+		return -1;
+
+	err = pwrite(env.memory_peak_fd, buf, sizeof(buf), 0);
+	if (err <= 0) {
+		log_errno("pwrite(%s/memory.peak)", env.stat_cgroup);
+		return -1;
+	}
+	return 0;
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
 	const char *prog_name = bpf_program__name(prog);
+	long mem_peak_a, mem_peak_b, mem_peak = -1;
 	char *buf;
 	int buf_sz, log_level;
 	struct verif_stats *stats;
 	struct bpf_prog_info info;
 	__u32 info_len = sizeof(info);
-	int err = 0;
+	int err = 0, cgroup_err;
 	void *tmp;
 	int fd;
 
@@ -1332,7 +1551,15 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	if (env.force_reg_invariants)
 		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG_INVARIANTS);
 
-	err = bpf_object__load(obj);
+	err = bpf_object__prepare(obj);
+	if (!err) {
+		cgroup_err = reset_stat_cgroup();
+		mem_peak_a = cgroup_memory_peak();
+		err = bpf_object__load(obj);
+		mem_peak_b = cgroup_memory_peak();
+		if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
+			mem_peak = mem_peak_b - mem_peak_a;
+	}
 	env.progs_processed++;
 
 	stats->file_name = strdup(base_filename);
@@ -1341,6 +1568,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	stats->stats[SIZE] = bpf_program__insn_cnt(prog);
 	stats->stats[PROG_TYPE] = bpf_program__type(prog);
 	stats->stats[ATTACH_TYPE] = bpf_program__expected_attach_type(prog);
+	stats->stats[MEMORY_PEAK] = mem_peak < 0 ? -1 : mem_peak / (1024 * 1024);
 
 	memset(&info, 0, info_len);
 	fd = bpf_program__fd(prog);
@@ -1824,6 +2052,7 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
 	case TOTAL_STATES:
 	case PEAK_STATES:
 	case MAX_STATES_PER_INSN:
+	case MEMORY_PEAK:
 	case MARK_READ_MAX_LEN: {
 		long v1 = s1->stats[id];
 		long v2 = s2->stats[id];
@@ -2053,6 +2282,7 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
 	case STACK:
 	case SIZE:
 	case JITED_SIZE:
+	case MEMORY_PEAK:
 		*val = s ? s->stats[id] : 0;
 		break;
 	default:
@@ -2139,6 +2369,7 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
 	case MARK_READ_MAX_LEN:
 	case SIZE:
 	case JITED_SIZE:
+	case MEMORY_PEAK:
 	case STACK: {
 		long val;
 		int err, n;
@@ -2776,7 +3007,7 @@ static void output_prog_stats(void)
 
 static int handle_verif_mode(void)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (env.filename_cnt == 0) {
 		fprintf(stderr, "Please provide path to BPF object file!\n\n");
@@ -2784,11 +3015,12 @@ static int handle_verif_mode(void)
 		return -EINVAL;
 	}
 
+	create_stat_cgroup();
 	for (i = 0; i < env.filename_cnt; i++) {
 		err = process_obj(env.filenames[i]);
 		if (err) {
 			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], err);
-			return err;
+			goto out;
 		}
 	}
 
@@ -2796,7 +3028,9 @@ static int handle_verif_mode(void)
 
 	output_prog_stats();
 
-	return 0;
+out:
+	destroy_stat_cgroup();
+	return err;
 }
 
 static int handle_replay_mode(void)
-- 
2.47.1


