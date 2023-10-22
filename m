Return-Path: <bpf+bounces-12953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812D7D25F7
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 22:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D341C209C0
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA413AC9;
	Sun, 22 Oct 2023 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CF134D6
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 20:58:10 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48263EE
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:09 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MKqR0W008572
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:09 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tvdy6mubj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:08 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 22 Oct 2023 13:58:01 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E19903A33D282; Sun, 22 Oct 2023 13:57:46 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 0/7] BPF register bounds logic and testing improvements
Date: Sun, 22 Oct 2023 13:57:36 -0700
Message-ID: <20231022205743.72352-1-andrii@kernel.org>
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
X-Proofpoint-GUID: kxhG6INylZwQ19NIVNXo2kOt7R7ra0W5
X-Proofpoint-ORIG-GUID: kxhG6INylZwQ19NIVNXo2kOt7R7ra0W5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_19,2023-10-19_01,2023-05-22_02

This patch set adds a big set of manual and auto-generated test cases
validating BPF verifier's register bounds tracking and deduction logic. S=
ee
details in the last patch.

To make this approach work, BPF verifier's logic needed a bunch of
improvements to handle some cases that previously were not covered. This =
had
no implications as to correctness of verifier logic, but it was incomplet=
e
enough to cause significant disagreements with alternative implementation=
 of
register bounds logic that tests in this patch set implement. So we need =
BPF
verifier logic improvements to make all the tests pass.

This is a first part of work with the end goal intended to extend registe=
r
bounds logic to cover range vs range comparisons, which will be submitted
later assuming changes in this patch set land.

See individual patches for details.

v3->v4:
  - improvements to reg_bounds tester (progress report, split 32-bit and
    64-bit ranges, fix various verbosity output issues, etc);
v2->v3:
  - fix a subtle little-endianness assumption inside parge_reg_state() (C=
I);
v1->v2:
  - fix compilation when building selftests with llvm-16 toolchain (CI).

Andrii Nakryiko (7):
  bpf: improve JEQ/JNE branch taken logic
  bpf: derive smin/smax from umin/max bounds
  bpf: enhance subregister bounds deduction logic
  bpf: improve deduction of 64-bit bounds from 32-bit bounds
  bpf: try harder to deduce register bounds from different numeric
    domains
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
  selftests/bpf: BPF register range bounds tester

 kernel/bpf/verifier.c                         |  175 +-
 .../selftests/bpf/prog_tests/reg_bounds.c     | 1756 +++++++++++++++++
 2 files changed, 1879 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reg_bounds.c

--=20
2.34.1


