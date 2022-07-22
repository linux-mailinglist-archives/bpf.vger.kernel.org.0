Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636A657E699
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGVSfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiGVSfE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11C89A72
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:03 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MC8QaH022622
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=j5IY34dMDkvyjKrSadECn8GfqDBNSp5UxYVCEHBrmXE=;
 b=GgeMBdTtLBkX9JxRQgLWOUjXFDYrJWj3+COZqxXwE44rVw6JAOw6XSYDNvZwqa8QWhaD
 KIH5hDizDfs4uYGXGiz7I9NZlVoxupNP1zixTIDt8Djv/I7tLMFgwTlKnGKWhmhrNwey
 wye2Q49cByLjQQ3VDdhv65OBV7l3WLfbXWg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf7fc10es-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:02 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:35:00 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 9966FAB6F1A1; Fri, 22 Jul 2022 11:34:49 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 06/11] bpf: Add bpf_rbtree_{lock,unlock} helpers
Date:   Fri, 22 Jul 2022 11:34:33 -0700
Message-ID: <20220722183438.3319790-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Yhrjpf-jfd84HC1dEsP_5VMWiCxg-Mdq
X-Proofpoint-ORIG-GUID: Yhrjpf-jfd84HC1dEsP_5VMWiCxg-Mdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These helpers are equivalent to bpf_spin_{lock,unlock}, but the verifier
doesn't try to enforce that no helper calls occur when there's an active
spin lock.

[ TODO: Currently the verifier doesn't do _anything_ spinlock related
when it sees one of these, including setting active_spin_lock. This is
probably too lenient. Also, EXPORT_SYMBOL for internal lock helpers
might not be the best code structure. ]

Future patches will add enforcement of "rbtree helpers must always be
called when lock is held" constraint.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/uapi/linux/bpf.h       | 20 ++++++++++++++++++++
 kernel/bpf/helpers.c           | 12 ++++++++++--
 kernel/bpf/rbtree.c            | 29 +++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  2 ++
 tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++++
 5 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c677d92de3bc..d21e2c99ea14 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5391,6 +5391,24 @@ union bpf_attr {
  *
  *	Return
  *		Ptr to lock
+ *
+ * void *bpf_rbtree_lock(struct bpf_spin_lock *lock)
+ *	Description
+ *		Like bpf_spin_lock helper, but use separate helper for now
+ *		as we don't want this helper to have special meaning to the verifier
+ *		so that we can do rbtree helper calls between rbtree_lock/unlock
+ *
+ *	Return
+ *		0
+ *
+ * void *bpf_rbtree_unlock(struct bpf_spin_lock *lock)
+ *	Description
+ *		Like bpf_spin_unlock helper, but use separate helper for now
+ *		as we don't want this helper to have special meaning to the verifier
+ *		so that we can do rbtree helper calls between rbtree_lock/unlock
+ *
+ *	Return
+ *		0
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5607,6 +5625,8 @@ union bpf_attr {
 	FN(rbtree_remove),		\
 	FN(rbtree_free_node),		\
 	FN(rbtree_get_lock),		\
+	FN(rbtree_lock),		\
+	FN(rbtree_unlock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 257a808bb767..fa2dba1dcec8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -303,7 +303,7 @@ static inline void __bpf_spin_unlock(struct bpf_spin_=
lock *lock)
=20
 static DEFINE_PER_CPU(unsigned long, irqsave_flags);
=20
-static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
+inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
=20
@@ -311,6 +311,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf=
_spin_lock *lock)
 	__bpf_spin_lock(lock);
 	__this_cpu_write(irqsave_flags, flags);
 }
+EXPORT_SYMBOL(__bpf_spin_lock_irqsave);
=20
 notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
 {
@@ -325,7 +326,7 @@ const struct bpf_func_proto bpf_spin_lock_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_SPIN_LOCK,
 };
=20
-static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lo=
ck)
+inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
=20
@@ -333,6 +334,7 @@ static inline void __bpf_spin_unlock_irqrestore(struc=
t bpf_spin_lock *lock)
 	__bpf_spin_unlock(lock);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(__bpf_spin_unlock_irqrestore);
=20
 notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
 {
@@ -1588,6 +1590,8 @@ const struct bpf_func_proto bpf_rbtree_find_proto _=
_weak;
 const struct bpf_func_proto bpf_rbtree_remove_proto __weak;
 const struct bpf_func_proto bpf_rbtree_free_node_proto __weak;
 const struct bpf_func_proto bpf_rbtree_get_lock_proto __weak;
+const struct bpf_func_proto bpf_rbtree_lock_proto __weak;
+const struct bpf_func_proto bpf_rbtree_unlock_proto __weak;
=20
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
@@ -1689,6 +1693,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_rbtree_free_node_proto;
 	case BPF_FUNC_rbtree_get_lock:
 		return &bpf_rbtree_get_lock_proto;
+	case BPF_FUNC_rbtree_lock:
+		return &bpf_rbtree_lock_proto;
+	case BPF_FUNC_rbtree_unlock:
+		return &bpf_rbtree_unlock_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index c6f0a2a083f6..bf2e30af82ec 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -262,6 +262,35 @@ const struct bpf_func_proto bpf_rbtree_get_lock_prot=
o =3D {
 	.arg1_type =3D ARG_CONST_MAP_PTR,
 };
=20
+extern void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock);
+extern void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock);
+
+BPF_CALL_1(bpf_rbtree_lock, void *, lock)
+{
+	__bpf_spin_lock_irqsave((struct bpf_spin_lock *)lock);
+	return 0;
+}
+
+const struct bpf_func_proto bpf_rbtree_lock_proto =3D {
+	.func =3D bpf_rbtree_lock,
+	.gpl_only =3D true,
+	.ret_type =3D RET_INTEGER,
+	.arg1_type =3D ARG_PTR_TO_SPIN_LOCK,
+};
+
+BPF_CALL_1(bpf_rbtree_unlock, void *, lock)
+{
+	__bpf_spin_unlock_irqrestore((struct bpf_spin_lock *)lock);
+	return 0;
+}
+
+const struct bpf_func_proto bpf_rbtree_unlock_proto =3D {
+	.func =3D bpf_rbtree_unlock,
+	.gpl_only =3D true,
+	.ret_type =3D RET_INTEGER,
+	.arg1_type =3D ARG_PTR_TO_SPIN_LOCK,
+};
+
 BTF_ID_LIST_SINGLE(bpf_rbtree_map_btf_ids, struct, bpf_rbtree)
 const struct bpf_map_ops rbtree_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 535f673882cd..174a355d97fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6047,6 +6047,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		} else if (meta->func_id =3D=3D BPF_FUNC_spin_unlock) {
 			if (process_spin_lock(env, regno, false))
 				return -EACCES;
+		} else if (meta->func_id =3D=3D BPF_FUNC_rbtree_lock ||
+			   meta->func_id =3D=3D BPF_FUNC_rbtree_unlock) { // Do nothing for n=
ow
 		} else {
 			verbose(env, "verifier internal error\n");
 			return -EFAULT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index c677d92de3bc..d21e2c99ea14 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5391,6 +5391,24 @@ union bpf_attr {
  *
  *	Return
  *		Ptr to lock
+ *
+ * void *bpf_rbtree_lock(struct bpf_spin_lock *lock)
+ *	Description
+ *		Like bpf_spin_lock helper, but use separate helper for now
+ *		as we don't want this helper to have special meaning to the verifier
+ *		so that we can do rbtree helper calls between rbtree_lock/unlock
+ *
+ *	Return
+ *		0
+ *
+ * void *bpf_rbtree_unlock(struct bpf_spin_lock *lock)
+ *	Description
+ *		Like bpf_spin_unlock helper, but use separate helper for now
+ *		as we don't want this helper to have special meaning to the verifier
+ *		so that we can do rbtree helper calls between rbtree_lock/unlock
+ *
+ *	Return
+ *		0
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5607,6 +5625,8 @@ union bpf_attr {
 	FN(rbtree_remove),		\
 	FN(rbtree_free_node),		\
 	FN(rbtree_get_lock),		\
+	FN(rbtree_lock),		\
+	FN(rbtree_unlock),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

