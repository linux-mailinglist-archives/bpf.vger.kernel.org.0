Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3963C87E
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 20:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiK2Tfk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 14:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiK2Tf1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 14:35:27 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E832B85
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:35:03 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x6-20020aa79a46000000b0057558a60f72so4384181pfj.15
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVTaBzzEQccyM/mxw7R704gPAXo7pWy8WQYRN5qCLic=;
        b=FEv1bLtZYziqSMcV+7llke6oVXcszGBh6JZtp6Gn3YCqgQ2OGQrcDq7hj+ZPS+eSsy
         QsjWcNFz6SelsvTJFdIeRIZTSXKTsu5LydlfgsQ/xtxYzXeb7SFDkDuEdkh879agMsg5
         AkMZxzzfiem4PWg/g3xMwov8nQ5BkO8DUeltHPX0ppTtazxSVcWCAdU6oq1cHhoVDgYr
         KcqorKQTrrx9LUYl6qnf4DdD3/iCvmnXq7c8UBiq+f14zCsXqF9fEd97vsvCqtqJHMUZ
         jUmP3rhpLBQv/GNsfCkvIhIGe1he4kICLqFaP2iw4xCYYB9XRuKYHDtqmVokDw570/Wf
         6+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVTaBzzEQccyM/mxw7R704gPAXo7pWy8WQYRN5qCLic=;
        b=ixsIe6wZMa+U5aC4WI8SXXqqfhbbwSZ3Q4jdFGnEq3BSxwy+38CTIkZV8fUxbOYdbk
         JIQzRafslACip3urQg9VmywJ+ShepZK3eG2Euc9wWjuOzJ5aQFxM2sUXSjmxQ9GyJCK0
         iOAtZevwAN+SlZ97Lym7MrqV+ivb3gJK+mAiDEqJmrPk+kLYxSzPbmSFiMv72AD4cEBS
         9kb0ToYmfso6y8WAQdZW2DfXxkdwwlG+W4CZk6TkEg5oHVC4CbrxmRe5KEQXFBEHMns3
         cBsmCUbp+maPMGVQAOS9OModITEfAU1J0zxh0h4J7QgGDzKrkjrxHxCOx8L895afD3bw
         W88w==
X-Gm-Message-State: ANoB5pn3eWPUERckkLod0nvn1VJ7nOrfbtJisjsUcEaz7gsoi+XAqywJ
        LEx8pGMvqTld9+josn+OvvO9j/iTX4O3yoUxmDj4FQkCAesZIacQA2LK5W6IOupQc0CqXwqa9GL
        Gr3czXHhti7vXYJx4Hp4RyXNryJQLtBO9dkWyUOLENR7PHUX1PQ==
X-Google-Smtp-Source: AA0mqf7wP1GfcEbjOJ/b/McgA93IAAbqqcTYEOPXOuo3OLgULJOuLetSsEFqV/vTFglhh1u0ZmmHiRs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:1ec2:0:b0:572:7b49:4f48 with SMTP id
 e185-20020a621ec2000000b005727b494f48mr39153864pfe.33.1669750502646; Tue, 29
 Nov 2022 11:35:02 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:34:46 -0800
In-Reply-To: <20221129193452.3448944-1-sdf@google.com>
Mime-Version: 1.0
References: <20221129193452.3448944-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129193452.3448944-6-sdf@google.com>
Subject: [PATCH bpf-next v3 05/11] selftests/bpf: Verify xdp_metadata
 xdp->af_xdp path
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

- create new netns
- create veth pair (veTX+veRX)
- setup AF_XDP socket for both interfaces
- attach bpf to veRX
- send packet via veTX
- verify the packet has expected metadata at veRX

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 365 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_metadata.c        |  57 +++
 tools/testing/selftests/bpf/xdp_metadata.h    |   7 +
 4 files changed, 430 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_metadata.c
 create mode 100644 tools/testing/selftests/bpf/xdp_metadata.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6a0f043dc410..4eed22fa3681 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -527,7 +527,7 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c
+			 cap_helpers.c xsk.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
new file mode 100644
index 000000000000..01035ff7d783
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "xdp_metadata.skel.h"
+#include "xdp_metadata.h"
+#include "xsk.h"
+
+#include <bpf/btf.h>
+#include <linux/errqueue.h>
+#include <linux/if_link.h>
+#include <linux/net_tstamp.h>
+#include <linux/udp.h>
+#include <sys/mman.h>
+#include <net/if.h>
+#include <poll.h>
+
+#define TX_NAME "veTX"
+#define RX_NAME "veRX"
+
+#define UDP_PAYLOAD_BYTES 4
+
+#define AF_XDP_SOURCE_PORT 1234
+#define AF_XDP_CONSUMER_PORT 8080
+
+#define UMEM_NUM 16
+#define UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
+#define UMEM_SIZE (UMEM_FRAME_SIZE * UMEM_NUM)
+#define XDP_FLAGS XDP_FLAGS_DRV_MODE
+#define QUEUE_ID 0
+
+#define TX_ADDR "10.0.0.1"
+#define RX_ADDR "10.0.0.2"
+#define PREFIX_LEN "8"
+#define FAMILY AF_INET
+
+#define SYS(cmd) ({ \
+	if (!ASSERT_OK(system(cmd), (cmd))) \
+		goto out; \
+})
+
+struct xsk {
+	void *umem_area;
+	struct xsk_umem *umem;
+	struct xsk_ring_prod fill;
+	struct xsk_ring_cons comp;
+	struct xsk_ring_prod tx;
+	struct xsk_ring_cons rx;
+	struct xsk_socket *socket;
+};
+
+static int open_xsk(const char *ifname, struct xsk *xsk)
+{
+	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
+	const struct xsk_socket_config socket_config = {
+		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.libbpf_flags = XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD,
+		.xdp_flags = XDP_FLAGS,
+		.bind_flags = XDP_COPY,
+	};
+	const struct xsk_umem_config umem_config = {
+		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
+		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
+		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
+	};
+	__u32 idx;
+	u64 addr;
+	int ret;
+	int i;
+
+	xsk->umem_area = mmap(NULL, UMEM_SIZE, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
+	if (!ASSERT_NEQ(xsk->umem_area, MAP_FAILED, "mmap"))
+		return -1;
+
+	ret = xsk_umem__create(&xsk->umem,
+			       xsk->umem_area, UMEM_SIZE,
+			       &xsk->fill,
+			       &xsk->comp,
+			       &umem_config);
+	if (!ASSERT_OK(ret, "xsk_umem__create"))
+		return ret;
+
+	ret = xsk_socket__create(&xsk->socket, ifname, QUEUE_ID,
+				 xsk->umem,
+				 &xsk->rx,
+				 &xsk->tx,
+				 &socket_config);
+	if (!ASSERT_OK(ret, "xsk_socket__create"))
+		return ret;
+
+	/* First half of umem is for TX. This way address matches 1-to-1
+	 * to the completion queue index.
+	 */
+
+	for (i = 0; i < UMEM_NUM / 2; i++) {
+		addr = i * UMEM_FRAME_SIZE;
+		printf("%p: tx_desc[%d] -> %lx\n", xsk, i, addr);
+	}
+
+	/* Second half of umem is for RX. */
+
+	ret = xsk_ring_prod__reserve(&xsk->fill, UMEM_NUM / 2, &idx);
+	if (!ASSERT_EQ(UMEM_NUM / 2, ret, "xsk_ring_prod__reserve"))
+		return ret;
+	if (!ASSERT_EQ(idx, 0, "fill idx != 0"))
+		return -1;
+
+	for (i = 0; i < UMEM_NUM / 2; i++) {
+		addr = (UMEM_NUM / 2 + i) * UMEM_FRAME_SIZE;
+		printf("%p: rx_desc[%d] -> %lx\n", xsk, i, addr);
+		*xsk_ring_prod__fill_addr(&xsk->fill, i) = addr;
+	}
+	xsk_ring_prod__submit(&xsk->fill, ret);
+
+	return 0;
+}
+
+static void close_xsk(struct xsk *xsk)
+{
+	if (xsk->umem)
+		xsk_umem__delete(xsk->umem);
+	if (xsk->socket)
+		xsk_socket__delete(xsk->socket);
+	munmap(xsk->umem, UMEM_SIZE);
+}
+
+static void ip_csum(struct iphdr *iph)
+{
+	__u32 sum = 0;
+	__u16 *p;
+	int i;
+
+	iph->check = 0;
+	p = (void *)iph;
+	for (i = 0; i < sizeof(*iph) / sizeof(*p); i++)
+		sum += p[i];
+
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+
+	iph->check = ~sum;
+}
+
+static int generate_packet(struct xsk *xsk, __u16 dst_port)
+{
+	struct xdp_desc *tx_desc;
+	struct udphdr *udph;
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	void *data;
+	__u32 idx;
+	int ret;
+
+	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
+	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
+		return -1;
+
+	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
+	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
+	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+
+	eth = data;
+	iph = (void *)(eth + 1);
+	udph = (void *)(iph + 1);
+
+	memcpy(eth->h_dest, "\x00\x00\x00\x00\x00\x02", ETH_ALEN);
+	memcpy(eth->h_source, "\x00\x00\x00\x00\x00\x01", ETH_ALEN);
+	eth->h_proto = htons(ETH_P_IP);
+
+	iph->version = 0x4;
+	iph->ihl = 0x5;
+	iph->tos = 0x9;
+	iph->tot_len = htons(sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES);
+	iph->id = 0;
+	iph->frag_off = 0;
+	iph->ttl = 0;
+	iph->protocol = IPPROTO_UDP;
+	ASSERT_EQ(inet_pton(FAMILY, TX_ADDR, &iph->saddr), 1, "inet_pton(TX_ADDR)");
+	ASSERT_EQ(inet_pton(FAMILY, RX_ADDR, &iph->daddr), 1, "inet_pton(RX_ADDR)");
+	ip_csum(iph);
+
+	udph->source = htons(AF_XDP_SOURCE_PORT);
+	udph->dest = htons(dst_port);
+	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
+	udph->check = 0;
+
+	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
+
+	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
+	xsk_ring_prod__submit(&xsk->tx, 1);
+
+	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
+	if (!ASSERT_GE(ret, 0, "sendto"))
+		return ret;
+
+	return 0;
+}
+
+static void complete_tx(struct xsk *xsk)
+{
+	__u32 idx;
+	__u64 addr;
+
+	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
+		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
+
+		printf("%p: refill idx=%u addr=%llx\n", xsk, idx, addr);
+		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
+		xsk_ring_prod__submit(&xsk->fill, 1);
+	}
+}
+
+static void refill_rx(struct xsk *xsk, __u64 addr)
+{
+	__u32 idx;
+
+	if (ASSERT_EQ(xsk_ring_prod__reserve(&xsk->fill, 1, &idx), 1, "xsk_ring_prod__reserve")) {
+		printf("%p: complete idx=%u addr=%llx\n", xsk, idx, addr);
+		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
+		xsk_ring_prod__submit(&xsk->fill, 1);
+	}
+}
+
+static int verify_xsk_metadata(struct xsk *xsk)
+{
+	const struct xdp_desc *rx_desc;
+	struct pollfd fds = {};
+	struct xdp_meta *meta;
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	__u64 comp_addr;
+	void *data;
+	__u64 addr;
+	__u32 idx;
+	int ret;
+
+	ret = recvfrom(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, NULL);
+	if (!ASSERT_EQ(ret, 0, "recvfrom"))
+		return -1;
+
+	fds.fd = xsk_socket__fd(xsk->socket);
+	fds.events = POLLIN;
+
+	ret = poll(&fds, 1, 1000);
+	if (!ASSERT_GT(ret, 0, "poll"))
+		return -1;
+
+	ret = xsk_ring_cons__peek(&xsk->rx, 1, &idx);
+	if (!ASSERT_EQ(ret, 1, "xsk_ring_cons__peek"))
+		return -2;
+
+	rx_desc = xsk_ring_cons__rx_desc(&xsk->rx, idx);
+	comp_addr = xsk_umem__extract_addr(rx_desc->addr);
+	addr = xsk_umem__add_offset_to_addr(rx_desc->addr);
+	printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx\n",
+	       xsk, idx, rx_desc->addr, addr, comp_addr);
+	data = xsk_umem__get_data(xsk->umem_area, addr);
+
+	/* Make sure we got the packet offset correctly. */
+
+	eth = data;
+	ASSERT_EQ(eth->h_proto, htons(ETH_P_IP), "eth->h_proto");
+	iph = (void *)(eth + 1);
+	ASSERT_EQ((int)iph->version, 4, "iph->version");
+
+	/* custom metadata */
+
+	meta = data - sizeof(struct xdp_meta);
+
+	if (!ASSERT_NEQ(meta->rx_timestamp, 0, "rx_timestamp"))
+		return -1;
+
+	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
+		return -1;
+
+	xsk_ring_cons__release(&xsk->rx, 1);
+	refill_rx(xsk, comp_addr);
+
+	return 0;
+}
+
+void test_xdp_metadata(void)
+{
+	struct xdp_metadata *bpf_obj = NULL;
+	struct nstoken *tok = NULL;
+	__u32 queue_id = QUEUE_ID;
+	struct bpf_program *prog;
+	struct xsk tx_xsk = {};
+	struct xsk rx_xsk = {};
+	int rx_ifindex;
+	int sock_fd;
+	int ret;
+
+	/* Setup new networking namespace, with a veth pair. */
+
+	SYS("ip netns add xdp_metadata");
+	tok = open_netns("xdp_metadata");
+	SYS("ip link add numtxqueues 1 numrxqueues 1 " TX_NAME
+	    " type veth peer " RX_NAME " numtxqueues 1 numrxqueues 1");
+	SYS("ip link set dev " TX_NAME " address 00:00:00:00:00:01");
+	SYS("ip link set dev " RX_NAME " address 00:00:00:00:00:02");
+	SYS("ip link set dev " TX_NAME " up");
+	SYS("ip link set dev " RX_NAME " up");
+	SYS("ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
+	SYS("ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
+
+	rx_ifindex = if_nametoindex(RX_NAME);
+
+	/* Setup separate AF_XDP for TX and RX interfaces. */
+
+	ret = open_xsk(TX_NAME, &tx_xsk);
+	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
+		goto out;
+
+	ret = open_xsk(RX_NAME, &rx_xsk);
+	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
+		goto out;
+
+	/* Attach BPF program to RX interface. */
+
+	bpf_obj = xdp_metadata__open();
+	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
+	bpf_program__set_ifindex(prog, rx_ifindex);
+	bpf_program__set_flags(prog, BPF_F_XDP_HAS_METADATA);
+
+	if (!ASSERT_OK(xdp_metadata__load(bpf_obj), "load skeleton"))
+		goto out;
+
+	ret = bpf_xdp_attach(rx_ifindex,
+			     bpf_program__fd(bpf_obj->progs.rx),
+			     XDP_FLAGS, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto out;
+
+	sock_fd = xsk_socket__fd(rx_xsk.socket);
+	ret = bpf_map_update_elem(bpf_map__fd(bpf_obj->maps.xsk), &queue_id, &sock_fd, 0);
+	if (!ASSERT_GE(ret, 0, "bpf_map_update_elem"))
+		goto out;
+
+	/* Send packet destined to RX AF_XDP socket. */
+	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
+		       "generate AF_XDP_CONSUMER_PORT"))
+		goto out;
+
+	/* Verify AF_XDP RX packet has proper metadata. */
+	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk), 0,
+		       "verify_xsk_metadata"))
+		goto out;
+
+	complete_tx(&tx_xsk);
+
+out:
+	close_xsk(&rx_xsk);
+	close_xsk(&tx_xsk);
+	if (bpf_obj)
+		xdp_metadata__destroy(bpf_obj);
+	system("ip netns del xdp_metadata");
+	if (tok)
+		close_netns(tok);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
new file mode 100644
index 000000000000..1b19a8d86efe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+
+#ifndef ETH_P_IP
+#define ETH_P_IP 0x0800
+#endif
+
+#include "xdp_metadata.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_XSKMAP);
+	__uint(max_entries, 4);
+	__type(key, __u32);
+	__type(value, __u32);
+} xsk SEC(".maps");
+
+extern bool bpf_xdp_metadata_rx_timestamp_supported(const struct xdp_md *ctx) __ksym;
+extern __u64 bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx) __ksym;
+extern bool bpf_xdp_metadata_rx_hash_supported(const struct xdp_md *ctx) __ksym;
+extern __u32 bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx) __ksym;
+
+SEC("xdp")
+int rx(struct xdp_md *ctx)
+{
+	void *data, *data_meta;
+	struct xdp_meta *meta;
+	int ret;
+
+	/* Reserve enough for all custom metadata. */
+
+	ret = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
+	if (ret != 0)
+		return XDP_DROP;
+
+	data = (void *)(long)ctx->data;
+	data_meta = (void *)(long)ctx->data_meta;
+
+	if (data_meta + sizeof(struct xdp_meta) > data)
+		return XDP_DROP;
+
+	meta = data_meta;
+
+	/* Export metadata. */
+
+	if (bpf_xdp_metadata_rx_timestamp_supported(ctx))
+		meta->rx_timestamp = bpf_xdp_metadata_rx_timestamp(ctx);
+
+	if (bpf_xdp_metadata_rx_hash_supported(ctx))
+		meta->rx_hash = bpf_xdp_metadata_rx_hash(ctx);
+
+	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
new file mode 100644
index 000000000000..c4892d122b7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+struct xdp_meta {
+	__u64 rx_timestamp;
+	__u32 rx_hash;
+};
-- 
2.38.1.584.g0f3c55d4c2-goog

