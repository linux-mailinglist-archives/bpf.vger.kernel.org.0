Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244B44702D0
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 15:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhLJObQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 09:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242154AbhLJObP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 09:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639146459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+nZTDEVt9EdEZZqLnhuepsdUznnuNGVa5p+dsD8f98=;
        b=P8htbFgOeFHGC07QYpvxvPlzL7gwvgq9n9X6z7x88Ci6a+jvo0TvnXHNjJPrC1B7x2GzCB
        Uyngt29PaqNyLMVXDkzgkvijrIGNBwU+BKAEO2jgV2ZyziOhj8HqaVchGbJEhnZR/lgOfL
        YE/D1K1l8xylOjKxEi6N4ViD+q1+v2A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-11-G1VFNidqMkCiEJWThoemqw-1; Fri, 10 Dec 2021 09:27:38 -0500
X-MC-Unique: G1VFNidqMkCiEJWThoemqw-1
Received: by mail-ed1-f71.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso8334602edq.19
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 06:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+nZTDEVt9EdEZZqLnhuepsdUznnuNGVa5p+dsD8f98=;
        b=zol7DvFaFwV/PZ6aj7Yq8KNHg4ZKx43DosCAVN6eS0akOCGff/IWiurUj/FlFPUC0u
         7wUhF6Q1GH5j87TKt34STIrEXVx7qMgRjIoEGDhRHCziLY++c56e+5GRQds9R4QpFCnq
         s5qHtgauzzPgxDm31qQCyrVQj6QmApuqcX4AZl3DqiYHKxyeF0kXHNEDQ4z2aSE5OJ+/
         Otu7eB3DI1M79twwrFvXDbx2UVEfcyyv+QqOVMupSmCIjUfhk1USsIxO9nNwQWirrZs7
         rN4J8sP96ZNRxX1UtDHjyi7VTbZPBBiw9QBskZnYkUAv/IpyPdf8+jxhQAVAKYPkfUQr
         pusg==
X-Gm-Message-State: AOAM533peQdU5/ljypAlnXJH6W19rt1CU7BW+QT5+2NHBk5pXGTIv29t
        YruDOpM8DMhXSjLsnr/YFWrSW/wyhIBIENmDxvLG9fK87p97SA7pvmO/coVIcpDQbAI0e8alLEC
        Te+wGaPJtFZ01
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr24402025ejd.462.1639146455457;
        Fri, 10 Dec 2021 06:27:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGGNKPyayAYStPDHY9KhHckWUVAnIH4IzqwhmPxq/0ZD2uj4G7AavCkHd5w89Gy7togr5V7g==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr24401920ejd.462.1639146454384;
        Fri, 10 Dec 2021 06:27:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id hd15sm1650012ejc.69.2021.12.10.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:27:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BE3BF1804B6; Fri, 10 Dec 2021 15:20:49 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 8/8] samples/bpf: Add xdp_trafficgen sample
Date:   Fri, 10 Dec 2021 15:20:08 +0100
Message-Id: <20211210142008.76981-9-toke@redhat.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211210142008.76981-1-toke@redhat.com>
References: <20211210142008.76981-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds an XDP-based traffic generator sample which uses the DO_REDIRECT
flag of bpf_prog_run(). It works by building the initial packet in
userspace and passing it to the kernel where an XDP program redirects the
packet to the target interface. The traffic generator supports two modes of
operation: one that just sends copies of the same packet as fast as it can
without touching the packet data at all, and one that rewrites the
destination port number of each packet, making the generated traffic span a
range of port numbers.

The dynamic mode is included to demonstrate how the bpf_prog_run() facility
enables building a completely programmable packet generator using XDP.
Using the dynamic mode has about a 10% overhead compared to the static
mode, because the latter completely avoids touching the page data.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/.gitignore            |   1 +
 samples/bpf/Makefile              |   4 +
 samples/bpf/xdp_redirect.bpf.c    |  34 +++
 samples/bpf/xdp_trafficgen_user.c | 421 ++++++++++++++++++++++++++++++
 4 files changed, 460 insertions(+)
 create mode 100644 samples/bpf/xdp_trafficgen_user.c

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index 0e7bfdbff80a..935672cbdd80 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -49,6 +49,7 @@ xdp_redirect_map_multi
 xdp_router_ipv4
 xdp_rxq_info
 xdp_sample_pkts
+xdp_trafficgen
 xdp_tx_iptunnel
 xdpsock
 xdpsock_ctrl_proc
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 38638845db9d..d827e0680945 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -58,6 +58,7 @@ tprogs-y += xdp_redirect_cpu
 tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect
+tprogs-y += xdp_trafficgen
 tprogs-y += xdp_monitor
 
 # Libbpf dependencies
@@ -123,6 +124,7 @@ xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o $(XDP_SAMPLE)
 xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o $(XDP_SAMPLE)
 xdp_redirect_map-objs := xdp_redirect_map_user.o $(XDP_SAMPLE)
 xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
+xdp_trafficgen-objs := xdp_trafficgen_user.o $(XDP_SAMPLE)
 xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
 
 # Tell kbuild to always build the programs
@@ -226,6 +228,7 @@ TPROGLDLIBS_map_perf_test	+= -lrt
 TPROGLDLIBS_test_overhead	+= -lrt
 TPROGLDLIBS_xdpsock		+= -pthread -lcap
 TPROGLDLIBS_xsk_fwd		+= -pthread
+TPROGLDLIBS_xdp_trafficgen	+= -pthread
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 # make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
@@ -341,6 +344,7 @@ $(obj)/xdp_redirect_cpu_user.o: $(obj)/xdp_redirect_cpu.skel.h
 $(obj)/xdp_redirect_map_multi_user.o: $(obj)/xdp_redirect_map_multi.skel.h
 $(obj)/xdp_redirect_map_user.o: $(obj)/xdp_redirect_map.skel.h
 $(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
+$(obj)/xdp_trafficgen_user.o: $(obj)/xdp_redirect.skel.h
 $(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
 
 $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
diff --git a/samples/bpf/xdp_redirect.bpf.c b/samples/bpf/xdp_redirect.bpf.c
index 7c02bacfe96b..a09c6f576b79 100644
--- a/samples/bpf/xdp_redirect.bpf.c
+++ b/samples/bpf/xdp_redirect.bpf.c
@@ -39,6 +39,40 @@ int xdp_redirect_prog(struct xdp_md *ctx)
 	return bpf_redirect(ifindex_out, 0);
 }
 
+SEC("xdp")
+int xdp_redirect_notouch(struct xdp_md *ctx)
+{
+	return bpf_redirect(ifindex_out, 0);
+}
+
+const volatile __u16 port_start;
+const volatile __u16 port_range;
+volatile __u16 next_port = 0;
+
+SEC("xdp")
+int xdp_redirect_update_port(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	__u16 cur_port, cksum_diff;
+	struct udphdr *hdr;
+
+	hdr = data + (sizeof(struct ethhdr) + sizeof(struct ipv6hdr));
+	if (hdr + 1 > data_end)
+		return XDP_ABORTED;
+
+	cur_port = bpf_ntohs(hdr->dest);
+	cksum_diff = next_port - cur_port;
+	if (cksum_diff) {
+		hdr->check = bpf_htons(~(~bpf_ntohs(hdr->check) + cksum_diff));
+		hdr->dest = bpf_htons(next_port);
+	}
+	if (next_port++ >= port_start + port_range - 1)
+		next_port = port_start;
+
+	return bpf_redirect(ifindex_out, 0);
+}
+
 /* Redirect require an XDP bpf_prog loaded on the TX device */
 SEC("xdp")
 int xdp_redirect_dummy_prog(struct xdp_md *ctx)
diff --git a/samples/bpf/xdp_trafficgen_user.c b/samples/bpf/xdp_trafficgen_user.c
new file mode 100644
index 000000000000..03f3a7b3260d
--- /dev/null
+++ b/samples/bpf/xdp_trafficgen_user.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021 Toke Høiland-Jørgensen <toke@redhat.com>
+ */
+static const char *__doc__ =
+"XDP trafficgen tool, using bpf_redirect helper\n"
+"Usage: xdp_trafficgen [options] <IFINDEX|IFNAME>_OUT\n";
+
+#define _GNU_SOURCE
+#include <linux/bpf.h>
+#include <linux/if_link.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <linux/ipv6.h>
+#include <linux/in6.h>
+#include <linux/udp.h>
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <net/if.h>
+#include <unistd.h>
+#include <libgen.h>
+#include <limits.h>
+#include <getopt.h>
+#include <pthread.h>
+#include <arpa/inet.h>
+#include <netinet/ether.h>
+#include <sys/resource.h>
+#include <sys/ioctl.h>
+#include <bpf/bpf.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/libbpf.h>
+#include "bpf_util.h"
+#include "xdp_sample_user.h"
+#include "xdp_redirect.skel.h"
+
+static int mask = SAMPLE_REDIRECT_ERR_CNT |
+		  SAMPLE_EXCEPTION_CNT | SAMPLE_DEVMAP_XMIT_CNT_MULTI;
+
+DEFINE_SAMPLE_INIT(xdp_redirect);
+
+static const struct option long_options[] = {
+	{"dst-mac",	required_argument,	NULL, 'm' },
+	{"src-mac",	required_argument,	NULL, 'M' },
+	{"dst-ip",	required_argument,	NULL, 'a' },
+	{"src-ip",	required_argument,	NULL, 'A' },
+	{"dst-port",	required_argument,	NULL, 'p' },
+	{"src-port",	required_argument,	NULL, 'P' },
+	{"dynamic-ports", required_argument,	NULL, 'd' },
+	{"help",	no_argument,		NULL, 'h' },
+	{"stats",	no_argument,		NULL, 's' },
+	{"interval",	required_argument,	NULL, 'i' },
+	{"n-pkts",	required_argument,	NULL, 'n' },
+	{"threads",	required_argument,	NULL, 't' },
+	{"verbose",	no_argument,		NULL, 'v' },
+	{}
+};
+
+static int sample_res;
+static bool sample_exited;
+
+static void *run_samples(void *arg)
+{
+	unsigned long *interval = arg;
+
+	sample_res = sample_run(*interval, NULL, NULL);
+	sample_exited = true;
+	return NULL;
+}
+
+struct ipv6_packet {
+	struct ethhdr eth;
+	struct ipv6hdr iph;
+	struct udphdr udp;
+	__u8 payload[64 - sizeof(struct udphdr)
+		     - sizeof(struct ethhdr) - sizeof(struct ipv6hdr)];
+} __packed;
+static struct ipv6_packet pkt_v6 = {
+	.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+	.iph.version = 6,
+	.iph.nexthdr = IPPROTO_UDP,
+	.iph.payload_len = bpf_htons(sizeof(struct ipv6_packet)
+				     - offsetof(struct ipv6_packet, udp)),
+	.iph.hop_limit = 1,
+	.iph.saddr.s6_addr16 = {bpf_htons(0xfe80), 0, 0, 0, 0, 0, 0, bpf_htons(1)},
+	.iph.daddr.s6_addr16 = {bpf_htons(0xfe80), 0, 0, 0, 0, 0, 0, bpf_htons(2)},
+	.udp.source = bpf_htons(1),
+	.udp.dest = bpf_htons(1),
+	.udp.len = bpf_htons(sizeof(struct ipv6_packet)
+			     - offsetof(struct ipv6_packet, udp)),
+};
+
+struct thread_config {
+	void *pkt;
+	size_t pkt_size;
+	__u32 cpu_core_id;
+	__u32 num_pkts;
+	int prog_fd;
+};
+
+struct config {
+	__be64 src_mac;
+	__be64 dst_mac;
+	struct in6_addr src_ip;
+	struct in6_addr dst_ip;
+	__be16 src_port;
+	__be16 dst_port;
+	int ifindex;
+	char ifname[IFNAMSIZ];
+};
+
+static void *run_traffic(void *arg)
+{
+	const struct thread_config *cfg = arg;
+	struct xdp_md ctx_in = {
+		.data_end = cfg->pkt_size,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = cfg->pkt,
+			    .data_size_in = cfg->pkt_size,
+			    .ctx_in = &ctx_in,
+			    .ctx_size_in = sizeof(ctx_in),
+			    .repeat = cfg->num_pkts ?: 1 << 24,
+			    .flags = BPF_F_TEST_XDP_DO_REDIRECT,
+		);
+	__u64 iterations = 0;
+	cpu_set_t cpu_cores;
+	int err;
+
+	CPU_ZERO(&cpu_cores);
+	CPU_SET(cfg->cpu_core_id, &cpu_cores);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpu_cores);
+	do {
+		err = bpf_prog_test_run_opts(cfg->prog_fd, &opts);
+		if (err) {
+			printf("bpf_prog_test_run ret %d errno %d\n", err, errno);
+			break;
+		}
+		iterations += opts.repeat;
+	} while (!sample_exited && (!cfg->num_pkts || cfg->num_pkts < iterations));
+	return NULL;
+}
+
+static __be16 calc_udp_cksum(const struct ipv6_packet *pkt)
+{
+	__u32 chksum = pkt->iph.nexthdr + bpf_ntohs(pkt->iph.payload_len);
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		chksum += bpf_ntohs(pkt->iph.saddr.s6_addr16[i]);
+		chksum += bpf_ntohs(pkt->iph.daddr.s6_addr16[i]);
+	}
+	chksum += bpf_ntohs(pkt->udp.source);
+	chksum += bpf_ntohs(pkt->udp.dest);
+	chksum += bpf_ntohs(pkt->udp.len);
+
+	while (chksum >> 16)
+		chksum = (chksum & 0xFFFF) + (chksum >> 16);
+	return bpf_htons(~chksum);
+}
+
+static int prepare_pkt(struct config *cfg)
+{
+	__be64 src_mac = cfg->src_mac;
+	struct in6_addr nulladdr = {};
+	int i, err;
+
+	if (!src_mac) {
+		err = get_mac_addr(cfg->ifindex, &src_mac);
+		if (err)
+			return err;
+	}
+	for (i = 0; i < 6 ; i++) {
+		pkt_v6.eth.h_source[i] = *((__u8 *)&src_mac + i);
+		if (cfg->dst_mac)
+			pkt_v6.eth.h_dest[i] = *((__u8 *)&cfg->dst_mac + i);
+	}
+	if (memcmp(&cfg->src_ip, &nulladdr, sizeof(nulladdr)))
+		pkt_v6.iph.saddr = cfg->src_ip;
+	if (memcmp(&cfg->dst_ip, &nulladdr, sizeof(nulladdr)))
+		pkt_v6.iph.daddr = cfg->dst_ip;
+	if (cfg->src_port)
+		pkt_v6.udp.source = cfg->src_port;
+	if (cfg->dst_port)
+		pkt_v6.udp.dest = cfg->dst_port;
+	pkt_v6.udp.check = calc_udp_cksum(&pkt_v6);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long interval = 2, threads = 1, dynports = 0;
+	__u64 num_pkts = 0;
+	pthread_t sample_thread, *runner_threads = NULL;
+	struct thread_config *t = NULL, tcfg = {
+		.pkt = &pkt_v6,
+		.pkt_size = sizeof(pkt_v6),
+	};
+	int ret = EXIT_FAIL_OPTION;
+	struct xdp_redirect *skel;
+	struct config cfg = {};
+	bool error = true;
+	int opt, i, err;
+
+	while ((opt = getopt_long(argc, argv, "a:A:d:hi:m:M:n:p:P:t:vs",
+				  long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'a':
+			if (!inet_pton(AF_INET6, optarg, &cfg.dst_ip)) {
+				fprintf(stderr, "Invalid IPv6 address: %s\n", optarg);
+				return -1;
+			}
+			break;
+		case 'A':
+			if (!inet_pton(AF_INET6, optarg, &cfg.src_ip)) {
+				fprintf(stderr, "Invalid IPv6 address: %s\n", optarg);
+				return -1;
+			}
+			break;
+		case 'd':
+			dynports = strtoul(optarg, NULL, 0);
+			if (dynports < 2 || dynports >= 65535) {
+				fprintf(stderr, "Dynamic port range must be >1 and < 65535\n");
+				return -1;
+			}
+			break;
+		case 'i':
+			interval = strtoul(optarg, NULL, 0);
+			if (interval < 1 || interval == ULONG_MAX) {
+				fprintf(stderr, "Need non-zero interval\n");
+				return -1;
+			}
+			break;
+		case 't':
+			threads = strtoul(optarg, NULL, 0);
+			if (threads < 1 || threads == ULONG_MAX) {
+				fprintf(stderr, "Need at least 1 thread\n");
+				return -1;
+			}
+			break;
+		case 'm':
+		case 'M':
+			struct ether_addr *a;
+
+			a = ether_aton(optarg);
+			if (!a) {
+				fprintf(stderr, "Invalid MAC: %s\n", optarg);
+				return -1;
+			}
+			if (opt == 'm')
+				memcpy(&cfg.dst_mac, a, sizeof(*a));
+			else
+				memcpy(&cfg.src_mac, a, sizeof(*a));
+			break;
+		case 'n':
+			num_pkts = strtoull(optarg, NULL, 0);
+			if (num_pkts >= 1ULL << 32) {
+				fprintf(stderr, "Can send up to 2^32-1 pkts or infinite (0)\n");
+				return -1;
+			}
+			tcfg.num_pkts = num_pkts;
+			break;
+		case 'p':
+		case 'P':
+			unsigned long p;
+
+			p = strtoul(optarg, NULL, 0);
+			if (!p || p > 0xFFFF) {
+				fprintf(stderr, "Invalid port: %s\n", optarg);
+				return -1;
+			}
+			if (opt == 'p')
+				cfg.dst_port = bpf_htons(p);
+			else
+				cfg.src_port = bpf_htons(p);
+			break;
+		case 'v':
+			sample_switch_mode();
+			break;
+		case 's':
+			mask |= SAMPLE_REDIRECT_CNT;
+			break;
+		case 'h':
+			error = false;
+		default:
+			sample_usage(argv, long_options, __doc__, mask, error);
+			return ret;
+		}
+	}
+
+	if (argc <= optind) {
+		sample_usage(argv, long_options, __doc__, mask, true);
+		return ret;
+	}
+
+	cfg.ifindex = if_nametoindex(argv[optind]);
+	if (!cfg.ifindex)
+		cfg.ifindex = strtoul(argv[optind], NULL, 0);
+
+	if (!cfg.ifindex) {
+		fprintf(stderr, "Bad interface index or name\n");
+		sample_usage(argv, long_options, __doc__, mask, true);
+		goto end;
+	}
+
+	if (!if_indextoname(cfg.ifindex, cfg.ifname)) {
+		fprintf(stderr, "Failed to if_indextoname for %d: %s\n", cfg.ifindex,
+			strerror(errno));
+		goto end;
+	}
+
+	err = prepare_pkt(&cfg);
+	if (err)
+		goto end;
+
+	if (dynports) {
+		if (!cfg.dst_port) {
+			fprintf(stderr, "Must specify dst port when using dynamic port range\n");
+			goto end;
+		}
+
+		if (dynports + bpf_ntohs(cfg.dst_port) - 1 > 65535) {
+			fprintf(stderr, "Dynamic port range must end <= 65535\n");
+			goto end;
+		}
+	}
+
+	skel = xdp_redirect__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to xdp_redirect__open: %s\n", strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end;
+	}
+
+	ret = sample_init_pre_load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
+	}
+
+	skel->rodata->to_match[0] = cfg.ifindex;
+	skel->rodata->ifindex_out = cfg.ifindex;
+	skel->rodata->port_start = bpf_ntohs(cfg.dst_port);
+	skel->rodata->port_range = dynports;
+	skel->bss->next_port = bpf_ntohs(cfg.dst_port);
+
+	ret = xdp_redirect__load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to xdp_redirect__load: %s\n", strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
+	}
+
+	if (dynports)
+		tcfg.prog_fd = bpf_program__fd(skel->progs.xdp_redirect_update_port);
+	else
+		tcfg.prog_fd = bpf_program__fd(skel->progs.xdp_redirect_notouch);
+
+	ret = sample_init(skel, mask);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
+	}
+
+	ret = EXIT_FAIL;
+
+	runner_threads = calloc(sizeof(pthread_t), threads);
+	if (!runner_threads) {
+		fprintf(stderr, "Couldn't allocate memory\n");
+		goto end_destroy;
+	}
+	t = calloc(sizeof(struct thread_config), threads);
+	if (!t) {
+		fprintf(stderr, "Couldn't allocate memory\n");
+		goto end_destroy;
+	}
+
+	printf("Transmitting on %s (ifindex %d; driver %s)\n",
+	       cfg.ifname, cfg.ifindex, get_driver_name(cfg.ifindex));
+
+	sample_exited = false;
+	ret = pthread_create(&sample_thread, NULL, run_samples, &interval);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to create sample thread: %s\n", strerror(-ret));
+		goto end_destroy;
+	}
+	sleep(1);
+	for (i = 0; i < threads; i++) {
+		memcpy(&t[i], &tcfg, sizeof(tcfg));
+		tcfg.cpu_core_id++;
+
+		ret = pthread_create(&runner_threads[i], NULL, run_traffic, &t[i]);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to create traffic thread: %s\n", strerror(-ret));
+			ret = EXIT_FAIL;
+			goto end_cancel;
+		}
+	}
+	pthread_join(sample_thread, NULL);
+	for (i = 0; i < 0; i++)
+		pthread_join(runner_threads[i], NULL);
+	ret = sample_res;
+	goto end_destroy;
+
+end_cancel:
+	pthread_cancel(sample_thread);
+	for (i = 0; i < 0; i++)
+		pthread_cancel(runner_threads[i]);
+end_destroy:
+	xdp_redirect__destroy(skel);
+	free(runner_threads);
+	free(t);
+end:
+	sample_exit(ret);
+}
-- 
2.34.0

