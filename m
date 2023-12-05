Return-Path: <bpf+bounces-16766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B8805DBC
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2EC281C91
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF6C6A033;
	Tue,  5 Dec 2023 18:43:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8194510D5
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:43:07 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5Iepq0021150
	for <bpf@vger.kernel.org>; Tue, 5 Dec 2023 10:43:06 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ut06scfe5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:43:06 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 5 Dec 2023 10:43:05 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 144D53CA16F9F; Tue,  5 Dec 2023 10:42:49 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 00/10] Complete BPF verifier precision tracking support for register spills
Date: Tue, 5 Dec 2023 10:42:38 -0800
Message-ID: <20231205184248.1502704-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aRAbaY_f_V3BE02Wv3JXcIkDYIvoQfz-
X-Proofpoint-ORIG-GUID: aRAbaY_f_V3BE02Wv3JXcIkDYIvoQfz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_13,2023-12-05_01,2023-05-22_02

Add support to BPF verifier to track and support register spill/fill to/f=
rom
stack regardless if it was done through read-only R10 register (which is =
the
only form supported today), or through a general register after copying R=
10
into it, while also potentially modifying offset.

Once we add register this generic spill/fill support to precision
backtracking, we can take advantage of it to stop doing eager STACK_ZERO
conversion on register spill. Instead we can rely on (im)precision of spi=
lled
const zero register to improve verifier state pruning efficiency. This
situation of using const zero register to initialize stack slots is very
common with __builtin_memset() usage or just zero-initializing variables =
on
the stack, and it causes unnecessary state duplication, as that STACK_ZER=
O
knowledge is often not necessary for correctness, as those zero values ar=
e
never used in precise context. Thus, relying on register imprecision help=
s
tremendously, especially in real-world BPF programs.

To make spilled const zero register behave completely equivalently to
STACK_ZERO, we need to improve few other small pieces, which is done in t=
he
second part of the patch set. See individual patches for details. There a=
re
also two small bug fixes spotted during STACK_ZERO debugging.

The patch set consists of logically three changes:
  - patch #1 (and corresponding tests in patch #2) is fixing/impoving pre=
cision
    propagation for stack spills/fills. This can be landed as a stand-alo=
ne
    improvement;
  - patches #3 through #9 is improving verification scalability by utiliz=
ing
    register (im)precision instead of eager STACK_ZERO. These changes dep=
end
    on patch #1.
  - patch #10 is a memory efficiency improvement to how instruction/jump
    history is tracked and maintained. It depends on patch #1, but is not
    strictly speaking required, even though I believe it's a good long-te=
rm
    solution to have a path-dependent per-instruction information. Kind
    of like a path-dependent counterpart to path-agnostic insn_aux array.

v3->v3:
  - fixed up Fixes tag (Alexei);
  - fixed few more selftests to not use BPF_ST instruction in inline asm
    directly, checked with CI, it was happy (CI);
v2->v3:
  - BPF_ST instruction workaround (Eduard);
  - force dereference in added tests to catch problems (Eduard);
  - some commit message massaging (Alexei);
v1->v2:
  - clean ups, WARN_ONCE(), insn_flags helpers added (Eduard);
  - added more selftests for STACK_ZERO/STACK_MISC cases (Eduard);
  - a bit more detailed explanation of effect of avoiding STACK_ZERO in f=
avor
    of register spill in patch #8 commit (Alexei);
  - global shared instruction history refactoring moved to be the last pa=
tch
    in the series to make it easier to revert it, if applied (Alexei).

Andrii Nakryiko (10):
  bpf: support non-r10 register spill/fill to/from stack in precision
    tracking
  selftests/bpf: add stack access precision test
  bpf: fix check for attempt to corrupt spilled pointer
  bpf: preserve STACK_ZERO slots on partial reg spills
  selftests/bpf: validate STACK_ZERO is preserved on subreg spill
  bpf: preserve constant zero when doing partial register restore
  selftests/bpf: validate zero preservation for sub-slot loads
  bpf: track aligned STACK_ZERO cases as imprecise spilled registers
  selftests/bpf: validate precision logic in
    partial_stack_load_preserves_zeros
  bpf: use common instruction history across all states

 include/linux/bpf_verifier.h                  |  42 ++-
 kernel/bpf/verifier.c                         | 297 +++++++++++-------
 .../selftests/bpf/progs/verifier_spill_fill.c | 127 ++++++++
 .../bpf/progs/verifier_subprog_precision.c    |  87 ++++-
 .../testing/selftests/bpf/verifier/precise.c  |  38 ++-
 5 files changed, 438 insertions(+), 153 deletions(-)

--=20
2.34.1


