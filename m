Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB669557E
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 01:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBNAnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 19:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBNAnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 19:43:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C310A90
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:43:45 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31DLuKm3019161
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:43:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Xv2EpalGo8YFFN26J8lSGoT2mcB2y8qU+e8eteZ6heA=;
 b=FTWhVT5TZFGCnSmQtP9TSq93m8flVo3uyJV7dclUAZRzYrIYvC56mhR/bcCQzo7h4zUI
 aaxygw3l3QWK/k+Fgy/OBjlvUDnDna6nYXoxugfJ8qp02Xdp0DNIzSfxlB2FBHHQpq+g
 /rl588xDHEZs9nz4Qk36f/kqxZLM76Q4xgQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3np7de8th2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:43:45 -0800
Received: from twshared24176.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Feb 2023 16:43:44 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 3108516ED5D9D; Mon, 13 Feb 2023 16:40:32 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v6 bpf-next 5/8] bpf: Special verifier handling for bpf_rbtree_{remove, first}
Date:   Mon, 13 Feb 2023 16:40:14 -0800
Message-ID: <20230214004017.2534011-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214004017.2534011-1-davemarchevsky@fb.com>
References: <20230214004017.2534011-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oqYkr-YlMw34xY6z05Mr9POq5Bqdgmny
X-Proofpoint-ORIG-GUID: oqYkr-YlMw34xY6z05Mr9POq5Bqdgmny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
that require handling in the verifier:

  * both bpf_rbtree_remove and bpf_rbtree_first return the type containin=
g
    the bpf_rb_node field, with the offset set to that field's offset,
    instead of a struct bpf_rb_node *
    * mark_reg_graph_node helper added in previous patch generalizes
      this logic, use it

  * bpf_rbtree_remove's node input is a node that's been inserted
    in the tree - a non-owning reference.

  * bpf_rbtree_remove must invalidate non-owning references in order to
    avoid aliasing issue. Use previously-added
    invalidate_non_owning_refs helper to mark this function as a
    non-owning ref invalidation point.

  * Unlike other functions, which convert one of their input arg regs to
    non-owning reference, bpf_rbtree_first takes no arguments and just
    returns a non-owning reference (possibly null)
    * For now verifier logic for this is special-cased instead of
      adding new kfunc flag.

This patch, along with the previous one, complete special verifier
handling for all rbtree API functions added in this series.

With functional verifier handling of rbtree_remove, under current
non-owning reference scheme, a node type with both bpf_{list,rb}_node
fields could cause the verifier to accept programs which remove such
nodes from collections they haven't been added to.

In order to prevent this, this patch adds a check to btf_parse_fields
which rejects structs with both bpf_{list,rb}_node fields. This is a
temporary measure that can be removed after "collection identity"
followup. See comment added in btf_parse_fields. A linked_list BTF test
exercising the new check is added in this patch as well.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/btf.c                              | 24 +++++++++++
 kernel/bpf/verifier.c                         | 43 +++++++++++++------
 .../selftests/bpf/prog_tests/linked_list.c    | 37 ++++++++++++++++
 3 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b9d1f5c4e316..6582735ef1fc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3768,6 +3768,30 @@ struct btf_record *btf_parse_fields(const struct b=
tf *btf, const struct btf_type
 		goto end;
 	}
=20
+	/* need collection identity for non-owning refs before allowing this
+	 *
+	 * Consider a node type w/ both list and rb_node fields:
+	 *   struct node {
+	 *     struct bpf_list_node l;
+	 *     struct bpf_rb_node r;
+	 *   }
+	 *
+	 * Used like so:
+	 *   struct node *n =3D bpf_obj_new(....);
+	 *   bpf_list_push_front(&list_head, &n->l);
+	 *   bpf_rbtree_remove(&rb_root, &n->r);
+	 *
+	 * It should not be possible to rbtree_remove the node since it hasn't
+	 * been added to a tree. But push_front converts n to a non-owning
+	 * reference, and rbtree_remove accepts the non-owning reference to
+	 * a type w/ bpf_rb_node field.
+	 */
+	if (btf_record_has_field(rec, BPF_LIST_NODE) &&
+	    btf_record_has_field(rec, BPF_RB_NODE)) {
+		ret =3D -EINVAL;
+		goto end;
+	}
+
 	return rec;
 end:
 	btf_record_free(rec);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 88c8edf67007..21e08c111702 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9682,14 +9682,26 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_NODE:
-			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "arg#%d expected pointer to allocated object\n", i);
-				return -EINVAL;
-			}
-			if (!reg->ref_obj_id) {
-				verbose(env, "allocated object must be referenced\n");
-				return -EINVAL;
+			if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove]) {
+				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
+					verbose(env, "rbtree_remove node input must be non-owning ref\n");
+					return -EINVAL;
+				}
+				if (in_rbtree_lock_required_cb(env)) {
+					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
+					return -EINVAL;
+				}
+			} else {
+				if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+					verbose(env, "arg#%d expected pointer to allocated object\n", i);
+					return -EINVAL;
+				}
+				if (!reg->ref_obj_id) {
+					verbose(env, "allocated object must be referenced\n");
+					return -EINVAL;
+				}
 			}
+
 			ret =3D process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
 			if (ret < 0)
 				return ret;
@@ -9940,11 +9952,12 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
=20
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D field->graph_root.btf;
-				regs[BPF_REG_0].btf_id =3D field->graph_root.value_btf_id;
-				regs[BPF_REG_0].off =3D field->graph_root.node_offset;
+				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
+			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remov=
e] ||
+				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first]) {
+				struct btf_field *field =3D meta.arg_rbtree_root.field;
+
+				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx]) {
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
@@ -10010,7 +10023,13 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 			if (is_kfunc_ret_null(&meta))
 				regs[BPF_REG_0].id =3D id;
 			regs[BPF_REG_0].ref_obj_id =3D id;
+		} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first]=
) {
+			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
+
+		if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove])
+			invalidate_non_owning_refs(env);
+
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].i=
d)
 			regs[BPF_REG_0].id =3D ++env->id_gen;
 	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index c456b34a823a..0ed8132ce1c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -715,6 +715,43 @@ static void test_btf(void)
 		btf__free(btf);
 		break;
 	}
+
+	while (test__start_subtest("btf: list_node and rb_node in same struct")=
) {
+		btf =3D init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+
+		id =3D btf__add_struct(btf, "bpf_rb_node", 24);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct bpf_rb_node"))
+			break;
+		id =3D btf__add_struct(btf, "bar", 40);
+		if (!ASSERT_EQ(id, 6, "btf__add_struct bar"))
+			break;
+		err =3D btf__add_field(btf, "a", LIST_NODE, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::a"))
+			break;
+		err =3D btf__add_field(btf, "c", 5, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::c"))
+			break;
+
+		id =3D btf__add_struct(btf, "foo", 20);
+		if (!ASSERT_EQ(id, 7, "btf__add_struct foo"))
+			break;
+		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err =3D btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		id =3D btf__add_decl_tag(btf, "contains:bar:a", 7, 0);
+		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag contains:bar:a"))
+			break;
+
+		err =3D btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -EINVAL, "check btf");
+		btf__free(btf);
+		break;
+	}
 }
=20
 void test_linked_list(void)
--=20
2.30.2

