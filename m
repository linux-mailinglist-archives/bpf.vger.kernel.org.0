Return-Path: <bpf+bounces-15683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4D7F4F3B
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22065281375
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401D58AC8;
	Wed, 22 Nov 2023 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="WbEIaFB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Q9Mov8Y"
X-Original-To: bpf@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133D1AB;
	Wed, 22 Nov 2023 10:21:03 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CD3C35C0150;
	Wed, 22 Nov 2023 13:21:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Nov 2023 13:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1700677262; x=
	1700763662; bh=1dQDEOh8HTBoY0VDz9uX6NM7X39IZ5Fcq3iL98Lsjko=; b=W
	bEIaFB5RMblwglobGDqjQZJgQNdzxHC4uLbYHHPbbwYVAtJBNI4xSjlJ7Oa4Es8X
	yjPYJG1S+qdaoJ0dQYpv5Bm00UC5sIrDgjPDHHYuYu8QDIG1iekzscBLDMalXrWZ
	RdPFItbBo6F663rAnwSpYP1BA10Z6LvW0DCx0m0HTuvFNthGazCNjzAO7V9jmgjv
	6z76wOQp9Qyjz0xhTQX8Yw02n5GitAninYKeLBqR7t+Js+DN3HlW8QvA+N/89Mbg
	U4NakqMumSFfRj85vpAW06FnNGR8A2q/J45N25LE7dhweaFElnDeiDkGPtFEaPbz
	Ln4SMq6BGuV+kCRGf4jbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700677262; x=
	1700763662; bh=1dQDEOh8HTBoY0VDz9uX6NM7X39IZ5Fcq3iL98Lsjko=; b=1
	Q9Mov8YxcEZsHKUjAR6PUL+qQNc0RYCYLfSsjgRJ5k79mgnV/e3oepx7n2D5i03b
	fjwUlNn+SJ4NSyTWfD2Glp9QOO7w2R39fB82PLA2uVM9/Ed+utYKoHv1MYhGX2pD
	cs/TBJilUT3ff3n0Fne8wQsA0UKaSAPLYfIUaqCWL0lStm/+moh2gLxnhRxJydVM
	tKa7WksFokIyt9mBVXk0GLuHrR1EqeXh7Z/vlQ+JwlLnPjxHvFZA28lnqgZAQR/p
	wTL8KAQzCpYF2g0VD9ahWaQxuUAq/47GUz8XZWL6C56RuqLATv3icnoPEE6TUhUG
	PBVgeaNzzR7dnqKQkrSeA==
X-ME-Sender: <xms:jkZeZZL2RRAT2SKS0TsE_ZkVmy9_EchcaPSL_6SUsMXwLnni5i3eww>
    <xme:jkZeZVJE3_sjUudfL_rKQA45Mqe90_dOSUyOQwqy0a9orB7MsRzjDUVY0Fgn6I4cD
    3oY5FJ8_1SFvMsuXg>
X-ME-Received: <xmr:jkZeZRsbauRZWgc3dRah0GK2Xa7RQtrqGeT8V67kDn14CHBUfoCQN3VQJOOA4kF1DetJbVR1L6saGy6wCJl1aFM6StqV2SBQi-z-Fk49AbIx7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:jkZeZaY4T0ENNnXX6swX0PPVLQI92t5qNcdfZWexBOtobpKP5iMPeg>
    <xmx:jkZeZQYH7GQPI5EPk-gRCmMMivaoVTYBgemkaY1sZVocuQGb5RiUIQ>
    <xmx:jkZeZeD9PDVB9IIcv15fyHZ4VZhq0iWSKwypVvfddRXK2G3A5hbeUg>
    <xmx:jkZeZWwjjMeGkQclpaT64S6MRZB_IAvtg7Ok3vjdWwhA-wj_1PSqkg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:21:01 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: john.fastabend@gmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	davem@davemloft.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	pabeni@redhat.com,
	hawk@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH ipsec-next v1 2/7] bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
Date: Wed, 22 Nov 2023 11:20:23 -0700
Message-ID: <c52cc759c663f51d5e8b755f555dc02d84917a7c.1700676682.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700676682.git.dxu@dxuuu.xyz>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This kfunc releases a previously acquired xfrm_state from
bpf_xdp_get_xfrm_state().

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/xfrm/xfrm_state_bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 0c1f2f91125c..33d1b00fedbd 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -93,10 +93,26 @@ bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32
 	return x;
 }
 
+/* bpf_xdp_xfrm_state_release - Release acquired xfrm_state object
+ *
+ * This must be invoked for referenced PTR_TO_BTF_ID, and the verifier rejects
+ * the program if any references remain in the program in all of the explored
+ * states.
+ *
+ * Parameters:
+ * @x		- Pointer to referenced xfrm_state object, obtained using
+ *		  bpf_xdp_get_xfrm_state.
+ */
+__bpf_kfunc void bpf_xdp_xfrm_state_release(struct xfrm_state *x)
+{
+	xfrm_state_put(x);
+}
+
 __diag_pop()
 
 BTF_SET8_START(xfrm_state_kfunc_set)
 BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_xdp_xfrm_state_release, KF_RELEASE)
 BTF_SET8_END(xfrm_state_kfunc_set)
 
 static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
-- 
2.42.1


