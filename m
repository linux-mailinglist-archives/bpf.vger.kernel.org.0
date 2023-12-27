Return-Path: <bpf+bounces-18692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B25181EDF6
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DB01F21D1B
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904C2C87A;
	Wed, 27 Dec 2023 10:01:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C829411
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VzKmKBW_1703671295;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VzKmKBW_1703671295)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 18:01:36 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	joannelkoong@gmail.com,
	laoar.shao@gmail.com,
	kuifeng@meta.com,
	houtao@huaweicloud.com,
	shung-hsi.yu@suse.com,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: add bpf relay map selftests
Date: Wed, 27 Dec 2023 18:01:30 +0800
Message-Id: <20231227100130.84501-4-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231227100130.84501-1-lulie@linux.alibaba.com>
References: <20231227100130.84501-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The operations of relay map create, update_elem, and output are tested.
The test is borrowed from ringbuf tests, where 2 samples are written
into the relay channel, and we get the samples by reading the files.
Overwriting mode is also tested, where the size of relay buffer equals
sample size and just the last sample can be seen.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/relay_map.c      | 197 ++++++++++++++++++
 .../selftests/bpf/progs/test_relay_map.c      |  69 ++++++
 5 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/relay_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_relay_map.c

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f24d898efbb..1e545bfe701f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -951,6 +951,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	BPF_MAP_TYPE_RELAY,
 };
 
 /* Note that tracing related programs such as
@@ -1330,6 +1331,9 @@ enum {
 
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		= (1U << 14),
+
+/* Enable overwrite for relay map */
+	BPF_F_OVERWRITE		= (1U << 15),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1401,6 +1405,9 @@ union bpf_attr {
 		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
 		 * number of hash functions (if 0, the bloom filter will default
 		 * to using 5 hash functions).
+		 *
+		 * BPF_MAP_TYPE_RELAY - the lowest 32 bits indicate the number of
+		 * relay subbufs (if 0, the number will be set to 8 by default).
 		 */
 		__u64	map_extra;
 	};
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 617ae55c3bb5..8cebb3810d50 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -427,7 +427,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_map_key.c
+	test_ringbuf_map_key.c test_relay_map.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c125c441abc7..8de1adf587f0 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -87,3 +87,4 @@ CONFIG_VSOCKETS=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
+CONFIG_RELAY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/relay_map.c b/tools/testing/selftests/bpf/prog_tests/relay_map.c
new file mode 100644
index 000000000000..bd9c1e62ca78
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/relay_map.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/compiler.h>
+#include <linux/bpf.h>
+#include <sys/sysinfo.h>
+#include <test_progs.h>
+#include <sched.h>
+
+#include "test_relay_map.lskel.h"
+
+static int duration;
+
+/* file names in debugfs */
+static const char dirname[]		= "relay_map_selftest";
+static const char mapname[]		= "relay_map";
+static const char mapname_ow[]	= "relay_map_ow";
+struct relay_sample {
+	int pid;
+	int seq;
+	long value;
+	char comm[16];
+};
+
+static int sample_cnt;
+static int overwrite;
+
+static void process_sample(struct relay_sample *s)
+{
+	++sample_cnt;
+
+	switch (s->seq) {
+	case 0:
+		/* sample1 will not appear in overwrite mode */
+		CHECK(overwrite != 0, "overwrite_mode",
+		      "sample1 appears in overwrite mode\n");
+		CHECK(s->value != 333, "sample1_value", "exp %ld, got %ld\n",
+		      333L, s->value);
+		break;
+	case 1:
+		CHECK(s->value != 777, "sample2_value", "exp %ld, got %ld\n",
+		      777L, s->value);
+		break;
+	default:
+		break;
+	}
+}
+
+static int relaymap_read(const char *mapname)
+{
+	int cpu = libbpf_num_possible_cpus();
+	char name[NAME_MAX];
+	struct relay_sample data;
+	int maxloop;
+	FILE *fp;
+
+	for (int i = 0; i < cpu; ++i) {
+		sprintf(name, "/sys/kernel/debug/%s/%s%d", dirname, mapname, i);
+		fp = fopen(name, "r");
+		if (CHECK(!fp, "fopen", "relay file open failed\n"))
+			return -1;
+
+		maxloop = 0;
+		while (fread(&data, sizeof(data), 1, fp)) {
+			process_sample(&data);
+
+			/* just 2 samples output */
+			if (++maxloop > 2)
+				return -1;
+		}
+	}
+	return 0;
+}
+
+static struct test_relay_map_lskel *skel;
+
+static void trigger_samples(void)
+{
+	skel->bss->dropped = 0;
+	skel->bss->total = 0;
+	skel->bss->seq = 0;
+
+	/* trigger exactly two samples */
+	skel->bss->value = 333;
+	syscall(__NR_getpgid);
+	skel->bss->value = 777;
+	syscall(__NR_getpgid);
+}
+
+static void relaymap_subtest(void)
+{
+	int err, map_fd;
+
+	skel = test_relay_map_lskel__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		return;
+
+	/* setup relay param */
+	skel->maps.relay_map.max_entries = 1024;
+
+	err = test_relay_map_lskel__load(skel);
+	if (CHECK(err, "skel_load", "skeleton load failed\n"))
+		goto cleanup;
+
+	/* only trigger BPF program for current process */
+	skel->bss->pid = getpid();
+
+	/* turn off overwrite */
+	skel->bss->overwrite_enable = 0;
+	overwrite = skel->bss->overwrite_enable;
+
+	err = test_relay_map_lskel__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n", err))
+		goto cleanup;
+
+	/* before file setup - output failed */
+	trigger_samples();
+	CHECK(skel->bss->dropped != 2, "err_dropped", "exp %ld, got %ld\n",
+	      0L, skel->bss->dropped);
+	CHECK(skel->bss->total != 2, "err_total", "exp %ld, got %ld\n",
+	      2L, skel->bss->total);
+
+	/* after file setup - output succ */
+	map_fd = skel->maps.relay_map.map_fd;
+	err = bpf_map_update_elem(map_fd, NULL, dirname, 0);
+	if (CHECK(err, "map_update", "map update failed: %d\n", err))
+		goto cleanup;
+	trigger_samples();
+	CHECK(skel->bss->dropped != 0, "err_dropped", "exp %ld, got %ld\n",
+	      0L, skel->bss->dropped);
+	CHECK(skel->bss->total != 2, "err_total", "exp %ld, got %ld\n",
+	      2L, skel->bss->total);
+
+	sample_cnt = 0;
+	err = relaymap_read(mapname);
+	CHECK(sample_cnt != 2, "sample_cnt", "exp %d samples, got %d\n",
+		   2, sample_cnt);
+
+	test_relay_map_lskel__detach(skel);
+cleanup:
+	test_relay_map_lskel__destroy(skel);
+}
+
+static void relaymap_overwrite_subtest(void)
+{
+	int err, map_fd;
+
+	skel = test_relay_map_lskel__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		return;
+
+	/* To test overwrite mode, we create subbuf of one-sample size */
+	skel->maps.relay_map_ow.max_entries = sizeof(struct relay_sample);
+
+	err = test_relay_map_lskel__load(skel);
+	if (CHECK(err, "skel_load", "skeleton load failed\n"))
+		goto cleanup;
+
+	/* only trigger BPF program for current process */
+	skel->bss->pid = getpid();
+
+	/* turn on overwrite */
+	skel->bss->overwrite_enable = 1;
+	overwrite = skel->bss->overwrite_enable;
+
+	err = test_relay_map_lskel__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n", err))
+		goto cleanup;
+
+	map_fd = skel->maps.relay_map_ow.map_fd;
+	err = bpf_map_update_elem(map_fd, NULL, dirname, 0);
+	if (CHECK(err, "map_update", "map update failed: %d\n", err))
+		goto cleanup;
+	trigger_samples();
+	/* relay_write never fails whether overwriting or not */
+	CHECK(skel->bss->dropped != 0, "err_dropped", "exp %ld, got %ld\n",
+	      0L, skel->bss->dropped);
+	CHECK(skel->bss->total != 2, "err_total", "exp %ld, got %ld\n",
+	      2L, skel->bss->total);
+
+	/* 2 samples are output, but only the last (val=777) could be seen */
+	sample_cnt = 0;
+	err = relaymap_read(mapname_ow);
+	CHECK(sample_cnt != 1, "sample_cnt", "exp %d samples, got %d\n",
+		   1, sample_cnt);
+
+	test_relay_map_lskel__detach(skel);
+cleanup:
+	test_relay_map_lskel__destroy(skel);
+}
+
+void test_relaymap(void)
+{
+	if (test__start_subtest("relaymap"))
+		relaymap_subtest();
+	if (test__start_subtest("relaymap_overwrite"))
+		relaymap_overwrite_subtest();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_relay_map.c b/tools/testing/selftests/bpf/progs/test_relay_map.c
new file mode 100644
index 000000000000..1adf1be8e125
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_relay_map.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern int bpf_relay_output(struct bpf_map *map, void *data,
+				      __u64 data__sz, __u32 flags) __ksym;
+
+struct relay_sample {
+	int pid;
+	int seq;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RELAY);
+	__uint(max_entries, 1024);
+} relay_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RELAY);
+	__uint(map_flags, BPF_F_OVERWRITE);
+	__uint(max_entries, 1024);
+	__uint(map_extra, 1);
+} relay_map_ow SEC(".maps");
+
+/* inputs */
+int pid = 0;
+long value = 0;
+int overwrite_enable = 0;
+
+/* outputs */
+long total = 0;
+long dropped = 0;
+
+/* inner state */
+long seq = 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_bpf_relaymap(void *ctx)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	struct relay_sample sample;
+	int ret = 0;
+
+	if (cur_pid != pid)
+		return 0;
+
+	sample.pid = pid;
+	bpf_get_current_comm(sample.comm, sizeof(sample.comm));
+	sample.value = value;
+	sample.seq = seq++;
+	__sync_fetch_and_add(&total, 1);
+
+	if (overwrite_enable)
+		ret = bpf_relay_output((struct bpf_map *)&relay_map_ow,
+				      &sample, sizeof(sample), 0);
+	else
+		ret = bpf_relay_output((struct bpf_map *)&relay_map,
+				      &sample, sizeof(sample), 0);
+
+	if (ret)
+		__sync_fetch_and_add(&dropped, 1);
+
+	return 0;
+}
-- 
2.32.0.3.g01195cf9f


