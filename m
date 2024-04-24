Return-Path: <bpf+bounces-27691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0519A8B0EF7
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D3A29576B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA76C1607A1;
	Wed, 24 Apr 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ilKUJj+l"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240915EFAD
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973723; cv=none; b=cr6IqIXVrjYjK2oF1eFKZQ2YpuD1kRNnBeF/oJUNl738WD8X8u0BduM7hpOlQkLHb1oeVTwTtKldusnsK0VnlD+QWvLKPcnbYp9GsBlkGopZFlGdqEevPLO7Wkl/GuaYFwbOi9K9ei6oSdyw+0S/IY4qwcSRzOGdtDfHxIY56fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973723; c=relaxed/simple;
	bh=naBE7idfmkEzeDp0s3d/+P02p9pu6zewWCgBdysiGCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RC6Zo6QKUlV0rxm6Zi4dJA1tqVAQP6Q7s4FmsCEuBgEHq4mSFbPyBHUBrJQtlSDc/4ehPSNmmFUyen3bSooMkxBsh635KIpehtu+4R8tRxvCP8muu//z3yCec02xjdC847btDVnGLO/ihTePSnjfHHIbp0WhwIi7PeSoubIe4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ilKUJj+l; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OAAcAK014716;
	Wed, 24 Apr 2024 15:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=hUOrKSuivqj9lUqm8qadsBBlQvYCtgkCuDgzNx/LZ8Y=;
 b=ilKUJj+lqDlyLnjfoKoWHwSUki/c8HBvwn36TKmNGMV7wy68iaQukB4TjXbuwvAoWIhP
 1zdHDE7ACY0QnzGXMxBf6oNzqPj2tAke23/diyz0EXR4XdgB7cozhKKwBOfm0xvoQxq3
 xefT2amZbo6c0JBCCzlZ/sjf/jFKy3IGcLVMIQI1OT8lZRsLzjXrA0eVsQD6+0fnQQjM
 zrHUH0rQUG46aq+wDMZTBBSfYvltfcCMp+u6pvH1OhY5raNvvPA2y0gYRMV3dVpHxi9W
 rZLZGCKyx/m87t8oBiWz0PR8dkO6gdVNE4RzGfroPpDpwQ6X3CBt6IKRw2X4SFWQhHMN pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4gjcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFK5jn025252;
	Wed, 24 Apr 2024 15:48:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fay1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:17 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCoQ008769;
	Wed, 24 Apr 2024 15:48:17 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-2;
	Wed, 24 Apr 2024 15:48:17 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 01/13] libbpf: add support to btf__add_fwd() for ENUM64
Date: Wed, 24 Apr 2024 16:47:54 +0100
Message-Id: <20240424154806.3417662-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-GUID: 0-iyE_rhLeIlfqO8fs2S3LQk2lrDcq1d
X-Proofpoint-ORIG-GUID: 0-iyE_rhLeIlfqO8fs2S3LQk2lrDcq1d

Forward declaration of BTF_KIND_ENUM64 is added by supporting BTF_FWD_ENUM64
as an enumerated value for btf_fwd_kind; an ENUM64 forward is an 8-byte
signed enum64 with no values.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 7 ++++++-
 tools/lib/bpf/btf.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..44afae098369 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2418,7 +2418,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
  * Append new BTF_KIND_FWD type with:
  *   - *name*, non-empty/non-NULL name;
  *   - *fwd_kind*, kind of forward declaration, one of BTF_FWD_STRUCT,
- *     BTF_FWD_UNION, or BTF_FWD_ENUM;
+ *     BTF_FWD_UNION, BTF_FWD_ENUM or BTF_FWD_ENUM64;
  * Returns:
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
@@ -2446,6 +2446,11 @@ int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
 		 * values; we also assume a standard 4-byte size for it
 		 */
 		return btf__add_enum(btf, name, sizeof(int));
+	case BTF_FWD_ENUM64:
+		/* enum64 forward is similarly just an enum64 with no enum
+		 * values; assume 8 byte size, signed.
+		 */
+		return btf__add_enum64(btf, name, sizeof(__u64), true);
 	default:
 		return libbpf_err(-EINVAL);
 	}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..47d3e00b25c7 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -194,6 +194,7 @@ enum btf_fwd_kind {
 	BTF_FWD_STRUCT = 0,
 	BTF_FWD_UNION = 1,
 	BTF_FWD_ENUM = 2,
+	BTF_FWD_ENUM64 = 3,
 };
 
 LIBBPF_API int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind);
-- 
2.31.1


