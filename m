Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28CF3622
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 18:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbfKGRrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 12:47:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:33463 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbfKGRry (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 12:47:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 09:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="353858406"
Received: from unknown (HELO VM.jf.intel.com) ([10.78.3.78])
  by orsmga004.jf.intel.com with ESMTP; 07 Nov 2019 09:47:53 -0800
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, u9012063@gmail.com
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/5] samples/bpf: add XDP_SHARED_UMEM support to xdpsock
Date:   Thu,  7 Nov 2019 18:47:37 +0100
Message-Id: <1573148860-30254-3-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573148860-30254-1-git-send-email-magnus.karlsson@intel.com>
References: <1573148860-30254-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for the XDP_SHARED_UMEM mode to the xdpsock sample
application. As libbpf does not have a built in XDP program for this
mode, we use an explicitly loaded XDP program. This also serves as an
example on how to write your own XDP program that can route to an
AF_XDP socket.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 samples/bpf/Makefile       |   1 +
 samples/bpf/xdpsock.h      |  11 ++++
 samples/bpf/xdpsock_kern.c |  24 ++++++++
 samples/bpf/xdpsock_user.c | 141 +++++++++++++++++++++++++++++++--------------
 4 files changed, 135 insertions(+), 42 deletions(-)
 create mode 100644 samples/bpf/xdpsock.h
 create mode 100644 samples/bpf/xdpsock_kern.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4df11dd..8a9af3a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -167,6 +167,7 @@ always += xdp_sample_pkts_kern.o
 always += ibumad_kern.o
 always += hbm_out_kern.o
 always += hbm_edt_kern.o
+always += xdpsock_kern.o
 
 ifeq ($(ARCH), arm)
 # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
diff --git a/samples/bpf/xdpsock.h b/samples/bpf/xdpsock.h
new file mode 100644
index 0000000..b7eca15
--- /dev/null
+++ b/samples/bpf/xdpsock.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright(c) 2019 Intel Corporation.
+ */
+
+#ifndef XDPSOCK_H_
+#define XDPSOCK_H_
+
+#define MAX_SOCKS 4
+
+#endif /* XDPSOCK_H */
diff --git a/samples/bpf/xdpsock_kern.c b/samples/bpf/xdpsock_kern.c
new file mode 100644
index 0000000..a06177c
--- /dev/null
+++ b/samples/bpf/xdpsock_kern.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+#include "xdpsock.h"
+
+/* This XDP program is only needed for the XDP_SHARED_UMEM mode.
+ * If you do not use this mode, libbpf can supply an XDP program for you.
+ */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_XSKMAP);
+	__uint(max_entries, MAX_SOCKS);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} xsks_map SEC(".maps");
+
+static unsigned int rr;
+
+SEC("xdp_sock") int xdp_sock_prog(struct xdp_md *ctx)
+{
+	rr = (rr + 1) & (MAX_SOCKS - 1);
+
+	return bpf_redirect_map(&xsks_map, rr, XDP_DROP);
+}
diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 405c4e0..d3dba93 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -29,6 +29,7 @@
 
 #include "libbpf.h"
 #include "xsk.h"
+#include "xdpsock.h"
 #include <bpf/bpf.h>
 
 #ifndef SOL_XDP
@@ -47,7 +48,6 @@
 #define BATCH_SIZE 64
 
 #define DEBUG_HEXDUMP 0
-#define MAX_SOCKS 8
 
 typedef __u64 u64;
 typedef __u32 u32;
@@ -75,7 +75,8 @@ static u32 opt_xdp_bind_flags;
 static int opt_xsk_frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 static int opt_timeout = 1000;
 static bool opt_need_wakeup = true;
-static __u32 prog_id;
+static u32 opt_num_xsks = 1;
+static u32 prog_id;
 
 struct xsk_umem_info {
 	struct xsk_ring_prod fq;
@@ -179,7 +180,7 @@ static void *poller(void *arg)
 
 static void remove_xdp_program(void)
 {
-	__u32 curr_prog_id = 0;
+	u32 curr_prog_id = 0;
 
 	if (bpf_get_link_xdp_id(opt_ifindex, &curr_prog_id, opt_xdp_flags)) {
 		printf("bpf_get_link_xdp_id failed\n");
@@ -196,11 +197,11 @@ static void remove_xdp_program(void)
 static void int_exit(int sig)
 {
 	struct xsk_umem *umem = xsks[0]->umem->umem;
-
-	(void)sig;
+	int i;
 
 	dump_stats();
-	xsk_socket__delete(xsks[0]->xsk);
+	for (i = 0; i < num_socks; i++)
+		xsk_socket__delete(xsks[i]->xsk);
 	(void)xsk_umem__delete(umem);
 	remove_xdp_program();
 
@@ -290,8 +291,8 @@ static struct xsk_umem_info *xsk_configure_umem(void *buffer, u64 size)
 		.frame_headroom = XSK_UMEM__DEFAULT_FRAME_HEADROOM,
 		.flags = opt_umem_flags
 	};
-
-	int ret;
+	int ret, i;
+	u32 idx;
 
 	umem = calloc(1, sizeof(*umem));
 	if (!umem)
@@ -303,6 +304,15 @@ static struct xsk_umem_info *xsk_configure_umem(void *buffer, u64 size)
 	if (ret)
 		exit_with_error(-ret);
 
+	ret = xsk_ring_prod__reserve(&umem->fq,
+				     XSK_RING_PROD__DEFAULT_NUM_DESCS, &idx);
+	if (ret != XSK_RING_PROD__DEFAULT_NUM_DESCS)
+		exit_with_error(-ret);
+	for (i = 0; i < XSK_RING_PROD__DEFAULT_NUM_DESCS; i++)
+		*xsk_ring_prod__fill_addr(&umem->fq, idx++) =
+			i * opt_xsk_frame_size;
+	xsk_ring_prod__submit(&umem->fq, XSK_RING_PROD__DEFAULT_NUM_DESCS);
+
 	umem->buffer = buffer;
 	return umem;
 }
@@ -312,8 +322,6 @@ static struct xsk_socket_info *xsk_configure_socket(struct xsk_umem_info *umem)
 	struct xsk_socket_config cfg;
 	struct xsk_socket_info *xsk;
 	int ret;
-	u32 idx;
-	int i;
 
 	xsk = calloc(1, sizeof(*xsk));
 	if (!xsk)
@@ -322,11 +330,15 @@ static struct xsk_socket_info *xsk_configure_socket(struct xsk_umem_info *umem)
 	xsk->umem = umem;
 	cfg.rx_size = XSK_RING_CONS__DEFAULT_NUM_DESCS;
 	cfg.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
-	cfg.libbpf_flags = 0;
+	if (opt_num_xsks > 1)
+		cfg.libbpf_flags = XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD;
+	else
+		cfg.libbpf_flags = 0;
 	cfg.xdp_flags = opt_xdp_flags;
 	cfg.bind_flags = opt_xdp_bind_flags;
-	ret = xsk_socket__create(&xsk->xsk, opt_if, opt_queue, umem->umem,
-				 &xsk->rx, &xsk->tx, &cfg);
+
+	ret = xsk_socket__create(&xsk->xsk, opt_if, opt_queue,
+				 umem->umem, &xsk->rx, &xsk->tx, &cfg);
 	if (ret)
 		exit_with_error(-ret);
 
@@ -334,17 +346,6 @@ static struct xsk_socket_info *xsk_configure_socket(struct xsk_umem_info *umem)
 	if (ret)
 		exit_with_error(-ret);
 
-	ret = xsk_ring_prod__reserve(&xsk->umem->fq,
-				     XSK_RING_PROD__DEFAULT_NUM_DESCS,
-				     &idx);
-	if (ret != XSK_RING_PROD__DEFAULT_NUM_DESCS)
-		exit_with_error(-ret);
-	for (i = 0; i < XSK_RING_PROD__DEFAULT_NUM_DESCS; i++)
-		*xsk_ring_prod__fill_addr(&xsk->umem->fq, idx++) =
-			i * opt_xsk_frame_size;
-	xsk_ring_prod__submit(&xsk->umem->fq,
-			      XSK_RING_PROD__DEFAULT_NUM_DESCS);
-
 	return xsk;
 }
 
@@ -363,6 +364,7 @@ static struct option long_options[] = {
 	{"frame-size", required_argument, 0, 'f'},
 	{"no-need-wakeup", no_argument, 0, 'm'},
 	{"unaligned", no_argument, 0, 'u'},
+	{"shared-umem", no_argument, 0, 'M'},
 	{0, 0, 0, 0}
 };
 
@@ -386,6 +388,7 @@ static void usage(const char *prog)
 		"  -m, --no-need-wakeup Turn off use of driver need wakeup flag.\n"
 		"  -f, --frame-size=n   Set the frame size (must be a power of two in aligned mode, default is %d).\n"
 		"  -u, --unaligned	Enable unaligned chunk placement\n"
+		"  -M, --shared-umem	Enable XDP_SHARED_UMEM\n"
 		"\n";
 	fprintf(stderr, str, prog, XSK_UMEM__DEFAULT_FRAME_SIZE);
 	exit(EXIT_FAILURE);
@@ -398,7 +401,7 @@ static void parse_command_line(int argc, char **argv)
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "Frtli:q:psSNn:czf:mu",
+		c = getopt_long(argc, argv, "Frtli:q:psSNn:czf:muM",
 				long_options, &option_index);
 		if (c == -1)
 			break;
@@ -448,11 +451,14 @@ static void parse_command_line(int argc, char **argv)
 			break;
 		case 'f':
 			opt_xsk_frame_size = atoi(optarg);
+			break;
 		case 'm':
 			opt_need_wakeup = false;
 			opt_xdp_bind_flags &= ~XDP_USE_NEED_WAKEUP;
 			break;
-
+		case 'M':
+			opt_num_xsks = MAX_SOCKS;
+			break;
 		default:
 			usage(basename(argv[0]));
 		}
@@ -586,11 +592,9 @@ static void rx_drop(struct xsk_socket_info *xsk, struct pollfd *fds)
 
 static void rx_drop_all(void)
 {
-	struct pollfd fds[MAX_SOCKS + 1];
+	struct pollfd fds[MAX_SOCKS] = {};
 	int i, ret;
 
-	memset(fds, 0, sizeof(fds));
-
 	for (i = 0; i < num_socks; i++) {
 		fds[i].fd = xsk_socket__fd(xsks[i]->xsk);
 		fds[i].events = POLLIN;
@@ -633,11 +637,10 @@ static void tx_only(struct xsk_socket_info *xsk, u32 frame_nb)
 
 static void tx_only_all(void)
 {
-	struct pollfd fds[MAX_SOCKS];
+	struct pollfd fds[MAX_SOCKS] = {};
 	u32 frame_nb[MAX_SOCKS] = {};
 	int i, ret;
 
-	memset(fds, 0, sizeof(fds));
 	for (i = 0; i < num_socks; i++) {
 		fds[0].fd = xsk_socket__fd(xsks[i]->xsk);
 		fds[0].events = POLLOUT;
@@ -706,11 +709,9 @@ static void l2fwd(struct xsk_socket_info *xsk, struct pollfd *fds)
 
 static void l2fwd_all(void)
 {
-	struct pollfd fds[MAX_SOCKS];
+	struct pollfd fds[MAX_SOCKS] = {};
 	int i, ret;
 
-	memset(fds, 0, sizeof(fds));
-
 	for (i = 0; i < num_socks; i++) {
 		fds[i].fd = xsk_socket__fd(xsks[i]->xsk);
 		fds[i].events = POLLOUT | POLLIN;
@@ -728,13 +729,65 @@ static void l2fwd_all(void)
 	}
 }
 
+static void load_xdp_program(char **argv, struct bpf_object **obj)
+{
+	struct bpf_prog_load_attr prog_load_attr = {
+		.prog_type      = BPF_PROG_TYPE_XDP,
+	};
+	char xdp_filename[256];
+	int prog_fd;
+
+	snprintf(xdp_filename, sizeof(xdp_filename), "%s_kern.o", argv[0]);
+	prog_load_attr.file = xdp_filename;
+
+	if (bpf_prog_load_xattr(&prog_load_attr, obj, &prog_fd))
+		exit(EXIT_FAILURE);
+	if (prog_fd < 0) {
+		fprintf(stderr, "ERROR: no program found: %s\n",
+			strerror(prog_fd));
+		exit(EXIT_FAILURE);
+	}
+
+	if (bpf_set_link_xdp_fd(opt_ifindex, prog_fd, opt_xdp_flags) < 0) {
+		fprintf(stderr, "ERROR: link set xdp fd failed\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void enter_xsks_into_map(struct bpf_object *obj)
+{
+	struct bpf_map *map;
+	int i, xsks_map;
+
+	map = bpf_object__find_map_by_name(obj, "xsks_map");
+	xsks_map = bpf_map__fd(map);
+	if (xsks_map < 0) {
+		fprintf(stderr, "ERROR: no xsks map found: %s\n",
+			strerror(xsks_map));
+			exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < num_socks; i++) {
+		int fd = xsk_socket__fd(xsks[i]->xsk);
+		int key, ret;
+
+		key = i;
+		ret = bpf_map_update_elem(xsks_map, &key, &fd, 0);
+		if (ret) {
+			fprintf(stderr, "ERROR: bpf_map_update_elem %d\n", i);
+			exit(EXIT_FAILURE);
+		}
+	}
+}
+
 int main(int argc, char **argv)
 {
 	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
 	struct xsk_umem_info *umem;
+	struct bpf_object *obj;
 	pthread_t pt;
+	int i, ret;
 	void *bufs;
-	int ret;
 
 	parse_command_line(argc, argv);
 
@@ -744,6 +797,9 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	if (opt_num_xsks > 1)
+		load_xdp_program(argv, &obj);
+
 	/* Reserve memory for the umem. Use hugepages if unaligned chunk mode */
 	bufs = mmap(NULL, NUM_FRAMES * opt_xsk_frame_size,
 		    PROT_READ | PROT_WRITE,
@@ -752,16 +808,17 @@ int main(int argc, char **argv)
 		printf("ERROR: mmap failed\n");
 		exit(EXIT_FAILURE);
 	}
-       /* Create sockets... */
+
+	/* Create sockets... */
 	umem = xsk_configure_umem(bufs, NUM_FRAMES * opt_xsk_frame_size);
-	xsks[num_socks++] = xsk_configure_socket(umem);
+	for (i = 0; i < opt_num_xsks; i++)
+		xsks[num_socks++] = xsk_configure_socket(umem);
 
-	if (opt_bench == BENCH_TXONLY) {
-		int i;
+	for (i = 0; i < NUM_FRAMES; i++)
+		gen_eth_frame(umem, i * opt_xsk_frame_size);
 
-		for (i = 0; i < NUM_FRAMES; i++)
-			(void)gen_eth_frame(umem, i * opt_xsk_frame_size);
-	}
+	if (opt_num_xsks > 1 && opt_bench != BENCH_TXONLY)
+		enter_xsks_into_map(obj);
 
 	signal(SIGINT, int_exit);
 	signal(SIGTERM, int_exit);
-- 
2.7.4

