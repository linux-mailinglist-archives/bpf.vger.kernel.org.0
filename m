Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC35A6AFB
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiH3Rjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiH3RjG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:39:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DDA136B20
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:36:16 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UAp7Ud031207
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:31:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=U3nZu1a49RK7Lk9vLSqUFpl1hmbrlApYlzGKZcCEpqA=;
 b=ec0TnLOYMtpYnRWhspHbg/zGU5KTqRY3fW2m7PlAtv1rQdZuPdKoDdMGRLWE2ZVy1qAc
 9x35tEWqLX1a9R3tfq/KS6NHIVWYDHYzLsc67AFWahgdVzYs+PjRykYh7+JEHjt8Hwmv
 QnEdT32DV6X/YiuGCeSoTF0Pi5auuxjP0iY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9h5djr9u-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:31:17 -0700
Received: from twshared11415.03.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:31:12 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 200B1CAD0778; Tue, 30 Aug 2022 10:28:09 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 07/18] bpf: Add bpf_rbtree_{lock,unlock} helpers
Date:   Tue, 30 Aug 2022 10:27:48 -0700
Message-ID: <20220830172759.4069786-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jMQaguVmKrUhBBvTyNFIixen1dlwksnA
X-Proofpoint-ORIG-GUID: jMQaguVmKrUhBBvTyNFIixen1dlwksnA
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
index 06d71207de0b..f4c615fbf64f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5415,6 +5415,24 @@ union bpf_attr {
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
@@ -5632,6 +5650,8 @@ union bpf_attr {
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
index ae974d0aa70d..0ca5fed1013b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -316,7 +316,7 @@ static inline void __bpf_spin_unlock(struct bpf_spin_=
lock *lock)
=20
 static DEFINE_PER_CPU(unsigned long, irqsave_flags);
=20
-static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
+inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
=20
@@ -324,6 +324,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf=
_spin_lock *lock)
 	__bpf_spin_lock(lock);
 	__this_cpu_write(irqsave_flags, flags);
 }
+EXPORT_SYMBOL(__bpf_spin_lock_irqsave);
=20
 notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
 {
@@ -338,7 +339,7 @@ const struct bpf_func_proto bpf_spin_lock_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_SPIN_LOCK,
 };
=20
-static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lo=
ck)
+inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
 {
 	unsigned long flags;
=20
@@ -346,6 +347,7 @@ static inline void __bpf_spin_unlock_irqrestore(struc=
t bpf_spin_lock *lock)
 	__bpf_spin_unlock(lock);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(__bpf_spin_unlock_irqrestore);
=20
 notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
 {
@@ -1604,6 +1606,8 @@ const struct bpf_func_proto bpf_rbtree_find_proto _=
_weak;
 const struct bpf_func_proto bpf_rbtree_remove_proto __weak;
 const struct bpf_func_proto bpf_rbtree_free_node_proto __weak;
 const struct bpf_func_proto bpf_rbtree_get_lock_proto __weak;
+const struct bpf_func_proto bpf_rbtree_lock_proto __weak;
+const struct bpf_func_proto bpf_rbtree_unlock_proto __weak;
=20
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
@@ -1707,6 +1711,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
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
index 0cc495b7cb26..641821ee1a7f 100644
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
index 0a2e958ddca8..b9e5d87fe323 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6057,6 +6057,8 @@ static int check_func_arg(struct bpf_verifier_env *=
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
index 06d71207de0b..f4c615fbf64f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5415,6 +5415,24 @@ union bpf_attr {
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
@@ -5632,6 +5650,8 @@ union bpf_attr {
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

