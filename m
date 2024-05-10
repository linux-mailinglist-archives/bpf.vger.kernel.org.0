Return-Path: <bpf+bounces-29473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ADC8C24DD
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A2281AC4
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6D170832;
	Fri, 10 May 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Ko8jKlIu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0D12B177
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344130; cv=none; b=rOFSTWMpoIfXTwi9RdBvTOanMDeYtO2CAC7hYu8+oiiUg6NYX6ohVdknZ7Bylsp7TVoQ3r1E2UzlFmi8N1hpF6eVnf/AjUMguBytZq37lRLE7viLH2mMgnYedpCtQ2RxMYysNKtRRJqzh4oWoejWyKpmAEqJX/d+BPK8SaODrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344130; c=relaxed/simple;
	bh=xkUA+ZdoaRrxiJJpJG9Gxwc0ZruKOevYi79DYLrp5Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLuqQKhZ+Czym1Pfs8Vb4VsY7Kz6qv/vU+YvkGcgOIkaI64OW90awk4DPYYe4RPVrnJyxoPKGDtW2WpW37YGkb+jYxJVBRkgudAPAl/Ym0FmcYDISIcF9tnuqf+DuisGoXj0kdbTzT19fsb3bR9Onp/v/VmqhqbG4P4GrzD2mdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Ko8jKlIu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0QAPQ021039;
	Fri, 10 May 2024 05:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=RAtc41c5KP/0D5YtkuiplfaJKKlNf+QL4ZD3+asfYjU=;
 b=Ko8jKlIuXrfjUN/AmVdPC280gntyTv+hz8ba0UEgYqKbjGhhRtchgI9bPrWc66fPfTu7
 e6eoNWUZhJvQv9pirx5zbXHLdTS8H7gq4rrg0tNQLhbYiuMrJVUV72WhKCD3KgXs11yy
 Qm5sJRWelJJnQ2boPUlbpLtrUYDyHAxXnYTEHLWZtNzj4MGoPySw1prXWA4S6aNUJGpK
 3USlHZfsNQTBq1cr2wHfRDdQO9cjORpm8v1p4TXrny6/Yh3RbgvXRsqndCfyHvxrpxFe
 KvxXD/iN8Gc1078g4J+H/onpElARgF4KYdiZWq5BlAj1OmvUlK3lZzKzznvrOMtNxZD1 PQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pxayxy-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 May 2024 05:28:37 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server id
 15.1.2507.35; Fri, 10 May 2024 12:28:36 +0000
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
Subject: [PATCH bpf-next v2 4/4] selftests: bpf: crypto: adjust bench to use nullable IV
Date: Fri, 10 May 2024 05:28:23 -0700
Message-ID: <20240510122823.1530682-5-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510122823.1530682-1-vadfed@meta.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ml4AACuYV3RqB_kwJHNa_fj4xlzXsIc_
X-Proofpoint-ORIG-GUID: ml4AACuYV3RqB_kwJHNa_fj4xlzXsIc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02

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


