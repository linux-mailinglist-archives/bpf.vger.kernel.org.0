Return-Path: <bpf+bounces-17915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D3813F0A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA30D283914
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FFF805;
	Fri, 15 Dec 2023 01:13:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029B7E4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3BEJJQeJ007951
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 17:13:51 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3uynkksh6e-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 17:13:51 -0800
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 17:13:48 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4A1853D2CCEAF; Thu, 14 Dec 2023 17:13:35 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 00/10] Enhance BPF global subprogs with argument tags
Date: Thu, 14 Dec 2023 17:13:24 -0800
Message-ID: <20231215011334.2307144-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: 6cyuvIUPWRz8vDOMkC55Kbqmh_zcUHSt
X-Proofpoint-GUID: 6cyuvIUPWRz8vDOMkC55Kbqmh_zcUHSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02

This patch set adds verifier support for annotating user's global BPF sub=
prog
arguments with few commonly requested annotations, to improve global subp=
rog
verification experience.

These tags are:
  - ability to annotate a special PTR_TO_CTX argument;
  - ability to annotate a generic PTR_TO_MEM as non-null.

We utilize btf_decl_tag attribute for this and provide two helper macros =
as
part of bpf_helpers.h in libbpf (patch #8).

Besides this we also add abilit to pass a pointer to dynptr into global
subprog. This is done based on type name match (struct bpf_dynptr *). Thi=
s
allows to pass dynptrs into global subprogs, for use cases that deal with
variable-sized generic memory pointers.

Big chunk of the patch set (patches #1 through #5) are various refactorin=
gs to
make verifier internals around global subprog validation logic easier to
extend and support long term, eliminating BTF parsing logic duplication,
factoring out argument expectation definitions from BTF parsing, etc.

New functionality is added in patch #6 (ctx and non-null) and patch #7
(dynptr), extending global subprog checks with awareness for arg tags.

Patch #9 adds simple tests validating each of the added tags and dynptr
argument passing.

Patch #10 adds a simple negative case for freplace programs to make sure =
that
target BPF programs with "unreliable" BTF func proto cannot be freplaced.

v2->v3:
  - patch #10 improved by checking expected verifier error (Eduard);
v1->v2:
  - dropped packet args for now (Eduard);
  - added back unreliable=3Dtrue detection for entry BPF programs (Eduard=
);
  - improved subprog arg validation (Eduard);
  - switched dynptr arg from tag to just type name based check (Eduard).

Andrii Nakryiko (10):
  bpf: abstract away global subprog arg preparation logic from reg state
    setup
  bpf: reuse btf_prepare_func_args() check for main program BTF
    validation
  bpf: prepare btf_prepare_func_args() for handling static subprogs
  bpf: move subprog call logic back to verifier.c
  bpf: reuse subprog argument parsing logic for subprog call checks
  bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog
    args
  bpf: add support for passing dynptr pointer to global subprog
  libbpf: add __arg_xxx macros for annotating global func args
  selftests/bpf: add global subprog annotation tests
  selftests/bpf: add freplace of BTF-unreliable main prog test

 include/linux/bpf.h                           |   7 +-
 include/linux/bpf_verifier.h                  |  29 +-
 kernel/bpf/btf.c                              | 282 +++++-------------
 kernel/bpf/verifier.c                         | 184 +++++++++---
 tools/lib/bpf/bpf_helpers.h                   |   3 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  30 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |   4 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   2 +-
 .../bpf/progs/freplace_unreliable_prog.c      |  20 ++
 .../selftests/bpf/progs/task_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/test_global_func5.c   |   2 +-
 .../bpf/progs/verifier_btf_unreliable_prog.c  |  20 ++
 .../bpf/progs/verifier_global_subprogs.c      |  99 +++++-
 14 files changed, 416 insertions(+), 270 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_unreliable=
_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_unreli=
able_prog.c

--=20
2.34.1


