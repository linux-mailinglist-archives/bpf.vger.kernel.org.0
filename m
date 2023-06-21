Return-Path: <bpf+bounces-3057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F9A738CAB
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE47B2816FA
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B21B91E;
	Wed, 21 Jun 2023 17:03:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907419935
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:03:06 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF2120
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-570553a18deso85885117b3.2
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366984; x=1689958984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8agh8JqEdvNU3UHvadoBRqAaekfLA9306UePh3v55SI=;
        b=byWwJVeTVryhCx3j+k5EiX1zDwGl6dx1QXr7yMStP8TaW0PHyQT/VSdXE5XoITg7K9
         KnPaTDbtnnb/9QMPZnsYkmctzfV9J15pGTL91txZulHWHL8hcpTMlKL1J1zEacAi//tm
         JfQ3sPuJ8Yo8HarFSKo2bmW4Ux4zdQt/whNZlxpMSCSk5MeFVTMmMjSZNZsaZo/etj/a
         +lnEQxnLLzSuNsjAIod9GBoL9/8L7FVTvktLSkk1KXm7hR0kpmvASrH/+CEgAII8Bn4f
         cUHsEETT6ubH/MBTBFrGuJM3M2DCOBVzK9ZHM1wkst1i9OQLeVZnVZHjjHEpCXPiVcLS
         Hm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366984; x=1689958984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8agh8JqEdvNU3UHvadoBRqAaekfLA9306UePh3v55SI=;
        b=GKPaqhtXzuI0W+ZFrscZbs3P/TkQyRX6UstSbqdSplL05Ddv3mQ6cQjowcG+kOOwKa
         c5gb2s55aBzGA+4IrBfJA0u5MMLJLLd2515hHspPijOZwMIl8qLaWL2h9rbYGgNcvCVQ
         WDM5P3sTTmqdlzsk2BgWAziJyPb7Vpjl6XfkbfDoE8mki1q1iJDT3aBEl8tHOLqTTRr5
         xSORB08LDojYlK3X3FULICp4U2J/62ULYrp2vpg0/0DDh+oBRvBojMrkAI6FKZOJnudL
         gzruEmGJl4BGlU/VguBG1w8cAflHespYUKZPlHo6EVWnRKzHVHBnouEMBkklUG3JQdPs
         Kc+w==
X-Gm-Message-State: AC+VfDyah6k4dy7EJeoZkxlPGJTKKCEkDfOh+FxBxkwj3umfrIU2zd0v
	WrcyZxJe3Dr/cCiDN0Vqz02ryvGAD8TBb7Hm7QWI1/IboP+runWYbrJ0x+osGjDJjIhZp+Y5pXi
	3n1uLXrKJt/s/kdp/StVemztpAK5prnSDOS+cdO3jj4Hya7LMAw==
X-Google-Smtp-Source: ACHHUZ6271UlFgq363ZV7qkRhWhv7ST2ptldt76s4nWKMP7suM4OwuBEqIYIU3dPNlajJ+koaK5rEWw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ae1f:0:b0:56f:f77c:3c7d with SMTP id
 m31-20020a81ae1f000000b0056ff77c3c7dmr6681623ywh.3.1687366983966; Wed, 21 Jun
 2023 10:03:03 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:43 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-11-sdf@google.com>
Subject: [RFC bpf-next v2 10/11] selftests/bpf: Extend xdp_hw_metadata with
 devtx kfuncs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we get packets on port 9091, we swap src/dst and send it out.
At this point, we also request the timestamp and plumb it back
to the userspace. The userspace simply prints the timestamp.

Haven't really tested, still working on mlx5 patches...

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 107 ++++++++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 198 ++++++++++++++++--
 2 files changed, 285 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index b2dfd7066c6e..84f10d6b11f1 100644
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
+	__uint(max_entries, 10);
+} tx_compl_buf SEC(".maps");
+
 __u64 pkts_skip = 0;
+__u64 pkts_tx_skip = 0;
 __u64 pkts_fail = 0;
 __u64 pkts_redir = 0;
+__u64 pkts_fail_tx = 0;
+__u64 pkts_ringbuf_full = 0;
+
+int ifindex = -1;
+__u64 net_cookie = -1;
 
 extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_devtx_sb_request_timestamp(const struct devtx_frame *ctx) __ksym;
+extern int bpf_devtx_cp_timestamp(const struct devtx_frame *ctx, __u64 *timestamp) __ksym;
+
+extern int bpf_devtx_sb_attach(int ifindex, int prog_fd) __ksym;
+extern int bpf_devtx_cp_attach(int ifindex, int prog_fd) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -90,4 +107,94 @@ int rx(struct xdp_md *ctx)
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
+/* This is not strictly required; only to showcase how to access the payload. */
+static __always_inline bool tx_filter(const struct devtx_frame *frame)
+{
+	int port_offset = sizeof(struct ethhdr) + offsetof(struct udphdr, source);
+	struct ethhdr eth = {};
+	struct udphdr udp = {};
+
+	bpf_probe_read_kernel(&eth.h_proto, sizeof(eth.h_proto),
+			      frame->data + offsetof(struct ethhdr, h_proto));
+
+	if (eth.h_proto == bpf_htons(ETH_P_IP)) {
+		port_offset += sizeof(struct iphdr);
+	} else if (eth.h_proto == bpf_htons(ETH_P_IPV6)) {
+		port_offset += sizeof(struct ipv6hdr);
+	} else {
+		__sync_add_and_fetch(&pkts_tx_skip, 1);
+		return false;
+	}
+
+	bpf_probe_read_kernel(&udp.source, sizeof(udp.source), frame->data + port_offset);
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
+SEC("fentry")
+int BPF_PROG(tx_submit, const struct devtx_frame *frame)
+{
+	struct xdp_tx_meta meta = {};
+	int ret;
+
+	if (frame->netdev->ifindex != ifindex)
+		return 0;
+	if (frame->netdev->nd_net.net->net_cookie != net_cookie)
+		return 0;
+	if (frame->meta_len != TX_META_LEN)
+		return 0;
+
+	bpf_probe_read_kernel(&meta, sizeof(meta), frame->data - TX_META_LEN);
+	if (!meta.request_timestamp)
+		return 0;
+
+	if (!tx_filter(frame))
+		return 0;
+
+	ret = bpf_devtx_sb_request_timestamp(frame);
+	if (ret < 0)
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+
+	return 0;
+}
+
+SEC("fentry")
+int BPF_PROG(tx_complete, const struct devtx_frame *frame)
+{
+	struct xdp_tx_meta meta = {};
+	struct devtx_sample *sample;
+
+	if (frame->netdev->ifindex != ifindex)
+		return 0;
+	if (frame->netdev->nd_net.net->net_cookie != net_cookie)
+		return 0;
+	if (frame->meta_len != TX_META_LEN)
+		return 0;
+
+	bpf_probe_read_kernel(&meta, sizeof(meta), frame->data - TX_META_LEN);
+	if (!meta.request_timestamp)
+		return 0;
+
+	if (!tx_filter(frame))
+		return 0;
+
+	sample = bpf_ringbuf_reserve(&tx_compl_buf, sizeof(*sample), 0);
+	if (!sample) {
+		__sync_add_and_fetch(&pkts_ringbuf_full, 1);
+		return 0;
+	}
+
+	sample->timestamp_retval = bpf_devtx_cp_timestamp(frame, &sample->timestamp);
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..0bbe8377a34b 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -10,7 +10,8 @@
  *   - rx_hash
  *
  * TX:
- * - TBD
+ * - UDP 9091 packets trigger TX reply
+ * - TX HW timestamp is requested and reported back upon completion
  */
 
 #include <test_progs.h>
@@ -28,6 +29,8 @@
 #include <net/if.h>
 #include <poll.h>
 #include <time.h>
+#include <unistd.h>
+#include <libgen.h>
 
 #include "xdp_metadata.h"
 
@@ -54,13 +57,14 @@ int rxq;
 
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
@@ -228,7 +232,87 @@ static void verify_skb_metadata(int fd)
 	printf("skb hwtstamp is not found!\n");
 }
 
-static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id)
+static void complete_tx(struct xsk *xsk, struct ring_buffer *ringbuf)
+{
+	__u32 idx;
+	__u64 addr;
+
+	ring_buffer__poll(ringbuf, 1000);
+
+	if (xsk_ring_cons__peek(&xsk->comp, 1, &idx)) {
+		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
+
+		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
+		xsk_ring_cons__release(&xsk->comp, 1);
+	}
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
+	eth = data;
+
+	if (eth->h_proto == htons(ETH_P_IP)) {
+		iph = (void *)(eth + 1);
+		udph = (void *)(iph + 1);
+	} else if (eth->h_proto == htons(ETH_P_IPV6)) {
+		ip6h = (void *)(eth + 1);
+		udph = (void *)(ip6h + 1);
+	} else {
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
+	memcpy(data, rx_packet, len);
+	swap(eth->h_dest, eth->h_source, ETH_ALEN);
+	if (iph)
+		swap(&iph->saddr, &iph->daddr, 4);
+	else
+		swap(&ip6h->saddr, &ip6h->daddr, 16);
+	swap(&udph->source, &udph->dest, 2);
+
+	xsk_ring_prod__submit(&xsk->tx, 1);
+}
+
+static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id,
+			   struct ring_buffer *ringbuf)
 {
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds[rxq + 1];
@@ -251,8 +335,9 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 	while (true) {
 		errno = 0;
 		ret = poll(fds, rxq + 1, 1000);
-		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
+		printf("poll: %d (%d) skip=%llu/%llu fail=%llu redir=%llu\n",
 		       ret, errno, bpf_obj->bss->pkts_skip,
+		       bpf_obj->bss->pkts_tx_skip,
 		       bpf_obj->bss->pkts_fail, bpf_obj->bss->pkts_redir);
 		if (ret < 0)
 			break;
@@ -280,6 +365,11 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 			       xsk, idx, rx_desc->addr, addr, comp_addr);
 			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
 					    clock_id);
+
+			/* mirror packet back */
+			ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr));
+			complete_tx(xsk, ringbuf);
+
 			xsk_ring_cons__release(&xsk->rx, 1);
 			refill_rx(xsk, comp_addr);
 		}
@@ -373,16 +463,6 @@ static void cleanup(void)
 	int ret;
 	int i;
 
-	if (bpf_obj) {
-		opts.old_prog_fd = bpf_program__fd(bpf_obj->progs.rx);
-		if (opts.old_prog_fd >= 0) {
-			printf("detaching bpf program....\n");
-			ret = bpf_xdp_detach(ifindex, XDP_FLAGS, &opts);
-			if (ret)
-				printf("failed to detach XDP program: %d\n", ret);
-		}
-	}
-
 	for (i = 0; i < rxq; i++)
 		close_xsk(&rx_xsk[i]);
 
@@ -404,21 +484,69 @@ static void timestamping_enable(int fd, int val)
 		error(1, errno, "setsockopt(SO_TIMESTAMPING)");
 }
 
+static int process_sample(void *ctx, void *data, size_t len)
+{
+	struct devtx_sample *sample = data;
+
+	printf("got tx timestamp sample %u %llu\n",
+	       sample->timestamp_retval, sample->timestamp);
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
+		"    -C    run in copy mode\n",
+		prog);
+}
+
 int main(int argc, char *argv[])
 {
+	struct ring_buffer *tx_compl_ringbuf = NULL;
 	clockid_t clock_id = CLOCK_TAI;
+	char *tx_complete = NULL;
+	char *tx_submit = NULL;
+	int bind_flags = 0;
 	int server_fd = -1;
+	int opt;
 	int ret;
 	int i;
 
 	struct bpf_program *prog;
 
-	if (argc != 2) {
+	while ((opt = getopt(argc, argv, "s:c:C")) != -1) {
+		switch (opt) {
+		case 's':
+			tx_submit = optarg;
+			break;
+		case 'c':
+			tx_complete = optarg;
+			break;
+		case 'C':
+			bind_flags |= XDP_COPY;
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
 
@@ -432,7 +560,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < rxq; i++) {
 		printf("open_xsk(%s, %p, %d)\n", ifname, &rx_xsk[i], i);
-		ret = open_xsk(ifindex, &rx_xsk[i], i);
+		ret = open_xsk(ifindex, &rx_xsk[i], i, bind_flags);
 		if (ret)
 			error(1, -ret, "open_xsk");
 
@@ -444,15 +572,45 @@ int main(int argc, char *argv[])
 	if (libbpf_get_error(bpf_obj))
 		error(1, libbpf_get_error(bpf_obj), "xdp_hw_metadata__open");
 
+	bpf_obj->data->ifindex = ifindex;
+	bpf_obj->data->net_cookie = get_net_cookie();
+
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, ifindex);
 	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
+	prog = bpf_object__find_program_by_name(bpf_obj->obj, "tx_submit");
+	bpf_program__set_ifindex(prog, ifindex);
+	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	if (tx_submit) {
+		printf("attaching devtx submit program to %s\n", tx_submit);
+		bpf_program__set_attach_target(prog, 0, tx_submit);
+	} else {
+		printf("skipping devtx submit program\n");
+		bpf_program__set_autoattach(prog, false);
+	}
+
+	prog = bpf_object__find_program_by_name(bpf_obj->obj, "tx_complete");
+	bpf_program__set_ifindex(prog, ifindex);
+	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	if (tx_complete) {
+		printf("attaching devtx complete program to %s\n", tx_complete);
+		bpf_program__set_attach_target(prog, 0, tx_complete);
+	} else {
+		printf("skipping devtx complete program\n");
+		bpf_program__set_autoattach(prog, false);
+	}
+
 	printf("load bpf program...\n");
 	ret = xdp_hw_metadata__load(bpf_obj);
 	if (ret)
 		error(1, -ret, "xdp_hw_metadata__load");
 
+	tx_compl_ringbuf = ring_buffer__new(bpf_map__fd(bpf_obj->maps.tx_compl_buf),
+					    process_sample, NULL, NULL);
+	if (libbpf_get_error(tx_compl_ringbuf))
+		error(1, -libbpf_get_error(tx_compl_ringbuf), "ring_buffer__new");
+
 	printf("prepare skb endpoint...\n");
 	server_fd = start_server(AF_INET6, SOCK_DGRAM, NULL, 9092, 1000);
 	if (server_fd < 0)
@@ -472,7 +630,7 @@ int main(int argc, char *argv[])
 			error(1, -ret, "bpf_map_update_elem");
 	}
 
-	printf("attach bpf program...\n");
+	printf("attach rx bpf program...\n");
 	ret = bpf_xdp_attach(ifindex,
 			     bpf_program__fd(bpf_obj->progs.rx),
 			     XDP_FLAGS, NULL);
@@ -480,7 +638,7 @@ int main(int argc, char *argv[])
 		error(1, -ret, "bpf_xdp_attach");
 
 	signal(SIGINT, handle_signal);
-	ret = verify_metadata(rx_xsk, rxq, server_fd, clock_id);
+	ret = verify_metadata(rx_xsk, rxq, server_fd, clock_id, tx_compl_ringbuf);
 	close(server_fd);
 	cleanup();
 	if (ret)
-- 
2.41.0.162.gfafddb0af9-goog


