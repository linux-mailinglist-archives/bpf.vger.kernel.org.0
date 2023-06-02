Return-Path: <bpf+bounces-1639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A4D71F85D
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B52281992
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5015B3;
	Fri,  2 Jun 2023 02:27:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1925015A3
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:27:06 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6D184
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:27:01 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351NtU1D001147
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 19:27:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=R+PLP9Ajq/IVxQTuFFWfZSzFMlSvZnYS3K619WP2fS4=;
 b=bGefK7bPdINEomMLmsqnjlCtmvDs5VUeNA4XLaTz+RpJdlfvQvFcSy7LM9h3vl4MIoxI
 f8zzTam3VsbMZXVtwSpRgGjvg1SDKnBbBmOsPM1COCToW/jS7y2EpXTxwe2PiPAUt/Mg
 EMKDqJFWfFzWGWPABQtnvgCs2bhW5FTyYpc= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxxpa4574-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 19:27:01 -0700
Received: from twshared16624.09.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 19:26:59 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 5EF0E1EF7C8CB; Thu,  1 Jun 2023 19:26:54 -0700 (PDT)
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
	<davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH v2 bpf-next 4/9] bpf: Make bpf_refcount_acquire fallible for non-owning refs
Date: Thu, 1 Jun 2023 19:26:42 -0700
Message-ID: <20230602022647.1571784-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602022647.1571784-1-davemarchevsky@fb.com>
References: <20230602022647.1571784-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: VldP4yUdy_o8CS7MeSlgAHiBZWx4vJd8
X-Proofpoint-ORIG-GUID: VldP4yUdy_o8CS7MeSlgAHiBZWx4vJd8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

This patch fixes an incorrect assumption made in the original
bpf_refcount series [0], specifically that the BPF program calling
bpf_refcount_acquire on some node can always guarantee that the node is
alive. In that series, the patch adding failure behavior to rbtree_add
and list_push_{front, back} breaks this assumption for non-owning
references.

Consider the following program:

  n =3D bpf_kptr_xchg(&mapval, NULL);
  /* skip error checking */

  bpf_spin_lock(&l);
  if(bpf_rbtree_add(&t, &n->rb, less)) {
    bpf_refcount_acquire(n);
    /* Failed to add, do something else with the node */
  }
  bpf_spin_unlock(&l);

It's incorrect to assume that bpf_refcount_acquire will always succeed in t=
his
scenario. bpf_refcount_acquire is being called in a critical section
here, but the lock being held is associated with rbtree t, which isn't
necessarily the lock associated with the tree that the node is already
in. So after bpf_rbtree_add fails to add the node and calls bpf_obj_drop
in it, the program has no ownership of the node's lifetime. Therefore
the node's refcount can be decr'd to 0 at any time after the failing
rbtree_add. If this happens before the refcount_acquire above, the node
might be free'd, and regardless refcount_acquire will be incrementing a
0 refcount.

Later patches in the series exercise this scenario, resulting in the
expected complaint from the kernel (without this patch's changes):

  refcount_t: addition on 0; use-after-free.
  WARNING: CPU: 1 PID: 207 at lib/refcount.c:25 refcount_warn_saturate+0xbc=
/0x110
  Modules linked in: bpf_testmod(O)
  CPU: 1 PID: 207 Comm: test_progs Tainted: G           O       6.3.0-rc7-0=
2231-g723de1a718a2-dirty #371
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-=
g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
  RIP: 0010:refcount_warn_saturate+0xbc/0x110
  Code: 6f 64 f6 02 01 e8 84 a3 5c ff 0f 0b eb 9d 80 3d 5e 64 f6 02 00 75 9=
4 48 c7 c7 e0 13 d2 82 c6 05 4e 64 f6 02 01 e8 64 a3 5c ff <0f> 0b e9 7a ff=
 ff ff 80 3d 38 64 f6 02 00 0f 85 6d ff ff ff 48 c7
  RSP: 0018:ffff88810b9179b0 EFLAGS: 00010082
  RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
  RDX: 0000000000000202 RSI: 0000000000000008 RDI: ffffffff857c3680
  RBP: ffff88810027d3c0 R08: ffffffff8125f2a4 R09: ffff88810b9176e7
  R10: ffffed1021722edc R11: 746e756f63666572 R12: ffff88810027d388
  R13: ffff88810027d3c0 R14: ffffc900005fe030 R15: ffffc900005fe048
  FS:  00007fee0584a700(0000) GS:ffff88811b280000(0000) knlGS:0000000000000=
000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00005634a96f6c58 CR3: 0000000108ce9002 CR4: 0000000000770ee0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
   <TASK>
   bpf_refcount_acquire_impl+0xb5/0xc0

  (rest of output snipped)

The patch addresses this by changing bpf_refcount_acquire_impl to use
refcount_inc_not_zero instead of refcount_inc and marking
bpf_refcount_acquire KF_RET_NULL.

For owning references, though, we know the above scenario is not possible
and thus that bpf_refcount_acquire will always succeed. Some verifier
bookkeeping is added to track "is input owning ref?" for bpf_refcount_acqui=
re
calls and return false from is_kfunc_ret_null for bpf_refcount_acquire on
owning refs despite it being marked KF_RET_NULL.

Existing selftests using bpf_refcount_acquire are modified where
necessary to NULL-check its return value.

  [0]: https://lore.kernel.org/bpf/20230415201811.343116-1-davemarchevsky@f=
b.com/

Fixes: d2dcc67df910 ("bpf: Migrate bpf_rbtree_add and bpf_list_push_{front,=
back} to possibly fail")
Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c                          |  8 ++++--
 kernel/bpf/verifier.c                         | 26 +++++++++++++------
 .../selftests/bpf/progs/refcounted_kptr.c     |  2 ++
 .../bpf/progs/refcounted_kptr_fail.c          |  4 ++-
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a4e437eabcb4..9e80efa59a5d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1933,8 +1933,12 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p_=
_refcounted_kptr, void *meta
 	 * bpf_refcount type so that it is emitted in vmlinux BTF
 	 */
 	ref =3D (struct bpf_refcount *)(p__refcounted_kptr + meta->record->refcou=
nt_off);
+	if (!refcount_inc_not_zero((refcount_t *)ref))
+		return NULL;
=20
-	refcount_inc((refcount_t *)ref);
+	/* Verifier strips KF_RET_NULL if input is owned ref, see is_kfunc_ret_nu=
ll
+	 * in verifier.c
+	 */
 	return (void *)p__refcounted_kptr;
 }
=20
@@ -2406,7 +2410,7 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 43d26b65a3ad..48c3e2bbcc4a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -298,16 +298,19 @@ struct bpf_kfunc_call_arg_meta {
 		bool found;
 	} arg_constant;
=20
-	/* arg_btf and arg_btf_id are used by kfunc-specific handling,
+	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
 	 * generally to pass info about user-defined local kptr types to later
 	 * verification logic
 	 *   bpf_obj_drop
 	 *     Record the local kptr type to be drop'd
 	 *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
-	 *     Record the local kptr type to be refcount_incr'd
+	 *     Record the local kptr type to be refcount_incr'd and use
+	 *     arg_owning_ref to determine whether refcount_acquire should be
+	 *     fallible
 	 */
 	struct btf *arg_btf;
 	u32 arg_btf_id;
+	bool arg_owning_ref;
=20
 	struct {
 		struct btf_field *field;
@@ -9678,11 +9681,6 @@ static bool is_kfunc_acquire(struct bpf_kfunc_call_a=
rg_meta *meta)
 	return meta->kfunc_flags & KF_ACQUIRE;
 }
=20
-static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return meta->kfunc_flags & KF_RET_NULL;
-}
-
 static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_RELEASE;
@@ -9998,6 +9996,16 @@ BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
=20
+static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
+{
+	if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_impl]=
 &&
+	    meta->arg_owning_ref) {
+		return false;
+	}
+
+	return meta->kfunc_flags & KF_RET_NULL;
+}
+
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *met=
a)
 {
 	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_rcu_read_lock];
@@ -10880,10 +10888,12 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			meta->subprogno =3D reg->subprogno;
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
-			if (!type_is_ptr_alloc_obj(reg->type) && !type_is_non_owning_ref(reg->t=
ype)) {
+			if (!type_is_ptr_alloc_obj(reg->type)) {
 				verbose(env, "arg#%d is neither owning or non-owning ref\n", i);
 				return -EINVAL;
 			}
+			if (!type_is_non_owning_ref(reg->type))
+				meta->arg_owning_ref =3D true;
=20
 			rec =3D reg_btf_record(reg);
 			if (!rec) {
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/te=
sting/selftests/bpf/progs/refcounted_kptr.c
index 1d348a225140..a3da610b1e6b 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -375,6 +375,8 @@ long rbtree_refcounted_node_ref_escapes(void *ctx)
 	bpf_rbtree_add(&aroot, &n->node, less_a);
 	m =3D bpf_refcount_acquire(n);
 	bpf_spin_unlock(&alock);
+	if (!m)
+		return 2;
=20
 	m->key =3D 2;
 	bpf_obj_drop(m);
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/too=
ls/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index efcb308f80ad..0b09e5c915b1 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_=
rb_node *b)
 }
=20
 SEC("?tc")
-__failure __msg("Unreleased reference id=3D3 alloc_insn=3D21")
+__failure __msg("Unreleased reference id=3D4 alloc_insn=3D21")
 long rbtree_refcounted_node_ref_escapes(void *ctx)
 {
 	struct node_acquire *n, *m;
@@ -43,6 +43,8 @@ long rbtree_refcounted_node_ref_escapes(void *ctx)
 	/* m becomes an owning ref but is never drop'd or added to a tree */
 	m =3D bpf_refcount_acquire(n);
 	bpf_spin_unlock(&glock);
+	if (!m)
+		return 2;
=20
 	m->key =3D 2;
 	return 0;
--=20
2.34.1


