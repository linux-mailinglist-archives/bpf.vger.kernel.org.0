Return-Path: <bpf+bounces-18980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF8823A42
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96CF287EB8
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825817FF;
	Thu,  4 Jan 2024 01:38:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D11859
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GjYI4025582
	for <bpf@vger.kernel.org>; Wed, 3 Jan 2024 17:38:57 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vda6tbu65-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 17:38:56 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 17:38:54 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4765C3DFAFE3C; Wed,  3 Jan 2024 17:38:51 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 0/9] Libbpf-side __arg_ctx fallback support
Date: Wed, 3 Jan 2024 17:38:38 -0800
Message-ID: <20240104013847.3875810-1-andrii@kernel.org>
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
X-Proofpoint-GUID: ua-OlOiF8_b2DfBZIx6qPS9vEStQVvMy
X-Proofpoint-ORIG-GUID: ua-OlOiF8_b2DfBZIx6qPS9vEStQVvMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02

Support __arg_ctx global function argument tag semantics even on older ke=
rnels
that don't natively support it through btf_decl_tag("arg:ctx").

Patches #2-#6 are preparatory work to allow to postpone BTF loading into =
the
kernel until after all the BPF program relocations (including global func
appending to main programs) are done. Patch #4 is perhaps the most import=
ant
and establishes pre-created stable placeholder FDs, so that relocations c=
an
embed valid map FDs into ldimm64 instructions.

Once BTF is done after relocation, what's left is to adjust BTF informati=
on to
have each main program's copy of each used global subprog to point to its=
 own
adjusted FUNC -> FUNC_PROTO type chain (if they use __arg_ctx) in such a =
way
as to satisfy type expectations of BPF verifier regarding the PTR_TO_CTX
argument definition. See patch #8 for details.

Patch #8 adds few more __arg_ctx use cases (edge cases like multiple argu=
ments
having __arg_ctx, etc) to test_global_func_ctx_args.c, to make it simple =
to
validate that this logic indeed works on old kernels. It does. But just t=
o be
100% sure patch #9 adds a test validating that libbpf uploads func_info w=
ith
properly modified BTF data.

v2->v3:
  - drop renaming patch (Alexei, Eduard);
  - use memfd_create() instead of /dev/null for placeholder FD (Eduard);
  - add one more test for validating BTF rewrite logic (Eduard);
  - fixed wrong -errno usage, reshuffled some BTF rewrite bits (Eduard);
v1->v2:
  - do internal functions renaming in patch #1 (Alexei);
  - extract cloning of FUNC -> FUNC_PROTO information into separate funct=
ion
    (Alexei);

Andrii Nakryiko (9):
  libbpf: make uniform use of btf__fd() accessor inside libbpf
  libbpf: use explicit map reuse flag to skip map creation steps
  libbpf: don't rely on map->fd as an indicator of map being created
  libbpf: use stable map placeholder FDs
  libbpf: move exception callbacks assignment logic into relocation step
  libbpf: move BTF loading step after relocation step
  libbpf: implement __arg_ctx fallback logic
  selftests/bpf: add arg:ctx cases to test_global_funcs tests
  selftests/bpf: add __arg_ctx BTF rewrite test

 tools/lib/bpf/libbpf.c                        | 570 +++++++++++++-----
 tools/lib/bpf/libbpf_internal.h               |  14 +
 .../bpf/prog_tests/test_global_funcs.c        | 106 ++++
 .../bpf/progs/test_global_func_ctx_args.c     |  49 ++
 4 files changed, 599 insertions(+), 140 deletions(-)

--=20
2.34.1


