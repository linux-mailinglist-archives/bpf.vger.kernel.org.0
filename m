Return-Path: <bpf+bounces-4925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA075188B
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33181C212B5
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1685684;
	Thu, 13 Jul 2023 06:07:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD35679
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:07:39 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BE1FD7
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:37 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMvdcR003868
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Rohh7pwY8uBys7mEpcWWvfI83l7+NCgFlFQcDrzVGQs=;
 b=EbLrts5DohfAKVWmxcbzrs0wspOxtkyUZy0p7X1ppFvG4WwsBje9OzhotMYHBZ8GGXLF
 CUC+UZ2EuoI2GjdIEKwT7437xEPizhj7RriLumamZ8flBdszdznLoHgryZGoURf3A4E6
 bwPxu8Mnf9UoHds/X+RUxhzhQgk48c2Vq6Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsgc92vc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:07:36 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:07:35 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0DDC822EFA1F7; Wed, 12 Jul 2023 23:07:19 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 00/15] bpf: Support new insns from cpu v4
Date: Wed, 12 Jul 2023 23:07:18 -0700
Message-ID: <20230713060718.388258-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KeefVed5U1Mj9UCXdJwgbTHW7yJJYZX_
X-Proofpoint-ORIG-GUID: KeefVed5U1Mj9UCXdJwgbTHW7yJJYZX_
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
 definitions=2023-07-13_03,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
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

The patchset implements interpreter and jit support for these new
insns as well as necessary verifier support.

To test this patch set, you need to have latest llvm from 'main' branch
of llvm-project repo and apply [2] on top of it.

  [1] https://lore.kernel.org/bpf/4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta=
.com/
  [2] https://reviews.llvm.org/D144829

Changelogs:
  RFCv1 -> v2:
   . add more verifier supports for signed extend load and mov insns.
   . rename some insn names to be more consistent with intel practice.
   . add cpuv4 test runner for test progs.
   . add more unit and C tests.
   . add documentation.

Yonghong Song (15):
  bpf: Support new sign-extension load insns
  bpf: Fix sign-extension ctx member accesses
  bpf: Support new sign-extension mov insns
  bpf: Support new unconditional bswap instruction
  bpf: Support new signed div/mod instructions.
  bpf: Fix jit blinding with new sdiv/smov insns
  bpf: Support new 32bit offset jmp instruction
  selftests/bpf: Add a cpuv4 test runner for cpu=3Dv4 testing
  selftests/bpf: Add unit tests for new sign-extension load insns
  selftests/bpf: Add unit tests for new sign-extension mov insns
  selftests/bpf: Add unit tests for new bswap insns
  selftests/bpf: Add unit tests for new sdiv/smod insns
  selftests/bpf: Add unit tests for new gotol insn
  selftests/bpf: Test ldsx with more complex cases
  docs/bpf: Add documentation for new instructions

 Documentation/bpf/bpf_design_QA.rst           |   5 -
 .../bpf/standardization/instruction-set.rst   | 100 ++-
 arch/x86/net/bpf_jit_comp.c                   | 131 ++-
 include/linux/filter.h                        |  14 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/cgroup.c                           |  14 +-
 kernel/bpf/core.c                             | 174 +++-
 kernel/bpf/verifier.c                         | 315 ++++++--
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  18 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   9 +-
 .../selftests/bpf/prog_tests/test_ldsx_insn.c |  88 ++
 .../selftests/bpf/prog_tests/verifier.c       |  10 +
 .../selftests/bpf/progs/test_ldsx_insn.c      |  75 ++
 .../selftests/bpf/progs/verifier_bswap.c      |  45 ++
 .../selftests/bpf/progs/verifier_gotol.c      |  30 +
 .../selftests/bpf/progs/verifier_ldsx.c       | 115 +++
 .../selftests/bpf/progs/verifier_movsx.c      | 177 ++++
 .../selftests/bpf/progs/verifier_sdiv.c       | 763 ++++++++++++++++++
 20 files changed, 1929 insertions(+), 158 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_movsx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c

--=20
2.34.1


