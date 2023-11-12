Return-Path: <bpf+bounces-14894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC07E8DCD
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D4D1C2040E
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD4C17C5;
	Sun, 12 Nov 2023 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B915B5
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:18 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F1E171A
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:16 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AC0xYTJ004010
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:16 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua5tqb58y-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:16 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:12 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 760283B5D5161; Sat, 11 Nov 2023 17:06:10 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 00/13] BPF register bounds range vs range support
Date: Sat, 11 Nov 2023 17:05:56 -0800
Message-ID: <20231112010609.848406-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zvAPP7XAVrz4CjWNfGfAdm25Sl5pixG7
X-Proofpoint-ORIG-GUID: zvAPP7XAVrz4CjWNfGfAdm25Sl5pixG7
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
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

This patch set is a continuation of work started in [0]. It adds a big set =
of
manual, auto-generated, and now also random test cases validating BPF
verifier's register bounds tracking and deduction logic.

First few patches generalize verifier's logic to handle conditional jumps a=
nd
corresponding range adjustments in case when two non-const registers are
compared to each other. Patch #1 generalizes reg_set_min_max() portion, whi=
le
patch #2 does the same for is_branch_taken() part of the overall solution.

Patch #3 improves equality and inequality for cases when BPF program code
mixes 64-bit and 32-bit uses of the same register. Depending on specific
sequence, it's possible to get to the point where u64/s64 bounds will be ve=
ry
generic (e.g., after signed 32-bit comparison), while we still keep pretty
tight u32/s32 bounds. If in such state we proceed with 32-bit equality or
inequality comparison, reg_set_min_max() might have to deal with adjusting =
s32
bounds for two registers that don't overlap, which breaks reg_set_min_max().
This doesn't manifest in <range> vs <const> cases, because if that happens
reg_set_min_max() in effect will force s32 bounds to be a new "impossible"
constant (from original smin32/smax32 bounds point of view). Things get tri=
cky
when we have <range> vs <range> adjustments, so instead of trying to somehow
make sense out of such situations, it's best to detect such impossible
situations and prune the branch that can't be taken in is_branch_taken()
logic.  This equality/inequality was the only such category of situations w=
ith
auto-generated tests added later in the patch set.

But when we start mixing arithmetic operations in different numeric domains
and conditionals, things get even hairier. So, patch #4 adds sanity checking
logic after all ALU/ALU64, JMP/JMP32, and LDX operations. By default, inste=
ad
of failing verification, we conservatively reset range bounds to unknown
values, reporting violation in verifier log (if verbose logs are requested).
But to aid development, detection, and debugging, we also introduce a new t=
est
flag, BPF_F_TEST_SANITY_STRICT, which triggers verification failure on range
sanity violation.

Patch #11 sets BPF_F_TEST_SANITY_STRICT by default for test_progs and
test_verifier. Patch #12 adds support for controlling this in veristat for
testing with production BPF object files.

Getting back to BPF verifier, patches #5 and #6 complete verifier's range
tracking logic clean up. See respective patches for details.

With kernel-side taken care of, we move to testing. We start with building
a tester that validates existing <range> vs <scalar> verifier logic for ran=
ge
bounds. Patch #7 implements an initial version of such a tester. We guard
millions of generated tests behind SLOW_TESTS=3D1 envvar requirement, but a=
lso
have a relatively small number of tricky cases that came up during developm=
ent
and debugging of this work. Those will be executed as part of a normal
test_progs run.

Patch #8 simulates more nuanced JEQ/JNE logic we added to verifier in patch=
 #3.
Patch #9 adds <range> vs <range> "slow tests".

Patch #10 is a completely new one, it adds a bunch of randomly generated ca=
ses
to be run normally, without SLOW_TESTS=3D1 guard. This should help to get
a bunch of cover, and hopefully find some remaining latent problems if
verifier proactively as part of normal BPF CI runs.

Finally, a tiny test which was, amazingly, an initial motivation for this
whole work, is added in lucky patch #13, demonstrating how verifier is now
smart enough to track actual number of elements in the array and won't requ=
ire
additional checks on loop iteration variable inside the bpf_for() open-coded
iterator loop.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D798308&=
state=3D*

v1->v2:
  - use x < y =3D> y > x property to minimize reg_set_min_max (Eduard);
  - fix for JEQ/JNE logic in reg_bounds.c (Eduard);
  - split BPF_JSET and !BPF_JSET cases handling (Shung-Hsi);
  - adjustments to reg_bounds.c to make it easier to follow (Alexei);
  - added acks (Eduard, Shung-Hsi).

Andrii Nakryiko (13):
  bpf: generalize reg_set_min_max() to handle non-const register
    comparisons
  bpf: generalize is_scalar_branch_taken() logic
  bpf: enhance BPF_JEQ/BPF_JNE is_branch_taken logic
  bpf: add register bounds sanity checks and sanitization
  bpf: remove redundant s{32,64} -> u{32,64} deduction logic
  bpf: make __reg{32,64}_deduce_bounds logic more robust
  selftests/bpf: BPF register range bounds tester
  selftests/bpf: adjust OP_EQ/OP_NE handling to use subranges for branch
    taken
  selftests/bpf: add range x range test to reg_bounds
  selftests/bpf: add randomized reg_bounds tests
  selftests/bpf: set BPF_F_TEST_SANITY_SCRIPT by default
  veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r
    flag
  selftests/bpf: add iter test requiring range x range logic

 include/linux/bpf_verifier.h                  |    1 +
 include/linux/tnum.h                          |    4 +
 include/uapi/linux/bpf.h                      |    3 +
 kernel/bpf/syscall.c                          |    3 +-
 kernel/bpf/tnum.c                             |    7 +-
 kernel/bpf/verifier.c                         |  601 ++---
 tools/include/uapi/linux/bpf.h                |    3 +
 .../bpf/prog_tests/bpf_verif_scale.c          |    2 +-
 .../selftests/bpf/prog_tests/reg_bounds.c     | 2099 +++++++++++++++++
 tools/testing/selftests/bpf/progs/iters.c     |   22 +
 .../selftests/bpf/progs/verifier_bounds.c     |    2 +
 tools/testing/selftests/bpf/test_loader.c     |   35 +-
 tools/testing/selftests/bpf/test_sock_addr.c  |    1 +
 tools/testing/selftests/bpf/test_verifier.c   |    2 +-
 tools/testing/selftests/bpf/testing_helpers.c |    4 +-
 tools/testing/selftests/bpf/veristat.c        |   13 +-
 16 files changed, 2495 insertions(+), 307 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c

--=20
2.34.1


