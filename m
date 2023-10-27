Return-Path: <bpf+bounces-13439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8C7D9F9C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CA31C2114B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E048827;
	Fri, 27 Oct 2023 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF73AC25
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:14:04 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93002AC
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:14:02 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5bQU006325
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:14:01 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0c4pu2fy-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:14:01 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:13:57 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3C6B73A796515; Fri, 27 Oct 2023 11:13:47 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 00/23] BPF register bounds logic and testing improvements
Date: Fri, 27 Oct 2023 11:13:23 -0700
Message-ID: <20231027181346.4019398-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: k0VDM3Nyrvu3D7hW-jBq5zaw23i1eLkt
X-Proofpoint-ORIG-GUID: k0VDM3Nyrvu3D7hW-jBq5zaw23i1eLkt
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
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

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

With range vs const cases taken care of and well tested, we move to
generalizing this to handle generic range vs range cases. Patches #11-#17
perform preliminary refactorings without functionally changing anything. But
they do clean up check_cond_jmp_op() logic and generalize a bunch of other
pieces in is_branch_taken() logic.

With refactorings out of the way, patch #18 teaches reg_set_min_max() to
handle <range> vs <range>, whenever possible, and patch #19 adjusts
is_branch_taken() accordingly. Those two have to match each other, as
is_branch_taken() prevents some situations that reg_set_min_max() assumes n=
ot
possible from getting through to reg_set_min_max().

One such class of situations is when we mix 64-bit operations with 32-bit
operations on the same register. Depending on specific sequence, it's possi=
ble
to get to the point where u64/s64 bounds will be very generic (e.g., after
signed 32-bit comparison), while we still keep pretty tight u32/s32 bounds.=
 If
in such state we proceed with 32-bit equality or inequality comparison,
reg_set_min_max() might have to deal with adjusting s32 bounds for two
registers that don't overlap, which breaks reg_set_min_max(). This doesn't
manifest in <range> vs <const> cases, because if that happens
reg_set_min_max() in effect will force s32 bounds to be a new "impossible"
constant (from original smin32/smax32 bounds point of view). Things get tri=
cky
when we have <range> vs <range> adjustments, so instead of trying to somehow
make sense out of such situations, it's best to detect such impossible
situations and prune the branch that can't be take in is_branch_taken() log=
ic.
This is taken care of in patch #20.

Note, this is not unique to <range> vs <range> logic. Just recently ([0])
a related issue was reported for existing verifier logic. This patch set do=
es
fix that issues as well, as pointed out on the mailing list.

Wrapping up, patches #21-22 adjust reg_bounds selftests to handle and test
range vs range cases.

Finally, a tiny test which was, amazingly, an initial motivation for this
work, is added in patch #23, demonstrating how verifier is now smart enough=
 to
track actual number of elements in the array and won't require additional
checks on loop iteration variable inside the bpf_for() loop.

  [0] https://lore.kernel.org/bpf/CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE7Veo=
UWgKf3cpig@mail.gmail.com/

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

Andrii Nakryiko (23):
  selftests/bpf: fix RELEASE=3D1 build for tc_opts
  selftests/bpf: satisfy compiler by having explicit return in btf test
  bpf: derive smin/smax from umin/max bounds
  bpf: derive smin32/smax32 from umin32/umax32 bounds
  bpf: derive subreg bounds from full bounds when upper 32 bits are constant
  bpf: add special smin32/smax32 derivation from 64-bit bounds
  bpf: improve deduction of 64-bit bounds from 32-bit bounds
  bpf: try harder to deduce register bounds from different numeric domains
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
  selftests/bpf: BPF register range bounds tester
  bpf: rename is_branch_taken reg arguments to prepare for the second one
  bpf: generalize is_branch_taken() to work with two registers
  bpf: move is_branch_taken() down
  bpf: generalize is_branch_taken to handle all conditional jumps in one pl=
ace
  bpf: unify 32-bit and 64-bit is_branch_taken logic
  bpf: prepare reg_set_min_max for second set of registers
  bpf: generalize reg_set_min_max() to handle two sets of two registers
  bpf: generalize reg_set_min_max() to handle non-const register comparisons
  bpf: generalize is_scalar_branch_taken() logic
  bpf: enhance BPF_JEQ/BPF_JNE is_branch_taken logic
  selftests/bpf: adjust OP_EQ/OP_NE handling to use subranges for branch ta=
ken
  selftests/bpf: add range x range test to reg_bounds
  selftests/bpf: add iter test requiring range x range logic

 include/linux/tnum.h                          |    4 +
 kernel/bpf/tnum.c                             |    7 +-
 kernel/bpf/verifier.c                         |  920 ++++----
 tools/testing/selftests/bpf/prog_tests/btf.c  |    1 +
 .../selftests/bpf/prog_tests/reg_bounds.c     | 1938 +++++++++++++++++
 .../selftests/bpf/prog_tests/tc_opts.c        |    6 +-
 tools/testing/selftests/bpf/progs/iters.c     |   22 +
 7 files changed, 2473 insertions(+), 425 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c

--=20
2.34.1


