Return-Path: <bpf+bounces-59811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BC4ACF9E7
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 01:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87D816B7F1
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 23:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960CF27FD50;
	Thu,  5 Jun 2025 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keHUSHLb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F527EC80
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749164788; cv=none; b=CHwNMVSU7N7pY93msVy9TGZEpvz0CVkgbxHRywAkKuNHfLJgGjGhg7rRTEW/n/DBft9ym1OHcVUbMLqcYP/veSUsiv3+XFK2SWUWXVcE4GaFj3WDHFz9nK6WhWg8Gj9iO5i0sfNKtukq1lEak0p/E+Dj/NFVYHg4mCyJoox3dLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749164788; c=relaxed/simple;
	bh=jPIJL9FlAX/lU39nEOaSf3WEVTd8w8xutf3qfjPbmQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMC8XUPXGCuKyEreDQ7p1IFK4zia7iMkP5Wfl5pTCfSwHFUYzsueQ5HmuHMaEhwKVtabDdzW2ZxC2kxK4BkOdZnBpwdqkT2SoeAUYp6l0gfq//5KgfCQRRwT91jmD114FYdyn2xNB74muQ0LFfRVPJL8Dqj+sOAmpjf9QuT38SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keHUSHLb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235d6de331fso18603425ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749164785; x=1749769585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqYFWdewp8luQfcrbOfstRmAc1ziw0UEzhWQ4/IVDU0=;
        b=keHUSHLbkwhoENQAosoz79krtsx/1dFyIH9di6+t9gWH/E0FkZn4Z6PNsYTyleSS06
         AWftuwwm3lXKRr+TnYj4+hmCG/BCPhwVsWO8Pv44q51b7sUbztWG9pCNSbPItNZDS1Hu
         LgU/uyd+ZvO0CFeUs0HzIoiu4yDqbKjU+vVPkf4Ec+AfmYwpXIckUcOqLXQ0NGV81HYw
         axGjxzQYLSsEZrFaZV6B1jtXO4RMXA+ZmG9p9dUe1Tqko5NodLxZo58UmTBVqDoT6aw4
         uCoQ1fuhERk1A67wS2GeSR3/HCl4PIbGNWHbiIVG2RhA/igMjxF9qjcAJWHT2Nbq89Pk
         DjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749164785; x=1749769585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqYFWdewp8luQfcrbOfstRmAc1ziw0UEzhWQ4/IVDU0=;
        b=OXvZ+Yl5Ci81KNdOtxoMFCAcRLTVtNmxmVHJ6+REgvUBvFWoAbpfKG2n/Kxw0pJ/K4
         /5Ebp5URUu8kZSdOcX9lpwHxCg1n5GTfbudTLOSTBvs4RaklelVyVxb4OzH7fEypKneG
         HtmaEambhxVqPuWx8p1k3V2+RK/WqB8Kj909A3cQyL1KyxSLYt79MJeaXhB8SpO4BgJ9
         W+jMC9A3FVgWHYvoNRQ2uxPKYQ7XJJerNKrFImwKZZmXGWPBMcB79uFSh2X9oGdgtA3w
         dKg2mSiInHsddIrHFcDvrQdIKw5K4ZZbLsTXodubZB2OWCb6zHFSibosOjsh8466JsPX
         K5zw==
X-Gm-Message-State: AOJu0Yw4A6NzDTPmSmDxQymET+0noYEjGjbirGNBZio3OR1Shz6s0++/
	2tsRm5miBB63fM3NCeQYiHQbfStzQTTuVSXLM3pjIeEL+XYR+UADlfNpcltn3kOHBf0=
X-Gm-Gg: ASbGncsURKG0PtoG151CkJUmhwgQnjsky6/3wjlyAbDnhv+UF/3J/xzNi26gnZFBTlI
	D8yYrxUA3lcM46WTd1AhXqI7Gbj/XwW3RFkIIGFwW/UDrfT+EH1soyuQKlDy+pH4uU64Tb0lAc2
	RNT9nIiAbUJgBn85zXB5TSXvXoanbPIRu9KSRC4F/hAPIjG2cCSWBy0rkNnt8hSVe7kykz5f544
	axR/JnpKMhHT74J+QYCQnMRhtKDLLlgcSBjCJbUwEpXJN+3h5yFImxzFQasZpL5C8N3LhM3I226
	0QvhcjKzc5y5Kx2j2ticG1xZqD/oePVM+YdduxJTv/MgEfWhKfljuces/g==
X-Google-Smtp-Source: AGHT+IE27vl7wfizJM2J6dtmh/rsYOr/rkmKXGAaP4XtFTmSFibDtEyWCDWorWfV15NmlK1DzML3iw==
X-Received: by 2002:a17:902:ce12:b0:234:ef42:5d5b with SMTP id d9443c01a7336-23601cf8db4mr16612355ad.16.1749164785219;
        Thu, 05 Jun 2025 16:06:25 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092635sm1305655ad.81.2025.06.05.16.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:06:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf programs
Date: Thu,  5 Jun 2025 16:06:09 -0700
Message-ID: <20250605230609.1444980-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250605230609.1444980-1-eddyz87@gmail.com>
References: <20250605230609.1444980-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a new field mem_peak / "Peak memory" field to a set
of gathered statistics. The field is intended as an estimate for peak
verifier memory consumption for processing of a given program.

Mechanically stat is collected as follows:
- At the beginning of handle_verif_mode() a new cgroup namespace is
  created and cgroup fs is mounted in this namespace, memory
  controller is enabled for the root cgroup.
- At each program load:
  - bpf_object__load() is split into bpf_object__prepare() and
    bpf_object__load() to avoid accounting for memory allocated for
    maps;
  - before bpf_object__load() a new cgroup is created and veristat
    process enters this cgroup, "memory.peak" of the new cgroup is
    stashed;
  - after bpf_object__load() the difference between current
    "memory.peak" and stashed "memory.peak" is used as a metric,
    veristat exits the cgroup and cgroup is discarded.

If any of the above steps fails veristat would proceed w/o collecting
mem_peak information for a program.

The change has impact on veristat running time, e.g. for all
test_progs object files there is an increase from 82s to 102s.

I take a correlation between "Peak states" and "Peak memory" fields as
a sanity check for gathered statistics, e.g. here is a sample of data
for sched_ext programs:

File       Program               Peak states  Peak memory (KiB)
---------  --------------------  -----------  -----------------
bpf.bpf.o  lavd_select_cpu              1311              26256
bpf.bpf.o  lavd_enqueue                 1140              22720
bpf.bpf.o  layered_enqueue               777              11504
bpf.bpf.o  layered_dispatch              578               7976
bpf.bpf.o  lavd_dispatch                 634               6204
bpf.bpf.o  rusty_init                    343               5352
bpf.bpf.o  lavd_init                     361               5092
...
bpf.bpf.o  rusty_exit_task                36                256
bpf.bpf.o  rusty_running                  19                256
bpf.bpf.o  bpfland_dispatch                3                  0
bpf.bpf.o  bpfland_enable                  1                  0

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 249 ++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2bb20b00952..e68f5dda5278 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -12,6 +12,7 @@
 #include <signal.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <sys/mount.h>
 #include <sys/time.h>
 #include <sys/sysinfo.h>
 #include <sys/stat.h>
@@ -49,6 +50,7 @@ enum stat_id {
 	STACK,
 	PROG_TYPE,
 	ATTACH_TYPE,
+	MEMORY_PEAK,
 
 	FILE_NAME,
 	PROG_NAME,
@@ -208,6 +210,9 @@ static struct env {
 	int top_src_lines;
 	struct var_preset *presets;
 	int npresets;
+	char cgroup_fs_mount[PATH_MAX + 1];
+	char stat_cgroup[PATH_MAX + 1];
+	int memory_peak_fd;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -219,6 +224,22 @@ static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va
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
+	fprintf(stderr, " failed with error '%s'\n", strerror(errno));
+	va_end(ap);
+	return err;
+}
+
 #ifndef VERISTAT_VERSION
 #define VERISTAT_VERSION "<kernel>"
 #endif
@@ -734,13 +755,13 @@ static int append_file_from_file(const char *path)
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
 
@@ -781,6 +802,7 @@ static struct stat_def {
 	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
 	[PROG_TYPE] = { "Program type", {"prog_type"}, },
 	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
+	[MEMORY_PEAK] = { "Peak memory (KiB)", {"mem_peak", }, },
 };
 
 static bool parse_stat_id_var(const char *name, size_t len, int *id,
@@ -1278,16 +1300,213 @@ static int max_verifier_log_size(void)
 	return log_size;
 }
 
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
+/*
+ * This works around GCC warning about snprintf truncating strings like:
+ *
+ *   char a[PATH_MAX], b[PATH_MAX];
+ *   snprintf(a, "%s/foo", b);      // triggers -Wformat-truncation
+ */
+__printf(3, 4)
+static int snprintf_trunc(char *str, volatile size_t size, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = vsnprintf(str, size, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+
+static void destroy_stat_cgroup(void);
+static void umount_cgroupfs(void);
+
+/*
+ * Enters new cgroup namespace and mounts cgroupfs at /tmp/veristat-cgroup-mount-XXXXXX,
+ * enables "memory" controller for the root cgroup.
+ */
+static int mount_cgroupfs(void)
+{
+	char buf[PATH_MAX + 1];
+	int err;
+
+	env.memory_peak_fd = -1;
+
+	err = unshare(CLONE_NEWCGROUP);
+	if (err < 0) {
+		err = log_errno("unshare(CLONE_NEWCGROUP)");
+		goto err_out;
+	}
+
+	snprintf_trunc(buf, sizeof(buf), "%s/veristat-cgroup-mount-XXXXXX", P_tmpdir);
+	if (mkdtemp(buf) == NULL) {
+		err = log_errno("mkdtemp(%s)", buf);
+		goto err_out;
+	}
+	strcpy(env.cgroup_fs_mount, buf);
+
+	err = mount("none", env.cgroup_fs_mount, "cgroup2", 0, NULL);
+	if (err < 0) {
+		err = log_errno("mount none %s -t cgroup2", env.cgroup_fs_mount);
+		goto err_out;
+	}
+
+	snprintf_trunc(buf, sizeof(buf), "%s/cgroup.subtree_control", env.cgroup_fs_mount);
+	err = write_one_line(buf, "+memory\n");
+	if (err < 0) {
+		err = log_errno("echo '+memory' > %s", buf);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	umount_cgroupfs();
+	return err;
+}
+
+static void umount_cgroupfs(void)
+{
+	int err;
+
+	if (!env.cgroup_fs_mount[0])
+		return;
+
+	err = umount(env.cgroup_fs_mount);
+	if (err < 0)
+		log_errno("umount %s", env.cgroup_fs_mount);
+
+	err = rmdir(env.cgroup_fs_mount);
+	if (err < 0)
+		log_errno("rmdir %s", env.cgroup_fs_mount);
+
+	env.cgroup_fs_mount[0] = 0;
+}
+
+/*
+ * Creates a cgroup at /tmp/veristat-cgroup-mount-XXXXXX/accounting-<pid>,
+ * moves current process to this cgroup.
+ */
+static int create_stat_cgroup(void)
+{
+	char buf[PATH_MAX + 1];
+	int err;
+
+	if (!env.cgroup_fs_mount[0])
+		return -1;
+
+	env.memory_peak_fd = -1;
+
+	snprintf_trunc(buf, sizeof(buf), "%s/accounting-%d", env.cgroup_fs_mount, getpid());
+	err = mkdir(buf, 0777);
+	if (err < 0) {
+		err = log_errno("mkdir(%s)", buf);
+		goto err_out;
+	}
+	strcpy(env.stat_cgroup, buf);
+
+	snprintf_trunc(buf, sizeof(buf), "%s/cgroup.procs", env.stat_cgroup);
+	err = write_one_line(buf, "%d\n", getpid());
+	if (err < 0) {
+		err = log_errno("echo %d > %s", getpid(), buf);
+		goto err_out;
+	}
+
+	snprintf_trunc(buf, sizeof(buf), "%s/memory.peak", env.stat_cgroup);
+	env.memory_peak_fd = open(buf, O_RDWR | O_APPEND);
+	if (env.memory_peak_fd < 0) {
+		err = log_errno("open(%s)", buf);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	destroy_stat_cgroup();
+	return err;
+}
+
+static void destroy_stat_cgroup(void)
+{
+	char buf[PATH_MAX];
+	int err;
+
+	close(env.memory_peak_fd);
+
+	if (env.cgroup_fs_mount[0]) {
+		snprintf_trunc(buf, sizeof(buf), "%s/cgroup.procs", env.cgroup_fs_mount);
+		err = write_one_line(buf, "%d\n", getpid());
+		if (err < 0)
+			log_errno("echo %d > %s", getpid(), buf);
+	}
+
+	if (env.stat_cgroup[0]) {
+		err = rmdir(env.stat_cgroup);
+		if (err < 0)
+			log_errno("rmdir %s", env.stat_cgroup);
+	}
+
+	env.stat_cgroup[0] = 0;
+}
+
+/* Current value of /tmp/veristat-cgroup-mount-XXXXXX/accounting-<pid>/memory.peak */
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
+		log_errno("read(%s/memory.peak)", env.stat_cgroup);
+		return -1;
+	}
+
+	buf[err] = 0;
+	errno = 0;
+	memory_peak = strtoll(buf, NULL, 10);
+	if (errno) {
+		log_errno("unrecognized %s/memory.peak format: %s", env.stat_cgroup, buf);
+		return -1;
+	}
+
+	return memory_peak;
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
 
@@ -1332,7 +1551,16 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	if (env.force_reg_invariants)
 		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG_INVARIANTS);
 
-	err = bpf_object__load(obj);
+	err = bpf_object__prepare(obj);
+	if (!err) {
+		cgroup_err = create_stat_cgroup();
+		mem_peak_a = cgroup_memory_peak();
+		err = bpf_object__load(obj);
+		mem_peak_b = cgroup_memory_peak();
+		destroy_stat_cgroup();
+		if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
+			mem_peak = mem_peak_b - mem_peak_a;
+	}
 	env.progs_processed++;
 
 	stats->file_name = strdup(base_filename);
@@ -1341,6 +1569,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	stats->stats[SIZE] = bpf_program__insn_cnt(prog);
 	stats->stats[PROG_TYPE] = bpf_program__type(prog);
 	stats->stats[ATTACH_TYPE] = bpf_program__expected_attach_type(prog);
+	stats->stats[MEMORY_PEAK] = mem_peak < 0 ? -1 : mem_peak / 1024;
 
 	memset(&info, 0, info_len);
 	fd = bpf_program__fd(prog);
@@ -1824,6 +2053,7 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
 	case TOTAL_STATES:
 	case PEAK_STATES:
 	case MAX_STATES_PER_INSN:
+	case MEMORY_PEAK:
 	case MARK_READ_MAX_LEN: {
 		long v1 = s1->stats[id];
 		long v2 = s2->stats[id];
@@ -2053,6 +2283,7 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
 	case STACK:
 	case SIZE:
 	case JITED_SIZE:
+	case MEMORY_PEAK:
 		*val = s ? s->stats[id] : 0;
 		break;
 	default:
@@ -2139,6 +2370,7 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
 	case MARK_READ_MAX_LEN:
 	case SIZE:
 	case JITED_SIZE:
+	case MEMORY_PEAK:
 	case STACK: {
 		long val;
 		int err, n;
@@ -2776,7 +3008,7 @@ static void output_prog_stats(void)
 
 static int handle_verif_mode(void)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (env.filename_cnt == 0) {
 		fprintf(stderr, "Please provide path to BPF object file!\n\n");
@@ -2784,11 +3016,12 @@ static int handle_verif_mode(void)
 		return -EINVAL;
 	}
 
+	mount_cgroupfs();
 	for (i = 0; i < env.filename_cnt; i++) {
 		err = process_obj(env.filenames[i]);
 		if (err) {
 			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], err);
-			return err;
+			goto out;
 		}
 	}
 
@@ -2796,7 +3029,9 @@ static int handle_verif_mode(void)
 
 	output_prog_stats();
 
-	return 0;
+out:
+	umount_cgroupfs();
+	return err;
 }
 
 static int handle_replay_mode(void)
-- 
2.48.1


