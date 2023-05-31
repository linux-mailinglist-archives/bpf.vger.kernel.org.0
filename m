Return-Path: <bpf+bounces-1539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516B718B01
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301852815E5
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148D3C0B9;
	Wed, 31 May 2023 20:21:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367834CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:21:24 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B66121
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VK7HN8031553;
	Wed, 31 May 2023 20:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=edpUMvx9nc746n340mpDJsAQcNBqSlvkm5A3SNEBO2o=;
 b=x0Axjs4ReFukVQqA4xBDO6tR83YkadLe6Vwxj/JSyWrmkwpEuaxLbVSfU2UhVYWw3ZzF
 hlV1ooFRfRsIcJjx5JEGXsc60v/OOhhnimDu1/kujGLj2By9e1OfSm9WyQfTIM/Sq/Am
 7zxqHGRmKihYbKHp1UndXJ3COKxCrfNnND1ZjTUobqQ+EQsZVC5w230aZuHT2Lrf948F
 AL9WeOjsDRDuqtDyJGYO/zgDf5NW5JG1MWwcWmiumJoo5ClVWg+IYtafNuI7AmBiA1qc
 lM4fHMITMKsjfZQFFaLRwHnkHimxYwBSPx3MPDwQY996Yejx45ZhEZ3T18KgOilZ3W1Y iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4xww8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJkL0q019748;
	Wed, 31 May 2023 20:20:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6djh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaEN000653;
	Wed, 31 May 2023 20:20:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-2;
	Wed, 31 May 2023 20:20:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
Date: Wed, 31 May 2023 21:19:28 +0100
Message-Id: <20230531201936.1992188-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531201936.1992188-1-alan.maguire@oracle.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310172
X-Proofpoint-GUID: z4KnLF4RDRZ6s2A9h2PzI33ZCAL-J0Z-
X-Proofpoint-ORIG-GUID: z4KnLF4RDRZ6s2A9h2PzI33ZCAL-J0Z-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BTF kind metadata provides information to parse BTF kinds.
By separating parsing BTF from using all the information
it provides, we allow BTF to encode new features even if
they cannot be used.  This is helpful in particular for
cases where newer tools for BTF generation run on an
older kernel; BTF kinds may be present that the kernel
cannot yet use, but at least it can parse the BTF
provided.  Meanwhile userspace tools with newer libbpf
may be able to use the newer information.

The intent is to support encoding of kind metadata
optionally so that tools like pahole can add this
information.  So for each kind we record

- a kind name string
- kind-related flags
- length of singular element following struct btf_type
- length of each of the btf_vlen() elements following

In addition we make space in the metadata for
CRC32s computed over the BTF along with a CRC for
the base BTF; this allows split BTF to identify
a mismatch explicitly.  Finally we provide an
offset for an optional description string.

The ideas here were discussed at [1] hence

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
---
 include/uapi/linux/btf.h       | 29 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/btf.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index ec1798b6d3ff..94c1f4518249 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -8,6 +8,34 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/* is this information required? If so it cannot be sanitized safely. */
+#define BTF_KIND_META_OPTIONAL		(1 << 0)
+
+struct btf_kind_meta {
+	__u32 name_off;		/* kind name string offset */
+	__u16 flags;		/* see BTF_KIND_META_* values above */
+	__u8 info_sz;		/* size of singular element after btf_type */
+	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
+};
+
+/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
+#define BTF_META_CRC_SET		(1 << 0)
+#define BTF_META_BASE_CRC_SET		(1 << 1)
+
+struct btf_metadata {
+	__u8	kind_meta_cnt;		/* number of struct btf_kind_meta */
+	__u32	flags;
+	__u32	description_off;	/* optional description string */
+	__u32	crc;			/* crc32 of BTF */
+	__u32	base_crc;		/* crc32 of base BTF */
+	struct btf_kind_meta kind_meta[];
+};
+
+struct btf_meta_header {
+	__u32	meta_off;	/* offset of metadata section */
+	__u32	meta_len;	/* length of metadata section */
+};
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +47,7 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	struct btf_meta_header meta_header;
 };
 
 /* Max # of type identifier */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index ec1798b6d3ff..94c1f4518249 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -8,6 +8,34 @@
 #define BTF_MAGIC	0xeB9F
 #define BTF_VERSION	1
 
+/* is this information required? If so it cannot be sanitized safely. */
+#define BTF_KIND_META_OPTIONAL		(1 << 0)
+
+struct btf_kind_meta {
+	__u32 name_off;		/* kind name string offset */
+	__u16 flags;		/* see BTF_KIND_META_* values above */
+	__u8 info_sz;		/* size of singular element after btf_type */
+	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
+};
+
+/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
+#define BTF_META_CRC_SET		(1 << 0)
+#define BTF_META_BASE_CRC_SET		(1 << 1)
+
+struct btf_metadata {
+	__u8	kind_meta_cnt;		/* number of struct btf_kind_meta */
+	__u32	flags;
+	__u32	description_off;	/* optional description string */
+	__u32	crc;			/* crc32 of BTF */
+	__u32	base_crc;		/* crc32 of base BTF */
+	struct btf_kind_meta kind_meta[];
+};
+
+struct btf_meta_header {
+	__u32	meta_off;	/* offset of metadata section */
+	__u32	meta_len;	/* length of metadata section */
+};
+
 struct btf_header {
 	__u16	magic;
 	__u8	version;
@@ -19,6 +47,7 @@ struct btf_header {
 	__u32	type_len;	/* length of type section	*/
 	__u32	str_off;	/* offset of string section	*/
 	__u32	str_len;	/* length of string section	*/
+	struct btf_meta_header meta_header;
 };
 
 /* Max # of type identifier */
-- 
2.31.1


