Return-Path: <bpf+bounces-38625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0BB966D2F
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 02:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDC1284C83
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 00:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F428EF;
	Sat, 31 Aug 2024 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Z/DQgEsW"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40010193
	for <bpf@vger.kernel.org>; Sat, 31 Aug 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063015; cv=none; b=ro3dC8rQVYeX34BxxUTVkJJk0epitjRFcQlEeDM9uHirXccM3Gaqg7G46aqo17jDHpGK9ZZYXN/YrQeBddL3pdBN9XuzAQi5TQkOG8ZvbTGpXFFmx8Ga1Mn1pXUtBrEiPzteBoiH29idyuuIMpFQsvX6+cQiKQGB9dcMkFkQx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063015; c=relaxed/simple;
	bh=3ELa3v7d0Sd3CCzs5ZLq9ROy55shKSmTqiKw5F2ANdM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LLmgJQ+xwI7+xOZSwtUJ+nlwLsCEZb+esksMT9Va/4pJ5UhIBwCO99GsLqEjPH0ORG3h2NUl8d0trbG8s+xCrqiORol3Edy+Pcx281RdJxqx3hahjTBwTyndKjdGkuyqiQIkrSkvSfZUqjyoPZnxQCTjkHeI/C7dLCw38l+W+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Z/DQgEsW; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725063008;
	bh=Pp5fbxH8Yz5IVta2/xKONO8NGXAM54UiF0c+o7rpJZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/DQgEsWAYLvBxp1N0Pq7uoNALzXH+UUIIEbnQd0VziRynZ3+SuTT/aSNV4S6LMGM
	 dbbOotApRGAYkPAXpcldXglI8vBbE8US5xripy1c3qZj7cFpaDqdRgjSjsZod+Gli8
	 C72JvwG2rcGrEVapn2Ldt7gnF/LzGiuR0ooDy9t0=
Received: from rtoax.lan ([120.245.115.147])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id EE3BE3C; Sat, 31 Aug 2024 08:03:46 +0800
X-QQ-mid: xmsmtpt1725062626tuusdn36m
Message-ID: <tencent_30ADAC88CB2915CA57E9512D4460035BA107@qq.com>
X-QQ-XMAILINFO: OW8rLgt5YFkGLOQfs+m1UIYMbW/SmndDdxI5lTRMX6seJPklYhm+kmfeD4xWmt
	 0fDEIHZosBprGbqHiywUg/j5bM850XjeLHYiUFLfdUxkg2sAPMALSABa+CGjzvpfdpbnwgIlnJYq
	 gTymTP5b/A1mfTT01+UvQzHQASIBrEkXlaiISJXAV+vsU4cHMNnNJmyeIfrOgNNdprQ9VMakFH6T
	 +7WUt/H7A9jMdMwXwcTEhEIvPS/8+fIUcoggPymD9B2+IukySjws4ekTxspPPhMp3y8Tn8p1D84v
	 1PnGwp3ILmtaiGdxuMqmbhu2n9mG+WZOf/30E3l2jI/iuSUUdRw0nltDqBnGZByGWnq5fT9ZU611
	 ShjV44/lfM7ViLqpeI0RMboTnv/qqRfEVzpIuL5x9GGoNEjUMw0fK9nhVfmzvOS47DoqKNu4ahqt
	 zpI4kb6UVjBNinqHowuHvibUC3TYHojHBvlULn81nyRF7Mp9tde3j7Cxu3MDvUQluRneOUttO5qt
	 x9n53q+B5J5EcvI9V+vMmgzOHJThaCcQ57jQeuSirFeXtGNIDPshe3zlfap/ulin0GoWxjm9g8Gi
	 Yl8F1aMiAjCrD2h32iwnavRj/vyxXxnuxfz8ZN1AgAaVO0ldociVK69C3akH4P/JLqJqBmakyziN
	 lf38rQOPe+8rStJ/LLmpZIQ5VDC/ar3uO/GQqZ/MO4xh7zNRRuIUpkegyClbS1eu8iU9iWbIkCcF
	 rxLq3NCOBokfDbpmHCEW8A3z1fwNgAwC1SMkj2GdIKmJYSBRaob1zA2BIfWYbLfMdvqzJnBQGt3R
	 sUPv8NA9tegwkMQ6l/zrKD4WtyFMvx7aAEAXz0TpiCWJ7Fq7WSGlHS0QPUjg+re6MCzVyxU716Pr
	 F4/2PIJoQXvXEEGCawz60fq0fG+BdzCjYLlAVnuSShbHVqyxY8SMP0zqZmS+gMGTCOo5ethWxjPO
	 1kl/23/HcOF+YntuCXXIvByiApTXUFkcrZftkwzLW8qtbbcoaFoThauxD5rroxcRvbAMyUnKo=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	rongtao@cestc.cn,
	rtoax@foxmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next] samples/bpf: Remove sample tracex2
Date: Sat, 31 Aug 2024 08:03:38 +0800
X-OQ-MSGID: <20240831000338.9813-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CAEf4BzaCW03xOp6=rSUqmy8DRFvGJWHy1LyGNdpP+D-D9Eo+Yw@mail.gmail.com>
References: <CAEf4BzaCW03xOp6=rSUqmy8DRFvGJWHy1LyGNdpP+D-D9Eo+Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

In commit ba8de796baf4 ("net: introduce sk_skb_reason_drop function")
kfree_skb_reason() becomes an inline function and cannot be traced.

samples/bpf is abandonware by now, and we should slowly but surely
convert whatever makes sense into BPF selftests under
tools/testing/selftests/bpf and just get rid of the rest.

Link: https://github.com/torvalds/linux/commit/ba8de796baf4bdc03530774fb284fe3c97875566
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/Makefile       |   3 -
 samples/bpf/tracex2.bpf.c  |  99 --------------------
 samples/bpf/tracex2_user.c | 187 -------------------------------------
 3 files changed, 289 deletions(-)
 delete mode 100644 samples/bpf/tracex2.bpf.c
 delete mode 100644 samples/bpf/tracex2_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index dca56aa360ff..7afe040cf43b 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -13,7 +13,6 @@ tprogs-y += sockex1
 tprogs-y += sockex2
 tprogs-y += sockex3
 tprogs-y += tracex1
-tprogs-y += tracex2
 tprogs-y += tracex3
 tprogs-y += tracex4
 tprogs-y += tracex5
@@ -63,7 +62,6 @@ sockex1-objs := sockex1_user.o
 sockex2-objs := sockex2_user.o
 sockex3-objs := sockex3_user.o
 tracex1-objs := tracex1_user.o $(TRACE_HELPERS)
-tracex2-objs := tracex2_user.o
 tracex3-objs := tracex3_user.o
 tracex4-objs := tracex4_user.o
 tracex5-objs := tracex5_user.o $(TRACE_HELPERS)
@@ -105,7 +103,6 @@ always-y += sockex1_kern.o
 always-y += sockex2_kern.o
 always-y += sockex3_kern.o
 always-y += tracex1.bpf.o
-always-y += tracex2.bpf.o
 always-y += tracex3.bpf.o
 always-y += tracex4.bpf.o
 always-y += tracex5.bpf.o
diff --git a/samples/bpf/tracex2.bpf.c b/samples/bpf/tracex2.bpf.c
deleted file mode 100644
index 0a5c75b367be..000000000000
--- a/samples/bpf/tracex2.bpf.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/* Copyright (c) 2013-2015 PLUMgrid, http://plumgrid.com
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#include "vmlinux.h"
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include <bpf/bpf_core_read.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, long);
-	__type(value, long);
-	__uint(max_entries, 1024);
-} my_map SEC(".maps");
-
-/* kprobe is NOT a stable ABI. If kernel internals change this bpf+kprobe
- * example will no longer be meaningful
- */
-SEC("kprobe/kfree_skb_reason")
-int bpf_prog2(struct pt_regs *ctx)
-{
-	long loc = 0;
-	long init_val = 1;
-	long *value;
-
-	/* read ip of kfree_skb_reason caller.
-	 * non-portable version of __builtin_return_address(0)
-	 */
-	BPF_KPROBE_READ_RET_IP(loc, ctx);
-
-	value = bpf_map_lookup_elem(&my_map, &loc);
-	if (value)
-		*value += 1;
-	else
-		bpf_map_update_elem(&my_map, &loc, &init_val, BPF_ANY);
-	return 0;
-}
-
-static unsigned int log2(unsigned int v)
-{
-	unsigned int r;
-	unsigned int shift;
-
-	r = (v > 0xFFFF) << 4; v >>= r;
-	shift = (v > 0xFF) << 3; v >>= shift; r |= shift;
-	shift = (v > 0xF) << 2; v >>= shift; r |= shift;
-	shift = (v > 0x3) << 1; v >>= shift; r |= shift;
-	r |= (v >> 1);
-	return r;
-}
-
-static unsigned int log2l(unsigned long v)
-{
-	unsigned int hi = v >> 32;
-	if (hi)
-		return log2(hi) + 32;
-	else
-		return log2(v);
-}
-
-struct hist_key {
-	char comm[16];
-	u64 pid_tgid;
-	u64 uid_gid;
-	u64 index;
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
-	__uint(key_size, sizeof(struct hist_key));
-	__uint(value_size, sizeof(long));
-	__uint(max_entries, 1024);
-} my_hist_map SEC(".maps");
-
-SEC("ksyscall/write")
-int BPF_KSYSCALL(bpf_prog3, unsigned int fd, const char *buf, size_t count)
-{
-	long init_val = 1;
-	long *value;
-	struct hist_key key;
-
-	key.index = log2l(count);
-	key.pid_tgid = bpf_get_current_pid_tgid();
-	key.uid_gid = bpf_get_current_uid_gid();
-	bpf_get_current_comm(&key.comm, sizeof(key.comm));
-
-	value = bpf_map_lookup_elem(&my_hist_map, &key);
-	if (value)
-		__sync_fetch_and_add(value, 1);
-	else
-		bpf_map_update_elem(&my_hist_map, &key, &init_val, BPF_ANY);
-	return 0;
-}
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/tracex2_user.c b/samples/bpf/tracex2_user.c
deleted file mode 100644
index 2131f1648cf1..000000000000
--- a/samples/bpf/tracex2_user.c
+++ /dev/null
@@ -1,187 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <string.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include "bpf_util.h"
-
-#define MAX_INDEX	64
-#define MAX_STARS	38
-
-/* my_map, my_hist_map */
-static int map_fd[2];
-
-static void stars(char *str, long val, long max, int width)
-{
-	int i;
-
-	for (i = 0; i < (width * val / max) - 1 && i < width - 1; i++)
-		str[i] = '*';
-	if (val > max)
-		str[i - 1] = '+';
-	str[i] = '\0';
-}
-
-struct task {
-	char comm[16];
-	__u64 pid_tgid;
-	__u64 uid_gid;
-};
-
-struct hist_key {
-	struct task t;
-	__u32 index;
-};
-
-#define SIZE sizeof(struct task)
-
-static void print_hist_for_pid(int fd, void *task)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct hist_key key = {}, next_key;
-	long values[nr_cpus];
-	char starstr[MAX_STARS];
-	long value;
-	long data[MAX_INDEX] = {};
-	int max_ind = -1;
-	long max_value = 0;
-	int i, ind;
-
-	while (bpf_map_get_next_key(fd, &key, &next_key) == 0) {
-		if (memcmp(&next_key, task, SIZE)) {
-			key = next_key;
-			continue;
-		}
-		bpf_map_lookup_elem(fd, &next_key, values);
-		value = 0;
-		for (i = 0; i < nr_cpus; i++)
-			value += values[i];
-		ind = next_key.index;
-		data[ind] = value;
-		if (value && ind > max_ind)
-			max_ind = ind;
-		if (value > max_value)
-			max_value = value;
-		key = next_key;
-	}
-
-	printf("           syscall write() stats\n");
-	printf("     byte_size       : count     distribution\n");
-	for (i = 1; i <= max_ind + 1; i++) {
-		stars(starstr, data[i - 1], max_value, MAX_STARS);
-		printf("%8ld -> %-8ld : %-8ld |%-*s|\n",
-		       (1l << i) >> 1, (1l << i) - 1, data[i - 1],
-		       MAX_STARS, starstr);
-	}
-}
-
-static void print_hist(int fd)
-{
-	struct hist_key key = {}, next_key;
-	static struct task tasks[1024];
-	int task_cnt = 0;
-	int i;
-
-	while (bpf_map_get_next_key(fd, &key, &next_key) == 0) {
-		int found = 0;
-
-		for (i = 0; i < task_cnt; i++)
-			if (memcmp(&tasks[i], &next_key, SIZE) == 0)
-				found = 1;
-		if (!found)
-			memcpy(&tasks[task_cnt++], &next_key, SIZE);
-		key = next_key;
-	}
-
-	for (i = 0; i < task_cnt; i++) {
-		printf("\npid %d cmd %s uid %d\n",
-		       (__u32) tasks[i].pid_tgid,
-		       tasks[i].comm,
-		       (__u32) tasks[i].uid_gid);
-		print_hist_for_pid(fd, &tasks[i]);
-	}
-
-}
-
-static void int_exit(int sig)
-{
-	print_hist(map_fd[1]);
-	exit(0);
-}
-
-int main(int ac, char **argv)
-{
-	long key, next_key, value;
-	struct bpf_link *links[2];
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	char filename[256];
-	int i, j = 0;
-	FILE *f;
-
-	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj)) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		return 0;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	map_fd[0] = bpf_object__find_map_fd_by_name(obj, "my_map");
-	map_fd[1] = bpf_object__find_map_fd_by_name(obj, "my_hist_map");
-	if (map_fd[0] < 0 || map_fd[1] < 0) {
-		fprintf(stderr, "ERROR: finding a map in obj file failed\n");
-		goto cleanup;
-	}
-
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
-
-	/* start 'ping' in the background to have some kfree_skb_reason
-	 * events */
-	f = popen("ping -4 -c5 localhost", "r");
-	(void) f;
-
-	/* start 'dd' in the background to have plenty of 'write' syscalls */
-	f = popen("dd if=/dev/zero of=/dev/null count=5000000", "r");
-	(void) f;
-
-	bpf_object__for_each_program(prog, obj) {
-		links[j] = bpf_program__attach(prog);
-		if (libbpf_get_error(links[j])) {
-			fprintf(stderr, "ERROR: bpf_program__attach failed\n");
-			links[j] = NULL;
-			goto cleanup;
-		}
-		j++;
-	}
-
-	for (i = 0; i < 5; i++) {
-		key = 0;
-		while (bpf_map_get_next_key(map_fd[0], &key, &next_key) == 0) {
-			bpf_map_lookup_elem(map_fd[0], &next_key, &value);
-			printf("location 0x%lx count %ld\n", next_key, value);
-			key = next_key;
-		}
-		if (key)
-			printf("\n");
-		sleep(1);
-	}
-	print_hist(map_fd[1]);
-
-cleanup:
-	for (j--; j >= 0; j--)
-		bpf_link__destroy(links[j]);
-
-	bpf_object__close(obj);
-	return 0;
-}
-- 
2.46.0


