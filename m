Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE11644F57
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiLFXKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLFXKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1516C4299E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:16 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhAIe005404
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GJHnREvB4ds25DN4QssMCHuYvpiRk8k4zF7gMzr7kkU=;
 b=RyX+DXkYDuLDJdeprpTKHd1xRjnmmYpSkv1nsYVQnZNzGlwsYxHz8jt3J8DDGZurs41/
 aQdID2i3X9rqML57eUDjP8hzO3Mt6fNK1c0SFM9doqGjVhD5XWjCpFaud/FFkrK+FCg6
 Dpu7/LmjwB51qhMXi7O91bw/HZYlaq5RcgE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ma9dxtxe2-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:15 -0800
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 15:10:12 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 757D9120B376A; Tue,  6 Dec 2022 15:10:04 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 04/13] bpf: rename list_head -> datastructure_head in field info types
Date:   Tue, 6 Dec 2022 15:09:51 -0800
Message-ID: <20221206231000.3180914-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qe2SvtNj-ib0vGplf8oU8ktpfe33BG-M
X-Proofpoint-ORIG-GUID: qe2SvtNj-ib0vGplf8oU8ktpfe33BG-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Many of the structs recently added to track field info for linked-list
head are useful as-is for rbtree root. So let's do a mechanical renaming
of list_head-related types and fields:

include/linux/bpf.h:
  struct btf_field_list_head -> struct btf_field_datastructure_head
  list_head -> datastructure_head in struct btf_field union
kernel/bpf/btf.c:
  list_head -> datastructure_head in struct btf_field_info

This is a nonfunctional change, functionality to actually use these
fields for rbtree will be added in further patches.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h   |  4 ++--
 kernel/bpf/btf.c      | 21 +++++++++++----------
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/verifier.c | 21 +++++++++++----------
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4920ac252754..9e8b12c7061e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -189,7 +189,7 @@ struct btf_field_kptr {
 	u32 btf_id;
 };
=20
-struct btf_field_list_head {
+struct btf_field_datastructure_head {
 	struct btf *btf;
 	u32 value_btf_id;
 	u32 node_offset;
@@ -201,7 +201,7 @@ struct btf_field {
 	enum btf_field_type type;
 	union {
 		struct btf_field_kptr kptr;
-		struct btf_field_list_head list_head;
+		struct btf_field_datastructure_head datastructure_head;
 	};
 };
=20
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c80bd8709e69..284e3e4b76b7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3227,7 +3227,7 @@ struct btf_field_info {
 		struct {
 			const char *node_name;
 			u32 value_btf_id;
-		} list_head;
+		} datastructure_head;
 	};
 };
=20
@@ -3334,8 +3334,8 @@ static int btf_find_list_head(const struct btf *btf=
, const struct btf_type *pt,
 		return -EINVAL;
 	info->type =3D BPF_LIST_HEAD;
 	info->off =3D off;
-	info->list_head.value_btf_id =3D id;
-	info->list_head.node_name =3D list_node;
+	info->datastructure_head.value_btf_id =3D id;
+	info->datastructure_head.node_name =3D list_node;
 	return BTF_FIELD_FOUND;
 }
=20
@@ -3603,13 +3603,14 @@ static int btf_parse_list_head(const struct btf *=
btf, struct btf_field *field,
 	u32 offset;
 	int i;
=20
-	t =3D btf_type_by_id(btf, info->list_head.value_btf_id);
+	t =3D btf_type_by_id(btf, info->datastructure_head.value_btf_id);
 	/* We've already checked that value_btf_id is a struct type. We
 	 * just need to figure out the offset of the list_node, and
 	 * verify its type.
 	 */
 	for_each_member(i, t, member) {
-		if (strcmp(info->list_head.node_name, __btf_name_by_offset(btf, member=
->name_off)))
+		if (strcmp(info->datastructure_head.node_name,
+			   __btf_name_by_offset(btf, member->name_off)))
 			continue;
 		/* Invalid BTF, two members with same name */
 		if (n)
@@ -3626,9 +3627,9 @@ static int btf_parse_list_head(const struct btf *bt=
f, struct btf_field *field,
 		if (offset % __alignof__(struct bpf_list_node))
 			return -EINVAL;
=20
-		field->list_head.btf =3D (struct btf *)btf;
-		field->list_head.value_btf_id =3D info->list_head.value_btf_id;
-		field->list_head.node_offset =3D offset;
+		field->datastructure_head.btf =3D (struct btf *)btf;
+		field->datastructure_head.value_btf_id =3D info->datastructure_head.va=
lue_btf_id;
+		field->datastructure_head.node_offset =3D offset;
 	}
 	if (!n)
 		return -ENOENT;
@@ -3735,11 +3736,11 @@ int btf_check_and_fixup_fields(const struct btf *=
btf, struct btf_record *rec)
=20
 		if (!(rec->fields[i].type & BPF_LIST_HEAD))
 			continue;
-		btf_id =3D rec->fields[i].list_head.value_btf_id;
+		btf_id =3D rec->fields[i].datastructure_head.value_btf_id;
 		meta =3D btf_find_struct_meta(btf, btf_id);
 		if (!meta)
 			return -EFAULT;
-		rec->fields[i].list_head.value_rec =3D meta->record;
+		rec->fields[i].datastructure_head.value_rec =3D meta->record;
=20
 		if (!(rec->field_mask & BPF_LIST_NODE))
 			continue;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cca642358e80..6c67740222c2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1737,12 +1737,12 @@ void bpf_list_head_free(const struct btf_field *f=
ield, void *list_head,
 	while (head !=3D orig_head) {
 		void *obj =3D head;
=20
-		obj -=3D field->list_head.node_offset;
+		obj -=3D field->datastructure_head.node_offset;
 		head =3D head->next;
 		/* The contained type can also have resources, including a
 		 * bpf_list_head which needs to be freed.
 		 */
-		bpf_obj_free_fields(field->list_head.value_rec, obj);
+		bpf_obj_free_fields(field->datastructure_head.value_rec, obj);
 		/* bpf_mem_free requires migrate_disable(), since we can be
 		 * called from map free path as well apart from BPF program (as
 		 * part of map ops doing bpf_obj_free_fields).
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f0aac837d77..bc80b4c4377b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8615,21 +8615,22 @@ static int process_kf_arg_ptr_to_list_node(struct=
 bpf_verifier_env *env,
=20
 	field =3D meta->arg_list_head.field;
=20
-	et =3D btf_type_by_id(field->list_head.btf, field->list_head.value_btf_=
id);
+	et =3D btf_type_by_id(field->datastructure_head.btf, field->datastructu=
re_head.value_btf_id);
 	t =3D btf_type_by_id(reg->btf, reg->btf_id);
-	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->l=
ist_head.btf,
-				  field->list_head.value_btf_id, true)) {
+	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->d=
atastructure_head.btf,
+				  field->datastructure_head.value_btf_id, true)) {
 		verbose(env, "operation on bpf_list_head expects arg#1 bpf_list_node a=
t offset=3D%d "
 			"in struct %s, but arg is at offset=3D%d in struct %s\n",
-			field->list_head.node_offset, btf_name_by_offset(field->list_head.btf=
, et->name_off),
+			field->datastructure_head.node_offset,
+			btf_name_by_offset(field->datastructure_head.btf, et->name_off),
 			list_node_off, btf_name_by_offset(reg->btf, t->name_off));
 		return -EINVAL;
 	}
=20
-	if (list_node_off !=3D field->list_head.node_offset) {
+	if (list_node_off !=3D field->datastructure_head.node_offset) {
 		verbose(env, "arg#1 offset=3D%d, but expected bpf_list_node at offset=3D=
%d in struct %s\n",
-			list_node_off, field->list_head.node_offset,
-			btf_name_by_offset(field->list_head.btf, et->name_off));
+			list_node_off, field->datastructure_head.node_offset,
+			btf_name_by_offset(field->datastructure_head.btf, et->name_off));
 		return -EINVAL;
 	}
 	/* Set arg#1 for expiration after unlock */
@@ -9078,9 +9079,9 @@ static int check_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
=20
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D field->list_head.btf;
-				regs[BPF_REG_0].btf_id =3D field->list_head.value_btf_id;
-				regs[BPF_REG_0].off =3D field->list_head.node_offset;
+				regs[BPF_REG_0].btf =3D field->datastructure_head.btf;
+				regs[BPF_REG_0].btf_id =3D field->datastructure_head.value_btf_id;
+				regs[BPF_REG_0].off =3D field->datastructure_head.node_offset;
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx]) {
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
--=20
2.30.2

