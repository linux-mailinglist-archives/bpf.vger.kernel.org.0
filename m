Return-Path: <bpf+bounces-41610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9199918C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DA41F25C7F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DE1E47A4;
	Thu, 10 Oct 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="iSlslW1S"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE71CEAD2
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586042; cv=none; b=ZIeqCJkfA4Qqpalau7m7t0aWAGZARPBNoB47KJ1n3n2FO1yzHqKmoyXZXVqnxoT8CSbGBVL0WF5wl1AP4DatnRDbQuy0Oc14KIJlelh9sCtRjaQvp9EgSVHqCS2BwNFt3PZrQqPvHVYEvsu6KdOV+F7vwvjxJ2amTgwRB3fwZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586042; c=relaxed/simple;
	bh=/B3656dKDVyz1E+sZHBKJG6YFEOpZVg/03qbEHHr1DU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6UExHujKtHON/nDsF95Emw5XTfdkXcoo7AxcZFgrKwQVCGIEHckoZgM9h10f3+VtpfW0KD1E+ky9JBdsWzRlVEsKe6qYOe6vU4lDcVWABY9O2XuKxDRQnFhJqbIrlUrtVpH0RFroISEE92SedlZ7PxhVod8NbIOtmIHb4YulX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=iSlslW1S; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHEjih026055;
	Thu, 10 Oct 2024 18:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=nAtBINV2DBR99
	eS4IrxhiRKLFDObP53bsU+4eyHI9l0=; b=iSlslW1SfletpPQOsl49QkQpXa2e5
	2BX6DQNUYsFxDu1bQVDVU71BsmKuC0DOe+FBr0szyW8VQC58Jx0Nr5G2kStvFCRu
	XbUJ/LQwHvXScgYlogsJXnmloJJlAWnFTI9BdENoB8RPoV2+xQOfx0e3yudt1Utg
	2VH79nknuDFao1pAf1r+hGJtJhT45YX5YWPZQtP5bIfF8V7cl2ctIYxA81O27iWO
	nEwLX/h9LVKW+b6MvE4XNF75tVSxLjsCvG7iWNg28P7wsHAuVRA1JFgXV9yT4OM+
	bSNIgUzVwgsqMLjzYWHQgaL5RKOrAZUXtEn/ZMmGXCQkfneA/n8EacGgA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 426fuys0e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 18:46:51 +0000 (GMT)
Received: from LL-J21Z134.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Oct 2024 18:46:49 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
Subject: [PATCH bpf-next] bpf: update docs on CONFIG_FUNCTION_ERROR_INJECTION
Date: Thu, 10 Oct 2024 11:45:56 -0700
Message-ID: <20241010184556.985660-1-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04wpexch13.crowdstrike.sys (10.100.11.103) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: _ASTIxTCjiwINUvun8ntNTdGB9E9q6g3
X-Authority-Analysis: v=2.4 cv=I8o3R8gg c=1 sm=1 tr=0 ts=6708211b cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=EjBHVkixTFsA:10 a=DAUX931o1VcA:10 a=pl6vuDidAAAA:8 a=VyAg9FH10EQY466DWOYA:9
X-Proofpoint-ORIG-GUID: _ASTIxTCjiwINUvun8ntNTdGB9E9q6g3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=522 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100123

The documentation says CONFIG_FUNCTION_ERROR_INJECTION is supported only
on x86. This was presumably true at the time of writing, but it's now
supported on many other architectures too, so drop the part of the
statement mentioning x86.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 include/uapi/linux/bpf.h       | 3 +--
 tools/include/uapi/linux/bpf.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8ab4d8184b9d..a2ddfc8c8ed9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3105,8 +3105,7 @@ union bpf_attr {
  * 		**ALLOW_ERROR_INJECTION** in the kernel code.
  *
  * 		Also, the helper is only available for the architectures having
- * 		the CONFIG_FUNCTION_ERROR_INJECTION option. As of this writing,
- * 		x86 architecture is the only one to support this feature.
+ * 		the CONFIG_FUNCTION_ERROR_INJECTION option.
  * 	Return
  * 		0
  *
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7610883c8191..15c9364b8d7d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3105,8 +3105,7 @@ union bpf_attr {
  * 		**ALLOW_ERROR_INJECTION** in the kernel code.
  *
  * 		Also, the helper is only available for the architectures having
- * 		the CONFIG_FUNCTION_ERROR_INJECTION option. As of this writing,
- * 		x86 architecture is the only one to support this feature.
+ * 		the CONFIG_FUNCTION_ERROR_INJECTION option.
  * 	Return
  * 		0
  *
-- 
2.34.1


