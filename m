Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CE5B4C9F
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiIKIfk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 04:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIKIfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 04:35:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E27B30F4E
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:35:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oo12-20020a17090b1c8c00b001faa0b549caso5969122pjb.0
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+SqLElBwbW3rvekY3ijlqjV+hQEFZtxBqbrdA9ngSjc=;
        b=cdgtThGnOagpzntnndBJxW7/R89LxjmSM5iRoI5HtHKhX4XuzS1OHEoUPCkIIHB3qr
         BhjlKiSC9/HYGlhUzYaOJthaAhYpKWGiczWOEnLI+7fmt2RV16BjDN+9uR0boVf2k7/Y
         zmZTC94zr8SJXyv1UDGHYsq1oBYpR5svSUiFPTwXHrNbjb4mg1QltASaPGdlmfOGFAGd
         DZi6Tgqs67mDSIQH7R5+7T4MLP2S9xds+UcmQWwQjClEiXyQJIFt4GJEqoSfPzeE55P/
         YorAcJD1+UzBhw3lNkSNUfOBVxmIp8uhV6b/qoxEaIiGGrbo37lNYMzgPu1mnc6VtLgj
         zWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+SqLElBwbW3rvekY3ijlqjV+hQEFZtxBqbrdA9ngSjc=;
        b=IP3R1/eUfrxcR3nYBjNpeRH/NZN6VEBK50h+OIJMpBT9csayvHNJ2poBst8nPNWVGW
         xSM+KAdLaKihRbOfHSYFHWCIurkROc4dEvGABqAtlsCGg3dFrzHPh2zE3Ab1MYCV6rvw
         Hlgn1IBWL/WC/x07ejPfDimgjz0p0+ObHAQLXOjfyUN1sxQmn4SFOh2G8kaUWP1toTdZ
         41uMbjlOPEd8lilOwImBsV6Z5VIczT0h3OOs73LpMteOsZqsgWAY9nftlRS4bEYFb2Pf
         6cV+zAJytpj4ekNfnCT879juiQ4YsM9CCLhAn1nCG88iHGtqxVBLD+jnDBOSleybRXB2
         shag==
X-Gm-Message-State: ACgBeo0QWOTJ7cEwey8cNSwkYzcZ/LEYM4YSM2v+IqDqKShjTNwMNmZg
        /8hYnShj+QKKL/kd1IqMsFG0jIZNPBXA
X-Google-Smtp-Source: AA6agR4ShsWN+jgimkiPO+j8MYcaEgkkuvMf05zPiNiX/H3atMP+rzUDrkMRVZ8epv0HbboYAH8LNzeQz47l
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2d4:203:5076:f273:1383:891d])
 (user=yuanchu job=sendgmr) by 2002:a05:6a00:2395:b0:536:8296:51d5 with SMTP
 id f21-20020a056a00239500b00536829651d5mr22475520pfc.84.1662885336105; Sun,
 11 Sep 2022 01:35:36 -0700 (PDT)
Date:   Sun, 11 Sep 2022 01:34:18 -0700
In-Reply-To: <20220911083418.2818369-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20220911083418.2818369-1-yuanchu@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220911083418.2818369-3-yuanchu@google.com>
Subject: [RFC PATCH 2/2] mm: add a BPF-based per-process heatmap tool
From:   Yuanchu Xie <yuanchu@google.com>
To:     linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Cc:     Michael Larabel <Michael@MichaelLarabel.com>,
        Jon Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuanchu Xie <yuanchu@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The heatmap tool uses a bpf program integrated with a TUI as a proof of
concept for consuming page access information from MGLRU. It displays
heats, NUMA node, and anon/other with configurable aging intervals and
aggregation intervals.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 tools/vm/heatmap/Makefile       |  30 ++
 tools/vm/heatmap/heatmap.bpf.c  | 123 +++++++
 tools/vm/heatmap/heatmap.user.c | 188 ++++++++++
 tools/vm/heatmap/heatmap_tui.py | 600 ++++++++++++++++++++++++++++++++
 4 files changed, 941 insertions(+)
 create mode 100644 tools/vm/heatmap/Makefile
 create mode 100644 tools/vm/heatmap/heatmap.bpf.c
 create mode 100644 tools/vm/heatmap/heatmap.user.c
 create mode 100755 tools/vm/heatmap/heatmap_tui.py

diff --git a/tools/vm/heatmap/Makefile b/tools/vm/heatmap/Makefile
new file mode 100644
index 000000000000..43ae4af67781
--- /dev/null
+++ b/tools/vm/heatmap/Makefile
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../build/Build.include
+
+MAKEFLAGS += --no-builtin-rules
+MAKEFLAGS += --no-builtin-variables
+
+CC := clang
+KERNEL_DIR := $(abspath ../../..)
+
+.PHONY: clean all
+
+all: heatmap.user heatmap.skel.h vmlinux.h
+
+%.user: %.user.o
+	$(CC) -g -O2 $^ -l:libbpf.a -lelf -lz -o $@ -static
+
+vmlinux.h: $(KERNEL_DIR)/vmlinux
+	bpftool btf dump file $(KERNEL_DIR)/vmlinux format c > vmlinux.h
+
+%.bpf.o: vmlinux.h %.bpf.c
+	$(CC) -g -D__TARGET_ARCH_x86 -O2 -target bpf -c $*.bpf.c -o $*.bpf.o
+
+%.skel.h: %.bpf.o
+	bpftool gen skeleton $*.bpf.o > $*.skel.h
+
+%.user.o: %.skel.h %.user.c
+	$(CC) -g -O2 -c $*.user.c -o $*.user.o
+
+clean:
+	rm -f *.o heatmap.user *.skel.h vmlinux.h
diff --git a/tools/vm/heatmap/heatmap.bpf.c b/tools/vm/heatmap/heatmap.bpf.c
new file mode 100644
index 000000000000..924d896a0c4f
--- /dev/null
+++ b/tools/vm/heatmap/heatmap.bpf.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+static const u8 one = 1;
+pid_t target_pid;
+#define MAP_SHIFT (12 + 9)
+#define MIXED_NODES -1
+#define MIXED_MEM -1
+
+struct region_stat {
+	u16 accesses;
+	s8 mem_type; /* NON_ANON, ANON */
+	s8 node_id;
+};
+
+struct heatmap_outer {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1000000);
+	__type(key, u64);
+	__type(value, struct region_stat);
+} heatmap SEC(".maps");
+
+int probe(unsigned int nid, unsigned long addr, unsigned long len, bool anon)
+{
+	u64 map_key = addr >> MAP_SHIFT;
+	struct region_stat *region = bpf_map_lookup_elem(&heatmap, &map_key);
+	int err;
+	struct region_stat to_insert;
+
+	if (!region) {
+		to_insert.accesses = len;
+		to_insert.mem_type = anon;
+		to_insert.node_id = nid;
+		err = bpf_map_update_elem(&heatmap, &map_key, &to_insert,
+					  BPF_NOEXIST);
+		if (err)
+			return err;
+	} else {
+		region->accesses += len;
+		if (region->node_id != (int)nid)
+			region->node_id = MIXED_NODES;
+		if (region->mem_type != anon)
+			region->mem_type = MIXED_MEM;
+		err = bpf_map_update_elem(&heatmap, &map_key, region,
+					  BPF_EXIST);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+SEC("fentry/mglru_pte_probe")
+int BPF_PROG(fentry_mglru_pte_probe, pid_t pid, unsigned int nid,
+	     unsigned long addr, unsigned long len, bool anon)
+{
+	int err;
+
+	if (pid != target_pid)
+		return 0;
+	err = probe(nid, addr, len, anon);
+	if (err)
+		bpf_printk("PTE called addr:0x%lx len:%lu error:%ld", addr, len,
+			   err);
+	return 0;
+}
+
+SEC("fentry/mglru_pmd_probe")
+int BPF_PROG(fentry_mglru_pmd_probe, pid_t pid, unsigned int nid,
+	     unsigned long addr, unsigned long len, bool anon)
+{
+	int err;
+
+	if (pid != target_pid)
+		return 0;
+	err = probe(nid, addr, len, anon);
+	if (err)
+		bpf_printk("PMD called addr:0x%lx len:%lu error:%ld", addr, len,
+			   err);
+	return 0;
+}
+
+extern void
+bpf_set_skip_mm(struct bpf_mglru_should_skip_mm_control *should_skip) __ksym;
+
+SEC("fentry/bpf_mglru_should_skip_mm")
+int BPF_PROG(bpf_mglru_should_skip_mm,
+	     struct bpf_mglru_should_skip_mm_control *ctl)
+{
+	if (ctl->pid != target_pid) {
+		bpf_printk("aging wrong pid");
+		bpf_set_skip_mm(ctl);
+	}
+	return 0;
+}
+
+extern int bpf_run_aging(int memcg_id, bool can_swap, bool force_scan) __ksym;
+
+struct args {
+	int memcg_id;
+};
+
+SEC("syscall")
+int memcg_run_aging(struct args *ctx)
+{
+	int err;
+
+	err = bpf_run_aging(ctx->memcg_id, true, true);
+
+	if (err != 0) {
+		bpf_printk("aging failed for memcg %ld with error %ld",
+			   ctx->memcg_id, err);
+		return 0;
+	}
+
+	bpf_printk("aging succeeded for memcg %ld", ctx->memcg_id);
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/vm/heatmap/heatmap.user.c b/tools/vm/heatmap/heatmap.user.c
new file mode 100644
index 000000000000..094ba1e49233
--- /dev/null
+++ b/tools/vm/heatmap/heatmap.user.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "heatmap.skel.h"
+
+#define MAP_SHIFT (12 + 9)
+
+static bool terminate;
+
+struct args {
+	int memcg_id;
+};
+
+void handle_sigint(int sig)
+{
+	terminate = true;
+}
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format,
+			   va_list args)
+{
+	return vfprintf(stderr, format, args);
+}
+
+int run_aging(int aging_fd, int memcg_id)
+{
+	struct args ctx = {
+		.memcg_id = memcg_id,
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, tattr, .ctx_in = &ctx,
+		    .ctx_size_in = sizeof(ctx));
+	return bpf_prog_test_run_opts(aging_fd, &tattr);
+}
+
+int attach_progs(pid_t pid, struct heatmap_bpf **heatmap_obj, int *aging_fd,
+		 int *heatmap_fd)
+{
+	int err;
+	int fd;
+	struct heatmap_bpf *obj;
+
+	obj = heatmap_bpf__open();
+	if (obj == NULL) {
+		perror("Error when opening heatmap bpf object");
+		return -1;
+	}
+	obj->bss->target_pid = pid;
+
+	err = heatmap_bpf__load(obj);
+	if (err) {
+		perror("Error loading heatmap bpf object");
+		goto cleanup;
+	}
+
+	fd = bpf_program__fd(obj->progs.memcg_run_aging);
+
+	err = heatmap_bpf__attach(obj);
+	if (err) {
+		perror("Error attaching heatmap bpf object");
+		goto cleanup;
+	}
+
+	*aging_fd = fd;
+	*heatmap_fd = bpf_map__fd(obj->maps.heatmap);
+	*heatmap_obj = obj;
+	return 0;
+
+cleanup:
+	heatmap_bpf__destroy(obj);
+	return err;
+}
+
+int bpf_map_delete_and_get_next_key(int fd, const void *key, void *next_key)
+{
+	int err = bpf_map_get_next_key(fd, key, next_key);
+
+	bpf_map_delete_elem(fd, key);
+	return err;
+}
+
+struct region_stat {
+	__u16 accesses;
+	__s8 mem_type; /* NON_ANON, ANON */
+	__s8 node_id;
+};
+
+void dump_map(int fd)
+{
+	__u64 prev_key, key;
+	struct region_stat value;
+	int err;
+
+	while (bpf_map_delete_and_get_next_key(fd, &prev_key, &key) == 0) {
+		err = bpf_map_lookup_elem(fd, &key, &value);
+		if (err < 0) {
+			/* impossible if we don't have racing deletions */
+			exit(-1);
+		}
+		printf("%llu %u %d %d\n", key << MAP_SHIFT, value.accesses,
+		       value.mem_type, value.node_id);
+		prev_key = key;
+	}
+}
+
+void detach_progs(struct heatmap_bpf *heatmap_obj)
+{
+	heatmap_bpf__detach(heatmap_obj);
+	heatmap_bpf__destroy(heatmap_obj);
+}
+
+int main(void)
+{
+	struct heatmap_bpf *heatmap_obj = NULL;
+	int aging_fd = -1;
+	int heatmap_fd = -1;
+	int memcg_id = -1;
+	int err;
+
+	signal(SIGINT, handle_sigint);
+	setvbuf(stdout, NULL, _IONBF, BUFSIZ);
+	libbpf_set_print(libbpf_print_fn);
+
+	while (!terminate) {
+		char *buffer = NULL;
+
+		if (scanf("%ms", &buffer) == 1) {
+			if (strcmp(buffer, "exit") == 0) {
+				printf("No hard feelings.\n");
+				exit(0);
+
+			} else if (heatmap_obj == NULL &&
+				   strcmp(buffer, "attach") == 0) {
+				pid_t pid_;
+				int memcg_id_;
+
+				if (scanf("%d %d", &pid_, &memcg_id_) == 2) {
+					err = attach_progs(pid_, &heatmap_obj,
+							   &aging_fd,
+							   &heatmap_fd);
+					if (err) {
+						printf("error: aging %d\n",
+						       err);
+						goto next;
+					}
+					memcg_id = memcg_id_;
+					printf("success: attach\n");
+
+				} else
+					printf("error: invalid arguments\n");
+
+			} else if (heatmap_obj != NULL) {
+				if (strcmp(buffer, "map") == 0) {
+					dump_map(heatmap_fd);
+					printf("success: map\n");
+
+				} else if (strcmp(buffer, "age") == 0) {
+					err = run_aging(aging_fd, memcg_id);
+					if (err)
+						printf("error: age %d\n", err);
+					else
+						printf("success: age\n");
+
+				} else if (strcmp(buffer, "detach") == 0) {
+					detach_progs(heatmap_obj);
+					heatmap_obj = NULL;
+					heatmap_fd = -1;
+					aging_fd = -1;
+					memcg_id = -1;
+					printf("success: detach\n");
+				}
+
+			} else
+				printf("error: invalid command\n");
+
+next:
+			free(buffer);
+		} else
+			printf("error: invalid command\n");
+	}
+}
diff --git a/tools/vm/heatmap/heatmap_tui.py b/tools/vm/heatmap/heatmap_tui.py
new file mode 100755
index 000000000000..9be6b611bc24
--- /dev/null
+++ b/tools/vm/heatmap/heatmap_tui.py
@@ -0,0 +1,600 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+import urwid
+import parse
+import subprocess
+import os
+
+from time import time
+from math import floor
+
+UPDATE_INTERVAL = 0.5
+MEM_MAX = 0
+MEM_MIN = 0x10000000000000000
+INVALID_NODE = -2
+MIXED_NODE = -1
+INVALID_MEM = -2
+MIXED_MEM = -1
+ANON_MEM = 1
+MAX_AGGREGATIONS = 20
+MIN_ROWS = 40
+MAX_COL = 7
+
+
+class HeatmapModel:
+    def __init__(self, max_nr_aggregations):
+        self.data_range = (MEM_MIN, MEM_MAX)
+        self.data = []
+        self.max_nr_aggregations = max_nr_aggregations
+
+    def get_nr_aggregations(self):
+        return len(self.data)
+
+    def get_max_nr_aggregations(self):
+        return self.max_nr_generations
+
+    def set_max_nr_aggregations(self, max_nr_aggregations):
+        self.max_nr_aggregations = max_nr_aggregations
+
+    def append_data(self, bpf_access_data):
+        region_min = MEM_MIN
+        region_max = MEM_MAX
+        for region in bpf_access_data:
+            if region["address"] > region_max:
+                region_max = region["address"]
+            if region["address"] < region_min:
+                region_min = region["address"]
+
+        self.data.append({
+            "min": region_min,
+            "max": region_max,
+            "data": sorted(bpf_access_data, key=lambda d: d["address"]),
+        })
+
+        if len(self.data) > self.max_nr_aggregations:
+            del self.data[:len(self.data) - self.max_nr_aggregations]
+
+
+    def get_display_sections(self, rows):
+        REGION_SIZE = 2 * 1024 * 1024 # region size (21 bits) 2 MB
+        ranges = []
+        for d in self.data:
+            for r in d["data"]:
+                addr = r["address"]
+                ranges.append(("start", addr - REGION_SIZE))
+                ranges.append(("end", addr + REGION_SIZE * 2))
+
+        ranges = sorted(ranges, key=lambda d: d[1])
+        sections = []
+        start_addr = None
+        nesting = 0
+        total_size = 0
+        for (tag, addr) in ranges:
+            if tag == "start":
+                nesting += 1
+                if start_addr == None:
+                    start_addr = addr
+
+            if tag == "end":
+                nesting -= 1;
+                if nesting == 0:
+                    total_size += addr - start_addr
+                    sections.append((start_addr, addr))
+                    start_addr = None
+
+        if len(sections) > rows:
+            # compact some sections
+            sections_with_idx = [((start, end), i, end - start) for (i, (start, end)) in enumerate(sections)]
+            sections_with_idx = sorted(sections_with_idx, key=lambda x:
+                                       x[-1] + abs(sections[x[1] + 1][0] - x[0][1]) + abs(sections[x[1] - 1][1] - x[0][0]))
+            for i in range(0, len(sections) - rows):
+                # natural number of regions is greater than the number of rows
+                ((start, end), section_i, size) = sections_with_idx[i]
+                (_, prev_end) = sections[section_i - 1]
+                (succ_start, _) = sections[section_i + 1]
+                if abs(succ_start - end) > abs(prev_end - start):
+                    sections[section_i - 1][1] = end
+                else:
+                    sections[section_i - 1][0] = start
+
+            new_sections = []
+            for i in range(len(sections) - rows, len(sections)):
+                (_, section_i, _) = sections_with_idx[i]
+                new_sections.append(sections[section_i])
+            sections = sorted(new_sections, key=lambda x: x[0])
+
+        else:
+            extra_rows = rows - len(sections)
+            split_sections = []
+            spill_over_factor = 0
+            for (start, end) in sections:
+                fraction_of_row = (end - start) / total_size * rows
+                if fraction_of_row > 1:
+                    additional_rows_frac = (spill_over_factor + (fraction_of_row - 1))
+                    spill_over_factor = additional_rows_frac - floor(additional_rows_frac)
+                    additional_rows = min(floor(additional_rows_frac), extra_rows)
+                    extra_rows -= additional_rows
+                    new_rows = additional_rows + 1
+                    # split current interval
+                    inc = (end - start + new_rows - 1) // new_rows # round up
+                    for i in range(0, new_rows):
+                        split_sections.append((start + inc * i, min(start + inc * (i + 1), end)))
+                else:
+                    split_sections.append((start, end))
+            while extra_rows > 0:
+                split_sections.append((0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF))
+                extra_rows -= 1
+            sections = split_sections
+
+        return sections
+
+    def format_data(self, rows):
+        cell_init = (0, INVALID_MEM, INVALID_NODE)
+        def cell_update(cell, r):
+            (acc, mem, node) = cell
+            acc += r["accesses"]
+            if mem == INVALID_MEM:
+                mem = r["mem"]
+            elif mem != r["mem"]:
+                mem = MIXED_MEM
+
+            if node == INVALID_NODE:
+                node = r["node"]
+            elif node != r["node"]:
+                node = MIXED_NODE
+
+            return (acc, mem, node)
+
+        return self.__format_data(rows, cell_init, cell_update)
+
+    def __format_data(self, rows, cell_init, cell_update):
+        row_ranges = self.get_display_sections(rows)
+        assert(len(row_ranges) == rows)
+        graph = []
+        for d in self.data:
+            (curr_start, curr_end) = row_ranges[0]
+            range_idx = 0
+
+            col = []
+            cell = cell_init
+            for r in d["data"]:
+                while r["address"] >= curr_end:
+                    col.append(cell)
+                    cell = cell_init
+                    range_idx += 1
+                    (curr_start, curr_end) = row_ranges[range_idx]
+
+                cell = cell_update(cell, r)
+
+            while range_idx < len(row_ranges):
+                (curr_start, curr_end) = row_ranges[range_idx]
+                col.append(cell)
+                cell = cell_init
+                range_idx += 1
+
+            assert(len(col) == rows)
+            graph.append(col)
+
+        col_labels = [start for (start, end) in row_ranges]
+        return (col_labels, graph)
+
+
+class GraphView(urwid.Widget):
+    def __init__(self, model, modes):
+        self.model = model
+        self.mode = modes[0]
+        urwid.Widget.__init__(self)
+
+    def set_mode(self, mode):
+        self.mode = mode
+        self.update()
+
+    def render_col(self, col):
+        l = []
+        if self.mode == "Anon/Other":
+            for (_, mem, _) in col:
+                if mem == MIXED_MEM:
+                    l.append(("mixed", "M" * MAX_COL))
+                elif mem == INVALID_MEM:
+                    l.append(("invalid", "." * MAX_COL))
+                elif mem == ANON_MEM:
+                    l.append(("anon mem", "A" * MAX_COL))
+                else:
+                    l.append(("other mem", "X" * MAX_COL))
+        elif self.mode == "NUMA Node":
+            for (_, _, node) in col:
+                if node == MIXED_NODE:
+                    l.append(("mixed", "M" * MAX_COL))
+                elif node == INVALID_NODE:
+                    l.append(("invalid", "." * MAX_COL))
+                else:
+                    node_str = str(node)
+                    left_pad = (MAX_COL - len(node_str)) // 2
+                    right_pad = MAX_COL - left_pad - len(node_str)
+                    node_style = "node"
+                    if node < 4 and node >= 0:
+                        node_style += " " + node_str
+                    l.append((node_style, "_" * left_pad + node_str + "_" * right_pad))
+        else:
+            for (acc, _, _) in col:
+                acc_str = str(acc)
+                left_pad = (MAX_COL - len(acc_str)) // 2
+                right_pad = MAX_COL - left_pad - len(acc_str)
+                heat_style = "heat"
+                if acc >= 512:
+                    heat_style += " mid"
+                elif acc >= 1024:
+                    heat_style += " high"
+                l.append((heat_style, u"\u00a0" * left_pad + acc_str + u"\u00a0" * right_pad))
+
+        return (urwid.Text(l).render((MAX_COL,)), None, False, MAX_COL)
+
+    def render(self, size, focus=False):
+        (cols, rows) = size
+        LABEL_COLS = 16 + 2 + 4 # 0x and 16 chars of hex address, plus padding
+        self.model.set_max_nr_aggregations((cols - LABEL_COLS) // MAX_COL)
+        data_cols = cols - LABEL_COLS
+        (labels, data) = self.model.format_data(rows)[-(data_cols // MAX_COL):]
+        if len(labels) == 0:
+            label_col = urwid.SolidCanvas(" ", LABEL_COLS, rows)
+        else:
+            label_col = [("pg smooth", "0x{:016X}".format(addr) + u"\u00a0" * 4) for addr in labels]
+            label_col = urwid.Text(label_col).render((LABEL_COLS,))
+
+        label_col = (label_col, None, False, LABEL_COLS)
+        if len(data) > 0:
+            return urwid.CanvasJoin([label_col] + list(map(self.render_col, data)) + [
+                (urwid.SolidCanvas(" ", data_cols - len(data) * MAX_COL, rows),
+                 None, False, data_cols - len(data) * MAX_COL)])
+        else:
+            return urwid.SolidCanvas(" ", cols, rows)
+
+    def update(self):
+        self._invalidate()
+
+    def rows(self, size, focus=False):
+        return MIN_ROWS
+
+    def keypress(self, size, key):
+        return key
+
+
+class HeatmapView(urwid.WidgetWrap):
+    palette = [
+        ('body',         'black',      'light gray', 'standout'),
+        ('header',       'white',      'dark red',   'bold'),
+        ('screen edge',  'light blue', 'dark cyan'),
+        ('main shadow',  'dark gray',  'black'),
+        ('line',         'black',      'light gray', 'standout'),
+        ('bg background','light gray', 'black'),
+        ('bg 1',         'black',      'dark blue', 'standout'),
+        ('bg 1 smooth',  'dark blue',  'black'),
+        ('bg 2',         'black',      'dark cyan', 'standout'),
+        ('bg 2 smooth',  'dark cyan',  'black'),
+        ('button normal','light gray', 'dark blue', 'standout'),
+        ('button select','white',      'dark green'),
+        ('line',         'black',      'light gray', 'standout'),
+        ('pg normal',    'white',      'black', 'standout'),
+        ('pg complete',  'white',      'dark magenta'),
+        ('pg smooth',     'dark magenta','black'),
+
+        ("mixed", "light blue", "black"),
+        ("invalid", "dark gray", "black"),
+        ("anon mem", "white", "dark cyan"),
+        ("other mem", "light blue", "dark red"),
+
+        ("node", "white", "black"),
+
+        ("node 0", "light green", "black"),
+        ("node 1", "light blue", "black"),
+        ("node 2", "light red", "black"),
+        ("node 3", "yellow", "black"),
+
+        ("heat", "yellow", "black"),
+        ("heat mid", "dark red", "brown"),
+        ("heat high", "light red", "dark red"),
+    ]
+
+    def __init__(self, controller):
+        self.controller = controller
+        urwid.WidgetWrap.__init__(self, self.draw_view())
+
+    def update_graph(self):
+        self.graph_view.update()
+        pass
+
+    def set_selected_mode(self, new_mode):
+        self.graph_view.set_mode(new_mode)
+        for b in self.mode_buttons:
+            if b.get_label() == new_mode:
+                b.set_state(True, do_callback=False)
+                break
+
+    def on_mode_button(self, button, state):
+        if state:
+            self.controller.on_mode_change(button.get_label())
+
+    def radio_button(self, group, label, state, on_state_change):
+        w = urwid.RadioButton(group, label, state, on_state_change=on_state_change)
+        w = urwid.AttrWrap(w, 'button normal', 'button select')
+        return w
+
+    def button(self, label, on_press):
+        w = urwid.Button(label, on_press)
+        w = urwid.AttrWrap(w, 'button normal', 'button select')
+        return w
+
+    def set_alert_message(self, new_alert_text):
+        self.alert_text.set_text(new_alert_text)
+        pass
+
+    def set_start_button_text(self, new_text):
+        self.start_button.set_label(new_text)
+        pass
+
+    def edit_box(self, label, text, on_change):
+        w = urwid.Edit(label, text)
+        urwid.connect_signal(w, 'change', on_change)
+        w = urwid.AttrWrap(w, 'edit')
+        return w
+
+    def draw_control_pane(self):
+        g = []
+        self.mode_buttons = [self.radio_button(g, mode, mode == self.controller.mode,
+                                               self.on_mode_button)
+                          for mode in self.controller.overlay_modes]
+        self.pid_box = self.edit_box("PID: ", "1", self.controller.on_pid_change)
+        self.memcg_box = self.edit_box("memcg id: ", "1", self.controller.on_memcg_change)
+        self.start_button = self.button("Start", self.controller.on_start_button)
+        self.alert_text = urwid.Text("", align="center")
+
+        aging_text = urwid.Text("Aging interval", align="center")
+        self.aging_box = self.edit_box("Seconds: ", str(0.5), self.controller.on_aging_change)
+        aggregation_text = urwid.Text("Aggregation Interval", align="center")
+        self.aggregation_box = self.edit_box("Aging cycles: ", str(3), self.controller.on_aggregation_change)
+
+        self.quit_button = self.button("Quit", self.controller.on_quit_button)
+        l = [
+            urwid.Text("Overlay Mode", align="center")
+        ] + self.mode_buttons + [
+            urwid.Divider(),
+            self.pid_box,
+            self.memcg_box,
+            self.start_button,
+            urwid.Divider(),
+            aging_text,
+            self.aging_box,
+            aggregation_text,
+            self.aggregation_box,
+            urwid.Divider(),
+            self.alert_text,
+            urwid.Divider(),
+            self.quit_button
+        ]
+        return urwid.ListBox(urwid.SimpleListWalker(l))
+
+    def main_shadow(self, w):
+        # Wrap a shadow and background around widget w
+        bg = urwid.AttrWrap(urwid.SolidFill(u"\u2592"), 'screen edge')
+        shadow = urwid.AttrWrap(urwid.SolidFill(u" "), 'main shadow')
+
+        bg = urwid.Overlay( shadow, bg,
+                            ('fixed left', 3), ('fixed right', 1),
+                            ('fixed top', 2), ('fixed bottom', 1))
+        w = urwid.Overlay( w, bg,
+                           ('fixed left', 2), ('fixed right', 3),
+                           ('fixed top', 1), ('fixed bottom', 2))
+        return w
+
+    def draw_view(self):
+        control_pane = self.draw_control_pane()
+        self.graph_view = GraphView(self.controller.model, self.controller.overlay_modes)
+        vline = urwid.AttrWrap(urwid.SolidFill(u'\u2502'), 'line')
+        w = urwid.Columns([("weight", 4, self.graph_view), ("fixed", 1, vline), control_pane],
+                          dividechars=1, focus_column=2)
+        w = urwid.Padding(w,('fixed left',1),('fixed right',0))
+        w = urwid.AttrWrap(w,'body')
+        w = urwid.LineBox(w)
+        w = urwid.AttrWrap(w,'line')
+        w = self.main_shadow(w)
+        return w
+
+class BpfBridge:
+    def __init__(self):
+        self.bpf_bridge = subprocess.Popen(os.path.join(os.path.dirname(os.path.abspath(__file__)),
+                                                        "heatmap.user"),
+                                           stdin=subprocess.PIPE,
+                                           stdout=subprocess.PIPE,
+                                           stderr=subprocess.DEVNULL,
+                                           text=True)
+
+    def attach(self, pid, memcg_id):
+        self.bpf_bridge.stdin.write("attach\n")
+        self.bpf_bridge.stdin.write("{:d} {:d}\n".format(pid, memcg_id))
+        self.bpf_bridge.stdin.flush()
+        result = self.bpf_bridge.stdout.readline()
+        if "success" not in result:
+            return result
+
+        return "success"
+
+    def detach(self):
+        self.bpf_bridge.stdin.write("detach\n")
+        self.bpf_bridge.stdin.flush()
+        result = self.bpf_bridge.stdout.readline()
+        if "success" not in result:
+            return result
+
+        return "success"
+
+    def run_aging(self):
+        self.bpf_bridge.stdin.write("age\n")
+        self.bpf_bridge.stdin.flush()
+        result = self.bpf_bridge.stdout.readline()
+        if "success" not in result:
+            return result
+
+        return "success"
+
+    def get_map(self):
+        self.bpf_bridge.stdin.write("map\n")
+        self.bpf_bridge.stdin.flush()
+        result = ""
+        access_data = []
+        parser = parse.compile("{:d} {:d} {:d} {:d}\n")
+        result = self.bpf_bridge.stdout.readline()
+        while "success" not in result:
+            parsed_access = parser.parse(result)
+            if parsed_access is None:
+                raise Exception("woo " + result)
+                return result
+
+            access_data.append({
+                "address": parsed_access[0],
+                "accesses": parsed_access[1],
+                "mem": parsed_access[2],
+                "node": parsed_access[3],
+            })
+            result = self.bpf_bridge.stdout.readline()
+
+        return access_data
+
+
+class HeatmapController:
+    def __init__(self):
+        self.last_aged = 0
+        self.aging_interval = 0.5
+        self.aging_count = 0
+        self.aggregation_interval = 3
+        self.overlay_modes = ["Heat", "NUMA Node", "Anon/Other"]
+        self.monitoring_pid = 1
+        self.monitoring_memcg_id = 1
+        self.mode = self.overlay_modes[0]
+        self.model = HeatmapModel(MAX_AGGREGATIONS)
+        self.bpf_bridge = BpfBridge()
+        self.monitoring = False
+        self.view = HeatmapView(self)
+
+    def main(self):
+        self.loop = urwid.MainLoop(self.view, self.view.palette)
+        self.timer = self.loop.set_alarm_in(UPDATE_INTERVAL, self.on_timer)
+        # spawn the monitored process
+        self.loop.run()
+
+    def on_mode_change(self, new_mode):
+        mode = new_mode
+        self.view.set_selected_mode(new_mode)
+
+    def on_aging_change(self, w, new_value):
+        try:
+            aging_interval = float(new_value)
+            if aging_interval > 0:
+                self.aging_interval = aging_interval
+                self.view.set_alert_message("")
+            else:
+                self.view.set_alert_message("invalid aging interval")
+        except ValueError:
+            self.view.set_alert_message("invalid aging interval")
+
+    def on_aggregation_change(self, w, new_value):
+        try:
+            aggregation_interval = int(new_value)
+            if aggregation_interval > 0:
+                self.aggregation_interval = aggregation_interval
+                self.view.set_alert_message("")
+            else:
+                self.view.set_alert_message("invalid aggregation interval")
+        except ValueError:
+            self.view.set_alert_message("invalid aggregation interval")
+
+    def update_graph(self, new_data):
+        self.model.append_data(new_data)
+        self.view.update_graph()
+
+    def on_timer(self, loop=None, user_data=None):
+        # perform aging
+        # read data
+        delta_time = -time()
+        if self.last_aged <= -delta_time - self.aging_interval:
+            if self.monitoring:
+                # aging
+                self.last_aged = -delta_time
+                self.aging_count += 1
+                err = self.bpf_bridge.run_aging()
+                if "success" not in err:
+                    self.disable_monitoring()
+                    self.view.set_alert_message(err)
+
+                if self.aging_count % self.aggregation_interval == 0:
+                    # aggregation
+                    data = self.bpf_bridge.get_map()
+                    if isinstance(data, str):
+                        # get map failed
+                        self.disable_monitoring()
+                        self.view.set_alert_message(err)
+                    else:
+                        self.update_graph(data)
+
+        delta_time += time()
+        if delta_time > UPDATE_INTERVAL:
+            self.view.set_alert_message("timer running behind")
+            self.loop.set_alarm_in(0, self.on_timer)
+        else:
+            self.loop.set_alarm_in(UPDATE_INTERVAL - delta_time, self.on_timer)
+
+    def on_pid_change(self, widget, new_text):
+        pid = parse.parse("{:d}", new_text)
+        self.view.set_alert_message("")
+        if self.monitoring:
+            return
+
+        if pid is not None:
+            self.monitoring_pid = pid[0]
+        else:
+            self.monitoring_pid = -1
+
+    def on_memcg_change(self, widget, new_text):
+        memcg_id = parse.parse("{:d}", new_text)
+        self.view.set_alert_message("")
+        if self.monitoring:
+            return
+
+        if memcg_id is not None:
+            self.monitoring_memcg_id = memcg_id[0]
+        else:
+            self.monitoring_memcg_id = -1
+
+    def disable_monitoring(self):
+        self.monitoring = False
+        self.bpf_bridge.detach()
+        self.view.set_start_button_text("Start")
+
+    def on_start_button(self, w):
+        if self.monitoring:
+            err = self.bpf_bridge.detach()
+            self.monitoring = False
+            self.view.set_start_button_text("Start")
+            if "success" not in err:
+                self.view.set_alert_message(err)
+                self.view.pid_box.set_edit_text(str(self.monitoring_pid))
+        else:
+            if self.monitoring_pid != -1 and self.monitoring_memcg_id != -1:
+                err = self.bpf_bridge.attach(self.monitoring_pid, self.monitoring_memcg_id)
+                if "success" in err:
+                    self.view.set_start_button_text("Stop")
+                    self.monitoring = True
+                else:
+                    self.view.set_alert_message(err)
+            else:
+                self.view.set_alert_message("invalid pid/memcg")
+
+
+
+    def on_quit_button(self, w):
+        raise urwid.ExitMainLoop()
+
+def main():
+    HeatmapController().main()
+
+if "__main__" == __name__:
+    main()
-- 
2.37.2.789.g6183377224-goog

