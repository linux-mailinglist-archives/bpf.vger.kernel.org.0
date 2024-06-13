Return-Path: <bpf+bounces-32129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89864907DF4
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841B41F23C8D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F682496;
	Thu, 13 Jun 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ET4uTwcw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA73C7604D
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313531; cv=none; b=H0Uy8aQBJljKajEu4Q227YgJPYVUX7IyvPiKmbzWS3ppckveWvweZ5cii00RQGH614JB1BuOM+3emm6huCSe31N5tjBqySp5dupC2JnY3ntndONorYtCZgtuzAOsHf5jQByu8BxJOXblhP51YSzB/A4MTNLbZqBVcWyx39ce/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313531; c=relaxed/simple;
	bh=8e94HX+yNfqYS9sJyHJNUIpdxnoOAXbGo/pLaYRpEj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj99gAsLtdNTGf3sq2KYaaX9cQbH5rfkpUnwAjX6LUuk0OeXwE5eQewqKAtQfnmDG3QocVf9XCFIYCDrhS1vNurXDbIyZPdSmc/avZ+Np8ImPZvDGpKOnt5k2ENs5ALT/2nHvgg9IIb32SsnX+kaOgFLgou4y9nTzvAo08bNgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ET4uTwcw; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45DJXJip001192;
	Thu, 13 Jun 2024 14:18:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=38LDd7vZKELIhFnGuh59fbaP4qYMe3CDh8dOgSEQyhk=;
 b=ET4uTwcw763CPSbuKlS5cD5lNIZNA/SH9AHlwvVy7PtMI+OHNnpFijO4Kl4OwvYFRGIU
 fQ8Q0aMT9o27wJuVSzFC5RRGPUZDWHDv3DVKPFNZW3KT9fjYZIxBYTd7w4L7fthIFtYB
 4j5GU3/Nsx7kLGqfRvM+5qn7g/KRglZCZ30ibfzQ44qdg7e/gvBAjrtajtMwKgpFwYun
 1XhFAYLGTkAzzVB0NlmUAoSC0z0UIxVMXG1PA1SkoVFBzBxhX/nG0Iquy671Bw3tU0c5
 +ugJPuhayGxlvHoUxbs3fyG8dXAzyjV8A5eC95ckE7vglsQlJ54Bom7DzIQSOBcsaZ7L uA== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yr347av6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 Jun 2024 14:18:34 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 13 Jun 2024 21:18:31 +0000
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
Subject: [PATCH RESEND bpf-next v3 3/5] selftests: bpf: crypto: use NULL instead of 0-sized dynptr
Date: Thu, 13 Jun 2024 14:18:15 -0700
Message-ID: <20240613211817.1551967-4-vadfed@meta.com>
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
X-Proofpoint-ORIG-GUID: KY3C9KJX9uHIaa_nCvYwEdx_7wKufEC9
X-Proofpoint-GUID: KY3C9KJX9uHIaa_nCvYwEdx_7wKufEC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01

Adjust selftests to use nullable option for state and IV arg.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../testing/selftests/bpf/progs/crypto_sanity.c  | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c b/tools/testing/selftests/bpf/progs/crypto_sanity.c
index 1be0a3fa5efd..645be6cddf36 100644
--- a/tools/testing/selftests/bpf/progs/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
@@ -89,7 +89,7 @@ int decrypt_sanity(struct __sk_buff *skb)
 {
 	struct __crypto_ctx_value *v;
 	struct bpf_crypto_ctx *ctx;
-	struct bpf_dynptr psrc, pdst, iv;
+	struct bpf_dynptr psrc, pdst;
 	int err;
 
 	err = skb_dynptr_validate(skb, &psrc);
@@ -114,12 +114,8 @@ int decrypt_sanity(struct __sk_buff *skb)
 	 * production code, a percpu map should be used to store the result.
 	 */
 	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
-	/* iv dynptr has to be initialized with 0 size, but proper memory region
-	 * has to be provided anyway
-	 */
-	bpf_dynptr_from_mem(dst, 0, 0, &iv);
 
-	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
+	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, NULL);
 
 	return TC_ACT_SHOT;
 }
@@ -129,7 +125,7 @@ int encrypt_sanity(struct __sk_buff *skb)
 {
 	struct __crypto_ctx_value *v;
 	struct bpf_crypto_ctx *ctx;
-	struct bpf_dynptr psrc, pdst, iv;
+	struct bpf_dynptr psrc, pdst;
 	int err;
 
 	status = 0;
@@ -156,12 +152,8 @@ int encrypt_sanity(struct __sk_buff *skb)
 	 * production code, a percpu map should be used to store the result.
 	 */
 	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
-	/* iv dynptr has to be initialized with 0 size, but proper memory region
-	 * has to be provided anyway
-	 */
-	bpf_dynptr_from_mem(dst, 0, 0, &iv);
 
-	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
+	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, NULL);
 
 	return TC_ACT_SHOT;
 }
-- 
2.43.0


