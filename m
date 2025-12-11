Return-Path: <bpf+bounces-76482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D50CB690C
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E099303C9FA
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CFE3126B8;
	Thu, 11 Dec 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iYeSxLQR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A42F60A4;
	Thu, 11 Dec 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471666; cv=none; b=ozMuGOBwvC1IAuNzDn7tdolSdpogkjlBmd3jDTs4W1SY22nuuo1HVPuJhIzQoTliA+Sh38m45gsk05nHrqSy362fGTBjVrTWyh/ltbGzXlSYjhuXVH8CAh4zzUnRvoJHpd0GQP5WEAay1PNEPT75roSBZZkTRxsw5OWu2QE9o04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471666; c=relaxed/simple;
	bh=R46RowHVNcRX/fyaYFi3afp9MZxZtIKXHgOmyKUx4fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekTsr6ldvZHkmgTq8Tt6M7kRLISjvfqeSJXkQFE/X6AY3xU+3aXmCCgjl9yZst1NPGDR3HqScfzEtegK0T3h+cXF2xvTWydtlqwDzajM+yMw7p1OaeFb7W5YqGVrw/FHGsTy6LvMms+6lGXyheskODPlJ+Bm5ju6JPcGd2yWSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iYeSxLQR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBG58Uk1695711;
	Thu, 11 Dec 2025 16:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=opLkx
	oScR957WnYuTM9BmX0z2BvtKaU1ziDHQ/2ONS4=; b=iYeSxLQRzNHM5ZEMUKuGC
	t0Lu7i9Ha2c/TVLrgP0fXe2No+1cgCF7nlOBCLBZbCRArXxCKc2rtV+uN5nvRiJ7
	ZM9eZB+Q1r+SHp0E1KXM5hNO35nU5xr/f35Pxms1oUtsE0XP4MORYQd6H1JFGIBu
	ble/Cud3WtNJGRyTkOkVZx6RDN/dlmx4b9h/nsnehvGtRi470aI+s0E5lc2Ay5RX
	I0p2KX5csf6ROxVHvi2cWJY1jOHJdkvcC0siD67DqYl5l+t3R3Qu8sj8LLgCd/2c
	sJHsRiE66tl6zrKnHuSkI2vttyD0mgYlDVuS3OaUlL+vuhP5Vy/xhJJ7qb93Iuvv
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aycne1v1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBGUDJ4039919;
	Thu, 11 Dec 2025 16:47:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnsx5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BBGknmR030704;
	Thu, 11 Dec 2025 16:47:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-126.vpn.oracle.com [10.154.50.126])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxnswqy-11;
	Thu, 11 Dec 2025 16:47:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 10/10] kbuild, bpf: Specify "kind_layout" optional feature
Date: Thu, 11 Dec 2025 16:46:46 +0000
Message-ID: <20251211164646.1219122-11-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251211164646.1219122-1-alan.maguire@oracle.com>
References: <20251211164646.1219122-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110133
X-Authority-Analysis: v=2.4 cv=F65at6hN c=1 sm=1 tr=0 ts=693af596 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=J4qZCyyk7QvxA2XVlwcA:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: do4vsa_Jd56CrTkhWHLgoWumNvumWcwM
X-Proofpoint-ORIG-GUID: do4vsa_Jd56CrTkhWHLgoWumNvumWcwM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNCBTYWx0ZWRfXzJ0JQ4DmMrUz
 rL/rJ+sSbjcyPFdMaMVIYjpYgzXCUQ4reYvjFE5tSbtJmi0zTySSuMSkSdebCpuXkBP6JIwtD4K
 /WPGhL4koPg6npv48D23HB2dZuh8JiWABKW1I/b5za2SKBrA76gR1g9x39QVlhJSghIuaqKSBln
 XJ0bp5TWKfcbgMrnsZrZMU28+6MCwjXqOu+B7myDoMnI5mD7OnYUoqpkkulDnsxhDA4cb0JHa8i
 jE4cEdiMRotKeaIrwSYpipizwSlqza7oVrPiPb3aoGf/rzyCLfhOANiU/3mqq3ISVaoObg2RYWh
 +5KkLMb3fGTuxflTqA6bdFt3JSoXhYVqvcbj51h4USRJx/fByFQokfvRKw1KnDH50cHkDmngCqG
 2E0f8M5UM6kqh6zPARg6Mc0p0ePDL0haSZoVHzbh2Uetf8XLuLw=

The "kind_layout" feature will add metadata about BTF kinds to the
generated BTF; its absence in pahole will not trigger an error so it
is safe to add unconditionally as it will simply be ignored if pahole
does not support it.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..c20f9bbcabeb 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -25,6 +25,8 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=enc
 
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
+pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=kind_layout
+
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
 endif
-- 
2.39.3


