Return-Path: <bpf+bounces-76424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9BCB3F74
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3284830341FC
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AEF32C31E;
	Wed, 10 Dec 2025 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W1N0atXd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFF146588;
	Wed, 10 Dec 2025 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398795; cv=none; b=klI4UwemKgopwODVCBt0S/tXGgpCYSI4vY55YJE9tkr9Fhi+iUguPGVOq8zOwnHxweRbXD6hSZGBJLndpXX19oyFPqVVzy9xuh85N2IWppnlAXY2Z6WEw48+CWyrtKBYlkiaXKDZFSHqNCayNNZnbj+3OTV4DX/qIlUzH/B/YPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398795; c=relaxed/simple;
	bh=2I9HhY/ZuB/Z5avPdjUt4CpmxlGzsxqxlgYIahXGkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsblnTcEbvJ5/KgHVzC+TqNyQGTrih+eFF1f4TnI5ZwX+S7DhxdQ8tuex3jGuhHsl4LEgEAGAy0mFUI2t4o2SG1z0UDsS0+FBqcI3KWDc7znav33X8ACq6nYx03TXNm/FYWhQscwu0FT9uPNoNdOHxcUXC++Kz2bScAkG7IqZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W1N0atXd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYeKV3730410;
	Wed, 10 Dec 2025 20:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=bUJa9
	z6gd5HRBCaH/2/biqpjFB6dpeBxIKQMj8DsSow=; b=W1N0atXdKDvL2kTFkj1eG
	uETTKTZh24D137FrBPbFTDHZ6v9GLASiieV5EMrl0r5HWppe5EBOmo4umF+amHHA
	x2op5mrX45RcxscY37iLu7zXiSSWk/bQ/N0RXEkANT4qqEn7jYhyChakuBJdDJlt
	oMWwn4nueag2temr7XKPxXprk0yO9WoziRc7rIcIhSelL8zBLBxD+7vp5jr5TXvD
	q6O5eadMMlrDzKgTTKfNAcvdZoQXQm8wrDP2ssAQS4tNmYf+qzZrBuNiA7NPtWnk
	TGvhHCO3AAgWlqV0gL3GiF1IX4+FqEhhbxCbot4MGD1onagw7w4yB6GeYxvV2twT
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayc9q0e3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:32:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJSnmW040221;
	Wed, 10 Dec 2025 20:32:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrptx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:32:49 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkSV001635;
	Wed, 10 Dec 2025 20:32:49 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-2;
	Wed, 10 Dec 2025 20:32:49 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 01/10] btf: add kind layout encoding to UAPI
Date: Wed, 10 Dec 2025 20:32:34 +0000
Message-ID: <20251210203243.814529-2-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: CNUn90Rhxi0BAWY0E3yd21LNB7IrqhDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfX6YrB0R6Vi7eu
 qkryFev0JLN2HDvFRjWukzxZR8+hqt2EBPeP3lIocQu7ESZzFzcQEZuIKjHyP3qlH2Sf5QzWEQJ
 q0P+/JMpxuNoB8b0SYOme5B+/5TErpDkRfUZ8nkFda33LVrtJjGT/DXhx1Uf1nfLYCITjc2jMFR
 Y0pMI/enwEbqVh70O8uUfXa+YW9+WCKMNrUOoIM6Gaz8nJj+gaDhw6TtUoecpGuy8SY7OQJyMON
 /RPRBv6nd3oRDL8dooKWJOnVrhikSSF/S1dCa95XcFwftHaFjcw+i/FDlhVIhB2plMZj9B/WTN6
 PyJDMRoWVTSEkVLV09wI3MHSz0Bo5D3qqf24SpRxzE6G1RUyh/JLI+RiI8u9UGL3u4h1Q596V0h
 7Ksjg4BZRWnl2EpdAxmb5u4n7ca6YAMDr7YFUSBMk76p5HWM4cg=
X-Proofpoint-ORIG-GUID: CNUn90Rhxi0BAWY0E3yd21LNB7IrqhDG
X-Authority-Analysis: v=2.4 cv=SYn6t/Ru c=1 sm=1 tr=0 ts=6939d8f2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=X2N_ohHhAXeM7Wann8EA:9 cc=ntf awl=host:12099

BTF kind layouts provide information to parse BTF kinds. By separating
parsing BTF from using all the information it provides, we allow BTF
to encode new features even if they cannot be used by readers. This
will be helpful in particular for cases where older tools are used
to parse newer BTF with kinds the older tools do not recognize;
the BTF can still be parsed in such cases using kind layout.

The intent is to support encoding of kind layouts optionally so that
tools like pahole can add this information. For each kind, we record

- length of singular element following struct btf_type
- length of each of the btf_vlen() elements following

The ideas here were discussed at [1], [2]; hence

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
---
 include/uapi/linux/btf.h       | 10 ++++++++++
 tools/include/uapi/linux/btf.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 266d4ffa6c07..64dd681274f4 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -8,6 +8,14 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/* kind layout section consists of a struct btf_kind_layout for each known
+ * kind at BTF encoding time.
+ */
+struct btf_kind_layout {
+	__u8 info_sz;		/* size of singular element after btf_type */
+	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
+};
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +27,8 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
 };
 
 /* Max # of type identifier */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 266d4ffa6c07..64dd681274f4 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -8,6 +8,14 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/* kind layout section consists of a struct btf_kind_layout for each known
+ * kind at BTF encoding time.
+ */
+struct btf_kind_layout {
+	__u8 info_sz;		/* size of singular element after btf_type */
+	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
+};
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +27,8 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
 };
 
 /* Max # of type identifier */
-- 
2.43.5


