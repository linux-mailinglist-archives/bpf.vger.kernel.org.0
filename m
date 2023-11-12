Return-Path: <bpf+bounces-14932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A217E8FCB
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F27B280C46
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FB8482;
	Sun, 12 Nov 2023 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2eiTSK94"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79CB3C07
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:52 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100732D5B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACChtuc027096;
	Sun, 12 Nov 2023 12:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=ivUum2/JCj+FtHFoYVk5pljkUMu4OxwJi22XKzZlXxg=;
 b=2eiTSK94+unfbgC72ZOuS6C5BZWoPzWEu+r5LE9WXFyUFE7xfYsChzS3dcpKDooOdcs1
 dxIaPFE4A7VrS+pspg/op3IOGv6lsBGGhSPRs4l6lpYxQPXPI0pA/YOWqTohVmWUprDN
 dMC9ZVa/i/QssVv3fUKwxbMZN94x1zBnrAngGsEwD8NI7+F3mD+F3o7kynVDvVjXf940
 ewPttQJkRvYX65zyPon2XQ6TIuXRdqzV8aIwxyT/3EQqJovYfrtWJe/veRcIN6wjzNxM
 ZITmwMtMpHM/7ExQP0QgAXhuWhpM6qZ9NAAXFwTXSbOPzM3EZOQ7p/a3WA3JbbLnJuus Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd1e24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCENCj008877;
	Sun, 12 Nov 2023 12:49:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceS029718;
	Sun, 12 Nov 2023 12:49:32 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-14;
	Sun, 12 Nov 2023 12:49:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 13/17] bpf: support standalone BTF in modules
Date: Sun, 12 Nov 2023 12:48:30 +0000
Message-Id: <20231112124834.388735-14-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-ORIG-GUID: JM8H4v6eD3iMnxWrq2ch9iDKUSRNaSnp
X-Proofpoint-GUID: JM8H4v6eD3iMnxWrq2ch9iDKUSRNaSnp

Not all kernel modules can be built in-tree when the core
kernel is built. This presents a problem for split BTF, because
split module BTF refers to type ids in the base kernel BTF, and
if that base kernel BTF changes (even in minor ways) those
references become invalid.  Such modules then cannot take
advantage of BTF (or at least they only can until the kernel
changes enough to invalidate their vmlinux type id references).
This problem has been discussed before, and the initial approach
was to allow BTF mismatch but fail to load BTF.  See [1]
for more discussion.

Generating standalone BTF for modules helps solve this problem
because the BTF generated is self-referential only.  However,
tooling is geared towards split BTF - for example bpftool assumes
a module's BTF is defined relative to vmlinux BTF.  To handle
this, dynamic remapping of standalone BTF is done on module
load to make it appear like split BTF - type ids and string
offsets are remapped such that they appear as they would in
split BTF.  It just so happens that the BTF is self-referential.
With this approach, existing tooling works with standalone
module BTF from /sys/kernel/btf in the same way as before;
no knowledge of split versus standalone BTF is required.

To verify that the module BTF is standalone we verify that
either

1. a CRC is present for BTF, but no base CRC is specified;
   this indicates that BTF was not generated relative to
   base BTF; or

2. the string offsets all lie within the range
   <0, string_section_size>; and
3. the BTF ids all lie within range
   <0, number_of_types_in_module_BTF>

Case 1 is a fastpath available when pahole generates CRCs.
The tests carried out in 2 and 3 are fallbacks for when newer
pahole is not present.

If these conditions are true, BTF and string ids are remapped
such that they appear to be split BTF.

Note that the kfunc and dtor ids need to be remapped also
on registration, since they will be out-of-date with respect
to the remapped module BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/YfK18x%2FXrYL4Vw8o@syu-laptop/
---
 kernel/bpf/btf.c | 304 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 302 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a51dc3ef6a56..412184ade0f1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -267,6 +267,7 @@ struct btf {
 	u32 start_str_off; /* first string offset (0 for base BTF) */
 	char name[MODULE_NAME_LEN];
 	bool kernel_btf;
+	bool standalone_btf;
 };
 
 enum verifier_phase {
@@ -5882,6 +5883,253 @@ struct btf *btf_parse_vmlinux(void)
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
+/* verify module BTF is self-contained:
+ * - if CRC is set and base CRC is not: or
+ *  - no string offset should exceed standalone str len; and
+ *  - the max id referenced should be <= the number of btf types in module BTF
+ *
+ * Taken together with the fact that the number of module types is much less
+ * than the number of types in vmliux BTF, these imply self-reference and hence
+ * standalone BTF.
+ */
+static bool btf_module_is_standalone(struct btf_verifier_env *env)
+{
+	u32 id_max = 0, num_ids = 0;
+	struct btf *btf = env->btf;
+	struct btf_header *hdr;
+	void *cur, *end;
+	u32 end_str_off;
+
+	hdr = &btf->hdr;
+	cur = btf->nohdr_data + hdr->type_off;
+	end = cur + hdr->type_len;
+	end_str_off = hdr->str_len;
+
+	/* Quick CRC test; if base CRC is absent while CRC is present,
+	 * we know BTF was generated without reference to base BTF.
+	 */
+	if (hdr->hdr_len >= sizeof(struct btf_header)) {
+		if ((hdr->flags & BTF_FLAG_CRC_SET) &&
+		    !(hdr->flags & BTF_FLAG_BASE_CRC_SET))
+			return true;
+	}
+
+	while (cur < end) {
+		struct btf_type *t = cur;
+		u32 meta_size = sizeof(*t);
+		struct btf_member *member;
+		struct btf_param *param;
+		struct btf_array *array;
+		struct btf_enum64 *e64;
+		struct btf_enum *e;
+		int i, vlen;
+
+		if (t->name_off >= end_str_off)
+			return false;
+
+		switch (btf_kind(t)) {
+		case BTF_KIND_FLOAT:
+			break;
+		case BTF_KIND_PTR:
+		case BTF_KIND_FWD:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_CONST:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_FUNC:
+		case BTF_KIND_TYPE_TAG:
+			if (t->type > id_max)
+				id_max = t->type;
+			break;
+		case BTF_KIND_VAR:
+			if (t->type > id_max)
+				id_max = t->type;
+			meta_size += sizeof(struct btf_var);
+			break;
+		case BTF_KIND_INT:
+			meta_size += sizeof(u32);
+			break;
+		case BTF_KIND_DATASEC:
+			meta_size += btf_vlen(t) * sizeof(struct btf_var_secinfo);
+			break;
+		case BTF_KIND_ARRAY:
+			array = (struct btf_array *)(t + 1);
+			if (array->type > id_max)
+				id_max = array->type;
+			if (array->index_type > id_max)
+				id_max = array->index_type;
+			meta_size += sizeof(*array);
+			break;
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			member = (struct btf_member *)(t + 1);
+			vlen = btf_type_vlen(t);
+			for (i = 0; i < vlen; i++, member++) {
+				if (member->name_off >= end_str_off)
+					return false;
+				if (member->type > id_max)
+					id_max = member->type;
+			}
+			meta_size += vlen * sizeof(*member);
+			break;
+		case BTF_KIND_ENUM:
+			e = (struct btf_enum *)(t + 1);
+			vlen = btf_type_vlen(t);
+			for (i = 0; i < vlen; i++, e++) {
+				if  (e->name_off > end_str_off)
+					return false;
+			}
+			meta_size +=  vlen * sizeof(*e);
+			break;
+		case BTF_KIND_ENUM64:
+			e64 = (struct btf_enum64 *)(t + 1);
+			vlen = btf_type_vlen(t);
+			for (i = 0; i < vlen; i++, e64++) {
+				if (e64->name_off > end_str_off)
+					return false;
+			}
+			meta_size += vlen * sizeof(*e64);
+			break;
+		case BTF_KIND_FUNC_PROTO:
+			param = (struct btf_param *)(t + 1);
+			vlen = btf_type_vlen(t);
+			for (i = 0; i < vlen; i++, param++) {
+				if (param->name_off > end_str_off)
+					return false;
+				if (param->type > id_max)
+					id_max = param->type;
+			}
+			meta_size += vlen * sizeof(*param);
+			break;
+		case BTF_KIND_DECL_TAG:
+			if (t->type > id_max)
+				id_max = t->type;
+			meta_size += sizeof(struct btf_decl_tag);
+			break;
+		}
+		cur += meta_size;
+		num_ids++;
+	}
+	/* if all standalone string checks look good and we found no references
+	 * to ids higher than the number present here, we can be sure it is
+	 * standalone BTF.
+	 */
+	return id_max <= num_ids;
+}
+
+static u32 btf_name_off_renumber(struct btf *btf, u32 name_off)
+{
+	/* no need to renumber empty string */
+	if (name_off == 0)
+		return name_off;
+	return name_off + btf->start_str_off;
+}
+
+static u32 btf_id_renumber(struct btf *btf, u32 id)
+{
+	/* no need to renumber void type id */
+	if (id == 0)
+		return id;
+
+	return id + btf->start_id - 1;
+}
+
+/* Renumber standalone BTF to appear as split BTF; name offsets must
+ * be relative to btf->start_str_offset and ids relative to btf->start_id.
+ * When user sees BTF it will appear as normal module split BTF, the only
+ * difference being it is fully self-referential and does not refer back
+ * to vmlinux BTF (aside from 0 "void" references).
+ */
+static void btf_type_renumber(struct btf_verifier_env *env, struct btf_type *t)
+{
+	struct btf_var_secinfo *secinfo;
+	struct btf *btf = env->btf;
+	struct btf_member *member;
+	struct btf_param *param;
+	struct btf_array *array;
+	struct btf_enum64 *e64;
+	struct btf_enum *e;
+	int i, vlen;
+
+	t->name_off = btf_name_off_renumber(btf, t->name_off);
+
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
+		/* nothing to renumber here, no type references */
+		break;
+	case BTF_KIND_PTR:
+	case BTF_KIND_FWD:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_FUNC:
+	case BTF_KIND_VAR:
+	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_DECL_TAG:
+		/* renumber the referenced type */
+		t->type = btf_id_renumber(btf, t->type);
+		break;
+	case BTF_KIND_ARRAY:
+		array = btf_array(t);
+		array->type = btf_id_renumber(btf, array->type);
+		array->index_type = btf_id_renumber(btf, array->index_type);
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		member = (struct btf_member *)(t + 1);
+		vlen = btf_type_vlen(t);
+		for (i = 0; i < vlen; i++, member++) {
+			member->type = btf_id_renumber(btf, member->type);
+			member->name_off = btf_name_off_renumber(btf, member->name_off);
+		}
+		break;
+	case BTF_KIND_FUNC_PROTO:
+		param = (struct btf_param *)(t + 1);
+		vlen = btf_type_vlen(t);
+		for (i = 0; i < vlen; i++, param++) {
+			param->type = btf_id_renumber(btf, param->type);
+			param->name_off = btf_name_off_renumber(btf, param->name_off);
+		}
+		break;
+	case BTF_KIND_DATASEC:
+		vlen = btf_type_vlen(t);
+		secinfo = (struct btf_var_secinfo *)(t + 1);
+		for (i = 0; i < vlen; i++, secinfo++)
+			secinfo->type = btf_id_renumber(btf, secinfo->type);
+		break;
+	case BTF_KIND_ENUM:
+		e = (struct btf_enum *)(t + 1);
+		vlen = btf_type_vlen(t);
+		for (i = 0; i < vlen; i++, e++)
+			e->name_off = btf_name_off_renumber(btf, e->name_off);
+		break;
+	case BTF_KIND_ENUM64:
+		e64 = (struct btf_enum64 *)(t + 1);
+		vlen = btf_type_vlen(t);
+		for (i = 0; i < vlen; i++, e64++)
+			e64->name_off = btf_name_off_renumber(btf, e64->name_off);
+		break;
+	}
+}
+
+static void btf_renumber(struct btf_verifier_env *env, struct btf *base_btf)
+{
+	struct btf *btf = env->btf;
+	int i;
+
+	btf->start_id = base_btf->nr_types;
+	btf->start_str_off = base_btf->hdr.str_len;
+	btf->base_btf = base_btf;
+
+	for (i = 1; i < btf->nr_types; i++)
+		btf_type_renumber(env, btf->types[i]);
+	/* skip past unneeded void type (we use base id 0 instead) */
+	btf->types++;
+	btf->nr_types--;
+}
+
 static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
 {
 	struct btf_verifier_env *env = NULL;
@@ -5933,10 +6181,29 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 	if (err)
 		goto errout;
 
+	if (btf_module_is_standalone(env)) {
+		/* BTF may be standalone; in that case BTF ids and strings
+		 * will all be self-referential.
+		 *
+		 * Later on, once we have checked all metas, we will
+		 * retain start id from  base BTF so it will look like
+		 * split BTF (but is self-contained); renumbering is done
+		 * also to give the split BTF-like appearance and not
+		 * confuse pahole which assumes split BTF for modules.
+		 */
+		btf->base_btf = NULL;
+		btf->start_id = 0;
+		btf->nr_types = 0;
+		btf->start_str_off = 0;
+		btf->standalone_btf = true;
+	}
 	err = btf_check_all_metas(env);
 	if (err)
 		goto errout;
 
+	if (btf->standalone_btf)
+		btf_renumber(env, base_btf);
+
 	err = btf_check_type_tags(env, btf, btf_nr_types(base_btf));
 	if (err)
 		goto errout;
@@ -7876,6 +8143,16 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
 	/* Concatenate the two sets */
 	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
+	if (btf->standalone_btf) {
+		u32 i;
+
+		/* renumber BTF ids since BTF is standalone and has been mapped to look
+		 * like split BTF, while BTF kfunc ids are still old unmapped values.
+		 */
+		for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
+			set->pairs[i].id = btf_id_renumber(btf, set->pairs[i].id);
+	}
+
 	set->cnt += add_set->cnt;
 
 	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
@@ -7936,7 +8213,6 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 		return BTF_KFUNC_HOOK_CGROUP_SKB;
 	case BPF_PROG_TYPE_SCHED_ACT:
 		return BTF_KFUNC_HOOK_SCHED_ACT;
@@ -8005,7 +8281,14 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 		return PTR_ERR(btf);
 
 	for (i = 0; i < kset->set->cnt; i++) {
-		ret = btf_check_kfunc_protos(btf, kset->set->pairs[i].id,
+		u32 kfunc_id = kset->set->pairs[i].id;
+
+		/* standalone BTF renumbers BTF ids to make them appear as split BTF;
+		 * resolve_btfids has the old BTF ids so we need to renumber here.
+		 */
+		if (btf->standalone_btf)
+			kfunc_id = btf_id_renumber(btf, kfunc_id);
+		ret = btf_check_kfunc_protos(btf, kfunc_id,
 					     kset->set->pairs[i].flags);
 		if (ret)
 			goto err_out;
@@ -8063,6 +8346,12 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 	for (i = 0; i < cnt; i++) {
 		dtor_btf_id = dtors[i].kfunc_btf_id;
 
+		/* standalone BTF renumbers BTF ids to make them appear as split BTF;
+		 * resolve_btfids has the old BTF ids so we need to renumber here.
+		 */
+		if (btf->standalone_btf)
+			dtor_btf_id = btf_id_renumber(btf, dtor_btf_id);
+
 		dtor_func = btf_type_by_id(btf, dtor_btf_id);
 		if (!dtor_func || !btf_type_is_func(dtor_func))
 			return -EINVAL;
@@ -8156,6 +8445,17 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 	btf->dtor_kfunc_tab = tab;
 
 	memcpy(tab->dtors + tab->cnt, dtors, add_cnt * sizeof(tab->dtors[0]));
+	if (btf->standalone_btf) {
+		u32 i;
+
+		/* renumber BTF ids since BTF is standalone and has been mapped to look
+		 * like split BTF, while BTF dtor ids are still old unmapped values.
+		 */
+		for (i = tab->cnt; i < tab->cnt + add_cnt; i++) {
+			tab->dtors[i].btf_id = btf_id_renumber(btf, tab->dtors[i].btf_id);
+			tab->dtors[i].kfunc_btf_id = btf_id_renumber(btf, tab->dtors[i].kfunc_btf_id);
+		}
+	}
 	tab->cnt += add_cnt;
 
 	sort(tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func, NULL);
-- 
2.31.1


