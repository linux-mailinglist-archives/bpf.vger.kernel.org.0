Return-Path: <bpf+bounces-32130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C8907DF5
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F55CB22D45
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22613D250;
	Thu, 13 Jun 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Mlkd6Upu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3A13C3C0
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313533; cv=none; b=d9pvmj29GYgDA8qG9LOii35EE0pwZ9SIRI6P2AEVRlF3xnVS5PFGMVhVI003vpOUamR0OcCmGM6r4Jl3xNSUCtFplRABr7pFhJ6WGRcbLh9E4VbwJURO+C/L2fJ/FKXMp8E7lkMlGhFoVqBzfCCxXHMe5x9WPRIGrcOqCrobNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313533; c=relaxed/simple;
	bh=IoM5RGCURefztZvm2g0G3gycI9rGz1lygsKEpZvnCP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cv2EemeQId9SiP4tWwTu6B6CRSwF2XrEHfDQtww0Dg6jWcMOf/7UoOnoVrwaIaswUaQqjX1oDyGjcZ5KAiY3PmU3IjTIezdBoIMAstx0flS0nJHPCssG+b4VyaSEtPT1Z5ru5bjZ7JdELlvr+KSZmCstFV34zC9iAEImWmaG9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Mlkd6Upu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45DJXbqE005405;
	Thu, 13 Jun 2024 14:18:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=FyjI1gmssVMjNssoes9a+Ur2Wie84+kxR5H/qYPR14w=;
 b=Mlkd6UpuT9S7gipt+sNN1V1xhMSQQXnaUB2ux1oPqsusLYuWdzD9U+bt2Kdc4ApYeGYC
 pIrB338GKP1s4ZJretitZHk52n0Mz+RbSU/VqmOnGnFLeRQFSAPDd7wFe1kYv5FFP43t
 WgZgsaqMLQan3GoYuUOyURhRZFdxJYJ8hiUrnIJFxjrFHszv8QSp8bBGIxpe3jZPHtyu
 BE7V5jF1Wwd+RILZnTmHq5k9w/OZGnxL2jkqUSpF0w2WrkogjJFtjaTsWqp6pqFal3x1
 ZwriWzHftDfnrwMj1VSAH45I2vgKOrdil3l7vZ4uFEUeXQDPOQYaZRB1UjGxtstP099D Lg== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yqefqjctq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 13 Jun 2024 14:18:36 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 13 Jun 2024 21:18:34 +0000
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
Subject: [PATCH RESEND bpf-next v3 4/5] selftests: bpf: crypto: adjust bench to use nullable IV
Date: Thu, 13 Jun 2024 14:18:16 -0700
Message-ID: <20240613211817.1551967-5-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613211817.1551967-1-vadfed@meta.com>
References: <20240613211817.1551967-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QwA5dRvySaOi0Uqic-WUAfNpgtlPQhdJ
X-Proofpoint-ORIG-GUID: QwA5dRvySaOi0Uqic-WUAfNpgtlPQhdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01

The bench shows some improvements, around 4% faster on decrypt.

Before:

Benchmark 'crypto-decrypt' started.
Iter   0 (325.719us): hits    5.105M/s (  5.105M/prod), drops 0.000M/s, total operations    5.105M/s
Iter   1 (-17.295us): hits    5.224M/s (  5.224M/prod), drops 0.000M/s, total operations    5.224M/s
Iter   2 (  5.504us): hits    4.630M/s (  4.630M/prod), drops 0.000M/s, total operations    4.630M/s
Iter   3 (  9.239us): hits    5.148M/s (  5.148M/prod), drops 0.000M/s, total operations    5.148M/s
Iter   4 ( 37.885us): hits    5.198M/s (  5.198M/prod), drops 0.000M/s, total operations    5.198M/s
Iter   5 (-53.282us): hits    5.167M/s (  5.167M/prod), drops 0.000M/s, total operations    5.167M/s
Iter   6 (-17.809us): hits    5.186M/s (  5.186M/prod), drops 0.000M/s, total operations    5.186M/s
Summary: hits    5.092 ± 0.228M/s (  5.092M/prod), drops    0.000 ±0.000M/s, total operations    5.092 ± 0.228M/s

After:

Benchmark 'crypto-decrypt' started.
Iter   0 (268.912us): hits    5.312M/s (  5.312M/prod), drops 0.000M/s, total operations    5.312M/s
Iter   1 (124.869us): hits    5.354M/s (  5.354M/prod), drops 0.000M/s, total operations    5.354M/s
Iter   2 (-36.801us): hits    5.334M/s (  5.334M/prod), drops 0.000M/s, total operations    5.334M/s
Iter   3 (254.628us): hits    5.334M/s (  5.334M/prod), drops 0.000M/s, total operations    5.334M/s
Iter   4 (-77.691us): hits    5.275M/s (  5.275M/prod), drops 0.000M/s, total operations    5.275M/s
Iter   5 (-164.510us): hits    5.313M/s (  5.313M/prod), drops 0.000M/s, total operations    5.313M/s
Iter   6 (-81.376us): hits    5.346M/s (  5.346M/prod), drops 0.000M/s, total operations    5.346M/s
Summary: hits    5.326 ± 0.029M/s (  5.326M/prod), drops    0.000 ±0.000M/s, total operations    5.326 ± 0.029M/s

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 tools/testing/selftests/bpf/progs/crypto_bench.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/crypto_bench.c b/tools/testing/selftests/bpf/progs/crypto_bench.c
index e61fe0882293..4ac956b26240 100644
--- a/tools/testing/selftests/bpf/progs/crypto_bench.c
+++ b/tools/testing/selftests/bpf/progs/crypto_bench.c
@@ -57,7 +57,7 @@ int crypto_encrypt(struct __sk_buff *skb)
 {
 	struct __crypto_ctx_value *v;
 	struct bpf_crypto_ctx *ctx;
-	struct bpf_dynptr psrc, pdst, iv;
+	struct bpf_dynptr psrc, pdst;
 
 	v = crypto_ctx_value_lookup();
 	if (!v) {
@@ -73,9 +73,8 @@ int crypto_encrypt(struct __sk_buff *skb)
 
 	bpf_dynptr_from_skb(skb, 0, &psrc);
 	bpf_dynptr_from_mem(dst, len, 0, &pdst);
-	bpf_dynptr_from_mem(dst, 0, 0, &iv);
 
-	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
+	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, NULL);
 	__sync_add_and_fetch(&hits, 1);
 
 	return 0;
@@ -84,7 +83,7 @@ int crypto_encrypt(struct __sk_buff *skb)
 SEC("tc")
 int crypto_decrypt(struct __sk_buff *skb)
 {
-	struct bpf_dynptr psrc, pdst, iv;
+	struct bpf_dynptr psrc, pdst;
 	struct __crypto_ctx_value *v;
 	struct bpf_crypto_ctx *ctx;
 
@@ -98,9 +97,8 @@ int crypto_decrypt(struct __sk_buff *skb)
 
 	bpf_dynptr_from_skb(skb, 0, &psrc);
 	bpf_dynptr_from_mem(dst, len, 0, &pdst);
-	bpf_dynptr_from_mem(dst, 0, 0, &iv);
 
-	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
+	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, NULL);
 	__sync_add_and_fetch(&hits, 1);
 
 	return 0;
-- 
2.43.0


