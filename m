Return-Path: <bpf+bounces-76476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEBCB68F7
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B6D6302E170
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE1314B83;
	Thu, 11 Dec 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hzy3GTLm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBAC23EAB8;
	Thu, 11 Dec 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471645; cv=none; b=YLnuiDn4eVMNxvCqsmRMSGpLwRPFemEBd/hbk4rvHUEy1uXcfScP+otNE0hcXs4eN3KvRfyM0c5mHcbvp/eRzHYWKYM5q6J/ZUVl4YLUl5LFuz/p793FTH7kJiyIWZuWkzXJJyHZGXK/ecOAHg+AMezcxyJmw+040bFgp8HYtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471645; c=relaxed/simple;
	bh=UCO1n7Kl/U/cQA/z44g0OwGBgWHatmWtgC4wAAE7ux0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5noK+jpF7m3QF3o7cyUtq5y3F1Kn52vE95bqYs+JcdeIBE9feI+4V7p6P8HNJ+sDQD1tfMI9VNe8uxfrmTU7POzu4ol/5hm4PH6yoi5fGZ9F97rF0X6dDDvXvnSgk8XuR/G8oq+aYLKohfETbLybBpYsnWfTrY9f9CbmyPjOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hzy3GTLm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBG5Bve1699173;
	Thu, 11 Dec 2025 16:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=yHmpp
	/bN3czi3p4dn4fkwBODHJuHvYUemZfXIc7nGUI=; b=Hzy3GTLmX+6+8iP4VVltv
	IN38f/HTYt8oLJRkAfL3GVAg44dB5hiPV8iLjQVqvPCiuFLRAFt80brP7naXUjzi
	QH/HbEtFfao4cUUfI64NsKgzU+5qiKvjT9DFied7VDBn1BP26BFXcagVmWpl1X8n
	1s8hTqmIuekvddYnrGmnJUwRFUXDl97d4XEzWnUeY4KFm6auHA2YfCqwoNCgmLOM
	RtxP/Dkz9dmvRbBjH3pypxI8EQ0KHzSUOLl4YZu87OiCn3hX5PxGZBGWrXmHwaFm
	UJwynl9VGMpSQIqyrvKgtiX7q7rIE7dY/4T7+928bFyToabWBaVXSCjekXPTgZmC
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aycy8svpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:46:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBGjaa6039934;
	Thu, 11 Dec 2025 16:46:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnswt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:46:53 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BBGknm9030704;
	Thu, 11 Dec 2025 16:46:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-126.vpn.oracle.com [10.154.50.126])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxnswqy-2;
	Thu, 11 Dec 2025 16:46:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 01/10] btf: add kind layout encoding to UAPI
Date: Thu, 11 Dec 2025 16:46:37 +0000
Message-ID: <20251211164646.1219122-2-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: isoP9edgGFSBV14fSysVh4YvAeZfY-JH
X-Authority-Analysis: v=2.4 cv=SZn6t/Ru c=1 sm=1 tr=0 ts=693af57e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=X2N_ohHhAXeM7Wann8EA:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: isoP9edgGFSBV14fSysVh4YvAeZfY-JH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNCBTYWx0ZWRfXxoouoeph4yWV
 ZGjm4lwIRuN6akeMD3qkmAB/qQtAXgIAoC1ZWHZgI2wWnwoz6ihGzxYEwJXNCocPajgF5Dq39iB
 JHRt5lJOu/aLiuwO6ZXA4JzDkL6KWaFVqaNt37gDP/pSvPKmKW5jH4lzjuM5cdOm6dyzv+s588L
 xv/bQIcTTmkeMg+iU9Cwj91mgYLVL3NSkkjJp46S95MC3IdZHZNx/IKpwkiIPqUylm7lgCl46EB
 Rrkm2IHNsoyjI+vt9lfGv0U7TV2CcKiEU7Y6+/p2Qq97q7Y3CvtASYTp7M0MWPb9MZgLewPqOee
 iDKVOcP4//BFas/b5Rr3m6ineBk8C1seSRTsHCIa6xYn0m7lMzW/AKFy+mW8GqKxmRXqxMPBTZT
 U+4m62icN/t5TBiu69HeWz7gAo+ijA0jJZtPVmIRZoT+31uo/YA=

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
2.39.3


