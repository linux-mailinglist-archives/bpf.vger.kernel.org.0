Return-Path: <bpf+bounces-14920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D77E8FBF
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6C280C4D
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D0525A;
	Sun, 12 Nov 2023 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MqZyaOO9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF5811
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:08 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E182D62
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:06 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCjJMb030563;
	Sun, 12 Nov 2023 12:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=0zB0lwzVbbOxxaN+/YtN9HrKGbspvfZZLc4/QRvopDw=;
 b=MqZyaOO9Y1mHqCLP52s4jjYKako0w/IG9Ie185nDCZdFtbytDzsGgXiNtVOBJDaTTz5R
 4iNwznjoUSdGj7iEC8N4aWewF3N+7UxER7UKy3x0VM0fE3zMbDbc/xBVznRVH2rvb/Ah
 nu/KHaENI5M6yCtbupMmv+2+i6uuj0a5xE67n6IBcl4uqVDJKnw6ryt2sPkFcGXhuCxc
 Ioarzfa79Ki0GqKgc14FevErK66TClJDEv8Pt0JjOEYbcmex75+sT1CeMYXR17NmcEc0
 jTQDxMpZfEEPgheC93DOaDxyoMtdaEGyQIqG1AMsy2ltj+1iIvAYXQcQ+zGWlme/8M7Y Rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd1e1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:48:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCEGNf008467;
	Sun, 12 Nov 2023 12:48:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:48:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmce6029718;
	Sun, 12 Nov 2023 12:48:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-3;
	Sun, 12 Nov 2023 12:48:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 02/17] libbpf: support kind layout section handling in BTF
Date: Sun, 12 Nov 2023 12:48:19 +0000
Message-Id: <20231112124834.388735-3-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: HRlIwO_dC2-mtpOanlnvGqaTUe_GPtiD
X-Proofpoint-GUID: HRlIwO_dC2-mtpOanlnvGqaTUe_GPtiD

support reading in kind layout fixing endian issues on reading;
also support writing kind layout section to raw BTF object.
There is not yet an API to populate the kind layout with meaningful
information.

As part of this, we need to consider multiple valid BTF header
sizes; the original or the kind layout/CRC-extended headers.
So to support this, the "struct btf" representation is modified
to always allocate a "struct btf_header" and copy the valid
portion from the raw data to it; this means we can always safely
check fields like btf->hdr->crc or btf->hdr->kind_layout_len.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 218 +++++++++++++++++++++++++++++++-------------
 1 file changed, 157 insertions(+), 61 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ee95fd379d4d..1d043fe49d4c 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -39,42 +39,53 @@ struct btf {
 
 	/*
 	 * When BTF is loaded from an ELF or raw memory it is stored
-	 * in a contiguous memory block. The hdr, type_data, and, strs_data
+	 * in a contiguous memory block. The  type_data, and, strs_data
 	 * point inside that memory region to their respective parts of BTF
 	 * representation:
 	 *
-	 * +--------------------------------+
-	 * |  Header  |  Types  |  Strings  |
-	 * +--------------------------------+
-	 * ^          ^         ^
-	 * |          |         |
-	 * hdr        |         |
-	 * types_data-+         |
-	 * strs_data------------+
+	 * +--------------------------------+---------------------+
+	 * |  Header  |  Types  |  Strings  |Optional kind layout |
+	 * +--------------------------------+---------------------+
+	 * ^          ^         ^           ^
+	 * |          |         |           |
+	 * raw_data   |         |           |
+	 * types_data-+         |           |
+	 * strs_data------------+           |
+	 * kind_layout----------------------+
+	 *
+	 * A separate struct btf_header is allocated for btf->hdr,
+	 * and header information is copied into it.  This allows us
+	 * to handle header data for various header formats; the original,
+	 * the extended header with CRCs/kind layout, etc.
 	 *
 	 * If BTF data is later modified, e.g., due to types added or
 	 * removed, BTF deduplication performed, etc, this contiguous
-	 * representation is broken up into three independently allocated
-	 * memory regions to be able to modify them independently.
+	 * representation is broken up into four independent memory
+	 * regions.
+	 *
 	 * raw_data is nulled out at that point, but can be later allocated
 	 * and cached again if user calls btf__raw_data(), at which point
-	 * raw_data will contain a contiguous copy of header, types, and
-	 * strings:
+	 * raw_data will contain a contiguous copy of header, types, strings
+	 * and optionally kind_layout.  kind_layout optionally points to a
+	 * kind_layout array - this allows us to encode information about
+	 * the kinds known at encoding time.  If kind_layout is NULL no
+	 * kind information is encoded.
 	 *
-	 * +----------+  +---------+  +-----------+
-	 * |  Header  |  |  Types  |  |  Strings  |
-	 * +----------+  +---------+  +-----------+
-	 * ^             ^            ^
-	 * |             |            |
-	 * hdr           |            |
-	 * types_data----+            |
-	 * strset__data(strs_set)-----+
+	 * +----------+  +---------+  +-----------+   +-----------+
+	 * |  Header  |  |  Types  |  |  Strings  |   |kind_layout|
+	 * +----------+  +---------+  +-----------+   +-----------+
+	 * ^             ^            ^               ^
+	 * |             |            |               |
+	 * hdr           |            |               |
+	 * types_data----+            |               |
+	 * strset__data(strs_set)-----+               |
+	 * kind_layout--------------------------------+
 	 *
-	 *               +----------+---------+-----------+
-	 *               |  Header  |  Types  |  Strings  |
-	 * raw_data----->+----------+---------+-----------+
+	 *               +----------+---------+-----------+---------------------+
+	 *               |  Header  |  Types  |  Strings  | Optional kind layout|
+	 * raw_data----->+----------+---------+-----------+---------------------+
 	 */
-	struct btf_header *hdr;
+	struct btf_header *hdr; /* separately-allocated header data */
 
 	void *types_data;
 	size_t types_data_cap; /* used size stored in hdr->type_len */
@@ -116,6 +127,14 @@ struct btf {
 	/* whether strings are already deduplicated */
 	bool strs_deduped;
 
+	/* Points either at raw kind layout data in parsed BTF (if present), or
+	 * at an allocated kind layout array when BTF is modifiable.
+	 */
+	void *kind_layout;
+
+	/* is BTF modifiable? i.e. is it split into separate sections as described above? */
+	bool modifiable;
+
 	/* BTF object FD, if loaded into kernel */
 	int fd;
 
@@ -207,7 +226,7 @@ static int btf_add_type_idx_entry(struct btf *btf, __u32 type_off)
 	return 0;
 }
 
-static void btf_bswap_hdr(struct btf_header *h)
+static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
 {
 	h->magic = bswap_16(h->magic);
 	h->hdr_len = bswap_32(h->hdr_len);
@@ -215,50 +234,70 @@ static void btf_bswap_hdr(struct btf_header *h)
 	h->type_len = bswap_32(h->type_len);
 	h->str_off = bswap_32(h->str_off);
 	h->str_len = bswap_32(h->str_len);
+	/* May be operating on raw data with hdr_len that does not include below fields */
+	if (hdr_len >= sizeof(struct btf_header)) {
+		h->kind_layout_off = bswap_32(h->kind_layout_off);
+		h->kind_layout_len = bswap_32(h->kind_layout_len);
+		h->crc = bswap_32(h->crc);
+		h->base_crc = bswap_32(h->base_crc);
+	}
 }
 
 static int btf_parse_hdr(struct btf *btf)
 {
-	struct btf_header *hdr = btf->hdr;
+	struct btf_header *hdr = btf->raw_data;
+	__u32 hdr_len = hdr->hdr_len;
 	__u32 meta_left;
 
-	if (btf->raw_size < sizeof(struct btf_header)) {
+	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
 		pr_debug("BTF header not found\n");
 		return -EINVAL;
 	}
 
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
 		btf->swapped_endian = true;
-		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
+		hdr_len = bswap_32(hdr->hdr_len);
+		if (hdr_len < offsetofend(struct btf_header, str_len)) {
 			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
-				bswap_32(hdr->hdr_len));
+				hdr_len);
 			return -ENOTSUP;
 		}
-		btf_bswap_hdr(hdr);
 	} else if (hdr->magic != BTF_MAGIC) {
 		pr_debug("Invalid BTF magic: %x\n", hdr->magic);
 		return -EINVAL;
 	}
 
-	if (btf->raw_size < hdr->hdr_len) {
+	if (btf->raw_size < hdr_len) {
 		pr_debug("BTF header len %u larger than data size %u\n",
-			 hdr->hdr_len, btf->raw_size);
+			 hdr_len, btf->raw_size);
 		return -EINVAL;
 	}
 
-	meta_left = btf->raw_size - hdr->hdr_len;
-	if (meta_left < (long long)hdr->str_off + hdr->str_len) {
+	/* At this point, we have basic header information, so allocate btf->hdr */
+	btf->hdr = calloc(1, sizeof(struct btf_header));
+	if (!btf->hdr) {
+		pr_debug("BTF header allocation failed\n");
+		return -ENOMEM;
+	}
+	if (btf->swapped_endian)
+		btf_bswap_hdr(hdr, hdr_len);
+	memcpy(btf->hdr, hdr, hdr_len < sizeof(struct btf_header) ? hdr_len :
+								    sizeof(struct btf_header));
+
+	meta_left = btf->raw_size - hdr_len;
+	if (meta_left < (long long)btf->hdr->str_off + btf->hdr->str_len) {
 		pr_debug("Invalid BTF total size: %u\n", btf->raw_size);
 		return -EINVAL;
 	}
 
-	if ((long long)hdr->type_off + hdr->type_len > hdr->str_off) {
+	if ((long long)btf->hdr->type_off + btf->hdr->type_len > btf->hdr->str_off) {
 		pr_debug("Invalid BTF data sections layout: type data at %u + %u, strings data at %u + %u\n",
-			 hdr->type_off, hdr->type_len, hdr->str_off, hdr->str_len);
+			 btf->hdr->type_off, btf->hdr->type_len, btf->hdr->str_off,
+			 btf->hdr->str_len);
 		return -EINVAL;
 	}
 
-	if (hdr->type_off % 4) {
+	if (btf->hdr->type_off % 4) {
 		pr_debug("BTF type section is not aligned to 4 bytes\n");
 		return -EINVAL;
 	}
@@ -285,6 +324,32 @@ static int btf_parse_str_sec(struct btf *btf)
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
+	if (!hdr->kind_layout_off || !hdr->kind_layout_len)
+		return 0;
+
+	if (hdr->kind_layout_len % sizeof(struct btf_kind_layout) != 0) {
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
@@ -944,7 +1009,8 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 
 static bool btf_is_modifiable(const struct btf *btf)
 {
-	return (void *)btf->hdr != btf->raw_data;
+	/* BTF is modifiable if split into multiple sections */
+	return btf->modifiable;
 }
 
 void btf__free(struct btf *btf)
@@ -961,12 +1027,16 @@ void btf__free(struct btf *btf)
 		 * sections, so we need to free all of them individually. It
 		 * might still have a cached contiguous raw data present,
 		 * which will be unconditionally freed below.
+		 *
+		 * Optional kind layout information may be present too.
 		 */
-		free(btf->hdr);
 		free(btf->types_data);
 		strset__free(btf->strs_set);
+		free(btf->kind_layout);
 	}
 	free(btf->raw_data);
+	if (btf->hdr != btf->raw_data)
+		free(btf->hdr);
 	free(btf->raw_data_swapped);
 	free(btf->type_offs);
 	free(btf);
@@ -974,6 +1044,7 @@ void btf__free(struct btf *btf)
 
 static struct btf *btf_new_empty(struct btf *base_btf)
 {
+	struct btf_header *hdr;
 	struct btf *btf;
 
 	btf = calloc(1, sizeof(*btf));
@@ -1001,14 +1072,20 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	btf->hdr = btf->raw_data;
-	btf->hdr->hdr_len = sizeof(struct btf_header);
-	btf->hdr->magic = BTF_MAGIC;
-	btf->hdr->version = BTF_VERSION;
+	hdr = btf->raw_data;
+	hdr->hdr_len = sizeof(struct btf_header);
+	hdr->magic = BTF_MAGIC;
+	hdr->version = BTF_VERSION;
 
-	btf->types_data = btf->raw_data + btf->hdr->hdr_len;
-	btf->strs_data = btf->raw_data + btf->hdr->hdr_len;
-	btf->hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
+	btf->types_data = btf->raw_data + hdr->hdr_len;
+	btf->strs_data = btf->raw_data + hdr->hdr_len;
+	hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
+	btf->hdr = calloc(1, sizeof(struct btf_header));
+	if (!btf->hdr) {
+		free(btf);
+		return ERR_PTR(-ENOMEM);
+	}
+	memcpy(btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
 }
@@ -1051,7 +1128,6 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	memcpy(btf->raw_data, data, size);
 	btf->raw_size = size;
 
-	btf->hdr = btf->raw_data;
 	err = btf_parse_hdr(btf);
 	if (err)
 		goto done;
@@ -1060,6 +1136,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	btf->types_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->type_off;
 
 	err = btf_parse_str_sec(btf);
+	err = err ?: btf_parse_kind_layout_sec(btf);
 	err = err ?: btf_parse_type_sec(btf);
 	err = err ?: btf_sanity_check(btf);
 	if (err)
@@ -1427,6 +1504,11 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
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
@@ -1434,7 +1516,7 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 
 	memcpy(p, hdr, hdr->hdr_len);
 	if (swap_endian)
-		btf_bswap_hdr(p);
+		btf_bswap_hdr(p, hdr->hdr_len);
 	p += hdr->hdr_len;
 
 	memcpy(p, btf->types_data, hdr->type_len);
@@ -1453,7 +1535,13 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	p += hdr->type_len;
 
 	memcpy(p, btf_strs_data(btf), hdr->str_len);
-	p += hdr->str_len;
+
+	if (btf->kind_layout) {
+		p = data + hdr->hdr_len + hdr->kind_layout_off;
+		memcpy(p, btf->kind_layout, hdr->kind_layout_len);
+		if (swap_endian)
+			btf_bswap_kind_layout_sec(p, hdr->kind_layout_len);
+	}
 
 	*size = data_sz;
 	return data;
@@ -1585,13 +1673,13 @@ static void btf_invalidate_raw_data(struct btf *btf)
 	}
 }
 
-/* Ensure BTF is ready to be modified (by splitting into a three memory
- * regions for header, types, and strings). Also invalidate cached
- * raw_data, if any.
+/* Ensure BTF is ready to be modified (by splitting into memory regions
+ * for types and strings, with kind layout section if needed (btf->hdr
+ * is already a separate region).  Also invalidate cached raw_data, if any.
  */
 static int btf_ensure_modifiable(struct btf *btf)
 {
-	void *hdr, *types;
+	void *types, *kind_layout = NULL;
 	struct strset *set = NULL;
 	int err = -ENOMEM;
 
@@ -1601,15 +1689,20 @@ static int btf_ensure_modifiable(struct btf *btf)
 		return 0;
 	}
 
-	/* split raw data into three memory regions */
-	hdr = malloc(btf->hdr->hdr_len);
+	/* split raw data into memory regions; btf->hdr is done already. */
 	types = malloc(btf->hdr->type_len);
-	if (!hdr || !types)
+	if (!types)
 		goto err_out;
-
-	memcpy(hdr, btf->hdr, btf->hdr->hdr_len);
 	memcpy(types, btf->types_data, btf->hdr->type_len);
 
+	if (btf->hdr->kind_layout_len && btf->hdr->kind_layout_off) {
+		kind_layout = malloc(btf->hdr->kind_layout_len);
+		if (!kind_layout)
+			goto err_out;
+		memcpy(kind_layout, btf->raw_data + btf->hdr->hdr_len + btf->hdr->kind_layout_off,
+		       btf->hdr->kind_layout_len);
+	}
+
 	/* build lookup index for all strings */
 	set = strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr->str_len);
 	if (IS_ERR(set)) {
@@ -1618,11 +1711,12 @@ static int btf_ensure_modifiable(struct btf *btf)
 	}
 
 	/* only when everything was successful, update internal state */
-	btf->hdr = hdr;
 	btf->types_data = types;
 	btf->types_data_cap = btf->hdr->type_len;
 	btf->strs_data = NULL;
 	btf->strs_set = set;
+	if (kind_layout)
+		btf->kind_layout = kind_layout;
 	/* if BTF was created from scratch, all strings are guaranteed to be
 	 * unique and deduplicated
 	 */
@@ -1634,12 +1728,14 @@ static int btf_ensure_modifiable(struct btf *btf)
 	/* invalidate raw_data representation */
 	btf_invalidate_raw_data(btf);
 
+	btf->modifiable = true;
+
 	return 0;
 
 err_out:
 	strset__free(set);
-	free(hdr);
 	free(types);
+	free(kind_layout);
 	return err;
 }
 
-- 
2.31.1


