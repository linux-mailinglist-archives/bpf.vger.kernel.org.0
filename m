Return-Path: <bpf+bounces-42652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53139A6E1C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7BD1C22004
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F36136328;
	Mon, 21 Oct 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HyWlcVT+"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE4139D07
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524495; cv=none; b=JYtJ2iVHMOzgoMqb8zBAFtg5zb9WHs1IIZK/DoA7uxff7nDyELzZt/enz5RGMQWgrZMQ7zeG+c7QP0PrsauffDIKiNyk7mPiZSJMxoVe0j9zrD1vZk/DqgL9zxaVDtzB7GuJaJjzCvRq5LwEjXxOkx8LberhO5DoJIO4jAJ80MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524495; c=relaxed/simple;
	bh=ROK/kISiwrecK1XYpL6XvgFYoodPwoZFdX3QWqLtgyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otyVwLy0ntOZI59EcfpBnszWsjHCHJ1wPU7Ma1efH4fcSvSBC7hBSmIt7P/XLIUnVC50XPm/AXO6K4YrfDPoBOoJC6wRR3FFbk00kDq4BuDFCOxd73po+vsRm30FhmJWrIWbIH2v7l/L/zRTNNUdCt87iC6C4qSuoelSnu4FbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HyWlcVT+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gfHC+jpHulDn2Wr5ZX5QAk8mUxZ8R91yD1dlZZ/e+FM=; b=HyWlcVT+0j9tlFen8vZa+SUmaN
	2VFH3M7immKs6Cy+50loGJ5WW+O2DyaYssuCq7fd5EPmYTDMpi3XyyGhWz/bsx0zu4duj7arMaBoc
	gcn8Bhnk1ijIxrpgm88rgqvBTJAvkbxOkcWiJ5u9oecbISfU8kX8rFQzzZGS97QwF/jbCzdNyhYQ1
	fuGNgLuAKpcjPcf5inuvY9cdy6IJaWo8Pea7iCBwZMtlRKWEYFZTxmdZeOZiZRXpZK+dmnhBs7VWc
	qUrIHV4bLb85unXNXFz1Bw1DMd63hB6Abko3d+jwcZmx6DFR+qSUC+PBEF2XTf2wfiFbcbeu3ZGWa
	kSj+SZ3g==;
Received: from 43.248.197.178.dynamic.cust.swisscom.net ([178.197.248.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t2uKJ-000MzG-5R; Mon, 21 Oct 2024 17:28:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	kongln9170@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf 3/5] bpf: Remove MEM_UNINIT from skb/xdp MTU helpers
Date: Mon, 21 Oct 2024 17:28:07 +0200
Message-Id: <20241021152809.33343-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021152809.33343-1-daniel@iogearbox.net>
References: <20241021152809.33343-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27434/Mon Oct 21 10:49:31 2024)

We can now undo parts of 4b3786a6c539 ("bpf: Zero former ARG_PTR_TO_{LONG,INT}
args in case of error") as discussed in [0].

Given the BPF helpers now have MEM_WRITE tag, the MEM_UNINIT can be cleared.

The mtu_len is an input as well as output argument, meaning, the BPF program
has to set it to something. It cannot be uninitialized. Therefore, allowing
uninitialized memory and zeroing it on error would be odd. It was done as
an interim step in 4b3786a6c539 as the desired behavior could not have been
expressed before the introduction of MEM_WRITE tag.

Fixes: 4b3786a6c539 ("bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/a86eb76d-f52f-dee4-e5d2-87e45de3e16f@iogearbox.net [0]
---
 net/core/filter.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6be0c0b86049..26cc64f99d6a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6281,24 +6281,16 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 {
 	int ret = BPF_MTU_CHK_RET_FRAG_NEEDED;
 	struct net_device *dev = skb->dev;
-	int skb_len, dev_len;
-	int mtu = 0;
+	int mtu, dev_len, skb_len;
 
-	if (unlikely(flags & ~(BPF_MTU_CHK_SEGS))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len))) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
+		return -EINVAL;
+	if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
+		return -EINVAL;
 
 	dev = __dev_via_ifindex(dev, ifindex);
-	if (unlikely(!dev)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (unlikely(!dev))
+		return -ENODEV;
 
 	mtu = READ_ONCE(dev->mtu);
 	dev_len = mtu + dev->hard_header_len;
@@ -6333,19 +6325,15 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	struct net_device *dev = xdp->rxq->dev;
 	int xdp_len = xdp->data_end - xdp->data;
 	int ret = BPF_MTU_CHK_RET_SUCCESS;
-	int mtu = 0, dev_len;
+	int mtu, dev_len;
 
 	/* XDP variant doesn't support multi-buffer segment check (yet) */
-	if (unlikely(flags)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (unlikely(flags))
+		return -EINVAL;
 
 	dev = __dev_via_ifindex(dev, ifindex);
-	if (unlikely(!dev)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (unlikely(!dev))
+		return -ENODEV;
 
 	mtu = READ_ONCE(dev->mtu);
 	dev_len = mtu + dev->hard_header_len;
@@ -6357,7 +6345,7 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	xdp_len += len_diff; /* minus result pass check */
 	if (xdp_len > dev_len)
 		ret = BPF_MTU_CHK_RET_FRAG_NEEDED;
-out:
+
 	*mtu_len = mtu;
 	return ret;
 }
@@ -6368,7 +6356,7 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6380,7 +6368,7 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
-- 
2.43.0


