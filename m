Return-Path: <bpf+bounces-3708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69574206E
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199A91C2095E
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361946A5;
	Thu, 29 Jun 2023 06:37:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443531FA1
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:37:27 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0121727
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:26 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0N5AP028519
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=MtYWd76etUZc2BJ2IugeLNB9024ewMZIItkVF/tcdVA=;
 b=VB5L8+qzpln72VxKqLVApiNmqZwR65ap80JaEUlHCHOBrUHgpIt3fm1PpbHB0Idm6wAI
 wFEhnXYXVe2TuUMRu1OStgYvrQvNlMPJQeRrbFyvBQ4LNi/gL2Q2gpwzDKwZg/FDtO7H
 XlLsVGUwI7AxvGvp4GmbvRysxR2JIVl1u7c= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgyc1aakp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:25 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:37:23 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2C378221E7AD8; Wed, 28 Jun 2023 23:37:15 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 00/13] bpf: Support new insns from cpu v4
Date: Wed, 28 Jun 2023 23:37:15 -0700
Message-ID: <20230629063715.1646832-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mLUUN_fQ3yFBVRcQxUSvfGaqXJrNCdZR
X-Proofpoint-GUID: mLUUN_fQ3yFBVRcQxUSvfGaqXJrNCdZR
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
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
insns. It has minimum verifier support in order to pass bpf selftests.
More work will be required to cover verification and other aspects
(e.g. blinding, etc.).

I send the patch set earlier and want to get some early feedbacks
before I dig into verifier details. Patch 3 (sign-extension mov
insns) prompts me to think whether we should have unsign-extension
mov insns as well (see Patch 3 commit message for details).
The last patch contains some statistics of how many new insns are
actually generated in selftests.  Please see each individual patch
for details.

  [1] https://lore.kernel.org/bpf/4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta=
.com/
  [2] https://reviews.llvm.org/D144829

Yonghong Song (13):
  bpf: Support new sign-extension load insns
  bpf: Add verifier support for sign-extension load insns
  bpf: Support new sign-extension mov insns
  bpf: Support new unconditional bswap instruction
  bpf: Support new signed div/mod instructions.
  bpf: Support new 32bit offset jmp instruction
  bpf: Add kernel/bpftool asm support for new instructions
  selftests/bpf: Add unit tests for new sign-extension load insns
  selftests/bpf: Add unit tests for new sign-extension mov insns
  selftests/bpf: Add unit tests for new bswap insns
  selftests/bpf: Add unit tests for new sdiv/smod insns
  selftests/bpf: Add unit tests for new gotol insn
  selftests/bpf: Add a cpuv4 test runner for cpu=3Dv4 testing

 arch/x86/net/bpf_jit_comp.c                   | 130 ++-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/core.c                             | 170 +++-
 kernel/bpf/disasm.c                           |  57 +-
 kernel/bpf/verifier.c                         | 100 ++-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/Makefile          |  18 +-
 .../selftests/bpf/prog_tests/verifier.c       |  10 +
 .../selftests/bpf/progs/verifier_bswap.c      |  45 ++
 .../selftests/bpf/progs/verifier_gotol.c      |  30 +
 .../selftests/bpf/progs/verifier_lds.c        |  46 ++
 .../selftests/bpf/progs/verifier_movs.c       |  67 ++
 .../selftests/bpf/progs/verifier_sdiv.c       | 763 ++++++++++++++++++
 13 files changed, 1357 insertions(+), 81 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lds.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_movs.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c

--=20
2.34.1


