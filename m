Return-Path: <bpf+bounces-15118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D27ECA16
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4BA1F27F80
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093A433BE;
	Wed, 15 Nov 2023 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACfmZ1iG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD31A8;
	Wed, 15 Nov 2023 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070916; x=1731606916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MW5qfXznjQTBINO8QgixT9oFS4keqSt5OPuUOJR6x/o=;
  b=ACfmZ1iGy/Eijq3RSCVnGUcqhaueKmBpP5r7NDsiAte6CuElHyEfGNAM
   1ZjI1FNdelOex1M2v2gRp1pWrroOUsKfeiI4BfNXB3cwNQW0yEBCRM4Za
   zE78O5XlD47ctAjzuoAKVc3OKurTAzjTErKYWjuPNbqxemmLmvzLTbHxv
   G8q/RqykNSSGHB4OU6wjf7rhmHEdrXcp06sXcjtEqm3sRJqdYqzflSb2f
   mM009QKNO/GN/wR8REf6H/oW+5Uk2gJqngPJ+WFBJ3YJrxysLA03yo28M
   ZaaiOnVXiUQzx73lsdYi38nOIWxKRJxLkNxZZn3A+HJtqPlAyDSlHcMSR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="375965654"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="375965654"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="855720216"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="855720216"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2023 09:55:09 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 709EA3783B;
	Wed, 15 Nov 2023 17:55:06 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v7 17/18] selftests/bpf: Use AF_INET for TX in xdp_metadata
Date: Wed, 15 Nov 2023 18:52:59 +0100
Message-ID: <20231115175301.534113-18-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115175301.534113-1-larysa.zaremba@intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The easiest way to simulate stripped VLAN tag in veth is to send a packet
from VLAN interface, attached to veth. Unfortunately, this approach is
incompatible with AF_XDP on TX side, because VLAN interfaces do not have
such feature.

Replace AF_XDP packet generation with sending the same datagram via
AF_INET socket.

This does not change the packet contents or hints values with one notable
exception: rx_hash_type, which previously was expected to be 0, now is
expected be at least XDP_RSS_TYPE_L4.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 167 +++++++-----------
 1 file changed, 59 insertions(+), 108 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 4439ba9392f8..4fcdda02c75e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -20,7 +20,7 @@
 
 #define UDP_PAYLOAD_BYTES 4
 
-#define AF_XDP_SOURCE_PORT 1234
+#define UDP_SOURCE_PORT 1234
 #define AF_XDP_CONSUMER_PORT 8080
 
 #define UMEM_NUM 16
@@ -33,6 +33,12 @@
 #define RX_ADDR "10.0.0.2"
 #define PREFIX_LEN "8"
 #define FAMILY AF_INET
+#define TX_NETNS_NAME "xdp_metadata_tx"
+#define RX_NETNS_NAME "xdp_metadata_rx"
+#define TX_MAC "00:00:00:00:00:01"
+#define RX_MAC "00:00:00:00:00:02"
+
+#define XDP_RSS_TYPE_L4 BIT(3)
 
 struct xsk {
 	void *umem_area;
@@ -119,90 +125,28 @@ static void close_xsk(struct xsk *xsk)
 	munmap(xsk->umem_area, UMEM_SIZE);
 }
 
-static void ip_csum(struct iphdr *iph)
+static int generate_packet_udp(void)
 {
-	__u32 sum = 0;
-	__u16 *p;
-	int i;
-
-	iph->check = 0;
-	p = (void *)iph;
-	for (i = 0; i < sizeof(*iph) / sizeof(*p); i++)
-		sum += p[i];
-
-	while (sum >> 16)
-		sum = (sum & 0xffff) + (sum >> 16);
-
-	iph->check = ~sum;
-}
-
-static int generate_packet(struct xsk *xsk, __u16 dst_port)
-{
-	struct xdp_desc *tx_desc;
-	struct udphdr *udph;
-	struct ethhdr *eth;
-	struct iphdr *iph;
-	void *data;
-	__u32 idx;
-	int ret;
-
-	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
-	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
-		return -1;
-
-	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
-	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
-	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
-	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
-
-	eth = data;
-	iph = (void *)(eth + 1);
-	udph = (void *)(iph + 1);
-
-	memcpy(eth->h_dest, "\x00\x00\x00\x00\x00\x02", ETH_ALEN);
-	memcpy(eth->h_source, "\x00\x00\x00\x00\x00\x01", ETH_ALEN);
-	eth->h_proto = htons(ETH_P_IP);
-
-	iph->version = 0x4;
-	iph->ihl = 0x5;
-	iph->tos = 0x9;
-	iph->tot_len = htons(sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES);
-	iph->id = 0;
-	iph->frag_off = 0;
-	iph->ttl = 0;
-	iph->protocol = IPPROTO_UDP;
-	ASSERT_EQ(inet_pton(FAMILY, TX_ADDR, &iph->saddr), 1, "inet_pton(TX_ADDR)");
-	ASSERT_EQ(inet_pton(FAMILY, RX_ADDR, &iph->daddr), 1, "inet_pton(RX_ADDR)");
-	ip_csum(iph);
-
-	udph->source = htons(AF_XDP_SOURCE_PORT);
-	udph->dest = htons(dst_port);
-	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
-	udph->check = 0;
-
-	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
-
-	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
-	xsk_ring_prod__submit(&xsk->tx, 1);
-
-	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
-	if (!ASSERT_GE(ret, 0, "sendto"))
-		return ret;
-
-	return 0;
-}
-
-static void complete_tx(struct xsk *xsk)
-{
-	__u32 idx;
-	__u64 addr;
-
-	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
-		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
-
-		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
-		xsk_ring_cons__release(&xsk->comp, 1);
-	}
+	char udp_payload[UDP_PAYLOAD_BYTES];
+	struct sockaddr_in rx_addr;
+	int sock_fd, err = 0;
+
+	/* Build a packet */
+	memset(udp_payload, 0xAA, UDP_PAYLOAD_BYTES);
+	rx_addr.sin_addr.s_addr = inet_addr(RX_ADDR);
+	rx_addr.sin_family = AF_INET;
+	rx_addr.sin_port = htons(UDP_SOURCE_PORT);
+
+	sock_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (!ASSERT_GE(sock_fd, 0, "socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)"))
+		return sock_fd;
+
+	err = sendto(sock_fd, udp_payload, UDP_PAYLOAD_BYTES, MSG_DONTWAIT,
+		     (void *)&rx_addr, sizeof(rx_addr));
+	ASSERT_GE(err, 0, "sendto");
+
+	close(sock_fd);
+	return err;
 }
 
 static void refill_rx(struct xsk *xsk, __u64 addr)
@@ -268,7 +212,8 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
-	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
+	if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
+		return -1;
 
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
@@ -284,36 +229,38 @@ void test_xdp_metadata(void)
 	struct nstoken *tok = NULL;
 	__u32 queue_id = QUEUE_ID;
 	struct bpf_map *prog_arr;
-	struct xsk tx_xsk = {};
 	struct xsk rx_xsk = {};
 	__u32 val, key = 0;
 	int retries = 10;
 	int rx_ifindex;
-	int tx_ifindex;
 	int sock_fd;
 	int ret;
 
-	/* Setup new networking namespace, with a veth pair. */
+	/* Setup new networking namespaces, with a veth pair. */
 
-	SYS(out, "ip netns add xdp_metadata");
-	tok = open_netns("xdp_metadata");
+	SYS(out, "ip netns add " TX_NETNS_NAME);
+	SYS(out, "ip netns add " RX_NETNS_NAME);
+
+	tok = open_netns(TX_NETNS_NAME);
 	SYS(out, "ip link add numtxqueues 1 numrxqueues 1 " TX_NAME
 	    " type veth peer " RX_NAME " numtxqueues 1 numrxqueues 1");
-	SYS(out, "ip link set dev " TX_NAME " address 00:00:00:00:00:01");
-	SYS(out, "ip link set dev " RX_NAME " address 00:00:00:00:00:02");
+	SYS(out, "ip link set " RX_NAME " netns " RX_NETNS_NAME);
+
+	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
 	SYS(out, "ip link set dev " TX_NAME " up");
-	SYS(out, "ip link set dev " RX_NAME " up");
 	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
-	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
 
-	rx_ifindex = if_nametoindex(RX_NAME);
-	tx_ifindex = if_nametoindex(TX_NAME);
+	/* Avoid ARP calls */
+	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
+	close_netns(tok);
 
-	/* Setup separate AF_XDP for TX and RX interfaces. */
+	tok = open_netns(RX_NETNS_NAME);
+	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
+	SYS(out, "ip link set dev " RX_NAME " up");
+	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
+	rx_ifindex = if_nametoindex(RX_NAME);
 
-	ret = open_xsk(tx_ifindex, &tx_xsk);
-	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
-		goto out;
+	/* Setup AF_XDP for RX interface. */
 
 	ret = open_xsk(rx_ifindex, &rx_xsk);
 	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
@@ -353,19 +300,20 @@ void test_xdp_metadata(void)
 	ret = bpf_map_update_elem(bpf_map__fd(bpf_obj->maps.xsk), &queue_id, &sock_fd, 0);
 	if (!ASSERT_GE(ret, 0, "bpf_map_update_elem"))
 		goto out;
+	close_netns(tok);
 
 	/* Send packet destined to RX AF_XDP socket. */
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
-		       "generate AF_XDP_CONSUMER_PORT"))
+	tok = open_netns(TX_NETNS_NAME);
+	if (!ASSERT_GE(generate_packet_udp(), 0, "generate UDP packet"))
 		goto out;
+	close_netns(tok);
 
 	/* Verify AF_XDP RX packet has proper metadata. */
+	tok = open_netns(RX_NETNS_NAME);
 	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk), 0,
 		       "verify_xsk_metadata"))
 		goto out;
 
-	complete_tx(&tx_xsk);
-
 	/* Make sure freplace correctly picks up original bound device
 	 * and doesn't crash.
 	 */
@@ -382,12 +330,15 @@ void test_xdp_metadata(void)
 
 	if (!ASSERT_OK(xdp_metadata2__attach(bpf_obj2), "attach freplace"))
 		goto out;
+	close_netns(tok);
 
 	/* Send packet to trigger . */
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
-		       "generate freplace packet"))
+	tok = open_netns(TX_NETNS_NAME);
+	if (!ASSERT_GE(generate_packet_udp(), 0, "generate freplace packet"))
 		goto out;
+	close_netns(tok);
 
+	tok = open_netns(RX_NETNS_NAME);
 	while (!retries--) {
 		if (bpf_obj2->bss->called)
 			break;
@@ -397,10 +348,10 @@ void test_xdp_metadata(void)
 
 out:
 	close_xsk(&rx_xsk);
-	close_xsk(&tx_xsk);
 	xdp_metadata2__destroy(bpf_obj2);
 	xdp_metadata__destroy(bpf_obj);
 	if (tok)
 		close_netns(tok);
-	SYS_NOFAIL("ip netns del xdp_metadata");
+	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
+	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
 }
-- 
2.41.0


