Return-Path: <bpf+bounces-16807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D580606D
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB7B20EDF
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237546EB7E;
	Tue,  5 Dec 2023 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aq6xX5QP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1525D18B;
	Tue,  5 Dec 2023 13:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810704; x=1733346704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGTg7YmMfMOidynl6KXHw7rlhjLfYy4M2maVRiVxOcY=;
  b=Aq6xX5QPftlIXFyez35JvatxTJx9C7CV1SqkyP/eWoTtww6crk2aXwhu
   TGLyMi+jrNXwEqRnPdQkS9xHL5xqsN9uSKDDOfDyhyo6Pd6Jui1g++GcL
   c51YooQ0K+O0b13tNeRg0xfWY3RCGSag/nro2+/KnWxa/+jP9dNF+2Xgx
   a/MwZW4f7PCP4k3M8AgNbQPtmEoab4wJCKe/hIoh9C0kjZ/drDNToMGkX
   MLoiSSEgEzvgLGwip5Rqj4bWMf8PKqIMBiDGGSf7+OP1dRyxwvYEQOhiA
   evis3jtNC2Q94toRXc7MY9POmnTPZTDfqlGqGF/tZaYd0B7BdaEuzywXq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392827576"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="392827576"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764464738"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="764464738"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2023 13:11:35 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BBD603433E;
	Tue,  5 Dec 2023 21:11:32 +0000 (GMT)
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
Subject: [PATCH bpf-next v8 17/18] selftests/bpf: Add AF_INET packet generation to xdp_metadata
Date: Tue,  5 Dec 2023 22:08:46 +0100
Message-ID: <20231205210847.28460-18-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205210847.28460-1-larysa.zaremba@intel.com>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
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

Check both packets sent via AF_XDP TX and regular socket.

AF_INET packet will also have a filled-in hash type (XDP_RSS_TYPE_L4),
unlike AF_XDP packet, so more values can be checked.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 116 +++++++++++++++---
 1 file changed, 97 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 33cdf88efa6b..e7f06cbdd845 100644
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
@@ -181,7 +187,7 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	ASSERT_EQ(inet_pton(FAMILY, RX_ADDR, &iph->daddr), 1, "inet_pton(RX_ADDR)");
 	ip_csum(iph);
 
-	udph->source = htons(AF_XDP_SOURCE_PORT);
+	udph->source = htons(UDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
 	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
@@ -204,6 +210,30 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	return 0;
 }
 
+static int generate_packet_inet(void)
+{
+	char udp_payload[UDP_PAYLOAD_BYTES];
+	struct sockaddr_in rx_addr;
+	int sock_fd, err = 0;
+
+	/* Build a packet */
+	memset(udp_payload, 0xAA, UDP_PAYLOAD_BYTES);
+	rx_addr.sin_addr.s_addr = inet_addr(RX_ADDR);
+	rx_addr.sin_family = AF_INET;
+	rx_addr.sin_port = htons(AF_XDP_CONSUMER_PORT);
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
+}
+
 static void complete_tx(struct xsk *xsk)
 {
 	struct xsk_tx_metadata *meta;
@@ -236,7 +266,7 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
 	}
 }
 
-static int verify_xsk_metadata(struct xsk *xsk)
+static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 {
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds = {};
@@ -290,17 +320,36 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
+	if (!sent_from_af_xdp) {
+		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
+			return -1;
+		goto done;
+	}
+
 	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
 
 	/* checksum offload */
 	ASSERT_EQ(udph->check, htons(0x721c), "csum");
 
+done:
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
 	return 0;
 }
 
+static void switch_ns_to_rx(struct nstoken **tok)
+{
+	close_netns(*tok);
+	*tok = open_netns(RX_NETNS_NAME);
+}
+
+static void switch_ns_to_tx(struct nstoken **tok)
+{
+	close_netns(*tok);
+	*tok = open_netns(TX_NETNS_NAME);
+}
+
 void test_xdp_metadata(void)
 {
 	struct xdp_metadata2 *bpf_obj2 = NULL;
@@ -318,27 +367,31 @@ void test_xdp_metadata(void)
 	int sock_fd;
 	int ret;
 
-	/* Setup new networking namespace, with a veth pair. */
+	/* Setup new networking namespaces, with a veth pair. */
+	SYS(out, "ip netns add " TX_NETNS_NAME);
+	SYS(out, "ip netns add " RX_NETNS_NAME);
 
-	SYS(out, "ip netns add xdp_metadata");
-	tok = open_netns("xdp_metadata");
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
+
+	/* Avoid ARP calls */
+	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
+
+	switch_ns_to_rx(&tok);
+
+	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
+	SYS(out, "ip link set dev " RX_NAME " up");
 	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
 
 	rx_ifindex = if_nametoindex(RX_NAME);
-	tx_ifindex = if_nametoindex(TX_NAME);
 
-	/* Setup separate AF_XDP for TX and RX interfaces. */
-
-	ret = open_xsk(tx_ifindex, &tx_xsk);
-	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
-		goto out;
+	/* Setup separate AF_XDP for RX interface. */
 
 	ret = open_xsk(rx_ifindex, &rx_xsk);
 	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
@@ -379,18 +432,38 @@ void test_xdp_metadata(void)
 	if (!ASSERT_GE(ret, 0, "bpf_map_update_elem"))
 		goto out;
 
-	/* Send packet destined to RX AF_XDP socket. */
+	switch_ns_to_tx(&tok);
+
+	/* Setup separate AF_XDP for TX interface nad send packet to the RX socket. */
+	tx_ifindex = if_nametoindex(TX_NAME);
+	ret = open_xsk(tx_ifindex, &tx_xsk);
+	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
+		goto out;
+
 	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
 		       "generate AF_XDP_CONSUMER_PORT"))
 		goto out;
 
-	/* Verify AF_XDP RX packet has proper metadata. */
-	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk), 0,
+	switch_ns_to_rx(&tok);
+
+	/* Verify packet sent from AF_XDP has proper metadata. */
+	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
 		       "verify_xsk_metadata"))
 		goto out;
 
+	switch_ns_to_tx(&tok);
 	complete_tx(&tx_xsk);
 
+	/* Now check metadata of packet, generated with network stack */
+	if (!ASSERT_GE(generate_packet_inet(), 0, "generate UDP packet"))
+		goto out;
+
+	switch_ns_to_rx(&tok);
+
+	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, false), 0,
+		       "verify_xsk_metadata"))
+		goto out;
+
 	/* Make sure freplace correctly picks up original bound device
 	 * and doesn't crash.
 	 */
@@ -408,11 +481,15 @@ void test_xdp_metadata(void)
 	if (!ASSERT_OK(xdp_metadata2__attach(bpf_obj2), "attach freplace"))
 		goto out;
 
+	switch_ns_to_tx(&tok);
+
 	/* Send packet to trigger . */
 	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
 		       "generate freplace packet"))
 		goto out;
 
+	switch_ns_to_rx(&tok);
+
 	while (!retries--) {
 		if (bpf_obj2->bss->called)
 			break;
@@ -427,5 +504,6 @@ void test_xdp_metadata(void)
 	xdp_metadata__destroy(bpf_obj);
 	if (tok)
 		close_netns(tok);
-	SYS_NOFAIL("ip netns del xdp_metadata");
+	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
+	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
 }
-- 
2.41.0


