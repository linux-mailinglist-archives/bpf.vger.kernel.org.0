Return-Path: <bpf+bounces-2736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771BE73374C
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998821C21017
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7761C773;
	Fri, 16 Jun 2023 17:18:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF9182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:18:02 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A783D1FEC
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:18:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCiGtg021275;
	Fri, 16 Jun 2023 17:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=8o5FpErrqAPmxFvELGV2s51KoU61sURgJsrB6tf06AY=;
 b=dPw+LxJgdxTIgvt6roT6eUoBxzWceGkLw3w8wnukLcInHbqVJta7Zp4N8sf2TDijpq1S
 Ziv2du6xYo27YsXY9InL3A2xlIwSeNp7VMiKPUeGpdkR412j2zHLZIYl4Ggyx81F9DqT
 ceheoLTEJwNB3ngA9q8w46ILWZamB6aUv5aNznlQL6Ztr8JJHIviyAADDNMISXNKgGmP
 SRYmMn/1WS7SNFl+aIpMsc+9eNJYuX8RJnD43IuK0pqshbiFP9jSr7HoRJdS2Qi+vw4r
 MwEwLdkAW2G5Ieqq/6rSEdD+YOgteMfPKfDndFRynxwB7NLKIgxue8NZNcziQG5BWMmA Dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdvh29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GG5E71012376;
	Fri, 16 Jun 2023 17:17:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmertd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:41 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPa007608;
	Fri, 16 Jun 2023 17:17:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-3;
	Fri, 16 Jun 2023 17:17:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 2/9] libbpf: support handling of kind layout section in BTF
Date: Fri, 16 Jun 2023 18:17:20 +0100
Message-Id: <20230616171728.530116-3-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: 0ne5SpTCf5b7OfKIU4UzGE_-dWOnjFLr
X-Proofpoint-GUID: 0ne5SpTCf5b7OfKIU4UzGE_-dWOnjFLr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

support reading in kind layout fixing endian issues on reading;
also support writing kind layout section to raw BTF object.
There is not yet an API to populate the kind layout with meaningful
information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 132 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 33 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8484b563b53d..f9f919fdc728 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -39,40 +39,44 @@ struct btf {
 
 	/*
 	 * When BTF is loaded from an ELF or raw memory it is stored
-	 * in a contiguous memory block. The hdr, type_data, and, strs_data
-	 * point inside that memory region to their respective parts of BTF
-	 * representation:
+	 * in a contiguous memory block. The hdr, type_data, strs_data,
+	 * and optional kind layout point inside that memory region to their
+	 * respective parts of BTF representation:
 	 *
-	 * +--------------------------------+
-	 * |  Header  |  Types  |  Strings  |
-	 * +--------------------------------+
-	 * ^          ^         ^
-	 * |          |         |
-	 * hdr        |         |
-	 * types_data-+         |
-	 * strs_data------------+
+	 * +--------------------------------+-------------+
+	 * |  Header  |  Types  |  Strings  | Kind Layout |
+	 * +--------------------------------+-------------+
+	 * ^          ^         ^           ^
+	 * |          |         |           |
+	 * hdr        |         |           |
+	 * types_data-+         |           |
+	 * strs_data------------+           |
+	 * kind_layout----------------------+
+	 *
+	 * kind_layout is optional.
 	 *
 	 * If BTF data is later modified, e.g., due to types added or
 	 * removed, BTF deduplication performed, etc, this contiguous
-	 * representation is broken up into three independently allocated
-	 * memory regions to be able to modify them independently.
+	 * representation is broken up into three or four independently
+	 * allocated memory regions to be able to modify them independently.
 	 * raw_data is nulled out at that point, but can be later allocated
 	 * and cached again if user calls btf__raw_data(), at which point
-	 * raw_data will contain a contiguous copy of header, types, and
-	 * strings:
+	 * raw_data will contain a contiguous copy of header, types, strings
+	 * and (again optionally) kind layout:
 	 *
-	 * +----------+  +---------+  +-----------+
-	 * |  Header  |  |  Types  |  |  Strings  |
-	 * +----------+  +---------+  +-----------+
-	 * ^             ^            ^
-	 * |             |            |
-	 * hdr           |            |
-	 * types_data----+            |
-	 * strset__data(strs_set)-----+
+	 * +----------+  +---------+  +-----------+  +-------------+
+	 * |  Header  |  |  Types  |  |  Strings  |  | Kind layout |
+	 * +----------+  +---------+  +-----------+  +-------------+
+	 * ^             ^            ^              ^
+	 * |             |            |              |
+	 * hdr           |            |              |
+	 * types_data----+            |              |
+	 * strset__data(strs_set)-----+              |
+	 * kind_layout-------------------------------+
 	 *
-	 *               +----------+---------+-----------+
-	 *               |  Header  |  Types  |  Strings  |
-	 * raw_data----->+----------+---------+-----------+
+	 *               +----------+---------+-----------+-------------+
+	 *               |  Header  |  Types  |  Strings  | Kind Layout |
+	 * raw_data----->+----------+---------+-----------+-------------+
 	 */
 	struct btf_header *hdr;
 
@@ -116,6 +120,8 @@ struct btf {
 	/* whether strings are already deduplicated */
 	bool strs_deduped;
 
+	struct btf_kind_layout *kind_layout;
+
 	/* BTF object FD, if loaded into kernel */
 	int fd;
 
@@ -215,6 +221,13 @@ static void btf_bswap_hdr(struct btf_header *h)
 	h->type_len = bswap_32(h->type_len);
 	h->str_off = bswap_32(h->str_off);
 	h->str_len = bswap_32(h->str_len);
+	if (h->hdr_len >= sizeof(struct btf_header)) {
+		h->kind_layout_off = bswap_32(h->kind_layout_off);
+		h->kind_layout_len = bswap_32(h->kind_layout_len);
+		h->crc = bswap_32(h->crc);
+		h->base_crc = bswap_32(h->base_crc);
+	}
+
 }
 
 static int btf_parse_hdr(struct btf *btf)
@@ -222,14 +235,17 @@ static int btf_parse_hdr(struct btf *btf)
 	struct btf_header *hdr = btf->hdr;
 	__u32 meta_left;
 
-	if (btf->raw_size < sizeof(struct btf_header)) {
+	if (btf->raw_size < BTF_HEADER_MIN_LEN) {
 		pr_debug("BTF header not found\n");
 		return -EINVAL;
 	}
 
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
+		int swapped_len = bswap_32(hdr->hdr_len);
+
 		btf->swapped_endian = true;
-		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
+		if (swapped_len != sizeof(struct btf_header) &&
+		    swapped_len != BTF_HEADER_MIN_LEN) {
 			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
 				bswap_32(hdr->hdr_len));
 			return -ENOTSUP;
@@ -285,6 +301,32 @@ static int btf_parse_str_sec(struct btf *btf)
 	return 0;
 }
 
+static void btf_bswap_kind_layout_sec(struct btf_kind_layout *k, int len)
+{
+	struct btf_kind_layout *end = (void *)k + len;
+
+	while (k < end) {
+		k->flags = bswap_16(k->flags);
+		k++;
+	}
+}
+
+static int btf_parse_kind_layout_sec(struct btf *btf)
+{
+	const struct btf_header *hdr = btf->hdr;
+
+	if (hdr->hdr_len < sizeof(struct btf_header) ||
+	    !hdr->kind_layout_off || !hdr->kind_layout_len)
+		return 0;
+	if (hdr->kind_layout_len < sizeof(struct btf_kind_layout)) {
+		pr_debug("Invalid BTF kind layout section\n");
+		return -EINVAL;
+	}
+	btf->kind_layout = btf->raw_data + btf->hdr->hdr_len + btf->hdr->kind_layout_off;
+
+	return 0;
+}
+
 static int btf_type_size(const struct btf_type *t)
 {
 	const int base_size = sizeof(struct btf_type);
@@ -901,6 +943,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	btf->types_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->type_off;
 
 	err = btf_parse_str_sec(btf);
+	err = err ?: btf_parse_kind_layout_sec(btf);
 	err = err ?: btf_parse_type_sec(btf);
 	if (err)
 		goto done;
@@ -1267,6 +1310,11 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	}
 
 	data_sz = hdr->hdr_len + hdr->type_len + hdr->str_len;
+	if (btf->kind_layout) {
+		data_sz = roundup(data_sz, 4);
+		data_sz += hdr->kind_layout_len;
+		hdr->kind_layout_off = roundup(hdr->type_len + hdr->str_len, 4);
+	}
 	data = calloc(1, data_sz);
 	if (!data)
 		return NULL;
@@ -1293,8 +1341,15 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	p += hdr->type_len;
 
 	memcpy(p, btf_strs_data(btf), hdr->str_len);
-	p += hdr->str_len;
+	/* round up to 4 byte alignment to match offset above */
+	p = data + hdr->hdr_len + roundup(hdr->type_len + hdr->str_len, 4);
 
+	if (btf->kind_layout) {
+		memcpy(p, btf->kind_layout, hdr->kind_layout_len);
+		if (swap_endian)
+			btf_bswap_kind_layout_sec(p, hdr->kind_layout_len);
+		p += hdr->kind_layout_len;
+	}
 	*size = data_sz;
 	return data;
 err_out:
@@ -1425,13 +1480,13 @@ static void btf_invalidate_raw_data(struct btf *btf)
 	}
 }
 
-/* Ensure BTF is ready to be modified (by splitting into a three memory
- * regions for header, types, and strings). Also invalidate cached
- * raw_data, if any.
+/* Ensure BTF is ready to be modified (by splitting into a three or four memory
+ * regions for header, types, strings and optional kind layout). Also invalidate
+ * cached raw_data, if any.
  */
 static int btf_ensure_modifiable(struct btf *btf)
 {
-	void *hdr, *types;
+	void *hdr, *types, *kind_layout = NULL;
 	struct strset *set = NULL;
 	int err = -ENOMEM;
 
@@ -1446,9 +1501,17 @@ static int btf_ensure_modifiable(struct btf *btf)
 	types = malloc(btf->hdr->type_len);
 	if (!hdr || !types)
 		goto err_out;
+	if (btf->hdr->hdr_len >= sizeof(struct btf_header)  &&
+	    btf->hdr->kind_layout_off && btf->hdr->kind_layout_len) {
+		kind_layout = calloc(1, btf->hdr->kind_layout_len);
+		if (!kind_layout)
+			goto err_out;
+	}
 
 	memcpy(hdr, btf->hdr, btf->hdr->hdr_len);
 	memcpy(types, btf->types_data, btf->hdr->type_len);
+	if (kind_layout)
+		memcpy(kind_layout, btf->kind_layout, btf->hdr->kind_layout_len);
 
 	/* build lookup index for all strings */
 	set = strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr->str_len);
@@ -1463,6 +1526,8 @@ static int btf_ensure_modifiable(struct btf *btf)
 	btf->types_data_cap = btf->hdr->type_len;
 	btf->strs_data = NULL;
 	btf->strs_set = set;
+	btf->kind_layout = kind_layout;
+
 	/* if BTF was created from scratch, all strings are guaranteed to be
 	 * unique and deduplicated
 	 */
@@ -1480,6 +1545,7 @@ static int btf_ensure_modifiable(struct btf *btf)
 	strset__free(set);
 	free(hdr);
 	free(types);
+	free(kind_layout);
 	return err;
 }
 
-- 
2.39.3


