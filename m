Return-Path: <bpf+bounces-32053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61435906949
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358551C2382D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94DF140388;
	Thu, 13 Jun 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SlZsanpP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C9140387
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272258; cv=none; b=YC0vh8L489q81zZZw1WJvoujFQOFwxG12V0KTsv7MiI9imddP8v+7mTQz4DXJDMbT6tAdM7BSohexfSI6laacjxuwm9NboTsH3p1a8fYrLxBOtyKAyO51mWp0MXUJVnpKR2iB+wMn7NfWRFqq8IzOewMg1bdHWKcUlC0UqHusYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272258; c=relaxed/simple;
	bh=eA+E50LiymVYGu3/hzgINUOeYpd5qtyJOtIqNBo5gV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=No9JSOGpkIWTgF7IBaY9lHw8eiMff0xz3RTrqseJ4pYvdP2+xF81cMzy+2Lie1UeIT8Bmj+0ktkN60iI9D67hxeHRdH+re+m8nmbZUZHuQcgF9Nhr2pK2C21p3i3Bjt4gadGv1K+DfcVEMEo9+sdIi88teWZTfmWkmY2Ic8mckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SlZsanpP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7tYcT031482;
	Thu, 13 Jun 2024 09:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=I
	x1ipejYgg1M1vcehdsNuRihq8PCGA3QtYoBC4e6IJs=; b=SlZsanpPq77MHutBu
	5RNzG04eZi2ul35tsRLE3kjC0S+zAxIUugXs11i53h6ICMcDkSJlCoVJBHbzD985
	511vmmBeendvFXV0so3Yku0ZnKpW2l6TIVYy8BMvDmqVBguGrtjC5PVR1pONyHOC
	NVE1P5JV25DcaILrWPeJoXjH40bIMtyBweT+lrCmE5XQJA+qvaECRJ14wo6L+xn9
	dDoqfLJxpsT0bbff8pkYBJh/Yxn3O6+TPYYkbErpFv2rz/TRKG6TGh6mVQyEFUSp
	Sbuwt6SsAE/dobpxTu/9LsZsEu0O6ACQDPeb7dYbXhLb0hSrFoUKUxqLG07o44BJ
	+7sCQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7ds5u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D86xt8014271;
	Thu, 13 Jun 2024 09:50:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncewnm34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45D9oJpu005489;
	Thu, 13 Jun 2024 09:50:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-187.vpn.oracle.com [10.175.212.187])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yncewnkqw-4;
	Thu, 13 Jun 2024 09:50:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 3/9] libbpf: split BTF relocation
Date: Thu, 13 Jun 2024 10:50:08 +0100
Message-Id: <20240613095014.357981-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240613095014.357981-1-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130070
X-Proofpoint-GUID: ytu0qfHFAx1rmlmanEYjC1A_2jTinHpb
X-Proofpoint-ORIG-GUID: ytu0qfHFAx1rmlmanEYjC1A_2jTinHpb

Map distilled base BTF type ids referenced in split BTF and their
references to the base BTF passed in, and if the mapping succeeds,
reparent the split BTF to the base BTF.

Relocation is done by first verifying that distilled base BTF
only consists of named INT, FLOAT, ENUM, FWD, STRUCT and
UNION kinds; then we sort these to speed lookups.  Once sorted,
the base BTF is iterated, and for each relevant kind we check
for an equivalent in distilled base BTF.  When found, the
mapping from distilled -> base BTF id and string offset is recorded.
In establishing mappings, we need to ensure we check STRUCT/UNION
size when the STRUCT/UNION is embedded in a split BTF STRUCT/UNION,
and when duplicate names exist for the same STRUCT/UNION.  Otherwise
size is ignored in matching STRUCT/UNIONs.

Once all mappings are established, we can update type ids
and string offsets in split BTF and reparent it to the new base.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/btf.c             |  17 ++
 tools/lib/bpf/btf.h             |  14 +
 tools/lib/bpf/btf_relocate.c    | 506 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |   3 +
 6 files changed, 542 insertions(+), 1 deletion(-)
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
index 407ed92b4134..5e20354fbcfa 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5583,3 +5583,20 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
 
 	return 0;
 }
+
+const struct btf_header *btf_header(const struct btf *btf)
+{
+	return btf->hdr;
+}
+
+void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
+{
+	btf->base_btf = (struct btf *)base_btf;
+	btf->start_id = btf__type_cnt(base_btf);
+	btf->start_str_off = base_btf->hdr->str_len;
+}
+
+int btf__relocate(struct btf *btf, const struct btf *base_btf)
+{
+	return libbpf_err(btf_relocate(btf, base_btf, NULL));
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index cb08ee9a5a10..8a93120b7385 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -252,6 +252,20 @@ struct btf_dedup_opts {
 
 LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
 
+/**
+ * @brief **btf__relocate()** will check the split BTF *btf* for references
+ * to base BTF kinds, and verify those references are compatible with
+ * *base_btf*; if they are, *btf* is adjusted such that is re-parented to
+ * *base_btf* and type ids and strings are adjusted to accommodate this.
+ *
+ * If successful, 0 is returned and **btf** now has **base_btf** as its
+ * base.
+ *
+ * A negative value is returned on error and the thread-local `errno` variable
+ * is set to the error code as well.
+ */
+LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_btf);
+
 struct btf_dump;
 
 struct btf_dump_opts {
diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
new file mode 100644
index 000000000000..eabb8755f662
--- /dev/null
+++ b/tools/lib/bpf/btf_relocate.c
@@ -0,0 +1,506 @@
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
+	struct btf *btf;
+	const struct btf *base_btf;
+	const struct btf *dist_base_btf;
+	unsigned int nr_base_types;
+	unsigned int nr_split_types;
+	unsigned int nr_dist_base_types;
+	int dist_str_len;
+	int base_str_len;
+	__u32 *id_map;
+	__u32 *str_map;
+};
+
+/* Set temporarily in relocation id_map if distilled base struct/union is
+ * embedded in a split BTF struct/union; in such a case, size information must
+ * match between distilled base BTF and base BTF representation of type.
+ */
+#define BTF_IS_EMBEDDED ((__u32)-1)
+
+/* <name, size, id> triple used in sorting/searching distilled base BTF. */
+struct btf_name_info {
+	const char *name;
+	/* set when search requires a size match */
+	int needs_size:1,
+	    size:31;
+	__u32 id;
+};
+
+static int btf_relocate_rewrite_type_id(struct btf_relocate *r, __u32 i)
+{
+	struct btf_type *t = btf_type_by_id(r->btf, i);
+	struct btf_field_iter it;
+	__u32 *id;
+	int err;
+
+	err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
+	if (err)
+		return err;
+
+	while ((id = btf_field_iter_next(&it)))
+		*id = r->id_map[*id];
+	return 0;
+}
+
+/* Simple string comparison used for sorting within BTF, since all distilled
+ * types are named.  If strings match, and size is non-zero for both elements
+ * fall back to using size for ordering.
+ */
+static int cmp_btf_name_size(const void *n1, const void *n2)
+{
+	const struct btf_name_info *ni1 = n1;
+	const struct btf_name_info *ni2 = n2;
+	int name_diff = strcmp(ni1->name, ni2->name);
+
+	if (!name_diff && ni1->needs_size && ni2->needs_size)
+		return ni2->size - ni1->size;
+	return name_diff;
+}
+
+/* Binary search with a small twist; find leftmost element that matches
+ * so that we can then iterate through all exact matches.  So for example
+ * searching { "a", "bb", "bb", "c" }  we would always match on the
+ * leftmost "bb".
+ */
+static struct btf_name_info *search_btf_name_size(struct btf_name_info *key,
+						  struct btf_name_info *vals,
+						  int nelems)
+{
+	struct btf_name_info *ret = NULL;
+	int high = nelems - 1;
+	int low = 0;
+
+	while (low <= high) {
+		int mid = (low + high)/2;
+		struct btf_name_info *val = &vals[mid];
+		int diff = cmp_btf_name_size(key, val);
+
+		if (diff == 0)
+			ret = val;
+		/* even if found, keep searching for leftmost match */
+		if (diff <= 0)
+			high = mid - 1;
+		else
+			low = mid + 1;
+	}
+	return ret;
+}
+
+/* If a member of a split BTF struct/union refers to a base BTF
+ * struct/union, mark that struct/union id temporarily in the id_map
+ * with BTF_IS_EMBEDDED.  Members can be const/restrict/volatile/typedef
+ * reference types, but if a pointer is encountered, the type is no longer
+ * considered embedded.
+ */
+static int btf_mark_embedded_composite_type_ids(struct btf_relocate *r, __u32 i)
+{
+	struct btf_type *t = btf_type_by_id(r->btf, i);
+	struct btf_field_iter it;
+	__u32 *id;
+	int err;
+
+	if (!btf_is_composite(t))
+		return 0;
+
+	err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
+	if (err)
+		return err;
+
+	while ((id = btf_field_iter_next(&it))) {
+		__u32 next_id = *id;
+
+		while (next_id) {
+			t = btf_type_by_id(r->btf, next_id);
+			switch (btf_kind(t)) {
+			case BTF_KIND_CONST:
+			case BTF_KIND_RESTRICT:
+			case BTF_KIND_VOLATILE:
+			case BTF_KIND_TYPEDEF:
+			case BTF_KIND_TYPE_TAG:
+				next_id = t->type;
+				break;
+			case BTF_KIND_ARRAY: {
+				struct btf_array *a = btf_array(t);
+
+				next_id = a->type;
+				break;
+			}
+			case BTF_KIND_STRUCT:
+			case BTF_KIND_UNION:
+				if (next_id < r->nr_dist_base_types)
+					r->id_map[next_id] = BTF_IS_EMBEDDED;
+				next_id = 0;
+				break;
+			default:
+				next_id = 0;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* Build a map from distilled base BTF ids to base BTF ids. To do so, iterate
+ * through base BTF looking up distilled type (using binary search) equivalents.
+ */
+static int btf_relocate_map_distilled_base(struct btf_relocate *r)
+{
+	struct btf_name_info *dist_base_info_sorted, *dist_base_info_sorted_end;
+	struct btf_type *base_t, *dist_t;
+	__u8 *base_name_cnt = NULL;
+	int err = 0;
+	__u32 id;
+
+	/* generate a sort index array of name/type ids sorted by name for
+	 * distilled base BTF to speed name-based lookups.
+	 */
+	dist_base_info_sorted = calloc(r->nr_dist_base_types, sizeof(*dist_base_info_sorted));
+	if (!dist_base_info_sorted) {
+		err = -ENOMEM;
+		goto done;
+	}
+	dist_base_info_sorted_end = dist_base_info_sorted + r->nr_dist_base_types;
+	for (id = 0; id < r->nr_dist_base_types; id++) {
+		dist_t = btf_type_by_id(r->dist_base_btf, id);
+		dist_base_info_sorted[id].name = btf__name_by_offset(r->dist_base_btf,
+								     dist_t->name_off);
+		dist_base_info_sorted[id].id = id;
+		dist_base_info_sorted[id].size = dist_t->size;
+		dist_base_info_sorted[id].needs_size = true;
+	}
+	qsort(dist_base_info_sorted, r->nr_dist_base_types, sizeof(*dist_base_info_sorted),
+	      cmp_btf_name_size);
+
+	/* Mark distilled base struct/union members of split BTF structs/unions
+	 * in id_map with BTF_IS_EMBEDDED; this signals that these types
+	 * need to match both name and size, otherwise embeddding the base
+	 * struct/union in the split type is invalid.
+	 */
+	for (id = r->nr_dist_base_types; id < r->nr_split_types; id++) {
+		err = btf_mark_embedded_composite_type_ids(r, id);
+		if (err)
+			goto done;
+	}
+
+	/* Collect name counts for composite types in base BTF.  If multiple
+	 * instances of a struct/union of the same name exist, we need to use
+	 * size to determine which to map to since name alone is ambiguous.
+	 */
+	base_name_cnt = calloc(r->base_str_len, sizeof(*base_name_cnt));
+	if (!base_name_cnt) {
+		err = -ENOMEM;
+		goto done;
+	}
+	for (id = 1; id < r->nr_base_types; id++) {
+		base_t = btf_type_by_id(r->base_btf, id);
+		if (!btf_is_composite(base_t) || !base_t->name_off)
+			continue;
+		if (base_name_cnt[base_t->name_off] < 255)
+			base_name_cnt[base_t->name_off]++;
+	}
+
+	/* Now search base BTF for matching distilled base BTF types. */
+	for (id = 1; id < r->nr_base_types; id++) {
+		struct btf_name_info *dist_name_info, *dist_name_info_next = NULL;
+		struct btf_name_info base_name_info = {};
+		int dist_kind, base_kind;
+
+		base_t = btf_type_by_id(r->base_btf, id);
+		/* distilled base consists of named types only. */
+		if (!base_t->name_off)
+			continue;
+		base_kind = btf_kind(base_t);
+		base_name_info.id = id;
+		base_name_info.name = btf__name_by_offset(r->base_btf, base_t->name_off);
+		switch (base_kind) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			/* These types should match both name and size */
+			base_name_info.needs_size = true;
+			base_name_info.size = base_t->size;
+			break;
+		case BTF_KIND_FWD:
+			/* No size considerations for fwds. */
+			break;
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			/* Size only needs to be used for struct/union if there
+			 * are multiple types in base BTF with the same name.
+			 * If there are multiple _distilled_ types with the same
+			 * name (a very unlikely scenario), that doesn't matter
+			 * unless corresponding _base_ types to match them are
+			 * missing.
+			 */
+			base_name_info.needs_size = base_name_cnt[base_t->name_off] > 1;
+			base_name_info.size = base_t->size;
+			break;
+		default:
+			continue;
+		}
+		/* iterate over all matching distilled base types */
+		for (dist_name_info = search_btf_name_size(&base_name_info, dist_base_info_sorted,
+							   r->nr_dist_base_types);
+		     dist_name_info != NULL; dist_name_info = dist_name_info_next) {
+			/* Are there more distilled matches to process after
+			 * this one?
+			 */
+			dist_name_info_next = dist_name_info + 1;
+			if (dist_name_info_next >= dist_base_info_sorted_end ||
+			    cmp_btf_name_size(&base_name_info, dist_name_info_next))
+				dist_name_info_next = NULL;
+
+			if (!dist_name_info->id || dist_name_info->id > r->nr_dist_base_types) {
+				pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\n",
+					id, dist_name_info->id);
+				err = -EINVAL;
+				goto done;
+			}
+			dist_t = btf_type_by_id(r->dist_base_btf, dist_name_info->id);
+			dist_kind = btf_kind(dist_t);
+
+			/* Validate that the found distilled type is compatible.
+			 * Do not error out on mismatch as another match may
+			 * occur for an identically-named type.
+			 */
+			switch (dist_kind) {
+			case BTF_KIND_FWD:
+				switch (base_kind) {
+				case BTF_KIND_FWD:
+					if (btf_kflag(dist_t) != btf_kflag(base_t))
+						continue;
+					break;
+				case BTF_KIND_STRUCT:
+					if (btf_kflag(base_t))
+						continue;
+					break;
+				case BTF_KIND_UNION:
+					if (!btf_kflag(base_t))
+						continue;
+					break;
+				default:
+					continue;
+				}
+				break;
+			case BTF_KIND_INT:
+				if (dist_kind != base_kind ||
+				    btf_int_encoding(base_t) != btf_int_encoding(dist_t))
+					continue;
+				break;
+			case BTF_KIND_FLOAT:
+				if (dist_kind != base_kind)
+					continue;
+				break;
+			case BTF_KIND_ENUM:
+				/* ENUM and ENUM64 are encoded as sized ENUM in
+				 * distilled base BTF.
+				 */
+				if (base_kind != dist_kind && base_kind != BTF_KIND_ENUM64)
+					continue;
+				break;
+			case BTF_KIND_STRUCT:
+			case BTF_KIND_UNION:
+				/* size verification is required for embedded
+				 * struct/unions.
+				 */
+				if (r->id_map[dist_name_info->id] == BTF_IS_EMBEDDED &&
+				    base_t->size != dist_t->size)
+					continue;
+				break;
+			default:
+				continue;
+			}
+			if (r->id_map[dist_name_info->id] &&
+			    r->id_map[dist_name_info->id] != BTF_IS_EMBEDDED) {
+				/* we already have a match; this tells us that
+				 * multiple base types of the same name
+				 * have the same size, since for cases where
+				 * multiple types have the same name we match
+				 * on name and size.  In this case, we have
+				 * no way of determining which to relocate
+				 * to in base BTF, so error out.
+				 */
+				pr_warn("distilled base BTF type '%s' [%u], size %u has multiple candidates of the same size (ids [%u, %u]) in base BTF\n",
+					base_name_info.name, dist_name_info->id,
+					base_t->size, id, r->id_map[dist_name_info->id]);
+				err = -EINVAL;
+				goto done;
+			}
+			/* map id and name */
+			r->id_map[dist_name_info->id] = id;
+			r->str_map[dist_t->name_off] = base_t->name_off;
+		}
+	}
+	/* ensure all distilled BTF ids now have a mapping... */
+	for (id = 1; id < r->nr_dist_base_types; id++) {
+		const char *name;
+
+		if (r->id_map[id] && r->id_map[id] != BTF_IS_EMBEDDED)
+			continue;
+		dist_t = btf_type_by_id(r->dist_base_btf, id);
+		name = btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
+		pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF id\n",
+			name, id);
+		err = -EINVAL;
+		break;
+	}
+done:
+	free(base_name_cnt);
+	free(dist_base_info_sorted);
+	return err;
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
+static int btf_relocate_rewrite_strs(struct btf_relocate *r, __u32 i)
+{
+	struct btf_type *t = btf_type_by_id(r->btf, i);
+	struct btf_field_iter it;
+	__u32 *str_off;
+	int off, err;
+
+	err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
+	if (err)
+		return err;
+
+	while ((str_off = btf_field_iter_next(&it))) {
+		if (!*str_off)
+			continue;
+		if (*str_off >= r->dist_str_len) {
+			*str_off += r->base_str_len - r->dist_str_len;
+		} else {
+			off = r->str_map[*str_off];
+			if (!off) {
+				pr_warn("string '%s' [offset %u] is not mapped to base BTF",
+					btf__str_by_offset(r->btf, off), *str_off);
+				return -ENOENT;
+			}
+			*str_off = off;
+		}
+	}
+	return 0;
+}
+
+/* If successful, output of relocation is updated BTF with base BTF pointing
+ * at base_btf, and type ids, strings adjusted accordingly.
+ */
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map)
+{
+	unsigned int nr_types = btf__type_cnt(btf);
+	const struct btf_header *dist_base_hdr;
+	const struct btf_header *base_hdr;
+	struct btf_relocate r = {};
+	int err = 0;
+	__u32 id, i;
+
+	r.dist_base_btf = btf__base_btf(btf);
+	if (!base_btf || r.dist_base_btf == base_btf)
+		return -EINVAL;
+
+	r.nr_dist_base_types = btf__type_cnt(r.dist_base_btf);
+	r.nr_base_types = btf__type_cnt(base_btf);
+	r.nr_split_types = nr_types - r.nr_dist_base_types;
+	r.btf = btf;
+	r.base_btf = base_btf;
+
+	r.id_map = calloc(nr_types, sizeof(*r.id_map));
+	r.str_map = calloc(btf_header(r.dist_base_btf)->str_len, sizeof(*r.str_map));
+	dist_base_hdr = btf_header(r.dist_base_btf);
+	base_hdr = btf_header(r.base_btf);
+	r.dist_str_len = dist_base_hdr->str_len;
+	r.base_str_len = base_hdr->str_len;
+	if (!r.id_map || !r.str_map) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = btf_relocate_validate_distilled_base(&r);
+	if (err)
+		goto err_out;
+
+	/* Split BTF ids need to be adjusted as base and distilled base
+	 * have different numbers of types, changing the start id of split
+	 * BTF.
+	 */
+	for (id = r.nr_dist_base_types; id < nr_types; id++)
+		r.id_map[id] = id + r.nr_base_types - r.nr_dist_base_types;
+
+	/* Build a map from distilled base ids to actual base BTF ids; it is used
+	 * to update split BTF id references.  Also build a str_map mapping from
+	 * distilled base BTF names to base BTF names.
+	 */
+	err = btf_relocate_map_distilled_base(&r);
+	if (err)
+		goto err_out;
+
+	/* Next, rewrite type ids in split BTF, replacing split ids with updated
+	 * ids based on number of types in base BTF, and base ids with
+	 * relocated ids from base_btf.
+	 */
+	for (i = 0, id = r.nr_dist_base_types; i < r.nr_split_types; i++, id++) {
+		err = btf_relocate_rewrite_type_id(&r, id);
+		if (err)
+			goto err_out;
+	}
+	/* String offsets now need to be updated using the str_map. */
+	for (i = 0; i < r.nr_split_types; i++) {
+		err = btf_relocate_rewrite_strs(&r, i + r.nr_dist_base_types);
+		if (err)
+			goto err_out;
+	}
+	/* Finally reset base BTF to be base_btf */
+	btf_set_base_btf(btf, base_btf);
+
+	if (id_map) {
+		*id_map = r.id_map;
+		r.id_map = NULL;
+	}
+err_out:
+	free(r.id_map);
+	free(r.str_map);
+	return err;
+}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 175d1536e070..8f0d9ea3b1b4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -420,6 +420,7 @@ LIBBPF_1.4.0 {
 LIBBPF_1.5.0 {
 	global:
 		btf__distill_base;
+		btf__relocate;
 		bpf_map__autoattach;
 		bpf_map__set_autoattach;
 		bpf_program__attach_sockmap;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e2f06609c624..408df59e0771 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -234,6 +234,9 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+const struct btf_header *btf_header(const struct btf *btf);
+void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.31.1


