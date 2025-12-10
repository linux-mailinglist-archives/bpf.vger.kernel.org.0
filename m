Return-Path: <bpf+bounces-76432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60326CB3F8C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFD23030D98
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469C32C321;
	Wed, 10 Dec 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DDJTJHLi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD32FFDC2;
	Wed, 10 Dec 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398861; cv=none; b=IFIbWUPG0N6cErKvNAQJlN9PxjSbUIpUT/2X50xErNSb0SisjlyhTvfjZ2aBu5jentP2mvR5j9RgZ5N3BLgPQqgN6b9f0wtXyZ0ZRTLrhyD9akVDeVBTJG7f1H5sT8DOijvLEs+OPnqyL3vJZx1x/4HJ0OXhUS13nULqB5zNDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398861; c=relaxed/simple;
	bh=2qlVpQG8RSGHt0GgyHDo6cmvpwg/YCtLD0OMG5hLwYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsEutstJz3O+ahisV7g40bYKzZc5YLxlbrvgLUqSIwLqaw9nlS+ZCbp7mQ6RDKhUQ/YDScK/68p1kHA/nnave191mss4uLkahrAqzjkmBK+JXlTFHJa/bjxmZD0QuXsGzeiVBqT8FrQ/oS7zja81BhLFAWbPLCDHQ0lX9zkxLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DDJTJHLi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYB1M3758073;
	Wed, 10 Dec 2025 20:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=E+V+G
	yzErcove4jmu4cJ58ZbtMzf2k8VZCPe+J9yuRc=; b=DDJTJHLivIIXVFc9158VJ
	dLciA9vOunBGzXLoR3cGeqsWfDa78b5BFeGqN6LC262Bdej4PUU0qEDMeBDYK4fP
	FYthSvtpl5hAAJyEWNlrq9KbMf5eZqT6EscSEghsgw9qViMEQldLTze45YeAnZ2I
	WaApe0KzrBu098eYK1xc+VwZU3ZJmZ4tB/TkVuIAk6ZBNEY88M3L0pYoaQd8wc2F
	D8LWQC0A4cusoFj2+vjUqq4FzYhXeJNEB9toAONaA+ncq0sEXPRF1Y4nJCRwQ6Ii
	wHDEh4ZZVfud+DFcv4qG63J89JwLZZBWoLcrWC2Q/XAS5HaMtCyOah7Q6AuxT2Kg
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aybqv0h6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:32:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAKTEKT039944;
	Wed, 10 Dec 2025 20:32:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrpxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:32:57 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkSb001635;
	Wed, 10 Dec 2025 20:32:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-5;
	Wed, 10 Dec 2025 20:32:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 04/10] libbpf: Add kind layout encoding support
Date: Wed, 10 Dec 2025 20:32:37 +0000
Message-ID: <20251210203243.814529-5-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfX0EQzCfq4aMdP
 s8PSUIze+z8mudWT08uTjTAeybXQeoTQsvf3m3GUrvTQWYw7KrQqokJCqcT8lRMeiixiL2anf7q
 CvGmHuJ77y+gAqnSiYqqmPSd7OB3621WBFIjrOO3wJLP1q6GaJlvq2MWWeiRa6mTHN7v6Eulgda
 z9mBvYDVmhAVb5LtjYYoGKqcNd3l9ybFafTfqwmEL80aVDk3TlJSr4C/1meBfvpHn873AGzUm9d
 FMPpqwtJm7ZPQBvv4nQlwC1PL9b1Gi4WoGDqEXnKWu+SRkubgMsBDl+KqzhvJQ+xPCe8uwOtB7R
 fArfQOxQ2JVcTMMalSwo69+J3M5jfTLcA3orrfmF7ni0MFMqucdBr/6nfmY8G/JCmyOD6RoLB+E
 g4kWyIqofPRDAG9dXbpHwr5uEfrTQyN4MpVew0LNe5PUFS/Dc+w=
X-Proofpoint-ORIG-GUID: U8zYbnPhsbv9JsfeKmvMn_NaN9fOtvoP
X-Authority-Analysis: v=2.4 cv=OLAqHCaB c=1 sm=1 tr=0 ts=6939d8fa b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=cKRRRYibTiSyJAuzRoMA:9 cc=ntf awl=host:12099
X-Proofpoint-GUID: U8zYbnPhsbv9JsfeKmvMn_NaN9fOtvoP

Support encoding of BTF kind layout data via btf__new_empty_opts().

Current supported opts are base_btf and add_kind_layout.

Kind layout information is maintained in btf.c in the
kind_layouts[] array; when BTF is created with the
add_kind_layout option it represents the current view
of supported BTF kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 61 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      | 20 +++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 4eb0704a0309..2133e976cb9c 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -29,6 +29,35 @@
 
 static struct btf_type btf_void;
 
+/* Describe how kinds are laid out; some have a singular element following the "struct btf_type",
+ * some have BTF_INFO_VLEN(t->info) elements.  Specify sizes for both.  Flags are currently unused.
+ * Kind layout can be optionally added to the BTF representation in a dedicated section to
+ * facilitate parsing.  New kinds must be added here.
+ */
+struct btf_kind_layout kind_layouts[NR_BTF_KINDS] = {
+/*	singular element size		vlen element(s) size */
+{	0,				0				}, /* _UNKN */
+{	sizeof(__u32),			0				}, /* _INT */
+{	0,				0				}, /* _PTR */
+{	sizeof(struct btf_array),	0				}, /* _ARRAY */
+{	0,				sizeof(struct btf_member)	}, /* _STRUCT */
+{	0,				sizeof(struct btf_member)	}, /* _UNION */
+{	0,				sizeof(struct btf_enum)		}, /* _ENUM */
+{	0,				0				}, /* _FWD */
+{	0,				0				}, /* _TYPEDEF */
+{	0,				0				}, /* _VOLATILE */
+{	0,				0				}, /* _CONST */
+{	0,				0				}, /* _RESTRICT */
+{	0,				0				}, /* _FUNC */
+{	0,				sizeof(struct btf_param)	}, /* _FUNC_PROTO */
+{	sizeof(struct btf_var),		0				}, /* _VAR */
+{	0,				sizeof(struct btf_var_secinfo)	}, /* _DATASEC */
+{	0,				0				}, /* _FLOAT */
+{	sizeof(struct btf_decl_tag),	0				}, /* _DECL_TAG */
+{	0,				0				}, /* _TYPE_TAG */
+{	0,				sizeof(struct btf_enum64)	}, /* _ENUM64 */
+};
+
 struct btf {
 	/* raw BTF data in native endianness */
 	void *raw_data;
@@ -1067,8 +1096,9 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
 {
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf_header *hdr;
 	struct btf *btf;
 
@@ -1111,6 +1141,17 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 		free(btf);
 		return ERR_PTR(-ENOMEM);
 	}
+
+	if (opts->add_kind_layout) {
+		hdr->kind_layout_len = sizeof(kind_layouts);
+		btf->kind_layout = malloc(hdr->kind_layout_len);
+		if (!btf->kind_layout) {
+			free(btf->hdr);
+			free(btf);
+			return ERR_PTR(-ENOMEM);
+		}
+		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
+	}
 	memcpy(btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
@@ -1118,12 +1159,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 struct btf *btf__new_empty(void)
 {
-	return libbpf_ptr(btf_new_empty(NULL));
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	return libbpf_ptr(btf_new_empty(&opts));
 }
 
 struct btf *btf__new_empty_split(struct btf *base_btf)
 {
-	return libbpf_ptr(btf_new_empty(base_btf));
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	opts.base_btf = base_btf;
+
+	return libbpf_ptr(btf_new_empty(&opts));
+}
+
+struct btf *btf__new_empty_opts(struct btf_new_opts *opts)
+{
+	if (!OPTS_VALID(opts, btf_new_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	return libbpf_ptr(btf_new_empty(opts));
 }
 
 static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, bool is_mmap)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index cc01494d6210..dcc166834937 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -109,6 +109,26 @@ LIBBPF_API struct btf *btf__new_empty(void);
  */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
+struct btf_new_opts {
+	size_t sz;
+	struct btf *base_btf;	/* optional base BTF */
+	bool add_kind_layout;	/* add BTF kind layout information */
+	size_t:0;
+};
+#define btf_new_opts__last_field add_kind_layout
+
+/**
+ * @brief **btf__new_empty_opts()** creates an unpopulated BTF object with
+ * optional *base_btf* and BTF kind layout description if *add_kind_layout*
+ * is set
+ * @return new BTF object instance which has to be eventually freed with
+ * **btf__free()**
+ *
+ * On error, NULL is returned and the thread-local `errno` variable is
+ * set to the error code.
+ */
+LIBBPF_API struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
+
 /**
  * @brief **btf__distill_base()** creates new versions of the split BTF
  * *src_btf* and its base BTF. The new base BTF will only contain the types
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 84fb90a016c9..0fb9a1f70e72 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -453,4 +453,5 @@ LIBBPF_1.7.0 {
 		bpf_map__exclusive_program;
 		bpf_prog_assoc_struct_ops;
 		bpf_program__assoc_struct_ops;
+		btf__new_empty_opts;
 } LIBBPF_1.6.0;
-- 
2.43.5


