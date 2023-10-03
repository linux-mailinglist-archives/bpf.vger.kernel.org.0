Return-Path: <bpf+bounces-11310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7B7B7243
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 918CA281D92
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFC3E46C;
	Tue,  3 Oct 2023 20:05:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA893E461
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:42 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC0EAB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f616f4660so19060007b3.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363540; x=1696968340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgSUvply8sXC/u3o357anBYjJyaAwC3vpkApYvKGB2U=;
        b=EFtWDvg5Im/7ic8qqgtjwsE7pWfq6RkV7aymFqNLrV5JJjtpKnQHSZ4HTeZLThsh87
         5mwA3Fz6RCKCBWcnaNX4BhCX5LO+lb0eSu7FVPk+2QPMwbmVqIQF2uXqgbV7hAai9czW
         w0njQvSDjQCvAL/MaNvty7PlSxS6nFIbl7jWieuxyEjWbHeJH5WX1kTakxi59hvJL3b0
         R76Mw7A9Ig2E727Tr7AuFR7E0jBB56/iDNGU7MEqEKL8UZeE+q90nwY94s4si3mSkTBa
         LFVZR0JGZN1T8hatwmaPpA6cP9Gtwoy7HqMQDyVVdJ4ADgJOPyd1hCdUIHjYlA9zHnPo
         FuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363540; x=1696968340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgSUvply8sXC/u3o357anBYjJyaAwC3vpkApYvKGB2U=;
        b=h6+YC7psfZjxpvzDX0r91nZyXhV18Dk7XTeBoCNLVVEFI6zbHda91F670U5ErHlCUh
         olAB9H9YNA5wzTOxmJWcf6osHJaf982dCewJnc5Q6sYmcQPW5wluhwLMQNYHpcuguzoP
         8WUvanUY9G4muvvTgBEequpNNlInqguvS4viiuRky+WtZs/kbxq3JqQoJo3qYiHT4+b3
         uFg4rdrj1JbFOPKMccIbVCKoIBl9Ud05rGPmPqwgbH95V2B36za0cVsnUpj5BVUsIKkL
         FO53JKzA34yytH/+415edwJrqOkgwQSdJbcBxuOgOEJioyxzXIcfkVqb0vB2Hc4XxStx
         XnjQ==
X-Gm-Message-State: AOJu0YwlDwLRFrXDxclSmYuj5WccGuDJYqfEgZ+G4YJyS4H5yppcHg9P
	LESs5wF6X5tZlzvx9YuGW0A7UgTvRXl/bN0FkoNwTveo20bG8bk0N6byLxLMTDk5naT6kw3YTY8
	gxeXayvEw11t9EMmytohkR+ciJEPhUcr8g223lWehYeLfXRuJ1A==
X-Google-Smtp-Source: AGHT+IHN9onGjSG2mBV9XxMTSC9B/sj5x46S9kMGbmyHXYMpWR9Zld0GuIITglpHeLw+SyeLawYWa+0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:aa4d:0:b0:592:83d2:1f86 with SMTP id
 z13-20020a81aa4d000000b0059283d21f86mr10182ywk.4.1696363540181; Tue, 03 Oct
 2023 13:05:40 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:20 -0700
In-Reply-To: <20231003200522.1914523-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-9-sdf@google.com>
Subject: [PATCH bpf-next v3 08/10] selftests/bpf: Add TX side to xdp_metadata
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Request TX timestamp and make sure it's not empty.
Request TX checksum offload (SW-only) and make sure it's resolved
to the correct one.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 626c461fa34d..f0da8fe93276 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -57,6 +57,7 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
 		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
+		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx;
 	u64 addr;
@@ -138,6 +139,7 @@ static void ip_csum(struct iphdr *iph)
 
 static int generate_packet(struct xsk *xsk, __u16 dst_port)
 {
+	struct xsk_tx_metadata *meta;
 	struct xdp_desc *tx_desc;
 	struct udphdr *udph;
 	struct ethhdr *eth;
@@ -151,10 +153,14 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 		return -1;
 
 	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
-	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
 	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
 	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
 
+	meta = data - sizeof(struct xsk_tx_metadata);
+	memset(meta, 0, sizeof(*meta));
+	meta->flags = XDP_TX_METADATA_TIMESTAMP;
+
 	eth = data;
 	iph = (void *)(eth + 1);
 	udph = (void *)(iph + 1);
@@ -178,11 +184,17 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	udph->source = htons(AF_XDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
-	udph->check = 0;
+	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+					 ntohs(udph->len), IPPROTO_UDP, 0);
 
 	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
 
+	meta->flags |= XDP_TX_METADATA_CHECKSUM | XDP_TX_METADATA_CHECKSUM_SW;
+	meta->csum_start = sizeof(*eth) + sizeof(*iph);
+	meta->csum_offset = offsetof(struct udphdr, check);
+
 	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
+	tx_desc->options |= XDP_TX_METADATA;
 	xsk_ring_prod__submit(&xsk->tx, 1);
 
 	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
@@ -194,13 +206,21 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 
 static void complete_tx(struct xsk *xsk)
 {
-	__u32 idx;
+	struct xsk_tx_metadata *meta;
 	__u64 addr;
+	void *data;
+	__u32 idx;
 
 	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
 		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
 
 		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
+
+		data = xsk_umem__get_data(xsk->umem_area, addr);
+		meta = data - sizeof(struct xsk_tx_metadata);
+
+		ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
+
 		xsk_ring_cons__release(&xsk->comp, 1);
 	}
 }
@@ -221,6 +241,7 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds = {};
 	struct xdp_meta *meta;
+	struct udphdr *udph;
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	__u64 comp_addr;
@@ -257,6 +278,7 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	ASSERT_EQ(eth->h_proto, htons(ETH_P_IP), "eth->h_proto");
 	iph = (void *)(eth + 1);
 	ASSERT_EQ((int)iph->version, 4, "iph->version");
+	udph = (void *)(iph + 1);
 
 	/* custom metadata */
 
@@ -270,6 +292,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
 
 	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
 
+	/* checksum offload */
+	ASSERT_EQ(udph->check, 0x1c72, "csum");
+
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
-- 
2.42.0.582.g8ccd20d70d-goog


