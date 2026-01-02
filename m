Return-Path: <bpf+bounces-77696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B9CEF1F3
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E84213019E10
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F982FFF98;
	Fri,  2 Jan 2026 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWrxAkXZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87D2FF172
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376866; cv=none; b=R0m+ZQGlsiKTO7YZSHzHLZcC7RzYegQTlAVSKl2vQCjtZ6V9cs3bC2Zm/acR22uhGuV+uqtcJiyPqKv0Dh3uYb2ffwmS76OntbBw0EQS4u02V0/10y0LDMH2cxB/RP6sUjt84j7itW6CRhj4vkUNiLB6g+Uxf2UrAfHIRmECaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376866; c=relaxed/simple;
	bh=SF5p6BCEjr05RtD6fCvKUHx5gn2dc4azeSnp4Jy7G8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5ahc72+2liXQrKVPLELyKuqechkufPTeBS2HyiNk4Nvp6BemdoIIQlrqZEHzh/dRXyO/rx1kQbEVMPzB9wlHEx3I+6srFgg8FQ4DLdZvxBZj5ABXbt4SR+y7ydxToENIC/CCdHWVy1WI5EWKGgNDFLRM0Zq/a/GokDEZIsaWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWrxAkXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88F3C19423;
	Fri,  2 Jan 2026 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376866;
	bh=SF5p6BCEjr05RtD6fCvKUHx5gn2dc4azeSnp4Jy7G8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWrxAkXZqoUqb2Ki38Mp/ba1IJDa9Uuwnqw9eUKB4xkkjqQiOH6/dJfnw3Y3qHG+w
	 gnrCm3r1YESX7snt9JE8XKbgUaeongTjjBgaExmKHKjQDjcy4JFmSTuCaRcn1hpAKh
	 0ioN91PRP4kZBdErL3XRWJxGLSO8AHeDR7hG+8sy+8IZ0/I7jdD6CIEAiSq78EXljw
	 aKyfXhn+TVhYFhCJcl7uD+tjrByGLqo9CO3dhkaPOoQlaIdxQSb7cvYQ0QmHtG5BXn
	 Nv7fVnpmTR4oKbF6DM/AVyY2/sia1bRAZ7WP5ptFJ+SQj02Kh1ewKeCIOZFSOwYIRH
	 O9sKRxLw5LOQw==
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
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/10] bpf: net: netfilter: drop dead NULL checks
Date: Fri,  2 Jan 2026 10:00:29 -0800
Message-ID: <20260102180038.2708325-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
References: <20260102180038.2708325-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_ct_lookup() and bpf_skb_ct_lookup() receive bpf_tuple and opts
parameter that are expected to be not NULL for real usages (see doc
string above functions). They return an error if NULL is passed for opts
or tuple.

The verifier will now reject programs that pass NULL to these
parameters, the kfuns can assume that these are always valid pointer, so
drop the NULL checks for these parameters.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 net/netfilter/nf_conntrack_bpf.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index a630139bd0c3..be654363f53f 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -114,8 +114,6 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 	struct nf_conn *ct;
 	int err;
 
-	if (!opts || !bpf_tuple)
-		return ERR_PTR(-EINVAL);
 	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == 12))
 		return ERR_PTR(-EINVAL);
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
@@ -299,8 +297,7 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
 	nfct = __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev), bpf_tuple, tuple__sz,
 				       opts, opts__sz, 10);
 	if (IS_ERR(nfct)) {
-		if (opts)
-			opts->error = PTR_ERR(nfct);
+		opts->error = PTR_ERR(nfct);
 		return NULL;
 	}
 
@@ -334,8 +331,7 @@ bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
 	caller_net = dev_net(ctx->rxq->dev);
 	nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple, tuple__sz, opts, opts__sz);
 	if (IS_ERR(nfct)) {
-		if (opts)
-			opts->error = PTR_ERR(nfct);
+		opts->error = PTR_ERR(nfct);
 		return NULL;
 	}
 	return nfct;
@@ -367,8 +363,7 @@ bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
 	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
 	nfct = __bpf_nf_ct_alloc_entry(net, bpf_tuple, tuple__sz, opts, opts__sz, 10);
 	if (IS_ERR(nfct)) {
-		if (opts)
-			opts->error = PTR_ERR(nfct);
+		opts->error = PTR_ERR(nfct);
 		return NULL;
 	}
 
@@ -402,8 +397,7 @@ bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
 	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
 	nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple, tuple__sz, opts, opts__sz);
 	if (IS_ERR(nfct)) {
-		if (opts)
-			opts->error = PTR_ERR(nfct);
+		opts->error = PTR_ERR(nfct);
 		return NULL;
 	}
 	return nfct;
-- 
2.47.3


