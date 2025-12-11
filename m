Return-Path: <bpf+bounces-76477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5445CB68B8
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 317D830021D2
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC23126B8;
	Thu, 11 Dec 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eb1e2dgR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1C3126AF;
	Thu, 11 Dec 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471646; cv=none; b=oz1Ux38X+FJl/a2wODN8D2mlSm2ZxeD1cVND9eKazms1wi/atE3tAzkBxVeUm4J4pTodPKGKwTutdEDdkM1oKLK4r+BL3XOXCxbaSzqTy52yvwM4hV8eE0LSeWj3yDNfz06mBJzLnAe8RpOvLpW6D0/3gIdQ/s1E3wj+HcmMUN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471646; c=relaxed/simple;
	bh=fl1iLhCaw6Q72AjhmJEqSHWzE702Eyo5AvkELbKXs6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHvbIDH2IG7LTE3DRxVRY1g/bLiHxjca3p75KIeSNVCW1GDSKi2aqfeHD0us1lxwfBj2yRCvuDllJV7w3k3KMifCompsFgkc/jo+cOqs2hH8T8G+ljI6cBSw4F9tdITKy/E0EnMQfSoo0w5M9JK5MbUke38D0aHJJLx4AEXkHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eb1e2dgR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBG5EXi1722247;
	Thu, 11 Dec 2025 16:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=dVt3s
	YM5QlQcCuJfpcIU0I+e6tHqTk3p7vVEd9TY+fU=; b=Eb1e2dgR4SXnCehXX80ar
	Zz7GGqfGldEdwfpz7Jy6B9nYtZvt6VRp0d7lA7KGODdDAHycUtycRdY7kK4C4Ljr
	e8GCIvW6EA6VzOVHmBQTx3pRLaXgXrKYdvXP3VFYnd1suCsAWHFdhtfwvXtaJFos
	imhr91uhvC00IGPqf4qDkh/b8s19s6VBBoz8+QU7xegpiYHgPE0iFd0vcnfWQZ8H
	/M9ge7YvTlNIOB/1IRE/ZxrcS04fc/YXTTUQ9acG+LRgm0DbPz8yWSqrSimdYhoF
	10QX5NIdsPfFdVRDYPWUhQxs4DkfBAVur2nc07AjqMegdOhMBvtJTOE+Vy/JtI5I
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayd1m9ss2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBF62po039952;
	Thu, 11 Dec 2025 16:47:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnswyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BBGknmH030704;
	Thu, 11 Dec 2025 16:47:03 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-126.vpn.oracle.com [10.154.50.126])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxnswqy-6;
	Thu, 11 Dec 2025 16:47:03 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 05/10] libbpf: BTF validation can use kind layout for unknown kinds
Date: Thu, 11 Dec 2025 16:46:41 +0000
Message-ID: <20251211164646.1219122-6-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: MtN1f2yh9FCJ9lzkH420iuEHi0RCVnTV
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=693af589 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=aoasKMbPG5nyLhygJAEA:9 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:12110
X-Proofpoint-ORIG-GUID: MtN1f2yh9FCJ9lzkH420iuEHi0RCVnTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNCBTYWx0ZWRfXx0omHNazTW6P
 cfI4NLuvWuOc5xq+oEmaIWVssrXjUvM/rd87J0yJMs5ypbp+DeyBdiMWdGgwqt0IBNKtrRmy8Yd
 0ItwfNwBXuJ6GKGomynI0AlBWWagnc/uQ067Ef/AtYRAy8/moPW9QaYPK5QExKn/6HEeTKY4dXO
 LEHq6l5EqLWziknPwR4WvRm95uMi4qYI8hKbePur0bnMDVwljiko2xROq1ZTdVfkVXY7YppQ/ad
 +HrR/alp+AT8ISVEJvF3A3hKlYBo4/wIN2Cawgx1k6/lfqZjKcCFN33qhik3xJBOuGIwY8y1uTu
 3TBTRpLP7IqD3nUr2YRJRQ5hAqjp0lhE4xSnBRECj6LnT21xHJetH3JKTMRpsRhvDGRmHiT3EuW
 xNxfuQn/4WcnaOCrzV/snDR0ckjjB8U1Ht8Tg7nsn50VH2hr1lI=

BTF parsing can use kind layout to navigate unknown kinds, so
btf_validate_type() should take kind layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9ef46aef43fc..440cd451c340 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -706,8 +706,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
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
2.39.3


