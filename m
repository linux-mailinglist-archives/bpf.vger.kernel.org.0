Return-Path: <bpf+bounces-7753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696DD77BEFE
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CE6280EDA
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A030CA5E;
	Mon, 14 Aug 2023 17:29:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52653CA40
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:29:11 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB12A10DB
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:29:08 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0FB8E24C22056; Mon, 14 Aug 2023 10:28:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 09/15] bpf: Mark OBJ_RELEASE argument as MEM_RCU when possible
Date: Mon, 14 Aug 2023 10:28:57 -0700
Message-Id: <20230814172857.1366162-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814172809.1361446-1-yonghong.song@linux.dev>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
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
 kernel/bpf/verifier.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6fc200cb68b6..6fa458e13bfc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8854,8 +8854,15 @@ static int release_reference(struct bpf_verifier_e=
nv *env,
 		return err;
=20
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-		if (reg->ref_obj_id =3D=3D ref_obj_id)
-			mark_reg_invalid(env, reg);
+		if (reg->ref_obj_id =3D=3D ref_obj_id) {
+			if (in_rcu_cs(env) && (reg->type & MEM_ALLOC) && (reg->type & MEM_PER=
CPU)) {
+				reg->ref_obj_id =3D 0;
+				reg->type &=3D ~MEM_ALLOC;
+				reg->type |=3D MEM_RCU;
+			} else {
+				mark_reg_invalid(env, reg);
+			}
+		}
 	}));
=20
 	return 0;
--=20
2.34.1


