Return-Path: <bpf+bounces-5780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652C760384
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955A01C20D0C
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DF15AD5;
	Tue, 25 Jul 2023 00:00:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63C156F9
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:00:14 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C45172D
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563bcd2cb78so744500a12.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690243213; x=1690848013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lu7z7JckF+WwjvByshwT9Vj3+m/MkD61H4qOkk5aNU=;
        b=CqTxr3odSmJnweQVTo64Fev9zOIwnOtW/wOByXZBsnlQ3IXnVAV9yuyMM7CqhJrxq8
         wesNhQmLjLgzAbBH3dBxb/ST8YBqRH/y/E/yN74/p7Y6mz9rDQdjIfCUfo3yZHruWiST
         Ei/ZfuYmWVE3Tq1uNvKt429VXaxsA1m5PHYTioEW2dQq7UiPox+OXkgqGLeaqag4CLkD
         Oe7MZDtt5eAnMLruVEmRCwOyktcOhZ3ywR+mKCJZ4ObehlTDl3SJFwiImhn4b5Jz9p1B
         nNwvFdzaKkLzZ1vSSAtEiUnS3XVIWLMFtv+AZBWmLf+bPnmrNJ9K8q8sm5WhTEaa/H88
         rC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243213; x=1690848013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lu7z7JckF+WwjvByshwT9Vj3+m/MkD61H4qOkk5aNU=;
        b=O1W9OPySVFvgXgXugM21aHv5AtQHQ+Ho/4eeIEUDtdj5wTGcK6DgTRB6g+AZMdbOk9
         6NJxE2Wo1g20UJGB0vXzxdnaWntzHgEzREAWflvXEONNpyWMidyNmAYMEG/3NEcbrSik
         L+IdcujYOShXBh86iVrI4jUUSSBnKJZ+p7d8XIjTIJF4PA6FbDuJw+fMfucutm1DPO3j
         f8jhgxMh2ZXN/cB6o0Uk//Yy6Do15baeFqchk5TpYcYb5FQZpz8MLcDKxdZcYUk7gb1c
         en9/7LLF0IpOBL0TWFBkzyTy4+sNAK9qcUV1mmDEg6y80yHmoWeIxxUsnXzAYIVUBekO
         W2jw==
X-Gm-Message-State: ABy/qLa2/xwZAIqX1Xrp4mC49fU9MTsnDq+WCmqxbJskmU+Zj5pp/ZbT
	7QOnAR0F3YP6sxXnD4YORL23kj9cKyaHVDYy+KRFlGG5VX5zF/4cUwrvgL4TkEgA/XfIgqki5Rl
	BF7zSpFqUY337IjSGQHy//D1BnYEG9odRKc4r7U2bNwhPNjofJw==
X-Google-Smtp-Source: APBJJlGLpmeK7I0G8oMupZCuwtKhOQsRExw1BOzpw9G2DFmlhD/kyCi1xNOsaUFXgOiN4vcFH6ktcDM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3549:0:b0:55c:5c64:2c73 with SMTP id
 c70-20020a633549000000b0055c5c642c73mr46597pga.6.1690243212600; Mon, 24 Jul
 2023 17:00:12 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:59:56 -0700
In-Reply-To: <20230724235957.1953861-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724235957.1953861-8-sdf@google.com>
Subject: [RFC net-next v4 7/8] selftests/bpf: Add TX side to xdp_metadata
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

Request TX timestamp and make sure it's not empty.
Request TX checksum offload (SW-only) and make sure it's resolved
to the correct one.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 626c461fa34d..04477a557b8c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -48,6 +48,7 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 {
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	const struct xsk_socket_config socket_config = {
+		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.bind_flags = XDP_COPY,
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
+		ASSERT_NEQ(meta->tx_timestamp, 0, "tx_timestamp");
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
2.41.0.487.g6d72f3e995-goog


