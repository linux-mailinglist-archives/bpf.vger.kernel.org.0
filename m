Return-Path: <bpf+bounces-29178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B701E8C1082
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420F71F22F72
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540AE15667B;
	Thu,  9 May 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="d6iSfsaT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304915278D
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262060; cv=none; b=WRKnmd8ru2DldNZNuGnkZfm9UqIItsF/dfV0i+VASQJOVVl+u6XZg3jMYefXqgygQllW+XdaU0iLnLHOa9XcrImtrfDaD2v4wPAfhd/W63gGgou2ZD0x6qJZjsPmhbZOR1k5ToVBLyNZNMbcqeVdp8/QAjYSRPEPtOqHtSRFsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262060; c=relaxed/simple;
	bh=66Oh1Qkhcs+js50B13/qSi+ZF1VuESgstARP/jc7WLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KniAECfjIqxDa8PO6o1l6UltzXSbkr0H0QtsU0yCzWhRDXyNPhroTxOrkFTk7kdWu9c8UpBrtrKMqp3V2XzFO2QRQ4DsNB5uy0+sw5qKkRwtQvp70uq2cpkMaV7iEn8W3O0sQVLkX99VGc/uepnQOBIbvTbkALPCJpJ2+fvH7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=d6iSfsaT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 449DOpCA001589;
	Thu, 9 May 2024 06:40:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=qQiZf+I1XtZhlent6hRaa/2097qMmkLH+mwxyspjAuM=;
 b=d6iSfsaTOKC8sBXyh90fFDsaBpW6pwf05f+9+TD+eatYHsHSZ53p/fdzC8nb+QdAhCCr
 MQ0qCk+NjHAgwFvkO8LQgaomiBD+KHMCr3AqCNaFZQKuowkGXJFDvCTMnSM9kw23689b
 Uh/6fxFtfzhJEIvKDajxRZs073oU4wcVjDQchdJu7u00mcF+wJvEh8wKgASebPCFJ91S
 Q8W2nqKEdxOf41nB6V0kg/sHK/YgXYN0mLd5arVBQ0NqzWyaDgh9s//Z730h8YS2MTlw
 kjWY6fGjnpXVG1Lk4Btz90eltiy8VsAkmFUJGA4oR4NkBSWILcWtLjVuANENira7vhpD dg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3y0e7umtpu-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 May 2024 06:40:45 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.35; Thu, 9 May 2024 13:40:36 +0000
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
Subject: [PATCH bpf-next 2/4] bpf: crypto: make state and IV dynptr nullable
Date: Thu, 9 May 2024 06:40:21 -0700
Message-ID: <20240509134023.1289303-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509134023.1289303-1-vadfed@meta.com>
References: <20240509134023.1289303-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1O6g5ou1edw3_NplFl5mfPQJyHv5eLRb
X-Proofpoint-ORIG-GUID: 1O6g5ou1edw3_NplFl5mfPQJyHv5eLRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02

Some ciphers do not require state and IV buffer, but with current
implementation 0-sized dynptr is always needed. With adjustment to
verifier we can provide NULL instead of 0-sized dynptr. Make crypto
kfuncs ready for this.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 kernel/bpf/crypto.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 2bee4af91e38..4f4446c34b3c 100644
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
@@ -313,9 +313,9 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
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
@@ -330,9 +330,9 @@ __bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
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


