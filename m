Return-Path: <bpf+bounces-76591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03909CBD22A
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E44300AB1F
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024E314B81;
	Mon, 15 Dec 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f4AqLVSV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E542AB7;
	Mon, 15 Dec 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790334; cv=none; b=mj6bzzGfH5mDOCHK+hdE0qpSqMHYWHhcgQempZX/sujD/LXuApq/8p7yauyMZ1jcI58P2s23a+BLsyzqxHWOdADS645qZGtBzcJC+MYGotOsdv+5Ipmm8rn2s/DH1QfDUpzeMHhjGqyZfEKPYpzIg11c0lgd0rBYrCcgntI4ypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790334; c=relaxed/simple;
	bh=IR0RuASLD5iHv5w2sl1/R+r5ihjyuFLDKRcny8dQsEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHxVpJxucHLQj5b/rupitoP9TUsISksXXRjUwvO8AK4hgZUFIichdT3EzqAafxRv3DXR7OMuutQ4x3SAgzP2SBP5ka3+5bsClco9AmSOnN9zgUFAh93i+Wm+0rBMlWuszmf+3WaQ1HnjbYQTec468uvM+gLAt155AsVaazyUZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f4AqLVSV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uKmC1652143;
	Mon, 15 Dec 2025 09:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=M6b1S
	y4LgXDoatkbtOnFfZleknaokRC1EZ7QQnXeyTo=; b=f4AqLVSV6D/P9EBBCY6f0
	513D+EHgWGDAprOcvs9X1TuZg473lzlCNlJwIuGqzTzYo5G4MZxF+xNdkH6Ib/th
	gkffb016rUve923VXcNSKaQcHBFzlzb/V33CLnMxcpvMM/NRALH+vS5IwHh9vDxB
	zCcdaXZaBSXmi4Riqb+fFRAmD/08sT8BJyWGU44BTCiPQX1F8JBGBE2OsP2G0v0j
	x50WCToBhB9ejH8DYdar1Ri705mb7GncKYVT7/Yl2dnN5ZwqW1W/EXA/UuZPVppB
	kWfJUDZ1gcDNpzI21S+mNjU4AMaAdrSpfUuxoGA+R0uoyHOLQ3zTdWAGY+2977yt
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prhp09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF6mjMi025211;
	Mon, 15 Dec 2025 09:18:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8ygr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BF9HdwW027566;
	Mon, 15 Dec 2025 09:18:17 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-2.vpn.oracle.com [10.154.53.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk8yg99-4;
	Mon, 15 Dec 2025 09:18:17 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an unknown kind size
Date: Mon, 15 Dec 2025 09:17:23 +0000
Message-ID: <20251215091730.1188790-4-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA3OCBTYWx0ZWRfX0P4o44+Mqp/1
 GS1o6shn5mKeQCmJM55usPKBkSbcFmjM7eot5wkrOuvxsF7cnXxzlaTKSRw495yqpRKMemkXJ1L
 LghMiZYyGj66blsqFgwTrpvOUOKA14qG195Zn5p1q2yHaNj7a6ybJJnUds51sZjHxyy/wcwt6Y0
 RRHzIrypXlQFEvzN0FcNoOuLtLPIzxKAHpnJv0a3heuo9Bfav3HWGDYPA8dYmW8pQGM68rz13wJ
 ifO85C/ggCq2QnAtDontTo9hyy+ny3Yq3xlSb+t3U1DvWSJa4naxtLGNVG2+3VsQtXHbSGSmZSd
 QVa8tYsqUxxmsZJ95RZ2x3GOdUoLGxH7+LNRIwPv/pRemUAFXreyI4vQ/3XDGcaCwjBwX+dpMoP
 Q0k7zIZZViduFRAs86aNYvuUIu8Llg==
X-Proofpoint-GUID: g7XSocCxgF_r-XsIDB1XbeV6cwNX19lo
X-Proofpoint-ORIG-GUID: g7XSocCxgF_r-XsIDB1XbeV6cwNX19lo
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=693fd25a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lBhNhz_EOHFIOJiDK9sA:9

This allows BTF parsing to proceed even if we do not know the
kind.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8835aee6ee84..3936ee04a46a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -359,7 +359,28 @@ static int btf_parse_kind_layout_sec(struct btf *btf)
 	return 0;
 }
 
-static int btf_type_size(const struct btf_type *t)
+/* for unknown kinds, consult kind layout. */
+static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
+{
+	int size = sizeof(struct btf_type);
+	struct btf_kind_layout *k = NULL;
+	__u16 vlen = btf_vlen(t);
+	__u8 kind = btf_kind(t);
+	__u32 off = kind * sizeof(struct btf_kind_layout);
+
+	if (!btf->kind_layout || off >= btf->hdr->kind_layout_len) {
+		pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
+		return -EINVAL;
+	}
+	k = btf->kind_layout + off;
+
+	size += k->info_sz;
+	size += vlen * k->elem_sz;
+
+	return size;
+}
+
+static int btf_type_size(const struct btf *btf, const struct btf_type *t)
 {
 	const int base_size = sizeof(struct btf_type);
 	__u16 vlen = btf_vlen(t);
@@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -495,7 +515,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -2005,7 +2025,7 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 	__u32 *str_off;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(p->src, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -2087,7 +2107,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		struct btf_field_iter it;
 		__u32 *type_id, *str_off;
 
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -5422,7 +5442,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
-- 
2.39.3


