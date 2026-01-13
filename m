Return-Path: <bpf+bounces-78714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF29D190F5
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 14:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13F67300E4F2
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4041C3904CB;
	Tue, 13 Jan 2026 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jyg2ksJ9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471838FEFD;
	Tue, 13 Jan 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310065; cv=none; b=NukQTsWjCJj272PsHayY9uiWWP9Pl+I0jluMBh858O5RhVNoqel+jHL7EVIVPkdqoLs9O6Bi6Kl/ZiPSLE/HumnTGQarHr6Su6PcaUnj0lrxhlQTv2yNDpJuoI0QrWVuZVf8c3fdlGlcZhtp7SJk9PTljBgejFarF/McNIhs4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310065; c=relaxed/simple;
	bh=u5XTiTh0/UfAU3r3QfwDnD5Rru7947T36tD60ICyFe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJxcIJ8S9LZ5oGqMuxBCrxYZ9NtQd6m5PiqbSRo+SRCXQAXTs8TRLNELEdnNbtlnEOHpVkWA71jODl3/lrw0W+DuEtXfksX7ma54I/yDfHONX3a6A/xrAKTM7hckk1xXN5inATfCtJm0MrKHGtu/2Hy1S5qIMt65K8JkGu8HevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jyg2ksJ9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1ggo72395980;
	Tue, 13 Jan 2026 13:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mhAJX
	+gxXJRnHvzE2Ueah353F2U4OOaMCBGW+//duTc=; b=jyg2ksJ9Yqp4t9IMuuoKD
	tc7pMeDZVhXFVN7S+FJWG8nw1usl/4hjmEbmclr7/36DtDlyBm3vm+9EU/hRb5VQ
	tmRhYuGrqqhFfhlTJAgOCG1DVMsIrVQRJTn3n+5oagaBE9oeLeIv4OyDrRgMsaT3
	fq7XVlLVaF8dVlllWpR/E0JBqak6dRLHrEu0IJcjmYcvWELsRYrggMOf7iIg5KE/
	dIOUHhrpLA2SCeNuCsHSEcR8h7f0t1dUq3+r8wkn0GbXi84a7lcn8epzu3eLTJg2
	KBl/VS8l0Du4C/m0w6akyii3RkXa87ud55iqvPSzSbp8lpjX9Goz+9rVv7324yMu
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkqq53cjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:14:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DCdwdg004128;
	Tue, 13 Jan 2026 13:14:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-89.vpn.oracle.com [10.154.50.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7jg7a6-3;
	Tue, 13 Jan 2026 13:14:15 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH dwarves 2/4] btf_encoder: Refactor elf_functions__new() with struct btf_encoder as argument
Date: Tue, 13 Jan 2026 13:13:50 +0000
Message-ID: <20260113131352.2395024-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260113131352.2395024-1-alan.maguire@oracle.com>
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=998 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130111
X-Proofpoint-ORIG-GUID: -DBXt5okUDudVxhT6P3fvDyrqeW3z-9l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExMSBTYWx0ZWRfX2f1iYszGKlUC
 5zHYjhFOmGTucqHmJPY/QvmWgCQGLBz5CzPSM22vvKnqV8MNKYzkGpjo4WlhHMMTBU/sYQr4iGw
 4oXmsbH4J9diHy3iHZTJ62X0f6B8b8ZT65wIgIGDW6LKUeSNjJt73mMPopCeWGuWDCGXPXghtgu
 m6iS0oh3vkgozNd4NVCWeA/9moE2wXM4lQacy0HQE/O1V7EgVglfeIW4tlMNohAmd641gT2jHE/
 HwwPYRxQ3MLIZ4VziI2Rzl/VgBudNaAPqJGjfTfkw3QnAto9fj/0NuOD/cIKUx4p3RMKBN9QdUK
 gFZThrcOF5gi5lR8+8Qwk9QYwNRauz7dIgKFn6uQ3SM+Ktx/BO7A8tzvybm0IRfJiMZuWVRlMYJ
 p5Gqj7VezbKbu9RB5yOBqELCViS/QRWDgKa13odw8Z2AY/0SxqjhpoKyMe8D0DOtNX30omHXXpH
 /0ZJVsAMF4Hwuq1fiXVbZs+UyN4uNgb/QkrJUqps=
X-Authority-Analysis: v=2.4 cv=J9KnLQnS c=1 sm=1 tr=0 ts=69664529 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=sY2qMMBZjZJEShipdn0A:9 cc=ntf
 awl=host:12110
X-Proofpoint-GUID: -DBXt5okUDudVxhT6P3fvDyrqeW3z-9l

From: Yonghong Song <yonghong.song@linux.dev>

For elf_functions__new(), replace original argument 'Elf *elf' with
'struct btf_encoder *encoder' for future use.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2c3cef9..5bc61cb 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -187,11 +187,13 @@ static inline void elf_functions__delete(struct elf_functions *funcs)
 
 static int elf_functions__collect(struct elf_functions *functions);
 
-struct elf_functions *elf_functions__new(Elf *elf)
+struct elf_functions *elf_functions__new(struct btf_encoder *encoder)
 {
 	struct elf_functions *funcs;
+	Elf *elf;
 	int err;
 
+	elf = encoder->cu->elf;
 	funcs = calloc(1, sizeof(*funcs));
 	if (!funcs) {
 		err = -ENOMEM;
@@ -1552,7 +1554,7 @@ static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *enco
 
 	funcs = elf_functions__find(encoder->cu->elf, &encoder->elf_functions_list);
 	if (!funcs) {
-		funcs = elf_functions__new(encoder->cu->elf);
+		funcs = elf_functions__new(encoder);
 		if (funcs)
 			list_add(&funcs->node, &encoder->elf_functions_list);
 	}
-- 
2.43.5


