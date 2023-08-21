Return-Path: <bpf+bounces-8138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5307820C3
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 02:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DCE1C204F3
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 00:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490291C39;
	Mon, 21 Aug 2023 00:02:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DBD1849
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 00:02:47 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F6AA
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 17:02:45 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2AC10251CEEEB; Sun, 20 Aug 2023 17:02:30 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
Date: Sun, 20 Aug 2023 17:02:30 -0700
Message-Id: <20230821000230.3108635-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP autolearn=no autolearn_force=no
	version=3.4.6
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
 kernel/bpf/verifier.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 02a021c524ab..4e1ecd4b8497 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7745,7 +7745,18 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 			verbose(env, "verifier internal error: unimplemented handling of MEM_=
ALLOC\n");
 			return -EFAULT;
 		}
-		/* Handled by helper specific checks */
+		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg) {
+			struct btf_field *kptr_field =3D meta->kptr_field;
+
+			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
+						  kptr_field->kptr.btf, kptr_field->kptr.btf_id,
+						  true)) {
+				verbose(env, "R%d is of type %s but %s is expected\n",
+					regno, btf_type_name(reg->btf, reg->btf_id),
+					btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id));
+				return -EACCES;
+			}
+		}
 		break;
 	case PTR_TO_BTF_ID | MEM_PERCPU:
 	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
--=20
2.34.1


