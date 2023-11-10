Return-Path: <bpf+bounces-14753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E97E7B9C
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 12:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A502813FF
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A301427E;
	Fri, 10 Nov 2023 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8PYSO/C"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036512B75
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:04:07 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3AA2B78D
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:04:06 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAAa6u9017477;
	Fri, 10 Nov 2023 11:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Zny0GWWT0isQSzvl6z9jaCawxilet081z4jJO7AwjeQ=;
 b=G8PYSO/CcN1dU7P7ZJFgv/6ruDxHMSypVoAwIO54Im4CDyZqBpg6uHnzCKjjWwWkQ1VJ
 3kc5mbKaGtDhnjUeZhSahwEaxZX/u8IIDaJDNXtsaTMWmaHNZ8Z/XIkVy6ocKDt3wDsX
 F/X1BdtxZJPAP8V7PFt3G+Emh6oGNT831ITOoVoMx6q47BNxr2o5VXbVjQHlMP1YZlKH
 YigpVSCh6fxp+TXVf73BkebUeLCIkum3oaGOKiNGcnoW/QhzG2jQivpI7GrPq262isY2
 3aADCzMNrKgSykuekDDvNeiR6pU82U/+Sz1DSewLsSd3Aj3lI5PlCJ+NlGhC0ogpZ5d8 pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23620y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:03:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAA974o017695;
	Fri, 10 Nov 2023 11:03:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c01qg7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:03:47 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAB3Wfk018454;
	Fri, 10 Nov 2023 11:03:46 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-193.vpn.oracle.com [10.175.213.193])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u8c01qfd7-4;
	Fri, 10 Nov 2023 11:03:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: jolsa@kernel.org, quentin@isovalent.com, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 03/17] libbpf: use kind layout to compute an unknown kind size
Date: Fri, 10 Nov 2023 11:02:50 +0000
Message-Id: <20231110110304.63910-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231110110304.63910-1-alan.maguire@oracle.com>
References: <20231110110304.63910-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=941 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100090
X-Proofpoint-GUID: KvAE9K-zt5DABvZX_vsRI63jTKzDwiYZ
X-Proofpoint-ORIG-GUID: KvAE9K-zt5DABvZX_vsRI63jTKzDwiYZ

This allows BTF parsing to proceed even if we do not know the
kind.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7a7a9793126a..007ce6bcad70 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -351,7 +351,29 @@ static int btf_parse_kind_layout_sec(struct btf *btf)
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
@@ -387,8 +409,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -487,7 +508,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -1868,7 +1889,7 @@ int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_t
 	struct btf_type *t;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(src_btf, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -1949,7 +1970,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	memcpy(t, src_btf->types_data, data_sz);
 
 	for (i = 0; i < cnt; i++) {
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -4945,7 +4966,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
-- 
2.31.1


