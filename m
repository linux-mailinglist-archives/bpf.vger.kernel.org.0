Return-Path: <bpf+bounces-76433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E03CB3F8F
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4083031CFC
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289BF32C92D;
	Wed, 10 Dec 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eoYDQqdo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC50D2FFDC2;
	Wed, 10 Dec 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398864; cv=none; b=JLFT8V+swlPO4EkRli/J2UNyUdm7kiZGjg7ztAJoCILKw2kWym3magzfH31TN9O7Ef1M9Fv3LX11lUjPbbQcKbS/rm9cEl0xUWExGihQPKssl3phH93RGHlZDQ7SCOm87zbq4ITmK0xpSn5FNW0uFyJxZABtPnbFSTdgC5t3Xjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398864; c=relaxed/simple;
	bh=fuPXMwOZFviQByDHs/6lai8TofzvPJMTBdZalsli2KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK+CjYjIkbSAj/3MrdPWGhWGfs/zwjnwjXp8OWuxmdeN5rq12jyr2XgMFtLmj+RThYzuoCLRRJpSnoNpjr0te6ttLnUlhl/BMZmi39OWvqMbcIY3T92PFMwnlhAosMRu+hmCKGqzhy9cuERfEdGBc+mWmw6TjG6hS8CuPIzfTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eoYDQqdo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIY8P43798961;
	Wed, 10 Dec 2025 20:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=5G0Cn
	cV0eT6uz8BM0jpDFEH0NmsMxffd04ZZoW6Ky2U=; b=eoYDQqdokIVu4nWi61sx+
	dnyF0yJ3+Dd6zIw1m4TQ7Oyet4Yixg1WJvX/vXfZkhKRdINTLoElO7Ri0aFZk5z8
	3hPf7LhYpNx8tvu1vbu2iH2xFLHf1J/tSh5vjimB0Nd6gxQv8yOueRuilc9za0QA
	0oWQqBcCP9oDzNr9BxeyMOxeJTrfm3w8by0a/i1/7ASuL7RUJ9zHEgScTAYheZIt
	tMGztW5wmFgZbW0AYieMlumhfUE9gJgEda+F39zcpYAR/N7KAv2KXVsA6Eg0AbIA
	3Fb2eCUUeSLSylMAei9FCRP2mtaYk7qiwoHroRWLzzNhxFfqm7h76aJoDzJiQeh0
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayd1m8buc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAKTEKV039944;
	Wed, 10 Dec 2025 20:33:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrpyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:33:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkSd001635;
	Wed, 10 Dec 2025 20:32:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-6;
	Wed, 10 Dec 2025 20:32:59 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 05/10] libbpf: BTF validation can use kind layout for unknown kinds
Date: Wed, 10 Dec 2025 20:32:38 +0000
Message-ID: <20251210203243.814529-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210203243.814529-1-alan.maguire@oracle.com>
References: <20251210203243.814529-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100168
X-Proofpoint-GUID: gs922G6Z_fKB9FjZaLnDMWR3eGTX_K7W
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=6939d8fd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=aoasKMbPG5nyLhygJAEA:9 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: gs922G6Z_fKB9FjZaLnDMWR3eGTX_K7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfX1WrBi1yd9Wp2
 jdej3ubmwjsUpTjXKEUjL+XUvp1qbZaAQQUgybKA5qf9UG1FhgRSbDG0EtPZC/ez8pmc5Pjnm7C
 u7fl1ylM/JAvM7m+8XGpTA0jlzWm9uoPPrzild+d+QSvgO36lT6DVDWnC4sU96JtH1wliRleyCS
 y8Vn4XmlJk9QsZ24Oo5CJqqSBwoSpF2zXfHiAePY2oeP13RoN8cNhsR2x8vabMdG9Mj7p5U0x4Q
 wN2O6SceLdm8aevIvq1uTgFTqhK/WAaUU3v5TjKmic3RmYkihbZ7XGsowO0oF/tdwlTM8foLwlw
 pfO82fvmJUcuecPCHHPsj3fmQffi4ZMLz4+15BZYJqaFXr5z0WbMhAScq5fQS8Fr5AxpFqsSs6b
 l5njO764npUEYeZV745F/HXVs47dLAxHS59K3GHfS7hsdzCNyoU=

BTF parsing can use kind layout to navigate unknown kinds, so
btf_validate_type() should take kind layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2133e976cb9c..19e37a543e9a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -691,8 +691,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
 		break;
 	}
 	default:
-		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
-		return -EINVAL;
+		/* Kind may be represented in kind layout information. */
+		if (btf_type_size_unknown(btf, t) < 0) {
+			pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
+			return -EINVAL;
+		}
+		break;
 	}
 	return 0;
 }
-- 
2.43.5


