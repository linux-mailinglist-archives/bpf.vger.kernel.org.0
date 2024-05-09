Return-Path: <bpf+bounces-29176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CE8C1080
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5236E285073
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F45158D6D;
	Thu,  9 May 2024 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dRwl2RN9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13CF13AA2B
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262057; cv=none; b=s94SAU6rbf6jAy3q4tlGVkgAmKBe4tIcxiZmx4vbHLsNlhWdXdU9RRHnwLIm9Ch0sWunmyCHMg4yShiFQvIfwIOijHf4kU3i8RkSJzH2wkZms5jhanQ0a/qrc9wAb48rEOMtDi4CQglZEkS7G276QB7e2NpxgC319+kqoppIWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262057; c=relaxed/simple;
	bh=Yy8YXC7+UhJNQZDZpXzDLDAOS3PhQf3C5GCrM5+0eMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5IpWmfIOFFW8IITjs7vZadFwb5gpdRfaV07hdw8oFdWh2p6aqHgiDdcBNoF54dNyUa1x8z3t3F23d2bk1RDVNTPN5cv+Szo9UEFBr2B9r9Q9olXSOlh9dExVaG96A2yik1DXKMjM+zoNyhjMbNZQRQQoNgUdbGiUaF6zInB9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dRwl2RN9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448MkYmI030616;
	Thu, 9 May 2024 06:40:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Jv0P5knC923RSnpeJNxI1Sq+V4H3QW9Kcv6Lt++3eNw=;
 b=dRwl2RN9EULlM3FNyOvhGBuSolbQt0pj3w3lwc/Xivv7YC4XlHSRpEgiwCOFEh9lpLEX
 MG+6QqWZtJ4G/KFajK6kJyzYDXL6yGglbVgptn2t73gWlbTQvxex031LlwWnvDmppoFU
 C+/H+QAzVOiA74kf+T7pJS7j/xCb3I+UlrtfloZZ1t2lXEBV+Ya5cDgI+EcEqEI5kaN5
 C/06j+FapizlZt7bj+72bRbBDVZuaiCA7h95fEiB6L0gIk+IQdrBeN1e7uCclF01Ap8o
 AgImP+OjNPIqc0KgF22w7XP4IMZntq2ya+GmnZf/JkCbGfG2Q/P8CZD+ltDZ8tXsF6Bx BA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y0e7hcpp0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 May 2024 06:40:45 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.35; Thu, 9 May 2024 13:40:37 +0000
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
Subject: [PATCH bpf-next 3/4] selftests: bpf: crypto: use NULL instead of 0-sized dynptr
Date: Thu, 9 May 2024 06:40:22 -0700
Message-ID: <20240509134023.1289303-4-vadfed@meta.com>
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
X-Proofpoint-GUID: yxEIFSfraYHzDh1RzGRXA1iUOmyEXnxE
X-Proofpoint-ORIG-GUID: yxEIFSfraYHzDh1RzGRXA1iUOmyEXnxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02

Adjust selftests to use nullable option for state and IV arg.

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


