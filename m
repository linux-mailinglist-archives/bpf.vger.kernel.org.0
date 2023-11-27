Return-Path: <bpf+bounces-15978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D127FA99D
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDD7B211A1
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35B4597D;
	Mon, 27 Nov 2023 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9ALPJsg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039BD64
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daee86e2d70so5564570276.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111825; x=1701716625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aC0MUVrEZYxjfAF4f/0rZDSKLUrYPaQCejwf2lWEL6M=;
        b=G9ALPJsg57c+HgathfbTBKDANAU0IhRIII7umWuVlM3YfTYmNSIG0npc76E0/yhIUe
         f8WteS1iMEibEWGTYEMsZOc6ucMgc+9KywDXh4/TdBbW0/rn+qz4FNsViW0rzqalhswa
         cvWM7TfwiuBmfulwtokREMRHNZT7YM9nmMx1gpFV4sIEcyDrVJw4NvppUDeFoqivsmg1
         0u1PUgOkbCwMYBJyLRNYLXhf6CSnkGXGOkce/QWjvZL1DSq2iMUMG197PEDL7geZK6cB
         z+mGqSt5xxUUHytGsXscU2/hPtAXACxwAFO7Z0HCoKQQOUGJ5qgSgMMmtXMaFLnMaoHR
         GFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111825; x=1701716625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aC0MUVrEZYxjfAF4f/0rZDSKLUrYPaQCejwf2lWEL6M=;
        b=CDXyGYprFjGR9NNkQR1CINUQp8++Z//XI148WklFyCOo2T6DVNBw4fGNKY92xSSbsj
         InI4/+SADS4am3QwuDeMn3X4U8dWiP02vE5ZssFbkj08khG5TLqbZYOiaSCwzAIJBZDe
         Z4MbFZTL9kphm86LaeDn4OGJnOjmhwd1P9oFiY4ON0ynZj6rTaLb8MLja3dOt8tALHLM
         HiI8WjVjlqjKRhlfZ5Mzx73wt3adC4Ek6uYO8J0yGMaqSkpICscEcu5+UydLs2W8xx9D
         amoO3Cfbvs06E+AeqVsL2miXlqseNDkKfBFN1OSOI9eqt4YwXLme/LYhz4A8YuAGm8tu
         +1Ew==
X-Gm-Message-State: AOJu0YzL5gR0Ia42tJ3RzKBs7dPXnkcevurMupcJSZaWlP+UkpGpc9Tz
	7tVuKYjUMTTSpojwIAzDYYw3pGa/H4zs9cPyTKgiqNyaXn/qDbYVALrTJGCMY30PkgvTp6Zp/Bd
	u7Xd4ady4Z79Ewf9sTX33+osSGqn0sDfPan00gSvG5jQQl7AVRw==
X-Google-Smtp-Source: AGHT+IEyWw1rFaEtva2abKBWLH/BWw/JiEVXaHeYe1SwZrUJDV9SaIrZHHbmcNLI6LhJzWJrHYqfjtE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:6f09:0:b0:d9a:d233:b2a3 with SMTP id
 k9-20020a256f09000000b00d9ad233b2a3mr400180ybc.1.1701111825142; Mon, 27 Nov
 2023 11:03:45 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:19 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-14-sdf@google.com>
Subject: [PATCH bpf-next v6 13/13] selftests/bpf: Add TX side to xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

When we get a packet on port 9091, we swap src/dst and send it out.
At this point we also request the timestamp and checksum offloads.

Checksum offload is verified by looking at the tcpdump on the other side.
The tool prints pseudo-header csum and the final one it expects.
The final checksum actually matches the incoming packets checksum
because we only flip the src/dst and don't change the payload.

Some other related changes:
- switched to zerocopy mode by default; new flag can be used to force
  old behavior
- request fixed tx_metadata_len headroom
- some other small fixes (umem size, fill idx+i, etc)

mvbz3:~# ./xdp_hw_metadata eth3
...
xsk_ring_cons__peek: 1
0x19546f8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
rx_hash: 0x80B7EA8B with RSS type:0x2A
rx_timestamp:  1697580171852147395 (sec:1697580171.8521)
HW RX-time:   1697580171852147395 (sec:1697580171.8521), delta to User RX-time sec:0.2797 (279673.082 usec)
XDP RX-time:   1697580172131699047 (sec:1697580172.1317), delta to User RX-time sec:0.0001 (121.430 usec)
0x19546f8: ping-pong with csum=3b8e (want d862) csum_start=54 csum_offset=6
0x19546f8: complete tx idx=0 addr=8
tx_timestamp:  1697580172056756493 (sec:1697580172.0568)
HW TX-complete-time:   1697580172056756493 (sec:1697580172.0568), delta to User TX-complete-time sec:0.0852 (85175.537 usec)
XDP RX-time:   1697580172131699047 (sec:1697580172.1317), delta to User TX-complete-time sec:0.0102 (10232.983 usec)
HW RX-time:   1697580171852147395 (sec:1697580171.8521), delta to HW TX-complete-time sec:0.2046 (204609.098 usec)
0x19546f8: complete rx idx=128 addr=80100

mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091

mvbz4:~# tcpdump -vvx -i eth3 udp
        tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
12:26:09.301074 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1087.55807 > fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0xde7e!] UDP, length 3
        0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
        0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
        0x0020:  1270 fdff fe48 1077 d9ff 2383 000b 3b8e
        0x0030:  7864 70
12:26:09.301976 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.55807: [udp sum ok] UDP, length 3
        0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
        0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
        0x0020:  1270 fdff fe48 1087 2383 d9ff 000b de7e
        0x0030:  7864 70

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 164 +++++++++++++++++-
 1 file changed, 160 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 4484b17c7a56..3291625ba4fb 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -10,7 +10,9 @@
  *   - rx_hash
  *
  * TX:
- * - TBD
+ * - UDP 9091 packets trigger TX reply
+ * - TX HW timestamp is requested and reported back upon completion
+ * - TX checksum is requested
  */
 
 #include <test_progs.h>
@@ -24,11 +26,14 @@
 #include <linux/net_tstamp.h>
 #include <linux/udp.h>
 #include <linux/sockios.h>
+#include <linux/if_xdp.h>
 #include <sys/mman.h>
 #include <net/if.h>
 #include <ctype.h>
 #include <poll.h>
 #include <time.h>
+#include <unistd.h>
+#include <libgen.h>
 
 #include "xdp_metadata.h"
 
@@ -53,6 +58,9 @@ struct xsk *rx_xsk;
 const char *ifname;
 int ifindex;
 int rxq;
+bool skip_tx;
+__u64 last_hw_rx_timestamp;
+__u64 last_xdp_rx_timestamp;
 
 void test__fail(void) { /* for network_helpers.c */ }
 
@@ -69,6 +77,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
 		.flags = XSK_UMEM__DEFAULT_FLAGS,
+		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx;
 	u64 addr;
@@ -185,15 +194,19 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		printf("rx_hash: 0x%X with RSS type:0x%X\n",
 		       meta->rx_hash, meta->rx_hash_type);
 
-	printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
-	       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
 	if (meta->rx_timestamp) {
 		__u64 ref_tstamp = gettime(clock_id);
 
+		/* store received timestamps to calculate a delta at tx */
+		last_hw_rx_timestamp = meta->rx_timestamp;
+		last_xdp_rx_timestamp = meta->xdp_timestamp;
+
 		print_tstamp_delta("HW RX-time", "User RX-time",
 				   meta->rx_timestamp, ref_tstamp);
 		print_tstamp_delta("XDP RX-time", "User RX-time",
 				   meta->xdp_timestamp, ref_tstamp);
+	} else {
+		printf("No rx_timestamp\n");
 	}
 }
 
@@ -242,6 +255,129 @@ static void verify_skb_metadata(int fd)
 	printf("skb hwtstamp is not found!\n");
 }
 
+static bool complete_tx(struct xsk *xsk, clockid_t clock_id)
+{
+	struct xsk_tx_metadata *meta;
+	__u64 addr;
+	void *data;
+	__u32 idx;
+
+	if (!xsk_ring_cons__peek(&xsk->comp, 1, &idx))
+		return false;
+
+	addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
+	data = xsk_umem__get_data(xsk->umem_area, addr);
+	meta = data - sizeof(struct xsk_tx_metadata);
+
+	printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
+
+	if (meta->completion.tx_timestamp) {
+		__u64 ref_tstamp = gettime(clock_id);
+
+		print_tstamp_delta("HW TX-complete-time", "User TX-complete-time",
+				   meta->completion.tx_timestamp, ref_tstamp);
+		print_tstamp_delta("XDP RX-time", "User TX-complete-time",
+				   last_xdp_rx_timestamp, ref_tstamp);
+		print_tstamp_delta("HW RX-time", "HW TX-complete-time",
+				   last_hw_rx_timestamp, meta->completion.tx_timestamp);
+	} else {
+		printf("No tx_timestamp\n");
+	}
+
+	xsk_ring_cons__release(&xsk->comp, 1);
+
+	return true;
+}
+
+#define swap(a, b, len) do { \
+	for (int i = 0; i < len; i++) { \
+		__u8 tmp = ((__u8 *)a)[i]; \
+		((__u8 *)a)[i] = ((__u8 *)b)[i]; \
+		((__u8 *)b)[i] = tmp; \
+	} \
+} while (0)
+
+static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t clock_id)
+{
+	struct xsk_tx_metadata *meta;
+	struct ipv6hdr *ip6h = NULL;
+	struct iphdr *iph = NULL;
+	struct xdp_desc *tx_desc;
+	struct udphdr *udph;
+	struct ethhdr *eth;
+	__sum16 want_csum;
+	void *data;
+	__u32 idx;
+	int ret;
+	int len;
+
+	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
+	if (ret != 1) {
+		printf("%p: failed to reserve tx slot\n", xsk);
+		return;
+	}
+
+	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
+	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
+	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+
+	meta = data - sizeof(struct xsk_tx_metadata);
+	memset(meta, 0, sizeof(*meta));
+	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP;
+
+	eth = rx_packet;
+
+	if (eth->h_proto == htons(ETH_P_IP)) {
+		iph = (void *)(eth + 1);
+		udph = (void *)(iph + 1);
+	} else if (eth->h_proto == htons(ETH_P_IPV6)) {
+		ip6h = (void *)(eth + 1);
+		udph = (void *)(ip6h + 1);
+	} else {
+		printf("%p: failed to detect IP version for ping pong %04x\n", xsk, eth->h_proto);
+		xsk_ring_prod__cancel(&xsk->tx, 1);
+		return;
+	}
+
+	len = ETH_HLEN;
+	if (ip6h)
+		len += sizeof(*ip6h) + ntohs(ip6h->payload_len);
+	if (iph)
+		len += ntohs(iph->tot_len);
+
+	swap(eth->h_dest, eth->h_source, ETH_ALEN);
+	if (iph)
+		swap(&iph->saddr, &iph->daddr, 4);
+	else
+		swap(&ip6h->saddr, &ip6h->daddr, 16);
+	swap(&udph->source, &udph->dest, 2);
+
+	want_csum = udph->check;
+	if (ip6h)
+		udph->check = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
+					       ntohs(udph->len), IPPROTO_UDP, 0);
+	else
+		udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+						 ntohs(udph->len), IPPROTO_UDP, 0);
+
+	meta->flags |= XDP_TXMD_FLAGS_CHECKSUM;
+	if (iph)
+		meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
+	else
+		meta->request.csum_start = sizeof(*eth) + sizeof(*ip6h);
+	meta->request.csum_offset = offsetof(struct udphdr, check);
+
+	printf("%p: ping-pong with csum=%04x (want %04x) csum_start=%d csum_offset=%d\n",
+	       xsk, ntohs(udph->check), ntohs(want_csum),
+	       meta->request.csum_start, meta->request.csum_offset);
+
+	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
+	tx_desc->options |= XDP_TX_METADATA;
+	tx_desc->len = len;
+
+	xsk_ring_prod__submit(&xsk->tx, 1);
+}
+
 static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id)
 {
 	const struct xdp_desc *rx_desc;
@@ -307,6 +443,22 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 				verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
 						    clock_id);
 				first_seg = false;
+
+				if (!skip_tx) {
+					/* mirror first chunk back */
+					ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr),
+						  clock_id);
+
+					ret = kick_tx(xsk);
+					if (ret)
+						printf("kick_tx ret=%d\n", ret);
+
+					for (int j = 0; j < 500; j++) {
+						if (complete_tx(xsk, clock_id))
+							break;
+						usleep(10*1000);
+					}
+				}
 			}
 
 			xsk_ring_cons__release(&xsk->rx, 1);
@@ -442,6 +594,7 @@ static void print_usage(void)
 		"  -c    Run in copy mode (zerocopy is default)\n"
 		"  -h    Display this help and exit\n\n"
 		"  -m    Enable multi-buffer XDP for larger MTU\n"
+		"  -r    Don't generate AF_XDP reply (rx metadata only)\n"
 		"Generate test packets on the other machine with:\n"
 		"  echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
 
@@ -452,7 +605,7 @@ static void read_args(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "chm")) != -1) {
+	while ((opt = getopt(argc, argv, "chmr")) != -1) {
 		switch (opt) {
 		case 'c':
 			bind_flags &= ~XDP_USE_NEED_WAKEUP;
@@ -465,6 +618,9 @@ static void read_args(int argc, char *argv[])
 		case 'm':
 			bind_flags |= XDP_USE_SG;
 			break;
+		case 'r':
+			skip_tx = true;
+			break;
 		case '?':
 			if (isprint(optopt))
 				fprintf(stderr, "Unknown option: -%c\n", optopt);
-- 
2.43.0.rc1.413.gea7ed67945-goog


