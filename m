Return-Path: <bpf+bounces-16205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DCA7FE477
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 01:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55FEB20FF3
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A74385;
	Thu, 30 Nov 2023 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218512F
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:05 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATNHDmr010343
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:05 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3upeu6086w-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:05:05 -0800
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 16:04:14 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 894363C556402; Wed, 29 Nov 2023 16:04:07 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 00/10] BPF verifier retval logic fixes
Date: Wed, 29 Nov 2023 16:03:56 -0800
Message-ID: <20231130000406.480870-1-andrii@kernel.org>
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
X-Proofpoint-GUID: UPPVKiWcXUYOmsGIcFwhwQOXMG-BVP2p
X-Proofpoint-ORIG-GUID: UPPVKiWcXUYOmsGIcFwhwQOXMG-BVP2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02

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

v2->v3:
  - more carefullly switch from umin/umax to smin/smax;
v1->v2:
  - drop tnum from retval checks (Eduard);
  - use smin/smax instead of umin/umax (Alexei).

Andrii Nakryiko (10):
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

 include/linux/bpf_verifier.h                  |   7 +-
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
 15 files changed, 211 insertions(+), 79 deletions(-)

--=20
2.34.1


