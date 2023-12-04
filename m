Return-Path: <bpf+bounces-16635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC379804084
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611F4281256
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08736AFB;
	Mon,  4 Dec 2023 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="rHkSSEtY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5fkODck"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44FA18F;
	Mon,  4 Dec 2023 12:56:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 46C2C5C022C;
	Mon,  4 Dec 2023 15:56:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Dec 2023 15:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701723418; x=
	1701809818; bh=tXj3x6eY8vsT5+TocaSwBKV9SbhnMSnULNqJ8i4jISo=; b=r
	HkSSEtYynt0S9qFqRUmbLLODgbBYDPjNBFS8JA5hFCVDhjGZvwkNYPlRcwC5NBsa
	PV7r8hmSoohudI4tpRRyxoJTCjfo/X1kpLFGOFwEb782e0zj+oBmPiweq0IayVDX
	BdPd4aiNo/uDmmXEldcMIS+C0IYYiafxVwjLRavIHzwPXjiuCuJ8w+foKIO9WDuN
	5xKqHTddUTCIE+qelsnNtCoPPW+oAwpVmBM2r8g1nviyTLU9t1ivkv45xPxYF3u1
	M6tJYHvZgzIGc3XRyGEPnq5rVRBozkWI0LTXEpBP1Mhjn1Pz3CvMica8SfGdOOHk
	1i94nJODY6Zp8gJpab5NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723418; x=
	1701809818; bh=tXj3x6eY8vsT5+TocaSwBKV9SbhnMSnULNqJ8i4jISo=; b=F
	5fkODckQaeWCoS2rJ2cLpXu2ZTXbG2c05MIp0yxtQRuhklvn4t+PEicjnOOLBsIk
	hYU3IR53AaLMHAUb8hdkeGF7q+gnBX9nGQH2jIdmz/nddTYNzPfmomWbu5ed1Q/n
	tfHO7Dkby6Etz0bn6WGutzLiwvijotdCWIxFWdrvt/Vv98vbqObqQtLNCNFp4bDt
	i8DIP6D7rRezaOP2yx8IHUFEapHKpiz3RDeS4ho2tYw7rfSU4OtvocKabGsUasor
	WkiM8F/ggkw862/IZKwFpU4lblb4PbLe7ReoEdoHF8P56CCoGpg2xB3HngJpsWHp
	PnGw+I6uj56ZfEDek/NqQ==
X-ME-Sender: <xms:GT1uZTuIUinow1_iWRFR3Wv2Nd1eI_q0rjJPPZV2XAzykN5qG8M1oQ>
    <xme:GT1uZUcf48aE5DeG4BSXn-j2lYEOFh4jaQGPpFHP5JuttzmaamXygz9k__G3JMVOz
    Dj7W696SM6Aj1VddQ>
X-ME-Received: <xmr:GT1uZWxzohvwu1XE9bwhxBkebnCbtY94Yrw5gP56DvM3DuWJuUJDxKXPgOsHNP32FdH0QMLWlmcKIosFbq0grs7WA7RH4irxxteW_4P17xo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Gj1uZSOZUQw71iFCBv-V_WTIoMHJXDMrBN2SG53UwPdIWk6z6jiiWQ>
    <xmx:Gj1uZT9q21CESBon1SqqVfQX0Iqc1H6W82SBZs37WnGLH-cIMd4NFg>
    <xmx:Gj1uZSVz26PNlN5-Zr7hcVDhDho1JL51F2SgzIk8dh90VIMcWNw7Nw>
    <xmx:Gj1uZbPjmoEcIu4Jneo6KXsgIrpJ_0vWrt5Er-o9QonNAuC7aHR95A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:56:56 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	Herbert Xu <herbert@gondor.apana.org.au>,
	steffen.klassert@secunet.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	edumazet@google.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH bpf-next v4 03/10] bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
Date: Mon,  4 Dec 2023 13:56:23 -0700
Message-ID: <66e92984df48e03a518580f2d416a6fdb5bd4b0d.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
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
 net/xfrm/xfrm_bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/xfrm/xfrm_bpf.c b/net/xfrm/xfrm_bpf.c
index 3d6cac7345ca..5ca780526607 100644
--- a/net/xfrm/xfrm_bpf.c
+++ b/net/xfrm/xfrm_bpf.c
@@ -198,10 +198,26 @@ bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32
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


