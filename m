Return-Path: <bpf+bounces-11311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792157B7246
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2A202281B73
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A59B3E482;
	Tue,  3 Oct 2023 20:05:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825C3D3AC
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:45 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E61EB4
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:43 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5788445ac04so1035582a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363543; x=1696968343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGfPuUwgr0+ElclHHDmveyFqBwHJSTeVQksYF8EQp38=;
        b=CvufN88weFhPUfGk2ruY7ejEYmxnzBY211/oSKZg+Nk+xA+5WVX1Ir+QAtwTbIXzZI
         463961Az6GaY+Kfh0WCw6hKmEyRTyLqABbkOhqDq0CZ+3c38cyD6wtoV+YNZ6POk5zTH
         VImX/66Ktqgry7ganiS1fHULjiTdb/MymNg6ks8P2L04QMmO0nfgDDPSCXlI9aTyb39z
         9wyw418NSWp/EianF+xytArnvlVlpV+BuDRW9ZRmmRVEn/CTqGQlLnkovHzEk3O/DTcU
         +cYuvfocxG8y87R7OAcfqOLN6mvJECJ93HGrjEWCgV+jOmJ9sz4mOuYdic/eU87p9gCz
         gxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363543; x=1696968343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGfPuUwgr0+ElclHHDmveyFqBwHJSTeVQksYF8EQp38=;
        b=T9r7m9WWmoNR8eBWLGe536rhzIUZbdzKaxXwqo6mSsdT4mQPbUccSdas8Dc+MnWbGp
         tFv9w5LAj88do+At+mUKLVfRTxR4rF5MkWsHDGJ0tyd8YaoQpa8eXAEXA5lUxwbNoZPN
         43OPy3WqLUBSF4MB90CyTw1BDgkECm/n6S14xzrmH5Eqk1ESUw5TzYC7tVfm2eJyULvR
         xGy6l1bttmC+NQ6XazENPjLUlYovD5qWfpegGyphDL5QhVvWY4pf3QgC0Vup9Z0fJ99b
         reTlmRrVHn62zBtfnpGksIpoxVNgt5JXQ+5BtkpgyNIMVNBt0jA+5LvEKFP3uMgAw2wf
         p8aA==
X-Gm-Message-State: AOJu0YwomHhYqCDr4HOYhbJ9c5ya2P6mh+qQdqOqtqfJaYegdFvZ3KPd
	f0N6SVMkn74T/qKx/LnEYP876BGTx3zsRCoCvdmSxN+dPH0eW44zvD60bzan5y3ZnKfu963RueB
	B3snyRg/mJzv/N/3HE1Gs05tLdIw8Pk8qkzEd2zccj3x8+LPymA==
X-Google-Smtp-Source: AGHT+IGNhNO9FoH7l0YKdnmEToEAgoE8RDMFOanuVgcfdsvb4m3lNNG2IJdzmKtY6CR6pTUrMQQ5LYY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6d48:0:b0:57c:856a:5010 with SMTP id
 i69-20020a636d48000000b0057c856a5010mr2389pgc.10.1696363541940; Tue, 03 Oct
 2023 13:05:41 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:21 -0700
In-Reply-To: <20231003200522.1914523-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-10-sdf@google.com>
Subject: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to xdp_hw_metadata
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
2.42.0.582.g8ccd20d70d-goog


