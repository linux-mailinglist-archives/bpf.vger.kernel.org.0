Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400BA683489
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjAaSBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjAaSBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:01:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A1D517
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:57 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGmeRc029056
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=v+c/70MypJFIvs1XcKMwtBJYxn4OY5FFZu0Dkbth0Nw=;
 b=fRBpDSWvH5o0AlQB5jRDWUpVbLnMSVJwquLqh4wEpa27XuKBXikclSRvzuD1rjRGlv4z
 16RLH/Ll9hsu8hD0dGuOOHUqO48dW5SUgdvFWGT2OGmxqSK/5R0fQioVWCoqZsNfkkG4
 WpNW+yPx0cQG+lfp/JajmOCgzmzvvVau/qs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nd29t8g26-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:56 -0800
Received: from twshared9608.03.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 31 Jan 2023 10:00:27 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 5AD9E15D5BB64; Tue, 31 Jan 2023 10:00:19 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 02/11] bpf: Improve bpf_reg_state space usage for non-owning ref lock
Date:   Tue, 31 Jan 2023 10:00:07 -0800
Message-ID: <20230131180016.3368305-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230131180016.3368305-1-davemarchevsky@fb.com>
References: <20230131180016.3368305-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NASF3pOzAyDC16TVVtxXy4qSZaoA7mvk
X-Proofpoint-ORIG-GUID: NASF3pOzAyDC16TVVtxXy4qSZaoA7mvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
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
 kernel/bpf/verifier.c        | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1c6bbde40705..baeb5afb0b81 100644
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
 		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4b1883ffcf21..ed816e824928 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -935,9 +935,8 @@ static void print_verifier_state(struct bpf_verifier_=
env *env,
 				verbose_a("id=3D%d", reg->id);
 			if (reg->ref_obj_id)
 				verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
-			if (reg->non_owning_ref_lock.ptr)
-				verbose_a("non_own_id=3D(%p,%d)", reg->non_owning_ref_lock.ptr,
-					  reg->non_owning_ref_lock.id);
+			if (reg->non_owning_ref_lock)
+				verbose(env, "non_own_ref,");
 			if (t !=3D SCALAR_VALUE)
 				verbose_a("off=3D%d", reg->off);
 			if (type_is_pkt_pointer(t))
@@ -4834,7 +4833,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
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
@@ -7085,13 +7084,15 @@ static int release_reference(struct bpf_verifier_=
env *env,
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
 				       struct bpf_active_lock *lock)
 {
+	struct bpf_active_lock *cur_state_lock;
 	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
=20
+	cur_state_lock =3D &env->cur_state->active_lock;
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
-		if (reg->non_owning_ref_lock.ptr &&
-		    reg->non_owning_ref_lock.ptr =3D=3D lock->ptr &&
-		    reg->non_owning_ref_lock.id =3D=3D lock->id)
+		if (reg->non_owning_ref_lock &&
+		    cur_state_lock->ptr =3D=3D lock->ptr &&
+		    cur_state_lock->id =3D=3D lock->id)
 			__mark_reg_unknown(env, reg);
 	}));
 }
@@ -8718,13 +8719,12 @@ static int ref_set_non_owning_lock(struct bpf_ver=
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

