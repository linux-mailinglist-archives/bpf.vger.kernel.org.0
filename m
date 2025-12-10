Return-Path: <bpf+bounces-76426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0321CB3F80
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95FC030542F3
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BB2FB622;
	Wed, 10 Dec 2025 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kSgd0V8V"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE432C31C;
	Wed, 10 Dec 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398804; cv=none; b=XYkbPeUrLFPhd4/ZuqE+kbRDNspPIzSXmPbounS80tgFKJIISVumt90vEdV/wa55GYZPoyhYevaG31Gz73w5HVqytLUZ/qonZhGytHbIs0wAjbd2I7f45I9/vXwxQ5bW3UULs8QpzlK9DLNwq7nudAZtiYKA3nKo6eB5GehwBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398804; c=relaxed/simple;
	bh=PnxQyXinFe48SYvKHXfrZiczsYnN94afvjaqdrnCbh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy4AetZTGlGWsK+loUBmaFYICqrTV8XT95aC/zOpNmFffc8auhQ5cvb957e75Z1VSD69HK3tsM2jBIEx2xeUvWiph2SNdX3O7qBBNt/dpcKv/Yqk9WdIY+Dr4ipu4qk3NJVcJEtgpR8OWnAFm/cMNlhUUrGazfTiCmTziSaKpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kSgd0V8V; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIYAkN3966875;
	Wed, 10 Dec 2025 20:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=z5yzC
	QrnOqZRLdw1PtgZ/fJipHbrWBiWZJ1EPJ0kt8w=; b=kSgd0V8VUSGiwGKvJfKti
	Rwadw85BGahaA3V3lzQByw4Rr6oyGrosKkkK4/iAPXwA+H0YhYdl/4vvimqq1K2G
	9ARNHS27lXyNmNp+obwYpHvw9xZgaF1POug61cXoIh0pIwUACawNFiV4j71nt5RM
	oswul8OblF0bNkdfcGwy41RkBqymN94I6kpKhTEiwYnZ5ofZuforRCLiABU3X1GQ
	GmPQvScn2vbXkyn6jsoKyOu1UCGxoMvmAPKtZ+z/Wk8/+lJ6TC/BxdCTrOpiPAVl
	+6HYAjyOwdUVOOXP55EdkUKShc+lS+o2moW9jyFBUEuwkO+GcX5VrzeYm1Iu7/F5
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ay9y30q5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:32:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJnJF2040226;
	Wed, 10 Dec 2025 20:32:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxmrpw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:32:55 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKWkSZ001635;
	Wed, 10 Dec 2025 20:32:54 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxmrprn-4;
	Wed, 10 Dec 2025 20:32:54 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 03/10] libbpf: use kind layout to compute an unknown kind size
Date: Wed, 10 Dec 2025 20:32:36 +0000
Message-ID: <20251210203243.814529-4-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: bpP-4sJ1MnYoIlTXJHI5BzV_-OLd0tFg
X-Proofpoint-ORIG-GUID: bpP-4sJ1MnYoIlTXJHI5BzV_-OLd0tFg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2OCBTYWx0ZWRfXzbgF43Lq5Mje
 NNnRwkQPPDh1Chnl1evfZzhCz1pU0AViwu2mY7tgMhzRfiFqF1RVcmdl1PGISB+8EctccptYq93
 P2BA15+0Cwn0LbmViC40VJS3c0awGD4XF+Sa+ZUyziXTWh7d81CgOvHLg9INW2/nKYf5dYD369d
 Z9p3RVfmtE2YMTFbFc3xOQkk1TfwmciCdqGLdn4gmJQO2XARrcXks0R2XYHE33Y6HbiZdX5aJe5
 UIyp20WGWkUIoQzlQjmXrhI0rE3EOgGHKARdy+91FyCjeP/qjTbIu8AT527HMvzYh2QlRJGUDG2
 oU0vU9iNeIY9VpVinQa1Ihn2qfJEDC96FRX0ypBKAJEuwCPbjQRHvIuHXY5H/k9uUvmYSUOY+id
 volSgXLk98aiDbYFX/QsGcBjGUcbKDOsXYoQoJmqP2G5zkyixDM=
X-Authority-Analysis: v=2.4 cv=YJeSCBGx c=1 sm=1 tr=0 ts=6939d8f7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lBhNhz_EOHFIOJiDK9sA:9 cc=ntf awl=host:12099

This allows BTF parsing to proceed even if we do not know the
kind.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 737adc560818..4eb0704a0309 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -344,7 +344,29 @@ static int btf_parse_kind_layout_sec(struct btf *btf)
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
@@ -380,8 +402,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -480,7 +501,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -1976,7 +1997,7 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 	__u32 *str_off;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(p->src, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -2058,7 +2079,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		struct btf_field_iter it;
 		__u32 *type_id, *str_off;
 
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -5399,7 +5420,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
-- 
2.43.5


