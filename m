Return-Path: <bpf+bounces-13886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F117DEB72
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFDE2819EC
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9C185B;
	Thu,  2 Nov 2023 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD02D63D
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:08 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65ED9F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:06 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A223kwt001150
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u42n90r4h-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:06 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E2B9C3AC97E9C; Wed,  1 Nov 2023 20:38:00 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v6 bpf-next 00/17] BPF register bounds logic and testing improvements
Date: Wed, 1 Nov 2023 20:37:42 -0700
Message-ID: <20231102033759.2541186-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wMpv4B-JzAxv1cRISdZuFaAU6yI8I96O
X-Proofpoint-GUID: wMpv4B-JzAxv1cRISdZuFaAU6yI8I96O
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

This patch set adds a big set of manual and auto-generated test cases
validating BPF verifier's register bounds tracking and deduction logic. See
details in the last patch.

We start with building a tester that validates existing <range> vs <scalar>
verifier logic for range bounds. To make all this work, BPF verifier's logic
needed a bunch of improvements to handle some cases that previously were not
covered. This had no implications as to correctness of verifier logic, but =
it
was incomplete enough to cause significant disagreements with alternative
implementation of register bounds logic that tests in this patch set
implement. So we need BPF verifier logic improvements to make all the tests
pass. This is what we do in patches #3 through #9.

Patch #10 implements tester. We guard millions of generated tests behind
SLOW_TESTS=3D1 envvar requirement, but also have a relatively small number =
of
tricky cases that came up during development and debugging of this work. Th=
ose
will be executed as part of a normal test_progs run.

The end goal of this work, though, is to extend BPF verifier range state
tracking such as to allow to derive new range bounds when comparing non-con=
st
registers. There is some more investigative work required to investigate and
fix existing potential issues with range tracking as part of ALU/ALU64
operations, so <range> x <range> part of v5 patch set ([0]) is dropped until
these issues are sorted out.

For now, we include preparatory refactorings and clean ups, that set up BPF
verifier code base to extend the logic to <range> vs <range> logic in
subsequent patch set. Patches #11-#17 perform preliminary refactorings with=
out
functionally changing anything. But they do clean up check_cond_jmp_op() lo=
gic
and generalize a bunch of other pieces in is_branch_taken() logic.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D797178&=
state=3D*

v5->v6:
  - dropped <range> vs <range> patches (original patches #18 through #23) to
    add more register range sanity checks and fix preexisting issues;
  - comments improvements, addressing other feedback on first 17 patches
    (Eduard, Alexei);
v4->v5:
  - added entirety of verifier reg bounds tracking changes, now handling
    <range> vs <range> cases (Alexei);
  - added way more comments trying to explain why deductions added are
    correct, hopefully they are useful and clarify things a bit (Daniel,
    Shung-Hsi);
  - added two preliminary selftests fixes necessary for RELEASE=3D1 build to
    work again, it keeps breaking.
v3->v4:
  - improvements to reg_bounds tester (progress report, split 32-bit and
    64-bit ranges, fix various verbosity output issues, etc);
v2->v3:
  - fix a subtle little-endianness assumption inside parge_reg_state() (CI);
v1->v2:
  - fix compilation when building selftests with llvm-16 toolchain (CI).

Andrii Nakryiko (17):
  selftests/bpf: fix RELEASE=3D1 build for tc_opts
  selftests/bpf: satisfy compiler by having explicit return in btf test
  bpf: derive smin/smax from umin/max bounds
  bpf: derive smin32/smax32 from umin32/umax32 bounds
  bpf: derive subreg bounds from full bounds when upper 32 bits are
    constant
  bpf: add special smin32/smax32 derivation from 64-bit bounds
  bpf: improve deduction of 64-bit bounds from 32-bit bounds
  bpf: try harder to deduce register bounds from different numeric
    domains
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
  selftests/bpf: BPF register range bounds tester
  bpf: rename is_branch_taken reg arguments to prepare for the second
    one
  bpf: generalize is_branch_taken() to work with two registers
  bpf: move is_branch_taken() down
  bpf: generalize is_branch_taken to handle all conditional jumps in one
    place
  bpf: unify 32-bit and 64-bit is_branch_taken logic
  bpf: prepare reg_set_min_max for second set of registers
  bpf: generalize reg_set_min_max() to handle two sets of two registers

 kernel/bpf/verifier.c                         |  744 ++++---
 tools/testing/selftests/bpf/prog_tests/btf.c  |    1 +
 .../selftests/bpf/prog_tests/reg_bounds.c     | 1841 +++++++++++++++++
 .../selftests/bpf/prog_tests/tc_opts.c        |    6 +-
 4 files changed, 2242 insertions(+), 350 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c

--=20
2.34.1


