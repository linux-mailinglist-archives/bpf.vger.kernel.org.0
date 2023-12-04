Return-Path: <bpf+bounces-16619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BAC803E56
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F1E1F21162
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7343173F;
	Mon,  4 Dec 2023 19:26:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42589CA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 11:26:33 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B4JQSjp024219
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 11:26:32 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3us9fbw31f-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 11:26:32 -0800
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 11:26:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3855C3C94B7AF; Mon,  4 Dec 2023 11:26:02 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 00/10] Complete BPF verifier precision tracking support for register spills
Date: Mon, 4 Dec 2023 11:25:51 -0800
Message-ID: <20231204192601.2672497-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: 6H-5_X96a6KLJZt8qP--wGksPtOKcb5X
X-Proofpoint-GUID: 6H-5_X96a6KLJZt8qP--wGksPtOKcb5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02

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
 .../selftests/bpf/progs/verifier_spill_fill.c | 124 ++++++++
 .../bpf/progs/verifier_subprog_precision.c    |  87 ++++-
 .../testing/selftests/bpf/verifier/precise.c  |  38 ++-
 5 files changed, 435 insertions(+), 153 deletions(-)

--=20
2.34.1


