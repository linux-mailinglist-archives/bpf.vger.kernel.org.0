Return-Path: <bpf+bounces-7189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F9772D70
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 20:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB6E280CAE
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA6156EC;
	Mon,  7 Aug 2023 17:57:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35924171A7
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 17:57:39 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7E10F3
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 10:57:38 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 8C069245D52DF; Mon,  7 Aug 2023 10:57:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 1/2] bpf: Fix an incorrect verification success with movsx insn
Date: Mon,  7 Aug 2023 10:57:21 -0700
Message-Id: <20230807175721.671696-1-yonghong.song@linux.dev>
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

syzbot reports a verifier bug which triggers a runtime panic.
The test bpf program is:
   0: (62) *(u32 *)(r10 -8) =3D 553656332
   1: (bf) r1 =3D (s16)r10
   2: (07) r1 +=3D -8
   3: (b7) r2 =3D 3
   4: (bd) if r2 <=3D r1 goto pc+0
   5: (85) call bpf_trace_printk#-138320
   6: (b7) r0 =3D 0
   7: (95) exit

At insn 1, the current implementation keeps 'r1' as a frame pointer,
which caused later bpf_trace_printk helper call crash since frame
pointer address is not valid any more. Note that at insn 4,
the 'pointer vs. scalar' comparison is allowed for privileged
prog run.

To fix the problem with above insn 1, the fix in the patch adopts
similar pattern to existing 'R1 =3D (u32) R2' handling. For unprivileged
prog run, verification will fail with 'R<num> sign-extension part of poin=
ter'.
For privileged prog run, the dst_reg 'r1' will be marked as
an unknown scalar, so later 'bpf_trace_pointk' helper will complain
since it expected certain pointers.

Reported-by: syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com
Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 132f25dab931..4ccca1f6c998 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13165,17 +13165,26 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
 					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
 				} else {
 					/* case: R1 =3D (s8, s16 s32)R2 */
-					bool no_sext;
-
-					no_sext =3D src_reg->umax_value < (1ULL << (insn->off - 1));
-					if (no_sext && need_id)
-						src_reg->id =3D ++env->id_gen;
-					copy_register_state(dst_reg, src_reg);
-					if (!no_sext)
-						dst_reg->id =3D 0;
-					coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
-					dst_reg->live |=3D REG_LIVE_WRITTEN;
-					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
+					if (is_pointer_value(env, insn->src_reg)) {
+						verbose(env,
+							"R%d sign-extension part of pointer\n",
+							insn->src_reg);
+						return -EACCES;
+					} else if (src_reg->type =3D=3D SCALAR_VALUE) {
+						bool no_sext;
+
+						no_sext =3D src_reg->umax_value < (1ULL << (insn->off - 1));
+						if (no_sext && need_id)
+							src_reg->id =3D ++env->id_gen;
+						copy_register_state(dst_reg, src_reg);
+						if (!no_sext)
+							dst_reg->id =3D 0;
+						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
+						dst_reg->live |=3D REG_LIVE_WRITTEN;
+						dst_reg->subreg_def =3D DEF_NOT_SUBREG;
+					} else {
+						mark_reg_unknown(env, regs, insn->dst_reg);
+					}
 				}
 			} else {
 				/* R1 =3D (u32) R2 */
--=20
2.34.1


