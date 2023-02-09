Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33417690F62
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBIRmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 12:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBIRmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 12:42:06 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3843432F
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 09:42:02 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319H5slX012948
        for <bpf@vger.kernel.org>; Thu, 9 Feb 2023 09:42:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cVA+vMf6boodN1emFjsFImlj8ZxVm6PQ6jyAjr8DqxA=;
 b=AZakvsc2b3AS5qj7ARHz1RtXet9aBQGjWYFSn/qoTY6CChW+3G0BpSSLhwL5nu73lqbS
 lOEMXzX1WCbMZ+/6hWNc1EYLDyBqogLcxwnhy6DeFJTV/Y0Ka9tD7dsqrDZsNDrVZLyF
 EXtpeZnUKRsoRrZX91vvvgcbmaEN0O7l/98= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nn1bxj6yh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 09:42:01 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Thu, 9 Feb 2023 09:42:00 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id F0A2B16905FE6; Thu,  9 Feb 2023 09:41:48 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 02/11] bpf: Improve bpf_reg_state space usage for non-owning ref lock
Date:   Thu, 9 Feb 2023 09:41:35 -0800
Message-ID: <20230209174144.3280955-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230209174144.3280955-1-davemarchevsky@fb.com>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Qx3IEbjnhc1y-QrZVKcsA5LbDGAbsG6W
X-Proofpoint-GUID: Qx3IEbjnhc1y-QrZVKcsA5LbDGAbsG6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch eliminates extra bpf_reg_state memory usage added due to
previous patch keeping a copy of lock identity in reg state for
non-owning refs.

Instead of copying lock identity around, this patch changes
non_owning_ref_lock field to be a bool, taking advantage of the
following:

  * There can currently only be one active lock at a time
  * non-owning refs are only valid in the critical section

So if a verifier_state has an active_lock, any non-owning ref must've
been obtained under that lock, and any non-owning ref not obtained under
that lock must have been invalidated previously. Therefore if a
non-owning ref is associated with a lock, it's the active_lock of the
current state. So we can keep a bool "are we associated with active_lock
of current state" instead of copying lock identity around.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/verifier.c        | 25 ++++++++++---------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7b5fbb66446c..d25446dd0413 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -84,7 +84,7 @@ struct bpf_reg_state {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
-			struct bpf_active_lock non_owning_ref_lock;
+			bool non_owning_ref_lock;
 		};
=20
 		struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f693cc97c574..89c09752421c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -190,8 +190,7 @@ struct bpf_verifier_stack_elem {
=20
 static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
-static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
-				       struct bpf_active_lock *lock);
+static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static int ref_set_non_owning_lock(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg);
=20
@@ -1077,9 +1076,8 @@ static void print_verifier_state(struct bpf_verifie=
r_env *env,
 				verbose_a("id=3D%d", reg->id);
 			if (reg->ref_obj_id)
 				verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
-			if (reg->non_owning_ref_lock.ptr)
-				verbose_a("non_own_id=3D(%p,%d)", reg->non_owning_ref_lock.ptr,
-					  reg->non_owning_ref_lock.id);
+			if (reg->non_owning_ref_lock)
+				verbose_a("%s", "non_own_ref");
 			if (t !=3D SCALAR_VALUE)
 				verbose_a("off=3D%d", reg->off);
 			if (type_is_pkt_pointer(t))
@@ -5049,7 +5047,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 		}
=20
 		if (type_is_alloc(reg->type) && !reg->ref_obj_id &&
-		    !reg->non_owning_ref_lock.ptr) {
+		    !reg->non_owning_ref_lock) {
 			verbose(env, "verifier internal error: ref_obj_id for allocated objec=
t must be non-zero\n");
 			return -EFAULT;
 		}
@@ -6056,7 +6054,7 @@ static int process_spin_lock(struct bpf_verifier_en=
v *env, int regno,
 			return -EINVAL;
 		}
=20
-		invalidate_non_owning_refs(env, &cur->active_lock);
+		invalidate_non_owning_refs(env);
=20
 		cur->active_lock.ptr =3D NULL;
 		cur->active_lock.id =3D 0;
@@ -7373,16 +7371,14 @@ static int release_reference(struct bpf_verifier_=
env *env,
 	return 0;
 }
=20
-static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
-				       struct bpf_active_lock *lock)
+static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
=20
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
-		if (reg->non_owning_ref_lock.ptr &&
-		    reg->non_owning_ref_lock.ptr =3D=3D lock->ptr &&
-		    reg->non_owning_ref_lock.id =3D=3D lock->id)
+		if (type_is_ptr_alloc_obj(reg->type) &&
+		    reg->non_owning_ref_lock)
 			__mark_reg_unknown(env, reg);
 	}));
 }
@@ -8948,13 +8944,12 @@ static int ref_set_non_owning_lock(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 		return -EFAULT;
 	}
=20
-	if (reg->non_owning_ref_lock.ptr) {
+	if (reg->non_owning_ref_lock) {
 		verbose(env, "verifier internal error: non_owning_ref_lock already set=
\n");
 		return -EFAULT;
 	}
=20
-	reg->non_owning_ref_lock.id =3D state->active_lock.id;
-	reg->non_owning_ref_lock.ptr =3D state->active_lock.ptr;
+	reg->non_owning_ref_lock =3D true;
 	return 0;
 }
=20
--=20
2.30.2

