Return-Path: <bpf+bounces-14919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401847E8FBE
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7FEB20957
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258447FB;
	Sun, 12 Nov 2023 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bTiyfPcD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A57648
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:05 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698492D5B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:04 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACChsUQ023710;
	Sun, 12 Nov 2023 12:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=C5jt4Q7tWVZFnGGb0eTPI3NHiRpXN7MnjPjR+tHMzKs=;
 b=bTiyfPcD8scKg6x4nSK59i7t2ELIJ2JLq/W3SJYZdKKMwO6EmiUNLighhXRm6L/5bqa6
 nIFAoFp1w/aW+IdHNn2TelHDmP2MnbxlyMPlGnEkP81jQ68qK8FrmOS7kt4+oI/6SteS
 fEOOI5P7Bn7gkNLz44qyam33mMA/kVZYK/NDH0GpRtie78XCpcYqKnQxqEEO4KriMrRk
 TWG9xsel4R1pEOwPjMf0eOjt03Ow1gtFn9N4a29HXTZbUUHhV59J3UdowytRqX58zDYC
 OOa0nlcE/GOD1iMHwiBl6xXJd2QhP6vfT0Xsatij6EtvWJVmqX+l5eEDP3rjwwk94pgF KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdhexx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:48:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCEZeE008972;
	Sun, 12 Nov 2023 12:48:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngffv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:48:43 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmce4029718;
	Sun, 12 Nov 2023 12:48:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-2;
	Sun, 12 Nov 2023 12:48:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 01/17] btf: add kind layout encoding, crcs to UAPI
Date: Sun, 12 Nov 2023 12:48:18 +0000
Message-Id: <20231112124834.388735-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-GUID: -wR9c5TENAQE9lKMjk4OYsKT9CEgb4CT
X-Proofpoint-ORIG-GUID: -wR9c5TENAQE9lKMjk4OYsKT9CEgb4CT

BTF kind layouts provide information to parse BTF kinds.
By separating parsing BTF from using all the information
it provides, we allow BTF to encode new features even if
they cannot be used.  This is helpful in particular for
cases where newer tools for BTF generation run on an
older kernel; BTF kinds may be present that the kernel
cannot yet use, but at least it can parse the BTF
provided.  Meanwhile userspace tools with newer libbpf
may be able to use the newer information.

The intent is to support encoding of kind layouts
optionally so that tools like pahole can add this
information.  So for each kind we record

- kind-related flags
- length of singular element following struct btf_type
- length of each of the btf_vlen() elements following

In addition we make space in the BTF header for
CRC32s computed over the BTF along with a CRC for
the base BTF; this allows split BTF to identify
a mismatch explicitly.

The ideas here were discussed at [1], [2]; hence

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
---
 include/uapi/linux/btf.h       | 18 ++++++++++++++++++
 tools/include/uapi/linux/btf.h | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index ec1798b6d3ff..5cc8cc793cd2 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -8,6 +8,19 @@
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
+/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
+#define BTF_FLAG_CRC_SET		(1 << 0)
+#define BTF_FLAG_BASE_CRC_SET		(1 << 1)
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +32,11 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
+
+	__u32	crc;		/* crc of BTF; used if flags set BTF_FLAG_CRC_SET */
+	__u32	base_crc;	/* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_SET */
 };
 
 /* Max # of type identifier */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index ec1798b6d3ff..5cc8cc793cd2 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -8,6 +8,19 @@
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
+/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
+#define BTF_FLAG_CRC_SET		(1 << 0)
+#define BTF_FLAG_BASE_CRC_SET		(1 << 1)
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +32,11 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
+
+	__u32	crc;		/* crc of BTF; used if flags set BTF_FLAG_CRC_SET */
+	__u32	base_crc;	/* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_SET */
 };
 
 /* Max # of type identifier */
-- 
2.31.1


