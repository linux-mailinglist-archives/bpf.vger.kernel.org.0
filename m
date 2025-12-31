Return-Path: <bpf+bounces-77602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5D3CEC551
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CCE33009F9F
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16A29BDB0;
	Wed, 31 Dec 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyoXFtXE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB129ACF0
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201097; cv=none; b=FNVkSU7ODdJ58Yg2wHNavjHJWs3LQdAvoMPVQhHoouZkRD1liliDf1lRI6UFVwpTwCuXFGI++xQ9x6diJ0hnmNIzeqmFYCizDV9zMkfa18ux8hYpcFH2UDEn/q9jSjCa8XoXwzk82Rrero0PMwKXsWYbYs5xBEhYbcThcXVTqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201097; c=relaxed/simple;
	bh=PvlDGtPWoyByCVtPEgjWDNEKiVkiNakXleqmUDrZ3dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2W5xuZuUbO6Z+YGLG318CyKfGN1M1MZT/20goIp3FSEh6o7YAtHElx8Xi4UO1GghVymNGajOCXmXTTVfhIBM14HGDlWi0VNngCtTnYzd0LBKKXH39fNQ/CT9dm9EA9yLxaOkhJBZcqsNH0JEz1+CyoZZcWycyPq9uW8b9eyQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyoXFtXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155EEC113D0;
	Wed, 31 Dec 2025 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201097;
	bh=PvlDGtPWoyByCVtPEgjWDNEKiVkiNakXleqmUDrZ3dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyoXFtXERBh4Gtfhl2/ClJRn+hE783HB7yFotnjEO2ZaqqY1tqKzJSHH8pQXOUyz5
	 Zm3uM646GORUZy9UkoE8RyM1Vw5OqxX6PlWNRnv0XDwZZjy55sCgd9ZHhFK9Q/2dV3
	 Y6OvtFnwxIXptcWvH4U52ihUrS0FWDbBHy1SZyHehvpMW4xL8n0+KX1JXZBZGhZkeQ
	 uOKo4vs2d2hnvglK575CWhUe+B0iFInMoEktvQ0x+dbkHaiYeYP2T/yscstxxsP+mG
	 iWJiB9d5s2UHplCstYWBM3hIDrWap+v1rIzgWBSASIsZJ7VylTNj42MHqyz7/JJDqf
	 6iDWHWKrrAULw==
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
Subject: [PATCH bpf-next v2 2/9] bpf: net: netfilter: Mark kfuncs accurately
Date: Wed, 31 Dec 2025 09:08:48 -0800
Message-ID: <20251231171118.1174007-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231171118.1174007-1-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
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
 net/netfilter/nf_conntrack_bpf.c | 38 +++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 4a136fc3a9c0..a9f4b7d23fe0 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -291,16 +291,16 @@ __bpf_kfunc_start_defs();
  */
 __bpf_kfunc struct nf_conn___init *
 bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
-		 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
+		 u32 tuple__sz, struct bpf_ct_opts *opts__nullable, u32 opts__sz)
 {
 	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
 	struct nf_conn *nfct;
 
 	nfct = __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev), bpf_tuple, tuple__sz,
-				       opts, opts__sz, 10);
+				       opts__nullable, opts__sz, 10);
 	if (IS_ERR(nfct)) {
-		if (opts)
-			opts->error = PTR_ERR(nfct);
+		if (opts__nullable)
+			opts__nullable->error = PTR_ERR(nfct);
 		return NULL;
 	}
 
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
@@ -358,17 +359,17 @@ bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  */
 __bpf_kfunc struct nf_conn___init *
 bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
-		 u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
+		 u32 tuple__sz, struct bpf_ct_opts *opts__nullable, u32 opts__sz)
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
 	struct nf_conn *nfct;
 	struct net *net;
 
 	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
-	nfct = __bpf_nf_ct_alloc_entry(net, bpf_tuple, tuple__sz, opts, opts__sz, 10);
+	nfct = __bpf_nf_ct_alloc_entry(net, bpf_tuple, tuple__sz, opts__nullable, opts__sz, 10);
 	if (IS_ERR(nfct)) {
-		if (opts)
-			opts->error = PTR_ERR(nfct);
+		if (opts__nullable)
+			opts__nullable->error = PTR_ERR(nfct);
 		return NULL;
 	}
 
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


