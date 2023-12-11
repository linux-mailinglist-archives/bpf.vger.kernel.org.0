Return-Path: <bpf+bounces-17441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC7F80DB6B
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 21:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698B51F21BCB
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E50053E3D;
	Mon, 11 Dec 2023 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NwgRGCpT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1YRYnJbR"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591C1E4;
	Mon, 11 Dec 2023 12:20:34 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C34965C03D8;
	Mon, 11 Dec 2023 15:20:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Dec 2023 15:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1702326033; x=
	1702412433; bh=wvipjySugI619NXNdRelseHYrba3lRKAMvJgNzRoOuk=; b=N
	wgRGCpTOXc3wzmvq1QtNsLHZfWBPf8XUYx+Qkn4dGq47VBctPVoT/F209lSG4pPr
	VnxUGr/PjAlURQCr+wPwSOd8P8d1FrksHxWRyMuRfyidNoNgULXnInnSr52RkKVO
	nQnxD5Kmn1kWsVGxUxpxxRG6rf9lqx8h0nFNcqsFrVes1gLahIpfD3OVQK7wm+gc
	4oxAAu5uWFYB/t8m1H8NLEDxWc/ePA0NG+Az6+KV+foxFqDwoiUYLEbP6cLQB0ge
	/GyTAfHPYz5DBj+oQTXYgsxzh1HOzsx8IUBcdFvE2VuZLxE+jtff1SSuJ5Yh17al
	U5/s449iu8dppjsFLoFiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326033; x=
	1702412433; bh=wvipjySugI619NXNdRelseHYrba3lRKAMvJgNzRoOuk=; b=1
	YRYnJbRbgtCn7zOXPOeJ1usXbCfQUyfJyJlmPd4OkwDkFaqGj1Oy5dioSM2MXsx7
	yUfWfXiglNIW5ijmjRkDENJiwEKjUhbRe+uhjO55EU3YCWTgmGUKuAsvsVMPZgX6
	ISL3ijOBTDrRSVGnb8LuBWPyi8ZeHg6DG5u7OLnD5/VvHR51aitYGKMrE8OF66sI
	xuSnVhAU7/ij5lOpAqlfgIetWyp4zsz/jItbP20mfKe/WVdhMCjSdPFwsq9pGyAS
	wW6EmlVZF9y8tDvJPDQWnThDl7rxewP1gsTu+9TgckYwsSYmubn1x18kUyCkSLxR
	5P6mfvFGTMdJhsvLdgJug==
X-ME-Sender: <xms:EW93ZfN1R2dStXm2CDZLvM6zWcA5mV8TzRmOQ6IXaHqgRz33Z-HfmA>
    <xme:EW93ZZ-mX-sRNS8r5Nf9f5zUxPRHEtWRXb0Zd1WDZtNzJzl429qcU6-WVITzzHF8Y
    FQmYOGYBj7oRd3lZw>
X-ME-Received: <xmr:EW93ZeQjYZt2gnXmXDV-InV7y9iifdswRSENFy7qz0z0LfBMREXJkYFBngOD-ChoOaRQSqA6lJvX8RvM9yHEubXyDQe3GGmL1hVN424Q-eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:EW93ZTuMroGTfT3fdqBOM-fpOsSfL7GQqsHC6C-ojOhV4cv0OwtZXw>
    <xmx:EW93ZXd79rUGeTPGLotgno63YwBm3BmsWYkUCv_GS87zMbvxjaMOpA>
    <xmx:EW93Zf0XenFcoBD5aLGWqNT2eIMcLjk92ukLj1ZDRW5W9T_a24YreQ>
    <xmx:EW93ZSDHDmyS7os5m2RMhnqTAMz74oeaTZidj2HoAsy-JUr0BovCeA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:32 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	ast@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	steffen.klassert@secunet.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH bpf-next v5 2/9] bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
Date: Mon, 11 Dec 2023 13:20:06 -0700
Message-ID: <45124c8da4d96f4e87da540dfe41b3fd7aea878e.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
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
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/xfrm/xfrm_state_bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 21630974c27d..b84adec4451c 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -96,10 +96,26 @@ bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32
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


