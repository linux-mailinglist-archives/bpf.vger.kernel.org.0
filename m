Return-Path: <bpf+bounces-16459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1493801451
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608AAB20F0C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7A65811E;
	Fri,  1 Dec 2023 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="N5qepEM+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ddfw/66q"
X-Original-To: bpf@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73606F7;
	Fri,  1 Dec 2023 12:23:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id D42845C01E6;
	Fri,  1 Dec 2023 15:23:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 01 Dec 2023 15:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701462235; x=
	1701548635; bh=gTC80DkbSwec6++klwVY+AjSyF2q8Jrio27MwPjAqCs=; b=N
	5qepEM+SjCrEYitQmzwC1hP/Ky4ABTGj/pnIWWXg/Rp9jZTTKwj1gXjEzONAf5Fa
	LbxVnTGkblBiwQ5wZNt8R0sgOMQOCZq37OTW2IbY+Drf3/dkW9pha0LFoS598FU5
	7fc3x6q0CoiAoAPd9KjTKXbPM49WDVKDfeT/H50+xWKN2xq1yxgdfiC65Jt0Smd8
	h7lvEA1DvX/AILJEU9Xh6NhmH53dCg9xydKxcJz8Ibqo43WX7Z+R967j5kUgNq0w
	P+yGvd/bNpSAD6cZ1tdOAke9qA8LBX02jv/wj/B57Uj3OQr4dRBvtmWAaqRZDiUH
	1WI0X1fPm3Iale1ZTBWMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701462235; x=
	1701548635; bh=gTC80DkbSwec6++klwVY+AjSyF2q8Jrio27MwPjAqCs=; b=D
	dfw/66qLjQd0Zbq9BHdmH0TjFLXYjk2WsdKiNWnjEGPXy2XNWOFJObm7HeCX8tl2
	GWw2xE71fPCi5eUUe4bTyVIgx85Kkp+zcSMK/fg6W6yg5L/ucEYovtVqkk1+Oa9g
	buDJqCJTFtVtZmooP9wM2lp2W9F0VOKzGc3CnLHAOdzuNrKKl2B3elmW6IJd7bc0
	gyVXAdpD0ZZ9ZjTmiYqlj7CD3Ae67xkoDNGNP/FxtZ1LemWs3HKueZHJqeZn8PVZ
	4fxgAD+K7wuOCKybWWnWYnmdCjygb3oOnha0snU80tBCYCsxKCWGruQCQKVi8mgG
	8bnqrf/UEUcj/MDUGgo8g==
X-ME-Sender: <xms:20BqZQfUgmwSSzHcd_uThK_RAoVDPN8orM4cBPmBigvR-IHmGGD9Bw>
    <xme:20BqZSOtnI6sqXfZBCbraIQHOr-f3AmAk_aXHXrke1rirpuG_A4QiuGI8Rxb_JhxK
    cLI2drrzUO-Fqtpcg>
X-ME-Received: <xmr:20BqZRiC52mZ6xoytM6s2bIEe72hy0NkxVOmInc2B6bnJBfb8L05i9vslkVb2CCO80ffuawluH5qB1lpgnmklveEiLcw7BhWVjWRnzwJjC2hDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:20BqZV9gdxlG5LGSBsTITsc4CaOv8xLEvE3ZPDcdH8ZhWgAdiKrANA>
    <xmx:20BqZcsmQY4IwdsNYKxaOLOd3SjjZBbpgSS_2CnY0z84YRfVDV9EcQ>
    <xmx:20BqZcGComiR7GiTzUcFnk5yRSfeGzJpsWpnPLTpHkFgScpeS2XZDA>
    <xmx:20BqZd_-yJobK70zK1mHb8wLXwA2PzY0VnAmzqR2LHlKwTSHq2sQ-A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:23:54 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	daniel@iogearbox.net,
	kuba@kernel.org,
	edumazet@google.com,
	ast@kernel.org,
	john.fastabend@gmail.com,
	steffen.klassert@secunet.com,
	hawk@kernel.org,
	pabeni@redhat.com,
	"Herbert Xu steffen . klassert @ secunet . com" <herbert@gondor.apana.org.au>,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH ipsec-next v3 2/9] bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
Date: Fri,  1 Dec 2023 13:23:13 -0700
Message-ID: <e35bf393128407bf75e9d2fb9dca6c8e31c2a677.1701462010.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701462010.git.dxu@dxuuu.xyz>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
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
index 1681825db506..1485b9da9425 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -94,10 +94,26 @@ bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32
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
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(xfrm_state_kfunc_set)
 BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_xdp_xfrm_state_release, KF_RELEASE)
 BTF_SET8_END(xfrm_state_kfunc_set)
 
 static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
-- 
2.42.1


