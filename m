Return-Path: <bpf+bounces-77426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EDCDD0A7
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC95330248BB
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724CE348883;
	Wed, 24 Dec 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVreiuQ8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0B3446B3
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604331; cv=none; b=P5p9XTbR0OkDE7ElkLsPtD7xS5aKwAm4YYjVm6GWdB+H8neuE8RpTKO27kz7sP6K1USfvEuQpv/sfreP46rnxWpXyzZJ9fGMHcwfkV3g5Gvbyg46mAOXiI6lwVmRPxRd40iyIJLG6+xohFJf8WC0Lt5Ss4JjgedzcjEf1aXTwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604331; c=relaxed/simple;
	bh=TILpMvOAfl9eNMO0RI9RM1Q86qS2fFiPCzffRJBzrnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8w0HzxErvKEILm//+nJahVrqopziAqO7kFWBQtDBLDXEHmk4hq0QcxiuC2HtMJyw8pjG2BYKkX8RbZ7Ca/c8BlgTUwQV5sCw9cQX5qxBo/3b5kiQ6b+bb41g3RRJOBXgGZ6iMkv/+anvw0lsChPtB0vN+H7kvuRBQxqRC1Y5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVreiuQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5730AC4CEF7;
	Wed, 24 Dec 2025 19:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766604330;
	bh=TILpMvOAfl9eNMO0RI9RM1Q86qS2fFiPCzffRJBzrnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVreiuQ81G4awu9o3f9uM1R4e71uzCPrHfqO+e0N0LQYGQcX536EvtzIoJrVSVqWM
	 o/gCKWj4bg6DsMJI+tMmbEnsJzW40qNwMHfs8SHqY4mbCRMAzRBd6+Uk2zSFmdzys/
	 +D5goCZ2Bk9I7ImE60jhEgxS9jDVrq+Gcu5t+OBdA2hw+6R2btHL2K4PtzqlFrTXZA
	 NV36jzNkSG0ci06AXW4K7X2LptZ4NX+XyqmvsTZ9x2p4zQdTBWT0M6Zp41AV/pio2x
	 1ClaUm0wwxqyvKHkre8PidlgO932alM0EHLlkdTIcSveATkyrbglWkJ3HAsWQeTzOH
	 bK3sqbAAP0yfQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/7] bpf: net: netfilter: Mark kfuncs accurately
Date: Wed, 24 Dec 2025 11:24:31 -0800
Message-ID: <20251224192448.3176531-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224192448.3176531-1-puranjay@kernel.org>
References: <20251224192448.3176531-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_ct_lookup() and bpf_skb_ct_lookup() receive bpf_tuple and opts
parameter that are then checked for NULL by __bpf_nf_ct_lookup(), so
these kfuns expects these arguments to be NULL.

Mark bpf_tuple and opts with __nullable so verifier allows passing NULL
pointer for these arguments.

This change is now required because verfier will now assume that every
kfunc expects trusted arguments by default, so even though these kfuns
don't have the KF_TRSUTED_ARGS flag, all arguments will be treated by
as KF_TRSUTED_ARGS by default.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 net/netfilter/nf_conntrack_bpf.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 4a136fc3a9c0..308e47c2aeaa 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -324,18 +324,19 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  *		    Must be NF_BPF_CT_OPTS_SZ (16) or 12
  */
 __bpf_kfunc struct nf_conn *
-bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
-		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
+bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple__nullable,
+		  u32 tuple__sz, struct bpf_ct_opts *opts__nullable, u32 opts__sz)
 {
 	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
 	struct net *caller_net;
 	struct nf_conn *nfct;
 
 	caller_net = dev_net(ctx->rxq->dev);
-	nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple, tuple__sz, opts, opts__sz);
+	nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple__nullable, tuple__sz, opts__nullable,
+				  opts__sz);
 	if (IS_ERR(nfct)) {
-		if (opts)
-			opts->error = PTR_ERR(nfct);
+		if (opts__nullable)
+			opts__nullable->error = PTR_ERR(nfct);
 		return NULL;
 	}
 	return nfct;
@@ -392,18 +393,19 @@ bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  *		    Must be NF_BPF_CT_OPTS_SZ (16) or 12
  */
 __bpf_kfunc struct nf_conn *
-bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
-		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
+bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple__nullable,
+		  u32 tuple__sz, struct bpf_ct_opts *opts__nullable, u32 opts__sz)
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
 	struct net *caller_net;
 	struct nf_conn *nfct;
 
 	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
-	nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple, tuple__sz, opts, opts__sz);
+	nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple__nullable, tuple__sz, opts__nullable,
+				  opts__sz);
 	if (IS_ERR(nfct)) {
-		if (opts)
-			opts->error = PTR_ERR(nfct);
+		if (opts__nullable)
+			opts__nullable->error = PTR_ERR(nfct);
 		return NULL;
 	}
 	return nfct;
-- 
2.47.3


