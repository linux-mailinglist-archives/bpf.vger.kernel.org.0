Return-Path: <bpf+bounces-16133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC387FD026
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 08:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB931C20A6B
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84946111B8;
	Wed, 29 Nov 2023 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6489D1710
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 23:54:22 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D1D352AA9DF89; Tue, 28 Nov 2023 23:54:09 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf] bpf: Fix a verifier bug due to incorrect branch offset comparison with cpu=v4
Date: Tue, 28 Nov 2023 23:54:09 -0800
Message-Id: <20231129075409.2709587-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bpf cpu=3Dv4 support is introduced in [1] and Commit 4cd58e9af8b9
("bpf: Support new 32bit offset jmp instruction") added support for new
32bit offset jmp instruction. Unfortunately, in function
bpf_adj_delta_to_off(), for new branch insn with 32bit offset, the offset
(plus/minor a small delta) compares to 16-bit offset bound
[S16_MIN, S16_MAX], which caused the following verification failure:
  $ ./test_progs-cpuv4 -t verif_scale_pyperf180
  ...
  insn 10 cannot be patched due to 16-bit range
  ...
  libbpf: failed to load object 'pyperf180.bpf.o'
  scale_test:FAIL:expect_success unexpected error: -12 (errno 12)
  #405     verif_scale_pyperf180:FAIL

Note that due to recent llvm18 development, the patch [2] (already applie=
d
in bpf-next) needs to be applied to bpf tree for testing purpose.

The fix is rather simple. For 32bit offset branch insn, the adjusted
offset compares to [S32_MIN, S32_MAX] and then verification succeeded.

  [1] https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@=
linux.dev
  [2] https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@=
linux.dev

Fixes: 4cd58e9af8b9 ("bpf: Support new 32bit offset jmp instruction")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cd3afe57ece3..74f2fd48148c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -371,14 +371,17 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *in=
sn, u32 pos, s32 end_old,
 static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_=
old,
 				s32 end_new, s32 curr, const bool probe_pass)
 {
-	const s32 off_min =3D S16_MIN, off_max =3D S16_MAX;
+	s32 off_min =3D S16_MIN, off_max =3D S16_MAX;
 	s32 delta =3D end_new - end_old;
 	s32 off;
=20
-	if (insn->code =3D=3D (BPF_JMP32 | BPF_JA))
+	if (insn->code =3D=3D (BPF_JMP32 | BPF_JA)) {
 		off =3D insn->imm;
-	else
+		off_min =3D S32_MIN;
+		off_max =3D S32_MAX;
+	} else {
 		off =3D insn->off;
+	}
=20
 	if (curr < pos && curr + off + 1 >=3D end_old)
 		off +=3D delta;
--=20
2.34.1


