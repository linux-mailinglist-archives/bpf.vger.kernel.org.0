Return-Path: <bpf+bounces-19407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE282BA49
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 05:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017841F26381
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 04:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DAF22090;
	Fri, 12 Jan 2024 04:17:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8421B281
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A1B822C8FE519; Thu, 11 Jan 2024 20:16:49 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Fix a 'unused function' compilation error
Date: Thu, 11 Jan 2024 20:16:49 -0800
Message-Id: <20240112041649.2891872-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Building the kernel with latest llvm18, I hit the following error:

 /home/yhs/work/bpf-next/kernel/bpf/verifier.c:4383:13: error: unused fun=
ction '__is_scalar_unbounded' [-Werror,-Wunused-function]
  4383 | static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
       |             ^~~~~~~~~~~~~~~~~~~~~
 1 error generated.

Patches [1] and [2] are in the same patch set. Patch [1] removed
the usage of __is_scalar_unbounded(), and patch [2] re-introduced
the usage of the function. Currently patch [1] is merged into
bpf-next while patch [2] does not, hence the above compilation
error is triggered.

To fix the compilation failure, let us temporarily make
__is_scalar_unbounded() not accessible through macro '#if 0'.
It can be re-introduced later when [2] is ready to merge.

  [1] https://lore.kernel.org/bpf/20240108205209.838365-11-maxtram95@gmai=
l.com/
  [2] https://lore.kernel.org/bpf/20240108205209.838365-15-maxtram95@gmai=
l.com/

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7ddad07ae928..e1f42082f32f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4380,6 +4380,7 @@ static u64 reg_const_value(struct bpf_reg_state *re=
g, bool subreg32)
 	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.value;
 }
=20
+#if 0
 static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
 {
 	return tnum_is_unknown(reg->var_off) &&
@@ -4388,6 +4389,7 @@ static bool __is_scalar_unbounded(struct bpf_reg_st=
ate *reg)
 	       reg->s32_min_value =3D=3D S32_MIN && reg->s32_max_value =3D=3D S=
32_MAX &&
 	       reg->u32_min_value =3D=3D 0 && reg->u32_max_value =3D=3D U32_MAX=
;
 }
+#endif
=20
 static bool __is_pointer_value(bool allow_ptr_leaks,
 			       const struct bpf_reg_state *reg)
--=20
2.34.1


