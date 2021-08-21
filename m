Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436263F37A0
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 02:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbhHUAVu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 20:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbhHUAVm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 20:21:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD295C0617AE;
        Fri, 20 Aug 2021 17:20:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso14933432pjh.5;
        Fri, 20 Aug 2021 17:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJ9oVHT265LHJikm+x9FrEd14fTMM3B2iroIi3V2J3o=;
        b=vMhQ6UXUGfLIcKMQWtBUen+5An3H1BTrHnh4oUdv5SP9K2KHpDqCtn36alMj6CnDJA
         hgXnKwpNpd3RbHqZo+qA6CXXpHYg3f4hkdmtXQiRgpyoFPf5zKBatFVp396yrqTCF7vr
         hUu2nSqkhgvFcCugaWUE5BX7UtChF/cOBXpw6RqW9n6iLEu8xf3hJo2i/j5w7/po3j04
         H3aDm4UyXfXgMkaQiSeTPzhE/TSe/3RYpfwec9Cc0Wy8UgaP2N44NDNLZY/G0AGbqXcM
         ASf4spHB+o8qxWZwUxESv8cjsbvwtPy8/B74xfsTrAMSafNO2CRs7yR0G9c+qTNuRUlR
         IDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJ9oVHT265LHJikm+x9FrEd14fTMM3B2iroIi3V2J3o=;
        b=prkl5XLJbGDFmbju0RLouzj/GA9HwM4kjByMMGxBHwJtLziWJlS6Fyspkax5AXPAvg
         7EclUkptAMDTwdo2NLJ8U466S9U7f0Mbyj2RCZqhe8BMfLRHuI5YVt7FFf7/8ctcmvvn
         icP9BD5cs3xZ0kaGP8cFeohWc5M3cB8erNVY7l1dhc3KhVWd+nr+sfkcc6NlDCca2Aic
         fzblrRfqzjZirvyB6KQkGoNXeAQPxPy+sJCM+R9eqeWpOsnhHQfEIn5dQQ34b0uscWZX
         9/Lpb4Mk0SMAOF3SZhPan3Rhh7acQPY1JfFqr4LVUmGQFOGOKPn31aw7GS/y7NM4OeiW
         xenA==
X-Gm-Message-State: AOAM5300JkJtDBp//T3fa+ko3yyqJ0lFv4l7/wUPNs5OmRNy+YrTb5WS
        Tg0QjR/ghKbjUlpzZuei+dpNc7NyhcI=
X-Google-Smtp-Source: ABdhPJyOeXIQXQlPwECNfuMzSCJ6eRilfHr8BEMX89SaUBWmpYcdnjSx6BgB+cigmT/mWLZKRcKd/A==
X-Received: by 2002:a17:90a:a894:: with SMTP id h20mr591165pjq.65.1629505256022;
        Fri, 20 Aug 2021 17:20:56 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id y62sm8035918pfg.88.2021.08.20.17.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 17:20:55 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 14/22] samples: bpf: Convert xdp_monitor to XDP samples helper
Date:   Sat, 21 Aug 2021 05:50:02 +0530
Message-Id: <20210821002010.845777-15-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210821002010.845777-1-memxor@gmail.com>
References: <20210821002010.845777-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the libbpf skeleton facility and other utilities provided by XDP
samples helper.

A lot of the code in xdp_monitor and xdp_redirect_cpu has been moved to
the xdp_sample_user.o helper, so we remove the duplicate functions here
that are no longer needed.

Thanks to BPF skeleton, we no longer depend on order of tracepoints to
uninstall them on startup. Instead, the sample mask is used to install
the needed tracepoints.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/Makefile           |   9 +-
 samples/bpf/Makefile.target    |  11 +
 samples/bpf/xdp_monitor_user.c | 798 +++------------------------------
 3 files changed, 83 insertions(+), 735 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 0d7086a2a393..479778439f5e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -43,7 +43,6 @@ tprogs-y += xdp_redirect
 tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_redirect_cpu
-tprogs-y += xdp_monitor
 tprogs-y += xdp_rxq_info
 tprogs-y += syscall_tp
 tprogs-y += cpustat
@@ -57,11 +56,14 @@ tprogs-y += xdp_sample_pkts
 tprogs-y += ibumad
 tprogs-y += hbm
 
+tprogs-y += xdp_monitor
+
 # Libbpf dependencies
 LIBBPF = $(TOOLS_PATH)/lib/bpf/libbpf.a
 
 CGROUP_HELPERS := ../../tools/testing/selftests/bpf/cgroup_helpers.o
 TRACE_HELPERS := ../../tools/testing/selftests/bpf/trace_helpers.o
+XDP_SAMPLE := xdp_sample_user.o
 
 fds_example-objs := fds_example.o
 sockex1-objs := sockex1_user.o
@@ -102,7 +104,6 @@ xdp_redirect-objs := xdp_redirect_user.o
 xdp_redirect_map-objs := xdp_redirect_map_user.o
 xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o
 xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o
-xdp_monitor-objs := xdp_monitor_user.o
 xdp_rxq_info-objs := xdp_rxq_info_user.o
 syscall_tp-objs := syscall_tp_user.o
 cpustat-objs := cpustat_user.o
@@ -116,6 +117,8 @@ xdp_sample_pkts-objs := xdp_sample_pkts_user.o
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
+xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
+
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
 always-y += sockex1_kern.o
@@ -310,6 +313,8 @@ verify_target_bpf: verify_cmds
 $(BPF_SAMPLES_PATH)/*.c: verify_target_bpf $(LIBBPF)
 $(src)/*.c: verify_target_bpf $(LIBBPF)
 
+$(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
+
 $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
 $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 $(obj)/hbm.o: $(src)/hbm.h
diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
index 7621f55e2947..5a368affa038 100644
--- a/samples/bpf/Makefile.target
+++ b/samples/bpf/Makefile.target
@@ -73,3 +73,14 @@ quiet_cmd_tprog-cobjs	= CC  $@
       cmd_tprog-cobjs	= $(CC) $(tprogc_flags) -c -o $@ $<
 $(tprog-cobjs): $(obj)/%.o: $(src)/%.c FORCE
 	$(call if_changed_dep,tprog-cobjs)
+
+# Override includes for xdp_sample_user.o because $(srctree)/usr/include in
+# TPROGS_CFLAGS causes conflicts
+XDP_SAMPLE_CFLAGS += -Wall -O2 -lm \
+		     -I./tools/include \
+		     -I./tools/include/uapi \
+		     -I./tools/lib \
+		     -I./tools/testing/selftests/bpf
+$(obj)/xdp_sample_user.o: $(src)/xdp_sample_user.c \
+	$(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
+	$(CC) $(XDP_SAMPLE_CFLAGS) -c -o $@ $<
diff --git a/samples/bpf/xdp_monitor_user.c b/samples/bpf/xdp_monitor_user.c
index 49ebc49aefc3..fb9391a5ec62 100644
--- a/samples/bpf/xdp_monitor_user.c
+++ b/samples/bpf/xdp_monitor_user.c
@@ -1,15 +1,12 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Copyright(c) 2017 Jesper Dangaard Brouer, Red Hat, Inc.
- */
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2017 Jesper Dangaard Brouer, Red Hat, Inc. */
 static const char *__doc__=
- "XDP monitor tool, based on tracepoints\n"
-;
+"XDP monitor tool, based on tracepoints\n";
 
 static const char *__doc_err_only__=
- " NOTICE: Only tracking XDP redirect errors\n"
- "         Enable TX success stats via '--stats'\n"
- "         (which comes with a per packet processing overhead)\n"
-;
+" NOTICE: Only tracking XDP redirect errors\n"
+"         Enable redirect success stats via '-s/--stats'\n"
+"         (which comes with a per packet processing overhead)\n";
 
 #include <errno.h>
 #include <stdio.h>
@@ -20,768 +17,103 @@ static const char *__doc_err_only__=
 #include <ctype.h>
 #include <unistd.h>
 #include <locale.h>
-
 #include <sys/resource.h>
 #include <getopt.h>
 #include <net/if.h>
 #include <time.h>
-
 #include <signal.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 #include "bpf_util.h"
+#include "xdp_sample_user.h"
+#include "xdp_monitor.skel.h"
 
-enum map_type {
-	REDIRECT_ERR_CNT,
-	EXCEPTION_CNT,
-	CPUMAP_ENQUEUE_CNT,
-	CPUMAP_KTHREAD_CNT,
-	DEVMAP_XMIT_CNT,
-};
+static int mask = SAMPLE_REDIRECT_ERR_CNT | SAMPLE_CPUMAP_ENQUEUE_CNT |
+		  SAMPLE_CPUMAP_KTHREAD_CNT | SAMPLE_EXCEPTION_CNT |
+		  SAMPLE_DEVMAP_XMIT_CNT | SAMPLE_DEVMAP_XMIT_CNT_MULTI;
 
-static const char *const map_type_strings[] = {
-	[REDIRECT_ERR_CNT] = "redirect_err_cnt",
-	[EXCEPTION_CNT] = "exception_cnt",
-	[CPUMAP_ENQUEUE_CNT] = "cpumap_enqueue_cnt",
-	[CPUMAP_KTHREAD_CNT] = "cpumap_kthread_cnt",
-	[DEVMAP_XMIT_CNT] = "devmap_xmit_cnt",
-};
-
-#define NUM_MAP 5
-#define NUM_TP 8
-
-static int tp_cnt;
-static int map_cnt;
-static int verbose = 1;
-static bool debug = false;
-struct bpf_map *map_data[NUM_MAP] = {};
-struct bpf_link *tp_links[NUM_TP] = {};
-struct bpf_object *obj;
+DEFINE_SAMPLE_INIT(xdp_monitor);
 
 static const struct option long_options[] = {
-	{"help",	no_argument,		NULL, 'h' },
-	{"debug",	no_argument,		NULL, 'D' },
-	{"stats",	no_argument,		NULL, 'S' },
-	{"sec", 	required_argument,	NULL, 's' },
-	{0, 0, NULL,  0 }
-};
-
-static void int_exit(int sig)
-{
-	/* Detach tracepoints */
-	while (tp_cnt)
-		bpf_link__destroy(tp_links[--tp_cnt]);
-
-	bpf_object__close(obj);
-	exit(0);
-}
-
-/* C standard specifies two constants, EXIT_SUCCESS(0) and EXIT_FAILURE(1) */
-#define EXIT_FAIL_MEM	5
-
-static void usage(char *argv[])
-{
-	int i;
-	printf("\nDOCUMENTATION:\n%s\n", __doc__);
-	printf("\n");
-	printf(" Usage: %s (options-see-below)\n",
-	       argv[0]);
-	printf(" Listing options:\n");
-	for (i = 0; long_options[i].name != 0; i++) {
-		printf(" --%-15s", long_options[i].name);
-		if (long_options[i].flag != NULL)
-			printf(" flag (internal value:%d)",
-			       *long_options[i].flag);
-		else
-			printf("short-option: -%c",
-			       long_options[i].val);
-		printf("\n");
-	}
-	printf("\n");
-}
-
-#define NANOSEC_PER_SEC 1000000000 /* 10^9 */
-static __u64 gettime(void)
-{
-	struct timespec t;
-	int res;
-
-	res = clock_gettime(CLOCK_MONOTONIC, &t);
-	if (res < 0) {
-		fprintf(stderr, "Error with gettimeofday! (%i)\n", res);
-		exit(EXIT_FAILURE);
-	}
-	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
-}
-
-enum {
-	REDIR_SUCCESS = 0,
-	REDIR_ERROR = 1,
-};
-#define REDIR_RES_MAX 2
-static const char *redir_names[REDIR_RES_MAX] = {
-	[REDIR_SUCCESS]	= "Success",
-	[REDIR_ERROR]	= "Error",
-};
-static const char *err2str(int err)
-{
-	if (err < REDIR_RES_MAX)
-		return redir_names[err];
-	return NULL;
-}
-/* enum xdp_action */
-#define XDP_UNKNOWN	XDP_REDIRECT + 1
-#define XDP_ACTION_MAX (XDP_UNKNOWN + 1)
-static const char *xdp_action_names[XDP_ACTION_MAX] = {
-	[XDP_ABORTED]	= "XDP_ABORTED",
-	[XDP_DROP]	= "XDP_DROP",
-	[XDP_PASS]	= "XDP_PASS",
-	[XDP_TX]	= "XDP_TX",
-	[XDP_REDIRECT]	= "XDP_REDIRECT",
-	[XDP_UNKNOWN]	= "XDP_UNKNOWN",
-};
-static const char *action2str(int action)
-{
-	if (action < XDP_ACTION_MAX)
-		return xdp_action_names[action];
-	return NULL;
-}
-
-/* Common stats data record shared with _kern.c */
-struct datarec {
-	__u64 processed;
-	__u64 dropped;
-	__u64 info;
-	__u64 err;
-};
-#define MAX_CPUS 64
-
-/* Userspace structs for collection of stats from maps */
-struct record {
-	__u64 timestamp;
-	struct datarec total;
-	struct datarec *cpu;
+	{ "help", no_argument, NULL, 'h' },
+	{ "stats", no_argument, NULL, 's' },
+	{ "interval", required_argument, NULL, 'i' },
+	{ "verbose", no_argument, NULL, 'v' },
+	{}
 };
-struct u64rec {
-	__u64 processed;
-};
-struct record_u64 {
-	/* record for _kern side __u64 values */
-	__u64 timestamp;
-	struct u64rec total;
-	struct u64rec *cpu;
-};
-
-struct stats_record {
-	struct record_u64 xdp_redirect[REDIR_RES_MAX];
-	struct record_u64 xdp_exception[XDP_ACTION_MAX];
-	struct record xdp_cpumap_kthread;
-	struct record xdp_cpumap_enqueue[MAX_CPUS];
-	struct record xdp_devmap_xmit;
-};
-
-static bool map_collect_record(int fd, __u32 key, struct record *rec)
-{
-	/* For percpu maps, userspace gets a value per possible CPU */
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct datarec values[nr_cpus];
-	__u64 sum_processed = 0;
-	__u64 sum_dropped = 0;
-	__u64 sum_info = 0;
-	__u64 sum_err = 0;
-	int i;
-
-	if ((bpf_map_lookup_elem(fd, &key, values)) != 0) {
-		fprintf(stderr,
-			"ERR: bpf_map_lookup_elem failed key:0x%X\n", key);
-		return false;
-	}
-	/* Get time as close as possible to reading map contents */
-	rec->timestamp = gettime();
-
-	/* Record and sum values from each CPU */
-	for (i = 0; i < nr_cpus; i++) {
-		rec->cpu[i].processed = values[i].processed;
-		sum_processed        += values[i].processed;
-		rec->cpu[i].dropped = values[i].dropped;
-		sum_dropped        += values[i].dropped;
-		rec->cpu[i].info = values[i].info;
-		sum_info        += values[i].info;
-		rec->cpu[i].err = values[i].err;
-		sum_err        += values[i].err;
-	}
-	rec->total.processed = sum_processed;
-	rec->total.dropped   = sum_dropped;
-	rec->total.info      = sum_info;
-	rec->total.err       = sum_err;
-	return true;
-}
-
-static bool map_collect_record_u64(int fd, __u32 key, struct record_u64 *rec)
-{
-	/* For percpu maps, userspace gets a value per possible CPU */
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct u64rec values[nr_cpus];
-	__u64 sum_total = 0;
-	int i;
-
-	if ((bpf_map_lookup_elem(fd, &key, values)) != 0) {
-		fprintf(stderr,
-			"ERR: bpf_map_lookup_elem failed key:0x%X\n", key);
-		return false;
-	}
-	/* Get time as close as possible to reading map contents */
-	rec->timestamp = gettime();
-
-	/* Record and sum values from each CPU */
-	for (i = 0; i < nr_cpus; i++) {
-		rec->cpu[i].processed = values[i].processed;
-		sum_total            += values[i].processed;
-	}
-	rec->total.processed = sum_total;
-	return true;
-}
-
-static double calc_period(struct record *r, struct record *p)
-{
-	double period_ = 0;
-	__u64 period = 0;
-
-	period = r->timestamp - p->timestamp;
-	if (period > 0)
-		period_ = ((double) period / NANOSEC_PER_SEC);
-
-	return period_;
-}
-
-static double calc_period_u64(struct record_u64 *r, struct record_u64 *p)
-{
-	double period_ = 0;
-	__u64 period = 0;
-
-	period = r->timestamp - p->timestamp;
-	if (period > 0)
-		period_ = ((double) period / NANOSEC_PER_SEC);
-
-	return period_;
-}
-
-static double calc_pps(struct datarec *r, struct datarec *p, double period)
-{
-	__u64 packets = 0;
-	double pps = 0;
-
-	if (period > 0) {
-		packets = r->processed - p->processed;
-		pps = packets / period;
-	}
-	return pps;
-}
-
-static double calc_pps_u64(struct u64rec *r, struct u64rec *p, double period)
-{
-	__u64 packets = 0;
-	double pps = 0;
-
-	if (period > 0) {
-		packets = r->processed - p->processed;
-		pps = packets / period;
-	}
-	return pps;
-}
-
-static double calc_drop(struct datarec *r, struct datarec *p, double period)
-{
-	__u64 packets = 0;
-	double pps = 0;
-
-	if (period > 0) {
-		packets = r->dropped - p->dropped;
-		pps = packets / period;
-	}
-	return pps;
-}
-
-static double calc_info(struct datarec *r, struct datarec *p, double period)
-{
-	__u64 packets = 0;
-	double pps = 0;
-
-	if (period > 0) {
-		packets = r->info - p->info;
-		pps = packets / period;
-	}
-	return pps;
-}
-
-static double calc_err(struct datarec *r, struct datarec *p, double period)
-{
-	__u64 packets = 0;
-	double pps = 0;
-
-	if (period > 0) {
-		packets = r->err - p->err;
-		pps = packets / period;
-	}
-	return pps;
-}
-
-static void stats_print(struct stats_record *stats_rec,
-			struct stats_record *stats_prev,
-			bool err_only)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	int rec_i = 0, i, to_cpu;
-	double t = 0, pps = 0;
-
-	/* Header */
-	printf("%-15s %-7s %-12s %-12s %-9s\n",
-	       "XDP-event", "CPU:to", "pps", "drop-pps", "extra-info");
-
-	/* tracepoint: xdp:xdp_redirect_* */
-	if (err_only)
-		rec_i = REDIR_ERROR;
-
-	for (; rec_i < REDIR_RES_MAX; rec_i++) {
-		struct record_u64 *rec, *prev;
-		char *fmt1 = "%-15s %-7d %'-12.0f %'-12.0f %s\n";
-		char *fmt2 = "%-15s %-7s %'-12.0f %'-12.0f %s\n";
-
-		rec  =  &stats_rec->xdp_redirect[rec_i];
-		prev = &stats_prev->xdp_redirect[rec_i];
-		t = calc_period_u64(rec, prev);
-
-		for (i = 0; i < nr_cpus; i++) {
-			struct u64rec *r = &rec->cpu[i];
-			struct u64rec *p = &prev->cpu[i];
-
-			pps = calc_pps_u64(r, p, t);
-			if (pps > 0)
-				printf(fmt1, "XDP_REDIRECT", i,
-				       rec_i ? 0.0: pps, rec_i ? pps : 0.0,
-				       err2str(rec_i));
-		}
-		pps = calc_pps_u64(&rec->total, &prev->total, t);
-		printf(fmt2, "XDP_REDIRECT", "total",
-		       rec_i ? 0.0: pps, rec_i ? pps : 0.0, err2str(rec_i));
-	}
-
-	/* tracepoint: xdp:xdp_exception */
-	for (rec_i = 0; rec_i < XDP_ACTION_MAX; rec_i++) {
-		struct record_u64 *rec, *prev;
-		char *fmt1 = "%-15s %-7d %'-12.0f %'-12.0f %s\n";
-		char *fmt2 = "%-15s %-7s %'-12.0f %'-12.0f %s\n";
-
-		rec  =  &stats_rec->xdp_exception[rec_i];
-		prev = &stats_prev->xdp_exception[rec_i];
-		t = calc_period_u64(rec, prev);
-
-		for (i = 0; i < nr_cpus; i++) {
-			struct u64rec *r = &rec->cpu[i];
-			struct u64rec *p = &prev->cpu[i];
-
-			pps = calc_pps_u64(r, p, t);
-			if (pps > 0)
-				printf(fmt1, "Exception", i,
-				       0.0, pps, action2str(rec_i));
-		}
-		pps = calc_pps_u64(&rec->total, &prev->total, t);
-		if (pps > 0)
-			printf(fmt2, "Exception", "total",
-			       0.0, pps, action2str(rec_i));
-	}
-
-	/* cpumap enqueue stats */
-	for (to_cpu = 0; to_cpu < MAX_CPUS; to_cpu++) {
-		char *fmt1 = "%-15s %3d:%-3d %'-12.0f %'-12.0f %'-10.2f %s\n";
-		char *fmt2 = "%-15s %3s:%-3d %'-12.0f %'-12.0f %'-10.2f %s\n";
-		struct record *rec, *prev;
-		char *info_str = "";
-		double drop, info;
-
-		rec  =  &stats_rec->xdp_cpumap_enqueue[to_cpu];
-		prev = &stats_prev->xdp_cpumap_enqueue[to_cpu];
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps  = calc_pps(r, p, t);
-			drop = calc_drop(r, p, t);
-			info = calc_info(r, p, t);
-			if (info > 0) {
-				info_str = "bulk-average";
-				info = pps / info; /* calc average bulk size */
-			}
-			if (pps > 0)
-				printf(fmt1, "cpumap-enqueue",
-				       i, to_cpu, pps, drop, info, info_str);
-		}
-		pps = calc_pps(&rec->total, &prev->total, t);
-		if (pps > 0) {
-			drop = calc_drop(&rec->total, &prev->total, t);
-			info = calc_info(&rec->total, &prev->total, t);
-			if (info > 0) {
-				info_str = "bulk-average";
-				info = pps / info; /* calc average bulk size */
-			}
-			printf(fmt2, "cpumap-enqueue",
-			       "sum", to_cpu, pps, drop, info, info_str);
-		}
-	}
-
-	/* cpumap kthread stats */
-	{
-		char *fmt1 = "%-15s %-7d %'-12.0f %'-12.0f %'-10.0f %s\n";
-		char *fmt2 = "%-15s %-7s %'-12.0f %'-12.0f %'-10.0f %s\n";
-		struct record *rec, *prev;
-		double drop, info;
-		char *i_str = "";
-
-		rec  =  &stats_rec->xdp_cpumap_kthread;
-		prev = &stats_prev->xdp_cpumap_kthread;
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps  = calc_pps(r, p, t);
-			drop = calc_drop(r, p, t);
-			info = calc_info(r, p, t);
-			if (info > 0)
-				i_str = "sched";
-			if (pps > 0 || drop > 0)
-				printf(fmt1, "cpumap-kthread",
-				       i, pps, drop, info, i_str);
-		}
-		pps = calc_pps(&rec->total, &prev->total, t);
-		drop = calc_drop(&rec->total, &prev->total, t);
-		info = calc_info(&rec->total, &prev->total, t);
-		if (info > 0)
-			i_str = "sched-sum";
-		printf(fmt2, "cpumap-kthread", "total", pps, drop, info, i_str);
-	}
-
-	/* devmap ndo_xdp_xmit stats */
-	{
-		char *fmt1 = "%-15s %-7d %'-12.0f %'-12.0f %'-10.2f %s %s\n";
-		char *fmt2 = "%-15s %-7s %'-12.0f %'-12.0f %'-10.2f %s %s\n";
-		struct record *rec, *prev;
-		double drop, info, err;
-		char *i_str = "";
-		char *err_str = "";
-
-		rec  =  &stats_rec->xdp_devmap_xmit;
-		prev = &stats_prev->xdp_devmap_xmit;
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps  = calc_pps(r, p, t);
-			drop = calc_drop(r, p, t);
-			info = calc_info(r, p, t);
-			err  = calc_err(r, p, t);
-			if (info > 0) {
-				i_str = "bulk-average";
-				info = (pps+drop) / info; /* calc avg bulk */
-			}
-			if (err > 0)
-				err_str = "drv-err";
-			if (pps > 0 || drop > 0)
-				printf(fmt1, "devmap-xmit",
-				       i, pps, drop, info, i_str, err_str);
-		}
-		pps = calc_pps(&rec->total, &prev->total, t);
-		drop = calc_drop(&rec->total, &prev->total, t);
-		info = calc_info(&rec->total, &prev->total, t);
-		err  = calc_err(&rec->total, &prev->total, t);
-		if (info > 0) {
-			i_str = "bulk-average";
-			info = (pps+drop) / info; /* calc avg bulk */
-		}
-		if (err > 0)
-			err_str = "drv-err";
-		printf(fmt2, "devmap-xmit", "total", pps, drop,
-		       info, i_str, err_str);
-	}
-
-	printf("\n");
-}
-
-static bool stats_collect(struct stats_record *rec)
-{
-	int fd;
-	int i;
-
-	/* TODO: Detect if someone unloaded the perf event_fd's, as
-	 * this can happen by someone running perf-record -e
-	 */
-
-	fd = bpf_map__fd(map_data[REDIRECT_ERR_CNT]);
-	for (i = 0; i < REDIR_RES_MAX; i++)
-		map_collect_record_u64(fd, i, &rec->xdp_redirect[i]);
-
-	fd = bpf_map__fd(map_data[EXCEPTION_CNT]);
-	for (i = 0; i < XDP_ACTION_MAX; i++) {
-		map_collect_record_u64(fd, i, &rec->xdp_exception[i]);
-	}
-
-	fd = bpf_map__fd(map_data[CPUMAP_ENQUEUE_CNT]);
-	for (i = 0; i < MAX_CPUS; i++)
-		map_collect_record(fd, i, &rec->xdp_cpumap_enqueue[i]);
-
-	fd = bpf_map__fd(map_data[CPUMAP_KTHREAD_CNT]);
-	map_collect_record(fd, 0, &rec->xdp_cpumap_kthread);
-
-	fd = bpf_map__fd(map_data[DEVMAP_XMIT_CNT]);
-	map_collect_record(fd, 0, &rec->xdp_devmap_xmit);
-
-	return true;
-}
-
-static void *alloc_rec_per_cpu(int record_size)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	void *array;
-
-	array = calloc(nr_cpus, record_size);
-	if (!array) {
-		fprintf(stderr, "Mem alloc error (nr_cpus:%u)\n", nr_cpus);
-		exit(EXIT_FAIL_MEM);
-	}
-	return array;
-}
-
-static struct stats_record *alloc_stats_record(void)
-{
-	struct stats_record *rec;
-	int rec_sz;
-	int i;
-
-	/* Alloc main stats_record structure */
-	rec = calloc(1, sizeof(*rec));
-	if (!rec) {
-		fprintf(stderr, "Mem alloc error\n");
-		exit(EXIT_FAIL_MEM);
-	}
-
-	/* Alloc stats stored per CPU for each record */
-	rec_sz = sizeof(struct u64rec);
-	for (i = 0; i < REDIR_RES_MAX; i++)
-		rec->xdp_redirect[i].cpu = alloc_rec_per_cpu(rec_sz);
-
-	for (i = 0; i < XDP_ACTION_MAX; i++)
-		rec->xdp_exception[i].cpu = alloc_rec_per_cpu(rec_sz);
-
-	rec_sz = sizeof(struct datarec);
-	rec->xdp_cpumap_kthread.cpu = alloc_rec_per_cpu(rec_sz);
-	rec->xdp_devmap_xmit.cpu    = alloc_rec_per_cpu(rec_sz);
-
-	for (i = 0; i < MAX_CPUS; i++)
-		rec->xdp_cpumap_enqueue[i].cpu = alloc_rec_per_cpu(rec_sz);
-
-	return rec;
-}
-
-static void free_stats_record(struct stats_record *r)
-{
-	int i;
-
-	for (i = 0; i < REDIR_RES_MAX; i++)
-		free(r->xdp_redirect[i].cpu);
-
-	for (i = 0; i < XDP_ACTION_MAX; i++)
-		free(r->xdp_exception[i].cpu);
-
-	free(r->xdp_cpumap_kthread.cpu);
-	free(r->xdp_devmap_xmit.cpu);
-
-	for (i = 0; i < MAX_CPUS; i++)
-		free(r->xdp_cpumap_enqueue[i].cpu);
-
-	free(r);
-}
-
-/* Pointer swap trick */
-static inline void swap(struct stats_record **a, struct stats_record **b)
-{
-	struct stats_record *tmp;
-
-	tmp = *a;
-	*a = *b;
-	*b = tmp;
-}
-
-static void stats_poll(int interval, bool err_only)
-{
-	struct stats_record *rec, *prev;
-
-	rec  = alloc_stats_record();
-	prev = alloc_stats_record();
-	stats_collect(rec);
-
-	if (err_only)
-		printf("\n%s\n", __doc_err_only__);
-
-	/* Trick to pretty printf with thousands separators use %' */
-	setlocale(LC_NUMERIC, "en_US");
-
-	/* Header */
-	if (verbose)
-		printf("\n%s", __doc__);
-
-	/* TODO Need more advanced stats on error types */
-	if (verbose) {
-		printf(" - Stats map0: %s\n", bpf_map__name(map_data[0]));
-		printf(" - Stats map1: %s\n", bpf_map__name(map_data[1]));
-		printf("\n");
-	}
-	fflush(stdout);
-
-	while (1) {
-		swap(&prev, &rec);
-		stats_collect(rec);
-		stats_print(rec, prev, err_only);
-		fflush(stdout);
-		sleep(interval);
-	}
-
-	free_stats_record(rec);
-	free_stats_record(prev);
-}
-
-static void print_bpf_prog_info(void)
-{
-	struct bpf_program *prog;
-	struct bpf_map *map;
-	int i = 0;
-
-	/* Prog info */
-	printf("Loaded BPF prog have %d bpf program(s)\n", tp_cnt);
-	bpf_object__for_each_program(prog, obj) {
-		printf(" - prog_fd[%d] = fd(%d)\n", i, bpf_program__fd(prog));
-		i++;
-	}
-
-	i = 0;
-	/* Maps info */
-	printf("Loaded BPF prog have %d map(s)\n", map_cnt);
-	bpf_object__for_each_map(map, obj) {
-		const char *name = bpf_map__name(map);
-		int fd		 = bpf_map__fd(map);
-
-		printf(" - map_data[%d] = fd(%d) name:%s\n", i, fd, name);
-		i++;
-	}
-
-	/* Event info */
-	printf("Searching for (max:%d) event file descriptor(s)\n", tp_cnt);
-	for (i = 0; i < tp_cnt; i++) {
-		int fd = bpf_link__fd(tp_links[i]);
-
-		if (fd != -1)
-			printf(" - event_fd[%d] = fd(%d)\n", i, fd);
-	}
-}
 
 int main(int argc, char **argv)
 {
-	struct bpf_program *prog;
-	int longindex = 0, opt;
-	int ret = EXIT_FAILURE;
-	enum map_type type;
-	char filename[256];
-
-	/* Default settings: */
+	unsigned long interval = 2;
+	int ret = EXIT_FAIL_OPTION;
+	struct xdp_monitor *skel;
 	bool errors_only = true;
-	int interval = 2;
+	int longindex = 0, opt;
+	bool error = true;
 
 	/* Parse commands line args */
-	while ((opt = getopt_long(argc, argv, "hDSs:",
+	while ((opt = getopt_long(argc, argv, "si:vh",
 				  long_options, &longindex)) != -1) {
 		switch (opt) {
-		case 'D':
-			debug = true;
-			break;
-		case 'S':
+		case 's':
 			errors_only = false;
+			mask |= SAMPLE_REDIRECT_CNT;
 			break;
-		case 's':
-			interval = atoi(optarg);
+		case 'i':
+			interval = strtoul(optarg, NULL, 0);
+			break;
+		case 'v':
+			sample_switch_mode();
 			break;
 		case 'h':
+			error = false;
 		default:
-			usage(argv);
+			sample_usage(argv, long_options, __doc__, mask, error);
 			return ret;
 		}
 	}
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-
-	/* Remove tracepoint program when program is interrupted or killed */
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
-
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj)) {
-		printf("ERROR: opening BPF object file failed\n");
-		obj = NULL;
-		goto cleanup;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		printf("ERROR: loading BPF object file failed\n");
-		goto cleanup;
+	skel = xdp_monitor__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to xdp_monitor__open: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end;
 	}
 
-	for (type = 0; type < NUM_MAP; type++) {
-		map_data[type] =
-			bpf_object__find_map_by_name(obj, map_type_strings[type]);
-
-		if (libbpf_get_error(map_data[type])) {
-			printf("ERROR: finding a map in obj file failed\n");
-			goto cleanup;
-		}
-		map_cnt++;
+	ret = sample_init_pre_load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
 	}
 
-	bpf_object__for_each_program(prog, obj) {
-		tp_links[tp_cnt] = bpf_program__attach(prog);
-		if (libbpf_get_error(tp_links[tp_cnt])) {
-			printf("ERROR: bpf_program__attach failed\n");
-			tp_links[tp_cnt] = NULL;
-			goto cleanup;
-		}
-		tp_cnt++;
+	ret = xdp_monitor__load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to xdp_monitor__load: %s\n", strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
 	}
 
-	if (debug) {
-		print_bpf_prog_info();
+	ret = sample_init(skel, mask);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
 	}
 
-	/* Unload/stop tracepoint event by closing bpf_link's */
-	if (errors_only) {
-		/* The bpf_link[i] depend on the order of
-		 * the functions was defined in _kern.c
-		 */
-		bpf_link__destroy(tp_links[2]);	/* tracepoint/xdp/xdp_redirect */
-		tp_links[2] = NULL;
+	if (errors_only)
+		printf("%s", __doc_err_only__);
 
-		bpf_link__destroy(tp_links[3]);	/* tracepoint/xdp/xdp_redirect_map */
-		tp_links[3] = NULL;
+	ret = sample_run(interval, NULL, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
 	}
-
-	stats_poll(interval, errors_only);
-
-	ret = EXIT_SUCCESS;
-
-cleanup:
-	/* Detach tracepoints */
-	while (tp_cnt)
-		bpf_link__destroy(tp_links[--tp_cnt]);
-
-	bpf_object__close(obj);
-	return ret;
+	ret = EXIT_OK;
+end_destroy:
+	xdp_monitor__destroy(skel);
+end:
+	sample_exit(ret);
 }
-- 
2.33.0

