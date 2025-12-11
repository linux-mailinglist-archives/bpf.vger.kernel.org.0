Return-Path: <bpf+bounces-76479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C0CB6906
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A383036584
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA48311C33;
	Thu, 11 Dec 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qSJLeNEo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED000313529;
	Thu, 11 Dec 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471652; cv=none; b=oNZqNW7ud+KiFV0jegEggh1jBqc0sHMsNvNQum9PZjm9Xvszb/ndS2v0KzDQ0Y2vhZkAbpBlO/V5YvefHjv0TkTfSUfKbUOPSenjIpeSUzfBQhR37EH1buWPwZyLg6PapmD2NM2HaL0ubhrh7gCrPK+HDDfyGB4iS6MmcWCF7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471652; c=relaxed/simple;
	bh=32g6IZdIx146r/su+5QTlWYhYv6qkGjihVARQwsM+8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOwMdmhQsd9U4+vF9g4AfYGkjpI3G9uOIAnocARp9JIqrnNeTf4gPfHW6anx46VqCLYl2WbYo7qnSl6Oxcd257AhkpYy1vhEtowwT0DwFcF6ntbQTPq+GEbBswzYVn9CgSV5mhCRmKyUZ6GUgPsw7ykONzS2qZzE6V4/ppRCXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qSJLeNEo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBG57iE1695668;
	Thu, 11 Dec 2025 16:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8+5TA
	+r3JvZ46+ZDlCPF2SX/6kbf57/3v0UwHIGpzpI=; b=qSJLeNEoS4mszfsXPWss1
	Zyo50KuFaqp55p5gnmXT9A/bGx3TPo9PA68g2Z+ovMu1F8+NznVMwWAQQgeXMxK1
	1bCt0kACJt3u9H9LUNbghwShoErKq0juG2Glpwp+9mfxuRJSQc0M+UNEy108S+GY
	Y27r+idqUjl+bbzTADM5T0KxbbGTqtiyktXCbR/7NcT9NM96YBaeyqoaOlhOoAHF
	2JA/4x4dX0068dTUSToDNy0Ri+0RL8UrGa1AeriRhGbe/GaUVVb9ExFatQd4+R71
	CMlNBnMhdrLXYXuTHSoab7KGFvTZx6rdeN7FdVg+WkROqEEb13g4YrS0th9V0Kh6
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aycne1v0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBEq4tG039892;
	Thu, 11 Dec 2025 16:47:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnswx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:01 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BBGknmF030704;
	Thu, 11 Dec 2025 16:47:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-126.vpn.oracle.com [10.154.50.126])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxnswqy-5;
	Thu, 11 Dec 2025 16:47:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 04/10] libbpf: Add kind layout encoding support
Date: Thu, 11 Dec 2025 16:46:40 +0000
Message-ID: <20251211164646.1219122-5-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=F65at6hN c=1 sm=1 tr=0 ts=693af586 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lIN0CykIrsTzq82mcFQA:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: IC6KjNgWrmmdUCWksI9bBXblRv9akCqG
X-Proofpoint-ORIG-GUID: IC6KjNgWrmmdUCWksI9bBXblRv9akCqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNCBTYWx0ZWRfX5WgC9C9JEMp6
 epz4y4IZ210LBI77d3K9QRbGvpYgLtwtyA2lxPm4Qjqkiy8yq84UXHG1qlEKLUVKf/NP5Qg1m3X
 6ExG2xDTt+oHmj4fgvBaFNiPPAM/4oAqP7eigLJOmNnGkKKSq5hJe2rk215yDka95VJT0SZKWLd
 Hthm47pgsJ20p1Yr+4YU3O7tUROKo7sqoY0k9gma8mbFk/Naa4C/T9NJpYI4zXup1vVtaMnis3f
 8J/kdorPiN1ZGDnvHygj/9/BzbvD7j3BHaz0nDaVsHTZJt+hv5yoHg661+H2KGCOiVQ40ma/IVR
 uO5btX9Jg7QigSrJ/6oTdLw0IP5UsiRUBSFRVY0ACRQ/yb2i/nfwTfX42HZepgDHBlwewRBdiaO
 h/vZjvhorAjYvNsjEpsMHoeHEX6b7iagbZeUdH2FCrk5cRImW10=

Support encoding of BTF kind layout data via btf__new_empty_opts().

Current supported opts are base_btf and add_kind_layout.

Kind layout information is maintained in btf.c in the
kind_layouts[] array; when BTF is created with the
add_kind_layout option it represents the current view
of supported BTF kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 60 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      | 20 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c21ee836ba1f..9ef46aef43fc 100644
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
@@ -1082,8 +1111,10 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
 {
+	bool add_kind_layout = OPTS_GET(opts, add_kind_layout, false);
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf_header *hdr;
 	struct btf *btf;
 
@@ -1107,6 +1138,8 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 	/* +1 for empty string at offset 0 */
 	btf->raw_size = sizeof(struct btf_header) + (base_btf ? 0 : 1);
+	if (add_kind_layout)
+		btf->raw_size = roundup(btf->raw_size, 4) + sizeof(kind_layouts);
 	btf->raw_data = calloc(1, btf->raw_size);
 	if (!btf->raw_data) {
 		free(btf);
@@ -1127,6 +1160,13 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 		free(btf);
 		return ERR_PTR(-ENOMEM);
 	}
+
+	if (add_kind_layout) {
+		hdr->kind_layout_len = sizeof(kind_layouts);
+		hdr->kind_layout_off = roundup(hdr->str_len, 4);
+		btf->kind_layout = btf->raw_data + hdr->hdr_len + hdr->kind_layout_off;
+		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
+	}
 	memcpy(btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
@@ -1134,12 +1174,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
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
2.39.3


