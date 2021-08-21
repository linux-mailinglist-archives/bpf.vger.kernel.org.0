Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B423F37A9
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 02:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbhHUAV6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 20:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbhHUAVt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 20:21:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F362C0612A5;
        Fri, 20 Aug 2021 17:21:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t1so10812263pgv.3;
        Fri, 20 Aug 2021 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDnXY1ednDonclXKnYZWgKEi+Ui/D7zYqxYJo8YIxsg=;
        b=ryYxMRtsDOmSNkLopQ23/lHo/GOCerZ7l2BpVIxIQDNmXldYywWZ+JPkq0it5PDx/h
         dUPxN4UXoacKlpthFdu8aLbd+jIXZ4NsSGFBww8W2/l6DNIn/09s9xCpCxyTbnrJcCZ3
         41fADWODFfF5nxXcRgU6+vzucXZJsN6AvuYxofSyNynL78OAWsHYDDovsJmLYYPyqqZi
         2F6i8mlpT5EIBZ1vxhlIPwYP2h6cQjAvCDVbWC0XJ2HhfSeAGqXOszX1sStRg7tinbLV
         Mz/laUp835JDM7BtAWX2F3l/RaIcZOSWAC8gJvQOhsp+RQBotg13M3AW6sBVch444tfQ
         8H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDnXY1ednDonclXKnYZWgKEi+Ui/D7zYqxYJo8YIxsg=;
        b=DrfsGisYEFOjeaFrj4yC/mFV29ZBnf6lAL57gktIp0jhhyFG4dMUDQMz8oAbMQ66cv
         hLHVsEy8M43LH7lYKbFSTkj4pL77jDsGDC/BXoYLyDuNXzjj4tAI845ulf9GDNrv2cVD
         VO5mH2xWAwDdfKWhZp4Z7z9jIhC4K3ynuo5jrdLMsW2tqKB7TOL6XMZwJDqkdVP7ybEv
         42rk6BhSlAxPH2La5mnsf0fUFIfGAy8AWMhuRfPa7tazaYa+dI8iRYqAd4H7ayvNqnI2
         1P4OuFV0pcv4VbDPvT8Hqs0cBE1REx1DlT+2nrkJtRDBT/8VSoD9dVBxLdT9Z1Fm4ckT
         6Ztw==
X-Gm-Message-State: AOAM532YIo5w1X3iOWWvFmNMb6WfA+P6RibPFhX5VQh/u7YMvSHzhIZc
        YQasFFvJInU+oySfs+FPaOcdMJsYwnc=
X-Google-Smtp-Source: ABdhPJyCu48RMRakOvUNUq8JWW+15+RppdrqAz2uj7EzfQS9Mn4adAf3cGjizvjGk52jRyIb1eTrbw==
X-Received: by 2002:a63:a4d:: with SMTP id z13mr20741126pgk.445.1629505268380;
        Fri, 20 Aug 2021 17:21:08 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id s26sm9052683pgv.46.2021.08.20.17.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 17:21:08 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 18/22] samples: bpf: Convert xdp_redirect_cpu to XDP samples helper
Date:   Sat, 21 Aug 2021 05:50:06 +0530
Message-Id: <20210821002010.845777-19-memxor@gmail.com>
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

Similar to xdp_monitor, xdp_redirect_cpu was quite featureful except a
few minor omissions (e.g. redirect errno reporting). All of these have
been moved to XDP samples helper, hence drop the unneeded code and
convert to usage of helpers provided by it.

One of the important changes here is dropping of mprog-disable option,
as we make that the default. Also, we support built-in programs for some
common actions on the packet when it reaches kthread (pass, drop,
redirect to device). If the user still needs to install a custom
program, they can still supply a BPF object, however the program should
be suitably tagged with SEC("xdp_cpumap") annotation so that the
expected attach type is correct when updating our cpumap map element.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/Makefile                |    5 +-
 samples/bpf/xdp_redirect_cpu_user.c | 1105 +++++++++------------------
 2 files changed, 343 insertions(+), 767 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 231cdbc773a7..43d3e52a8659 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -41,7 +41,6 @@ tprogs-y += test_map_in_map
 tprogs-y += per_socket_stats_example
 tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect_map_multi
-tprogs-y += xdp_redirect_cpu
 tprogs-y += xdp_rxq_info
 tprogs-y += syscall_tp
 tprogs-y += cpustat
@@ -55,6 +54,7 @@ tprogs-y += xdp_sample_pkts
 tprogs-y += ibumad
 tprogs-y += hbm
 
+tprogs-y += xdp_redirect_cpu
 tprogs-y += xdp_redirect
 tprogs-y += xdp_monitor
 
@@ -102,7 +102,6 @@ test_map_in_map-objs := test_map_in_map_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
 xdp_redirect_map-objs := xdp_redirect_map_user.o
 xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o
-xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o
 xdp_rxq_info-objs := xdp_rxq_info_user.o
 syscall_tp-objs := syscall_tp_user.o
 cpustat-objs := cpustat_user.o
@@ -116,6 +115,7 @@ xdp_sample_pkts-objs := xdp_sample_pkts_user.o
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
+xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o $(XDP_SAMPLE)
 xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
 xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
 
@@ -311,6 +311,7 @@ verify_target_bpf: verify_cmds
 $(BPF_SAMPLES_PATH)/*.c: verify_target_bpf $(LIBBPF)
 $(src)/*.c: verify_target_bpf $(LIBBPF)
 
+$(obj)/xdp_redirect_cpu_user.o: $(obj)/xdp_redirect_cpu.skel.h
 $(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
 $(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
 
diff --git a/samples/bpf/xdp_redirect_cpu_user.c b/samples/bpf/xdp_redirect_cpu_user.c
index 9e225c96b77e..631700aef69c 100644
--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ b/samples/bpf/xdp_redirect_cpu_user.c
@@ -2,7 +2,16 @@
 /* Copyright(c) 2017 Jesper Dangaard Brouer, Red Hat, Inc.
  */
 static const char *__doc__ =
-	" XDP redirect with a CPU-map type \"BPF_MAP_TYPE_CPUMAP\"";
+"XDP CPU redirect tool, using BPF_MAP_TYPE_CPUMAP\n"
+"Usage: xdp_redirect_cpu -d <IFINDEX|IFNAME> -c 0 ... -c N\n"
+"Valid specification for CPUMAP BPF program:\n"
+"  --mprog-name/-e pass (use built-in XDP_PASS program)\n"
+"  --mprog-name/-e drop (use built-in XDP_DROP program)\n"
+"  --redirect-device/-r <ifindex|ifname> (use built-in DEVMAP redirect program)\n"
+"  Custom CPUMAP BPF program:\n"
+"    --mprog-filename/-f <filename> --mprog-name/-e <program>\n"
+"    Optionally, also pass --redirect-map/-m and --redirect-device/-r together\n"
+"    to configure DEVMAP in BPF object <filename>\n";
 
 #include <errno.h>
 #include <signal.h>
@@ -18,558 +27,62 @@ static const char *__doc__ =
 #include <net/if.h>
 #include <time.h>
 #include <linux/limits.h>
-
 #include <arpa/inet.h>
 #include <linux/if_link.h>
-
-/* How many xdp_progs are defined in _kern.c */
-#define MAX_PROG 6
-
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
-
 #include "bpf_util.h"
+#include "xdp_sample_user.h"
+#include "xdp_redirect_cpu.skel.h"
 
-static int ifindex = -1;
-static char ifname_buf[IF_NAMESIZE];
-static char *ifname;
-static __u32 prog_id;
-
-static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-static int n_cpus;
-
-enum map_type {
-	CPU_MAP,
-	RX_CNT,
-	REDIRECT_ERR_CNT,
-	CPUMAP_ENQUEUE_CNT,
-	CPUMAP_KTHREAD_CNT,
-	CPUS_AVAILABLE,
-	CPUS_COUNT,
-	CPUS_ITERATOR,
-	EXCEPTION_CNT,
-};
+static int map_fd;
+static int avail_fd;
+static int count_fd;
 
-static const char *const map_type_strings[] = {
-	[CPU_MAP] = "cpu_map",
-	[RX_CNT] = "rx_cnt",
-	[REDIRECT_ERR_CNT] = "redirect_err_cnt",
-	[CPUMAP_ENQUEUE_CNT] = "cpumap_enqueue_cnt",
-	[CPUMAP_KTHREAD_CNT] = "cpumap_kthread_cnt",
-	[CPUS_AVAILABLE] = "cpus_available",
-	[CPUS_COUNT] = "cpus_count",
-	[CPUS_ITERATOR] = "cpus_iterator",
-	[EXCEPTION_CNT] = "exception_cnt",
-};
+static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
+		  SAMPLE_CPUMAP_ENQUEUE_CNT | SAMPLE_CPUMAP_KTHREAD_CNT |
+		  SAMPLE_EXCEPTION_CNT;
 
-#define NUM_TP 5
-#define NUM_MAP 9
-struct bpf_link *tp_links[NUM_TP] = {};
-static int map_fds[NUM_MAP];
-static int tp_cnt = 0;
-
-/* Exit return codes */
-#define EXIT_OK		0
-#define EXIT_FAIL		1
-#define EXIT_FAIL_OPTION	2
-#define EXIT_FAIL_XDP		3
-#define EXIT_FAIL_BPF		4
-#define EXIT_FAIL_MEM		5
+DEFINE_SAMPLE_INIT(xdp_redirect_cpu);
 
 static const struct option long_options[] = {
-	{"help",	no_argument,		NULL, 'h' },
-	{"dev",		required_argument,	NULL, 'd' },
-	{"skb-mode",	no_argument,		NULL, 'S' },
-	{"sec",		required_argument,	NULL, 's' },
-	{"progname",	required_argument,	NULL, 'p' },
-	{"qsize",	required_argument,	NULL, 'q' },
-	{"cpu",		required_argument,	NULL, 'c' },
-	{"stress-mode", no_argument,		NULL, 'x' },
-	{"no-separators", no_argument,		NULL, 'z' },
-	{"force",	no_argument,		NULL, 'F' },
-	{"mprog-disable", no_argument,		NULL, 'n' },
-	{"mprog-name",	required_argument,	NULL, 'e' },
-	{"mprog-filename", required_argument,	NULL, 'f' },
-	{"redirect-device", required_argument,	NULL, 'r' },
-	{"redirect-map", required_argument,	NULL, 'm' },
-	{0, 0, NULL,  0 }
+	{ "help", no_argument, NULL, 'h' },
+	{ "dev", required_argument, NULL, 'd' },
+	{ "skb-mode", no_argument, NULL, 'S' },
+	{ "progname", required_argument, NULL, 'p' },
+	{ "qsize", required_argument, NULL, 'q' },
+	{ "cpu", required_argument, NULL, 'c' },
+	{ "stress-mode", no_argument, NULL, 'x' },
+	{ "force", no_argument, NULL, 'F' },
+	{ "interval", required_argument, NULL, 'i' },
+	{ "verbose", no_argument, NULL, 'v' },
+	{ "stats", no_argument, NULL, 's' },
+	{ "mprog-name", required_argument, NULL, 'e' },
+	{ "mprog-filename", required_argument, NULL, 'f' },
+	{ "redirect-device", required_argument, NULL, 'r' },
+	{ "redirect-map", required_argument, NULL, 'm' },
+	{}
 };
 
-static void int_exit(int sig)
-{
-	__u32 curr_prog_id = 0;
-
-	if (ifindex > -1) {
-		if (bpf_get_link_xdp_id(ifindex, &curr_prog_id, xdp_flags)) {
-			printf("bpf_get_link_xdp_id failed\n");
-			exit(EXIT_FAIL);
-		}
-		if (prog_id == curr_prog_id) {
-			fprintf(stderr,
-				"Interrupted: Removing XDP program on ifindex:%d device:%s\n",
-				ifindex, ifname);
-			bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
-		} else if (!curr_prog_id) {
-			printf("couldn't find a prog id on a given iface\n");
-		} else {
-			printf("program on interface changed, not removing\n");
-		}
-	}
-	/* Detach tracepoints */
-	while (tp_cnt)
-		bpf_link__destroy(tp_links[--tp_cnt]);
-
-	exit(EXIT_OK);
-}
-
 static void print_avail_progs(struct bpf_object *obj)
 {
 	struct bpf_program *pos;
 
+	printf(" Programs to be used for -p/--progname:\n");
 	bpf_object__for_each_program(pos, obj) {
-		if (bpf_program__is_xdp(pos))
-			printf(" %s\n", bpf_program__section_name(pos));
-	}
-}
-
-static void usage(char *argv[], struct bpf_object *obj)
-{
-	int i;
-
-	printf("\nDOCUMENTATION:\n%s\n", __doc__);
-	printf("\n");
-	printf(" Usage: %s (options-see-below)\n", argv[0]);
-	printf(" Listing options:\n");
-	for (i = 0; long_options[i].name != 0; i++) {
-		printf(" --%-12s", long_options[i].name);
-		if (long_options[i].flag != NULL)
-			printf(" flag (internal value:%d)",
-				*long_options[i].flag);
-		else
-			printf(" short-option: -%c",
-				long_options[i].val);
-		printf("\n");
-	}
-	printf("\n Programs to be used for --progname:\n");
-	print_avail_progs(obj);
-	printf("\n");
-}
-
-/* gettime returns the current time of day in nanoseconds.
- * Cost: clock_gettime (ns) => 26ns (CLOCK_MONOTONIC)
- *       clock_gettime (ns) =>  9ns (CLOCK_MONOTONIC_COARSE)
- */
-#define NANOSEC_PER_SEC 1000000000 /* 10^9 */
-static __u64 gettime(void)
-{
-	struct timespec t;
-	int res;
-
-	res = clock_gettime(CLOCK_MONOTONIC, &t);
-	if (res < 0) {
-		fprintf(stderr, "Error with gettimeofday! (%i)\n", res);
-		exit(EXIT_FAIL);
-	}
-	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
-}
-
-/* Common stats data record shared with _kern.c */
-struct datarec {
-	__u64 processed;
-	__u64 dropped;
-	__u64 issue;
-	__u64 xdp_pass;
-	__u64 xdp_drop;
-	__u64 xdp_redirect;
-};
-struct record {
-	__u64 timestamp;
-	struct datarec total;
-	struct datarec *cpu;
-};
-struct stats_record {
-	struct record rx_cnt;
-	struct record redir_err;
-	struct record kthread;
-	struct record exception;
-	struct record enq[];
-};
-
-static bool map_collect_percpu(int fd, __u32 key, struct record *rec)
-{
-	/* For percpu maps, userspace gets a value per possible CPU */
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct datarec values[nr_cpus];
-	__u64 sum_xdp_redirect = 0;
-	__u64 sum_xdp_pass = 0;
-	__u64 sum_xdp_drop = 0;
-	__u64 sum_processed = 0;
-	__u64 sum_dropped = 0;
-	__u64 sum_issue = 0;
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
-		rec->cpu[i].issue = values[i].issue;
-		sum_issue        += values[i].issue;
-		rec->cpu[i].xdp_pass = values[i].xdp_pass;
-		sum_xdp_pass += values[i].xdp_pass;
-		rec->cpu[i].xdp_drop = values[i].xdp_drop;
-		sum_xdp_drop += values[i].xdp_drop;
-		rec->cpu[i].xdp_redirect = values[i].xdp_redirect;
-		sum_xdp_redirect += values[i].xdp_redirect;
-	}
-	rec->total.processed = sum_processed;
-	rec->total.dropped   = sum_dropped;
-	rec->total.issue     = sum_issue;
-	rec->total.xdp_pass  = sum_xdp_pass;
-	rec->total.xdp_drop  = sum_xdp_drop;
-	rec->total.xdp_redirect = sum_xdp_redirect;
-	return true;
-}
-
-static struct datarec *alloc_record_per_cpu(void)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct datarec *array;
-
-	array = calloc(nr_cpus, sizeof(struct datarec));
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
-	int i, size;
-
-	size = sizeof(*rec) + n_cpus * sizeof(struct record);
-	rec = malloc(size);
-	if (!rec) {
-		fprintf(stderr, "Mem alloc error\n");
-		exit(EXIT_FAIL_MEM);
-	}
-	memset(rec, 0, size);
-	rec->rx_cnt.cpu    = alloc_record_per_cpu();
-	rec->redir_err.cpu = alloc_record_per_cpu();
-	rec->kthread.cpu   = alloc_record_per_cpu();
-	rec->exception.cpu = alloc_record_per_cpu();
-	for (i = 0; i < n_cpus; i++)
-		rec->enq[i].cpu = alloc_record_per_cpu();
-
-	return rec;
-}
-
-static void free_stats_record(struct stats_record *r)
-{
-	int i;
-
-	for (i = 0; i < n_cpus; i++)
-		free(r->enq[i].cpu);
-	free(r->exception.cpu);
-	free(r->kthread.cpu);
-	free(r->redir_err.cpu);
-	free(r->rx_cnt.cpu);
-	free(r);
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
-static __u64 calc_pps(struct datarec *r, struct datarec *p, double period_)
-{
-	__u64 packets = 0;
-	__u64 pps = 0;
-
-	if (period_ > 0) {
-		packets = r->processed - p->processed;
-		pps = packets / period_;
-	}
-	return pps;
-}
-
-static __u64 calc_drop_pps(struct datarec *r, struct datarec *p, double period_)
-{
-	__u64 packets = 0;
-	__u64 pps = 0;
-
-	if (period_ > 0) {
-		packets = r->dropped - p->dropped;
-		pps = packets / period_;
-	}
-	return pps;
-}
-
-static __u64 calc_errs_pps(struct datarec *r,
-			    struct datarec *p, double period_)
-{
-	__u64 packets = 0;
-	__u64 pps = 0;
-
-	if (period_ > 0) {
-		packets = r->issue - p->issue;
-		pps = packets / period_;
-	}
-	return pps;
-}
-
-static void calc_xdp_pps(struct datarec *r, struct datarec *p,
-			 double *xdp_pass, double *xdp_drop,
-			 double *xdp_redirect, double period_)
-{
-	*xdp_pass = 0, *xdp_drop = 0, *xdp_redirect = 0;
-	if (period_ > 0) {
-		*xdp_redirect = (r->xdp_redirect - p->xdp_redirect) / period_;
-		*xdp_pass = (r->xdp_pass - p->xdp_pass) / period_;
-		*xdp_drop = (r->xdp_drop - p->xdp_drop) / period_;
-	}
-}
-
-static void stats_print(struct stats_record *stats_rec,
-			struct stats_record *stats_prev,
-			char *prog_name, char *mprog_name, int mprog_fd)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	double pps = 0, drop = 0, err = 0;
-	bool mprog_enabled = false;
-	struct record *rec, *prev;
-	int to_cpu;
-	double t;
-	int i;
-
-	if (mprog_fd > 0)
-		mprog_enabled = true;
-
-	/* Header */
-	printf("Running XDP/eBPF prog_name:%s\n", prog_name);
-	printf("%-15s %-7s %-14s %-11s %-9s\n",
-	       "XDP-cpumap", "CPU:to", "pps", "drop-pps", "extra-info");
-
-	/* XDP rx_cnt */
-	{
-		char *fmt_rx = "%-15s %-7d %'-14.0f %'-11.0f %'-10.0f %s\n";
-		char *fm2_rx = "%-15s %-7s %'-14.0f %'-11.0f\n";
-		char *errstr = "";
-
-		rec  = &stats_rec->rx_cnt;
-		prev = &stats_prev->rx_cnt;
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps = calc_pps(r, p, t);
-			drop = calc_drop_pps(r, p, t);
-			err  = calc_errs_pps(r, p, t);
-			if (err > 0)
-				errstr = "cpu-dest/err";
-			if (pps > 0)
-				printf(fmt_rx, "XDP-RX",
-					i, pps, drop, err, errstr);
-		}
-		pps  = calc_pps(&rec->total, &prev->total, t);
-		drop = calc_drop_pps(&rec->total, &prev->total, t);
-		err  = calc_errs_pps(&rec->total, &prev->total, t);
-		printf(fm2_rx, "XDP-RX", "total", pps, drop);
-	}
-
-	/* cpumap enqueue stats */
-	for (to_cpu = 0; to_cpu < n_cpus; to_cpu++) {
-		char *fmt = "%-15s %3d:%-3d %'-14.0f %'-11.0f %'-10.2f %s\n";
-		char *fm2 = "%-15s %3s:%-3d %'-14.0f %'-11.0f %'-10.2f %s\n";
-		char *errstr = "";
-
-		rec  =  &stats_rec->enq[to_cpu];
-		prev = &stats_prev->enq[to_cpu];
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps  = calc_pps(r, p, t);
-			drop = calc_drop_pps(r, p, t);
-			err  = calc_errs_pps(r, p, t);
-			if (err > 0) {
-				errstr = "bulk-average";
-				err = pps / err; /* calc average bulk size */
-			}
-			if (pps > 0)
-				printf(fmt, "cpumap-enqueue",
-				       i, to_cpu, pps, drop, err, errstr);
-		}
-		pps = calc_pps(&rec->total, &prev->total, t);
-		if (pps > 0) {
-			drop = calc_drop_pps(&rec->total, &prev->total, t);
-			err  = calc_errs_pps(&rec->total, &prev->total, t);
-			if (err > 0) {
-				errstr = "bulk-average";
-				err = pps / err; /* calc average bulk size */
-			}
-			printf(fm2, "cpumap-enqueue",
-			       "sum", to_cpu, pps, drop, err, errstr);
-		}
-	}
-
-	/* cpumap kthread stats */
-	{
-		char *fmt_k = "%-15s %-7d %'-14.0f %'-11.0f %'-10.0f %s\n";
-		char *fm2_k = "%-15s %-7s %'-14.0f %'-11.0f %'-10.0f %s\n";
-		char *e_str = "";
-
-		rec  = &stats_rec->kthread;
-		prev = &stats_prev->kthread;
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps  = calc_pps(r, p, t);
-			drop = calc_drop_pps(r, p, t);
-			err  = calc_errs_pps(r, p, t);
-			if (err > 0)
-				e_str = "sched";
-			if (pps > 0)
-				printf(fmt_k, "cpumap_kthread",
-				       i, pps, drop, err, e_str);
-		}
-		pps = calc_pps(&rec->total, &prev->total, t);
-		drop = calc_drop_pps(&rec->total, &prev->total, t);
-		err  = calc_errs_pps(&rec->total, &prev->total, t);
-		if (err > 0)
-			e_str = "sched-sum";
-		printf(fm2_k, "cpumap_kthread", "total", pps, drop, err, e_str);
-	}
-
-	/* XDP redirect err tracepoints (very unlikely) */
-	{
-		char *fmt_err = "%-15s %-7d %'-14.0f %'-11.0f\n";
-		char *fm2_err = "%-15s %-7s %'-14.0f %'-11.0f\n";
-
-		rec  = &stats_rec->redir_err;
-		prev = &stats_prev->redir_err;
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps  = calc_pps(r, p, t);
-			drop = calc_drop_pps(r, p, t);
-			if (pps > 0)
-				printf(fmt_err, "redirect_err", i, pps, drop);
+		if (bpf_program__is_xdp(pos)) {
+			if (!strncmp(bpf_program__name(pos), "xdp_prognum",
+				     sizeof("xdp_prognum") - 1))
+				printf(" %s\n", bpf_program__name(pos));
 		}
-		pps = calc_pps(&rec->total, &prev->total, t);
-		drop = calc_drop_pps(&rec->total, &prev->total, t);
-		printf(fm2_err, "redirect_err", "total", pps, drop);
 	}
-
-	/* XDP general exception tracepoints */
-	{
-		char *fmt_err = "%-15s %-7d %'-14.0f %'-11.0f\n";
-		char *fm2_err = "%-15s %-7s %'-14.0f %'-11.0f\n";
-
-		rec  = &stats_rec->exception;
-		prev = &stats_prev->exception;
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps  = calc_pps(r, p, t);
-			drop = calc_drop_pps(r, p, t);
-			if (pps > 0)
-				printf(fmt_err, "xdp_exception", i, pps, drop);
-		}
-		pps = calc_pps(&rec->total, &prev->total, t);
-		drop = calc_drop_pps(&rec->total, &prev->total, t);
-		printf(fm2_err, "xdp_exception", "total", pps, drop);
-	}
-
-	/* CPUMAP attached XDP program that runs on remote/destination CPU */
-	if (mprog_enabled) {
-		char *fmt_k = "%-15s %-7d %'-14.0f %'-11.0f %'-10.0f\n";
-		char *fm2_k = "%-15s %-7s %'-14.0f %'-11.0f %'-10.0f\n";
-		double xdp_pass, xdp_drop, xdp_redirect;
-
-		printf("\n2nd remote XDP/eBPF prog_name: %s\n", mprog_name);
-		printf("%-15s %-7s %-14s %-11s %-9s\n",
-		       "XDP-cpumap", "CPU:to", "xdp-pass", "xdp-drop", "xdp-redir");
-
-		rec  = &stats_rec->kthread;
-		prev = &stats_prev->kthread;
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			calc_xdp_pps(r, p, &xdp_pass, &xdp_drop,
-				     &xdp_redirect, t);
-			if (xdp_pass > 0 || xdp_drop > 0 || xdp_redirect > 0)
-				printf(fmt_k, "xdp-in-kthread", i, xdp_pass, xdp_drop,
-				       xdp_redirect);
-		}
-		calc_xdp_pps(&rec->total, &prev->total, &xdp_pass, &xdp_drop,
-			     &xdp_redirect, t);
-		printf(fm2_k, "xdp-in-kthread", "total", xdp_pass, xdp_drop, xdp_redirect);
-	}
-
-	printf("\n");
-	fflush(stdout);
-}
-
-static void stats_collect(struct stats_record *rec)
-{
-	int fd, i;
-
-	fd = map_fds[RX_CNT];
-	map_collect_percpu(fd, 0, &rec->rx_cnt);
-
-	fd = map_fds[REDIRECT_ERR_CNT];
-	map_collect_percpu(fd, 1, &rec->redir_err);
-
-	fd = map_fds[CPUMAP_ENQUEUE_CNT];
-	for (i = 0; i < n_cpus; i++)
-		map_collect_percpu(fd, i, &rec->enq[i]);
-
-	fd = map_fds[CPUMAP_KTHREAD_CNT];
-	map_collect_percpu(fd, 0, &rec->kthread);
-
-	fd = map_fds[EXCEPTION_CNT];
-	map_collect_percpu(fd, 0, &rec->exception);
 }
 
-
-/* Pointer swap trick */
-static inline void swap(struct stats_record **a, struct stats_record **b)
+static void usage(char *argv[], const struct option *long_options,
+		  const char *doc, int mask, bool error, struct bpf_object *obj)
 {
-	struct stats_record *tmp;
-
-	tmp = *a;
-	*a = *b;
-	*b = tmp;
+	sample_usage(argv, long_options, doc, mask, error);
+	print_avail_progs(obj);
 }
 
 static int create_cpu_entry(__u32 cpu, struct bpf_cpumap_val *value,
@@ -582,39 +95,41 @@ static int create_cpu_entry(__u32 cpu, struct bpf_cpumap_val *value,
 	/* Add a CPU entry to cpumap, as this allocate a cpu entry in
 	 * the kernel for the cpu.
 	 */
-	ret = bpf_map_update_elem(map_fds[CPU_MAP], &cpu, value, 0);
-	if (ret) {
-		fprintf(stderr, "Create CPU entry failed (err:%d)\n", ret);
-		exit(EXIT_FAIL_BPF);
+	ret = bpf_map_update_elem(map_fd, &cpu, value, 0);
+	if (ret < 0) {
+		fprintf(stderr, "Create CPU entry failed: %s\n", strerror(errno));
+		return ret;
 	}
 
 	/* Inform bpf_prog's that a new CPU is available to select
 	 * from via some control maps.
 	 */
-	ret = bpf_map_update_elem(map_fds[CPUS_AVAILABLE], &avail_idx, &cpu, 0);
-	if (ret) {
-		fprintf(stderr, "Add to avail CPUs failed\n");
-		exit(EXIT_FAIL_BPF);
+	ret = bpf_map_update_elem(avail_fd, &avail_idx, &cpu, 0);
+	if (ret < 0) {
+		fprintf(stderr, "Add to avail CPUs failed: %s\n", strerror(errno));
+		return ret;
 	}
 
 	/* When not replacing/updating existing entry, bump the count */
-	ret = bpf_map_lookup_elem(map_fds[CPUS_COUNT], &key, &curr_cpus_count);
-	if (ret) {
-		fprintf(stderr, "Failed reading curr cpus_count\n");
-		exit(EXIT_FAIL_BPF);
+	ret = bpf_map_lookup_elem(count_fd, &key, &curr_cpus_count);
+	if (ret < 0) {
+		fprintf(stderr, "Failed reading curr cpus_count: %s\n",
+			strerror(errno));
+		return ret;
 	}
 	if (new) {
 		curr_cpus_count++;
-		ret = bpf_map_update_elem(map_fds[CPUS_COUNT], &key,
+		ret = bpf_map_update_elem(count_fd, &key,
 					  &curr_cpus_count, 0);
-		if (ret) {
-			fprintf(stderr, "Failed write curr cpus_count\n");
-			exit(EXIT_FAIL_BPF);
+		if (ret < 0) {
+			fprintf(stderr, "Failed write curr cpus_count: %s\n",
+				strerror(errno));
+			return ret;
 		}
 	}
-	/* map_fd[7] = cpus_iterator */
-	printf("%s CPU:%u as idx:%u qsize:%d prog_fd: %d (cpus_count:%u)\n",
-	       new ? "Add-new":"Replace", cpu, avail_idx,
+
+	printf("%s CPU: %u as idx: %u qsize: %d cpumap_prog_fd: %d (cpus_count: %u)\n",
+	       new ? "Add new" : "Replace", cpu, avail_idx,
 	       value->qsize, value->bpf_prog.fd, curr_cpus_count);
 
 	return 0;
@@ -623,24 +138,29 @@ static int create_cpu_entry(__u32 cpu, struct bpf_cpumap_val *value,
 /* CPUs are zero-indexed. Thus, add a special sentinel default value
  * in map cpus_available to mark CPU index'es not configured
  */
-static void mark_cpus_unavailable(void)
+static int mark_cpus_unavailable(void)
 {
-	__u32 invalid_cpu = n_cpus;
-	int ret, i;
+	int ret, i, n_cpus = libbpf_num_possible_cpus();
+	__u32 invalid_cpu;
 
 	for (i = 0; i < n_cpus; i++) {
-		ret = bpf_map_update_elem(map_fds[CPUS_AVAILABLE], &i,
+		ret = bpf_map_update_elem(avail_fd, &i,
 					  &invalid_cpu, 0);
-		if (ret) {
-			fprintf(stderr, "Failed marking CPU unavailable\n");
-			exit(EXIT_FAIL_BPF);
+		if (ret < 0) {
+			fprintf(stderr, "Failed marking CPU unavailable: %s\n",
+				strerror(errno));
+			return ret;
 		}
 	}
+
+	return 0;
 }
 
 /* Stress cpumap management code by concurrently changing underlying cpumap */
-static void stress_cpumap(struct bpf_cpumap_val *value)
+static void stress_cpumap(void *ctx)
 {
+	struct bpf_cpumap_val *value = ctx;
+
 	/* Changing qsize will cause kernel to free and alloc a new
 	 * bpf_cpu_map_entry, with an associated/complicated tear-down
 	 * procedure.
@@ -653,144 +173,163 @@ static void stress_cpumap(struct bpf_cpumap_val *value)
 	create_cpu_entry(1, value, 0, false);
 }
 
-static void stats_poll(int interval, bool use_separators, char *prog_name,
-		       char *mprog_name, struct bpf_cpumap_val *value,
-		       bool stress_mode)
-{
-	struct stats_record *record, *prev;
-	int mprog_fd;
-
-	record = alloc_stats_record();
-	prev   = alloc_stats_record();
-	stats_collect(record);
-
-	/* Trick to pretty printf with thousands separators use %' */
-	if (use_separators)
-		setlocale(LC_NUMERIC, "en_US");
-
-	while (1) {
-		swap(&prev, &record);
-		mprog_fd = value->bpf_prog.fd;
-		stats_collect(record);
-		stats_print(record, prev, prog_name, mprog_name, mprog_fd);
-		sleep(interval);
-		if (stress_mode)
-			stress_cpumap(value);
-	}
-
-	free_stats_record(record);
-	free_stats_record(prev);
-}
-
-static int init_tracepoints(struct bpf_object *obj)
+static int set_cpumap_prog(struct xdp_redirect_cpu *skel,
+			   const char *redir_interface, const char *redir_map,
+			   const char *mprog_filename, const char *mprog_name)
 {
-	struct bpf_program *prog;
-
-	bpf_object__for_each_program(prog, obj) {
-		if (bpf_program__is_tracepoint(prog) != true)
-			continue;
-
-		tp_links[tp_cnt] = bpf_program__attach(prog);
-		if (libbpf_get_error(tp_links[tp_cnt])) {
-			tp_links[tp_cnt] = NULL;
-			return -EINVAL;
+	if (mprog_filename) {
+		struct bpf_program *prog;
+		struct bpf_object *obj;
+		int ret;
+
+		if (!mprog_name) {
+			fprintf(stderr, "BPF program not specified for file %s\n",
+				mprog_filename);
+			goto end;
+		}
+		if ((redir_interface && !redir_map) || (!redir_interface && redir_map)) {
+			fprintf(stderr, "--redirect-%s specified but --redirect-%s not specified\n",
+				redir_interface ? "device" : "map", redir_interface ? "map" : "device");
+			goto end;
 		}
-		tp_cnt++;
-	}
-
-	return 0;
-}
-
-static int init_map_fds(struct bpf_object *obj)
-{
-	enum map_type type;
-
-	for (type = 0; type < NUM_MAP; type++) {
-		map_fds[type] =
-			bpf_object__find_map_fd_by_name(obj,
-							map_type_strings[type]);
-
-		if (map_fds[type] < 0)
-			return -ENOENT;
-	}
-
-	return 0;
-}
 
-static int load_cpumap_prog(char *file_name, char *prog_name,
-			    char *redir_interface, char *redir_map)
-{
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type		= BPF_PROG_TYPE_XDP,
-		.expected_attach_type	= BPF_XDP_CPUMAP,
-		.file = file_name,
-	};
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	int fd;
+		/* Custom BPF program */
+		obj = bpf_object__open_file(mprog_filename, NULL);
+		if (!obj) {
+			ret = -errno;
+			fprintf(stderr, "Failed to bpf_prog_load_xattr: %s\n",
+				strerror(errno));
+			return ret;
+		}
 
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &fd))
-		return -1;
+		ret = bpf_object__load(obj);
+		if (ret < 0) {
+			ret = -errno;
+			fprintf(stderr, "Failed to bpf_object__load: %s\n",
+				strerror(errno));
+			return ret;
+		}
 
-	if (fd < 0) {
-		fprintf(stderr, "ERR: bpf_prog_load_xattr: %s\n",
-			strerror(errno));
-		return fd;
-	}
+		if (redir_map) {
+			int err, redir_map_fd, ifindex_out, key = 0;
 
-	if (redir_interface && redir_map) {
-		int err, map_fd, ifindex_out, key = 0;
+			redir_map_fd = bpf_object__find_map_fd_by_name(obj, redir_map);
+			if (redir_map_fd < 0) {
+				fprintf(stderr, "Failed to bpf_object__find_map_fd_by_name: %s\n",
+					strerror(errno));
+				return redir_map_fd;
+			}
 
-		map_fd = bpf_object__find_map_fd_by_name(obj, redir_map);
-		if (map_fd < 0)
-			return map_fd;
+			ifindex_out = if_nametoindex(redir_interface);
+			if (!ifindex_out)
+				ifindex_out = strtoul(redir_interface, NULL, 0);
+			if (!ifindex_out) {
+				fprintf(stderr, "Bad interface name or index\n");
+				return -EINVAL;
+			}
 
-		ifindex_out = if_nametoindex(redir_interface);
-		if (!ifindex_out)
-			return -1;
+			err = bpf_map_update_elem(redir_map_fd, &key, &ifindex_out, 0);
+			if (err < 0)
+				return err;
+		}
 
-		err = bpf_map_update_elem(map_fd, &key, &ifindex_out, 0);
-		if (err < 0)
-			return err;
-	}
+		prog = bpf_object__find_program_by_name(obj, mprog_name);
+		if (!prog) {
+			ret = -errno;
+			fprintf(stderr, "Failed to bpf_object__find_program_by_name: %s\n",
+				strerror(errno));
+			return ret;
+		}
 
-	prog = bpf_object__find_program_by_title(obj, prog_name);
-	if (!prog) {
-		fprintf(stderr, "bpf_object__find_program_by_title failed\n");
-		return EXIT_FAIL;
+		return bpf_program__fd(prog);
+	} else {
+		if (mprog_name) {
+			if (redir_interface || redir_map) {
+				fprintf(stderr, "Need to specify --mprog-filename/-f\n");
+				goto end;
+			}
+			if (!strcmp(mprog_name, "pass") || !strcmp(mprog_name, "drop")) {
+				/* Use built-in pass/drop programs */
+				return *mprog_name == 'p' ? bpf_program__fd(skel->progs.xdp_redirect_cpu_pass)
+					: bpf_program__fd(skel->progs.xdp_redirect_cpu_drop);
+			} else {
+				fprintf(stderr, "Unknown name \"%s\" for built-in BPF program\n",
+					mprog_name);
+				goto end;
+			}
+		} else {
+			if (redir_map) {
+				fprintf(stderr, "Need to specify --mprog-filename, --mprog-name and"
+					" --redirect-device with --redirect-map\n");
+				goto end;
+			}
+			if (redir_interface) {
+				/* Use built-in devmap redirect */
+				struct bpf_devmap_val val = {};
+				int ifindex_out, err;
+				__u32 key = 0;
+
+				if (!redir_interface)
+					return 0;
+
+				ifindex_out = if_nametoindex(redir_interface);
+				if (!ifindex_out)
+					ifindex_out = strtoul(redir_interface, NULL, 0);
+				if (!ifindex_out) {
+					fprintf(stderr, "Bad interface name or index\n");
+					return -EINVAL;
+				}
+
+				if (get_mac_addr(ifindex_out, skel->bss->tx_mac_addr) < 0) {
+					printf("Get interface %d mac failed\n", ifindex_out);
+					return -EINVAL;
+				}
+
+				val.ifindex = ifindex_out;
+				val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_redirect_egress_prog);
+				err = bpf_map_update_elem(bpf_map__fd(skel->maps.tx_port), &key, &val, 0);
+				if (err < 0)
+					return -errno;
+
+				return bpf_program__fd(skel->progs.xdp_redirect_cpu_devmap);
+			}
+		}
 	}
 
-	return bpf_program__fd(prog);
+	/* Disabled */
+	return 0;
+end:
+	fprintf(stderr, "Invalid options for CPUMAP BPF program\n");
+	return -EINVAL;
 }
 
 int main(int argc, char **argv)
 {
-	char *prog_name = "xdp_cpu_map5_lb_hash_ip_pairs";
-	char *mprog_filename = "xdp_redirect_kern.o";
-	char *redir_interface = NULL, *redir_map = NULL;
-	char *mprog_name = "xdp_redirect_dummy";
-	bool mprog_disable = false;
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_UNSPEC,
-	};
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
+	const char *redir_interface = NULL, *redir_map = NULL;
+	const char *mprog_filename = NULL, *mprog_name = NULL;
+	struct xdp_redirect_cpu *skel;
+	struct bpf_map_info info = {};
+	char ifname_buf[IF_NAMESIZE];
 	struct bpf_cpumap_val value;
-	bool use_separators = true;
+	__u32 infosz = sizeof(info);
+	int ret = EXIT_FAIL_OPTION;
+	unsigned long interval = 2;
 	bool stress_mode = false;
 	struct bpf_program *prog;
-	struct bpf_object *obj;
-	int err = EXIT_FAIL;
-	char filename[256];
+	const char *prog_name;
+	bool generic = false;
+	bool force = false;
 	int added_cpus = 0;
+	bool error = true;
 	int longindex = 0;
-	int interval = 2;
 	int add_cpu = -1;
-	int opt, prog_fd;
-	int *cpu, i;
+	int ifindex = -1;
+	int *cpu, i, opt;
+	char *ifname;
 	__u32 qsize;
+	int n_cpus;
 
-	n_cpus = get_nprocs_conf();
+	n_cpus = libbpf_num_possible_cpus();
 
 	/* Notice: Choosing the queue size is very important when CPU is
 	 * configured with power-saving states.
@@ -810,73 +349,87 @@ int main(int argc, char **argv)
 	 */
 	qsize = 2048;
 
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
-
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
-		return err;
-
-	if (prog_fd < 0) {
-		fprintf(stderr, "ERR: bpf_prog_load_xattr: %s\n",
+	skel = xdp_redirect_cpu__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to xdp_redirect_cpu__open: %s\n",
 			strerror(errno));
-		return err;
+		ret = EXIT_FAIL_BPF;
+		goto end;
+	}
+
+	ret = sample_init_pre_load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
 	}
 
-	if (init_tracepoints(obj) < 0) {
-		fprintf(stderr, "ERR: bpf_program__attach failed\n");
-		return err;
+	if (bpf_map__set_max_entries(skel->maps.cpu_map, n_cpus) < 0) {
+		fprintf(stderr, "Failed to set max entries for cpu_map map: %s",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
 	}
 
-	if (init_map_fds(obj) < 0) {
-		fprintf(stderr, "bpf_object__find_map_fd_by_name failed\n");
-		return err;
+	if (bpf_map__set_max_entries(skel->maps.cpus_available, n_cpus) < 0) {
+		fprintf(stderr, "Failed to set max entries for cpus_available map: %s",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
 	}
-	mark_cpus_unavailable();
 
-	cpu = malloc(n_cpus * sizeof(int));
+	cpu = calloc(n_cpus, sizeof(int));
 	if (!cpu) {
-		fprintf(stderr, "failed to allocate cpu array\n");
-		return err;
+		fprintf(stderr, "Failed to allocate cpu array\n");
+		goto end_destroy;
 	}
-	memset(cpu, 0, n_cpus * sizeof(int));
 
-	/* Parse commands line args */
-	while ((opt = getopt_long(argc, argv, "hSd:s:p:q:c:xzFf:e:r:m:n",
+	prog = skel->progs.xdp_prognum5_lb_hash_ip_pairs;
+	while ((opt = getopt_long(argc, argv, "d:si:Sxp:f:e:r:m:c:q:Fvh",
 				  long_options, &longindex)) != -1) {
 		switch (opt) {
 		case 'd':
 			if (strlen(optarg) >= IF_NAMESIZE) {
-				fprintf(stderr, "ERR: --dev name too long\n");
-				goto error;
+				fprintf(stderr, "-d/--dev name too long\n");
+				goto end_cpu;
 			}
 			ifname = (char *)&ifname_buf;
-			strncpy(ifname, optarg, IF_NAMESIZE);
+			safe_strncpy(ifname, optarg, sizeof(ifname));
 			ifindex = if_nametoindex(ifname);
-			if (ifindex == 0) {
-				fprintf(stderr,
-					"ERR: --dev name unknown err(%d):%s\n",
+			if (!ifindex)
+				ifindex = strtoul(optarg, NULL, 0);
+			if (!ifindex) {
+				fprintf(stderr, "Bad interface index or name (%d): %s\n",
 					errno, strerror(errno));
-				goto error;
+				usage(argv, long_options, __doc__, mask, true, skel->obj);
+				goto end_cpu;
 			}
 			break;
 		case 's':
-			interval = atoi(optarg);
+			mask |= SAMPLE_REDIRECT_MAP_CNT;
+			break;
+		case 'i':
+			interval = strtoul(optarg, NULL, 0);
 			break;
 		case 'S':
-			xdp_flags |= XDP_FLAGS_SKB_MODE;
+			generic = true;
 			break;
 		case 'x':
 			stress_mode = true;
 			break;
-		case 'z':
-			use_separators = false;
-			break;
 		case 'p':
 			/* Selecting eBPF prog to load */
 			prog_name = optarg;
-			break;
-		case 'n':
-			mprog_disable = true;
+			prog = bpf_object__find_program_by_name(skel->obj,
+								prog_name);
+			if (!prog) {
+				fprintf(stderr,
+					"Failed to find program %s specified by"
+					" option -p/--progname\n",
+					prog_name);
+				print_avail_progs(skel->obj);
+				goto end_cpu;
+			}
 			break;
 		case 'f':
 			mprog_filename = optarg;
@@ -886,6 +439,7 @@ int main(int argc, char **argv)
 			break;
 		case 'r':
 			redir_interface = optarg;
+			mask |= SAMPLE_DEVMAP_XMIT_CNT_MULTI;
 			break;
 		case 'm':
 			redir_map = optarg;
@@ -897,91 +451,112 @@ int main(int argc, char **argv)
 				fprintf(stderr,
 				"--cpu nr too large for cpumap err(%d):%s\n",
 					errno, strerror(errno));
-				goto error;
+				goto end_cpu;
 			}
 			cpu[added_cpus++] = add_cpu;
 			break;
 		case 'q':
-			qsize = atoi(optarg);
+			qsize = strtoul(optarg, NULL, 0);
 			break;
 		case 'F':
-			xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
+			force = true;
+			break;
+		case 'v':
+			sample_switch_mode();
 			break;
 		case 'h':
-		error:
+			error = false;
 		default:
-			free(cpu);
-			usage(argv, obj);
-			return EXIT_FAIL_OPTION;
+			usage(argv, long_options, __doc__, mask, error, skel->obj);
+			goto end_cpu;
 		}
 	}
 
-	if (!(xdp_flags & XDP_FLAGS_SKB_MODE))
-		xdp_flags |= XDP_FLAGS_DRV_MODE;
-
-	/* Required option */
+	ret = EXIT_FAIL_OPTION;
 	if (ifindex == -1) {
-		fprintf(stderr, "ERR: required option --dev missing\n");
-		usage(argv, obj);
-		err = EXIT_FAIL_OPTION;
-		goto out;
+		fprintf(stderr, "Required option --dev missing\n");
+		usage(argv, long_options, __doc__, mask, true, skel->obj);
+		goto end_cpu;
 	}
-	/* Required option */
+
 	if (add_cpu == -1) {
-		fprintf(stderr, "ERR: required option --cpu missing\n");
-		fprintf(stderr, " Specify multiple --cpu option to add more\n");
-		usage(argv, obj);
-		err = EXIT_FAIL_OPTION;
-		goto out;
+		fprintf(stderr, "Required option --cpu missing\n"
+				"Specify multiple --cpu option to add more\n");
+		usage(argv, long_options, __doc__, mask, true, skel->obj);
+		goto end_cpu;
 	}
 
-	value.bpf_prog.fd = 0;
-	if (!mprog_disable)
-		value.bpf_prog.fd = load_cpumap_prog(mprog_filename, mprog_name,
-						     redir_interface, redir_map);
-	if (value.bpf_prog.fd < 0) {
-		err = value.bpf_prog.fd;
-		goto out;
+	skel->rodata->from_match[0] = ifindex;
+	if (redir_interface)
+		skel->rodata->to_match[0] = if_nametoindex(redir_interface);
+
+	ret = xdp_redirect_cpu__load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to xdp_redirect_cpu__load: %s\n",
+			strerror(errno));
+		goto end_cpu;
 	}
-	value.qsize = qsize;
 
-	for (i = 0; i < added_cpus; i++)
-		create_cpu_entry(cpu[i], &value, i, true);
+	ret = bpf_obj_get_info_by_fd(bpf_map__fd(skel->maps.cpu_map), &info, &infosz);
+	if (ret < 0) {
+		fprintf(stderr, "Failed bpf_obj_get_info_by_fd for cpumap: %s\n",
+			strerror(errno));
+		goto end_cpu;
+	}
 
-	/* Remove XDP program when program is interrupted or killed */
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
+	skel->bss->cpumap_map_id = info.id;
 
-	prog = bpf_object__find_program_by_title(obj, prog_name);
-	if (!prog) {
-		fprintf(stderr, "bpf_object__find_program_by_title failed\n");
-		goto out;
+	map_fd = bpf_map__fd(skel->maps.cpu_map);
+	avail_fd = bpf_map__fd(skel->maps.cpus_available);
+	count_fd = bpf_map__fd(skel->maps.cpus_count);
+
+	ret = mark_cpus_unavailable();
+	if (ret < 0) {
+		fprintf(stderr, "Unable to mark CPUs as unavailable\n");
+		goto end_cpu;
 	}
 
-	prog_fd = bpf_program__fd(prog);
-	if (prog_fd < 0) {
-		fprintf(stderr, "bpf_program__fd failed\n");
-		goto out;
+	ret = sample_init(skel, mask);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_cpu;
 	}
 
-	if (bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags) < 0) {
-		fprintf(stderr, "link set xdp fd failed\n");
-		err = EXIT_FAIL_XDP;
-		goto out;
+	value.bpf_prog.fd = set_cpumap_prog(skel, redir_interface, redir_map,
+					    mprog_filename, mprog_name);
+	if (value.bpf_prog.fd < 0) {
+		fprintf(stderr, "Failed to set CPUMAP BPF program: %s\n",
+			strerror(-value.bpf_prog.fd));
+		usage(argv, long_options, __doc__, mask, true, skel->obj);
+		ret = EXIT_FAIL_BPF;
+		goto end_cpu;
 	}
+	value.qsize = qsize;
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
-	if (err) {
-		printf("can't get prog info - %s\n", strerror(errno));
-		goto out;
+	for (i = 0; i < added_cpus; i++) {
+		if (create_cpu_entry(cpu[i], &value, i, true) < 0) {
+			fprintf(stderr, "Cannot proceed, exiting\n");
+			usage(argv, long_options, __doc__, mask, true, skel->obj);
+			goto end_cpu;
+		}
 	}
-	prog_id = info.id;
 
-	stats_poll(interval, use_separators, prog_name, mprog_name,
-		   &value, stress_mode);
+	ret = EXIT_FAIL_XDP;
+	if (sample_install_xdp(prog, ifindex, generic, force) < 0)
+		goto end_cpu;
 
-	err = EXIT_OK;
-out:
+	ret = sample_run(interval, stress_mode ? stress_cpumap : NULL, &value);
+	if (ret < 0) {
+		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_cpu;
+	}
+	ret = EXIT_OK;
+end_cpu:
 	free(cpu);
-	return err;
+end_destroy:
+	xdp_redirect_cpu__destroy(skel);
+end:
+	sample_exit(ret);
 }
-- 
2.33.0

