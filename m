Return-Path: <bpf+bounces-8215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E37838F6
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 07:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F93F1C20A1E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5461C20;
	Tue, 22 Aug 2023 05:01:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13E15CB
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:01:09 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86811C
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:01:07 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 65456252EEC07; Mon, 21 Aug 2023 22:00:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
Date: Mon, 21 Aug 2023 22:00:53 -0700
Message-Id: <20230822050053.2886960-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
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

When reviewing local percpu kptr support, Alexei discovered a bug
wherea bpf_kptr_xchg() may succeed even if the map value kptr type and
locally allocated obj type do not match ([1]). Missed struct btf_id
comparison is the reason for the bug. This patch added such struct btf_id
comparison and will flag verification failure if types do not match.

  [1] https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook=
-pro-8.dhcp.thefacebook.com/#t

Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 738c96d5e2e3 ("bpf: Allow local kptrs to be exchanged via bpf_kptr=
_xchg")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

Changelogs:
  v1 -> v2:
    - call map_kptr_match_type() instead of btf_struct_ids_match().

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ccca1f6c998..3a91bfd7b9cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4990,20 +4990,22 @@ static int map_kptr_match_type(struct bpf_verifie=
r_env *env,
 			       struct bpf_reg_state *reg, u32 regno)
 {
 	const char *targ_name =3D btf_type_name(kptr_field->kptr.btf, kptr_fiel=
d->kptr.btf_id);
-	int perm_flags =3D PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
+	int perm_flags;
 	const char *reg_name =3D "";
=20
-	/* Only unreferenced case accepts untrusted pointers */
-	if (kptr_field->type =3D=3D BPF_KPTR_UNREF)
-		perm_flags |=3D PTR_UNTRUSTED;
+	if (btf_is_kernel(reg->btf)) {
+		perm_flags =3D PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
+
+		/* Only unreferenced case accepts untrusted pointers */
+		if (kptr_field->type =3D=3D BPF_KPTR_UNREF)
+			perm_flags |=3D PTR_UNTRUSTED;
+	} else {
+		perm_flags =3D PTR_MAYBE_NULL | MEM_ALLOC;
+	}
=20
 	if (base_type(reg->type) !=3D PTR_TO_BTF_ID || (type_flag(reg->type) & =
~perm_flags))
 		goto bad_type;
=20
-	if (!btf_is_kernel(reg->btf)) {
-		verbose(env, "R%d must point to kernel BTF\n", regno);
-		return -EINVAL;
-	}
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf =
*/
 	reg_name =3D btf_type_name(reg->btf, reg->btf_id);
=20
@@ -5016,7 +5018,7 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
 	if (__check_ptr_off_reg(env, reg, regno, true))
 		return -EACCES;
=20
-	/* A full type match is needed, as BTF can be vmlinux or module BTF, an=
d
+	/* A full type match is needed, as BTF can be vmlinux, module or prog B=
TF, and
 	 * we also need to take into account the reg->off.
 	 *
 	 * We want to support cases like:
@@ -7916,7 +7918,10 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 			verbose(env, "verifier internal error: unimplemented handling of MEM_=
ALLOC\n");
 			return -EFAULT;
 		}
-		/* Handled by helper specific checks */
+		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg) {
+			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
+				return -EACCES;
+		}
 		break;
 	case PTR_TO_BTF_ID | MEM_PERCPU:
 	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
--=20
2.34.1


