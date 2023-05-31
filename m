Return-Path: <bpf+bounces-1540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C21718B03
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF062815D7
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C673C0BC;
	Wed, 31 May 2023 20:21:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB334CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:21:33 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595B210F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:31 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJdLCB023290;
	Wed, 31 May 2023 20:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=FCr74+Ee35aH+w4HAX8moS1a9f6ti5Ewo8PizQLylvg=;
 b=DmYBsyWlQmsl22+dcjEHxB5QyOlE85V4k3kRY64Q45Ju+FCOWTB9ZOQJyKvvUK74u0BP
 Joi4au6KRecJ2sxbKqiaksIHuHdivw2PgC3fZXHYh0VCo0M8/2lgpq8apJYF1xwSRIMB
 t7MD15vf52R1rsKhzA7qdzU++uESpku4EdqUuwPE47QfsBDVn6E8gYdeM5XEadgRY9gO
 gjXNL9QBbm3rzPYnD1UVfagufRlW2R9urle0mVs9gBL5CbkW4lm9r9Gl98um2Q7j7PNl
 aTuLjd+8qNufDsh5xH8rsvqv2tYuffUBi9vH1U4Z8EMeFVA1+ioBk72Jggsx1XZF0N52 gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9y2ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJkL0s019748;
	Wed, 31 May 2023 20:20:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6djkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaEP000653;
	Wed, 31 May 2023 20:20:44 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-3;
	Wed, 31 May 2023 20:20:44 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 2/8] libbpf: support handling of metadata section in BTF
Date: Wed, 31 May 2023 21:19:29 +0100
Message-Id: <20230531201936.1992188-3-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 1AxV1jeHJeo9lpZrL4A4tMqwD0UDamAH
X-Proofpoint-ORIG-GUID: 1AxV1jeHJeo9lpZrL4A4tMqwD0UDamAH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

support reading in metadata, fixing endian issues on reading;
also support writing metadata section to raw BTF object.
There is not yet an API to populate the metadata with meaningful
information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 141 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 30 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8484b563b53d..036dc1505969 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/btf.h>
 #include <gelf.h>
+#include <zlib.h>
 #include "btf.h"
 #include "bpf.h"
 #include "libbpf.h"
@@ -39,36 +40,40 @@ struct btf {
 
 	/*
 	 * When BTF is loaded from an ELF or raw memory it is stored
-	 * in a contiguous memory block. The hdr, type_data, and, strs_data
-	 * point inside that memory region to their respective parts of BTF
-	 * representation:
+	 * in a contiguous memory block. The hdr, type_data, strs_data,
+	 * and optional meta_data point inside that memory region to their
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
+	 * +--------------------------------+----------+
+	 * |  Header  |  Types  |  Strings  | Metadata |
+	 * +--------------------------------+----------+
+	 * ^          ^         ^           ^
+	 * |          |         |           |
+	 * hdr        |         |           |
+	 * types_data-+         |           |
+	 * strs_data------------+           |
+	 * meta_data------------------------+
+	 *
+	 * meta_data is optional.
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
+	 * and (again optionally) metadata:
 	 *
-	 * +----------+  +---------+  +-----------+
-	 * |  Header  |  |  Types  |  |  Strings  |
-	 * +----------+  +---------+  +-----------+
-	 * ^             ^            ^
-	 * |             |            |
-	 * hdr           |            |
-	 * types_data----+            |
-	 * strset__data(strs_set)-----+
+	 * +----------+  +---------+  +-----------+  +----------+
+	 * |  Header  |  |  Types  |  |  Strings  |  | Metadata |
+	 * +----------+  +---------+  +-----------+  +---------_+
+	 * ^             ^            ^              ^
+	 * |             |            |              |
+	 * hdr           |            |              |
+	 * types_data----+            |              |
+	 * strset__data(strs_set)-----+              |
+	 * meta_data---------------------------------+
 	 *
 	 *               +----------+---------+-----------+
 	 *               |  Header  |  Types  |  Strings  |
@@ -116,6 +121,8 @@ struct btf {
 	/* whether strings are already deduplicated */
 	bool strs_deduped;
 
+	void *meta_data;
+
 	/* BTF object FD, if loaded into kernel */
 	int fd;
 
@@ -215,6 +222,11 @@ static void btf_bswap_hdr(struct btf_header *h)
 	h->type_len = bswap_32(h->type_len);
 	h->str_off = bswap_32(h->str_off);
 	h->str_len = bswap_32(h->str_len);
+	if (h->hdr_len >= sizeof(struct btf_header)) {
+		h->meta_header.meta_off = bswap_32(h->meta_header.meta_off);
+		h->meta_header.meta_len = bswap_32(h->meta_header.meta_len);
+	}
+
 }
 
 static int btf_parse_hdr(struct btf *btf)
@@ -222,14 +234,17 @@ static int btf_parse_hdr(struct btf *btf)
 	struct btf_header *hdr = btf->hdr;
 	__u32 meta_left;
 
-	if (btf->raw_size < sizeof(struct btf_header)) {
+	if (btf->raw_size < sizeof(struct btf_header) - sizeof(struct btf_meta_header)) {
 		pr_debug("BTF header not found\n");
 		return -EINVAL;
 	}
 
 	if (hdr->magic == bswap_16(BTF_MAGIC)) {
+		int swapped_len = bswap_32(hdr->hdr_len);
+
 		btf->swapped_endian = true;
-		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
+		if (swapped_len != sizeof(struct btf_header) &&
+		    swapped_len != sizeof(struct btf_header) - sizeof(struct btf_meta_header)) {
 			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
 				bswap_32(hdr->hdr_len));
 			return -ENOTSUP;
@@ -285,6 +300,42 @@ static int btf_parse_str_sec(struct btf *btf)
 	return 0;
 }
 
+static void btf_bswap_meta(struct btf_metadata *meta, int len)
+{
+	struct btf_kind_meta *m = &meta->kind_meta[0];
+	struct btf_kind_meta *end = (void *)meta + len;
+
+	meta->flags = bswap_32(meta->flags);
+	meta->crc = bswap_32(meta->crc);
+	meta->base_crc = bswap_32(meta->base_crc);
+	meta->description_off = bswap_32(meta->description_off);
+
+	while (m < end) {
+		m->name_off = bswap_32(m->name_off);
+		m->flags = bswap_16(m->flags);
+		m++;
+	}
+}
+
+static int btf_parse_meta_sec(struct btf *btf)
+{
+	const struct btf_header *hdr = btf->hdr;
+
+	if (hdr->hdr_len < sizeof(struct btf_header) ||
+	    !hdr->meta_header.meta_off || !hdr->meta_header.meta_len)
+		return 0;
+	if (hdr->meta_header.meta_len < sizeof(struct btf_metadata)) {
+		pr_debug("Invalid BTF metadata section\n");
+		return -EINVAL;
+	}
+	btf->meta_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->meta_header.meta_off;
+
+	if (btf->swapped_endian)
+		btf_bswap_meta(btf->meta_data, hdr->meta_header.meta_len);
+
+	return 0;
+}
+
 static int btf_type_size(const struct btf_type *t)
 {
 	const int base_size = sizeof(struct btf_type);
@@ -904,6 +955,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	err = err ?: btf_parse_type_sec(btf);
 	if (err)
 		goto done;
+	err = btf_parse_meta_sec(btf);
 
 done:
 	if (err) {
@@ -1267,6 +1319,11 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	}
 
 	data_sz = hdr->hdr_len + hdr->type_len + hdr->str_len;
+	if (btf->meta_data) {
+		data_sz = roundup(data_sz, 8);
+		data_sz += hdr->meta_header.meta_len;
+		hdr->meta_header.meta_off = roundup(hdr->type_len + hdr->str_len, 8);
+	}
 	data = calloc(1, data_sz);
 	if (!data)
 		return NULL;
@@ -1293,8 +1350,21 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	p += hdr->type_len;
 
 	memcpy(p, btf_strs_data(btf), hdr->str_len);
-	p += hdr->str_len;
+	/* round up to 8 byte alignment to match offset above */
+	p = data + hdr->hdr_len + roundup(hdr->type_len + hdr->str_len, 8);
+
+	if (btf->meta_data) {
+		struct btf_metadata *meta = p;
 
+		memcpy(p, btf->meta_data, hdr->meta_header.meta_len);
+		if (!swap_endian) {
+			meta->crc = crc32(0L, (const Bytef *)&data, sizeof(data));
+			meta->flags |= BTF_META_CRC_SET;
+		}
+		if (swap_endian)
+			btf_bswap_meta(p, hdr->meta_header.meta_len);
+		p += hdr->meta_header.meta_len;
+	}
 	*size = data_sz;
 	return data;
 err_out:
@@ -1425,13 +1495,13 @@ static void btf_invalidate_raw_data(struct btf *btf)
 	}
 }
 
-/* Ensure BTF is ready to be modified (by splitting into a three memory
- * regions for header, types, and strings). Also invalidate cached
- * raw_data, if any.
+/* Ensure BTF is ready to be modified (by splitting into a three or four memory
+ * regions for header, types, strings and optional metadata). Also invalidate
+ * cached raw_data, if any.
  */
 static int btf_ensure_modifiable(struct btf *btf)
 {
-	void *hdr, *types;
+	void *hdr, *types, *meta = NULL;
 	struct strset *set = NULL;
 	int err = -ENOMEM;
 
@@ -1446,9 +1516,17 @@ static int btf_ensure_modifiable(struct btf *btf)
 	types = malloc(btf->hdr->type_len);
 	if (!hdr || !types)
 		goto err_out;
+	if (btf->hdr->hdr_len >= sizeof(struct btf_header)  &&
+	    btf->hdr->meta_header.meta_off && btf->hdr->meta_header.meta_len) {
+		meta = calloc(1, btf->hdr->meta_header.meta_len);
+		if (!meta)
+			goto err_out;
+	}
 
 	memcpy(hdr, btf->hdr, btf->hdr->hdr_len);
 	memcpy(types, btf->types_data, btf->hdr->type_len);
+	if (meta)
+		memcpy(meta, btf->meta_data, btf->hdr->meta_header.meta_len);
 
 	/* build lookup index for all strings */
 	set = strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr->str_len);
@@ -1463,6 +1541,8 @@ static int btf_ensure_modifiable(struct btf *btf)
 	btf->types_data_cap = btf->hdr->type_len;
 	btf->strs_data = NULL;
 	btf->strs_set = set;
+	btf->meta_data = meta;
+
 	/* if BTF was created from scratch, all strings are guaranteed to be
 	 * unique and deduplicated
 	 */
@@ -1480,6 +1560,7 @@ static int btf_ensure_modifiable(struct btf *btf)
 	strset__free(set);
 	free(hdr);
 	free(types);
+	free(meta);
 	return err;
 }
 
-- 
2.31.1


