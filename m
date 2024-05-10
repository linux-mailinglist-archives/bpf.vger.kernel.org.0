Return-Path: <bpf+bounces-29457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE298C2234
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595A2B23361
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26378150998;
	Fri, 10 May 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jliKIwL4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB917FBDA
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337194; cv=none; b=hvsYEXC/9eQ0vguItXSiu7zwI5lrUzhqxfWBENOMy52Z5z0Si08YyX1/1ZbmxpQsNYbQSSnLvL7J6ObeyhelQ/vK2x7QdJHtcuCYRgW5NCbtZib1d57DIMVO3OtelFV3HMlKeEOU9+yOCzAqPYFnseNZR04GpjIqS4fcu5L6OAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337194; c=relaxed/simple;
	bh=9DK92P5f8nQGX2U7cJ7RiJxx/xJ/PD7fwSg01su+Eyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NS26KQ4XUWrg/P4lUUUVEAU2TYf2WaueM2sazSM1YuH/001swQUlrFC793XvVPWnhLRcV/AbuXp8p2fOTB0nD2+sVqgkE/f/liq5TT/DlL2hWVmq1tQV/50xI4IkVBaIzTXDHpW0uzo8Og2tCrFEMt/Y4ode/0wCMX+SQw/VnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jliKIwL4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AAWHoX012274;
	Fri, 10 May 2024 10:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=cAIqpD2xcEzIfOhdfFUDXI5xF/b+gVID+5C3LF9kfhk=;
 b=jliKIwL4Okh6WT78Oc9tzYO6lvEfQh1m3RjpqOFGPCBpmOGRQJbpl/cXkByY0t6jwt/2
 452egQBKlncRXy5SCtUw7nOoGtI6prxo1hYqlsZYLPudJEvqwnE9RJQr4puXD6wUWgLS
 xtHDJZUI6T/KiRzo9luo9656wObjJDmoxn6pTmgN3P9ydMSZF93Iha7BiM75GcaZSeTl
 gXNnRuo/hNkWVMflFLiPX98xzcLIDr5SmykhrxmBC3qYTUEUf3JInBRChhIsY+9pbwuL
 8+cOT6RYMW53hhmknvnNxNfxNvzfm79huEnGiJW1jORRIKFSITmPhoOBv+QxaVLqPYNq MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1dfsrkdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:32:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A98bib019108;
	Fri, 10 May 2024 10:31:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpcn41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAV0hf011786;
	Fri, 10 May 2024 10:31:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-199.vpn.oracle.com [10.175.161.199])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpcm4p-8;
	Fri, 10 May 2024 10:31:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 07/11] libbpf: split BTF relocation
Date: Fri, 10 May 2024 11:30:48 +0100
Message-Id: <20240510103052.850012-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240510103052.850012-1-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100074
X-Proofpoint-GUID: P-Zu09S7bgsDtxD7MGPrEsaqjncxbLjg
X-Proofpoint-ORIG-GUID: P-Zu09S7bgsDtxD7MGPrEsaqjncxbLjg

Map distilled base BTF type ids referenced in split BTF and their
references to the base BTF passed in, and if the mapping succeeds,
reparent the split BTF to the base BTF.

Relocation is done by first verifying that distilled base BTF
only consists of named INT, FLOAT, ENUM, FWD, STRUCT and
UNION kinds; then we sort these to speed lookups.  Once sorted,
the base BTF is iterated, and for each relevant kind we check
for an equivalent in distilled base BTF.  When found, the
mapping from distilled -> base BTF id is recorded.

Once all mappings are established, we can update type ids in
split BTF and reparent it to the new base.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/btf.c             |  59 +++++++
 tools/lib/bpf/btf.h             |   8 +
 tools/lib/bpf/btf_relocate.c    | 264 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |   2 +
 6 files changed, 335 insertions(+), 1 deletion(-)
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
index 1eb66a7a4c46..16bb1c538fa7 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5563,3 +5563,62 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
 	btf__free(new_base);
 	return libbpf_err(err);
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
+
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
index 8e1702ad5ef4..f75db650e426 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -282,6 +282,14 @@ struct btf_dedup_opts {
 
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
index 000000000000..54949975398b
--- /dev/null
+++ b/tools/lib/bpf/btf_relocate.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include "btf.h"
+#include "bpf.h"
+#include "libbpf.h"
+#include "libbpf_internal.h"
+
+struct btf;
+
+struct btf_relocate {
+	__u32 search_id;				/* must be first field; see search below */
+	struct btf *btf;
+	const struct btf *base_btf;
+	const struct btf *dist_base_btf;
+	unsigned int nr_base_types;
+	unsigned int nr_dist_base_types;
+	__u32 *map;
+	__u32 *dist_base_index;
+};
+
+static int btf_relocate_rewrite_type_id(__u32 *id, void *ctx)
+{
+	struct btf_relocate *r = ctx;
+
+	*id = r->map[*id];
+	return 0;
+}
+
+/* Simple string comparison used for sorting within BTF, since all distilled types are
+ * named.
+ */
+static int cmp_btf_types(const void *id1, const void *id2, void *priv)
+{
+	const struct btf *btf = priv;
+	const struct btf_type *t1 = btf_type_by_id(btf, *(__u32 *)id1);
+	const struct btf_type *t2 = btf_type_by_id(btf, *(__u32 *)id2);
+
+	return strcmp(btf__name_by_offset(btf, t1->name_off),
+		      btf__name_by_offset(btf, t2->name_off));
+}
+
+/* Comparison between base BTF type (search type) and distilled base types (target).
+ * Because there is no bsearch_r() we need to use the search key - which also is
+ * the first element of struct btf_relocate * - as a means to retrieve the
+ * struct btf_relocate *.
+ */
+static int cmp_base_and_distilled_btf_types(const void *idbase, const void *iddist)
+{
+	struct btf_relocate *r = (struct btf_relocate *)idbase;
+	const struct btf_type *tbase = btf_type_by_id(r->base_btf, *(__u32 *)idbase);
+	const struct btf_type *tdist = btf_type_by_id(r->dist_base_btf, *(__u32 *)iddist);
+
+	return strcmp(btf__name_by_offset(r->base_btf, tbase->name_off),
+		      btf__name_by_offset(r->dist_base_btf, tdist->name_off));
+}
+
+/* Build a map from distilled base BTF ids to base BTF ids. To do so, iterate
+ * through base BTF looking up distilled type (using binary search) equivalents.
+ */
+static int btf_relocate_map_distilled_base(struct btf_relocate *r)
+{
+	struct btf_type *t;
+	const char *name;
+	__u32 id;
+
+	/* generate a sort index array of type ids sorted by name for distilled
+	 * base BTF to speed lookups.
+	 */
+	for (id = 1; id < r->nr_dist_base_types; id++)
+		r->dist_base_index[id] = id;
+	qsort_r(r->dist_base_index, r->nr_dist_base_types, sizeof(__u32), cmp_btf_types,
+		(struct btf *)r->dist_base_btf);
+
+	for (id = 1; id < r->nr_base_types; id++) {
+		struct btf_type *dist_t;
+		int dist_kind, kind;
+		bool compat_kind;
+		__u32 *dist_id;
+
+		t = btf_type_by_id(r->base_btf, id);
+		kind = btf_kind(t);
+		/* distilled base consists of named types only. */
+		if (!t->name_off)
+			continue;
+		switch (kind) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+		case BTF_KIND_FWD:
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			break;
+		default:
+			continue;
+		}
+		r->search_id = id;
+		dist_id = bsearch(&r->search_id, r->dist_base_index, r->nr_dist_base_types,
+				  sizeof(__u32), cmp_base_and_distilled_btf_types);
+		if (!dist_id)
+			continue;
+		if (!*dist_id || *dist_id > r->nr_dist_base_types) {
+			pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\n",
+				id, *dist_id);
+			return -EINVAL;
+		}
+		/* validate that kinds are compatible */
+		dist_t = btf_type_by_id(r->dist_base_btf, *dist_id);
+		dist_kind = btf_kind(dist_t);
+		name = btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
+		compat_kind = dist_kind == kind;
+		if (!compat_kind) {
+			switch (dist_kind) {
+			case BTF_KIND_FWD:
+				compat_kind = kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
+				break;
+			case BTF_KIND_ENUM:
+				compat_kind = kind == BTF_KIND_ENUM64;
+				break;
+			default:
+				break;
+			}
+			if (!compat_kind) {
+				pr_warn("kind incompatibility (%d != %d) between distilled base type '%s'[%d] and base type [%d]\n",
+					dist_kind, kind, name, *dist_id, id);
+				return -EINVAL;
+			}
+		}
+		/* validate that int, float struct, union sizes are compatible;
+		 * distilled base BTF encodes an empty STRUCT/UNION with
+		 * specific size for cases where a type is embedded in a split
+		 * type (so has to preserve size info).  Do not error out
+		 * on mismatch as another size match may occur for an
+		 * identically-named type.
+		 */
+		switch (btf_kind(dist_t)) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			if (t->size == dist_t->size)
+				break;
+			continue;
+		default:
+			break;
+		}
+		r->map[*dist_id] = id;
+	}
+	/* ensure all distilled BTF ids have a mapping... */
+	for (id = 1; id < r->nr_dist_base_types; id++) {
+		t = btf_type_by_id(r->dist_base_btf, id);
+		name = btf__name_by_offset(r->dist_base_btf, t->name_off);
+		if (!r->map[id]) {
+			pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF id\n",
+				name, id);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* distilled base should only have named int/float/enum/fwd/struct/union types. */
+static int btf_relocate_validate_distilled_base(struct btf_relocate *r)
+{
+	unsigned int i;
+
+	for (i = 1; i < r->nr_dist_base_types; i++) {
+		struct btf_type *t = btf_type_by_id(r->dist_base_btf, i);
+		int kind = btf_kind(t);
+
+		switch (kind) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+		case BTF_KIND_FWD:
+			if (t->name_off)
+				break;
+			pr_warn("type [%d], kind [%d] is invalid for distilled base BTF; it is anonymous\n",
+				i, kind);
+			return -EINVAL;
+		default:
+			pr_warn("type [%d] in distilled based BTF has unexpected kind [%d]\n",
+				i, kind);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* If successful, output of relocation is updated BTF with base BTF pointing
+ * at base_btf, and type ids, strings adjusted accordingly
+ */
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids)
+{
+	const struct btf *dist_base_btf = btf__base_btf(btf);
+	unsigned int nr_types = btf__type_cnt(btf);
+	unsigned int nr_split_types;
+	struct btf_relocate r = {};
+	struct btf_type *t;
+	int diff_id, err = 0;
+	__u32 id, i;
+
+	if (!base_btf || dist_base_btf == base_btf)
+		return 0;
+
+	r.nr_dist_base_types = btf__type_cnt(dist_base_btf);
+	r.nr_base_types = btf__type_cnt(base_btf);
+	nr_split_types = nr_types - r.nr_dist_base_types;
+	r.btf = btf;
+	r.dist_base_btf = dist_base_btf;
+	r.base_btf = base_btf;
+
+	r.map = calloc(nr_types, sizeof(*r.map));
+	r.dist_base_index = calloc(r.nr_dist_base_types, sizeof(*r.dist_base_index));
+	if (!r.map || !r.dist_base_index) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = btf_relocate_validate_distilled_base(&r);
+	if (err)
+		goto err_out;
+
+	diff_id = r.nr_base_types - r.nr_dist_base_types;
+	/* Split BTF ids will start from after last base BTF id. */
+	for (id = r.nr_dist_base_types; id < nr_types; id++)
+		r.map[id] = id + diff_id;
+
+	/* Build a map from distilled base ids to actual base BTF ids; it is used
+	 * to update split BTF id references.
+	 */
+	err = btf_relocate_map_distilled_base(&r);
+	if (err)
+		goto err_out;
+
+	/* Next, rewrite type ids in split BTF, replacing split ids with updated
+	 * ids based on number of types in base BTF, and base ids with
+	 * relocated ids from base_btf.
+	 */
+	for (i = 0, id = r.nr_dist_base_types; i < nr_split_types; i++, id++) {
+		t = btf_type_by_id(btf, id);
+		err = btf_type_visit_type_ids(t, btf_relocate_rewrite_type_id, &r);
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
+	free(r.dist_base_index);
+	return err;
+}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index fd7bfeaba542..849cbe0def00 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -421,6 +421,7 @@ LIBBPF_1.5.0 {
 	global:
 		btf__distill_base;
 		btf__parse_opts;
+		btf__relocate;
 		bpf_program__attach_sockmap;
 		ring__consume_n;
 		ring_buffer__consume_n;
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


