Return-Path: <bpf+bounces-16656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FBB8042A3
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB192B20BC1
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83B132C7B;
	Mon,  4 Dec 2023 23:39:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D2C130
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:39:50 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KGrm0007860
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:39:50 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3us6mcg0kq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:39:50 -0800
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:39:46 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3E7C53C9725AD; Mon,  4 Dec 2023 15:39:32 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 00/13] Enhance BPF global subprogs with argument tags
Date: Mon, 4 Dec 2023 15:39:18 -0800
Message-ID: <20231204233931.49758-1-andrii@kernel.org>
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
X-Proofpoint-GUID: j6f_ateq9jEsYz5Yt8giC9Qk37tPS0PO
X-Proofpoint-ORIG-GUID: j6f_ateq9jEsYz5Yt8giC9Qk37tPS0PO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

This patch set adds verifier support for annotating user's global BPF sub=
prog
arguments with few commonly requested annotations, to improve global subp=
rog
verification experience.

These tags are:
  - ability to annotate a special PTR_TO_CTX argument;
  - ability to annotate a generic PTR_TO_MEM as non-null;
  - ability to annotate special PTR_TO_PACKET, PTR_TO_PACKET_END, and
    PTR_TO_PACKET_META pointers for networking programs;
  - ability to annotate argument as CONST_PTR_TO_DYNPTR to pass generic
    dynptrs into global subprogs, for use cases that deal with variable-s=
ized
    generic memory pointers.

We utilize btf_decl_tag attribute for this and provide few helper macros =
as
part of bpf_helpers.h in libbpf (patch #12).

Patches #1 and #2 are tiny improvements to verifier log, printing relevan=
t
information for PTR_TO_MEM and dynptr. Those missing pieces came up durin=
g
development of this patch set.

Big chunk of the patch set (patches #3 through #9) are various refactorin=
gs to
make verifier internals around global subprog validation logic easier to
extend and support long term, eliminating BTF parsing logic duplication,
factoring out argument expectation definitions from BTF parsing, etc.

New functionality is added in patch #10 (ctx, non-null, pkt pointers) and
patch #11 (dynptr), extending global subprog checks with awareness for ar=
g
tags.

Patch #12 adds simple macro helpers for arg tags to standardize their usa=
ge
across BPF code base.

Patch #13 adds simple tests validating each of the added tags.

Andrii Nakryiko (13):
  bpf: log PTR_TO_MEM memory size in verifier log
  bpf: emit more dynptr information in verifier log
  bpf: tidy up exception callback management a bit
  bpf: use bitfields for simple per-subprog bool flags
  bpf: abstract away global subprog arg preparation logic from reg state
    setup
  bpf: remove unnecessary and (mostly) ignored BTF check for main
    program
  bpf: prepare btf_prepare_func_args() for handling static subprogs
  bpf: move subprog call logic back to verifier.c
  bpf: reuse subprog argument parsing logic for subprog call checks
  bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog
    args
  bpf: add dynptr global subprog arg tag support
  libbpf: add __arg_xxx macros for annotating global func args
  selftests/bpf: add global subprog annotation tests

 include/linux/bpf.h                           |  12 +-
 include/linux/bpf_verifier.h                  |  41 ++-
 kernel/bpf/btf.c                              | 291 +++++-------------
 kernel/bpf/log.c                              |  29 +-
 kernel/bpf/verifier.c                         | 221 +++++++++++--
 tools/lib/bpf/bpf_helpers.h                   |   9 +
 .../selftests/bpf/prog_tests/log_fixup.c      |   4 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/test_global_func5.c   |   2 +-
 .../bpf/progs/verifier_global_subprogs.c      | 134 +++++++-
 11 files changed, 459 insertions(+), 288 deletions(-)

--=20
2.34.1


