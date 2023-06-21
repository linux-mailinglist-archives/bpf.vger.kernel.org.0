Return-Path: <bpf+bounces-3056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350A9738CA9
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BBE1C20EAC
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A311B912;
	Wed, 21 Jun 2023 17:03:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104321B90D
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 17:03:05 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1015122
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-553d27fe4baso2160780a12.2
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687366982; x=1689958982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m14zc5Ne3cCtu1j4SDPO41X9Yg8gCGGAV8qkGbFFLV4=;
        b=YhSyFM3AdxpwH9+6/7xUERw/pa56cCy4Y842C2uUQDnzE/jXH9HWWRW1WUXo9DXux/
         P4qFXTJ8iP+GYBPlxSnweF6jhwV3iaa1aWPl/+FjDpfcc8qrYH8LjjeGK4PlxLBckvzl
         wTsgasMe1aTVQRxTh1g5DxgfFWagxHf25yP3TKu0pn7QQICGfjfnct06s3Uga8UaORru
         9L3RG53EAjJdrJubKpCPfbM7JPui/WK20qxJ+RV2nEDMrhBhr1ZJrp8oImH64rh2d+8U
         jr9UN845P7Ycamae6T6ZnK6N32zO7DUaYk6datQWNAxjPYNawBNtvZbLs+fLrCb+bXTe
         3tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366982; x=1689958982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m14zc5Ne3cCtu1j4SDPO41X9Yg8gCGGAV8qkGbFFLV4=;
        b=Pw4HvEOplH3RuUfH9ttq4ohcrTY2/opjmOAgh6rXlSs6s388gS6o9w66LoUHeM2OTs
         cp4Kg0pavMn0tFOTTSjuWLCAb9eFoI292r1CauSeSfE0EVsIp4gcWGfOkjgFOL5FtLgk
         YQ0aePXCiFYE2FtABdNAxtwtD/BdR0xXqrEszHyvJM5KhttJJ6YB0QRFEXgKYjtfZDJW
         DDDo8o1pX5fU6AXk6CBIMOrCjgHefpMbUZPKXgg2K6884uE/f1s7eikDLdC5z+ircU5x
         FzisRxrcwXdiSMRLTCLGRSqEIqvcaKhS1Qi2N94LWMno99EwN3Hy6HnTHdeP3nCJbNYR
         C1pg==
X-Gm-Message-State: AC+VfDz/8FcAKRy9X4DXIbj7VMef0p2P7PXRHTlQ4tFhWbSDlJhyTKvK
	/R+1jVni2zlcrAiYh1btvmAFINrMwsztCnyZJgF9t3QIGAo4Rk3vWPQ4vLR3ebIPd6edUwvgb2J
	ZNcZkecAokfZoLS3QcgPlSnWpz5NhQ+HY6J/DTHKn6VkQZNYQzQ==
X-Google-Smtp-Source: ACHHUZ48yecyMc2NsRJfrsCYDLlxKGn6RUEUPaYAntNMBmsDofvGlaR9Ec/L2T1AKc1Q+t+Qufj8On4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:1f05:0:b0:557:3747:87b8 with SMTP id
 f5-20020a631f05000000b00557374787b8mr189968pgf.0.1687366982475; Wed, 21 Jun
 2023 10:03:02 -0700 (PDT)
Date: Wed, 21 Jun 2023 10:02:42 -0700
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621170244.1283336-10-sdf@google.com>
Subject: [RFC bpf-next v2 09/11] selftests/bpf: Extend xdp_metadata with devtx kfuncs
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

Attach kfuncs that request and report TX timestamp via ringbuf.
Confirm on the userspace side that the program has triggered
and the timestamp is non-zero.

Also make sure devtx_frame has a sensible pointers and data.

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  62 ++++++++-
 .../selftests/bpf/progs/xdp_metadata.c        | 118 ++++++++++++++++++
 tools/testing/selftests/bpf/xdp_metadata.h    |  14 +++
 3 files changed, 191 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 626c461fa34d..ca4f3106ce6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -42,6 +42,9 @@ struct xsk {
 	struct xsk_ring_prod tx;
 	struct xsk_ring_cons rx;
 	struct xsk_socket *socket;
+	int tx_completions;
+	u32 last_tx_timestamp_retval;
+	u64 last_tx_timestamp;
 };
 
 static int open_xsk(int ifindex, struct xsk *xsk)
@@ -51,6 +54,7 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.bind_flags = XDP_COPY,
+		.tx_metadata_len = TX_META_LEN,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
@@ -138,6 +142,7 @@ static void ip_csum(struct iphdr *iph)
 
 static int generate_packet(struct xsk *xsk, __u16 dst_port)
 {
+	struct xdp_tx_meta *meta;
 	struct xdp_desc *tx_desc;
 	struct udphdr *udph;
 	struct ethhdr *eth;
@@ -151,10 +156,13 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
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
@@ -192,7 +200,8 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	return 0;
 }
 
-static void complete_tx(struct xsk *xsk)
+static void complete_tx(struct xsk *xsk, struct xdp_metadata *bpf_obj,
+			struct ring_buffer *ringbuf)
 {
 	__u32 idx;
 	__u64 addr;
@@ -202,6 +211,13 @@ static void complete_tx(struct xsk *xsk)
 
 		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
 		xsk_ring_cons__release(&xsk->comp, 1);
+
+		ring_buffer__poll(ringbuf, 1000);
+
+		ASSERT_EQ(bpf_obj->bss->pkts_fail_tx, 0, "pkts_fail_tx");
+		ASSERT_GE(xsk->tx_completions, 1, "tx_completions");
+		ASSERT_EQ(xsk->last_tx_timestamp_retval, 0, "last_tx_timestamp_retval");
+		ASSERT_GE(xsk->last_tx_timestamp, 0, "last_tx_timestamp");
 	}
 }
 
@@ -276,8 +292,24 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	return 0;
 }
 
+static int process_sample(void *ctx, void *data, size_t len)
+{
+	struct devtx_sample *sample = data;
+	struct xsk *xsk = ctx;
+
+	printf("%p: got tx timestamp sample %u %llu\n",
+	       xsk, sample->timestamp_retval, sample->timestamp);
+
+	xsk->tx_completions++;
+	xsk->last_tx_timestamp_retval = sample->timestamp_retval;
+	xsk->last_tx_timestamp = sample->timestamp;
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
index d151d406a123..fc025183d45a 100644
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
@@ -19,10 +24,25 @@ struct {
 	__type(value, __u32);
 } prog_arr SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 10);
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
+extern int bpf_devtx_sb_request_timestamp(const struct devtx_frame *ctx) __ksym;
+extern int bpf_devtx_cp_timestamp(const struct devtx_frame *ctx, __u64 *timestamp) __ksym;
+
+extern int bpf_devtx_sb_attach(int ifindex, int prog_fd) __ksym;
+extern int bpf_devtx_cp_attach(int ifindex, int prog_fd) __ksym;
 
 SEC("xdp")
 int rx(struct xdp_md *ctx)
@@ -61,4 +81,102 @@ int rx(struct xdp_md *ctx)
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
+static inline int verify_frame(const struct devtx_frame *frame)
+{
+	struct ethhdr eth = {};
+
+	/* all the pointers are set up correctly */
+	if (!frame->data)
+		return -1;
+	if (!frame->sinfo)
+		return -1;
+
+	/* can get to the frags */
+	if (frame->sinfo->nr_frags != 0)
+		return -1;
+	if (frame->sinfo->frags[0].bv_page != 0)
+		return -1;
+	if (frame->sinfo->frags[0].bv_len != 0)
+		return -1;
+	if (frame->sinfo->frags[0].bv_offset != 0)
+		return -1;
+
+	/* the data has something that looks like ethernet */
+	if (frame->len != 46)
+		return -1;
+	bpf_probe_read_kernel(&eth, sizeof(eth), frame->data);
+
+	if (eth.h_proto != bpf_htons(ETH_P_IP))
+		return -1;
+
+	return 0;
+}
+
+SEC("fentry/veth_devtx_submit")
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
+	ret = verify_frame(frame);
+	if (ret < 0) {
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+		return 0;
+	}
+
+	ret = bpf_devtx_sb_request_timestamp(frame);
+	if (ret < 0) {
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+		return 0;
+	}
+
+	return 0;
+}
+
+SEC("fentry/veth_devtx_complete")
+int BPF_PROG(tx_complete, const struct devtx_frame *frame)
+{
+	struct xdp_tx_meta meta = {};
+	struct devtx_sample *sample;
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
+	ret = verify_frame(frame);
+	if (ret < 0) {
+		__sync_add_and_fetch(&pkts_fail_tx, 1);
+		return 0;
+	}
+
+	sample = bpf_ringbuf_reserve(&tx_compl_buf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+
+	sample->timestamp_retval = bpf_devtx_cp_timestamp(frame, &sample->timestamp);
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 938a729bd307..e410f2b95e64 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -18,3 +18,17 @@ struct xdp_meta {
 		__s32 rx_hash_err;
 	};
 };
+
+struct devtx_sample {
+	int timestamp_retval;
+	__u64 timestamp;
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
2.41.0.162.gfafddb0af9-goog


