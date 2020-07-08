Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25A2181C0
	for <lists+bpf@lfdr.de>; Wed,  8 Jul 2020 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgGHHui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 03:50:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:63202 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGHHuh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 03:50:37 -0400
IronPort-SDR: j0pvhITfWGaUb4AXYwYXxK1KtefdEe+rGFtx6LoGRgM/L2xvfA73aspCd12+TCrzM+68zpMQpI
 smqmz19oGm8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="149266807"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="149266807"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:50:37 -0700
IronPort-SDR: hzJtXiCtpklyr9p8A6ROO7bIqIU3UwDEnjqsSkPeE/oWKZ5fLe5UNTKtfUHyz3xAiDZEF+EJgn
 Pn+tKYTZ80yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358030331"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.116])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 00:50:36 -0700
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com
Cc:     Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next 2/3] samples: bpf: add an option for printing extra statistics in xdpsock
Date:   Wed,  8 Jul 2020 07:28:34 +0000
Message-Id: <20200708072835.4427-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708072835.4427-1-ciara.loftus@intel.com>
References: <20200708072835.4427-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce the --extra-stats (or simply -x) flag to the xdpsock application
which prints additional statistics alongside the regular rx and tx
counters. The new statistics printed report error conditions eg. rx ring
full, invalid descriptors, etc.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 samples/bpf/xdpsock_user.c | 87 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index c91e91362a0c..19c679456a0e 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -77,6 +77,7 @@ static u32 opt_batch_size = 64;
 static int opt_pkt_count;
 static u16 opt_pkt_size = MIN_PKT_SIZE;
 static u32 opt_pkt_fill_pattern = 0x12345678;
+static bool opt_extra_stats;
 static int opt_poll;
 static int opt_interval = 1;
 static u32 opt_xdp_bind_flags = XDP_USE_NEED_WAKEUP;
@@ -103,8 +104,20 @@ struct xsk_socket_info {
 	struct xsk_socket *xsk;
 	unsigned long rx_npkts;
 	unsigned long tx_npkts;
+	unsigned long rx_dropped_npkts;
+	unsigned long rx_invalid_npkts;
+	unsigned long tx_invalid_npkts;
+	unsigned long rx_full_npkts;
+	unsigned long rx_fill_empty_npkts;
+	unsigned long tx_empty_npkts;
 	unsigned long prev_rx_npkts;
 	unsigned long prev_tx_npkts;
+	unsigned long prev_rx_dropped_npkts;
+	unsigned long prev_rx_invalid_npkts;
+	unsigned long prev_tx_invalid_npkts;
+	unsigned long prev_rx_full_npkts;
+	unsigned long prev_rx_fill_empty_npkts;
+	unsigned long prev_tx_empty_npkts;
 	u32 outstanding_tx;
 };
 
@@ -147,6 +160,30 @@ static void print_benchmark(bool running)
 	}
 }
 
+static int xsk_get_xdp_stats(int fd, struct xsk_socket_info *xsk)
+{
+	struct xdp_statistics stats;
+	socklen_t optlen;
+	int err;
+
+	optlen = sizeof(stats);
+	err = getsockopt(fd, SOL_XDP, XDP_STATISTICS, &stats, &optlen);
+	if (err)
+		return err;
+
+	if (optlen == sizeof(struct xdp_statistics)) {
+		xsk->rx_dropped_npkts = stats.rx_dropped;
+		xsk->rx_invalid_npkts = stats.rx_invalid_descs;
+		xsk->tx_invalid_npkts = stats.tx_invalid_descs;
+		xsk->rx_full_npkts = stats.rx_ring_full;
+		xsk->rx_fill_empty_npkts = stats.rx_fill_ring_empty_descs;
+		xsk->tx_empty_npkts = stats.tx_ring_empty_descs;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static void dump_stats(void)
 {
 	unsigned long now = get_nsecs();
@@ -157,7 +194,8 @@ static void dump_stats(void)
 
 	for (i = 0; i < num_socks && xsks[i]; i++) {
 		char *fmt = "%-15s %'-11.0f %'-11lu\n";
-		double rx_pps, tx_pps;
+		double rx_pps, tx_pps, dropped_pps, rx_invalid_pps, full_pps, fill_empty_pps,
+			tx_invalid_pps, tx_empty_pps;
 
 		rx_pps = (xsks[i]->rx_npkts - xsks[i]->prev_rx_npkts) *
 			 1000000000. / dt;
@@ -175,6 +213,46 @@ static void dump_stats(void)
 
 		xsks[i]->prev_rx_npkts = xsks[i]->rx_npkts;
 		xsks[i]->prev_tx_npkts = xsks[i]->tx_npkts;
+
+		if (opt_extra_stats) {
+			if (!xsk_get_xdp_stats(xsk_socket__fd(xsks[i]->xsk), xsks[i])) {
+				dropped_pps = (xsks[i]->rx_dropped_npkts -
+						xsks[i]->prev_rx_dropped_npkts) * 1000000000. / dt;
+				rx_invalid_pps = (xsks[i]->rx_invalid_npkts -
+						xsks[i]->prev_rx_invalid_npkts) * 1000000000. / dt;
+				tx_invalid_pps = (xsks[i]->tx_invalid_npkts -
+						xsks[i]->prev_tx_invalid_npkts) * 1000000000. / dt;
+				full_pps = (xsks[i]->rx_full_npkts -
+						xsks[i]->prev_rx_full_npkts) * 1000000000. / dt;
+				fill_empty_pps = (xsks[i]->rx_fill_empty_npkts -
+						xsks[i]->prev_rx_fill_empty_npkts)
+						* 1000000000. / dt;
+				tx_empty_pps = (xsks[i]->tx_empty_npkts -
+						xsks[i]->prev_tx_empty_npkts) * 1000000000. / dt;
+
+				printf(fmt, "rx dropped", dropped_pps,
+				       xsks[i]->rx_dropped_npkts);
+				printf(fmt, "rx invalid", rx_invalid_pps,
+				       xsks[i]->rx_invalid_npkts);
+				printf(fmt, "tx invalid", tx_invalid_pps,
+				       xsks[i]->tx_invalid_npkts);
+				printf(fmt, "rx queue full", full_pps,
+				       xsks[i]->rx_full_npkts);
+				printf(fmt, "fill ring empty", fill_empty_pps,
+				       xsks[i]->rx_fill_empty_npkts);
+				printf(fmt, "tx ring empty", tx_empty_pps,
+				       xsks[i]->tx_empty_npkts);
+
+				xsks[i]->prev_rx_dropped_npkts = xsks[i]->rx_dropped_npkts;
+				xsks[i]->prev_rx_invalid_npkts = xsks[i]->rx_invalid_npkts;
+				xsks[i]->prev_tx_invalid_npkts = xsks[i]->tx_invalid_npkts;
+				xsks[i]->prev_rx_full_npkts = xsks[i]->rx_full_npkts;
+				xsks[i]->prev_rx_fill_empty_npkts = xsks[i]->rx_fill_empty_npkts;
+				xsks[i]->prev_tx_empty_npkts = xsks[i]->tx_empty_npkts;
+			} else {
+				printf("%-15s\n", "Error retrieving extra stats");
+			}
+		}
 	}
 }
 
@@ -630,6 +708,7 @@ static struct option long_options[] = {
 	{"tx-pkt-count", required_argument, 0, 'C'},
 	{"tx-pkt-size", required_argument, 0, 's'},
 	{"tx-pkt-pattern", required_argument, 0, 'P'},
+	{"extra-stats", no_argument, 0, 'x'},
 	{0, 0, 0, 0}
 };
 
@@ -664,6 +743,7 @@ static void usage(const char *prog)
 		"			(Default: %d bytes)\n"
 		"			Min size: %d, Max size %d.\n"
 		"  -P, --tx-pkt-pattern=nPacket fill pattern. Default: 0x%x\n"
+		"  -x, --extra-stats	Display extra statistics.\n"
 		"\n";
 	fprintf(stderr, str, prog, XSK_UMEM__DEFAULT_FRAME_SIZE,
 		opt_batch_size, MIN_PKT_SIZE, MIN_PKT_SIZE,
@@ -679,7 +759,7 @@ static void parse_command_line(int argc, char **argv)
 	opterr = 0;
 
 	for (;;) {
-		c = getopt_long(argc, argv, "Frtli:q:pSNn:czf:muMd:b:C:s:P:",
+		c = getopt_long(argc, argv, "Frtli:q:pSNn:czf:muMd:b:C:s:P:x",
 				long_options, &option_index);
 		if (c == -1)
 			break;
@@ -760,6 +840,9 @@ static void parse_command_line(int argc, char **argv)
 		case 'P':
 			opt_pkt_fill_pattern = strtol(optarg, NULL, 16);
 			break;
+		case 'x':
+			opt_extra_stats = 1;
+			break;
 		default:
 			usage(basename(argv[0]));
 		}
-- 
2.17.1

