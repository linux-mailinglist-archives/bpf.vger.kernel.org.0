Return-Path: <bpf+bounces-32571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36549910021
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281351C2205A
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5819E836;
	Thu, 20 Jun 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WUu1vhD5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58919AD5E
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875103; cv=none; b=o8PMHFT2CUCbrh+KMNXDoTBbWiqheCIbXFERx/DiiThpFgomZCvb8OF/UHWmdliVnV/OVeN2pUjePEU1NtK5mbarI/55IJhSvxkX/8Bv3Ab1222AIF2/LIV2fmWBVOjsSe3gdWKKa/2P3fDq9ixD/htlWHK84Vz5JG/KKoMxaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875103; c=relaxed/simple;
	bh=MLTb67WvtMU89T3my4+inkP6YNjaGuHU25I6DMuPmgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw+Tr8uP+S1ee8QyUkbDx0/nt6Y8YG4px2GCSqGGHMwG4L2s0LS3AEHG/DYzS0vzvJP8dJfy3WNDrhzOFmsTjf+EZ5QrUTNidosGu4ne9rgrhNVi5CRELI6EFQ+pN9LwF5FXZzmQvlB/kc+7lhbL5FZNxXgsS00U5NECvYiClLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WUu1vhD5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FU95005046;
	Thu, 20 Jun 2024 09:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=x
	2crl2P7Mg7n5pPEd16UbcWkMMKpdU7B0hp+laoJBpw=; b=WUu1vhD5r5/YzW9I7
	YGezUwvQrtWKcX3jZ6o8lliNxf+jioU1xAX2LtXFAAUNtpEWFwlI/vLsTTEckYgx
	m/LvqIPCvMv9Udq9e6yDiI6K/WUtE04N0DTydla3pVJVzz6K55a/N9u2HOj0V3Jq
	6kYfFItP7HOBSOb/Jm/klYP+207sJ6xUmosWyvJ5g/bv6EjlH1zzcC8j4gpeINVb
	MXHY26GGagQNDo9ZRwZpbc5kMYulFUaqGN0B8oBCiJUAWHtC9nI7srFlVWcBw5ZU
	hAani0Les8W8j7HyCak2M3fuh/zea0QyvKpAvTzODxvX5Ii5iCLE1IdTY2xIaMWA
	JgmFA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9jtqka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:17:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45K852Tm032785;
	Thu, 20 Jun 2024 09:17:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1da76em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:17:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45K9HdGJ028275;
	Thu, 20 Jun 2024 09:17:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-186-70.vpn.oracle.com [10.175.186.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1da764t-4;
	Thu, 20 Jun 2024 09:17:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 3/6] libbpf: split field iter code into its own file kernel
Date: Thu, 20 Jun 2024 10:17:30 +0100
Message-ID: <20240620091733.1967885-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620091733.1967885-1-alan.maguire@oracle.com>
References: <20240620091733.1967885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200065
X-Proofpoint-ORIG-GUID: eRHzzBk0dE1n_5fIUZlKczJl4ndEO4KC
X-Proofpoint-GUID: eRHzzBk0dE1n_5fIUZlKczJl4ndEO4KC

This will allow it to be shared with the kernel.  No functional change.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/Build      |   2 +-
 tools/lib/bpf/btf.c      | 162 -------------------------------------
 tools/lib/bpf/btf_iter.c | 169 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 163 deletions(-)
 create mode 100644 tools/lib/bpf/btf_iter.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 336da6844d42..e2cd558ca0b4 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o features.o btf_relocate.o
+	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ef1b2f573c1b..0c0f60cad769 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5093,168 +5093,6 @@ struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_bt
 	return btf__parse_split(path, vmlinux_btf);
 }
 
-int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t, enum btf_field_iter_kind iter_kind)
-{
-	it->p = NULL;
-	it->m_idx = -1;
-	it->off_idx = 0;
-	it->vlen = 0;
-
-	switch (iter_kind) {
-	case BTF_FIELD_ITER_IDS:
-		switch (btf_kind(t)) {
-		case BTF_KIND_UNKN:
-		case BTF_KIND_INT:
-		case BTF_KIND_FLOAT:
-		case BTF_KIND_ENUM:
-		case BTF_KIND_ENUM64:
-			it->desc = (struct btf_field_desc) {};
-			break;
-		case BTF_KIND_FWD:
-		case BTF_KIND_CONST:
-		case BTF_KIND_VOLATILE:
-		case BTF_KIND_RESTRICT:
-		case BTF_KIND_PTR:
-		case BTF_KIND_TYPEDEF:
-		case BTF_KIND_FUNC:
-		case BTF_KIND_VAR:
-		case BTF_KIND_DECL_TAG:
-		case BTF_KIND_TYPE_TAG:
-			it->desc = (struct btf_field_desc) { 1, {offsetof(struct btf_type, type)} };
-			break;
-		case BTF_KIND_ARRAY:
-			it->desc = (struct btf_field_desc) {
-				2, {sizeof(struct btf_type) + offsetof(struct btf_array, type),
-				    sizeof(struct btf_type) + offsetof(struct btf_array, index_type)}
-			};
-			break;
-		case BTF_KIND_STRUCT:
-		case BTF_KIND_UNION:
-			it->desc = (struct btf_field_desc) {
-				0, {},
-				sizeof(struct btf_member),
-				1, {offsetof(struct btf_member, type)}
-			};
-			break;
-		case BTF_KIND_FUNC_PROTO:
-			it->desc = (struct btf_field_desc) {
-				1, {offsetof(struct btf_type, type)},
-				sizeof(struct btf_param),
-				1, {offsetof(struct btf_param, type)}
-			};
-			break;
-		case BTF_KIND_DATASEC:
-			it->desc = (struct btf_field_desc) {
-				0, {},
-				sizeof(struct btf_var_secinfo),
-				1, {offsetof(struct btf_var_secinfo, type)}
-			};
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case BTF_FIELD_ITER_STRS:
-		switch (btf_kind(t)) {
-		case BTF_KIND_UNKN:
-			it->desc = (struct btf_field_desc) {};
-			break;
-		case BTF_KIND_INT:
-		case BTF_KIND_FLOAT:
-		case BTF_KIND_FWD:
-		case BTF_KIND_ARRAY:
-		case BTF_KIND_CONST:
-		case BTF_KIND_VOLATILE:
-		case BTF_KIND_RESTRICT:
-		case BTF_KIND_PTR:
-		case BTF_KIND_TYPEDEF:
-		case BTF_KIND_FUNC:
-		case BTF_KIND_VAR:
-		case BTF_KIND_DECL_TAG:
-		case BTF_KIND_TYPE_TAG:
-		case BTF_KIND_DATASEC:
-			it->desc = (struct btf_field_desc) {
-				1, {offsetof(struct btf_type, name_off)}
-			};
-			break;
-		case BTF_KIND_ENUM:
-			it->desc = (struct btf_field_desc) {
-				1, {offsetof(struct btf_type, name_off)},
-				sizeof(struct btf_enum),
-				1, {offsetof(struct btf_enum, name_off)}
-			};
-			break;
-		case BTF_KIND_ENUM64:
-			it->desc = (struct btf_field_desc) {
-				1, {offsetof(struct btf_type, name_off)},
-				sizeof(struct btf_enum64),
-				1, {offsetof(struct btf_enum64, name_off)}
-			};
-			break;
-		case BTF_KIND_STRUCT:
-		case BTF_KIND_UNION:
-			it->desc = (struct btf_field_desc) {
-				1, {offsetof(struct btf_type, name_off)},
-				sizeof(struct btf_member),
-				1, {offsetof(struct btf_member, name_off)}
-			};
-			break;
-		case BTF_KIND_FUNC_PROTO:
-			it->desc = (struct btf_field_desc) {
-				1, {offsetof(struct btf_type, name_off)},
-				sizeof(struct btf_param),
-				1, {offsetof(struct btf_param, name_off)}
-			};
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (it->desc.m_sz)
-		it->vlen = btf_vlen(t);
-
-	it->p = t;
-	return 0;
-}
-
-__u32 *btf_field_iter_next(struct btf_field_iter *it)
-{
-	if (!it->p)
-		return NULL;
-
-	if (it->m_idx < 0) {
-		if (it->off_idx < it->desc.t_off_cnt)
-			return it->p + it->desc.t_offs[it->off_idx++];
-		/* move to per-member iteration */
-		it->m_idx = 0;
-		it->p += sizeof(struct btf_type);
-		it->off_idx = 0;
-	}
-
-	/* if type doesn't have members, stop */
-	if (it->desc.m_sz == 0) {
-		it->p = NULL;
-		return NULL;
-	}
-
-	if (it->off_idx >= it->desc.m_off_cnt) {
-		/* exhausted this member's fields, go to the next member */
-		it->m_idx++;
-		it->p += it->desc.m_sz;
-		it->off_idx = 0;
-	}
-
-	if (it->m_idx < it->vlen)
-		return it->p + it->desc.m_offs[it->off_idx++];
-
-	it->p = NULL;
-	return NULL;
-}
-
 int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx)
 {
 	const struct btf_ext_info *seg;
diff --git a/tools/lib/bpf/btf_iter.c b/tools/lib/bpf/btf_iter.c
new file mode 100644
index 000000000000..c308aa60285d
--- /dev/null
+++ b/tools/lib/bpf/btf_iter.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2021 Facebook */
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include "btf.h"
+#include "libbpf_internal.h"
+
+int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
+			enum btf_field_iter_kind iter_kind)
+{
+	it->p = NULL;
+	it->m_idx = -1;
+	it->off_idx = 0;
+	it->vlen = 0;
+
+	switch (iter_kind) {
+	case BTF_FIELD_ITER_IDS:
+		switch (btf_kind(t)) {
+		case BTF_KIND_UNKN:
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			it->desc = (struct btf_field_desc) {};
+			break;
+		case BTF_KIND_FWD:
+		case BTF_KIND_CONST:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_PTR:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_FUNC:
+		case BTF_KIND_VAR:
+		case BTF_KIND_DECL_TAG:
+		case BTF_KIND_TYPE_TAG:
+			it->desc = (struct btf_field_desc) { 1, {offsetof(struct btf_type, type)} };
+			break;
+		case BTF_KIND_ARRAY:
+			it->desc = (struct btf_field_desc) {
+				2, {sizeof(struct btf_type) + offsetof(struct btf_array, type),
+				sizeof(struct btf_type) + offsetof(struct btf_array, index_type)}
+			};
+			break;
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			it->desc = (struct btf_field_desc) {
+				0, {},
+				sizeof(struct btf_member),
+				1, {offsetof(struct btf_member, type)}
+			};
+			break;
+		case BTF_KIND_FUNC_PROTO:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, type)},
+				sizeof(struct btf_param),
+				1, {offsetof(struct btf_param, type)}
+			};
+			break;
+		case BTF_KIND_DATASEC:
+			it->desc = (struct btf_field_desc) {
+				0, {},
+				sizeof(struct btf_var_secinfo),
+				1, {offsetof(struct btf_var_secinfo, type)}
+			};
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case BTF_FIELD_ITER_STRS:
+		switch (btf_kind(t)) {
+		case BTF_KIND_UNKN:
+			it->desc = (struct btf_field_desc) {};
+			break;
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_FWD:
+		case BTF_KIND_ARRAY:
+		case BTF_KIND_CONST:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_PTR:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_FUNC:
+		case BTF_KIND_VAR:
+		case BTF_KIND_DECL_TAG:
+		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_DATASEC:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)}
+			};
+			break;
+		case BTF_KIND_ENUM:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_enum),
+				1, {offsetof(struct btf_enum, name_off)}
+			};
+			break;
+		case BTF_KIND_ENUM64:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_enum64),
+				1, {offsetof(struct btf_enum64, name_off)}
+			};
+			break;
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_member),
+				1, {offsetof(struct btf_member, name_off)}
+			};
+			break;
+		case BTF_KIND_FUNC_PROTO:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_param),
+				1, {offsetof(struct btf_param, name_off)}
+			};
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (it->desc.m_sz)
+		it->vlen = btf_vlen(t);
+
+	it->p = t;
+	return 0;
+}
+
+__u32 *btf_field_iter_next(struct btf_field_iter *it)
+{
+	if (!it->p)
+		return NULL;
+
+	if (it->m_idx < 0) {
+		if (it->off_idx < it->desc.t_off_cnt)
+			return it->p + it->desc.t_offs[it->off_idx++];
+		/* move to per-member iteration */
+		it->m_idx = 0;
+		it->p += sizeof(struct btf_type);
+		it->off_idx = 0;
+	}
+
+	/* if type doesn't have members, stop */
+	if (it->desc.m_sz == 0) {
+		it->p = NULL;
+		return NULL;
+	}
+
+	if (it->off_idx >= it->desc.m_off_cnt) {
+		/* exhausted this member's fields, go to the next member */
+		it->m_idx++;
+		it->p += it->desc.m_sz;
+		it->off_idx = 0;
+	}
+
+	if (it->m_idx < it->vlen)
+		return it->p + it->desc.m_offs[it->off_idx++];
+
+	it->p = NULL;
+	return NULL;
+}
-- 
2.31.1


