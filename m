Return-Path: <bpf+bounces-59154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3AFAC666F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C88E16E4AA
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E21279334;
	Wed, 28 May 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BOtTOyyt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFF17BA1;
	Wed, 28 May 2025 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426292; cv=none; b=itEr2or/UZlwxDBdGmaV8dqxSmzcTqxeimpOs2aly5AQ2eys2Dmuuq93ra6LYfBCQpXLbtIlBPRC1O5IxV7AGfR2isTzuj5IN7UW5q/nKwB535UaatiHEFtmD/GUm2jFKbE4myuVpU1Y9nSTrhyyQvdmV/7sApaX/RzsXigwE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426292; c=relaxed/simple;
	bh=Dr+8VV5rgirmoAR+S/3c0gdJlQ+Rxg3bb2qa8FibHf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uq8QbVd2bT/xTG/P9MH3X9BAS7bx2gjwzoytWqOZm9lTZLI3ZFzHeaRQ5fLSELNyKF45fT5wibcmqFjyJ9hMB/oXjP6Uvff4gZBlcZd5I+VUu8WaV2V2rQ041suM1L31hlpPS5/uFWHPFMOLwsdIyra9UXWzLa6bZJeQaqhzqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BOtTOyyt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1fwTW027431;
	Wed, 28 May 2025 09:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ZPQsW
	Hf/KUFuDvjCR+NQbMA67Kgec/JfNq5lr6K5psw=; b=BOtTOyytMOD+9ZXMGnTwe
	kKZKFwG0yPH8xyHUVUIkb85TANZ0blMZ+T63egDC+uDt1BfLZmBxiWBXudmNYtuX
	FxP9d4UGueuQ+RMCm0i4Av/wKrz0n5YyY6WmQjDDyfs6p2pqMhznLLxp0nYB/LLz
	6j7SpcAV1gSWXDYhsK2ui3otQ+VkIKCviZbpWg6q+xuCyO/AcRMXwvDMOWlPti9e
	xCu/XgL+2xDoDU2GmV5+Fz1RYQlGGhHVw2JYZRDYs67gRIEbYIiddp97RKmW+oOX
	6ScQko3ee21PHXRqI3FhpRUWOjJipWR21T1hSPvlEgWY2jVEdcV0NnWG9FrNA/JS
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33mwequ-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:57:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S7j59n025374;
	Wed, 28 May 2025 09:57:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaeuyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:57:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwVm007194;
	Wed, 28 May 2025 09:57:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-2;
	Wed, 28 May 2025 09:57:48 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 1/9] btf: add kind layout encoding to UAPI
Date: Wed, 28 May 2025 10:57:35 +0100
Message-ID: <20250528095743.791722-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095743.791722-1-alan.maguire@oracle.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NSBTYWx0ZWRfX4gU7Lt3VrDPw gRcHQjfFm0L+Drd/dm+hv3k5PPZ2jnFHoWKbqJ2FwVryPONpvjWEeBs/+i2dUJK5Q9RyNWQmfJx CSFJBOghB+0Wqd9EQGoJCuTk/vE/isNLXf85YUC5YlWceaYemnQ0GMsGruwMwHXFztbgmGTmRT/
 29/fchAvCHH9O1BTxcAERa4EXvMYkoOchLDnN4S07KxGUyDrpAK8LD6kMs7qS8+3nw5E6g28nQt f1M6t5RUZ3AEVwHZt+3P+lbK8LDfo2sbbiM1nTRvRiF0me2qJOQwGBMFN8ErnexVXM1xIXKARPr /rg6dH55whyBXpacpAiry+eWLIIAsBqwL4lV5XIFGl3fVhZpVn7c36spi60VHnRhGHbe9KPXh8e
 TsrArAA2KezO2eOoN+fz3CAGJ60galp6vayUT8utcTv5O6otoXvyGeSNJCoo47btxCDOsteY
X-Proofpoint-GUID: cKjpJAZUG84uRuDqpE6HZSW0YP7PxqIB
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=6836de1f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=juZ357eHEe9gvkRO8XoA:9 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: cKjpJAZUG84uRuDqpE6HZSW0YP7PxqIB

BTF kind layouts provide information to parse BTF kinds. By separating
parsing BTF from using all the information it provides, we allow BTF
to encode new features even if they cannot be used by readers. This
will be helpful in particular for cases where older tools are used
to parse newer BTF with kinds the older tools do not recognize;
the BTF can still be parsed in such cases using kind layout.

The intent is to support encoding of kind layouts optionally so that
tools like pahole can add this information. For each kind, we record

- kind-related flags
- length of singular element following struct btf_type
- length of each of the btf_vlen() elements following

The ideas here were discussed at [1], [2]; hence

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
---
 include/uapi/linux/btf.h       | 11 +++++++++++
 tools/include/uapi/linux/btf.h | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 266d4ffa6c07..0b156178e664 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -8,6 +8,15 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/* kind layout section consists of a struct btf_kind_layout for each known
+ * kind at BTF encoding time.
+ */
+struct btf_kind_layout {
+	__u16 flags;		/* currently unused */
+	__u8 info_sz;		/* size of singular element after btf_type */
+	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
+};
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +28,8 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
 };
 
 /* Max # of type identifier */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 266d4ffa6c07..0b156178e664 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -8,6 +8,15 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/* kind layout section consists of a struct btf_kind_layout for each known
+ * kind at BTF encoding time.
+ */
+struct btf_kind_layout {
+	__u16 flags;		/* currently unused */
+	__u8 info_sz;		/* size of singular element after btf_type */
+	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
+};
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +28,8 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
 };
 
 /* Max # of type identifier */
-- 
2.39.3


