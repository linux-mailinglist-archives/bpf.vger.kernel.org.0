Return-Path: <bpf+bounces-10086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459097A0F97
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC081C21053
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DAF273E8;
	Thu, 14 Sep 2023 21:05:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7D273D8
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:05:12 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7A2698
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:12 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68fb5a36001so1284828b3a.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725511; x=1695330311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlWYpCqhbCmdH8qiwsH4cHVSjTYKJwE8lzm2W7kR5g8=;
        b=2konUb3b/kZf3UWmtuB5CIEpIRqrht5coTP4sqTxFPzg74YtqZ3sVp3uDZEugYj5wH
         /6IyVml2P1Cnc5JvAMmiNwOO8jjDeL1b3Ez3DHvET5viJX1Dv9ZevJJ9cfQWirZpfUzv
         gz8j62s1ndUpF71a8w3IeGyWaavFrNnt2EWd3I0oiSQ+0hzuFnAHhB9ftNZ0WfPHKZXf
         h4x2wmh1mgqevxdFjnteM3e6VDf9Uy6aWxryGOUtDE5FxQ7CgcEovW/rOBtxhuhESb3S
         BGqZDAOmqjRlJip9K1M4H2G0LFfm17lX2FYpyzBYOEP9ISJ0FunGUohktfabFyhtSlLT
         3PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725511; x=1695330311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlWYpCqhbCmdH8qiwsH4cHVSjTYKJwE8lzm2W7kR5g8=;
        b=QwfmOxP9qOMwpAHLvBiCSo6H7QaiC5zK6ODv1ZFLMrd7XwENSOokkj2ET16njVPtSB
         avuJ1DhS6parsGwgGjiINehfn6iSVHUGUGFu0t50MFC/kuTbjaxP2DLmOTVBoq8u0RHE
         iinuBCZDdLlYObng8J7Ur1UX79Hh9/vwWjKeTGAEkEFcLuZrLQzly75K7KlVtTFZM89s
         BAbsPD9FXm2f/+PW3O+qB+oravPzX4G13feS/tveJB/PV8uGpinffsNNVKP6MjDyCvlL
         IhUWufbcoB0oyQglMGxHlsWfwooe6si2iw/pGbC7f8jUtyVBnkGR4nVTnPmZJgKQ3E1d
         3a8Q==
X-Gm-Message-State: AOJu0Yzp1EdW/91KLkobCpDbDw2fTcWb9mB8iLLu/IxsoRwzlNhp0ZkH
	mS/gDDFaCjs8c6Yq0seg7M8rmR2J02FQTBhraURKeF1WoPIRi/fVotugBgtxpK6n5qZF8mRgKqj
	jcHIwX0ivFvsTH7lkjkr288QC+BuiPAQag2+WxskqGypj8vUUzw==
X-Google-Smtp-Source: AGHT+IGuhZsz2G5Om4WOLOPld0oLUgN1OjaPc+5x1PDZP0t0WxFdj5zB3+OG1M7BuWcQSDmw3A7E5oQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:18a3:b0:68a:58e1:ebf5 with SMTP id
 x35-20020a056a0018a300b0068a58e1ebf5mr317916pfh.2.1694725510362; Thu, 14 Sep
 2023 14:05:10 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:51 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-9-sdf@google.com>
Subject: [PATCH bpf-next v2 8/9] selftests/bpf: Add TX side to xdp_hw_metadata
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
0x1062cb8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
rx_hash: 0x2E1B50B9 with RSS type:0x2A
rx_timestamp:  1691436369532047139 (sec:1691436369.5320)
XDP RX-time:   1691436369261756803 (sec:1691436369.2618) delta sec:-0.2703 (-270290.336 usec)
AF_XDP time:   1691436369261878839 (sec:1691436369.2619) delta sec:0.0001 (122.036 usec)
0x1062cb8: ping-pong with csum=3b8e (want de7e) csum_start=54 csum_offset=6
0x1062cb8: complete tx idx=0 addr=10
0x1062cb8: tx_timestamp:  1691436369598419505 (sec:1691436369.5984)
0x1062cb8: complete rx idx=128 addr=80100

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
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 202 +++++++++++++++++-
 1 file changed, 192 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..ab83d0ba6763 100644
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
@@ -24,14 +26,17 @@
 #include <linux/net_tstamp.h>
 #include <linux/udp.h>
 #include <linux/sockios.h>
+#include <linux/if_xdp.h>
 #include <sys/mman.h>
 #include <net/if.h>
 #include <poll.h>
 #include <time.h>
+#include <unistd.h>
+#include <libgen.h>
 
 #include "xdp_metadata.h"
 
-#define UMEM_NUM 16
+#define UMEM_NUM 256
 #define UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
 #define UMEM_SIZE (UMEM_FRAME_SIZE * UMEM_NUM)
 #define XDP_FLAGS (XDP_FLAGS_DRV_MODE | XDP_FLAGS_REPLACE)
@@ -51,22 +56,24 @@ struct xsk *rx_xsk;
 const char *ifname;
 int ifindex;
 int rxq;
+bool skip_tx;
 
 void test__fail(void) { /* for network_helpers.c */ }
 
-static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
+static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id, int flags)
 {
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	const struct xsk_socket_config socket_config = {
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
-		.bind_flags = XDP_COPY,
+		.bind_flags = flags,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
+		.flags = XSK_UMEM__DEFAULT_FLAGS,
+		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx;
 	u64 addr;
@@ -108,7 +115,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 	for (i = 0; i < UMEM_NUM / 2; i++) {
 		addr = (UMEM_NUM / 2 + i) * UMEM_FRAME_SIZE;
 		printf("%p: rx_desc[%d] -> %lx\n", xsk, i, addr);
-		*xsk_ring_prod__fill_addr(&xsk->fill, i) = addr;
+		*xsk_ring_prod__fill_addr(&xsk->fill, idx + i) = addr;
 	}
 	xsk_ring_prod__submit(&xsk->fill, ret);
 
@@ -129,12 +136,22 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
 	__u32 idx;
 
 	if (xsk_ring_prod__reserve(&xsk->fill, 1, &idx) == 1) {
-		printf("%p: complete idx=%u addr=%llx\n", xsk, idx, addr);
+		printf("%p: complete rx idx=%u addr=%llx\n", xsk, idx, addr);
 		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
 		xsk_ring_prod__submit(&xsk->fill, 1);
 	}
 }
 
+static int kick_tx(struct xsk *xsk)
+{
+	return sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
+}
+
+static int kick_rx(struct xsk *xsk)
+{
+	return recvfrom(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, NULL);
+}
+
 #define NANOSEC_PER_SEC 1000000000 /* 10^9 */
 static __u64 gettime(clockid_t clock_id)
 {
@@ -228,6 +245,117 @@ static void verify_skb_metadata(int fd)
 	printf("skb hwtstamp is not found!\n");
 }
 
+static bool complete_tx(struct xsk *xsk)
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
+	printf("%p: tx_timestamp:  %llu (sec:%0.4f)\n", xsk,
+	       meta->completion.tx_timestamp,
+	       (double)meta->completion.tx_timestamp / NANOSEC_PER_SEC);
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
+static void ping_pong(struct xsk *xsk, void *rx_packet)
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
+	meta->flags = XDP_TX_METADATA_TIMESTAMP;
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
+	meta->flags |= XDP_TX_METADATA_CHECKSUM;
+	if (iph)
+		meta->csum_start = sizeof(*eth) + sizeof(*iph);
+	else
+		meta->csum_start = sizeof(*eth) + sizeof(*ip6h);
+	meta->csum_offset = offsetof(struct udphdr, check);
+
+	printf("%p: ping-pong with csum=%04x (want %04x) csum_start=%d csum_offset=%d\n",
+	       xsk, ntohs(udph->check), ntohs(want_csum), meta->csum_start, meta->csum_offset);
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
@@ -250,6 +378,13 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 
 	while (true) {
 		errno = 0;
+
+		for (i = 0; i < rxq; i++) {
+			ret = kick_rx(&rx_xsk[i]);
+			if (ret)
+				printf("kick_rx ret=%d\n", ret);
+		}
+
 		ret = poll(fds, rxq + 1, 1000);
 		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
 		       ret, errno, bpf_obj->bss->pkts_skip,
@@ -280,6 +415,22 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 			       xsk, idx, rx_desc->addr, addr, comp_addr);
 			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
 					    clock_id);
+
+			if (!skip_tx) {
+				/* mirror the packet back */
+				ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr));
+
+				ret = kick_tx(xsk);
+				if (ret)
+					printf("kick_tx ret=%d\n", ret);
+
+				for (int j = 0; j < 500; j++) {
+					if (complete_tx(xsk))
+						break;
+					usleep(10*1000);
+				}
+			}
+
 			xsk_ring_cons__release(&xsk->rx, 1);
 			refill_rx(xsk, comp_addr);
 		}
@@ -404,21 +555,52 @@ static void timestamping_enable(int fd, int val)
 		error(1, errno, "setsockopt(SO_TIMESTAMPING)");
 }
 
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s [OPTS] <ifname>\n"
+		"OPTS:\n"
+		"    -r    don't generate AF_XDP reply (rx metadata only)\n"
+		"    -c    run in copy mode\n",
+		prog);
+}
+
 int main(int argc, char *argv[])
 {
+	int bind_flags =  XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
 	clockid_t clock_id = CLOCK_TAI;
 	int server_fd = -1;
+	int opt;
 	int ret;
 	int i;
 
 	struct bpf_program *prog;
 
-	if (argc != 2) {
+	while ((opt = getopt(argc, argv, "rc")) != -1) {
+		switch (opt) {
+		case 'r':
+			skip_tx = true;
+			break;
+		case 'c':
+			bind_flags = XDP_USE_NEED_WAKEUP | XDP_COPY;
+			break;
+		default:
+			usage(basename(argv[0]));
+			return 1;
+		}
+	}
+
+	if (argc < 2) {
 		fprintf(stderr, "pass device name\n");
 		return -1;
 	}
 
-	ifname = argv[1];
+	if (optind >= argc) {
+		usage(basename(argv[0]));
+		return 1;
+	}
+
+	ifname = argv[optind];
 	ifindex = if_nametoindex(ifname);
 	rxq = rxq_num(ifname);
 
@@ -432,7 +614,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < rxq; i++) {
 		printf("open_xsk(%s, %p, %d)\n", ifname, &rx_xsk[i], i);
-		ret = open_xsk(ifindex, &rx_xsk[i], i);
+		ret = open_xsk(ifindex, &rx_xsk[i], i, bind_flags);
 		if (ret)
 			error(1, -ret, "open_xsk");
 
-- 
2.42.0.459.ge4e396fd5e-goog


