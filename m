Return-Path: <bpf+bounces-6016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970B764216
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C2C1C2119F
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C891AA74;
	Wed, 26 Jul 2023 22:25:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C991BF1C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:25:05 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FF1BFF
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:25:04 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 866A123B79F33; Wed, 26 Jul 2023 15:08:14 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 09/17] selftests/bpf: Fix a test_verifier failure
Date: Wed, 26 Jul 2023 15:08:14 -0700
Message-Id: <20230726220814.1098150-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726220726.1089817-1-yonghong.song@linux.dev>
References: <20230726220726.1089817-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following test_verifier subtest failed due to
new encoding for BSWAP.

  $ ./test_verifier
  ...
  #99/u invalid 64-bit BPF_END FAIL
  Unexpected success to load!
  verification time 215 usec
  stack depth 0
  processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
  #99/p invalid 64-bit BPF_END FAIL
  Unexpected success to load!
  verification time 198 usec
  stack depth 0
  processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0

Tighten the test so it still reports a failure.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/verifier/basic_instr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/basic_instr.c b/tools/t=
esting/selftests/bpf/verifier/basic_instr.c
index 071dbc889e8c..bd928a72ad73 100644
--- a/tools/testing/selftests/bpf/verifier/basic_instr.c
+++ b/tools/testing/selftests/bpf/verifier/basic_instr.c
@@ -176,11 +176,11 @@
 	.retval =3D 1,
 },
 {
-	"invalid 64-bit BPF_END",
+	"invalid 64-bit BPF_END with BPF_TO_BE",
 	.insns =3D {
 	BPF_MOV32_IMM(BPF_REG_0, 0),
 	{
-		.code  =3D BPF_ALU64 | BPF_END | BPF_TO_LE,
+		.code  =3D BPF_ALU64 | BPF_END | BPF_TO_BE,
 		.dst_reg =3D BPF_REG_0,
 		.src_reg =3D 0,
 		.off   =3D 0,
@@ -188,7 +188,7 @@
 	},
 	BPF_EXIT_INSN(),
 	},
-	.errstr =3D "unknown opcode d7",
+	.errstr =3D "unknown opcode df",
 	.result =3D REJECT,
 },
 {
--=20
2.34.1


