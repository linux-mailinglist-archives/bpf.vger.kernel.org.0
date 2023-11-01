Return-Path: <bpf+bounces-13842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA8E7DE7CD
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E75B20F43
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F311BDFD;
	Wed,  1 Nov 2023 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Bpxqexu3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9MYrB4b"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949D1BDEB;
	Wed,  1 Nov 2023 21:58:43 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993C122;
	Wed,  1 Nov 2023 14:58:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id A075632009F1;
	Wed,  1 Nov 2023 17:58:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 17:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698875918; x=
	1698962318; bh=BGnv0m4XviszG3KfpaWG6wdMA/qgxN6Pjaog3JfQZ6k=; b=B
	pxqexu3qJEC6HOvfCQgPzRi+zq5VoTjmwFJ7zfr93kUfZrVT3Sc0nl3t/BW7RfOg
	DNAYHbhKwUA0lCJ6/uwvnMffosnIHPguKjkSReLlKj0CvAWybx59SYBsVmYSnh79
	gCFpdHwifcsTEDBYUFm1LUG8HT4ToRIH7KshYRRK9OWAK5oSGwi4LhKT1VznamrG
	KpidjXZ6h4xe17T4uvYDl4WaOs2SGY974PLhFqPXa20+k1Y9dMEQVPfxZIEO9Y08
	j0GhAT0N1CkeDXuTuaikvQneyG3Z5NqlH9p8sfG1Ut+mgmTc7A/xFjr8uLXXUX6T
	ltcxBf/e3Y92Tlqigg8Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698875918; x=
	1698962318; bh=BGnv0m4XviszG3KfpaWG6wdMA/qgxN6Pjaog3JfQZ6k=; b=p
	9MYrB4bRqz5zbpP8TPkvOqrQAH+hjXcWp0OQOfIhcuKY1U+Ez6DJx4SwS3orMEir
	OpMZJiB15qVz/k1Gxxnly2kF5mDiVAFpa2Jbe2JjBUyQrJrxdODcj4v3Jp8tCCY5
	Q5SEh7DCUpcw3aA91Kvwmu229li7u7sLsla/NRASyCzDHoNAXJmpyr848/bOEKFt
	NqADwApeBi68oqA4BcH6km0IoXfKnNwpZlWTtSO7pMwvbpH3Crl51fzsLYk0/V//
	qOPlhddyX/NPfsRfHHZKSSaCz9F1Fbrp9dQQAwFoSuFxjk7a97LOnbQCUNKIBhk0
	d8vABaQrUMjXJxxEmxVdg==
X-ME-Sender: <xms:DcpCZVQzJ7rR2hC6l1P8SOirKjEWq9Du3XyrEMwSNGC0W_YAazxXGQ>
    <xme:DcpCZexuNOzJrAsz6WFXXYMMF53qDpIELLbMnMyhGb6Eg5F7e4AjOEjaw2ljh26WZ
    bobfySd5Zbu_OIyKQ>
X-ME-Received: <xmr:DcpCZa2a647323rgB3mr5DALjOj85dmGv9TzkirkhJQ_TFXBa9jmwBzR5U4wQOQjp8810w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:DcpCZdC1p2nva6MwtlLczNFlwwr0y6XjPhYmtT-NlZYOhqekRGr7jQ>
    <xmx:DcpCZegNxeHfQQUYONeCIh_4NZ_aag47cJhB6jtAmvsdl8BrAvmR3A>
    <xmx:DcpCZRr4K643GQG5IelP1vehc4wkagnvUuBfrm5X1MqRftYNOd0Tng>
    <xmx:DspCZVTW2i7tR8FCnLVq9rzNqC71EY-Dm4gVgJahoyyJBzNSOt1fcA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 17:58:35 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kuba@kernel.org,
	hawk@kernel.org,
	edumazet@google.com,
	steffen.klassert@secunet.com,
	daniel@iogearbox.net,
	Herbert Xu <herbert@gondor.apana.org.au>,
	ast@kernel.org,
	john.fastabend@gmail.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	antony.antony@secunet.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [RFCv2 bpf-next 2/7] bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
Date: Wed,  1 Nov 2023 14:57:46 -0700
Message-ID: <9f43e62bedf3aa0a230db607fee8bd650ab84649.1698875025.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698875025.git.dxu@dxuuu.xyz>
References: <cover.1698875025.git.dxu@dxuuu.xyz>
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
index 4aaac134b97a..386167c86767 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -87,10 +87,26 @@ bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32
 				 opts->proto, opts->family);
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
2.42.0


