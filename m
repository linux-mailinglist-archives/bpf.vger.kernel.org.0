Return-Path: <bpf+bounces-70602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66140BC6276
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579DF18961DC
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0472BF00B;
	Wed,  8 Oct 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mYZBeZk4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7D2BEC5E
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944953; cv=none; b=BHEMOxqwnkO7QwpnbEGHLW3o678rON9kyDOKpmOZ9REV3tdMlY1iSl3zTQUFMdFuPG4BvovKynoErAL5zbKpKUCedwxEDfUup010F93Y+/daf35is4My3QIvei+AGzDkY6uV1hPlI2phw7mMOKAMsFXO5kWA6x64W5fmOOQuHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944953; c=relaxed/simple;
	bh=cwA+OcY5rtBUVqBjCxceEgPc4GI42xDCuZgeGFsXGxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIFRk0qJhRjDWtU8b0wm7dLqf4BBwyUb85Q4WG3cZiqKLYfOR833G1CAPyYqs+OxdfL9WHC8xldwlRqdvp8B4teDppXZB1L7qVX23erGR1WebfGOztCHH1RvOXpJXWktHCANtrjEOQTYSHb95laacra3ET15yi+HYjv+kni0xl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mYZBeZk4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEUid032746;
	Wed, 8 Oct 2025 17:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=BS9Ms
	sHIxpXvxviTrr4rDqnw7aLBpQUDvlkOrX/gX7w=; b=mYZBeZk4V7mLfa2ocVgl8
	n6daQTbwR057sSQs4MRZ3i5nMcvWvNfwr9EU7f5YHR9ZlbsA/RjH1NehmJHFHwCD
	xiLyu/9YjAf5YGKrFXOGCjj72twFq4AwhEiBiaixhaLazZs/62wBMF3j2jME76Ur
	HvWaJh0Pqp32ReYATJqZq9zS0z0if7RnOLDSxdwEA3ui7SgxlfGOK5SZ7Pbg8D6M
	qp3Ng0VRN7//M8Vu4XI54VnJmeAml353UnH6XowhQTOtnY0LCgmnua2TlQUrdDwv
	ysyaqRekTEY+CHkSH8AqeUPbA3bLvWwAZDTgQI92dU7Xec9hgyczOZ2Uq2CGtkws
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6br1av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDujZ037077;
	Wed, 8 Oct 2025 17:35:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rpsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUk031138;
	Wed, 8 Oct 2025 17:35:20 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-3;
	Wed, 08 Oct 2025 17:35:20 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 02/15] libbpf: Add support for BTF kinds LOC_PARAM, LOC_PROTO and LOCSEC
Date: Wed,  8 Oct 2025 18:34:58 +0100
Message-ID: <20251008173512.731801-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e6a0da b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=r3duO8M3fcnYQWKYDvQA:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: 9gNh9gDuXMxPz4EavnkALv0C28XCgLMD
X-Proofpoint-GUID: 9gNh9gDuXMxPz4EavnkALv0C28XCgLMD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9f0qu7b03wDq
 35Ua5J2nH25mCo3SYEzkjRy3myc+uz9U8PzOK486go82yfsoiRwJnfCPN5Fz6P9lHy6/Ugx897m
 9ILiECXEoZLvqvrOU0HM8eq1cusqTXGFk7UV++2taCFpYQP2apzUX1iOJKiCwv8368kAHdckhlk
 cilaqp8oXXm71ViIPZBIlMoosDA/W4SMhLIdJowzojjd5mzta/4vkDPh2gdOO6Qr6NEkuOizveP
 Pjp0mVZOrkQfMIRYb6UqLGBDkYf4WA9EC4Wvw0Eh/Fmc9sCrNVKhoLkBptARGpv601Qhnm6SFWq
 hobGbUr2DXUmn96iALmRADGQOzn4x4mT9CAswzdVKtUTdZMLTeQvSZTydBL3MaEc3ZZ0/31kBz/
 IP5TYg/m/sRRORr3n/x8N3GwtW/vUpHGETF17xFx/0+MiHVIOYw=

Add support for new kinds to libbpf.  BTF_KIND_LOC_PARAM and
BTF_KIND_LOC_PROTO are dedup-able so add support for their
deduplication, whereas since BTF_KIND_LOCSEC contains a unique
offset it is not.

Other considerations: because BTF_KIND_LOCSEC has multiple
member type ids we need to increase the number of member elements
to 2 in the field iterator.

Add APIs to add location param, location prototypes and location
sections.

For BTF relocation we add location info to split BTF.

One small thing noticed during testing; the test for adding_to_base
relies on the split BTF start id being > 1; however it is possible
to have empty distilled base BTF, so this test should be generalized
to check for the base BTF pointer (it will be non-NULL for split
BTF even if the base BTF is empty).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c             | 339 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h             |  90 +++++++++
 tools/lib/bpf/btf_dump.c        |  10 +-
 tools/lib/bpf/btf_iter.c        |  23 +++
 tools/lib/bpf/libbpf.map        |   5 +
 tools/lib/bpf/libbpf_internal.h |   4 +-
 6 files changed, 464 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..0abd7831d6b4 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -327,6 +327,12 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + vlen * sizeof(struct btf_var_secinfo);
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
+	case BTF_KIND_LOC_PARAM:
+		return base_size + sizeof(__u64);
+	case BTF_KIND_LOC_PROTO:
+		return base_size + vlen * sizeof(__u32);
+	case BTF_KIND_LOCSEC:
+		return base_size + vlen * sizeof(struct btf_loc);
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
 		return -EINVAL;
@@ -343,12 +349,15 @@ static void btf_bswap_type_base(struct btf_type *t)
 static int btf_bswap_type_rest(struct btf_type *t)
 {
 	struct btf_var_secinfo *v;
+	struct btf_loc_param *lp;
 	struct btf_enum64 *e64;
 	struct btf_member *m;
 	struct btf_array *a;
 	struct btf_param *p;
 	struct btf_enum *e;
+	struct btf_loc *l;
 	__u16 vlen = btf_vlen(t);
+	__u32 *ids;
 	int i;
 
 	switch (btf_kind(t)) {
@@ -411,6 +420,30 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		btf_decl_tag(t)->component_idx = bswap_32(btf_decl_tag(t)->component_idx);
 		return 0;
+	case BTF_KIND_LOC_PARAM:
+		lp = btf_loc_param(t);
+		if (btf_kflag(t)) {
+			lp->val_lo32 = bswap_32(lp->val_lo32);
+			lp->val_hi32 = bswap_32(lp->val_hi32);
+		} else {
+			lp->reg = bswap_16(lp->reg);
+			lp->flags = bswap_16(lp->flags);
+			lp->offset = bswap_32(lp->offset);
+		}
+		return 0;
+	case BTF_KIND_LOC_PROTO:
+		for (i = 0, ids = btf_loc_proto_params(t); i < vlen; i++, ids++)
+			*ids = bswap_32(*ids);
+		return 0;
+	case BTF_KIND_LOCSEC:
+		for (i = 0, l = btf_locsec_locs(t); i < vlen; i++, l++) {
+			l->name_off = bswap_32(l->name_off);
+			l->func_proto = bswap_32(l->func_proto);
+			l->loc_proto = bswap_32(l->loc_proto);
+			l->offset = bswap_32(l->offset);
+		}
+		return 0;
+
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
 		return -EINVAL;
@@ -588,6 +621,34 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
 		}
 		break;
 	}
+	case BTF_KIND_LOC_PARAM:
+		break;
+	case BTF_KIND_LOC_PROTO: {
+		__u32 *p = btf_loc_proto_params(t);
+
+		n = btf_vlen(t);
+		for (i = 0; i < n; i++, p++) {
+			err = btf_validate_id(btf, *p, id);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_LOCSEC: {
+		const struct btf_loc *l = btf_locsec_locs(t);
+
+		n = btf_vlen(t);
+		for (i = 0; i < n; i++, l++) {
+			err = btf_validate_str(btf, l->name_off, "loc name", id);
+			if (!err)
+				err = btf_validate_id(btf, l->func_proto, id);
+			if (!err)
+				btf_validate_id(btf, l->loc_proto, id);
+			if (err)
+				return err;
+		}
+		break;
+	}
 	default:
 		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
 		return -EINVAL;
@@ -2993,6 +3054,183 @@ int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
 	return btf_add_decl_tag(btf, value, ref_type_id, component_idx, 1);
 }
 
+/*
+ * Append new BTF_KIND_LOC_PARAM with either
+ *   - *value* set as __u64 value following btf_type, with info->kflag set to 1
+ *     if *is_value* is true; or
+ *   - *reg* number, *flags* and *offset* set if *is_value* is set to 0, and
+ *    info->kflag set to 0.
+ * Returns:
+ *   -  >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_loc_param(struct btf *btf, __s32 size, bool is_value, __u64 value,
+		       __u16 reg, __u16 flags, __s32 offset)
+{
+	struct btf_loc_param *p;
+	struct btf_type *t;
+	int sz;
+
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	sz = sizeof(struct btf_type) + sizeof(__u64);
+	t = btf_add_type_mem(btf, sz);
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	t->name_off = 0;
+	t->info = btf_type_info(BTF_KIND_LOC_PARAM, 0, is_value);
+	t->size = size;
+
+	p = btf_loc_param(t);
+
+	if (is_value) {
+		p->val_lo32 = value & 0xffffffff;
+		p->val_hi32 = value >> 32;
+	} else {
+		p->reg = reg;
+		p->flags = flags;
+		p->offset = offset;
+	}
+	return btf_commit_type(btf, sz);
+}
+
+/*
+ * Append new BTF_KIND_LOC_PROTO
+ *
+ * The prototype is then populated with 0 or more BTF_KIND_LOC_PARAMs via
+ * btf__add_loc_proto_param(); similar to how btf__add_func_param() adds
+ * parameters to a FUNC_PROTO.
+ *
+ * Returns:
+ *   -  >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_loc_proto(struct btf *btf)
+{
+	struct btf_type *t;
+
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	t = btf_add_type_mem(btf, sizeof(struct btf_type));
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	t->name_off = 0;
+	t->info = btf_type_info(BTF_KIND_LOC_PROTO, 0, 0);
+	t->size = 0;
+
+	return btf_commit_type(btf, sizeof(struct btf_type));
+}
+
+int btf__add_loc_proto_param(struct btf *btf, __u32 id)
+{
+	struct btf_type *t;
+	__u32 *p;
+	int sz;
+
+	if (validate_type_id(id))
+		return libbpf_err(-EINVAL);
+
+	/* last type should be BTF_KIND_LOC_PROTO */
+	if (btf->nr_types == 0)
+		return libbpf_err(-EINVAL);
+	t = btf_last_type(btf);
+	if (!btf_is_loc_proto(t))
+		return libbpf_err(-EINVAL);
+
+	/* decompose and invalidate raw data */
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	sz = sizeof(__u32);
+	p = btf_add_type_mem(btf, sz);
+	if (!p)
+		return libbpf_err(-ENOMEM);
+	*p = id;
+
+	/* update parent type's vlen */
+	t = btf_last_type(btf);
+	btf_type_inc_vlen(t);
+
+	btf->hdr->type_len += sz;
+	btf->hdr->str_off += sz;
+	return 0;
+}
+
+int btf__add_locsec(struct btf *btf, const char *name)
+{
+	struct btf_type *t;
+	int name_off = 0;
+
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	if (name && name[0]) {
+		name_off = btf__add_str(btf, name);
+		if (name_off < 0)
+			return name_off;
+	}
+	t = btf_add_type_mem(btf, sizeof(struct btf_type));
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	t->name_off = name_off;
+	t->info = btf_type_info(BTF_KIND_LOCSEC, 0, 0);
+	t->size = 0;
+
+	return btf_commit_type(btf, sizeof(struct btf_type));
+}
+
+int btf__add_locsec_loc(struct btf *btf, const char *name, __u32 func_proto, __u32 loc_proto,
+			__u32 offset)
+{
+	struct btf_type *t;
+	struct btf_loc *l;
+	int name_off, sz;
+
+	if (!name || !name[0])
+		return libbpf_err(-EINVAL);
+
+	if (validate_type_id(func_proto) || validate_type_id(loc_proto))
+		return libbpf_err(-EINVAL);
+
+	/* last type should be BTF_KIND_LOCSEC */
+	if (btf->nr_types == 0)
+		return libbpf_err(-EINVAL);
+	t = btf_last_type(btf);
+	if (!btf_is_locsec(t))
+		return libbpf_err(-EINVAL);
+
+	/* decompose and invalidate raw data */
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	name_off = btf__add_str(btf, name);
+	if (name_off < 0)
+		return name_off;
+
+	sz = sizeof(*l);
+	l = btf_add_type_mem(btf, sz);
+	if (!l)
+		return libbpf_err(-ENOMEM);
+
+	l->name_off = name_off;
+	l->func_proto = func_proto;
+	l->loc_proto = loc_proto;
+	l->offset = offset;
+
+	/* update parent type's vlen */
+	t = btf_last_type(btf);
+	btf_type_inc_vlen(t);
+
+	btf->hdr->type_len += sz;
+	btf->hdr->str_off += sz;
+	return 0;
+}
+
 struct btf_ext_sec_info_param {
 	__u32 off;
 	__u32 len;
@@ -3760,8 +3998,8 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_o
 	for (i = 1; i < type_cnt; i++) {
 		struct btf_type *t = btf_type_by_id(d->btf, i);
 
-		/* VAR and DATASEC are never deduped and are self-canonical */
-		if (btf_is_var(t) || btf_is_datasec(t))
+		/* VAR DATASEC and LOCSEC are never deduped and are self-canonical */
+		if (btf_is_var(t) || btf_is_datasec(t) || btf_is_locsec(t))
 			d->map[i] = i;
 		else
 			d->map[i] = BTF_UNPROCESSED_ID;
@@ -4001,6 +4239,26 @@ static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
 		return btf_equal_enum64_members(t1, t2);
 }
 
+static long btf_hash_loc_proto(struct btf_type *t)
+{
+	__u32 *p = btf_loc_proto_params(t);
+	long h = btf_hash_common(t);
+	int i, vlen = btf_vlen(t);
+
+	for (i = 0; i < vlen; i++, p++)
+		h = hash_combine(h, *p);
+	return h;
+}
+
+static bool btf_equal_loc_param(struct btf_type *t1, struct btf_type *t2)
+{
+	if (!btf_equal_common(t1, t2))
+		return false;
+	return btf_kflag(t1) == btf_kflag(t2) &&
+	       t1->size == t2->size &&
+	       btf_loc_param_value(t1) == btf_loc_param_value(t2);
+}
+
 static inline bool btf_is_enum_fwd(struct btf_type *t)
 {
 	return btf_is_any_enum(t) && btf_vlen(t) == 0;
@@ -4214,7 +4472,8 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		switch (btf_kind(t)) {
 		case BTF_KIND_VAR:
 		case BTF_KIND_DATASEC:
-			/* VAR and DATASEC are never hash/deduplicated */
+		case BTF_KIND_LOCSEC:
+			/* VAR DATASEC and LOCSEC are never hash/deduplicated */
 			continue;
 		case BTF_KIND_CONST:
 		case BTF_KIND_VOLATILE:
@@ -4245,6 +4504,12 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		case BTF_KIND_FUNC_PROTO:
 			h = btf_hash_fnproto(t);
 			break;
+		case BTF_KIND_LOC_PARAM:
+			h = btf_hash_common(t);
+			break;
+		case BTF_KIND_LOC_PROTO:
+			h = btf_hash_loc_proto(t);
+			break;
 		default:
 			pr_debug("unknown kind %d for type [%d]\n", btf_kind(t), type_id);
 			return -EINVAL;
@@ -4287,6 +4552,8 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_DATASEC:
 	case BTF_KIND_DECL_TAG:
 	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
 		return 0;
 
 	case BTF_KIND_INT:
@@ -4336,6 +4603,18 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 		}
 		break;
 
+	case BTF_KIND_LOC_PARAM:
+		h = btf_hash_common(t);
+		for_each_dedup_cand(d, hash_entry, h) {
+			cand_id = hash_entry->value;
+			cand = btf_type_by_id(d->btf, cand_id);
+			if (btf_equal_loc_param(t, cand)) {
+				new_id = cand_id;
+				break;
+			}
+		}
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -4749,6 +5028,13 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return 1;
 	}
 
+	case BTF_KIND_LOC_PARAM:
+		return btf_equal_loc_param(cand_type, canon_type);
+
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -5075,6 +5361,45 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 		break;
 	}
 
+	case BTF_KIND_LOC_PROTO: {
+		__u32 *p1, *p2;
+		__u16 i, vlen;
+
+		p1 = btf_loc_proto_params(t);
+		vlen = btf_vlen(t);
+
+		for (i = 0; i < vlen; i++, p1++) {
+			ref_type_id = btf_dedup_ref_type(d, *p1);
+			if (ref_type_id < 0)
+				return ref_type_id;
+			*p1 = ref_type_id;
+		}
+
+		h = btf_hash_loc_proto(t);
+		for_each_dedup_cand(d, hash_entry, h) {
+			cand_id = hash_entry->value;
+			cand = btf_type_by_id(d->btf, cand_id);
+			if (!btf_equal_common(t, cand))
+				continue;
+			vlen = btf_vlen(cand);
+			p1 = btf_loc_proto_params(t);
+			p2 = btf_loc_proto_params(cand);
+			if (vlen == 0) {
+				new_id = cand_id;
+				break;
+			}
+			for (i = 0; i < vlen; i++, p1++, p2++) {
+				if (*p1 != *p2)
+					break;
+				new_id = cand_id;
+				break;
+			}
+			if (new_id == cand_id)
+				break;
+		}
+		break;
+	}
+
 	default:
 		return -EINVAL;
 	}
@@ -5555,6 +5880,8 @@ static int btf_add_distilled_type_ids(struct btf_distill *dist, __u32 i)
 		case BTF_KIND_VOLATILE:
 		case BTF_KIND_FUNC_PROTO:
 		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
 			dist->id_map[*id] = *id;
 			break;
 		default:
@@ -5580,12 +5907,11 @@ static int btf_add_distilled_type_ids(struct btf_distill *dist, __u32 i)
 
 static int btf_add_distilled_types(struct btf_distill *dist)
 {
-	bool adding_to_base = dist->pipe.dst->start_id == 1;
+	bool adding_to_base = dist->pipe.dst->base_btf == NULL;
 	int id = btf__type_cnt(dist->pipe.dst);
 	struct btf_type *t;
 	int i, err = 0;
 
-
 	/* Add types for each of the required references to either distilled
 	 * base or split BTF, depending on type characteristics.
 	 */
@@ -5650,6 +5976,9 @@ static int btf_add_distilled_types(struct btf_distill *dist)
 		case BTF_KIND_VOLATILE:
 		case BTF_KIND_FUNC_PROTO:
 		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
+		case BTF_KIND_LOCSEC:
 			/* All other types are added to split BTF. */
 			if (adding_to_base)
 				continue;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..0f55518a2be0 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -247,6 +247,18 @@ LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_typ
 LIBBPF_API int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
 				  int component_idx);
 
+LIBBPF_API int btf__add_loc_param(struct btf *btf, __s32 size, bool is_value, __u64 value,
+				  __u16 reg, __u16 flags, __s32 offset);
+
+LIBBPF_API int btf__add_loc_proto(struct btf *btf);
+
+LIBBPF_API int btf__add_loc_proto_param(struct btf *btf, __u32 id);
+
+LIBBPF_API int btf__add_locsec(struct btf *btf, const char *name);
+
+LIBBPF_API int btf__add_locsec_loc(struct btf *btf, const char *name, __u32 func_proto,
+				   __u32 loc_proto, __u32 offset);
+
 struct btf_dedup_opts {
 	size_t sz;
 	/* optional .BTF.ext info to dedup along the main BTF info */
@@ -360,6 +372,42 @@ btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 #define BTF_KIND_TYPE_TAG	18	/* Type Tag */
 #define BTF_KIND_ENUM64		19	/* Enum for up-to 64bit values */
 
+#ifndef BTF_KIND_LOC_UAPI_DEFINED
+#define BTF_KIND_LOC_LIBBPF_DEFINED
+#define BTF_KIND_LOC_PARAM	20
+#define BTF_KIND_LOC_PROTO	21
+#define BTF_KIND_LOCSEC		22
+
+#define BTF_TYPE_LOC_PARAM_SIZE(t)	((__s32)((t)->size))
+#define BTF_LOC_FLAG_DEREF		0x1
+#define BTF_LOC_FLAG_CONTINUE		0x2
+
+struct btf_loc_param {
+	union {
+		struct {
+			__u16 reg;	/* register number */
+			__u16 flags;	/* register dereference */
+			__s32 offset;	/* offset from register-stored address */
+		};
+		struct {
+			__u32 val_lo32;	/* lo 32 bits of 64-bit value */
+			__u32 val_hi32;	/* hi 32 bits of 64-bit value */
+		};
+	};
+};
+
+struct btf_loc {
+	__u32 name_off;
+	__u32 func_proto;
+	__u32 loc_proto;
+	__u32 offset;
+};
+
+#else
+struct btf_loc_param;
+struct btf_loc;
+#endif
+
 static inline __u16 btf_kind(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info);
@@ -497,6 +545,21 @@ static inline bool btf_is_any_enum(const struct btf_type *t)
 	return btf_is_enum(t) || btf_is_enum64(t);
 }
 
+static inline bool btf_is_loc_param(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_LOC_PARAM;
+}
+
+static inline bool btf_is_loc_proto(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_LOC_PROTO;
+}
+
+static inline bool btf_is_locsec(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_LOCSEC;
+}
+
 static inline bool btf_kind_core_compat(const struct btf_type *t1,
 					const struct btf_type *t2)
 {
@@ -611,6 +674,33 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 	return (struct btf_decl_tag *)(t + 1);
 }
 
+static inline struct btf_loc_param *btf_loc_param(const struct btf_type *t)
+{
+	return (struct btf_loc_param *)(t + 1);
+}
+
+static inline __s32 btf_loc_param_size(const struct btf_type *t)
+{
+	return (__s32)t->size;
+}
+
+static inline __u64 btf_loc_param_value(const struct btf_type *t)
+{
+	struct btf_loc_param *p = btf_loc_param(t);
+
+	return p->val_lo32 | (((__u64)(p->val_hi32)) << 32);
+}
+
+static inline __u32 *btf_loc_proto_params(const struct btf_type *t)
+{
+	return (__u32 *)(t + 1);
+}
+
+static inline struct btf_loc *btf_locsec_locs(const struct btf_type *t)
+{
+	return (struct btf_loc *)(t + 1);
+}
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 6388392f49a0..95bdda2f4a2d 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -328,6 +328,9 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 		case BTF_KIND_ENUM64:
 		case BTF_KIND_FWD:
 		case BTF_KIND_FLOAT:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
+		case BTF_KIND_LOCSEC:
 			break;
 
 		case BTF_KIND_VOLATILE:
@@ -339,7 +342,6 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 		case BTF_KIND_VAR:
 		case BTF_KIND_DECL_TAG:
 		case BTF_KIND_TYPE_TAG:
-			d->type_states[t->type].referenced = 1;
 			break;
 
 		case BTF_KIND_ARRAY: {
@@ -609,6 +611,9 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 	case BTF_KIND_VAR:
 	case BTF_KIND_DATASEC:
 	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_LOC_PARAM:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
 		d->type_states[id].order_state = ORDERED;
 		return 0;
 
@@ -2516,6 +2521,9 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
 	case BTF_KIND_FUNC:
 	case BTF_KIND_FUNC_PROTO:
 	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_LOC_PARAM:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
 		err = btf_dump_unsupported_data(d, t, id);
 		break;
 	case BTF_KIND_INT:
diff --git a/tools/lib/bpf/btf_iter.c b/tools/lib/bpf/btf_iter.c
index 9a6c822c2294..e9a865d84d35 100644
--- a/tools/lib/bpf/btf_iter.c
+++ b/tools/lib/bpf/btf_iter.c
@@ -29,6 +29,7 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 		case BTF_KIND_FLOAT:
 		case BTF_KIND_ENUM:
 		case BTF_KIND_ENUM64:
+		case BTF_KIND_LOC_PARAM:
 			it->desc = (struct btf_field_desc) {};
 			break;
 		case BTF_KIND_FWD:
@@ -71,6 +72,19 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 				1, {offsetof(struct btf_var_secinfo, type)}
 			};
 			break;
+		case BTF_KIND_LOC_PROTO:
+			it->desc = (struct btf_field_desc) {
+				0, {},
+				sizeof(__u32),
+				1, {0}};
+			break;
+		case BTF_KIND_LOCSEC:
+			it->desc = (struct btf_field_desc) {
+				0, {},
+				sizeof(struct btf_loc),
+				2, {offsetof(struct btf_loc, func_proto),
+				    offsetof(struct btf_loc, loc_proto)}};
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -94,6 +108,8 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 		case BTF_KIND_DECL_TAG:
 		case BTF_KIND_TYPE_TAG:
 		case BTF_KIND_DATASEC:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
 			it->desc = (struct btf_field_desc) {
 				1, {offsetof(struct btf_type, name_off)}
 			};
@@ -127,6 +143,13 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 				1, {offsetof(struct btf_param, name_off)}
 			};
 			break;
+		case BTF_KIND_LOCSEC:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)},
+				sizeof(struct btf_loc),
+				1, {offsetof(struct btf_loc, name_off)}
+			};
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..82a0d2ff1176 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,9 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		btf__add_loc_param;
+		btf__add_loc_proto;
+		btf__add_loc_proto_param;
+		btf__add_locsec;
+		btf__add_locsec_loc;
 } LIBBPF_1.6.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 35b2527bedec..2a05518265e9 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -562,7 +562,9 @@ struct btf_field_desc {
 	/* member struct size, or zero, if no members */
 	int m_sz;
 	/* repeated per-member offsets */
-	int m_off_cnt, m_offs[1];
+	int m_off_cnt, m_offs[2];
+	/* singular entity size after btf_type, if any */
+	int s_sz;
 };
 
 struct btf_field_iter {
-- 
2.39.3


