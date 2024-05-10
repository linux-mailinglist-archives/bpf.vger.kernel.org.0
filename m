Return-Path: <bpf+bounces-29471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D018C24DB
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0041F25AA7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D2415F3F4;
	Fri, 10 May 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Euov8o4p"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24115F870
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344129; cv=none; b=sCOXXVNIsmgIIMbQXsbIZiQYoegJbIiqs7yYKxBspLPbr7dPtqzBMG3+VM56OKVKlyKqCJnmocKx+D2RQoB/Sl4W1qljvOLN46qHtg5Vd7M2/6A3C609w1f/JIjkPo/Bz8H5XYWPh+gzIPBSYnBeENFCG8gTtC0bPXOjJ/K54lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344129; c=relaxed/simple;
	bh=JGCqVzldKsu5q5rOeaTaLkFAcuBIPGmlnnArLlciAvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrsFsxK3s74VlmB6iJUr80zC3FgGCs3MeI17YadXGtea7Ip90ghW6IrCdh4peLAyT3lyjz668+NZRatgnuY0A4yKH66BjYeAvOQlKoRNeJVAQyO5HoalQoYorH7OXEIkv3jrCJONxSzvMJym8+ruUNnhXy4nIA1NJeLOFLap0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Euov8o4p; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0QAPP021039;
	Fri, 10 May 2024 05:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=42iYzeR3dY17wXBYiPFxQ7skv0KWt2TGz/fj6a748nM=;
 b=Euov8o4pbSsZ+eT9xpIBlLQp14Y4KNMlQz30ge/zgCMPDi3HImMRInoUMVhUOOLsc0A3
 8h2QGH3e6Q0tCBS0LF7GukgfDoqnuqbbP+CFk0hT0OIMfOpqrb0OLQ5LqBEyzPW1XiPT
 xFshz/VByWPSIWrP9sA6AlBiIageKcEFFSyCt4i+tsMzhDeDZUl3L2aqHikELzNeBwbz
 14FdGIrqMfVgw77sPVXoczhPpztHSkqMHtQcovGzEwy2DXnC6NiGZHigNlxNsX51hQtM
 35H3nvxhdWIrzAZ/kSjbnkjZBlZXGjXxz+Q9a/jtVIAyWE9BAbsFot5n31zcsORkOw9W GQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pxayxy-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 May 2024 05:28:36 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server id
 15.1.2507.35; Fri, 10 May 2024 12:28:33 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 2/4] bpf: crypto: make state and IV dynptr nullable
Date: Fri, 10 May 2024 05:28:21 -0700
Message-ID: <20240510122823.1530682-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510122823.1530682-1-vadfed@meta.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: P1xsVddEfrQ2YwRARG7CKjOBs3ldt8pr
X-Proofpoint-ORIG-GUID: P1xsVddEfrQ2YwRARG7CKjOBs3ldt8pr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02

Some ciphers do not require state and IV buffer, but with current
implementation 0-sized dynptr is always needed. With adjustment to
verifier we can provide NULL instead of 0-sized dynptr. Make crypto
kfuncs ready for this.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 kernel/bpf/crypto.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 2bee4af91e38..ca25ed32e1cb 100644
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
@@ -303,36 +303,36 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 
 /**
  * bpf_crypto_decrypt() - Decrypt buffer using configured context and IV provided.
- * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
- * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
- * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
- * @siv:	bpf_dynptr to IV data and state data to be used by decryptor.
+ * @ctx:		The crypto context being used. The ctx must be a trusted pointer.
+ * @src:		bpf_dynptr to the encrypted data. Must be a trusted pointer.
+ * @dst:		bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
+ * @siv__nullable:	bpf_dynptr to IV data and state data to be used by decryptor. May be NULL.
  *
  * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
  */
 __bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
 				   const struct bpf_dynptr_kern *src,
 				   const struct bpf_dynptr_kern *dst,
-				   const struct bpf_dynptr_kern *siv)
+				   const struct bpf_dynptr_kern *siv__nullable)
 {
-	return bpf_crypto_crypt(ctx, src, dst, siv, true);
+	return bpf_crypto_crypt(ctx, src, dst, siv__nullable, true);
 }
 
 /**
  * bpf_crypto_encrypt() - Encrypt buffer using configured context and IV provided.
- * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
- * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
- * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
- * @siv:	bpf_dynptr to IV data and state data to be used by decryptor.
+ * @ctx:		The crypto context being used. The ctx must be a trusted pointer.
+ * @src:		bpf_dynptr to the plain data. Must be a trusted pointer.
+ * @dst:		bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
+ * @siv__nullable:	bpf_dynptr to IV data and state data to be used by decryptor. May be NULL.
  *
  * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
  */
 __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
 				   const struct bpf_dynptr_kern *src,
 				   const struct bpf_dynptr_kern *dst,
-				   const struct bpf_dynptr_kern *siv)
+				   const struct bpf_dynptr_kern *siv__nullable)
 {
-	return bpf_crypto_crypt(ctx, src, dst, siv, false);
+	return bpf_crypto_crypt(ctx, src, dst, siv__nullable, false);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.43.0


