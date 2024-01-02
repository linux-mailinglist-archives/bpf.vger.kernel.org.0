Return-Path: <bpf+bounces-18788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA38221A5
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393A51C212DF
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA316408;
	Tue,  2 Jan 2024 19:01:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5116409
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402IZUMX024369
	for <bpf@vger.kernel.org>; Tue, 2 Jan 2024 11:01:15 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vc34px26k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:01:14 -0800
Received: from twshared19982.14.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 2 Jan 2024 11:01:13 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 05D463DF015F6; Tue,  2 Jan 2024 11:00:57 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 0/9] Libbpf-side __arg_ctx fallback support
Date: Tue, 2 Jan 2024 11:00:46 -0800
Message-ID: <20240102190055.1602698-1-andrii@kernel.org>
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
X-Proofpoint-GUID: viSeXDsN2BcUMuwhmmPk9tJuy19AnEZd
X-Proofpoint-ORIG-GUID: viSeXDsN2BcUMuwhmmPk9tJuy19AnEZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02

Support __arg_ctx global function argument tag semantics even on older ke=
rnels
that don't natively support it through btf_decl_tag("arg:ctx").

Patch #1 does a bunch of internal renaming to make internal function nami=
ng
consistent. We were doing it lazily up until now, but mixing single and d=
ouble
underscored names are confusing, so let's bite a bullet and get it over t=
he
finish line in one go.

Patches #3-#7 are preparatory work to allow to postpone BTF loading into =
the
kernel until after all the BPF program relocations (including global func
appending to main programs) are done. Patch #5 is perhaps the most import=
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

Patch #9 adds few more __arg_ctx use cases (edge cases like multiple argu=
ments
having __arg_ctx, etc) to test_global_func_ctx_args.c, to make it simple =
to
validate that this logic indeed works on old kernels. It does.

Andrii Nakryiko (9):
  libbpf: name internal functions consistently
  libbpf: make uniform use of btf__fd() accessor inside libbpf
  libbpf: use explicit map reuse flag to skip map creation steps
  libbpf: don't rely on map->fd as an indicator of map being created
  libbpf: use stable map placeholder FDs
  libbpf: move exception callbacks assignment logic into relocation step
  libbpf: move BTF loading step after relocation step
  libbpf: implement __arg_ctx fallback logic
  selftests/bpf: add arg:ctx cases to test_global_funcs tests

 tools/lib/bpf/libbpf.c                        | 1055 ++++++++++-------
 tools/lib/bpf/libbpf_internal.h               |   24 +
 .../bpf/progs/test_global_func_ctx_args.c     |   49 +
 3 files changed, 725 insertions(+), 403 deletions(-)

--=20
2.34.1


