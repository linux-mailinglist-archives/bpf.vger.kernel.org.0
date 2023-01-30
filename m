Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC19D681D44
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 22:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjA3Vvm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 16:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3Vvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 16:51:41 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D63367F1
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 13:51:40 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y6-20020a17090ad70600b0022c755b04fcso3124467pju.1
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VHZZ+N66OZFSKCVVuvYxUOScmkQMjwMGvWhUGiSKBZ8=;
        b=ebdS2yPGYUvppWGftaMC5ZsugMJXch+g07k5zXAzkMn/bP46R3Orl9vu0xFhSE0QS4
         GPefzTUmKPERea/PnNaHIbF1xSX3YQYYfCVzc56DubmMjHSivUJJlDeIgV49tDY+zO+r
         i74E81Al33D/kmaf1+qx9eIO7CRMzmVvlKjiQuCxNT9GW6A45Xsfyv/3deniMqgeUAow
         ie701kbJEDnzrqVfK4tNbAOd7hearmaeCMimutBDcgeTgiz8O2pxToB6pRCDfL+aX1zs
         1qpBlzgwAtfXV1fVQ1z7QdaJ6QoqHduJj67zAxDfvLR2M3ItDMBdiYHP6m3SDEG5zb9s
         QA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHZZ+N66OZFSKCVVuvYxUOScmkQMjwMGvWhUGiSKBZ8=;
        b=3R21ovcOJOh67VA9nkkyFsn/Ub2i2hZ+MCjE9lRul7TADN/aIILfHSJVEKp8X9IDUT
         XVFYPogLkEVe1S/VkorYbDZH8OE533V+hPOKcXuDESmdkbZ2x5Xm7Lg2tXsrp0N9/b3q
         oS/lrNfXOEC0ZfayN2mvK0NYiNkR4DB5lUatMqeLOv46ytydNfkVaW2MUPogEl+hH764
         ZLlbZiwaWZ5yRnV7q3mVPRG9tk+FycWFBSSaRcqCZggzv0htl3MC8whC74tAlQYv1hlx
         T13nHQW8zTw3zFO5H8ICw2Pp7ZokMdglvbG3+hGmv60Vm2reQWf8g+3qWJHmXTjDuM/p
         c8Tw==
X-Gm-Message-State: AO0yUKUhAVV82G9PQ/fncoqUDXupqCQfebv4scnRxj1hvyA67sq1Y7d8
        vM2ChAWpi5b2WcmW6jR2j7dMerqilxOKxVloK/rlApe+d+tjg7XUrttk+SOBBgW995JdKsy6EvH
        Xe1/c5xhOrmPws0T5W/Z4mIwc0Xdxf/pY6uz1N+diTgub6ouH8A==
X-Google-Smtp-Source: AK7set+Jma2b6i/6yEjP0NMsokpUkb50HhVatC4kPjGuu/LtSiWMKemTB2VW+dWzJF04whRBBsdjqOg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:384:b0:22c:3a4:697d with SMTP id
 ga4-20020a17090b038400b0022c03a4697dmr3677191pjb.63.1675115499180; Mon, 30
 Jan 2023 13:51:39 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:51:37 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230130215137.3473320-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Try to address xdp_metadata crashes
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
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

Commit e04ce9f4040b ("selftests/bpf: Make crashes more debuggable in
test_progs") hasn't uncovered anything interesting besides
confirming that the test passes successfully, but crashes eventually [0].

I'm assuming the crashes are coming from something overriding
the stack/heap. Probably from the xsk misuse. So I'm trying
a bunch of things to address that:

- More debugging with real memory pointers for the queues/umem
  - To confirm that everything is sane
- Set proper tx/fill ring sizes
  - In particular, fill ring wasn't fully initialized, but I'm
    assuming no packets should be flowing there regardless
  - Do the same for xdp_hw_metadata
- Don't refill on tx completion; instead, only ack it

0: https://github.com/kernel-patches/bpf/actions/runs/4032162075/jobs/6931951300

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 36 +++++++++++++------
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  4 +--
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index e033d48288c0..453b4045a9d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -54,11 +54,11 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	const struct xsk_socket_config socket_config = {
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
-		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.tx_size = UMEM_NUM / 2,
 		.bind_flags = XDP_COPY,
 	};
 	const struct xsk_umem_config umem_config = {
-		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.fill_size = UMEM_NUM / 2,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
 		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
@@ -88,13 +88,24 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 	if (!ASSERT_OK(ret, "xsk_socket__create"))
 		return ret;
 
+	printf("%p: umem=<%p..%p>\n", xsk, xsk->umem_area, xsk->umem_area + UMEM_SIZE);
+	printf("%p: fill=<%p..%p>\n", xsk, xsk->fill.ring,
+	       xsk->fill.ring + xsk->fill.size * sizeof(__u64));
+	printf("%p: comp=<%p..%p>\n", xsk, xsk->comp.ring,
+	       xsk->comp.ring + xsk->comp.size * sizeof(__u64));
+	printf("%p: rx=<%p..%p>\n", xsk, xsk->rx.ring,
+	       xsk->rx.ring + xsk->rx.size * sizeof(struct xdp_desc));
+	printf("%p: tx=<%p..%p>\n", xsk, xsk->tx.ring,
+	       xsk->tx.ring + xsk->tx.size * sizeof(struct xdp_desc));
+
 	/* First half of umem is for TX. This way address matches 1-to-1
 	 * to the completion queue index.
 	 */
 
 	for (i = 0; i < UMEM_NUM / 2; i++) {
 		addr = i * UMEM_FRAME_SIZE;
-		printf("%p: tx_desc[%d] -> %lx\n", xsk, i, addr);
+		printf("%p: tx_desc[%d] -> %lx (%p)\n", xsk, i, addr,
+		       xsk_umem__get_data(xsk->umem_area, addr));
 	}
 
 	/* Second half of umem is for RX. */
@@ -107,7 +118,10 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 
 	for (i = 0; i < UMEM_NUM / 2; i++) {
 		addr = (UMEM_NUM / 2 + i) * UMEM_FRAME_SIZE;
-		printf("%p: rx_desc[%d] -> %lx\n", xsk, i, addr);
+		printf("%p: rx_desc[%d] -> %lx (%p)\n", xsk, i, addr,
+		       xsk_umem__get_data(xsk->umem_area, addr));
+		printf("%p: fill %lx at %p\n", xsk, addr,
+		       xsk_ring_prod__fill_addr(&xsk->fill, i));
 		*xsk_ring_prod__fill_addr(&xsk->fill, i) = addr;
 	}
 	xsk_ring_prod__submit(&xsk->fill, ret);
@@ -159,6 +173,7 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
 	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
 	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+	printf("%p: tx %llx (%p) at %p\n", xsk, tx_desc->addr, data, tx_desc);
 
 	eth = data;
 	iph = (void *)(eth + 1);
@@ -205,9 +220,8 @@ static void complete_tx(struct xsk *xsk)
 	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
 		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
 
-		printf("%p: refill idx=%u addr=%llx\n", xsk, idx, addr);
-		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
-		xsk_ring_prod__submit(&xsk->fill, 1);
+		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
+		xsk_ring_cons__release(&xsk->comp, 1);
 	}
 }
 
@@ -216,7 +230,9 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
 	__u32 idx;
 
 	if (ASSERT_EQ(xsk_ring_prod__reserve(&xsk->fill, 1, &idx), 1, "xsk_ring_prod__reserve")) {
-		printf("%p: complete idx=%u addr=%llx\n", xsk, idx, addr);
+		printf("%p: complete rx idx=%u addr=%llx\n", xsk, idx, addr);
+		printf("%p: fill %llx at %p\n", xsk, addr,
+		       xsk_ring_prod__fill_addr(&xsk->fill, idx));
 		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
 		xsk_ring_prod__submit(&xsk->fill, 1);
 	}
@@ -253,8 +269,8 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	rx_desc = xsk_ring_cons__rx_desc(&xsk->rx, idx);
 	comp_addr = xsk_umem__extract_addr(rx_desc->addr);
 	addr = xsk_umem__add_offset_to_addr(rx_desc->addr);
-	printf("%p: rx_desc[%u]->addr=%llx addr=%llx comp_addr=%llx\n",
-	       xsk, idx, rx_desc->addr, addr, comp_addr);
+	printf("%p: rx_desc[%u]->addr=%llx (%p) addr=%llx comp_addr=%llx\n",
+	       xsk, idx, rx_desc->addr, rx_desc, addr, comp_addr);
 	data = xsk_umem__get_data(xsk->umem_area, addr);
 
 	/* Make sure we got the packet offset correctly. */
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3823b1c499cc..6d715f85ea20 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -59,11 +59,11 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	const struct xsk_socket_config socket_config = {
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
-		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.tx_size = UMEM_NUM / 2,
 		.bind_flags = XDP_COPY,
 	};
 	const struct xsk_umem_config umem_config = {
-		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
+		.fill_size = UMEM_NUM / 2,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
 		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
-- 
2.39.1.456.gfc5497dd1b-goog

