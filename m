Return-Path: <bpf+bounces-76589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBDCBD21E
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99F4A3001515
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAED2F531B;
	Mon, 15 Dec 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJNChAp/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34962459C5;
	Mon, 15 Dec 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790303; cv=none; b=eUX3r/dHrEr2WUhpHV7Bu3PXVOVgXQ/WE1uODarZtrnr94BDf/E98Koc++dOsMVkBO+Bu4GoajO1ktLhhYt6Law5hmZBarFQq+Ny/o9xp6l/+g5vFcB4cmDFV/+4QZ12MZWQc/jP2N56RWK9S9fX7vNW3b9NCptuXz11WY9ZRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790303; c=relaxed/simple;
	bh=METNtLN617tvFqgPZgLotXMTSHFvFCjhBZoDIPn/Os4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzcizEmpDi0SkaQAemDlQA3DPGKY4+Oij5UszlUPOMo4H0wZ/6MHE6PrWhtC6O2xFQb4zxsLyf3SB7jJZWqjRdCq1QLvpvCTS/O1HAWV7oMQhrYRFGRSo6XcLtucbLhrJnJugK1QyplVkUCImXXhg0HVwfyRVjFwwY03mcq436A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kJNChAp/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uW8h1652378;
	Mon, 15 Dec 2025 09:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4qm3W
	cxNgxqYgsiP8xjrLcEbyacLqlmaQPP0TqXm9eA=; b=kJNChAp/dSQgaJRHs8l9j
	VUisY2nPDl/yuv62wezd+0c7v7efii6O01lbuJXqh21OClBZoRJ4WEZeE2gpw6ZC
	WyntHzOL1rHdgF3AqiRkw1xMhLSwh+Q0TTI/L1wI5zBogGorL/hz/i8j/GiIDy78
	HqN3WvLIBKlqnVFvXmsryWn/R4Pg6d9V7RtFh9MsHZodH1RBZDL9rMewTFOMb3Hd
	Dtk9X/koprSM/dGvo+T1/b8SeCEHhu7NiLYXZsesX+EpwLCtYCeGatydPqpynMRZ
	8d9dkXopkdgTYS0cLCkX5ZLbueifGqlTdZMwU/TBeZ7WDrkRG8Z0PzCKVwLQd+mC
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prhny6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:17:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF70Q4S025197;
	Mon, 15 Dec 2025 09:17:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8ygcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:17:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BF9HdwS027566;
	Mon, 15 Dec 2025 09:17:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-2.vpn.oracle.com [10.154.53.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk8yg99-2;
	Mon, 15 Dec 2025 09:17:43 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
Date: Mon, 15 Dec 2025 09:17:21 +0000
Message-ID: <20251215091730.1188790-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251215091730.1188790-1-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA3OCBTYWx0ZWRfX+mn3VSj4ppKj
 lkfCf4PTHSmuleUQ1oH4iM0xPq2UFqB4zvhCDvkMTHeBRDEo7hkgx1JGkaptJ/8/UFdrJVSmcW/
 xmISXYbisv48PfE/wfJPLeDaitZAarnwp/GAS68++QYvnrEu70F7COY4OOTsBBIxe4JTMooRDje
 FPm+1v391KR3pbkF2hbLYrHbuKCW0mOfr0kTvWPPVLjdDS5+BgWSpi239RYWfIiEUNb8XwDM5nS
 pMv72Wk8686ezqEnMNbdw7+DBU7jVUNYV6J4s12zex2OQ7ADry0EJ9+QnTPFf/7te3vzBS5XHCu
 MPWCPaisVhm94864F14LZ7nD4zXSvr2nKjY4/pdWSOMi+yrpRnmdqwAaEFSX1sbI+BjYGL2HscD
 hzRCZzKmq4shpKluoXcfLQuK/H70gQ==
X-Proofpoint-GUID: zriepC4PtYMUHeTLwg4LUAsir6MYauxE
X-Proofpoint-ORIG-GUID: zriepC4PtYMUHeTLwg4LUAsir6MYauxE
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=693fd239 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=X2N_ohHhAXeM7Wann8EA:9

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
 include/uapi/linux/btf.h       | 11 +++++++++++
 tools/include/uapi/linux/btf.h | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 266d4ffa6c07..c1854a1c7b38 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -8,6 +8,15 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/*
+ * kind layout section consists of a struct btf_kind_layout for each known
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
@@ -19,6 +28,8 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
 };
 
 /* Max # of type identifier */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 266d4ffa6c07..c1854a1c7b38 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -8,6 +8,15 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/*
+ * kind layout section consists of a struct btf_kind_layout for each known
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


