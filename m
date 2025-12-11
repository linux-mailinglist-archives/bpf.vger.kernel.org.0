Return-Path: <bpf+bounces-76475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0620CB68F4
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48C0302AB90
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD5313294;
	Thu, 11 Dec 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r0TQx3yw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD972F60A4;
	Thu, 11 Dec 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471644; cv=none; b=hgJwgKxt2abn65e+RK+bOAjVyw/jTqx7PjEpuxM13rZ+P/0d80/ntnkmXytM2KW+oQvmr7F9XSJKGXiKx0OMX1wlbcpi0qtGjwBNDz4UiJ1jt/1IlNFYyT8lkWW7GevBl0IB9nHjBiNh3Y8shGFfzlqMfIJoJn+vToyiwaCjM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471644; c=relaxed/simple;
	bh=m1IEn25sM4gu+NXNwvR0opRKZQ/qU7kQNJcJnZT2ZtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f06YikdpYV4bJ/Mkm6XwKeFWnP8PYlDFBj/3qxYgcb0R191C21IMqRH/zE7Iyg4JLBcESFwXRkjn5BvrWvUnm7WQcfGxiYA1ZKrFWsQ73O/Q82mp9OFuNRVVZohOpMGwadk7GSddU/ezyWgPXwkl4P2skffJ68gDnXjl7TE7KQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r0TQx3yw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBG57uN1654736;
	Thu, 11 Dec 2025 16:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=/LDE/
	aSghLdb3LPhfe+IFqTaaMQ0wReUjn5g3qKcwk4=; b=r0TQx3ywJIdhBndL9KoT9
	BxVgkXwOOpAMjQRlRQqB0lvaVR/VPrK591fcZ61YJrk3xmhgP7K3Qa5G78brNJzR
	ADGdWM0BFV1bcmm3K83k+Smw6u72OxnqLSyLRH77qa7vo54qdXXqZKBRIiV7yJWQ
	JCf9ket/wFwl4jx8g4TUeVPCYAgOrNXPC/1VGvDJ/YhPzCu8zfV1JyzvzD/xj9r4
	yAI8t+rX9R9Hq1WgewCETFNxnidkMECcJLI/oynuHabuBjhiWgwUbWeZehXAil5t
	Cb212d42EX0yhf3iFM9eKjS1TRlFAmGFI4BKEUsXK2kcJjNFe+d+JpDkBVbfeLI/
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayc9q1vu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:46:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBGUDIs039919;
	Thu, 11 Dec 2025 16:46:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnswu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:46:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BBGknmB030704;
	Thu, 11 Dec 2025 16:46:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-126.vpn.oracle.com [10.154.50.126])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxnswqy-3;
	Thu, 11 Dec 2025 16:46:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 02/10] libbpf: Support kind layout section handling in BTF
Date: Thu, 11 Dec 2025 16:46:38 +0000
Message-ID: <20251211164646.1219122-3-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: EIIEpWXIsaVndPzcFQ4tpvt9q-68jTUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNCBTYWx0ZWRfXx5l7SfAYi4K3
 60lMT5cDe8U8Y53eOjDnbPQkZh5uuhklnZhI0aTrfsLnB+cy7Qak33TJaf735VatcYAcalHwagI
 LZkkdIFi25quN9u+DizbnJltcEvacGKLn892pWnHL8owb+fLid8JManIjUEHvEZy3SJXE1nbGhu
 JKhUopJMKQX4kLHneqWYEz2wo+2QlMAQUnneArvw2hjYKvSMMbkran29u9/tS9Ae3pPcmDwrrxZ
 tgutmeLaWyfXZvkuBM3BxkWDF861S70rYRoyshn17FZoV5bSq0oAvvyf0yVYk7mz2OrG1lirQCM
 3on8dkqQNNl17dUoY+lVLzCvimWbTvzGiZDxapRV9FqIUGazdRYLeywiTonxODgxxi+5vM4NXVX
 E+yRN24kdk8RVJvQkCjU0yL7Rn2baVTIdKw6isX0ZwZ5XDXfwCQ=
X-Proofpoint-ORIG-GUID: EIIEpWXIsaVndPzcFQ4tpvt9q-68jTUm
X-Authority-Analysis: v=2.4 cv=SYn6t/Ru c=1 sm=1 tr=0 ts=693af580 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=RZZDsM_iJmhuNMX49CkA:9 cc=ntf awl=host:12110

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
 tools/lib/bpf/btf.c | 218 +++++++++++++++++++++++++++++++-------------
 1 file changed, 157 insertions(+), 61 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b136572e889a..531089a64adc 100644
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
@@ -222,54 +240,89 @@ static void btf_bswap_hdr(struct btf_header *h)
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
 
@@ -292,6 +345,22 @@ static int btf_parse_str_sec(struct btf *btf)
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
@@ -951,7 +1020,8 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 
 static bool btf_is_modifiable(const struct btf *btf)
 {
-	return (void *)btf->hdr != btf->raw_data;
+	/* BTF is modifiable if split into multiple sections */
+	return btf->modifiable;
 }
 
 static void btf_free_raw_data(struct btf *btf)
@@ -980,10 +1050,11 @@ void btf__free(struct btf *btf)
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
@@ -994,6 +1065,7 @@ void btf__free(struct btf *btf)
 
 static struct btf *btf_new_empty(struct btf *base_btf)
 {
+	struct btf_header *hdr;
 	struct btf *btf;
 
 	btf = calloc(1, sizeof(*btf));
@@ -1022,14 +1094,21 @@ static struct btf *btf_new_empty(struct btf *base_btf)
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
@@ -1078,7 +1157,6 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 
 	btf->raw_size = size;
 
-	btf->hdr = btf->raw_data;
 	err = btf_parse_hdr(btf);
 	if (err)
 		goto done;
@@ -1087,6 +1165,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	btf->types_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->type_off;
 
 	err = btf_parse_str_sec(btf);
+	err = err ?: btf_parse_kind_layout_sec(btf);
 	err = err ?: btf_parse_type_sec(btf);
 	err = err ?: btf_sanity_check(btf);
 	if (err)
@@ -1550,6 +1629,11 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
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
@@ -1557,7 +1641,7 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 
 	memcpy(p, hdr, hdr->hdr_len);
 	if (swap_endian)
-		btf_bswap_hdr(p);
+		btf_bswap_hdr(p, hdr->hdr_len);
 	p += hdr->hdr_len;
 
 	memcpy(p, btf->types_data, hdr->type_len);
@@ -1576,7 +1660,11 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
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
@@ -1717,13 +1805,13 @@ static void btf_invalidate_raw_data(struct btf *btf)
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
 
@@ -1733,15 +1821,20 @@ static int btf_ensure_modifiable(struct btf *btf)
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
@@ -1750,11 +1843,12 @@ static int btf_ensure_modifiable(struct btf *btf)
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
@@ -1766,12 +1860,14 @@ static int btf_ensure_modifiable(struct btf *btf)
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
2.39.3


