Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4145A6AFE
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiH3Rka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiH3RkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:40:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F12AA8318
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:37:08 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27UBSjjn011705
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5uFV82NmSqXGw01d54oYp2JuDAhn5np5/kV4LmVjmm0=;
 b=EkOkHeaxmQv2MFn3PQcWxzJ1uwUxCcwoBXev8LpK/zYQ2MbodxqAT4Lg7LRgeildo79z
 yj7iMSqWO6GsjyXun82OveE9xgMo5E6WgOHh0DlbIXRBeu0Nv5tEMw0uKWJniIzkznF6
 caF/oX1pNjBOcCnLlTpKlJbPpIW3sqUXptg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j9hpwjmdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:18 -0700
Received: from twshared14074.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:35:17 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 7B94ACAD078A; Tue, 30 Aug 2022 10:28:10 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 11/18] bpf: Check rbtree lock held during verification
Date:   Tue, 30 Aug 2022 10:27:52 -0700
Message-ID: <20220830172759.4069786-12-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: orJ_8fvw40SS0E_NtpbBN6reP4OoOajS
X-Proofpoint-GUID: orJ_8fvw40SS0E_NtpbBN6reP4OoOajS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch builds on the previous few locking patches, teaching the
verifier to check whether rbtree's lock is held.

[ RFC Notes:

  * After this patch, could change helpers which only can fail due to
    dynamic lock check to always succeed, likely allowing us to get rid
    of CONDITIONAL_RELEASE logic. But since dynamic lock checking is
    almost certainly going to be necessary regardless, didn't do so.
]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/rbtree.c   |  8 ++++++++
 kernel/bpf/verifier.c | 43 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d6458aa7b79c..b762c6b3dcfb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -155,6 +155,8 @@ struct bpf_map_ops {
 				     bpf_callback_t callback_fn,
 				     void *callback_ctx, u64 flags);
=20
+	bool (*map_lock_held)(struct bpf_map *map, void *current_lock);
+
 	/* BTF id of struct allocated by map_alloc */
 	int *map_btf_id;
=20
diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index 0821e841a518..b5d158254de6 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -245,6 +245,13 @@ static int rbtree_map_delete_elem(struct bpf_map *ma=
p, void *value)
 	return -ENOTSUPP;
 }
=20
+static bool rbtree_map_lock_held(struct bpf_map *map, void *current_lock=
)
+{
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+
+	return tree->lock =3D=3D current_lock;
+}
+
 BPF_CALL_2(bpf_rbtree_remove, struct bpf_map *, map, void *, value)
 {
 	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
@@ -353,4 +360,5 @@ const struct bpf_map_ops rbtree_map_ops =3D {
 	.map_delete_elem =3D rbtree_map_delete_elem,
 	.map_check_btf =3D rbtree_map_check_btf,
 	.map_btf_id =3D &bpf_rbtree_map_btf_ids[0],
+	.map_lock_held =3D rbtree_map_lock_held,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f8ba381f1327..3c9af1047d80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -508,16 +508,25 @@ static bool is_ptr_cast_function(enum bpf_func_id f=
unc_id)
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
 }
=20
+/* These functions can only be called when spinlock associated with rbtr=
ee
+ * is held. They all take struct bpf_map ptr to rbtree as their first ar=
gument,
+ * so we can verify that the correct lock is held before loading program
+ */
+static bool is_rbtree_lock_check_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_rbtree_add ||
+		func_id =3D=3D BPF_FUNC_rbtree_remove ||
+		func_id =3D=3D BPF_FUNC_rbtree_find;
+}
+
 /* These functions can only be called when spinlock associated with rbtr=
ee
  * is held. If they have a callback argument, that callback is not requi=
red
  * to release active_spin_lock before exiting
  */
 static bool is_rbtree_lock_required_function(enum bpf_func_id func_id)
 {
-	return func_id =3D=3D BPF_FUNC_rbtree_add ||
-		func_id =3D=3D BPF_FUNC_rbtree_remove ||
-		func_id =3D=3D BPF_FUNC_rbtree_find ||
-		func_id =3D=3D BPF_FUNC_rbtree_unlock;
+	return func_id =3D=3D BPF_FUNC_rbtree_unlock ||
+		is_rbtree_lock_check_function(func_id);
 }
=20
 /* These functions are OK to call when spinlock associated with rbtree
@@ -7354,6 +7363,26 @@ static void update_loop_inline_state(struct bpf_ve=
rifier_env *env, u32 subprogno
 				 state->callback_subprogno =3D=3D subprogno);
 }
=20
+static int check_rbtree_lock_held(struct bpf_verifier_env *env,
+				  struct bpf_map *map)
+{
+	struct bpf_verifier_state *cur =3D env->cur_state;
+
+	if (!map)
+		return -1;
+
+	if (!cur->active_spin_lock || !cur->maybe_active_spin_lock_addr ||
+	    !map || !map->ops->map_lock_held)
+		return -1;
+
+	if (!map->ops->map_lock_held(map, cur->maybe_active_spin_lock_addr)) {
+		verbose(env, "active spin lock doesn't match rbtree's lock\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
 			     int *insn_idx_p)
 {
@@ -7560,6 +7589,12 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 	if (err)
 		return err;
=20
+	if (is_rbtree_lock_check_function(func_id) &&
+	    check_rbtree_lock_held(env, meta.map_ptr)) {
+		verbose(env, "lock associated with rbtree is not held\n");
+		return -EINVAL;
+	}
+
 	/* reset caller saved regs */
 	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
--=20
2.30.2

