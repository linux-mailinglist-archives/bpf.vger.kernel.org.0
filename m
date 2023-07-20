Return-Path: <bpf+bounces-5387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F06675A2FD
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5FC1C21237
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EEC263B8;
	Thu, 20 Jul 2023 00:01:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FC182AD
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:01:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E38172D
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:22 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMYajW025695
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=iZg0xAhIsRpYMGBQ2MyUx3GMf8URFweOA8IceXvJivM=;
 b=PwwZN+M85W/FTR86Rm8stLMyJe/qjN09kVSK5fy9uXTCFKQjVjnsRYFkcWRe+zcGzkYM
 /QMRPS+8HRsYOP+OveyY2REhySPMrpWExcdDTbYnFTxysxRMmIDvR+o+PsTyKhuCFk6W
 DnXROr5SZhJoFbscSywNW6Wh57vkcq9AS54= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxjpcktx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:22 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:01:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E0CC82354E718; Wed, 19 Jul 2023 17:01:03 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 00/17] bpf: Support new insns from cpu v4
Date: Wed, 19 Jul 2023 17:01:03 -0700
Message-ID: <20230720000103.99949-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uo49zUciusDl9IvRLmpkmdj4tjOrrJNa
X-Proofpoint-ORIG-GUID: uo49zUciusDl9IvRLmpkmdj4tjOrrJNa
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
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
insns, LLVM will generate BPF_ST insn as well under -mcpu=3Dv4 ([2]).

The patchset implements interpreter, jit and verifier support for these new
insns.

To test this patch set, you need to have latest llvm from 'main' branch
of llvm-project repo and apply [2] on top of it.

For this patch set, I tested cpu v2/v3/v4 and the selftests are all passed.
I also tested selftests introduced in this patch set with additional changes
beside normal jit testing (bpf_jit_enable =3D 1 and bpf_jit_harden =3D 0)
  - bpf_jit_enable =3D 0
  - bpf_jit_enable =3D 1 and bpf_jit_harden =3D 1
and both testing passed.

  [1] https://lore.kernel.org/bpf/4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta=
.com/
  [2] https://reviews.llvm.org/D144829

Changelogs:
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
 .../bpf/standardization/instruction-set.rst   | 105 ++-
 arch/x86/net/bpf_jit_comp.c                   | 141 +++-
 include/linux/filter.h                        |  17 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/core.c                             | 196 ++++-
 kernel/bpf/disasm.c                           |  57 +-
 kernel/bpf/verifier.c                         | 366 +++++++--
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  18 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   9 +-
 .../selftests/bpf/prog_tests/test_ldsx_insn.c | 124 +++
 .../selftests/bpf/prog_tests/verifier.c       |  10 +
 .../selftests/bpf/progs/test_ldsx_insn.c      | 112 +++
 .../selftests/bpf/progs/verifier_bswap.c      |  45 +
 .../selftests/bpf/progs/verifier_gotol.c      |  30 +
 .../selftests/bpf/progs/verifier_ldsx.c       | 117 +++
 .../selftests/bpf/progs/verifier_movsx.c      | 199 +++++
 .../selftests/bpf/progs/verifier_sdiv.c       | 767 ++++++++++++++++++
 .../selftests/bpf/verifier/basic_instr.c      |   6 +-
 21 files changed, 2159 insertions(+), 169 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_movsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c

--=20
2.34.1


