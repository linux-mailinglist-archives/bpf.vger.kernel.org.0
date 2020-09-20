Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5550527150B
	for <lists+bpf@lfdr.de>; Sun, 20 Sep 2020 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgITOqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Sep 2020 10:46:04 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42796 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgITOqE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 20 Sep 2020 10:46:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U9V.p7K_1600613153;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U9V.p7K_1600613153)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 22:45:55 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, andriin@fb.com,
        xhao@linux.alibaba.com, bpf@vger.kernel.org
Subject: [bpf-next 3/3] samples/bpf: Add soft irq execution time statistics
Date:   Sun, 20 Sep 2020 22:45:47 +0800
Message-Id: <20200920144547.56771-4-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920144547.56771-1-xhao@linux.alibaba.com>
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch is aimed to count the execution time of
each soft irq and it supports log2 histogram display.

Soft irq counts:
     us	             : count    distribution

     0 -> 1	     : 151      |****************************************|
     2 -> 3          : 86       |**********************                  |
     4 -> 7          : 59       |***************                         |
     8 -> 15         : 20       |*****                                   |
    16 -> 31         : 3        |			                 |

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 samples/bpf/Makefile        |  3 ++
 samples/bpf/soft_irq_kern.c | 87 ++++++++++++++++++++++++++++++++++++
 samples/bpf/soft_irq_user.c | 88 +++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 samples/bpf/soft_irq_kern.c
 create mode 100644 samples/bpf/soft_irq_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index f87ee02073ba..0774f0fb8bdf 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -53,6 +53,7 @@ tprogs-y += task_fd_query
 tprogs-y += xdp_sample_pkts
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += soft_irq
 
 # Libbpf dependencies
 LIBBPF = $(TOOLS_PATH)/lib/bpf/libbpf.a
@@ -109,6 +110,7 @@ task_fd_query-objs := bpf_load.o task_fd_query_user.o $(TRACE_HELPERS)
 xdp_sample_pkts-objs := xdp_sample_pkts_user.o $(TRACE_HELPERS)
 ibumad-objs := bpf_load.o ibumad_user.o $(TRACE_HELPERS)
 hbm-objs := bpf_load.o hbm.o $(CGROUP_HELPERS)
+soft_irq-objs := bpf_load.o soft_irq_user.o $(TRACE_HELPERS)
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -170,6 +172,7 @@ always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
 always-y += xdpsock_kern.o
+always-y += soft_irq_kern.o
 
 ifeq ($(ARCH), arm)
 # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
diff --git a/samples/bpf/soft_irq_kern.c b/samples/bpf/soft_irq_kern.c
new file mode 100644
index 000000000000..e63f829cf7c7
--- /dev/null
+++ b/samples/bpf/soft_irq_kern.c
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ */
+
+#include <uapi/linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <uapi/linux/ptrace.h>
+#include <uapi/linux/perf_event.h>
+#include <linux/version.h>
+#include <linux/sched.h>
+#include "common_kern.h"
+
+typedef struct key {
+	u32 pid;
+	u32 cpu;
+} irqkey_t;
+
+typedef struct val {
+	u64 ts;
+	u32 vec;
+} val_t;
+
+typedef struct delta_irq {
+	u64 delta;
+    u32 value;
+} delta_irq_t;
+
+struct bpf_map_def SEC("maps") start = {
+	.type = BPF_MAP_TYPE_HASH,
+	.key_size = sizeof(irqkey_t),
+	.value_size = sizeof(val_t),
+	.max_entries = 1000,
+};
+
+struct soft_irq {
+	u64 pad;
+    u32 vec;
+};
+SEC("tracepoint/irq/softirq_entry")
+int entryirq(struct soft_irq *ctx)
+{
+    irqkey_t entry_key = {};
+	val_t val = {};
+
+	entry_key.pid = bpf_get_current_pid_tgid();
+    entry_key.cpu = bpf_get_smp_processor_id();
+
+	val.ts = bpf_ktime_get_ns();
+	val.vec = ctx->vec;
+
+	bpf_map_update_elem(&start, &entry_key, &val, BPF_ANY);
+	return 0;
+}
+
+struct bpf_map_def SEC("maps") over = {
+	.type = BPF_MAP_TYPE_HASH,
+	.key_size = sizeof(irqkey_t),
+	.value_size = sizeof(delta_irq_t),
+	.max_entries = 10000,
+};
+SEC("tracepoint/irq/softirq_exit")
+int exitirq(struct soft_irq *ctx)
+{
+    irqkey_t entry_key = {};
+	delta_irq_t delta_val = {};
+	val_t *valp;
+
+	entry_key.pid = bpf_get_current_pid_tgid();
+    entry_key.cpu = bpf_get_smp_processor_id();
+
+	valp = bpf_map_lookup_elem(&start, &entry_key);
+	if (valp) {
+		delta_val.delta = (bpf_ktime_get_ns() - valp->ts) / 1000; /* us */
+		delta_val.value = log2l(delta_val.delta);
+
+		bpf_map_update_elem(&over, &entry_key, &delta_val, BPF_ANY);
+		bpf_map_delete_elem(&start, valp);
+	}
+
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
+u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/soft_irq_user.c b/samples/bpf/soft_irq_user.c
new file mode 100644
index 000000000000..1bb338eb337c
--- /dev/null
+++ b/samples/bpf/soft_irq_user.c
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <linux/bpf.h>
+#include <string.h>
+#include <linux/perf_event.h>
+#include <errno.h>
+#include <assert.h>
+#include <stdbool.h>
+#include <sys/resource.h>
+#include <bpf/libbpf.h>
+#include "bpf_load.h"
+#include "trace_helpers.h"
+#include "common.h"
+
+#define MAX_SLOT_LEN 40
+
+struct hist {
+	unsigned int slots[MAX_SLOT_LEN];
+};
+
+struct hist new_hist;
+
+typedef struct delta_irq {
+	__u64 delta;
+    __u32 value;
+} delta_irq_t;
+
+typedef struct key {
+	__u32 pid;
+	__u32 cpu;
+} irqkey_t;
+
+static void print_hist(int fd)
+{
+    irqkey_t entry_key = {}, next_key;
+	delta_irq_t delta1;
+
+	printf("Soft irq counts: \n");
+	while (bpf_map_get_next_key(fd, &entry_key, &next_key) == 0) {
+		bpf_map_lookup_elem(fd, &next_key, &delta1);
+		new_hist.slots[delta1.value] += 1;
+		entry_key = next_key;
+	}
+	print_log2_hist(new_hist.slots, MAX_SLOT_LEN, "us");
+}
+
+static void int_exit(int sig)
+{
+	print_hist(map_fd[1]);
+	exit(0);
+}
+
+int main(int argc, char **argv)
+{
+	int i = 0;
+	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
+	char filename[256];
+
+	memset(&new_hist, 0, sizeof(struct hist));
+
+	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	setrlimit(RLIMIT_MEMLOCK, &r);
+
+	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
+
+	if (load_bpf_file(filename)) {
+		printf("%s", bpf_log_buf);
+		return 1;
+	}
+
+	while (i < 10)
+	{
+		sleep(5);
+		print_hist(map_fd[1]);
+		i++;
+	}
+	return 0;
+}
-- 
2.28.0

