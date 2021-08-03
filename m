Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E319A3DE3CF
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhHCBEF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:65282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233464AbhHCBEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327861"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480137"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 15/16] samples/bpf: XDP hints AF_XDP example
Date:   Mon,  2 Aug 2021 18:03:30 -0700
Message-Id: <20210803010331.39453-16-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using -D option, xdpsock now shows the RX or TX timestamp of last
sent/received packets (for rx only or tx only modes).

Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
---
 samples/bpf/xdpsock_user.c | 146 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 33d0bdebbed8..9485bb6fe356 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -7,11 +7,13 @@
 #include <libgen.h>
 #include <linux/bpf.h>
 #include <linux/compiler.h>
+#include <linux/ethtool.h>
 #include <linux/if_link.h>
 #include <linux/if_xdp.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
 #include <linux/limits.h>
+#include <linux/sockios.h>
 #include <linux/udp.h>
 #include <arpa/inet.h>
 #include <locale.h>
@@ -25,6 +27,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/capability.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
@@ -99,6 +102,7 @@ static u32 opt_num_xsks = 1;
 static u32 prog_id;
 static bool opt_busy_poll;
 static bool opt_reduced_cap;
+static bool opt_metadata;
 
 struct xsk_ring_stats {
 	unsigned long rx_npkts;
@@ -142,6 +146,14 @@ struct xsk_umem_info {
 	struct xsk_ring_cons cq;
 	struct xsk_umem *umem;
 	void *buffer;
+	u32 frame_headroom;
+};
+
+struct xsk_metadata {
+	struct xsk_btf_info *xbi;
+	unsigned long rx_timestamp;
+	unsigned long tx_timestamp;
+	u32 btf_id;
 };
 
 struct xsk_socket_info {
@@ -152,13 +164,48 @@ struct xsk_socket_info {
 	struct xsk_ring_stats ring_stats;
 	struct xsk_app_stats app_stats;
 	struct xsk_driver_stats drv_stats;
+	struct xsk_metadata metadata;
 	u32 outstanding_tx;
 };
 
+struct xdp_hints {
+	u64 rx_timestamp;
+	u64 tx_timestamp;
+	u32 hash32;
+	u32 extension_id;
+	u64 field_map;
+} __attribute__((packed));
+
 static int num_socks;
 struct xsk_socket_info *xsks[MAX_SOCKS];
 int sock;
 
+static u32 get_xdp_headroom(void)
+{
+	struct ethtool_drvinfo drvinfo = { .cmd = ETHTOOL_GDRVINFO };
+	struct ifreq ifr = {};
+	int fd, err, ret;
+
+	fd = socket(AF_LOCAL, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return 0;
+
+	ifr.ifr_data = (void *)&drvinfo;
+	memcpy(ifr.ifr_name, opt_if, strlen(opt_if) + 1);
+	err = ioctl(fd, SIOCETHTOOL, &ifr);
+
+	if (err) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = drvinfo.xdp_headroom;
+
+out:
+	close(fd);
+	return ret;
+}
+
 static unsigned long get_nsecs(void)
 {
 	struct timespec ts;
@@ -258,6 +305,44 @@ static void dump_app_stats(long dt)
 	}
 }
 
+static struct xsk_btf_info *init_xsk_metadata_info(u32 btf_id)
+{
+	struct xsk_btf_info *xbi;
+
+	if (xsk_btf__init(btf_id, &xbi) < 0)
+		return NULL;
+
+	return xbi;
+}
+
+static void save_metadata_tx(void *meta, struct xsk_socket_info *xsk)
+{
+	u64 valid_map;
+
+	if (!meta)
+		return;
+
+	XSK_BTF_READ_INTO(valid_map, valid_map, xsk->metadata.xbi, meta);
+	if (valid_map & XDP_GENERIC_HINTS_TX_TIMESTAMP) {
+		XSK_BTF_READ_INTO(xsk->metadata.tx_timestamp,
+				  tx_timestamp, xsk->metadata.xbi, meta);
+	}
+}
+
+static void save_metadata_rx(void *meta, struct xsk_socket_info *xsk)
+{
+	u64 valid_map;
+
+	if (!meta)
+		return;
+
+	XSK_BTF_READ_INTO(valid_map, valid_map, xsk->metadata.xbi, meta);
+	if (valid_map & XDP_GENERIC_HINTS_RX_TIMESTAMP) {
+		XSK_BTF_READ_INTO(xsk->metadata.rx_timestamp,
+				  rx_timestamp, xsk->metadata.xbi, meta);
+	}
+}
+
 static bool get_interrupt_number(void)
 {
 	FILE *f_int_proc;
@@ -432,6 +517,12 @@ static void dump_stats(void)
 				printf("%-15s\n", "Error retrieving extra stats");
 			}
 		}
+
+		if (opt_metadata) {
+			printf("Last TX time: %lu\n", xsks[i]->metadata.tx_timestamp);
+			printf("Last RX time: %lu\n", xsks[i]->metadata.rx_timestamp);
+		}
+
 	}
 
 	if (opt_app_stats)
@@ -798,8 +889,10 @@ static void gen_eth_hdr_data(void)
 
 static void gen_eth_frame(struct xsk_umem_info *umem, u64 addr)
 {
-	memcpy(xsk_umem__get_data(umem->buffer, addr), pkt_data,
-	       PKT_SIZE);
+	void *data = xsk_umem__get_data(umem->buffer, addr);
+
+	data = xsk_umem__adjust_prod_data(data, umem->umem);
+	memcpy(data, pkt_data, PKT_SIZE);
 }
 
 static struct xsk_umem_info *xsk_configure_umem(void *buffer, u64 size)
@@ -819,6 +912,7 @@ static struct xsk_umem_info *xsk_configure_umem(void *buffer, u64 size)
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = opt_xsk_frame_size,
 		.frame_headroom = XSK_UMEM__DEFAULT_FRAME_HEADROOM,
+		.xdp_headroom = get_xdp_headroom(),
 		.flags = opt_umem_flags
 	};
 	int ret;
@@ -833,6 +927,7 @@ static struct xsk_umem_info *xsk_configure_umem(void *buffer, u64 size)
 		exit_with_error(-ret);
 
 	umem->buffer = buffer;
+	umem->frame_headroom = cfg.frame_headroom;
 	return umem;
 }
 
@@ -927,6 +1022,7 @@ static struct option long_options[] = {
 	{"irq-string", no_argument, 0, 'I'},
 	{"busy-poll", no_argument, 0, 'B'},
 	{"reduce-cap", no_argument, 0, 'R'},
+	{"metadata", no_argument, 0, 'D'},
 	{0, 0, 0, 0}
 };
 
@@ -967,6 +1063,7 @@ static void usage(const char *prog)
 		"  -I, --irq-string	Display driver interrupt statistics for interface associated with irq-string.\n"
 		"  -B, --busy-poll      Busy poll.\n"
 		"  -R, --reduce-cap	Use reduced capabilities (cannot be used with -M)\n"
+		"  -D, --metadata	Display latest packet metadata\n"
 		"\n";
 	fprintf(stderr, str, prog, XSK_UMEM__DEFAULT_FRAME_SIZE,
 		opt_batch_size, MIN_PKT_SIZE, MIN_PKT_SIZE,
@@ -982,7 +1079,7 @@ static void parse_command_line(int argc, char **argv)
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "Frtli:q:pSNn:czf:muMd:b:C:s:P:xQaI:BR",
+		c = getopt_long(argc, argv, "Frtli:q:pSNn:czf:muMd:b:C:s:P:xQaI:BRD",
 				long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1087,6 +1184,9 @@ static void parse_command_line(int argc, char **argv)
 		case 'R':
 			opt_reduced_cap = true;
 			break;
+		case 'D':
+			opt_metadata = true;
+			break;
 		default:
 			usage(basename(argv[0]));
 		}
@@ -1193,6 +1293,25 @@ static inline void complete_tx_only(struct xsk_socket_info *xsk,
 
 	rcvd = xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
 	if (rcvd > 0) {
+		if (opt_metadata) {
+			const struct xdp_desc *cq_desc = xsk_ring_cons__rx_desc(&xsk->umem->cq,
+					idx);
+			char *pkt = xsk_umem__get_data(xsk->umem->buffer, cq_desc->addr);
+			__u32 btf_id = xsk_umem__btf_id(pkt, xsk->umem->umem);
+			if (btf_id > 0) {
+				if (!xsk->metadata.xbi) {
+					xsk->metadata.xbi = init_xsk_metadata_info(btf_id);
+					if (xsk->metadata.xbi)
+						xsk->metadata.btf_id = btf_id;
+				}
+				if (xsk->metadata.btf_id == btf_id) {
+					void *m;
+
+					m = xsk_umem__adjust_cons_data_meta(pkt, xsk->umem->umem);
+					save_metadata_tx(m, xsk);
+				}
+			}
+		}
 		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
 		xsk->outstanding_tx -= rcvd;
 	}
@@ -1232,6 +1351,23 @@ static void rx_drop(struct xsk_socket_info *xsk)
 		addr = xsk_umem__add_offset_to_addr(addr);
 		char *pkt = xsk_umem__get_data(xsk->umem->buffer, addr);
 
+		if (opt_metadata) {
+			__u32 btf_id = xsk_umem__btf_id(pkt, xsk->umem->umem);
+			if (btf_id > 0) {
+				if (!xsk->metadata.xbi) {
+					xsk->metadata.xbi = init_xsk_metadata_info(btf_id);
+					if (xsk->metadata.xbi)
+						xsk->metadata.btf_id = btf_id;
+				}
+				if (xsk->metadata.btf_id == btf_id) {
+					void *m;
+
+					m = xsk_umem__adjust_cons_data_meta(pkt, xsk->umem->umem);
+					save_metadata_rx(m, xsk);
+				}
+			}
+		}
+
 		hex_dump(pkt, len, addr);
 		*xsk_ring_prod__fill_addr(&xsk->umem->fq, idx_fq++) = orig;
 	}
@@ -1283,7 +1419,9 @@ static void tx_only(struct xsk_socket_info *xsk, u32 *frame_nb, int batch_size)
 	for (i = 0; i < batch_size; i++) {
 		struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx,
 								  idx + i);
-		tx_desc->addr = (*frame_nb + i) * opt_xsk_frame_size;
+		tx_desc->addr = (__u64)xsk_umem__adjust_prod_data(
+				(void *)(__u64)((*frame_nb + i) * opt_xsk_frame_size),
+				xsk->umem->umem);
 		tx_desc->len = PKT_SIZE;
 	}
 
-- 
2.32.0

