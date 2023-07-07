Return-Path: <bpf+bounces-4488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1374B738
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2EC281925
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855B18AF5;
	Fri,  7 Jul 2023 19:30:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34818AF1
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:41 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34530C1
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262d8c40189so3046547a91.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758232; x=1691350232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSNQ7+J+mNIfgDLdx4SLa8fNN2Odoru2w9MrO++sRPI=;
        b=m3zukDchSbEhu2J6VsNB/6sTSUC23C+GibuuPgBsTNw9uxSagSUdguaINNoIwRagk5
         lDj51RZGIgASliO7oRoD/PfaumRjUrRjHDppJwckNm0g9GTQb1AmX/dJ8RgET0TFEkJn
         8UquByJ4GsGmhA4YAsfTAnqBLTLystEnCfwiHkYCxFFipxcleJxXgzR9ugzO2OmX8huk
         O8dhhqDFollRjy5X5RVNrYt7Arwnkmsm6w4osmmMR1cdelv8UHEmisVH+XzNjUO0YSWD
         nEbFoSfX/s3VRCeB9458a7RZkDtmNuvT0D33e1+71Lzj7g+QKiMfefcb77cZKFAcQZdB
         k1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758232; x=1691350232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSNQ7+J+mNIfgDLdx4SLa8fNN2Odoru2w9MrO++sRPI=;
        b=FdcGuMucxRgyTDzECaK3M+evj6pR1Ywmn5N6dor8NY7jyp/JH4xBeE9IPWlnJy4Aqd
         TeS5WsUTO9nuKvXcpAyNtL9NM6gs9T4DsIco5QsgFDmNjyRFv02AMxdZ55h5jTzTcjtO
         IUdt1/4836dvE89uzDjR4MlTLdPEG2gxq87XmXJ2SpuI9iUDUy8CjnoforCNoNP1S7SV
         m29gd7iCYmsn8Wz3dhj0zRrzKsyeXx3BZiIGIc0jewbsfnHCFeFKNDg7mSXHGUqP+T17
         /8sjlg0tyBY3tPkjOgQkhy90O+0N9CjyW1Wr2fDRruY9rkEZ7p6Rvex7xq2JbgqI6Gns
         hTcQ==
X-Gm-Message-State: ABy/qLZcIUpUwTemRlpxOIH3vto9DVDeoPDeP7IXtv82y4NSFj5F8fMd
	iu+gCEqhwN62bsGVDWBAFFCcICkcZhnYEdrIyByZPupyO5ztT6pkGmhhnQi02kNhJNIsQfwE3Je
	+KnHgRVT+iZ1KB1ul719ugZnkKvr26OMmHVUpz6IaENlXFwynKw==
X-Google-Smtp-Source: APBJJlH9c0s0kPeYseEwkhoMLTWan9eJdkgZfOa4Dx0Zdb2DT0r3ugUGBHddYck1khGhI7aBggDrYjg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:f287:b0:261:2e5:b5af with SMTP id
 fs7-20020a17090af28700b0026102e5b5afmr4907166pjb.1.1688758231701; Fri, 07 Jul
 2023 12:30:31 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:30:05 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-14-sdf@google.com>
Subject: [RFC bpf-next v3 13/14] selftests/bpf: Extend xdp_metadata with devtx kfuncs
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Attach kfuncs that request and report TX timestamp via ringbuf.
Confirm on the userspace side that the program has triggered
and the timestamp is non-zero.

Also make sure skb has a sensible pointers and data.

In addition, calculate pseudo-header checksum and offload
payload checksum calculation to the kfunc.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  64 +++++++-
 .../selftests/bpf/progs/xdp_metadata.c        | 141 ++++++++++++++++++
 tools/testing/selftests/bpf/xdp_metadata.h    |  16 ++
 3 files changed, 217 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 626c461fa34d..ca1442d2c347 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -42,6 +42,8 @@ struct xsk {
 	struct xsk_ring_prod tx;
 	struct xsk_ring_cons rx;
 	struct xsk_socket *socket;
+	int tx_completions;
+	struct devtx_sample last_sample;
 };
 
 static int open_xsk(int ifindex, struct xsk *xsk)
@@ -51,6 +53,7 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.bind_flags = XDP_COPY,
+		.tx_metadata_len = TX_META_LEN,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
@@ -138,6 +141,7 @@ static void ip_csum(struct iphdr *iph)
 
 static int generate_packet(struct xsk *xsk, __u16 dst_port)
 {
+	struct xdp_tx_meta *meta;
 	struct xdp_desc *tx_desc;
 	struct udphdr *udph;
 	struct ethhdr *eth;
@@ -151,10 +155,13 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 		return -1;
 
 	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
-	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + TX_META_LEN;
 	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
 	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
 
+	meta = data - TX_META_LEN;
+	meta->request_timestamp = 1;
+
 	eth = data;
 	iph = (void *)(eth + 1);
 	udph = (void *)(iph + 1);
@@ -178,7 +185,8 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	udph->source = htons(AF_XDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
-	udph->check = 0;
+	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+					 ntohs(udph->len), IPPROTO_UDP, 0);
 
 	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
 
@@ -192,7 +200,8 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	return 0;
 }
 
-static void complete_tx(struct xsk *xsk)
+static void complete_tx(struct xsk *xsk, struct xdp_metadata *bpf_obj,
+			struct ring_buffer *ringbuf)
 {
 	__u32 idx;
 	__u64 addr;
@@ -202,6 +211,14 @@ static void complete_tx(struct xsk *xsk)
 
 		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
 		xsk_ring_cons__release(&xsk->comp, 1);
+
+		ring_buffer__poll(ringbuf, 1000);
+
+		ASSERT_EQ(bpf_obj->bss->pkts_fail_tx, 0, "pkts_fail_tx");
+		ASSERT_GE(xsk->tx_completions, 1, "tx_completions");
+		ASSERT_EQ(xsk->last_sample.timestamp_retval, 0, "timestamp_retval");
+		ASSERT_GE(xsk->last_sample.hw_timestamp, 0, "hw_timestamp");
+		ASSERT_EQ(xsk->last_sample.tx_csum, 0x1c72, "tx_csum");
 	}
 }
 
@@ -276,8 +293,23 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	return 0;
 }
 
+static int process_sample(void *ctx, void *data, size_t len)
+{
+	struct devtx_sample *sample = data;
+	struct xsk *xsk = ctx;
+
+	printf("%p: got tx timestamp sample %u %llu\n",
+	       xsk, sample->timestamp_retval, sample->hw_timestamp);
+
+	xsk->tx_completions++;
+	xsk->last_sample = *sample;
+
+	return 0;
+}
+
 void test_xdp_metadata(void)
 {
+	struct ring_buffer *tx_compl_ringbuf = NULL;
 	struct xdp_metadata2 *bpf_obj2 = NULL;
 	struct xdp_metadata *bpf_obj = NULL;
 	struct bpf_program *new_prog, *prog;
@@ -290,6 +322,7 @@ void test_xdp_metadata(void)
 	int retries = 10;
 	int rx_ifindex;
 	int tx_ifindex;
+	int syscall_fd;
 	int sock_fd;
 	int ret;
 
@@ -323,6 +356,14 @@ void test_xdp_metadata(void)
 	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
 		goto out;
 
+	prog = bpf_object__find_program_by_name(bpf_obj->obj, "tx_submit");
+	bpf_program__set_ifindex(prog, tx_ifindex);
+	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+
+	prog = bpf_object__find_program_by_name(bpf_obj->obj, "tx_complete");
+	bpf_program__set_ifindex(prog, tx_ifindex);
+	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, rx_ifindex);
 	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
@@ -330,6 +371,18 @@ void test_xdp_metadata(void)
 	if (!ASSERT_OK(xdp_metadata__load(bpf_obj), "load skeleton"))
 		goto out;
 
+	bpf_obj->data->ifindex = tx_ifindex;
+	bpf_obj->data->net_cookie = get_net_cookie();
+
+	ret = xdp_metadata__attach(bpf_obj);
+	if (!ASSERT_OK(ret, "xdp_metadata__attach"))
+		goto out;
+
+	tx_compl_ringbuf = ring_buffer__new(bpf_map__fd(bpf_obj->maps.tx_compl_buf),
+					    process_sample, &tx_xsk, NULL);
+	if (!ASSERT_OK_PTR(tx_compl_ringbuf, "ring_buffer__new"))
+		goto out;
+
 	/* Make sure we can't add dev-bound programs to prog maps. */
 	prog_arr = bpf_object__find_map_by_name(bpf_obj->obj, "prog_arr");
 	if (!ASSERT_OK_PTR(prog_arr, "no prog_arr map"))
@@ -364,7 +417,8 @@ void test_xdp_metadata(void)
 		       "verify_xsk_metadata"))
 		goto out;
 
-	complete_tx(&tx_xsk);
+	/* Verify AF_XDP TX packet has completion event with a timestamp. */
+	complete_tx(&tx_xsk, bpf_obj, tx_compl_ringbuf);
 
 	/* Make sure freplace correctly picks up original bound device
 	 * and doesn't crash.
@@ -402,5 +456,7 @@ void test_xdp_metadata(void)
 	xdp_metadata__destroy(bpf_obj);
 	if (tok)
 		close_netns(tok);
+	if (tx_compl_ringbuf)
+		ring_buffer__free(tx_compl_ringbuf);
 	SYS_NOFAIL("ip netns del xdp_metadata");
 }
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index d151d406a123..a5d9229acdf3 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -4,6 +4,11 @@
 #include "xdp_metadata.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+
+#ifndef ETH_P_IP
+#define ETH_P_IP 0x0800
+#endif
 
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
@@ -19,10 +24,24 @@ struct {
 	__type(value, __u32);
 } prog_arr SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} tx_compl_buf SEC(".maps");
+
+__u64 pkts_fail_tx = 0;
+
+int ifindex = -1;
+__u64 net_cookie = -1;
+
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
@@ -61,4 +80,126 @@ int rx(struct xdp_md *ctx)
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
+static inline int verify_frame(const struct sk_buff *skb, const struct skb_shared_info *sinfo)
+{
+	struct ethhdr eth = {};
+
+	/* all the pointers are set up correctly */
+	if (!skb->data)
+		return -1;
+	if (!sinfo)
+		return -1;
+
+	/* can get to the frags */
+	if (sinfo->nr_frags != 0)
+		return -1;
+	if (sinfo->frags[0].bv_page != 0)
+		return -1;
+	if (sinfo->frags[0].bv_len != 0)
+		return -1;
+	if (sinfo->frags[0].bv_offset != 0)
+		return -1;
+
+	/* the data has something that looks like ethernet */
+	if (skb->len != 46)
+		return -1;
+	bpf_probe_read_kernel(&eth, sizeof(eth), skb->data);
+
+	if (eth.h_proto != bpf_htons(ETH_P_IP))
+		return -1;
+
+	return 0;
+}
+
+static inline bool my_netdev(const struct devtx_ctx *ctx)
+{
+	static struct net_device *netdev;
+
+	if (netdev)
+		return netdev == ctx->netdev;
+
+	if (ctx->netdev->ifindex != ifindex)
+		return false;
+	if (ctx->netdev->nd_net.net->net_cookie != net_cookie)
+		return false;
+
+	netdev = ctx->netdev;
+	return true;
+}
+
+SEC("fentry/veth_devtx_submit_skb")
+int BPF_PROG(tx_submit, const struct devtx_ctx *devtx, struct sk_buff *skb)
+{
+	int udpoff = sizeof(struct ethhdr) + sizeof(struct iphdr);
+	struct xdp_tx_meta meta = {};
+	int ret;
+
+	if (!my_netdev(devtx))
+		return 0;
+	if (devtx->sinfo->meta_len != TX_META_LEN)
+		return 0;
+
+	bpf_probe_read_kernel(&meta, sizeof(meta), skb->data - TX_META_LEN);
+	if (!meta.request_timestamp)
+		return 0;
+
+	ret = verify_frame(skb, devtx->sinfo);
+	if (ret < 0) {
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+		return 0;
+	}
+
+	ret = bpf_devtx_request_tx_timestamp(devtx);
+	if (ret < 0) {
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+		return 0;
+	}
+
+	ret = bpf_devtx_request_l4_csum(devtx, udpoff, udpoff + offsetof(struct udphdr, check));
+	if (ret < 0) {
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+		return 0;
+	}
+
+	return 0;
+}
+
+SEC("fentry/veth_devtx_complete_skb")
+int BPF_PROG(tx_complete, const struct devtx_ctx *devtx, struct sk_buff *skb)
+{
+	struct xdp_tx_meta meta = {};
+	struct devtx_sample *sample;
+	struct udphdr udph;
+	int ret;
+
+	if (!my_netdev(devtx))
+		return 0;
+	if (devtx->sinfo->meta_len != TX_META_LEN)
+		return 0;
+
+	bpf_probe_read_kernel(&meta, sizeof(meta), skb->data - TX_META_LEN);
+	if (!meta.request_timestamp)
+		return 0;
+
+	ret = verify_frame(skb, devtx->sinfo);
+	if (ret < 0) {
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+		return 0;
+	}
+
+	sample = bpf_ringbuf_reserve(&tx_compl_buf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+
+	bpf_probe_read_kernel(&udph, sizeof(udph),
+			      skb->data + sizeof(struct ethhdr) + sizeof(struct iphdr));
+
+	sample->timestamp_retval = bpf_devtx_tx_timestamp(devtx, &sample->hw_timestamp);
+	sample->tx_csum = udph.check;
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 938a729bd307..ecab5404f1d6 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -18,3 +18,19 @@ struct xdp_meta {
 		__s32 rx_hash_err;
 	};
 };
+
+struct devtx_sample {
+	int timestamp_retval;
+	__u64 hw_timestamp;
+	__u64 sw_complete_timestamp;
+	__u16 tx_csum;
+};
+
+#define TX_META_LEN	8
+
+struct xdp_tx_meta {
+	__u8 request_timestamp;
+	__u8 padding0;
+	__u16 padding1;
+	__u32 padding2;
+};
-- 
2.41.0.255.g8b1d071c50-goog


