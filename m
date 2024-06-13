Return-Path: <bpf+bounces-32133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26829907DF8
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FD1C20777
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9914374A;
	Thu, 13 Jun 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C8y9bqEg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219A13D635
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313535; cv=none; b=Nbow/krCCTBBj5BJbgIg1cMw+s0V8qsyl0sTD7dX7lbRIbycvUOEzbXqPzB7c78gsA3gDRQC+wqqLcJBfXjKJU5SBHKnQp9wVjS4vugfYzM8ujbAYX7Iq2qdGpuY2/2xRjf+oeCA+/jVlDDCEzcQreMySA7Hj9U96X54P6ONWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313535; c=relaxed/simple;
	bh=wi4URgQNfa+usbkN7/rYQSLToWZZM0qyVlabCop+/4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRHZpGkWDRyTDUAEbpLJjHdNbZAFe18LrNtZTzn2PDNu3B7FiQzWa/KXtNl/pXV9E2gzXZu79iuVx98KPp1hBJtlIlpNUd8HmEmeiJDoRtnMv25SHcrh4cBzuma1Xc4WTLTRZU4qjcbCVaBWhY12/SWipteQ2+uomc80RhUro5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C8y9bqEg; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45DJYD21003272;
	Thu, 13 Jun 2024 14:18:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=pAQ41KDf72FEWbOSt8+ttKfR1q0F6kHf+1YmZSl0quk=;
 b=C8y9bqEgVyQZA6FoMdb8WxlUIJ5+XnHozEv99bOlMCPFM9UDbLQ2TM5fniE1PsLdFZIm
 RD75NxuXwIASezpY52xshn6Cb4+i8hJrq4+Fqqvhq995cPaB9z3S358awm8txtjcSAXI
 g6KGxieIXCENKvNwZj25BBXWnTwBKMOLx4G67eLxKv9lTUBaMR7gc5ORF1zsWAvNtMy8
 MJh7O/ixAji+VYgJEo1O12UXc0kRy1fqpP2iIq9iQ2PbQ+Zm/crOY4JsOgdFWHabYj/R
 R+Ygl+hzSOSc7baeieNpF3MhYo7vf+8PfXtVqZAcblAvvcxJpeNc0KG12u0ZKx4mqy4f rQ== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yqd9gtyxj-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 Jun 2024 14:18:33 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 13 Jun 2024 21:18:29 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>
CC: <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>
Subject: [PATCH RESEND bpf-next v3 2/5] bpf: crypto: make state and IV dynptr nullable
Date: Thu, 13 Jun 2024 14:18:14 -0700
Message-ID: <20240613211817.1551967-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613211817.1551967-1-vadfed@meta.com>
References: <20240613211817.1551967-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 38GVRoO4KG9ZAAyqFzmOGEwCZrx3DJdS
X-Proofpoint-ORIG-GUID: 38GVRoO4KG9ZAAyqFzmOGEwCZrx3DJdS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01

Some ciphers do not require state and IV buffer, but with current
implementation 0-sized dynptr is always needed. With adjustment to
verifier we can provide NULL instead of 0-sized dynptr. Make crypto
kfuncs ready for this.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 kernel/bpf/crypto.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 3c1de0e5c0bd..94854cd9c4cc 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -275,7 +275,7 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 	if (__bpf_dynptr_is_rdonly(dst))
 		return -EINVAL;
 
-	siv_len = __bpf_dynptr_size(siv);
+	siv_len = siv ? __bpf_dynptr_size(siv) : 0;
 	src_len = __bpf_dynptr_size(src);
 	dst_len = __bpf_dynptr_size(dst);
 	if (!src_len || !dst_len)
@@ -303,42 +303,42 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 
 /**
  * bpf_crypto_decrypt() - Decrypt buffer using configured context and IV provided.
- * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
- * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
- * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
- * @siv:	bpf_dynptr to IV data and state data to be used by decryptor.
+ * @ctx:		The crypto context being used. The ctx must be a trusted pointer.
+ * @src:		bpf_dynptr to the encrypted data. Must be a trusted pointer.
+ * @dst:		bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
+ * @siv__nullable:	bpf_dynptr to IV data and state data to be used by decryptor. May be NULL.
  *
  * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
  */
 __bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
 				   const struct bpf_dynptr *src,
 				   const struct bpf_dynptr *dst,
-				   const struct bpf_dynptr *siv)
+				   const struct bpf_dynptr *siv__nullable)
 {
 	const struct bpf_dynptr_kern *src_kern = (struct bpf_dynptr_kern *)src;
 	const struct bpf_dynptr_kern *dst_kern = (struct bpf_dynptr_kern *)dst;
-	const struct bpf_dynptr_kern *siv_kern = (struct bpf_dynptr_kern *)siv;
+	const struct bpf_dynptr_kern *siv_kern = (struct bpf_dynptr_kern *)siv__nullable;
 
 	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, true);
 }
 
 /**
  * bpf_crypto_encrypt() - Encrypt buffer using configured context and IV provided.
- * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
- * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
- * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
- * @siv:	bpf_dynptr to IV data and state data to be used by decryptor.
+ * @ctx:		The crypto context being used. The ctx must be a trusted pointer.
+ * @src:		bpf_dynptr to the plain data. Must be a trusted pointer.
+ * @dst:		bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
+ * @siv__nullable:	bpf_dynptr to IV data and state data to be used by decryptor. May be NULL.
  *
  * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
  */
 __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
 				   const struct bpf_dynptr *src,
 				   const struct bpf_dynptr *dst,
-				   const struct bpf_dynptr *siv)
+				   const struct bpf_dynptr *siv__nullable)
 {
 	const struct bpf_dynptr_kern *src_kern = (struct bpf_dynptr_kern *)src;
 	const struct bpf_dynptr_kern *dst_kern = (struct bpf_dynptr_kern *)dst;
-	const struct bpf_dynptr_kern *siv_kern = (struct bpf_dynptr_kern *)siv;
+	const struct bpf_dynptr_kern *siv_kern = (struct bpf_dynptr_kern *)siv__nullable;
 
 	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, false);
 }
-- 
2.43.0


