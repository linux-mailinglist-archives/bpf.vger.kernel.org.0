Return-Path: <bpf+bounces-6122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D8766104
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2D01C21745
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511715C3;
	Fri, 28 Jul 2023 01:12:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229A7C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:12:15 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614A30E0
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:12:05 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0BDCF23C7482F; Thu, 27 Jul 2023 18:11:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 00/17] bpf: Support new insns from cpu v4
Date: Thu, 27 Jul 2023 18:11:43 -0700
Message-Id: <20230728011143.3710005-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In previous discussion ([1]), it is agreed that we should introduce
cpu version 4 (llvm flag -mcpu=3Dv4) which contains some instructions
which can simplify code, make code easier to understand, fix the
existing problem, or simply for feature completeness. More specifically,
the following new insns are proposed:
  . sign extended load
  . sign extended mov
  . bswap
  . signed div/mod
  . ja with 32-bit offset

This patch set added kernel support for insns proposed in [1] except
BPF_ST which already has full kernel support. Beside the above proposed
insns, LLVM will generate BPF_ST insn as well under -mcpu=3Dv4.
The llvm patch ([2]) has been merged into llvm-project 'main' branch.

The patchset implements interpreter, jit and verifier support for these n=
ew
insns.

For this patch set, I tested cpu v2/v3/v4 and the selftests are all passe=
d.
I also tested selftests introduced in this patch set with additional chan=
ges
beside normal jit testing (bpf_jit_enable =3D 1 and bpf_jit_harden =3D 0)
  - bpf_jit_enable =3D 0
  - bpf_jit_enable =3D 1 and bpf_jit_harden =3D 1
and both testing passed.

  [1] https://lore.kernel.org/bpf/4bfe98be-5333-1c7e-2f6d-42486c8ec039@me=
ta.com/
  [2] https://reviews.llvm.org/D144829

Changelogs:
  v4 -> v5:
   . for v4, patch 8/17 missed in mailing list and patchwork, so resend.
   . rebase on top of master
  v3 -> v4:
   . some minor asm syntax adjustment based on llvm change.
   . add clang version and target arch guard for new tests
     so they can still compile with old llvm compilers.
   . some changes to the bpf doc.
  v2 -> v3:
   . add missed disasm change from v2.
   . handle signed load of ctx fields properly.
   . fix some interpreter sdiv/smod error when bpf_jit_enable =3D 0.
   . fix some verifier range bounding errors.
   . add more C tests.
  RFCv1 -> v2:
   . add more verifier supports for signed extend load and mov insns.
   . rename some insn names to be more consistent with intel practice.
   . add cpuv4 test runner for test progs.
   . add more unit and C tests.
   . add documentation.

Yonghong Song (17):
  bpf: Support new sign-extension load insns
  bpf: Support new sign-extension mov insns
  bpf: Handle sign-extenstin ctx member accesses
  bpf: Support new unconditional bswap instruction
  bpf: Support new signed div/mod instructions.
  bpf: Fix jit blinding with new sdiv/smov insns
  bpf: Support new 32bit offset jmp instruction
  bpf: Add kernel/bpftool asm support for new instructions
  selftests/bpf: Fix a test_verifier failure
  selftests/bpf: Add a cpuv4 test runner for cpu=3Dv4 testing
  selftests/bpf: Add unit tests for new sign-extension load insns
  selftests/bpf: Add unit tests for new sign-extension mov insns
  selftests/bpf: Add unit tests for new bswap insns
  selftests/bpf: Add unit tests for new sdiv/smod insns
  selftests/bpf: Add unit tests for new gotol insn
  selftests/bpf: Test ldsx with more complex cases
  docs/bpf: Add documentation for new instructions

 Documentation/bpf/bpf_design_QA.rst           |   5 -
 .../bpf/standardization/instruction-set.rst   | 115 ++-
 arch/x86/net/bpf_jit_comp.c                   | 141 +++-
 include/linux/filter.h                        |  17 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/core.c                             | 196 ++++-
 kernel/bpf/disasm.c                           |  57 +-
 kernel/bpf/verifier.c                         | 348 ++++++--
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  28 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   9 +-
 .../selftests/bpf/prog_tests/test_ldsx_insn.c | 139 ++++
 .../selftests/bpf/prog_tests/verifier.c       |  10 +
 .../selftests/bpf/progs/test_ldsx_insn.c      | 118 +++
 .../selftests/bpf/progs/verifier_bswap.c      |  59 ++
 .../selftests/bpf/progs/verifier_gotol.c      |  44 +
 .../selftests/bpf/progs/verifier_ldsx.c       | 131 +++
 .../selftests/bpf/progs/verifier_movsx.c      | 213 +++++
 .../selftests/bpf/progs/verifier_sdiv.c       | 781 ++++++++++++++++++
 .../selftests/bpf/verifier/basic_instr.c      |   6 +-
 21 files changed, 2251 insertions(+), 170 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_insn=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_movsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c

--=20
2.34.1


