Return-Path: <bpf+bounces-16505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EEA801E00
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 18:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE541F21098
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB3208A5;
	Sat,  2 Dec 2023 17:57:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887C1125
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 09:57:27 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B2EmrTW001879
	for <bpf@vger.kernel.org>; Sat, 2 Dec 2023 09:57:26 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ur1569rr5-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 09:57:26 -0800
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 2 Dec 2023 09:57:21 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 146503C7A80CB; Sat,  2 Dec 2023 09:57:06 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 00/11] BPF verifier retval logic fixes
Date: Sat, 2 Dec 2023 09:56:54 -0800
Message-ID: <20231202175705.885270-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: 8M3fOqwyNn_3juqqbdGBA3VyAJFu9HrL
X-Proofpoint-GUID: 8M3fOqwyNn_3juqqbdGBA3VyAJFu9HrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_16,2023-11-30_01,2023-05-22_02

This patch set fixes BPF verifier logic around validating and enforcing r=
eturn
values for BPF programs that have specific range of expected return value=
s.
Both sync and async callbacks have similar logic and are fixes as well.
A few tests are added that would fail without the fixes in this patch set=
.

Also, while at it, we update retval checking logic to use smin/smax range
instead of tnum, avoiding future potential issues if expected range canno=
t be
represented precisely by tnum (e.g., [0, 2] is not representable by tnum =
and
is treated as [0, 3]).

There is a little bit of refactoring to unify async callback and program =
exit
logic to avoid duplication of checks as much as possible.

v4->v5:
  - fix timer_bad_ret test on no-alu32 flavor (CI);
v3->v4:
  - add back bpf_func_state rearrangement patch;
  - simplified patch #4 as suggested (Shung-Hsi);
v2->v3:
  - more carefullly switch from umin/umax to smin/smax;
v1->v2:
  - drop tnum from retval checks (Eduard);
  - use smin/smax instead of umin/umax (Alexei).

Andrii Nakryiko (11):
  bpf: rearrange bpf_func_state fields to save a bit of memory
  bpf: provide correct register name for exception callback retval check
  bpf: enforce precision of R0 on callback return
  bpf: enforce exact retval range on subprog/callback exit
  selftests/bpf: add selftest validating callback result is enforced
  bpf: enforce precise retval range on program exit
  bpf: unify async callback and program retval checks
  bpf: enforce precision of R0 on program/async callback return
  selftests/bpf: validate async callback return value check correctness
  selftests/bpf: adjust global_func15 test to validate prog exit
    precision
  bpf: simplify tnum output if a fully known constant

 include/linux/bpf_verifier.h                  |   9 +-
 kernel/bpf/log.c                              |  13 ++
 kernel/bpf/tnum.c                             |   6 -
 kernel/bpf/verifier.c                         | 120 ++++++++++--------
 .../selftests/bpf/progs/exceptions_assert.c   |   2 +-
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +-
 .../selftests/bpf/progs/test_global_func15.c  |  34 ++++-
 .../selftests/bpf/progs/timer_failure.c       |  36 ++++--
 .../selftests/bpf/progs/user_ringbuf_fail.c   |   2 +-
 .../bpf/progs/verifier_cgroup_inv_retcode.c   |   8 +-
 .../bpf/progs/verifier_direct_packet_access.c |   2 +-
 .../selftests/bpf/progs/verifier_int_ptr.c    |   2 +-
 .../bpf/progs/verifier_netfilter_retcode.c    |   2 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c  |   4 +-
 .../bpf/progs/verifier_subprog_precision.c    |  50 ++++++++
 15 files changed, 212 insertions(+), 80 deletions(-)

--=20
2.34.1


