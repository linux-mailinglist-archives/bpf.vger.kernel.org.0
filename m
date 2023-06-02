Return-Path: <bpf+bounces-1644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA471F865
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BB7281972
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5217E5;
	Fri,  2 Jun 2023 02:27:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E315AC
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:27:12 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F42180
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:27:11 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351Ntt2i020129
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 19:27:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=WnkbqwD469opZcsZwnn6tu/4uQcYVyNcJxQq+7/GH/M=;
 b=IGXS36vFb9rHdJbsK31LdSoQMztEKY5AdrC8upAbNZhAIpmF49hyQrpcI+2jBjrtg010
 WevrKyeiQzKpgEQKBgNUA619IgZBsMiJr7GgXa3gFVxsy0EU/xO/QrTdG2DuQ0yhnF8Q
 dc30ya9/XCAVlhRc8IzY+Wt5aKO4s0zkX1M= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxcvfhm8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 19:27:10 -0700
Received: from twshared9332.02.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 19:27:10 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 6D2A71EF7C8E3; Thu,  1 Jun 2023 19:26:55 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 6/9] [DONOTAPPLY] selftests/bpf: Add unsafe lock/unlock and refcount_read kfuncs to bpf_testmod
Date: Thu, 1 Jun 2023 19:26:44 -0700
Message-ID: <20230602022647.1571784-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602022647.1571784-1-davemarchevsky@fb.com>
References: <20230602022647.1571784-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JboYpShVh5WqsSkzjhVwFeh9w_L7fZfo
X-Proofpoint-GUID: JboYpShVh5WqsSkzjhVwFeh9w_L7fZfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[
RFC: This patch currently copies static inline helpers:

  __bpf_spin_lock
  __bpf_spin_unlock
  __bpf_spin_lock_irqsave
  __bpf_spin_unlock_irqrestore

from kernel/bpf/helpers.c . The definition of these helpers is
config-dependant and they're not meant to be called from a module, so
not sure how to proceed here.
]

This patch adds three unsafe kfuncs to bpf_testmod for use in
selftests:

  - bpf__unsafe_spin_lock
  - bpf__unsafe_spin_unlock
  - bpf_refcount_read

The first two are equivalent to bpf_spin_{lock, unlock}, except without
any special treatment from the verifier, which allows them to be used in
tests to guarantee a specific interleaving of program execution. This
will simplify testing race conditions in BPF programs, as demonstrated
in further patches in the series. The kfuncs are marked KF_DESTRUCTIVE
as they can easily cause deadlock, and are only intended to be used in
tests.

bpf_refcount_read simply reads the refcount from the uapi-opaque
bpf_refcount struct and returns it. This allows more precise testing of
specific bpf_refcount scenarios, also demonstrated in further patches in
the series. Although this kfunc can't break the system as
catastrophically as the unsafe locking kfuncs, it's also marked
KF_DESTRUCTIVE as it relies on bpf_refcount implementation details, and
shouldn't be used outside of tests regardless.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cf216041876c..abac7a212ec2 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -109,6 +109,64 @@ __bpf_kfunc void bpf_iter_testmod_seq_destroy(struct=
 bpf_iter_testmod_seq *it)
 	it->cnt =3D 0;
 }
=20
+/* BEGIN copied from kernel/bpf/helpers.c */
+static DEFINE_PER_CPU(unsigned long, irqsave_flags);
+
+static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
+{
+        arch_spinlock_t *l =3D (void *)lock;
+        union {
+                __u32 val;
+                arch_spinlock_t lock;
+        } u =3D { .lock =3D __ARCH_SPIN_LOCK_UNLOCKED };
+
+        compiletime_assert(u.val =3D=3D 0, "__ARCH_SPIN_LOCK_UNLOCKED no=
t 0");
+        BUILD_BUG_ON(sizeof(*l) !=3D sizeof(__u32));
+        BUILD_BUG_ON(sizeof(*lock) !=3D sizeof(__u32));
+        arch_spin_lock(l);
+}
+
+static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
+{
+        arch_spinlock_t *l =3D (void *)lock;
+
+        arch_spin_unlock(l);
+}
+
+static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
+{
+        unsigned long flags;
+
+        local_irq_save(flags);
+        __bpf_spin_lock(lock);
+        __this_cpu_write(irqsave_flags, flags);
+}
+
+static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lo=
ck)
+{
+        unsigned long flags;
+
+        flags =3D __this_cpu_read(irqsave_flags);
+        __bpf_spin_unlock(lock);
+        local_irq_restore(flags);
+}
+/* END copied from kernel/bpf/helpers.c */
+
+__bpf_kfunc void bpf__unsafe_spin_lock(void *lock__ign)
+{
+	__bpf_spin_lock_irqsave((struct bpf_spin_lock *)lock__ign);
+}
+
+__bpf_kfunc void bpf__unsafe_spin_unlock(void *lock__ign)
+{
+	__bpf_spin_unlock_irqrestore((struct bpf_spin_lock *)lock__ign);
+}
+
+__bpf_kfunc int bpf_refcount_read(void *refcount__ign)
+{
+	return refcount_read((refcount_t *)refcount__ign);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -283,6 +341,9 @@ BTF_SET8_START(bpf_testmod_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL=
)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf__unsafe_spin_lock, KF_DESTRUCTIVE)
+BTF_ID_FLAGS(func, bpf__unsafe_spin_unlock, KF_DESTRUCTIVE)
+BTF_ID_FLAGS(func, bpf_refcount_read, KF_DESTRUCTIVE)
 BTF_SET8_END(bpf_testmod_common_kfunc_ids)
=20
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set =3D {
--=20
2.34.1


