Return-Path: <bpf+bounces-15609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E57F3B18
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150271C20F83
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036015C4;
	Wed, 22 Nov 2023 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE877199
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:07 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALNMW0h030143
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:07 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uh65qrpnr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:07 -0800
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 17:17:04 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 456C13BE884F1; Tue, 21 Nov 2023 17:16:59 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 00/10] BPF verifier retval logic fixes
Date: Tue, 21 Nov 2023 17:16:46 -0800
Message-ID: <20231122011656.1105943-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: jZm34nrEp4L3TdVMn6VmVUX4slAmce03
X-Proofpoint-GUID: jZm34nrEp4L3TdVMn6VmVUX4slAmce03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_16,2023-11-21_01,2023-05-22_02

This patch set fixes BPF verifier logic around validating and enforcing r=
eturn
values for BPF programs that have specific range of expected return value=
s.
Both sync and async callbacks have similar logic and are fixes as well.
A few tests are added that would fail without the fixes in this patch set=
.

Also, while at it, we extend retval checking logic to use not just tnum v=
alue,
but also umin/umax range, avoiding future potential issues if expected ra=
nge
cannot be represented precisely by tnum (e.g., [0, 2] is not representabl=
e by
tnum and is treated as [0, 3]).

There is a little bit of refactoring to unify async callback and program =
exit
logic to avoid duplication of checks as much as possible.

Andrii Nakryiko (10):
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

 include/linux/bpf_verifier.h                  |   9 +-
 kernel/bpf/verifier.c                         | 133 +++++++++++-------
 .../selftests/bpf/progs/exceptions_assert.c   |   2 +-
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +-
 .../selftests/bpf/progs/test_global_func15.c  |  31 +++-
 .../selftests/bpf/progs/timer_failure.c       |  31 ++--
 .../selftests/bpf/progs/user_ringbuf_fail.c   |   2 +-
 .../bpf/progs/verifier_cgroup_inv_retcode.c   |   8 +-
 .../bpf/progs/verifier_netfilter_retcode.c    |   2 +-
 .../bpf/progs/verifier_subprog_precision.c    |  45 ++++++
 10 files changed, 198 insertions(+), 67 deletions(-)

--=20
2.34.1


