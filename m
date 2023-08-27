Return-Path: <bpf+bounces-8802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E45789FF3
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1679280F34
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D10111AA;
	Sun, 27 Aug 2023 15:28:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6391096A
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 15:28:31 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F15D13E
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 08:28:30 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id AA791257ED012; Sun, 27 Aug 2023 08:28:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 09/13] bpf: Mark OBJ_RELEASE argument as MEM_RCU when possible
Date: Sun, 27 Aug 2023 08:28:16 -0700
Message-Id: <20230827152816.2000760-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827152729.1995219-1-yonghong.song@linux.dev>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In previous selftests/bpf patch, we have
  p =3D bpf_percpu_obj_new(struct val_t);
  if (!p)
          goto out;

  p1 =3D bpf_kptr_xchg(&e->pc, p);
  if (p1) {
          /* race condition */
          bpf_percpu_obj_drop(p1);
  }

  p =3D e->pc;
  if (!p)
          goto out;

After bpf_kptr_xchg(), we need to re-read e->pc into 'p'.
This is due to that the second argument of bpf_kptr_xchg() is marked
OBJ_RELEASE and it will be marked as invalid after the call.
So after bpf_kptr_xchg(), 'p' is an unknown scalar,
and the bpf program needs to reread from the map value.

This patch checks if the 'p' has type MEM_ALLOC and MEM_PERCPU,
and if 'p' is RCU protected. If this is the case, 'p' can be marked
as MEM_RCU. MEM_ALLOC needs to be removed since 'p' is not
an owning reference any more. Such a change makes re-read
from the map value unnecessary.

Note that re-reading 'e->pc' after bpf_kptr_xchg() might get
a different value from 'p' if immediately before 'p =3D e->pc',
another cpu may do another bpf_kptr_xchg() and swap in another value
into 'e->pc'. If this is the case, then 'p =3D e->pc' may
get either 'p' or another value, and race condition already exists.
So removing direct re-reading seems fine too.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b7e7ca611f3..dbba2b806017 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9660,6 +9660,26 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 				return -EFAULT;
 			}
 			err =3D unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
+		} else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.ref_obj_id) {
+			u32 ref_obj_id =3D meta.ref_obj_id;
+			bool in_rcu =3D in_rcu_cs(env);
+			struct bpf_func_state *state;
+			struct bpf_reg_state *reg;
+
+			err =3D release_reference_state(cur_func(env), ref_obj_id);
+			if (!err) {
+				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+					if (reg->ref_obj_id =3D=3D ref_obj_id) {
+						if (in_rcu && (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU))=
 {
+							reg->ref_obj_id =3D 0;
+							reg->type &=3D ~MEM_ALLOC;
+							reg->type |=3D MEM_RCU;
+						} else {
+							mark_reg_invalid(env, reg);
+						}
+					}
+				}));
+			}
 		} else if (meta.ref_obj_id) {
 			err =3D release_reference(env, meta.ref_obj_id);
 		} else if (register_is_null(&regs[meta.release_regno])) {
--=20
2.34.1


