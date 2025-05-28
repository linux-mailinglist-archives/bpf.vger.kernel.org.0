Return-Path: <bpf+bounces-59158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C037AC6675
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC1F3A6997
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64646279903;
	Wed, 28 May 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G0yaLhR4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5427933C;
	Wed, 28 May 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426309; cv=none; b=THZk6pDupB6UIwO+CvE2vu8QPzzP6I1zenBGy9DXqn9XrI0cFqDjzE45s9+qqLlOOyR9zcxKMceI9UABxfgnNNPwfNsneA2vUs+q76SDbfiAQJ8zBHCovDJLWtmVmuVUQfiaCgL2D4CnnuquUtmY0dkaYUG3bNhPe2miO1MG6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426309; c=relaxed/simple;
	bh=FmWw0FgSxE9Aebpn5xoDTtVm4w3tPkDTIXn/NILuXCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY7eehZZKFWWvGNAzESsOFSZV1clqfa4Tp25yFOxls/7PWkh2SQ4DO0KKLvlCNtRh0kkFr1UVY5xEjobcR5Q0f1la2JXLtVUMQD/5rEBYpXF3N60HcQ+WmYcbcpAvzn4LpRSVHjMr8JXglc/IRvidm650T2l1AKkhy0dxvxwjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G0yaLhR4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1gPAA004814;
	Wed, 28 May 2025 09:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4pPcI
	rykV8+8YnKxHHZCyVMsoguyXPSHev3vnrkadqY=; b=G0yaLhR4TMSJFwuadcLbP
	JgmumjgsUmHwgO4VflofF9oVV1v8tU6M37YwOCA2+I8FGeE76sv5kSqBsJNa1DTF
	+6cH68uAt6GvJQPXt6FaWY0lAC/z0fImvjc1zBbQKVBGYt8Wo4dfCD9AmOiQkKZc
	GPFlNDKTbV7dXaYP4TgjCU5z5akZVugADDPYXro3R5Oey6bcL5n8iGI2rLU0waOE
	L8keRHMPKxDkGNUxQ2qBi7v/mQEJjm70usKpctonWEKFYDcjkCYQYyK/zm88bons
	O6KKHxj4/WCNM6HkSFqA1c0pfw1TND6NDBn+F2IGus2bIp7UypCO8rfBjezkUyqJ
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s5ccy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:57:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9p61A024429;
	Wed, 28 May 2025 09:57:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaev11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:57:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwVq007194;
	Wed, 28 May 2025 09:57:54 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-4;
	Wed, 28 May 2025 09:57:54 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 3/9] libbpf: use kind layout to compute an unknown kind size
Date: Wed, 28 May 2025 10:57:37 +0100
Message-ID: <20250528095743.791722-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095743.791722-1-alan.maguire@oracle.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NiBTYWx0ZWRfXw691lT2Nn2hl VGNTqKsoFnXR+IN/V2fsjhdJPO+NYYLTWC0aEjR6xEJp4j+JOPqgUsCCTBv3nt+zrQjuqOAH56f bC0rKkGZhsf429MydcKByeMIC+QzfJBhpZYXnxM2EDMhofKhWTdvXHqAAw0eKQe5SLLo1PIldGj
 uvaJ9xxwVeXSINcguhwkMoXuSl4TPXb+V3BwZKVw3uqK///lfjfec55TNO1lChLj0BohcCcVjFn CET4H++Sy3s+wQ26XXNwkxr14yy/OtGMOp0Vkv8YVyz+FgBkleLHGKJ5Uko02NrguP8lDzlfjND 76cTCRGZ8skSi4W6ykohMFwPQ7ZDW4kd6g9ekm9GeL2LLPvWbVsd9ee5k00tUZn2Ho0tiNwxCjw
 5SOEHgP06to0vsPf6wNSksYilCiv+3ejOnkLNOX2bnAv1+L47nMdap85xaWLqzZ9dc9RwEDb
X-Proofpoint-GUID: leNQKER8cibAW8XKdd0f5Q3A4EkjIA3F
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=6836de24 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=lBhNhz_EOHFIOJiDK9sA:9 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: leNQKER8cibAW8XKdd0f5Q3A4EkjIA3F

This allows BTF parsing to proceed even if we do not know the
kind.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 43d1fce8977c..7a197dbfc689 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -355,7 +355,29 @@ static int btf_parse_kind_layout_sec(struct btf *btf)
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
+
+	if (btf->kind_layout)
+		k = &((struct btf_kind_layout *)btf->kind_layout)[kind];
+
+	if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_layout_len)) {
+		pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
+		return -EINVAL;
+	}
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
@@ -391,8 +413,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -491,7 +512,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -1989,7 +2010,7 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 	__u32 *str_off;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(p->src, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -2071,7 +2092,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		struct btf_field_iter it;
 		__u32 *type_id, *str_off;
 
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -5354,7 +5375,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
-- 
2.39.3


