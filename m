Return-Path: <bpf+bounces-3911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A17746251
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29E81C20A09
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E1182B0;
	Mon,  3 Jul 2023 18:17:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26155182A3;
	Mon,  3 Jul 2023 18:17:41 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AD10C8;
	Mon,  3 Jul 2023 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688408253; x=1719944253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zGuBRGqVUn/Ih1JTspa/2oogfTUhqh3ZC/6qM9n/W04=;
  b=HJW1qzP6ofizmBYvmhEXWGcp/kzbOgi2ClTSnyi2bmTct91YUSS+hDQf
   p+xyy9sV325FZlTARtC6f+0vguCK/Dm4kwUkY0ALP//CdTa43yZwW9MH2
   NRv2DrhDn7u7MTeC7eONSZ1cu8UhrllRt0151hi4Idg0JDYPhm7PSz1+T
   yGmVpV7lyYNKxG0VHWC6ffIg70SlthoynDuOyAIA4gppRCBDHcxPaVFh2
   nwH+/i1YkYuT1nNTShgIvrjAeNZ9tP0SXTSR40XOzBn9lxxd6UKjtKoy0
   HfYzU9MKcDIqyuZJ2KSwHQw1y0pvsVX3spyl//mTJSoGJqS9PfmljWL+H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393682746"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393682746"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892615167"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="892615167"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 11:17:18 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 65D3135804;
	Mon,  3 Jul 2023 19:17:16 +0100 (IST)
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
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 18/20] selftests/bpf: Use AF_INET for TX in xdp_metadata
Date: Mon,  3 Jul 2023 20:12:24 +0200
Message-ID: <20230703181226.19380-19-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703181226.19380-1-larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The easiest way to simulate stripped VLAN tag in veth is to send a packet
from VLAN interface, attached to veth. Unfortunately, this approach is
incompatible with AF_XDP on TX side, because VLAN interfaces do not have
such feature.

Replace AF_XDP packet generation with sending the same datagram via
AF_INET socket.

This does not change the packet contents or hints values with one notable
exception: rx_hash_type, which previously was expected to be 0, now is
expected be at least XDP_RSS_TYPE_L4.

Also, usage of AF_INET requires a little more complicated namespace setup,
therefore open_netns() helper function is divided into smaller reusable
pieces.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/network_helpers.c |  37 +++-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 175 +++++++-----------
 3 files changed, 98 insertions(+), 117 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index a105c0cd008a..19463230ece5 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -386,28 +386,51 @@ char *ping_command(int family)
 	return "ping";
 }
 
+int get_cur_netns(void)
+{
+	int nsfd;
+
+	nsfd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
+	return nsfd;
+}
+
+int get_netns(const char *name)
+{
+	char nspath[PATH_MAX];
+	int nsfd;
+
+	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
+	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
+	return nsfd;
+}
+
+int set_netns(int netns_fd)
+{
+	return setns(netns_fd, CLONE_NEWNET);
+}
+
 struct nstoken {
 	int orig_netns_fd;
 };
 
 struct nstoken *open_netns(const char *name)
 {
+	struct nstoken *token;
 	int nsfd;
-	char nspath[PATH_MAX];
 	int err;
-	struct nstoken *token;
 
 	token = calloc(1, sizeof(struct nstoken));
 	if (!ASSERT_OK_PTR(token, "malloc token"))
 		return NULL;
 
-	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
+	token->orig_netns_fd = get_cur_netns();
+	if (token->orig_netns_fd < 0)
 		goto fail;
 
-	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
-	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
-	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
+	nsfd = get_netns(name);
+	if (nsfd < 0)
 		goto fail;
 
 	err = setns(nsfd, CLONE_NEWNET);
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 694185644da6..b18b9619595c 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -58,6 +58,8 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
 
+int get_cur_netns(void);
+int get_netns(const char *name);
 struct nstoken;
 /**
  * open_netns() - Switch to specified network namespace by name.
@@ -67,4 +69,5 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+int set_netns(int netns_fd);
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 626c461fa34d..53b32a641e8e 100644
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
@@ -281,40 +226,46 @@ void test_xdp_metadata(void)
 	struct xdp_metadata2 *bpf_obj2 = NULL;
 	struct xdp_metadata *bpf_obj = NULL;
 	struct bpf_program *new_prog, *prog;
-	struct nstoken *tok = NULL;
+	int prev_netns, rx_netns, tx_netns;
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
+	prev_netns = get_cur_netns();
+	tx_netns = get_netns(TX_NETNS_NAME);
+	rx_netns = get_netns(RX_NETNS_NAME);
+	if (prev_netns < 0 || tx_netns < 0 || rx_netns < 0)
+		goto close_ns;
+
+	set_netns(tx_netns);
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
 
+	/* Avoid ARP calls */
+	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
+
+	set_netns(rx_netns);
+	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
+	SYS(out, "ip link set dev " RX_NAME " up");
+	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
 	rx_ifindex = if_nametoindex(RX_NAME);
-	tx_ifindex = if_nametoindex(TX_NAME);
 
 	/* Setup separate AF_XDP for TX and RX interfaces. */
 
-	ret = open_xsk(tx_ifindex, &tx_xsk);
-	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
-		goto out;
-
 	ret = open_xsk(rx_ifindex, &rx_xsk);
 	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
 		goto out;
@@ -355,17 +306,16 @@ void test_xdp_metadata(void)
 		goto out;
 
 	/* Send packet destined to RX AF_XDP socket. */
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
-		       "generate AF_XDP_CONSUMER_PORT"))
+	set_netns(tx_netns);
+	if (!ASSERT_GE(generate_packet_udp(), 0, "generate UDP packet"))
 		goto out;
 
 	/* Verify AF_XDP RX packet has proper metadata. */
+	set_netns(rx_netns);
 	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk), 0,
 		       "verify_xsk_metadata"))
 		goto out;
 
-	complete_tx(&tx_xsk);
-
 	/* Make sure freplace correctly picks up original bound device
 	 * and doesn't crash.
 	 */
@@ -384,10 +334,11 @@ void test_xdp_metadata(void)
 		goto out;
 
 	/* Send packet to trigger . */
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
-		       "generate freplace packet"))
+	set_netns(tx_netns);
+	if (!ASSERT_GE(generate_packet_udp(), 0, "generate freplace packet"))
 		goto out;
 
+	set_netns(rx_netns);
 	while (!retries--) {
 		if (bpf_obj2->bss->called)
 			break;
@@ -397,10 +348,14 @@ void test_xdp_metadata(void)
 
 out:
 	close_xsk(&rx_xsk);
-	close_xsk(&tx_xsk);
 	xdp_metadata2__destroy(bpf_obj2);
 	xdp_metadata__destroy(bpf_obj);
-	if (tok)
-		close_netns(tok);
-	SYS_NOFAIL("ip netns del xdp_metadata");
+	set_netns(prev_netns);
+close_ns:
+	close(prev_netns);
+	close(tx_netns);
+	close(rx_netns);
+
+	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
+	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
 }
-- 
2.41.0


