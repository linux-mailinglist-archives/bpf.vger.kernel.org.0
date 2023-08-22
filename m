Return-Path: <bpf+bounces-8259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60287784409
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EFD1C20B11
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DB1DA48;
	Tue, 22 Aug 2023 14:23:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6541DA3F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:23:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A43CDA
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692714187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCOJDW92vuajdIN4zu2fmSPl4KqONb0msFkW5zlXY8c=;
	b=ICNMUKF6qhLqMRa27e43gbDwzy08o58Gb1oAX1rd8ZhSyqWd7RTa7QvaIDQB9TS9ZnWjEG
	dWgjGkgKezIn0amfqU/OEyCTD33q2dytGw82QzT8ADZHUtCCQGB0DY1eITA73u+Yla1Ffy
	GQznjX+W5y3M3AxV9QlG1u8rOAP7pSk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-e8kAPjSYPY6FIP6A8teCDQ-1; Tue, 22 Aug 2023 10:23:05 -0400
X-MC-Unique: e8kAPjSYPY6FIP6A8teCDQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bba5d0c68bso45846441fa.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 07:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714184; x=1693318984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCOJDW92vuajdIN4zu2fmSPl4KqONb0msFkW5zlXY8c=;
        b=CFK2BgQnJitpcYY+/xbUuSDIunCaYdX60qXXrx4UD6Nwy56EtBtdygfVFyHwjaleqx
         qHKrR3jrfUVk4JDBhIzwkALJRv4BwzLefpc7MB7YBjwpxfFIp86anH7Q+Xa3YR33Hkmo
         NFUxCJsMGw568348CbfqgOh/XBeWKRPAlFubw9JvSlO5WGJhp8o0lN4pf1iCeSw0KQ5J
         r3NsdwR/gLB26yvesZE1/yMHL0bS3lGIX14G4BViYjsSICVsC0Es2gpCUYTYSzQa/C/d
         E1kaRLuuhX9SzYN3LgCx2PozYEpW3HB/cidXquR/sb5FTeMyQ0Cwm5DB8vtO6dyhBasv
         gmLQ==
X-Gm-Message-State: AOJu0YxWQ8wAw+OC/YEjdDYTnEU7Yl5wYv09H/eA6iOEQuyzfZLtZLEy
	PdFH5d+xepAbfHWalCAcaJGOM7oJHeA8F2SwXGpyyq17op4qnUe0213PyTx18qpYjJtZ2a+Dgod
	93+uDxHyzRRj6
X-Received: by 2002:a2e:888f:0:b0:2b9:cd79:8f94 with SMTP id k15-20020a2e888f000000b002b9cd798f94mr7483484lji.39.1692714183610;
        Tue, 22 Aug 2023 07:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkD62H0lgEtdyVfT12rugQo2YjR7svjoPwX4KGa0N2SIhT5EfuAMFiAObtbKyrrnN2xxpydg==
X-Received: by 2002:a2e:888f:0:b0:2b9:cd79:8f94 with SMTP id k15-20020a2e888f000000b002b9cd798f94mr7483410lji.39.1692714182139;
        Tue, 22 Aug 2023 07:23:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o15-20020a1709061b0f00b00985ed2f1584sm8287724ejg.187.2023.08.22.07.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:23:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 63B3BD3CCA5; Tue, 22 Aug 2023 16:23:01 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 3/6] samples/bpf: Remove the xdp_rxq_info utility
Date: Tue, 22 Aug 2023 16:22:41 +0200
Message-ID: <20230822142255.1340991-4-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822142255.1340991-1-toke@redhat.com>
References: <20230822142255.1340991-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The functionality of this utility has been incorporated into the xdp-bench
utility in xdp-tools. Remove the unmaintained version in samples.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile            |   3 -
 samples/bpf/xdp_rxq_info_kern.c | 140 --------
 samples/bpf/xdp_rxq_info_user.c | 614 --------------------------------
 3 files changed, 757 deletions(-)
 delete mode 100644 samples/bpf/xdp_rxq_info_kern.c
 delete mode 100644 samples/bpf/xdp_rxq_info_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index d2f5c043e4f3..fb1dc9d96b2a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -41,7 +41,6 @@ tprogs-y += lwt_len_hist
 tprogs-y += xdp_tx_iptunnel
 tprogs-y += test_map_in_map
 tprogs-y += per_socket_stats_example
-tprogs-y += xdp_rxq_info
 tprogs-y += syscall_tp
 tprogs-y += cpustat
 tprogs-y += xdp_adjust_tail
@@ -96,7 +95,6 @@ lwt_len_hist-objs := lwt_len_hist_user.o
 xdp_tx_iptunnel-objs := xdp_tx_iptunnel_user.o
 test_map_in_map-objs := test_map_in_map_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
-xdp_rxq_info-objs := xdp_rxq_info_user.o
 syscall_tp-objs := syscall_tp_user.o
 cpustat-objs := cpustat_user.o
 xdp_adjust_tail-objs := xdp_adjust_tail_user.o
@@ -151,7 +149,6 @@ always-y += tcp_clamp_kern.o
 always-y += tcp_basertt_kern.o
 always-y += tcp_tos_reflect_kern.o
 always-y += tcp_dumpstats_kern.o
-always-y += xdp_rxq_info_kern.o
 always-y += xdp2skb_meta_kern.o
 always-y += syscall_tp_kern.o
 always-y += cpustat_kern.o
diff --git a/samples/bpf/xdp_rxq_info_kern.c b/samples/bpf/xdp_rxq_info_kern.c
deleted file mode 100644
index 5e7459f9bf3e..000000000000
--- a/samples/bpf/xdp_rxq_info_kern.c
+++ /dev/null
@@ -1,140 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Copyright (c) 2017 Jesper Dangaard Brouer, Red Hat Inc.
- *
- *  Example howto extract XDP RX-queue info
- */
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/if_ether.h>
-#include <uapi/linux/in.h>
-#include <bpf/bpf_helpers.h>
-
-/* Config setup from with userspace
- *
- * User-side setup ifindex in config_map, to verify that
- * ctx->ingress_ifindex is correct (against configured ifindex)
- */
-struct config {
-	__u32 action;
-	int ifindex;
-	__u32 options;
-};
-enum cfg_options_flags {
-	NO_TOUCH = 0x0U,
-	READ_MEM = 0x1U,
-	SWAP_MAC = 0x2U,
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, int);
-	__type(value, struct config);
-	__uint(max_entries, 1);
-} config_map SEC(".maps");
-
-/* Common stats data record (shared with userspace) */
-struct datarec {
-	__u64 processed;
-	__u64 issue;
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__type(key, u32);
-	__type(value, struct datarec);
-	__uint(max_entries, 1);
-} stats_global_map SEC(".maps");
-
-#define MAX_RXQs 64
-
-/* Stats per rx_queue_index (per CPU) */
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__type(key, u32);
-	__type(value, struct datarec);
-	__uint(max_entries, MAX_RXQs + 1);
-} rx_queue_index_map SEC(".maps");
-
-static __always_inline
-void swap_src_dst_mac(void *data)
-{
-	unsigned short *p = data;
-	unsigned short dst[3];
-
-	dst[0] = p[0];
-	dst[1] = p[1];
-	dst[2] = p[2];
-	p[0] = p[3];
-	p[1] = p[4];
-	p[2] = p[5];
-	p[3] = dst[0];
-	p[4] = dst[1];
-	p[5] = dst[2];
-}
-
-SEC("xdp_prog0")
-int  xdp_prognum0(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	struct datarec *rec, *rxq_rec;
-	int ingress_ifindex;
-	struct config *config;
-	u32 key = 0;
-
-	/* Global stats record */
-	rec = bpf_map_lookup_elem(&stats_global_map, &key);
-	if (!rec)
-		return XDP_ABORTED;
-	rec->processed++;
-
-	/* Accessing ctx->ingress_ifindex, cause BPF to rewrite BPF
-	 * instructions inside kernel to access xdp_rxq->dev->ifindex
-	 */
-	ingress_ifindex = ctx->ingress_ifindex;
-
-	config = bpf_map_lookup_elem(&config_map, &key);
-	if (!config)
-		return XDP_ABORTED;
-
-	/* Simple test: check ctx provided ifindex is as expected */
-	if (ingress_ifindex != config->ifindex) {
-		/* count this error case */
-		rec->issue++;
-		return XDP_ABORTED;
-	}
-
-	/* Update stats per rx_queue_index. Handle if rx_queue_index
-	 * is larger than stats map can contain info for.
-	 */
-	key = ctx->rx_queue_index;
-	if (key >= MAX_RXQs)
-		key = MAX_RXQs;
-	rxq_rec = bpf_map_lookup_elem(&rx_queue_index_map, &key);
-	if (!rxq_rec)
-		return XDP_ABORTED;
-	rxq_rec->processed++;
-	if (key == MAX_RXQs)
-		rxq_rec->issue++;
-
-	/* Default: Don't touch packet data, only count packets */
-	if (unlikely(config->options & (READ_MEM|SWAP_MAC))) {
-		struct ethhdr *eth = data;
-
-		if (eth + 1 > data_end)
-			return XDP_ABORTED;
-
-		/* Avoid compiler removing this: Drop non 802.3 Ethertypes */
-		if (ntohs(eth->h_proto) < ETH_P_802_3_MIN)
-			return XDP_ABORTED;
-
-		/* XDP_TX requires changing MAC-addrs, else HW may drop.
-		 * Can also be enabled with --swapmac (for test purposes)
-		 */
-		if (unlikely(config->options & SWAP_MAC))
-			swap_src_dst_mac(data);
-	}
-
-	return config->action;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
deleted file mode 100644
index b95e0ef61f06..000000000000
--- a/samples/bpf/xdp_rxq_info_user.c
+++ /dev/null
@@ -1,614 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Copyright (c) 2017 Jesper Dangaard Brouer, Red Hat Inc.
- */
-static const char *__doc__ = " XDP RX-queue info extract example\n\n"
-	"Monitor how many packets per sec (pps) are received\n"
-	"per NIC RX queue index and which CPU processed the packet\n"
-	;
-
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <string.h>
-#include <unistd.h>
-#include <locale.h>
-#include <getopt.h>
-#include <net/if.h>
-#include <time.h>
-#include <limits.h>
-#include <arpa/inet.h>
-#include <linux/if_link.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include "bpf_util.h"
-
-static int ifindex = -1;
-static char ifname_buf[IF_NAMESIZE];
-static char *ifname;
-static __u32 prog_id;
-
-static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-
-static struct bpf_map *stats_global_map;
-static struct bpf_map *rx_queue_index_map;
-
-/* Exit return codes */
-#define EXIT_OK		0
-#define EXIT_FAIL		1
-#define EXIT_FAIL_OPTION	2
-#define EXIT_FAIL_XDP		3
-#define EXIT_FAIL_BPF		4
-#define EXIT_FAIL_MEM		5
-
-#define FAIL_MEM_SIG		INT_MAX
-#define FAIL_STAT_SIG		(INT_MAX - 1)
-
-static const struct option long_options[] = {
-	{"help",	no_argument,		NULL, 'h' },
-	{"dev",		required_argument,	NULL, 'd' },
-	{"skb-mode",	no_argument,		NULL, 'S' },
-	{"sec",		required_argument,	NULL, 's' },
-	{"no-separators", no_argument,		NULL, 'z' },
-	{"action",	required_argument,	NULL, 'a' },
-	{"readmem",	no_argument,		NULL, 'r' },
-	{"swapmac",	no_argument,		NULL, 'm' },
-	{"force",	no_argument,		NULL, 'F' },
-	{0, 0, NULL,  0 }
-};
-
-static void int_exit(int sig)
-{
-	__u32 curr_prog_id = 0;
-
-	if (ifindex > -1) {
-		if (bpf_xdp_query_id(ifindex, xdp_flags, &curr_prog_id)) {
-			printf("bpf_xdp_query_id failed\n");
-			exit(EXIT_FAIL);
-		}
-		if (prog_id == curr_prog_id) {
-			fprintf(stderr,
-				"Interrupted: Removing XDP program on ifindex:%d device:%s\n",
-				ifindex, ifname);
-			bpf_xdp_detach(ifindex, xdp_flags, NULL);
-		} else if (!curr_prog_id) {
-			printf("couldn't find a prog id on a given iface\n");
-		} else {
-			printf("program on interface changed, not removing\n");
-		}
-	}
-
-	if (sig == FAIL_MEM_SIG)
-		exit(EXIT_FAIL_MEM);
-	else if (sig == FAIL_STAT_SIG)
-		exit(EXIT_FAIL);
-
-	exit(EXIT_OK);
-}
-
-struct config {
-	__u32 action;
-	int ifindex;
-	__u32 options;
-};
-enum cfg_options_flags {
-	NO_TOUCH = 0x0U,
-	READ_MEM = 0x1U,
-	SWAP_MAC = 0x2U,
-};
-#define XDP_ACTION_MAX (XDP_TX + 1)
-#define XDP_ACTION_MAX_STRLEN 11
-static const char *xdp_action_names[XDP_ACTION_MAX] = {
-	[XDP_ABORTED]	= "XDP_ABORTED",
-	[XDP_DROP]	= "XDP_DROP",
-	[XDP_PASS]	= "XDP_PASS",
-	[XDP_TX]	= "XDP_TX",
-};
-
-static const char *action2str(int action)
-{
-	if (action < XDP_ACTION_MAX)
-		return xdp_action_names[action];
-	return NULL;
-}
-
-static int parse_xdp_action(char *action_str)
-{
-	size_t maxlen;
-	__u64 action = -1;
-	int i;
-
-	for (i = 0; i < XDP_ACTION_MAX; i++) {
-		maxlen = XDP_ACTION_MAX_STRLEN;
-		if (strncmp(xdp_action_names[i], action_str, maxlen) == 0) {
-			action = i;
-			break;
-		}
-	}
-	return action;
-}
-
-static void list_xdp_actions(void)
-{
-	int i;
-
-	printf("Available XDP --action <options>\n");
-	for (i = 0; i < XDP_ACTION_MAX; i++)
-		printf("\t%s\n", xdp_action_names[i]);
-	printf("\n");
-}
-
-static char* options2str(enum cfg_options_flags flag)
-{
-	if (flag == NO_TOUCH)
-		return "no_touch";
-	if (flag & SWAP_MAC)
-		return "swapmac";
-	if (flag & READ_MEM)
-		return "read";
-	fprintf(stderr, "ERR: Unknown config option flags");
-	int_exit(FAIL_STAT_SIG);
-	return "unknown";
-}
-
-static void usage(char *argv[])
-{
-	int i;
-
-	printf("\nDOCUMENTATION:\n%s\n", __doc__);
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
-	printf("\n");
-	list_xdp_actions();
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
-		int_exit(FAIL_STAT_SIG);
-	}
-	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
-}
-
-/* Common stats data record shared with _kern.c */
-struct datarec {
-	__u64 processed;
-	__u64 issue;
-};
-struct record {
-	__u64 timestamp;
-	struct datarec total;
-	struct datarec *cpu;
-};
-struct stats_record {
-	struct record stats;
-	struct record *rxq;
-};
-
-static struct datarec *alloc_record_per_cpu(void)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct datarec *array;
-
-	array = calloc(nr_cpus, sizeof(struct datarec));
-	if (!array) {
-		fprintf(stderr, "Mem alloc error (nr_cpus:%u)\n", nr_cpus);
-		int_exit(FAIL_MEM_SIG);
-	}
-	return array;
-}
-
-static struct record *alloc_record_per_rxq(void)
-{
-	unsigned int nr_rxqs = bpf_map__max_entries(rx_queue_index_map);
-	struct record *array;
-
-	array = calloc(nr_rxqs, sizeof(struct record));
-	if (!array) {
-		fprintf(stderr, "Mem alloc error (nr_rxqs:%u)\n", nr_rxqs);
-		int_exit(FAIL_MEM_SIG);
-	}
-	return array;
-}
-
-static struct stats_record *alloc_stats_record(void)
-{
-	unsigned int nr_rxqs = bpf_map__max_entries(rx_queue_index_map);
-	struct stats_record *rec;
-	int i;
-
-	rec = calloc(1, sizeof(struct stats_record));
-	if (!rec) {
-		fprintf(stderr, "Mem alloc error\n");
-		int_exit(FAIL_MEM_SIG);
-	}
-	rec->rxq = alloc_record_per_rxq();
-	for (i = 0; i < nr_rxqs; i++)
-		rec->rxq[i].cpu = alloc_record_per_cpu();
-
-	rec->stats.cpu = alloc_record_per_cpu();
-	return rec;
-}
-
-static void free_stats_record(struct stats_record *r)
-{
-	unsigned int nr_rxqs = bpf_map__max_entries(rx_queue_index_map);
-	int i;
-
-	for (i = 0; i < nr_rxqs; i++)
-		free(r->rxq[i].cpu);
-
-	free(r->rxq);
-	free(r->stats.cpu);
-	free(r);
-}
-
-static bool map_collect_percpu(int fd, __u32 key, struct record *rec)
-{
-	/* For percpu maps, userspace gets a value per possible CPU */
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct datarec values[nr_cpus];
-	__u64 sum_processed = 0;
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
-		rec->cpu[i].issue = values[i].issue;
-		sum_issue        += values[i].issue;
-	}
-	rec->total.processed = sum_processed;
-	rec->total.issue     = sum_issue;
-	return true;
-}
-
-static void stats_collect(struct stats_record *rec)
-{
-	int fd, i, max_rxqs;
-
-	fd = bpf_map__fd(stats_global_map);
-	map_collect_percpu(fd, 0, &rec->stats);
-
-	fd = bpf_map__fd(rx_queue_index_map);
-	max_rxqs = bpf_map__max_entries(rx_queue_index_map);
-	for (i = 0; i < max_rxqs; i++)
-		map_collect_percpu(fd, i, &rec->rxq[i]);
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
-static void stats_print(struct stats_record *stats_rec,
-			struct stats_record *stats_prev,
-			int action, __u32 cfg_opt)
-{
-	unsigned int nr_rxqs = bpf_map__max_entries(rx_queue_index_map);
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	double pps = 0, err = 0;
-	struct record *rec, *prev;
-	double t;
-	int rxq;
-	int i;
-
-	/* Header */
-	printf("\nRunning XDP on dev:%s (ifindex:%d) action:%s options:%s\n",
-	       ifname, ifindex, action2str(action), options2str(cfg_opt));
-
-	/* stats_global_map */
-	{
-		char *fmt_rx = "%-15s %-7d %'-11.0f %'-10.0f %s\n";
-		char *fm2_rx = "%-15s %-7s %'-11.0f\n";
-		char *errstr = "";
-
-		printf("%-15s %-7s %-11s %-11s\n",
-		       "XDP stats", "CPU", "pps", "issue-pps");
-
-		rec  =  &stats_rec->stats;
-		prev = &stats_prev->stats;
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps = calc_pps     (r, p, t);
-			err = calc_errs_pps(r, p, t);
-			if (err > 0)
-				errstr = "invalid-ifindex";
-			if (pps > 0)
-				printf(fmt_rx, "XDP-RX CPU",
-					i, pps, err, errstr);
-		}
-		pps  = calc_pps     (&rec->total, &prev->total, t);
-		err  = calc_errs_pps(&rec->total, &prev->total, t);
-		printf(fm2_rx, "XDP-RX CPU", "total", pps, err);
-	}
-
-	/* rx_queue_index_map */
-	printf("\n%-15s %-7s %-11s %-11s\n",
-	       "RXQ stats", "RXQ:CPU", "pps", "issue-pps");
-
-	for (rxq = 0; rxq < nr_rxqs; rxq++) {
-		char *fmt_rx = "%-15s %3d:%-3d %'-11.0f %'-10.0f %s\n";
-		char *fm2_rx = "%-15s %3d:%-3s %'-11.0f\n";
-		char *errstr = "";
-		int rxq_ = rxq;
-
-		/* Last RXQ in map catch overflows */
-		if (rxq_ == nr_rxqs - 1)
-			rxq_ = -1;
-
-		rec  =  &stats_rec->rxq[rxq];
-		prev = &stats_prev->rxq[rxq];
-		t = calc_period(rec, prev);
-		for (i = 0; i < nr_cpus; i++) {
-			struct datarec *r = &rec->cpu[i];
-			struct datarec *p = &prev->cpu[i];
-
-			pps = calc_pps     (r, p, t);
-			err = calc_errs_pps(r, p, t);
-			if (err > 0) {
-				if (rxq_ == -1)
-					errstr = "map-overflow-RXQ";
-				else
-					errstr = "err";
-			}
-			if (pps > 0)
-				printf(fmt_rx, "rx_queue_index",
-				       rxq_, i, pps, err, errstr);
-		}
-		pps  = calc_pps     (&rec->total, &prev->total, t);
-		err  = calc_errs_pps(&rec->total, &prev->total, t);
-		if (pps || err)
-			printf(fm2_rx, "rx_queue_index", rxq_, "sum", pps, err);
-	}
-}
-
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
-static void stats_poll(int interval, int action, __u32 cfg_opt)
-{
-	struct stats_record *record, *prev;
-
-	record = alloc_stats_record();
-	prev   = alloc_stats_record();
-	stats_collect(record);
-
-	while (1) {
-		swap(&prev, &record);
-		stats_collect(record);
-		stats_print(record, prev, action, cfg_opt);
-		sleep(interval);
-	}
-
-	free_stats_record(record);
-	free_stats_record(prev);
-}
-
-
-int main(int argc, char **argv)
-{
-	__u32 cfg_options= NO_TOUCH ; /* Default: Don't touch packet memory */
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	int prog_fd, map_fd, opt, err;
-	bool use_separators = true;
-	struct config cfg = { 0 };
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	struct bpf_map *map;
-	char filename[256];
-	int longindex = 0;
-	int interval = 2;
-	__u32 key = 0;
-
-
-	char action_str_buf[XDP_ACTION_MAX_STRLEN + 1 /* for \0 */] = { 0 };
-	int action = XDP_PASS; /* Default action */
-	char *action_str = NULL;
-
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj))
-		return EXIT_FAIL;
-
-	prog = bpf_object__next_program(obj, NULL);
-	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
-
-	err = bpf_object__load(obj);
-	if (err)
-		return EXIT_FAIL;
-	prog_fd = bpf_program__fd(prog);
-
-	map =  bpf_object__find_map_by_name(obj, "config_map");
-	stats_global_map = bpf_object__find_map_by_name(obj, "stats_global_map");
-	rx_queue_index_map = bpf_object__find_map_by_name(obj, "rx_queue_index_map");
-	if (!map || !stats_global_map || !rx_queue_index_map) {
-		printf("finding a map in obj file failed\n");
-		return EXIT_FAIL;
-	}
-	map_fd = bpf_map__fd(map);
-
-	if (!prog_fd) {
-		fprintf(stderr, "ERR: bpf_prog_load_xattr: %s\n", strerror(errno));
-		return EXIT_FAIL;
-	}
-
-	/* Parse commands line args */
-	while ((opt = getopt_long(argc, argv, "FhSrmzd:s:a:",
-				  long_options, &longindex)) != -1) {
-		switch (opt) {
-		case 'd':
-			if (strlen(optarg) >= IF_NAMESIZE) {
-				fprintf(stderr, "ERR: --dev name too long\n");
-				goto error;
-			}
-			ifname = (char *)&ifname_buf;
-			strncpy(ifname, optarg, IF_NAMESIZE);
-			ifindex = if_nametoindex(ifname);
-			if (ifindex == 0) {
-				fprintf(stderr,
-					"ERR: --dev name unknown err(%d):%s\n",
-					errno, strerror(errno));
-				goto error;
-			}
-			break;
-		case 's':
-			interval = atoi(optarg);
-			break;
-		case 'S':
-			xdp_flags |= XDP_FLAGS_SKB_MODE;
-			break;
-		case 'z':
-			use_separators = false;
-			break;
-		case 'a':
-			action_str = (char *)&action_str_buf;
-			strncpy(action_str, optarg, XDP_ACTION_MAX_STRLEN);
-			break;
-		case 'r':
-			cfg_options |= READ_MEM;
-			break;
-		case 'm':
-			cfg_options |= SWAP_MAC;
-			break;
-		case 'F':
-			xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
-			break;
-		case 'h':
-		error:
-		default:
-			usage(argv);
-			return EXIT_FAIL_OPTION;
-		}
-	}
-
-	if (!(xdp_flags & XDP_FLAGS_SKB_MODE))
-		xdp_flags |= XDP_FLAGS_DRV_MODE;
-
-	/* Required option */
-	if (ifindex == -1) {
-		fprintf(stderr, "ERR: required option --dev missing\n");
-		usage(argv);
-		return EXIT_FAIL_OPTION;
-	}
-	cfg.ifindex = ifindex;
-
-	/* Parse action string */
-	if (action_str) {
-		action = parse_xdp_action(action_str);
-		if (action < 0) {
-			fprintf(stderr, "ERR: Invalid XDP --action: %s\n",
-				action_str);
-			list_xdp_actions();
-			return EXIT_FAIL_OPTION;
-		}
-	}
-	cfg.action = action;
-
-	/* XDP_TX requires changing MAC-addrs, else HW may drop */
-	if (action == XDP_TX)
-		cfg_options |= SWAP_MAC;
-	cfg.options = cfg_options;
-
-	/* Trick to pretty printf with thousands separators use %' */
-	if (use_separators)
-		setlocale(LC_NUMERIC, "en_US");
-
-	/* User-side setup ifindex in config_map */
-	err = bpf_map_update_elem(map_fd, &key, &cfg, 0);
-	if (err) {
-		fprintf(stderr, "Store config failed (err:%d)\n", err);
-		exit(EXIT_FAIL_BPF);
-	}
-
-	/* Remove XDP program when program is interrupted or killed */
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
-
-	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
-		fprintf(stderr, "link set xdp fd failed\n");
-		return EXIT_FAIL_XDP;
-	}
-
-	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
-	if (err) {
-		printf("can't get prog info - %s\n", strerror(errno));
-		return err;
-	}
-	prog_id = info.id;
-
-	stats_poll(interval, action, cfg_options);
-	return EXIT_OK;
-}
-- 
2.41.0


