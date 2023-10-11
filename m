Return-Path: <bpf+bounces-11965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A47C6068
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E096D1C20A7C
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5624A1A;
	Wed, 11 Oct 2023 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD979C4
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:37:49 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821B3ED
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:44 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BLKL9s011989
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tnu0qd6tt-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:43 -0700
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 11 Oct 2023 15:37:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 52F063995127C; Wed, 11 Oct 2023 15:37:30 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/5] BPF verifier log improvements
Date: Wed, 11 Oct 2023 15:37:23 -0700
Message-ID: <20231011223728.3188086-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: SLVB_f5RyRsm_S-Vjl-0SOHxSWLU4jD6
X-Proofpoint-GUID: SLVB_f5RyRsm_S-Vjl-0SOHxSWLU4jD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_18,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set fixes ambiguity in BPF verifier log output of SCALAR regis=
ter
in the parts that emit umin/umax, smin/smax, etc ranges. See patch #4 for
details.

Also, patch #5 fixes an issue with verifier log missing instruction conte=
xt
(state) output for conditionals that trigger precision marking. See detai=
ls in
the patch.

First two patches are just improvements to two selftests that are very fl=
aky
locally when run in parallel mode.

Patch #3 changes 'align' selftest to be less strict about exact verifier =
log
output (which patch #4 changes, breaking lots of align tests as written).=
 Now
test does more of a register substate checks, mostly around expected var_=
off()
values. This 'align' selftests is one of the more brittle ones and requir=
es
constant adjustment when verifier log output changes, without really catc=
hing
any new issues. So hopefully these changes can minimize future support ef=
forts
for this specific set of tests.

Andrii Nakryiko (5):
  selftests/bpf: improve percpu_alloc test robustness
  selftests/bpf: improve missed_kprobe_recursion test robustness
  selftests/bpf: make align selftests more robust
  bpf: disambiguate SCALAR register state output in verifier logs
  bpf: ensure proper register state printing for cond jumps

 kernel/bpf/verifier.c                         |  74 ++++--
 .../testing/selftests/bpf/prog_tests/align.c  | 241 +++++++++---------
 .../testing/selftests/bpf/prog_tests/missed.c |   8 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   |   3 +
 .../selftests/bpf/progs/exceptions_assert.c   |  18 +-
 .../selftests/bpf/progs/percpu_alloc_array.c  |   7 +
 .../progs/percpu_alloc_cgrp_local_storage.c   |   4 +
 .../selftests/bpf/progs/verifier_ldsx.c       |   2 +-
 8 files changed, 200 insertions(+), 157 deletions(-)

--=20
2.34.1


