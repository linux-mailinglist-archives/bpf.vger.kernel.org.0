Return-Path: <bpf+bounces-27701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80648B0F0E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749551F22253
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215A16D4CB;
	Wed, 24 Apr 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QrjTMqfq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBF16D331
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973770; cv=none; b=B2w2R2e3k1q9P6ydhQEzmP7ZNb/HKsw9iKY3X9g0oGuMYOHQAU3tCM9EJeAq8fM9kp26v5+degbx6tZDLzCIWRaHurp+8U47x4HhKfr86Jbsn8p5WDSRu2KEZCVJKs5EU0m2qzRtWojohKcMucG/eZ2x9RZ6ncnegA9eSFAL3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973770; c=relaxed/simple;
	bh=pZztmVu8zS5kervyHu37bsZxkSjnkz1FIaFrGhz0SSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDNFRyh/QCYqcmDOqNsUD6d/Au/s6bA2XwEc3bBS4uXyR2ycpp2TH3+Z8WiU7kYdK6nI//7x1JSRtdA9ew1cYCq9oB91gXjwi/aKQOcDZjnJp9/tVqgdY7+U0reV5W2dIdCzLKwwcjzM/gPe+P7zyM+qIaF1+CWH9CAricUHPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QrjTMqfq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OA1QhY019778;
	Wed, 24 Apr 2024 15:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=aJmH1aYmvtMWnal5SxOHpzObLhEb3vLt5zmQ92QRkgo=;
 b=QrjTMqfqCkhauu2ZHX59QIKJoBfdNxU+Z10KDjmlDwthoR6k1wN0pGbB6+D6vgA1fx0K
 WhLWAdkwU51JBB9foMKMS2+raemKYFnPUourjoDUXE1MuvXtwAdogYHpqCD+U2cXgv6y
 XMysd9T4nzFV8Diwk9LXjvzGkFXkyJcMnnnEBBuPdKwJg6b66Zjh1IxZCmnXfmmbjOSR
 QbNYmeYsF2WoZ0Kp+zMFvpAMvQpo+nA9+EC5KgzNmuApZJLf3q1JZV6nYWqM7cetibqg
 pVj/rUeyDhk9VWiFjh8PRKv5UzIjDoHXfLem8NNIcGgaHRYuG9smzHfVBdqMId7oKmh4 Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md97p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OEguER025273;
	Wed, 24 Apr 2024 15:48:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fb0ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:58 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCog008769;
	Wed, 24 Apr 2024 15:48:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-10;
	Wed, 24 Apr 2024 15:48:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 09/13] libbpf: split BTF relocation
Date: Wed, 24 Apr 2024 16:48:02 +0100
Message-Id: <20240424154806.3417662-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-ORIG-GUID: 8m0wzbshmhVps650oDzO_n-cE0SrR52D
X-Proofpoint-GUID: 8m0wzbshmhVps650oDzO_n-cE0SrR52D

Map distilled base BTF type ids referenced in split BTF and their
references to the base BTF passed in, and if the mapping succeeds,
reparent the split BTF to the base BTF.

Relocation rules are

- base types must match exactly
- enum[64] types should match all value name/value pairs, but the
  to-be-relocated enum[64] can also define additional name/value pairs
- an enum64 can match an enum and vice versa provided the values match
  as described above
- named fwds match to the correspondingly-named struct/union/enum/enum64
- structs with no members match to the correspondingly-named struct/union
  provided their sizes match
- anon struct/unions must have field names/offsets specified in base
  reference BTF matched by those in base BTF we are matching with

Relocation can not recurse, since it will be used in-kernel also and
we do not want to blow up the kernel stack when carrying out type
compatibility checks.  Hence we use a stack for reference type
relocation rather then recursive function calls.  The approach however
is the same; we use a depth-first search to match the referents
associated with reference types, and work back from there to match
the reference type itself.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/btf.c             |  58 +++
 tools/lib/bpf/btf.h             |   8 +
 tools/lib/bpf/btf_relocate.c    | 601 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |   2 +
 6 files changed, 671 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/bpf/btf_relocate.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index b6619199a706..336da6844d42 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o features.o
+	    usdt.o zip.o elf.o features.o btf_relocate.o
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9036c1dc45d0..f00a84fea9b5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5541,3 +5541,61 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
 	errno = -ret;
 	return ret;
 }
+
+struct btf_rewrite_strs {
+	struct btf *btf;
+	const struct btf *old_base_btf;
+	int str_start;
+	int str_diff;
+};
+
+static int btf_rewrite_strs(__u32 *str_off, void *ctx)
+{
+	struct btf_rewrite_strs *r = ctx;
+	const char *s;
+	int off;
+
+	if (!*str_off)
+		return 0;
+	if (*str_off >= r->str_start) {
+		*str_off += r->str_diff;
+	} else {
+		s = btf__str_by_offset(r->old_base_btf, *str_off);
+		if (!s)
+			return -ENOENT;
+		off = btf__add_str(r->btf, s);
+		if (off < 0)
+			return off;
+		*str_off = off;
+	}
+	return 0;
+}
+
+int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
+{
+	struct btf_rewrite_strs r = {};
+	struct btf_type *t;
+	int i, err;
+
+	r.old_base_btf = btf__base_btf(btf);
+	if (!r.old_base_btf)
+		return -EINVAL;
+	r.btf = btf;
+	r.str_start = r.old_base_btf->hdr->str_len;
+	r.str_diff = base_btf->hdr->str_len - r.old_base_btf->hdr->str_len;
+	btf->base_btf = base_btf;
+	btf->start_id = btf__type_cnt(base_btf);
+	btf->start_str_off = base_btf->hdr->str_len;
+	for (i = 0; i < btf->nr_types; i++) {
+		t = (struct btf_type *)btf__type_by_id(btf, i + btf->start_id);
+		err = btf_type_visit_str_offs(t, btf_rewrite_strs, &r);
+		if (err)
+			break;
+	}
+	return err;
+}
+
+int btf__relocate(struct btf *btf, const struct btf *base_btf)
+{
+	return btf_relocate(btf, base_btf, NULL);
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 94dfdfdef617..00e885998ba1 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -284,6 +284,14 @@ struct btf_dedup_opts {
 
 LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
 
+/**
+ * @brief **btf__relocate()** will check the split BTF *btf* for references
+ * to base BTF kinds, and verify those references are compatible with
+ * *base_btf*; if they are, *btf* is adjusted such that is re-parented to
+ * *base_btf* and type ids and strings are adjusted to accommodate this.
+ */
+LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf);
+
 struct btf_dump;
 
 struct btf_dump_opts {
diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
new file mode 100644
index 000000000000..d9340375f4a3
--- /dev/null
+++ b/tools/lib/bpf/btf_relocate.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include "btf.h"
+#include "bpf.h"
+#include "libbpf.h"
+#include "libbpf_internal.h"
+
+struct btf;
+
+#define BTF_MAX_NR_TYPES 0x7fffffffU
+#define BTF_UNPROCESSED_ID ((__u32)-1)
+
+struct btf_relocate {
+	struct btf *btf;
+	const struct btf *base_btf;
+	const struct btf *dist_base_btf;
+	unsigned int nr_base_types;
+	__u32 *map;
+	__u32 *stack;
+	unsigned int stack_size;
+	unsigned int stack_limit;
+};
+
+/* Find next type after *id in base BTF that matches kind of type t passed in
+ * and name (if it is specified).  Match fwd kinds to appropriate kind also.
+ */
+static int btf_relocate_find_next(struct btf_relocate *r, const struct btf_type *t,
+				   __u32 *id, const struct btf_type **tp)
+{
+	const struct btf_type *nt;
+	int kind, tkind = btf_kind(t);
+	int tkflag = btf_kflag(t);
+	__u32 i;
+
+	for (i = *id + 1; i < r->nr_base_types; i++) {
+		nt = btf__type_by_id(r->base_btf, i);
+		kind = btf_kind(nt);
+		/* enum[64] can match either enum or enum64;
+		 * a fwd can match a struct/union of the appropriate
+		 * type; otherwise kinds must match.
+		 */
+		switch (tkind) {
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			switch (kind) {
+			case BTF_KIND_ENUM64:
+			case BTF_KIND_ENUM:
+				break;
+			default:
+				continue;
+			}
+			break;
+		case BTF_KIND_FWD:
+			switch (kind) {
+			case BTF_KIND_FWD:
+				continue;
+			case BTF_KIND_STRUCT:
+				if (tkflag)
+					continue;
+				break;
+			case BTF_KIND_UNION:
+				if (!tkflag)
+					continue;
+				break;
+			default:
+				break;
+			}
+			break;
+		default:
+			if (kind != tkind)
+				continue;
+			break;
+		}
+		/* either names must match or both be anon. */
+		if (t->name_off && nt->name_off) {
+			if (strcmp(btf__name_by_offset(r->btf, t->name_off),
+				   btf__name_by_offset(r->base_btf, nt->name_off)))
+				continue;
+		} else if (t->name_off != nt->name_off) {
+			continue;
+		}
+		*tp = nt;
+		*id = i;
+		return 0;
+	}
+	return -ENOENT;
+}
+
+static int btf_relocate_int(struct btf_relocate *r, const char *name,
+			     const struct btf_type *t, const struct btf_type *bt)
+{
+	__u8 encoding, bencoding, bits, bbits;
+
+	if (t->size != bt->size) {
+		pr_warn("INT types '%s' disagree on size; distilled base BTF says %d; base BTF says %d\n",
+			name, t->size, bt->size);
+		return -EINVAL;
+	}
+	encoding = btf_int_encoding(t);
+	bencoding = btf_int_encoding(bt);
+	if (encoding != bencoding) {
+		pr_warn("INT types '%s' disagree on encoding; distilled base BTF says '(%s/%s/%s); base BTF says '(%s/%s/%s)'\n",
+			name,
+			encoding & BTF_INT_SIGNED ? "signed" : "unsigned",
+			encoding & BTF_INT_CHAR ? "char" : "nonchar",
+			encoding & BTF_INT_BOOL ? "bool" : "nonbool",
+			bencoding & BTF_INT_SIGNED ? "signed" : "unsigned",
+			bencoding & BTF_INT_CHAR ? "char" : "nonchar",
+			bencoding & BTF_INT_BOOL ? "bool" : "nonbool");
+		return -EINVAL;
+	}
+	bits = btf_int_bits(t);
+	bbits = btf_int_bits(bt);
+	if (bits != bbits) {
+		pr_warn("INT types '%s' disagree on bit size; distilled base BTF says %d; base BTF says %d\n",
+			name, bits, bbits);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int btf_relocate_float(struct btf_relocate *r, const char *name,
+			       const struct btf_type *t, const struct btf_type *bt)
+{
+
+	if (t->size != bt->size) {
+		pr_warn("float types '%s' disagree on size; distilled base BTF says %d; base BTF says %d\n",
+			name, t->size, bt->size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* ensure each enum[64] value in type t has equivalent in base BTF and that
+ * values match; we must support matching enum64 to enum and vice versa
+ * as well as enum to enum and enum64 to enum64.
+ */
+static int btf_relocate_enum(struct btf_relocate *r, const char *name,
+			      const struct btf_type *t, const struct btf_type *bt)
+{
+	struct btf_enum *v = btf_enum(t);
+	struct btf_enum *bv = btf_enum(bt);
+	struct btf_enum64 *v64 = btf_enum64(t);
+	struct btf_enum64 *bv64 = btf_enum64(bt);
+	bool found, match, bisenum, isenum;
+	const char *vname, *bvname;
+	__u32 name_off, bname_off;
+	__u64 val = 0, bval = 0;
+	int i, j;
+
+	isenum = btf_kind(t) == BTF_KIND_ENUM;
+	for (i = 0; i < btf_vlen(t); i++, v++, v64++) {
+		found = match = false;
+
+		if (isenum) {
+			name_off = v->name_off;
+			val = v->val;
+		} else {
+			name_off = v64->name_off;
+			val = btf_enum64_value(v64);
+		}
+		if (!name_off)
+			continue;
+		vname = btf__name_by_offset(r->dist_base_btf, name_off);
+
+		bisenum = btf_kind(bt) == BTF_KIND_ENUM;
+		for (j = 0; j < btf_vlen(bt); j++, bv++, bv64++) {
+			if (bisenum) {
+				bname_off = bv->name_off;
+				bval = bv->val;
+			} else {
+				bname_off = bv64->name_off;
+				bval = btf_enum64_value(bv64);
+			}
+			if (!bname_off)
+				continue;
+			bvname = btf__name_by_offset(r->base_btf, bname_off);
+			if (strcmp(vname, bvname) != 0)
+				continue;
+			found = true;
+			match = val == bval;
+			break;
+		}
+		if (!found) {
+			if (t->name_off)
+				pr_warn("ENUM[64] types '%s' disagree; distilled base BTF has enum[64] value '%s' (%lld), base BTF does not have that value.\n",
+					name, vname, val);
+			return -EINVAL;
+		}
+		if (!match) {
+			if (t->name_off)
+				pr_warn("ENUM[64] types '%s' disagree on enum value '%s'; distilled base BTF specifies value %lld; base BTF specifies value %lld\n",
+					name, vname, val, bval);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* relocate base types (int, float, enum, enum64 and fwd) */
+static int btf_relocate_base_type(struct btf_relocate *r, __u32 id)
+{
+	const struct btf_type *t = btf_type_by_id(r->dist_base_btf, id);
+	const char *name = btf__name_by_offset(r->dist_base_btf, t->name_off);
+	const struct btf_type *bt = NULL;
+	__u32 base_id = 0;
+	int err = 0;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_INT:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_ENUM64:
+	case BTF_KIND_FWD:
+		break;
+	default:
+		return 0;
+	}
+
+	if (r->map[id] <= BTF_MAX_NR_TYPES)
+		return 0;
+
+	while ((err = btf_relocate_find_next(r, t, &base_id, &bt)) != -ENOENT) {
+		bt = btf_type_by_id(r->base_btf, base_id);
+		switch (btf_kind(t)) {
+		case BTF_KIND_INT:
+			err = btf_relocate_int(r, name, t, bt);
+			break;
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			err = btf_relocate_enum(r, name, t, bt);
+			break;
+		case BTF_KIND_FLOAT:
+			err = btf_relocate_float(r, name, t, bt);
+			break;
+		case BTF_KIND_FWD:
+			err = 0;
+			break;
+		default:
+			return 0;
+		}
+		if (!err) {
+			r->map[id] = base_id;
+			return 0;
+		}
+	}
+	return err;
+}
+
+/* all distilled base BTF members must be in base BTF equivalent. */
+static int btf_relocate_check_member(struct btf_relocate *r, const char *name,
+				      struct btf_member *m, const struct btf_type *bt,
+				      bool verbose)
+{
+	struct btf_member *bm = (struct btf_member *)(bt + 1);
+	const char *kindstr = btf_kind(bt) == BTF_KIND_STRUCT ? "STRUCT" : "UNION";
+	const char *mname, *bmname;
+	int i, bvlen = btf_vlen(bt);
+
+	mname = btf__name_by_offset(r->dist_base_btf, m->name_off);
+	for (i = 0; i < bvlen; i++, bm++) {
+		bmname = btf__name_by_offset(r->base_btf, bm->name_off);
+
+		if (!m->name_off || !bm->name_off) {
+			if (m->name_off != bm->name_off)
+				continue;
+			if (bm->offset != m->offset)
+				continue;
+		} else {
+			if (strcmp(mname, bmname) != 0)
+				continue;
+			if (bm->offset != m->offset) {
+				if (verbose) {
+					pr_warn("%s '%s' member '%s' disagrees about offset; %d in distilled base BTF versus %d in base BTF\n",
+						kindstr, name, mname, bm->offset, m->offset);
+					return -EINVAL;
+				}
+			}
+		}
+		return 0;
+	}
+	if (verbose)
+		pr_warn("%s '%s' missing member '%s' found in distilled base BTF\n",
+			kindstr, name, mname);
+	return -EINVAL;
+}
+
+static int btf_relocate_struct_type(struct btf_relocate *r, __u32 id)
+{
+	const struct btf_type *t = btf_type_by_id(r->dist_base_btf, id);
+	const char *name = btf__name_by_offset(r->dist_base_btf, t->name_off);
+	const struct btf_type *bt = NULL;
+	struct btf_member *m;
+	const char *kindstr;
+	int i, vlen, err = 0;
+	__u32 base_id = 0;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_STRUCT:
+		kindstr = "STRUCT";
+		break;
+	case BTF_KIND_UNION:
+		kindstr = "UNION";
+		break;
+	default:
+		return 0;
+	}
+
+	if (r->map[id] <= BTF_MAX_NR_TYPES)
+		return 0;
+
+	vlen = btf_vlen(t);
+
+	while ((err = btf_relocate_find_next(r, t, &base_id, &bt)) != -ENOENT) {
+		/* vlen 0 named types (signalling type is embedded in
+		 * a split BTF struct/union) must match size exactly
+		 */
+		if (t->name_off && vlen == 0) {
+			if (bt->size != t->size) {
+				pr_warn("%s '%s' disagrees about size; is size (%d) in distilled base BTF; in base BTF it is size (%d)\n",
+					kindstr, name, t->size, bt->size);
+				return -EINVAL;
+			}
+		}
+		/* otherwise must be at least as big */
+		if (bt->size < t->size) {
+			if (t->name_off) {
+				pr_warn("%s '%s' disagrees about size with distilled base BTF (%d); base BTF is smaller (%d)\n",
+					kindstr, name, t->size, bt->size);
+				return -EINVAL;
+			}
+			continue;
+		}
+		/* must have at least as many elements */
+		if (btf_vlen(bt) < vlen) {
+			if (t->name_off) {
+				pr_warn("%s '%s' disagrees about number of members with distilled base BTF (%d); base BTF has less (%d)\n",
+					kindstr, name, vlen, btf_vlen(bt));
+				return -EINVAL;
+			}
+			continue;
+		}
+		m = (struct btf_member *)(t + 1);
+		for (i = 0; i < vlen; i++, m++) {
+			if (btf_relocate_check_member(r, name, m, bt, t->name_off != 0)) {
+				if (t->name_off)
+					return -EINVAL;
+				err = -EINVAL;
+				break;
+			}
+		}
+		if (!err) {
+			r->map[id] = base_id;
+			return 0;
+		}
+	}
+	return err;
+}
+
+/* Use a stack rather than recursion to manage dependent reference types.
+ * When a reference type with dependents is encountered, the approach we
+ * take depends on whether the dependents have been resolved to base
+ * BTF references via the map[].  If they all have, we can simply search
+ * for the base BTF type that has those references.  If the references
+ * are not resolved, we need to push the type and its dependents onto
+ * the stack for later resolution.  We first pop the dependents, and
+ * once these have been resolved we pop the reference type with dependents
+ * now resolved.
+ */
+static int btf_relocate_push(struct btf_relocate *r, __u32 id)
+{
+	if (r->stack_size >= r->stack_limit)
+		return -ENOSPC;
+	r->stack[r->stack_size++] = id;
+	return 0;
+}
+
+static __u32 btf_relocate_pop(struct btf_relocate *r)
+{
+	if (r->stack_size > 0)
+		return r->stack[--r->stack_size];
+	return BTF_UNPROCESSED_ID;
+}
+
+static int btf_relocate_ref_type(struct btf_relocate *r, __u32 id)
+{
+	const struct btf_type *t;
+	const struct btf_type *bt;
+	__u32 base_id;
+	int err = 0;
+
+	do {
+		if (r->map[id] <= BTF_MAX_NR_TYPES)
+			continue;
+		t = btf_type_by_id(r->dist_base_btf, id);
+		switch (btf_kind(t)) {
+		case BTF_KIND_CONST:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_PTR:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_FUNC:
+		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_DECL_TAG:
+			if (r->map[t->type] <= BTF_MAX_NR_TYPES) {
+				bt = NULL;
+				base_id = 0;
+				while ((err = btf_relocate_find_next(r, t, &base_id, &bt))
+				       != -ENOENT) {
+					if (btf_kind(t) == BTF_KIND_DECL_TAG) {
+						if (btf_decl_tag(t) != btf_decl_tag(bt))
+							continue;
+					}
+					if (bt->type != r->map[t->type])
+						continue;
+					r->map[id] = base_id;
+					break;
+				}
+				if (err) {
+					pr_warn("could not find base BTF type for distilled base BTF type[%u]\n",
+						id);
+					return err;
+				}
+			} else {
+				if (btf_relocate_push(r, id) < 0 ||
+				    btf_relocate_push(r, t->type) < 0)
+					return -ENOSPC;
+			}
+			break;
+		case BTF_KIND_ARRAY: {
+			struct btf_array *ba, *a = btf_array(t);
+
+			if (r->map[a->type] <= BTF_MAX_NR_TYPES &&
+			    r->map[a->index_type] <= BTF_MAX_NR_TYPES) {
+				bt = NULL;
+				base_id = 0;
+				while ((err = btf_relocate_find_next(r, t, &base_id, &bt))
+				       != -ENOENT) {
+					ba = btf_array(bt);
+					if (a->nelems != ba->nelems ||
+					    r->map[a->type] != ba->type ||
+					    r->map[a->index_type] != ba->index_type)
+						continue;
+					r->map[id] = base_id;
+					break;
+				}
+				if (err) {
+					pr_warn("could not matching find base BTF ARRAY for distilled base BTF ARRAY[%u]\n",
+						id);
+					return err;
+				}
+			} else {
+				if (btf_relocate_push(r, id) < 0 ||
+				    btf_relocate_push(r, a->type) < 0 ||
+				    btf_relocate_push(r, a->index_type) < 0)
+					return -ENOSPC;
+			}
+			break;
+		}
+		case BTF_KIND_FUNC_PROTO: {
+			struct btf_param *p = btf_params(t);
+			int i, vlen = btf_vlen(t);
+
+			for (i = 0; i < vlen; i++, p++) {
+				if (r->map[p->type] > BTF_MAX_NR_TYPES)
+					break;
+			}
+			if (i == vlen && r->map[t->type] <= BTF_MAX_NR_TYPES) {
+				bt = NULL;
+				base_id = 0;
+				while ((err = btf_relocate_find_next(r, t, &base_id, &bt))
+				       != -ENOENT) {
+					struct btf_param *bp = btf_params(bt);
+					int bvlen = btf_vlen(bt);
+					int j;
+
+					if (bvlen != vlen)
+						continue;
+					if (r->map[t->type] != bt->type)
+						continue;
+					for (j = 0, p = btf_params(t); j < bvlen; j++, bp++, p++) {
+						if (r->map[p->type] != bp->type)
+							break;
+					}
+					if (j < bvlen)
+						continue;
+					r->map[id] = base_id;
+					break;
+				}
+				if (err) {
+					pr_warn("could not find matching base BTF FUNC_PROTO for distilled base BTF FUNC_PROTO[%u]\n",
+						id);
+					return err;
+				}
+			} else {
+				if (btf_relocate_push(r, id) < 0 ||
+				    btf_relocate_push(r, t->type) < 0)
+					return -ENOSPC;
+				for (i = 0, p = btf_params(t); i < btf_vlen(t); i++, p++) {
+					if (btf_relocate_push(r, p->type) < 0)
+						return -ENOSPC;
+				}
+			}
+			break;
+		}
+		default:
+			return -EINVAL;
+		}
+	} while ((id = btf_relocate_pop(r)) <= BTF_MAX_NR_TYPES);
+
+	return 0;
+}
+
+static int btf_relocate_rewrite_type_id(__u32 *id, void *ctx)
+{
+	struct btf_relocate *r = ctx;
+
+	*id = r->map[*id];
+	return 0;
+}
+
+/* If successful, output of relocation is updated BTF with base BTF pointing
+ * at base_btf, and type ids, strings adjusted accordingly
+ */
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids)
+{
+	const struct btf *dist_base_btf = btf__base_btf(btf);
+	unsigned int nr_split_types, nr_dist_base_types;
+	unsigned int nr_types = btf__type_cnt(btf);
+	struct btf_relocate r = {};
+	const struct btf_type *t;
+	int diff_id, err = 0;
+	__u32 id, i;
+
+	if (!base_btf || dist_base_btf == base_btf)
+		return 0;
+
+	nr_dist_base_types = btf__type_cnt(dist_base_btf);
+	r.nr_base_types = btf__type_cnt(base_btf);
+	nr_split_types = nr_types - nr_dist_base_types;
+	r.map = calloc(nr_types, sizeof(*r.map));
+	r.stack_limit = nr_dist_base_types;
+	r.stack = calloc(r.stack_limit, sizeof(*r.stack));
+	if (!r.map || !r.stack) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	diff_id = r.nr_base_types - nr_dist_base_types;
+	for (id = 1; id < nr_dist_base_types; id++)
+		r.map[id] = BTF_UNPROCESSED_ID;
+	for (id = nr_dist_base_types; id < nr_types; id++)
+		r.map[id] = id + diff_id;
+
+	r.btf = btf;
+	r.dist_base_btf = dist_base_btf;
+	r.base_btf = base_btf;
+
+	/* Build a map from base references to actual base BTF ids; it is used
+	 * to track the state of comparisons.  First map base types and fwds,
+	 * next structs/unions, and finally reference types (const, restrict,
+	 * ptr, array, func, func_proto etc).
+	 */
+	for (id = 1; id < nr_dist_base_types; id++) {
+		err = btf_relocate_base_type(&r, id);
+		if (err)
+			goto err_out;
+	}
+	for (id = 1; id < nr_dist_base_types; id++) {
+		err = btf_relocate_struct_type(&r, id);
+		if (err)
+			goto err_out;
+	}
+	for (id = 1; id < nr_dist_base_types; id++) {
+		err = btf_relocate_ref_type(&r, id);
+		if (err)
+			goto err_out;
+	}
+	/* Next, rewrite type ids in split BTF, replacing split ids with updated
+	 * ids based on number of types in base BTF, and base ids with
+	 * relocated ids from base_btf.
+	 */
+	for (i = 0, id = nr_dist_base_types; i < nr_split_types; i++, id++) {
+		t = btf__type_by_id(btf, id);
+		err = btf_type_visit_type_ids((struct btf_type *)t,
+					      btf_relocate_rewrite_type_id, &r);
+		if (err)
+			goto err_out;
+	}
+	/* Finally reset base BTF to base_btf; as part of this operation, string
+	 * offsets are also updated, and we are done.
+	 */
+	err = btf_set_base_btf(r.btf, (struct btf *)r.base_btf);
+err_out:
+	if (!err && map_ids)
+		*map_ids = r.map;
+	else
+		free(r.map);
+	free(r.stack);
+	return err;
+}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a9151e31dfa9..b245350f456c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -422,6 +422,7 @@ LIBBPF_1.5.0 {
 		bpf_program__attach_sockmap;
 		btf__distill_base;
 		btf__parse_opts;
+		btf__relocate;
 		ring__consume_n;
 		ring_buffer__consume_n;
 } LIBBPF_1.4.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index a0dcfb82e455..e38e1b01e86e 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -234,6 +234,8 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+int btf_set_base_btf(struct btf *btf, struct btf *base_btf);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.31.1


