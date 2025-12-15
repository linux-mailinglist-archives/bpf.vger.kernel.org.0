Return-Path: <bpf+bounces-76593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21BCBD27D
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D45303B192
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F93242AD;
	Mon, 15 Dec 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RRqlUVoV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56E327BE7;
	Mon, 15 Dec 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790344; cv=none; b=c0vlNYV9QS69mDPGavRibhsXhtvcY2JvLBi+fQ+vaRJPLOrMO7sX/uKe9K4zr/z0p1L9dbv/BiBVuw3JQA9e8wiT+OWd+cWG7eGKm3IgqAucdJTKR2jmUruKgqdpauwF2eLKHESlCW/n0rJQJKtR/2ccPeuD1x7wPIL6lp6cMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790344; c=relaxed/simple;
	bh=YuXDBfvyDg1BeNiHamNNUcuSZRcJEV+DmFKIL9QVV1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liyflhF1jwLT2WNudDPdRIzyobULdhKytnyQsWW8VoL3Q2SvTcOWJ5X2Dliq5zs4SwheOwSi7lie5yof5+jSGKSyNYzZXS5gep/c0LCcNegHGu9/pt+g/5W4a++dC75M3PQ+xtbDGIAKs3/KdQFCP++ziS900EG/yt50WEpxIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RRqlUVoV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uKs31583325;
	Mon, 15 Dec 2025 09:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=iD0Uq
	+xDQD4+grn4SyssG3z/TmFUyFBFeMAJ62mkpUo=; b=RRqlUVoV3HWg96+nQX0zi
	aXYiIve9mxlJoQ5j7HbvmziqwigVr/tt0dISqnLFIdTK7Mv7o6gFJHb0/tPCRPAG
	DnZhri5jnx0DoAK2Uv0A+o2Sj1EBkDOfFGEveJlayo+7VdviuyG8RJgZndo85Bmv
	homC1MsX/JePLvNYzrW3byJP8PyRbtgyPqkA4aGSn7Zwt4ahW05MBmDIlumSG5Wl
	vgNOKTl5+f+qW6VpIG6kKS0F+fEPyqyKmluniQqpLgecssvCp1drgdDvLa+2P6y9
	JgzmkJSr2NKxjA/iNODhTPGwtUjK0iSkPwdv8s/Ol7Uv8OQYi+11Is/sBNMh6Nek
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xqxsr0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF9H7dB025232;
	Mon, 15 Dec 2025 09:18:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8ygnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BF9HdwU027566;
	Mon, 15 Dec 2025 09:18:12 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-2.vpn.oracle.com [10.154.53.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk8yg99-3;
	Mon, 15 Dec 2025 09:18:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section handling in BTF
Date: Mon, 15 Dec 2025 09:17:22 +0000
Message-ID: <20251215091730.1188790-3-alan.maguire@oracle.com>
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
 definitions=main-2512150078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA3OCBTYWx0ZWRfXxen9MO4rJIop
 1Fe+oJqfS68HilA8bRx9N4DkcBHM7qwOob70c5j6gXqG1UvNVhpDBtt1Oeg0yBFxznS1GCPJOwi
 IIsjzgZwXl9D9EZ9RCAwSKeBt9kiMDOf1b3IrHye4b7yaPUb2sPEU9aDsZ/i+vEhwFrfflnHzFF
 kO5te+1FOXpMiOAUweGJWuXV1IE+xwK8qpP63sxjL/tnskvRs/eEKBVG33f1UeUFy8enjrdHVDJ
 uqK9x2CXax/dfHTPU08pz8PayreGbMGpw4QIyP2qvCqT0Jn00bf/pLRl1UFI1hjKnls5bbCPU7V
 qoXJczqNLPlPm4Uyve+PUZt0YNcgEvuzz9mYj8jzSQvs8e+czt0XZSn2NGYZrmsvrU7wSpwBwHV
 d1Xzt/qV1f11WlObWpW7ZdXBw6h2OQ==
X-Proofpoint-GUID: wSXKheXJ4986OJUhXWK0YjYvg3y8z2PM
X-Proofpoint-ORIG-GUID: wSXKheXJ4986OJUhXWK0YjYvg3y8z2PM
X-Authority-Analysis: v=2.4 cv=BYDVE7t2 c=1 sm=1 tr=0 ts=693fd257 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=WK6A99va1KDLO6KbJhgA:9

Support reading in kind layout fixing endian issues on reading;
also support writing kind layout section to raw BTF object.
There is not yet an API to populate the kind layout with meaningful
information.

As part of this, we need to consider multiple valid BTF header
sizes; the original or the kind layout-extended headers.
So to support this, the "struct btf" representation is modified
to always allocate a "struct btf_header" and copy the valid
portion from the raw data to it; this means we can always safely
check fields like btf->hdr->kind_layout_len.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 260 +++++++++++++++++++++++++++++++-------------
 1 file changed, 183 insertions(+), 77 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b136572e889a..8835aee6ee84 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -40,42 +40,53 @@ struct btf {
 
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
+	 * the extended header with kind layout, etc.
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
@@ -123,6 +134,13 @@ struct btf {
 	/* whether raw_data is a (read-only) mmap */
 	bool raw_data_is_mmap;
 
+	/* is BTF modifiable? i.e. is it split into separate sections as described above? */
+	bool modifiable;
+	/* Points either at raw kind layout data in parsed BTF (if present), or
+	 * at an allocated kind layout array when BTF is modifiable.
+	 */
+	void *kind_layout;
+
 	/* BTF object FD, if loaded into kernel */
 	int fd;
 
@@ -214,7 +232,7 @@ static int btf_add_type_idx_entry(struct btf *btf, __u32 type_off)
 	return 0;
 }
 
-static void btf_bswap_hdr(struct btf_header *h)
+static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
 {
 	h->magic = bswap_16(h->magic);
 	h->hdr_len = bswap_32(h->hdr_len);
@@ -222,54 +240,87 @@ static void btf_bswap_hdr(struct btf_header *h)
 	h->type_len = bswap_32(h->type_len);
 	h->str_off = bswap_32(h->str_off);
 	h->str_len = bswap_32(h->str_len);
+	/* May be operating on raw data with hdr_len that does not include below fields */
+	if (hdr_len >= sizeof(struct btf_header)) {
+		h->kind_layout_off = bswap_32(h->kind_layout_off);
+		h->kind_layout_len = bswap_32(h->kind_layout_len);
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
+		btf_bswap_hdr(hdr, hdr_len);
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
+	memcpy(btf->hdr, hdr, min((size_t)hdr_len, sizeof(struct btf_header)));
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
 
+	if (btf->hdr->kind_layout_len == 0)
+		return 0;
+
+	if (btf->hdr->kind_layout_off % 4) {
+		pr_debug("BTF kind_layout section is not aligned to 4 bytes\n");
+		return -EINVAL;
+	}
+	if (btf->hdr->kind_layout_off < btf->hdr->str_off + btf->hdr->str_len) {
+		pr_debug("Invalid BTF data sections layout: strings data at %u + %u, kind layout data at %u + %u\n",
+			 btf->hdr->str_off, btf->hdr->str_len,
+			 btf->hdr->kind_layout_off, btf->hdr->kind_layout_len);
+		return -EINVAL;
+	}
+	if (btf->hdr->kind_layout_off + btf->hdr->kind_layout_len > meta_left) {
+		pr_debug("Invalid BTF total size: %u\n", btf->raw_size);
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -292,6 +343,22 @@ static int btf_parse_str_sec(struct btf *btf)
 	return 0;
 }
 
+static int btf_parse_kind_layout_sec(struct btf *btf)
+{
+	const struct btf_header *hdr = btf->hdr;
+
+	if (!hdr->kind_layout_len)
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
@@ -951,7 +1018,8 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 
 static bool btf_is_modifiable(const struct btf *btf)
 {
-	return (void *)btf->hdr != btf->raw_data;
+	/* BTF is modifiable if split into multiple sections */
+	return btf->modifiable;
 }
 
 static void btf_free_raw_data(struct btf *btf)
@@ -980,10 +1048,11 @@ void btf__free(struct btf *btf)
 		 * might still have a cached contiguous raw data present,
 		 * which will be unconditionally freed below.
 		 */
-		free(btf->hdr);
 		free(btf->types_data);
 		strset__free(btf->strs_set);
+		free(btf->kind_layout);
 	}
+	free(btf->hdr);
 	btf_free_raw_data(btf);
 	free(btf->raw_data_swapped);
 	free(btf->type_offs);
@@ -994,6 +1063,7 @@ void btf__free(struct btf *btf)
 
 static struct btf *btf_new_empty(struct btf *base_btf)
 {
+	struct btf_header *hdr;
 	struct btf *btf;
 
 	btf = calloc(1, sizeof(*btf));
@@ -1022,14 +1092,21 @@ static struct btf *btf_new_empty(struct btf *base_btf)
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
+		free(btf->raw_data);
+		free(btf);
+		return ERR_PTR(-ENOMEM);
+	}
+	memcpy(btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
 }
@@ -1078,7 +1155,6 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 
 	btf->raw_size = size;
 
-	btf->hdr = btf->raw_data;
 	err = btf_parse_hdr(btf);
 	if (err)
 		goto done;
@@ -1087,6 +1163,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	btf->types_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->type_off;
 
 	err = btf_parse_str_sec(btf);
+	err = err ?: btf_parse_kind_layout_sec(btf);
 	err = err ?: btf_parse_type_sec(btf);
 	err = err ?: btf_sanity_check(btf);
 	if (err)
@@ -1550,6 +1627,10 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	}
 
 	data_sz = hdr->hdr_len + hdr->type_len + hdr->str_len;
+	if (btf->kind_layout) {
+		data_sz = roundup(data_sz, 4);
+		data_sz += hdr->kind_layout_len;
+	}
 	data = calloc(1, data_sz);
 	if (!data)
 		return NULL;
@@ -1557,7 +1638,7 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 
 	memcpy(p, hdr, hdr->hdr_len);
 	if (swap_endian)
-		btf_bswap_hdr(p);
+		btf_bswap_hdr(p, hdr->hdr_len);
 	p += hdr->hdr_len;
 
 	memcpy(p, btf->types_data, hdr->type_len);
@@ -1576,7 +1657,11 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	p += hdr->type_len;
 
 	memcpy(p, btf_strs_data(btf), hdr->str_len);
-	p += hdr->str_len;
+
+	if (btf->kind_layout) {
+		p = data + hdr->hdr_len + hdr->kind_layout_off;
+		memcpy(p, btf->kind_layout, hdr->kind_layout_len);
+	}
 
 	*size = data_sz;
 	return data;
@@ -1717,13 +1802,13 @@ static void btf_invalidate_raw_data(struct btf *btf)
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
 
@@ -1733,15 +1818,20 @@ static int btf_ensure_modifiable(struct btf *btf)
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
 
+	if (btf->hdr->kind_layout_len) {
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
@@ -1750,11 +1840,12 @@ static int btf_ensure_modifiable(struct btf *btf)
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
@@ -1766,12 +1857,14 @@ static int btf_ensure_modifiable(struct btf *btf)
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
 
@@ -1840,6 +1933,21 @@ static void btf_type_inc_vlen(struct btf_type *t)
 	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, btf_kflag(t));
 }
 
+static void btf_hdr_update_type_len(struct btf *btf, int new_len)
+{
+	btf->hdr->type_len = new_len;
+	btf->hdr->str_off = new_len;
+	if (btf->kind_layout)
+		btf->hdr->kind_layout_off = btf->hdr->type_len + roundup(btf->hdr->str_len, 4);
+}
+
+static void btf_hdr_update_str_len(struct btf *btf, int new_len)
+{
+	btf->hdr->str_len = new_len;
+	if (btf->kind_layout)
+		btf->hdr->kind_layout_off = btf->hdr->type_len + roundup(new_len, 4);
+}
+
 static int btf_commit_type(struct btf *btf, int data_sz)
 {
 	int err;
@@ -1848,8 +1956,7 @@ static int btf_commit_type(struct btf *btf, int data_sz)
 	if (err)
 		return libbpf_err(err);
 
-	btf->hdr->type_len += data_sz;
-	btf->hdr->str_off += data_sz;
+	btf_hdr_update_type_len(btf, btf->hdr->type_len + data_sz);
 	btf->nr_types++;
 	return btf->start_id + btf->nr_types - 1;
 }
@@ -2029,8 +2136,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	 * update type count and various internal offsets and sizes to
 	 * "commit" the changes and made them visible to the outside world.
 	 */
-	btf->hdr->type_len += data_sz;
-	btf->hdr->str_off += data_sz;
+	btf_hdr_update_type_len(btf, btf->hdr->type_len + data_sz);
 	btf->nr_types += cnt;
 
 	hashmap__free(p.str_off_map);
@@ -2047,7 +2153,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	/* and now restore original strings section size; types data size
 	 * wasn't modified, so doesn't need restoring, see big comment above
 	 */
-	btf->hdr->str_len = old_strs_len;
+	btf_hdr_update_str_len(btf, old_strs_len);
 
 	hashmap__free(p.str_off_map);
 
@@ -2365,8 +2471,7 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
 	/* update parent type's vlen and kflag */
 	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, is_bitfield || btf_kflag(t));
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr->type_len + sz);
 	return 0;
 }
 
@@ -2475,8 +2580,7 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
 	if (value < 0)
 		t->info = btf_type_info(btf_kind(t), btf_vlen(t), true);
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr->type_len + sz);
 	return 0;
 }
 
@@ -2547,8 +2651,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
 	t = btf_last_type(btf);
 	btf_type_inc_vlen(t);
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr->type_len + sz);
 	return 0;
 }
 
@@ -2786,8 +2889,7 @@ int btf__add_func_param(struct btf *btf, const char *name, int type_id)
 	t = btf_last_type(btf);
 	btf_type_inc_vlen(t);
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr->type_len + sz);
 	return 0;
 }
 
@@ -2923,8 +3025,7 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
 	t = btf_last_type(btf);
 	btf_type_inc_vlen(t);
 
-	btf->hdr->type_len += sz;
-	btf->hdr->str_off += sz;
+	btf_hdr_update_type_len(btf, btf->hdr->type_len + sz);
 	return 0;
 }
 
@@ -3888,7 +3989,7 @@ static int btf_dedup_strings(struct btf_dedup *d)
 
 	/* replace BTF string data and hash with deduped ones */
 	strset__free(d->btf->strs_set);
-	d->btf->hdr->str_len = strset__data_size(d->strs_set);
+	btf_hdr_update_str_len(d->btf, strset__data_size(d->strs_set));
 	d->btf->strs_set = d->strs_set;
 	d->strs_set = NULL;
 	d->btf->strs_deduped = true;
@@ -5343,6 +5444,11 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 	d->btf->type_offs = new_offs;
 	d->btf->hdr->str_off = d->btf->hdr->type_len;
 	d->btf->raw_size = d->btf->hdr->hdr_len + d->btf->hdr->type_len + d->btf->hdr->str_len;
+	if (d->btf->kind_layout) {
+		d->btf->hdr->kind_layout_off = d->btf->hdr->str_off + roundup(d->btf->hdr->str_len,
+									      4);
+		d->btf->raw_size = roundup(d->btf->raw_size, 4) + d->btf->hdr->kind_layout_len;
+	}
 	return 0;
 }
 
-- 
2.39.3


