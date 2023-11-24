Return-Path: <bpf+bounces-15796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C17F6B18
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 05:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2368F281303
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171B23A5;
	Fri, 24 Nov 2023 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13FF10C8
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 20:00:13 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO0UPX7016881
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 20:00:12 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ujhbbrkqs-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 20:00:12 -0800
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 19:59:52 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id BF9893C05793D; Thu, 23 Nov 2023 19:59:38 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 0/3] Verify global subprogs lazily
Date: Thu, 23 Nov 2023 19:59:34 -0800
Message-ID: <20231124035937.403208-1-andrii@kernel.org>
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
X-Proofpoint-GUID: WNpMsOZUWNoV_TDmv4_6qVkneva-YTuK
X-Proofpoint-ORIG-GUID: WNpMsOZUWNoV_TDmv4_6qVkneva-YTuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02

See patch #2 for justification. In few words, current eager verification =
of
global func prevents BPF CO-RE approaches to be applied to global functio=
ns.

Patch #1 is just a nicety to emit global subprog names in verifier logs.

Patch #3 adds selftests validating new lazy semantics.

v1->v2:
  - rebases on latest bpf-next resolving conflicts with bpf_loop fixes;
  - added acks from Eduard and Daniel.

Andrii Nakryiko (3):
  bpf: emit global subprog name in verifier logs
  bpf: validate global subprogs lazily
  selftests/bpf: add lazy global subprog validation tests

 include/linux/bpf.h                           |  2 +
 kernel/bpf/verifier.c                         | 83 +++++++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/test_global_func12.c  |  4 +-
 .../bpf/progs/verifier_global_subprogs.c      | 92 +++++++++++++++++++
 .../bpf/progs/verifier_subprog_precision.c    |  4 +-
 6 files changed, 166 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_sub=
progs.c

--=20
2.34.1


