Return-Path: <bpf+bounces-8419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE917863E2
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 01:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C02D1C20D04
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 23:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D3200CF;
	Wed, 23 Aug 2023 23:15:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271211FB35
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 23:15:13 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4115BE5C;
	Wed, 23 Aug 2023 16:15:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id AD5E05C01A4;
	Wed, 23 Aug 2023 19:15:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 23 Aug 2023 19:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1692832511; x=1692918911; bh=KTpk7xEkNI
	UPNXzFGoJxed5Ue7eQPU14WZBoOExDx/w=; b=Ydy8hNkiQ0T0JOHIPI+d14SD7i
	VBQZ+Rmq3V8WvJeaenFiD1fck/68cTqLcW6OQzXH24uKE2jwm0ztGN1+OKgWztGV
	+YDPxIj5DCOq8rMSmsEv9G87QReLn9F/Bhc14aq45FACUSXAQ0cxKgOMh2rlfrqJ
	WhZd6TAz7g3vTwpCBxco8LN+LD3KhUSDq7O8ql7P+YwoAWE71A4LCd2SEUGJvUhp
	mDUDj7lpCmLTFlHZz2a3JHEDfuD9LaR574xZX4JrbBAb9fi41W7TqWeuYy7WvQ1j
	1AoPo+2wEtgKKkB+4f9WAoXMbtbdFCLZL9Ia777hY6rad6oqi9vlJaOubAUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692832511; x=1692918911; bh=KTpk7xEkNIUPN
	XzFGoJxed5Ue7eQPU14WZBoOExDx/w=; b=q+KHa7DcKvvipBA0jnAxxjlUqWRiF
	QrZwiepBUdfdkIRrolacuNdsQGM3xhI/pasoaOcg+ExGPpt/l2gr9zkNFChLqKb2
	8TJ3wGFOqQXSGVRG/oHguScsy7Pnn41NGNEokM+AB/LGeF1rYQm/dS12UiIpQs2z
	YK0r65ZwFDpWz2dN5qwVtqj3b/2DHIz8RMqMYnbiviAn0wh9sdpmlasR0tgWhM0y
	tEAK2sSx4AlH2OPZnmXKOI3ZYfbBtzvRWgZxyFqoxWgq2pE7Ocf9PoXXj8xBiw+F
	P1FNaAcNGBIfVc3mNY1FYH9/6ZugN/uqH5xmtRo2fDQrrvdgE0X2J0PnA==
X-ME-Sender: <xms:_5LmZLTn8NkewjOI96eAhLiJRnT1IxWOf0n9kPAM6mZYww0clMhFqw>
    <xme:_5LmZMx7pDU6ha_MjUZihrm_gkJs0_wVCtjN-vsB3SW4KNjbLNdMRaW1tadUG-Ikp
    ViR3KNJMSAHI6Yhfw>
X-ME-Received: <xmr:_5LmZA1Wsp1oqB7u3q68O6lBNuUeolocpfgeQ7we4lwgTFU4oN3Xu6geyqtak4t96-GUVxq4SLbGCuyoD3VZ0IxJDsrFt3gX0UnrOe0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvhedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:_5LmZLC9HT3uuGLuw3KcjJoJeOjjDeMir8NdDM4l3tXCHKJg1ax0Mg>
    <xmx:_5LmZEiomXgOpQbcYq8I9kPaWDdnouN56mYCOBVaZhRwWGi3fkXrGA>
    <xmx:_5LmZPry43lN9fwFK2AzyITb8ZrstBeKm7Lc4q33L2t0MeYRiRO37g>
    <xmx:_5LmZDq4pNKMJ0CBeyz_ZkdZwWVYXRKYNk5SPmMMAgb4sPEKaBpB9A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 19:15:10 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] libbpf: Add bpf_object__unpin()
Date: Wed, 23 Aug 2023 17:15:02 -0600
Message-ID: <b2f9d41da4a350281a0b53a804d11b68327e14e5.1692832478.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For bpf_object__pin_programs() there is bpf_object__unpin_programs().
Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().

But no bpf_object__unpin() for bpf_object__pin(). Adding the former adds
symmetry to the API.

It's also convenient for cleanup in application code. It's an API I
would've used if it was available for a repro I was writing earlier.

Reviewed-by: Song Liu <song@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/libbpf.c   | 15 +++++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 17 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c3967d94b6d..96ff1aa4bf6a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8376,6 +8376,21 @@ int bpf_object__pin(struct bpf_object *obj, const char *path)
 	return 0;
 }
 
+int bpf_object__unpin(struct bpf_object *obj, const char *path)
+{
+	int err;
+
+	err = bpf_object__unpin_programs(obj, path);
+	if (err)
+		return libbpf_err(err);
+
+	err = bpf_object__unpin_maps(obj, path);
+	if (err)
+		return libbpf_err(err);
+
+	return 0;
+}
+
 static void bpf_map__destroy(struct bpf_map *map)
 {
 	if (map->inner_map) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2e3eb3614c40..0e52621cba43 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -266,6 +266,7 @@ LIBBPF_API int bpf_object__pin_programs(struct bpf_object *obj,
 LIBBPF_API int bpf_object__unpin_programs(struct bpf_object *obj,
 					  const char *path);
 LIBBPF_API int bpf_object__pin(struct bpf_object *object, const char *path);
+LIBBPF_API int bpf_object__unpin(struct bpf_object *object, const char *path);
 
 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 841a2f9c6fef..57712321490f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,6 +395,7 @@ LIBBPF_1.2.0 {
 LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
+		bpf_object__unpin;
 		bpf_prog_detach_opts;
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
-- 
2.41.0


