Return-Path: <bpf+bounces-29472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED68C24DC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 14:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F031C21E77
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12017082F;
	Fri, 10 May 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FfnNpJkP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B112AAE9
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344129; cv=none; b=drCR4RjpbHKdIqRRoY1QkGDPMnnHuJtoYf9rE6bb+gUZaKYldMZAUedz9g3EnQsjtlu4i5E8F7SqsUZIJOWP9G9z3snGfIgJhlmTFJuMgIndQVzDYHPHk1dpS/CN/3W+Ix95BJLWUKIieePvFxlR2l7g2jbkMrZy5ZiCKLOBMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344129; c=relaxed/simple;
	bh=Yy8YXC7+UhJNQZDZpXzDLDAOS3PhQf3C5GCrM5+0eMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PB4dktAIiRpSArxiwlukQK2qikT1RYjB3c6DQTemPD09v/0Y49IUiiKuc/E/IfrNJqrmkzNuuhg4JVIGiX1cw5p9ltHu7wvLySwmWLDAdQOF7L8O8Ltudibef3ViNS815+A2lkoP19qFwATdlbLCZSStmw4263VgFNiBUibefdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FfnNpJkP; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0PsSK003550;
	Fri, 10 May 2024 05:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Jv0P5knC923RSnpeJNxI1Sq+V4H3QW9Kcv6Lt++3eNw=;
 b=FfnNpJkPOHLQl4g3HqeYI5+8fQZGaG7TOF5RHoOENvaHWK6FrG09PZp/DgM9ydwO0eF2
 S0SYpxtTk+xPZ9VD5UVsBiH6yfagZRPu1Wij62zWJaElOlO3HtCjpJU9NdOvzlAbliqc
 B3NgpTn7eNukjK8v7+We6sngMNKbF4ZG6ktOcF8KcSu6xdkPLSHQkROOaWGcIeaYUsO+
 0NKDij0Wz9HHuzP2s8f4IQlsi1d2CWEBEwCf7blaEDyWVy/OvAHMG8Ak3ftdETs9U4Kb
 XimmRgG+8gyNfFrq65IczegHCiok3vgF7nl7DYv/adoubKObkY1TqpUWghy9Q3kmAgK9 DA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pwb1t2-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 May 2024 05:28:37 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server id
 15.1.2507.35; Fri, 10 May 2024 12:28:35 +0000
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
Subject: [PATCH bpf-next v2 3/4] selftests: bpf: crypto: use NULL instead of 0-sized dynptr
Date: Fri, 10 May 2024 05:28:22 -0700
Message-ID: <20240510122823.1530682-4-vadfed@meta.com>
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
X-Proofpoint-GUID: 3H4JkrzcygbumH7j6yQE1UomCSdr0VYa
X-Proofpoint-ORIG-GUID: 3H4JkrzcygbumH7j6yQE1UomCSdr0VYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_08,2024-05-10_02,2023-05-22_02

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


