Return-Path: <bpf+bounces-2735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDAE73374B
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6975328159F
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75931B916;
	Fri, 16 Jun 2023 17:17:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2A182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:17:59 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29071FF7
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:17:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCi2X3005979;
	Fri, 16 Jun 2023 17:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=gXV5mOEkgNVFNwO4SSJG0IW4iXAaUZWuyK18GOOJbM4=;
 b=csNyrDBx5OOsTxLwCykBGl/uXVr9DpbY6bw9Oxt1KhvcEX2VcqLU7XhxjFvZVxn7rOcx
 jjgFojIApBYzd6XnUYTU/kTSfE1UhCBIpiGQwlvGyYXMUty2g0VZN3MsDoRvjx0QFfNo
 c5GgavNDnBQmwX9PK1D2e98eTnLcoPIylOIZ/1Wb1O3LhNPFoUn3SAJRM+lgB7MGAP0o
 5opCry+3frDDRPgDW1gr2ktOPRWaT/ZdFPqpCYJ528p2plewv8/2w+XfyH+uUlS7zi1o
 UssAFulGIris9wwva1b/uLsuWXRAuZUGMXgklu1uO+q5HOCKQybhlJaksxPQPS6XpNNX YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7dcrde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GFwAxw012512;
	Fri, 16 Jun 2023 17:17:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmerta0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPY007608;
	Fri, 16 Jun 2023 17:17:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-2;
	Fri, 16 Jun 2023 17:17:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 1/9] btf: add kind layout encoding, crcs to UAPI
Date: Fri, 16 Jun 2023 18:17:19 +0100
Message-Id: <20230616171728.530116-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230616171728.530116-1-alan.maguire@oracle.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160155
X-Proofpoint-ORIG-GUID: k6DaUIEWl8L1fnGIVLkzlmRr0jo6xok8
X-Proofpoint-GUID: k6DaUIEWl8L1fnGIVLkzlmRr0jo6xok8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 include/uapi/linux/btf.h       | 24 ++++++++++++++++++++++++
 tools/include/uapi/linux/btf.h | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index ec1798b6d3ff..cea9125ed953 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -8,6 +8,22 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/* is this information required? If so it cannot be sanitized safely. */
+#define BTF_KIND_LAYOUT_OPTIONAL		(1 << 0)
+
+/* kind layout section consists of a struct btf_kind_layout for each known
+ * kind at BTF encoding time.
+ */
+struct btf_kind_layout {
+	__u16 flags;		/* see BTF_KIND_LAYOUT_* values above */
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
@@ -19,8 +35,16 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
+
+	__u32	crc;		/* crc of BTF; used if flags set BTF_FLAG_CRC_VALID */
+	__u32	base_crc;	/* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_VALID */
 };
 
+/* required minimum BTF header length */
+#define BTF_HEADER_MIN_LEN	(sizeof(struct btf_header) - 16)
+
 /* Max # of type identifier */
 #define BTF_MAX_TYPE	0x000fffff
 /* Max offset into the string section */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index ec1798b6d3ff..cea9125ed953 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -8,6 +8,22 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/* is this information required? If so it cannot be sanitized safely. */
+#define BTF_KIND_LAYOUT_OPTIONAL		(1 << 0)
+
+/* kind layout section consists of a struct btf_kind_layout for each known
+ * kind at BTF encoding time.
+ */
+struct btf_kind_layout {
+	__u16 flags;		/* see BTF_KIND_LAYOUT_* values above */
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
@@ -19,8 +35,16 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	__u32	kind_layout_off;/* offset of kind layout section */
+	__u32	kind_layout_len;/* length of kind layout section */
+
+	__u32	crc;		/* crc of BTF; used if flags set BTF_FLAG_CRC_VALID */
+	__u32	base_crc;	/* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_VALID */
 };
 
+/* required minimum BTF header length */
+#define BTF_HEADER_MIN_LEN	(sizeof(struct btf_header) - 16)
+
 /* Max # of type identifier */
 #define BTF_MAX_TYPE	0x000fffff
 /* Max offset into the string section */
-- 
2.39.3


