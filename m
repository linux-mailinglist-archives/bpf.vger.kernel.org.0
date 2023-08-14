Return-Path: <bpf+bounces-7755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0677BF01
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C291C20A0B
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FFFCA50;
	Mon, 14 Aug 2023 17:29:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DAC2FF
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:29:28 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0873810D0
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:29:26 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2CCBA24C220BF; Mon, 14 Aug 2023 10:29:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 12/15] bpf: Allow bpf_spin_lock and bpf_list_head in allocated percpu data structure
Date: Mon, 14 Aug 2023 10:29:12 -0700
Message-Id: <20230814172912.1367692-1-yonghong.song@linux.dev>
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

Currently, bpf_percpu_obj_new() only allows scalar struct. A scalar struc=
t contains
scalar member or a struct with scalar member up to 3 nested struct levels=
.
For example, below is a linked list in the per cpu object:
  struct val_t {
       long b, c, d;
       struct bpf_list_head head __contains(foo, node);
       struct bpf_spin_lock lock;
  };
  struct map_val_t {
       ...
       struct val_t __percpu *pc;
       ...
  };

This patch added verifier support for the above percpu struct
with bpf_spin_lock and bpf_list_head. The change is mostly to
add MEM_RCU to various type checking places since the eventual
per cpu object is marked as MEM_RCU, which is used as the input
to various helpers/kfuncs like bpf_spin_lock(), bpf_spin_unlock()
and bpf_list_push_back(), etc.

Another possible use case is bpf_rb_root where a rb tree is
in a percpu struct. The support can be added similarly in
the future if needed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6fa458e13bfc..4c3045c8d25f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7848,6 +7848,8 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 		type &=3D ~MEM_ALLOC;
 		type &=3D ~MEM_PERCPU;
 	}
+	if (meta->func_id =3D=3D BPF_FUNC_spin_lock || meta->func_id =3D=3D BPF=
_FUNC_spin_unlock)
+		type &=3D ~MEM_RCU;
=20
 	for (i =3D 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected =3D compatible->types[i];
@@ -7929,6 +7931,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 		}
 		break;
 	}
+	case PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 		if (meta->func_id !=3D BPF_FUNC_spin_lock && meta->func_id !=3D BPF_FU=
NC_spin_unlock &&
 		    meta->func_id !=3D BPF_FUNC_kptr_xchg) {
@@ -8040,6 +8043,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
+	case PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
@@ -10604,8 +10608,8 @@ static int ref_convert_owning_non_owning(struct b=
pf_verifier_env *env, u32 ref_o
  *	active_lock.ptr =3D Register's type specific pointer
  *	active_lock.id  =3D A unique ID for each register pointer value
  *
- * Currently, PTR_TO_MAP_VALUE and PTR_TO_BTF_ID | MEM_ALLOC are the two
- * supported register types.
+ * Currently, PTR_TO_MAP_VALUE, PTR_TO_BTF_ID | MEM_ALLOC and
+ * PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU are the three supported register =
types.
  *
  * The active_lock.ptr in case of map values is the reg->map_ptr, and in=
 case of
  * allocated objects is the reg->btf pointer.
@@ -10640,6 +10644,7 @@ static int check_reg_allocation_locked(struct bpf=
_verifier_env *env, struct bpf_
 		ptr =3D reg->map_ptr;
 		break;
 	case PTR_TO_BTF_ID | MEM_ALLOC:
+	case PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU:
 		ptr =3D reg->btf;
 		break;
 	default:
@@ -11140,7 +11145,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_LIST_HEAD:
 			if (reg->type !=3D PTR_TO_MAP_VALUE &&
-			    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+			    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC) &&
+			    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU)) {
 				verbose(env, "arg#%d expected pointer to map value or allocated obje=
ct\n", i);
 				return -EINVAL;
 			}
--=20
2.34.1


