Return-Path: <bpf+bounces-4489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FAD74B73B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311A6281925
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0E718AFF;
	Fri,  7 Jul 2023 19:30:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCB18AF0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:43 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CC02D66
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573d70da2dcso24756777b3.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758234; x=1691350234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ9AaI5NbcA/oN/ecuTimulSkDUKAiNeCXSYKFyoRpE=;
        b=pslXxhAl7Db8eW1923SaM9dPTzDYvuWeKvr+XMkN2/fSIGzCIQaX7EojfQQmY3p37L
         iBcy1ejUEDWx0nH5eChAogJGsfgH9/6u/0Qzcz9G1Bk9OqD0O08KxlS5V09XUJJfSbDg
         651PYELf0ontFLIypcuyrf0oDvjHdX/LDo7/QxTAgtRju/Zy8fjvM+Tdab8MisY9dSMn
         tif63CoWcqNVOkrlnz+yOo3rMn7XeXAi4WyA2xmxrbutPrbQWJcp9FhOYm/Vox7QPYXL
         uewRrYlkq0SmpbixuNV45nSeiRqmOxjuR9J+LFt6EFmrCLjD+eXVSbcFtQIyNR0wb56t
         DSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758234; x=1691350234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ9AaI5NbcA/oN/ecuTimulSkDUKAiNeCXSYKFyoRpE=;
        b=l5zaxRV4bEv4ALBQ12WXZvMMNbAZuYZqv09u5QuLP5UjU637c6ElQjUvsq/fEL9WIv
         Ge8Ru3hVDDA5skGjAnV1FSVimXM/tPnFNjFYpBY8N4srRR6jGbRNT9uL+CCi05Zau9ZE
         1uoXfEq36CcAv13cSRVeLE/x7L1oBX0qa1nF02CHS1ax0IhnkcdnynjvCigUgarFZUhv
         GGNyCMqwiIc4bES14YD2sCScY9MMfPN1UBsjZMjvJTjDhDYAmhgVz+c+Kt5IhFpuo5gU
         u9K82QSgsqgcePaXekgj4tuuqwCuaqZWMG72TKa67DqwQLCYIPekAOhQCujSWJPfG5Si
         iWtw==
X-Gm-Message-State: ABy/qLYFREtd/RNtCcFbwI8phG5l81NmXwrxS5IW7UROHBRkVwYA3jKS
	NMM1lREkeY7tSIBT44voKmTCKooDaPzw+t0x3wbBOEFOq3vT2BQuMWToeUm07CpI+jbUgG3+SEY
	5I19xN9WAJkbfRKvWqwsFWK0nzjc9HFVOWXgW8wakELDyt5AAzA==
X-Google-Smtp-Source: APBJJlGLjtZ1dAHoOjapPUfeQVnKhDOKJVvr+sIHAeYapEY5d0/pspClotBqzxOvQA7fjJhAoYM1KDw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:d305:0:b0:56d:2a88:49e5 with SMTP id
 y5-20020a81d305000000b0056d2a8849e5mr41186ywi.2.1688758233839; Fri, 07 Jul
 2023 12:30:33 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:30:06 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-15-sdf@google.com>
Subject: [RFC bpf-next v3 14/14] selftests/bpf: Extend xdp_hw_metadata with
 devtx kfuncs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we get packets on port 9091, we swap src/dst and send it out.
At this point, we also request the timestamp and plumb it back
to the userspace. The userspace simply prints the timestamp.

Also print current UDP checksum, rewrite it with the pseudo-header
checksum and offload TX checksum calculation to devtx. Upon
completion, report TX checksum back (mlx5 doesn't put it back, so
I've used tcpdump to confirm that the checksum is correct).

Some other related changes:
- switched to zerocopy mode by default; new flag can be used to force
  old behavior
- request fixed TX_METADAT_LEN headroom
- some other small fixes (umem size, fill idx+i, etc)

mvbz3:~# ./xdp_hw_metadata eth3 -c mlx5e_devtx_complete_xdp -s mlx5e_devtx_submit_xd
attach rx bpf program...
poll: 0 (0) skip=1/0 redir=0 ring_full=0 rx_fail=0 tx_fail=0 l4_csum_fail=0
...
xsk_ring_cons__peek: 1
0xeb4cb8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
rx_hash: 0x6A1A897A with RSS type:0x2A
rx_timestamp:  1688749963628930772 (sec:1688749963.6289)
XDP RX-time:   1688749963901850574 (sec:1688749963.9019) delta sec:0.2729 (272919.802 usec)
AF_XDP time:   1688749963901967812 (sec:1688749963.9020) delta sec:0.0001 (117.238 usec)
0xeb4cb8: ping_pong with csum=8e3b (want 4b0b)
0xeb4cb8: complete tx idx=0 addr=8
got tx sample: tx_err 0 hw_timestamp 1688749963859814790 sw_timestamp 1688749963902297286 csum 8e3b
0xeb4cb8: complete rx idx=128 addr=80100
poll: 0 (0) skip=7/0 redir=1 ring_full=0 rx_fail=0 tx_fail=0 l4_csum_fail=0

mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091

mvbz4:~# tcpdump -vvx -i eth3 udp
tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
10:12:43.901436 IP6 (flowlabel 0x7a5d2, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1087.44339 > fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0x0b4b!] UDP, length 3
        0x0000:  6007 a5d2 000b 117f fe80 0000 0000 0000
        0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
        0x0020:  1270 fdff fe48 1077 ad33 2383 000b 3b8e
        0x0030:  7864 70
10:12:43.902125 IP6 (flowlabel 0x7a5d2, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.44339: [udp sum ok] UDP, length 3
        0x0000:  6007 a5d2 000b 117f fe80 0000 0000 0000
        0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
        0x0020:  1270 fdff fe48 1087 2383 ad33 000b 0b4b
        0x0030:  7864 70

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 173 +++++++++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 269 +++++++++++++++++-
 2 files changed, 427 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index b2dfd7066c6e..2049bfa70ea9 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -4,6 +4,7 @@
 #include "xdp_metadata.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
 
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
@@ -12,14 +13,30 @@ struct {
 	__type(value, __u32);
 } xsk SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} tx_compl_buf SEC(".maps");
+
 __u64 pkts_skip = 0;
+__u64 pkts_tx_skip = 0;
 __u64 pkts_fail = 0;
 __u64 pkts_redir = 0;
+__u64 pkts_fail_tx = 0;
+__u64 pkts_fail_l4_csum = 0;
+__u64 pkts_ringbuf_full = 0;
+
+int ifindex = -1;
+__u64 net_cookie = -1;
 
 extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_devtx_request_tx_timestamp(const struct devtx_ctx *ctx) __ksym;
+extern int bpf_devtx_tx_timestamp(const struct devtx_ctx *ctx, __u64 *timestamp) __ksym;
+extern int bpf_devtx_request_l4_csum(const struct devtx_ctx *ctx,
+				     u16 csum_start, u16 csum_offset) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -90,4 +107,160 @@ int rx(struct xdp_md *ctx)
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
+/* This is not strictly required; only to showcase how to access the payload. */
+static __always_inline bool tx_filter(const struct devtx_ctx *devtx,
+				      const void *data, __be16 *proto)
+{
+	int port_offset = sizeof(struct ethhdr) + offsetof(struct udphdr, source);
+	struct ethhdr eth = {};
+	struct udphdr udp = {};
+
+	bpf_probe_read_kernel(&eth.h_proto, sizeof(eth.h_proto),
+			      data + offsetof(struct ethhdr, h_proto));
+
+	*proto = eth.h_proto;
+	if (eth.h_proto == bpf_htons(ETH_P_IP)) {
+		port_offset += sizeof(struct iphdr);
+	} else if (eth.h_proto == bpf_htons(ETH_P_IPV6)) {
+		port_offset += sizeof(struct ipv6hdr);
+	} else {
+		__sync_add_and_fetch(&pkts_tx_skip, 1);
+		return false;
+	}
+
+	bpf_probe_read_kernel(&udp.source, sizeof(udp.source), data + port_offset);
+
+	/* Replies to UDP:9091 */
+	if (udp.source != bpf_htons(9091)) {
+		__sync_add_and_fetch(&pkts_tx_skip, 1);
+		return false;
+	}
+
+	return true;
+}
+
+static inline bool my_netdev(const struct devtx_ctx *devtx)
+{
+	static struct net_device *netdev;
+
+	if (netdev)
+		return netdev == devtx->netdev;
+
+	if (devtx->netdev->ifindex != ifindex)
+		return false;
+	if (devtx->netdev->nd_net.net->net_cookie != net_cookie)
+		return false;
+
+	netdev = devtx->netdev;
+	return true;
+}
+
+static inline int udpoff(__be16 proto)
+{
+	if (proto == bpf_htons(ETH_P_IP))
+		return sizeof(struct ethhdr) + sizeof(struct iphdr);
+	else if (proto == bpf_htons(ETH_P_IPV6))
+		return sizeof(struct ethhdr) + sizeof(struct ipv6hdr);
+	else
+		return 0;
+}
+
+static inline int tx_submit(const struct devtx_ctx *devtx, const void *data, u8 meta_len)
+{
+	struct xdp_tx_meta meta = {};
+	__be16 proto = 0;
+	int off, ret;
+
+	if (!my_netdev(devtx))
+		return 0;
+	if (meta_len != TX_META_LEN)
+		return 0;
+
+	bpf_probe_read_kernel(&meta, sizeof(meta), data - TX_META_LEN);
+	if (!meta.request_timestamp)
+		return 0;
+
+	if (!tx_filter(devtx, data, &proto))
+		return 0;
+
+	ret = bpf_devtx_request_tx_timestamp(devtx);
+	if (ret < 0)
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+
+	off = udpoff(proto);
+	if (!off)
+		return 0;
+
+	ret = bpf_devtx_request_l4_csum(devtx, off, off + offsetof(struct udphdr, check));
+	if (ret < 0)
+		__sync_add_and_fetch(&pkts_fail_l4_csum, 1);
+
+	return 0;
+}
+
+SEC("?fentry")
+int BPF_PROG(tx_submit_xdp, const struct devtx_ctx *devtx, const struct xdp_frame *xdpf)
+{
+	return tx_submit(devtx, xdpf->data, xdpf->metasize);
+}
+
+SEC("?fentry")
+int BPF_PROG(tx_submit_skb, const struct devtx_ctx *devtx, const struct sk_buff *skb)
+{
+	return tx_submit(devtx, skb->data, devtx->sinfo->meta_len);
+}
+
+static inline int tx_complete(const struct devtx_ctx *devtx, const void *data, u8 meta_len)
+{
+	struct xdp_tx_meta meta = {};
+	struct devtx_sample *sample;
+	struct udphdr udph;
+	__be16 proto = 0;
+	int off;
+
+	if (!my_netdev(devtx))
+		return 0;
+	if (meta_len != TX_META_LEN)
+		return 0;
+
+	bpf_probe_read_kernel(&meta, sizeof(meta), data - TX_META_LEN);
+	if (!meta.request_timestamp)
+		return 0;
+
+	if (!tx_filter(devtx, data, &proto))
+		return 0;
+
+	off = udpoff(proto);
+	if (!off)
+		return 0;
+
+	bpf_probe_read_kernel(&udph, sizeof(udph), data + off);
+
+	sample = bpf_ringbuf_reserve(&tx_compl_buf, sizeof(*sample), 0);
+	if (!sample) {
+		__sync_add_and_fetch(&pkts_ringbuf_full, 1);
+		return 0;
+	}
+
+	sample->timestamp_retval = bpf_devtx_tx_timestamp(devtx, &sample->hw_timestamp);
+	sample->sw_complete_timestamp = bpf_ktime_get_tai_ns();
+	sample->tx_csum = udph.check;
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
+
+SEC("?fentry")
+int BPF_PROG(tx_complete_xdp, const struct devtx_ctx *devtx, const struct xdp_frame *xdpf)
+{
+	return tx_complete(devtx, xdpf->data, xdpf->metasize);
+}
+
+SEC("?fentry")
+int BPF_PROG(tx_complete_skb, const struct devtx_ctx *devtx, const struct sk_buff *skb)
+{
+	return tx_complete(devtx, skb->data, devtx->sinfo->meta_len);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..3f9c47ad5cfa 100644
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
@@ -28,10 +30,12 @@
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
@@ -49,24 +53,27 @@ struct xsk {
 struct xdp_hw_metadata *bpf_obj;
 struct xsk *rx_xsk;
 const char *ifname;
+char *tx_complete;
+char *tx_submit;
 int ifindex;
 int rxq;
 
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
+		.tx_metadata_len = TX_META_LEN,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
+		.flags = XSK_UMEM__DEFAULT_FLAGS,
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
@@ -228,7 +245,102 @@ static void verify_skb_metadata(int fd)
 	printf("skb hwtstamp is not found!\n");
 }
 
-static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id)
+static bool complete_tx(struct xsk *xsk, struct ring_buffer *ringbuf)
+{
+	__u32 idx;
+	__u64 addr;
+
+	if (!xsk_ring_cons__peek(&xsk->comp, 1, &idx))
+		return false;
+
+	addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
+
+	printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
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
+	struct ipv6hdr *ip6h = NULL;
+	struct iphdr *iph = NULL;
+	struct xdp_tx_meta *meta;
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
+	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + TX_META_LEN;
+	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+
+	meta = data - TX_META_LEN;
+	meta->request_timestamp = 1;
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
+	if (iph)
+		udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+						 ntohs(udph->len), IPPROTO_UDP, 0);
+	else
+		udph->check = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
+					       ntohs(udph->len), IPPROTO_UDP, 0);
+
+	printf("%p: ping-pong with csum=%04x (want %04x)\n", xsk, udph->check, want_csum);
+
+	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
+	tx_desc->len = len;
+
+	xsk_ring_prod__submit(&xsk->tx, 1);
+}
+
+static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id,
+			   struct ring_buffer *ringbuf)
 {
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds[rxq + 1];
@@ -250,10 +362,22 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 
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
-		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
+		printf("poll: %d (%d) skip=%llu/%llu redir=%llu ring_full=%llu rx_fail=%llu tx_fail=%llu l4_csum_fail=%llu\n",
 		       ret, errno, bpf_obj->bss->pkts_skip,
-		       bpf_obj->bss->pkts_fail, bpf_obj->bss->pkts_redir);
+		       bpf_obj->bss->pkts_tx_skip,
+		       bpf_obj->bss->pkts_redir,
+		       bpf_obj->bss->pkts_ringbuf_full,
+		       bpf_obj->bss->pkts_fail,
+		       bpf_obj->bss->pkts_fail_tx,
+		       bpf_obj->bss->pkts_fail_l4_csum);
 		if (ret < 0)
 			break;
 		if (ret == 0)
@@ -280,6 +404,24 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 			       xsk, idx, rx_desc->addr, addr, comp_addr);
 			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
 					    clock_id);
+
+			if (tx_submit && tx_complete) {
+				/* mirror the packet back */
+				ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr));
+
+				ret = kick_tx(xsk);
+				if (ret)
+					printf("kick_tx ret=%d\n", ret);
+
+				for (int j = 0; j < 500; j++) {
+					if (complete_tx(xsk, ringbuf))
+						break;
+					usleep(10*1000);
+				}
+
+				ring_buffer__poll(ringbuf, 1000);
+			}
+
 			xsk_ring_cons__release(&xsk->rx, 1);
 			refill_rx(xsk, comp_addr);
 		}
@@ -404,21 +546,69 @@ static void timestamping_enable(int fd, int val)
 		error(1, errno, "setsockopt(SO_TIMESTAMPING)");
 }
 
+static int process_sample(void *ctx, void *data, size_t len)
+{
+	struct devtx_sample *sample = data;
+
+	printf("got tx sample: tx_err %u hw_timestamp %llu sw_timestamp %llu csum %04x\n",
+	       sample->timestamp_retval, sample->hw_timestamp,
+	       sample->sw_complete_timestamp,
+	       sample->tx_csum);
+
+	return 0;
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s [OPTS] <ifname>\n"
+		"OPTS:\n"
+		"    -s    symbol name for tx_submit\n"
+		"    -c    symbol name for tx_complete\n"
+		"    -Z    run in copy mode\n",
+		prog);
+}
+
 int main(int argc, char *argv[])
 {
+	int bind_flags =  XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
+	struct ring_buffer *tx_compl_ringbuf = NULL;
 	clockid_t clock_id = CLOCK_TAI;
 	int server_fd = -1;
+	int opt;
 	int ret;
 	int i;
 
 	struct bpf_program *prog;
 
-	if (argc != 2) {
+	while ((opt = getopt(argc, argv, "s:c:Z")) != -1) {
+		switch (opt) {
+		case 's':
+			tx_submit = optarg;
+			break;
+		case 'c':
+			tx_complete = optarg;
+			break;
+		case 'Z':
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
 
@@ -432,7 +622,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < rxq; i++) {
 		printf("open_xsk(%s, %p, %d)\n", ifname, &rx_xsk[i], i);
-		ret = open_xsk(ifindex, &rx_xsk[i], i);
+		ret = open_xsk(ifindex, &rx_xsk[i], i, bind_flags);
 		if (ret)
 			error(1, -ret, "open_xsk");
 
@@ -444,15 +634,64 @@ int main(int argc, char *argv[])
 	if (libbpf_get_error(bpf_obj))
 		error(1, libbpf_get_error(bpf_obj), "xdp_hw_metadata__open");
 
+	bpf_obj->data->ifindex = ifindex;
+	bpf_obj->data->net_cookie = get_net_cookie();
+
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, ifindex);
 	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
+	prog = bpf_object__find_program_by_name(bpf_obj->obj,
+						bind_flags & XDP_COPY ?
+						"tx_submit_skb" :
+						"tx_submit_xdp");
+	bpf_program__set_ifindex(prog, ifindex);
+	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	if (tx_submit) {
+		printf("attaching devtx submit program to %s\n", tx_submit);
+		ret = bpf_program__set_attach_target(prog, 0, tx_submit);
+		if (ret)
+			printf("failed to attach submit program to %s, ret=%d\n",
+			       tx_submit, ret);
+		bpf_program__set_autoattach(prog, true);
+		bpf_program__set_autoload(prog, true);
+	} else {
+		printf("skipping devtx submit program\n");
+	}
+
+	prog = bpf_object__find_program_by_name(bpf_obj->obj,
+						bind_flags & XDP_COPY ?
+						"tx_complete_skb" :
+						"tx_complete_xdp");
+	bpf_program__set_ifindex(prog, ifindex);
+	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	if (tx_complete) {
+		printf("attaching devtx complete program to %s\n", tx_complete);
+		ret = bpf_program__set_attach_target(prog, 0, tx_complete);
+		if (ret)
+			printf("failed to attach complete program to %s, ret=%d\n",
+			       tx_complete, ret);
+		bpf_program__set_autoattach(prog, true);
+		bpf_program__set_autoload(prog, true);
+	} else {
+		printf("skipping devtx complete program\n");
+	}
+
 	printf("load bpf program...\n");
 	ret = xdp_hw_metadata__load(bpf_obj);
 	if (ret)
 		error(1, -ret, "xdp_hw_metadata__load");
 
+	printf("attach devts bpf programs...\n");
+	ret = xdp_hw_metadata__attach(bpf_obj);
+	if (ret)
+		error(1, -ret, "xdp_hw_metadata__attach");
+
+	tx_compl_ringbuf = ring_buffer__new(bpf_map__fd(bpf_obj->maps.tx_compl_buf),
+					    process_sample, NULL, NULL);
+	if (libbpf_get_error(tx_compl_ringbuf))
+		error(1, -libbpf_get_error(tx_compl_ringbuf), "ring_buffer__new");
+
 	printf("prepare skb endpoint...\n");
 	server_fd = start_server(AF_INET6, SOCK_DGRAM, NULL, 9092, 1000);
 	if (server_fd < 0)
@@ -472,7 +711,7 @@ int main(int argc, char *argv[])
 			error(1, -ret, "bpf_map_update_elem");
 	}
 
-	printf("attach bpf program...\n");
+	printf("attach rx bpf program...\n");
 	ret = bpf_xdp_attach(ifindex,
 			     bpf_program__fd(bpf_obj->progs.rx),
 			     XDP_FLAGS, NULL);
@@ -480,7 +719,7 @@ int main(int argc, char *argv[])
 		error(1, -ret, "bpf_xdp_attach");
 
 	signal(SIGINT, handle_signal);
-	ret = verify_metadata(rx_xsk, rxq, server_fd, clock_id);
+	ret = verify_metadata(rx_xsk, rxq, server_fd, clock_id, tx_compl_ringbuf);
 	close(server_fd);
 	cleanup();
 	if (ret)
-- 
2.41.0.255.g8b1d071c50-goog


