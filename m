Return-Path: <bpf+bounces-10084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB357A0F91
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6941D28222B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939962772D;
	Thu, 14 Sep 2023 21:05:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F927716
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:05:09 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1792700
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so26825347b3.1
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725508; x=1695330308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXhMN6bGqnJggKKLO/4TPQFnVFdhmWWVa7skOr7EcB8=;
        b=1eVf/qMBlmaRnP/1942HvQrE/fVdAZvSdZl+GAruNIN/cxjz2IRUWcYkdxtXwVC7i+
         mc2qT+JSgHDHggfQjgWUzwiASaPgEzaAgj5jSqZfzFO3a650REd3oj9SnQQMm30g8oY+
         JuVdE9/s78Vr97KT6H1xz4/AC2aECct6lm3uqP1S6fPHgP3lHa1seGnGt0TM1AR9EApY
         ZoQGxK2pIjGQTPt7LCVcheSdLo7wlt+wMTm/lI5qk4e19MytdrLCE84U5s07qpgj3Jlv
         dEGrCgKlm5bWYPqmGe3A5iZmdvcLTiuzKILne8Um8WOEpgKsQ1PD2J6pZnW2GBXCK+oW
         b7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725508; x=1695330308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXhMN6bGqnJggKKLO/4TPQFnVFdhmWWVa7skOr7EcB8=;
        b=iMKMH0mejeomLAvtaph2Bjp+NyV/bv74pl482GJujd9SiIzOCmMonSLxd1la+xspcS
         IaXi1+8462F81vfjMcmxOdyLyOIDdOCZKdCKT6p/+ddlRHx6vGvq0vsPA2ddl9HL8GMF
         i6fMSlbT5eNDOJ64As0VF//4lnmTBQx5NhIlIDgXqqnGwnVlBfEzgdVLMThE/WG8zPt/
         Y+GetJUhIGJ6Rgtw9KkV0YS4LwIRyhBXOMUBOMomuKBfmyNLksJWi5rY44Xik2EKkyS8
         U0eBpxQN3Q4HFzyFsyw6skVhLI5Ipf/zrXG76nRaiUAGOMd24aGaeRSTg96Uf07lgGjF
         8H/g==
X-Gm-Message-State: AOJu0YyV5LwAb66iCgRSlx8H12BH36MYlXGU+niGquJ2syzOxnxhVK6P
	ooB3KcXYTK21xoAVdRC9dOv0Rjk77NyNrbMKh4njLIzW4ZX4NyzfK6uf98oqQ0T4JujYDFNOzgc
	t16eQCtqSNvPUOcr9OadiCH1aL0/VyI0HDBTIruWQQALpon8jgQ==
X-Google-Smtp-Source: AGHT+IGI2D9XWQKji+z7BtupmR2kkWhx+xOBty7hIfVTjdRPqhTUDncVdW97+QXgcVjNaC3FDLQCpxo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:9850:0:b0:59b:5a5b:3a91 with SMTP id
 p77-20020a819850000000b0059b5a5b3a91mr104601ywg.2.1694725508369; Thu, 14 Sep
 2023 14:05:08 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:50 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-8-sdf@google.com>
Subject: [PATCH bpf-next v2 7/9] selftests/bpf: Add TX side to xdp_metadata
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
2.42.0.459.ge4e396fd5e-goog


