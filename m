Return-Path: <bpf+bounces-13661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED37DC59A
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E861C20C00
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6DECA44;
	Tue, 31 Oct 2023 05:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F46D22
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:03:45 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87501D8
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:44 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UItotN003514
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u2j6rtw9h-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:03:43 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 22:03:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5E9D83AA9B6A6; Mon, 30 Oct 2023 22:03:26 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/7] Complete BPF verifier precision tracking support for register spills
Date: Mon, 30 Oct 2023 22:03:17 -0700
Message-ID: <20231031050324.1107444-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: MtsOJQGX9rs_4NfnlDH_a1ps57LasWgb
X-Proofpoint-GUID: MtsOJQGX9rs_4NfnlDH_a1ps57LasWgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02

Add support to BPF verifier to track and support register spill/fill to/f=
rom
stack regardless if it was done through read-only R10 register (which is =
the
only form supported today), or through a general register after copying R=
10
into it, while also potentially modifying offset.

Once we add register this generic spill/fill support to precision
backtracking, we can take advantage of it to stop doing eager STACK_ZERO
conversion on register spill. Instead we can rely on (im)precision of spi=
lled
const zero register to improve verifier state pruning efficiency. This
situation of using const zero register to initialize stack slots is very
common with __builtin_memset() usage or just zero-initializing variables =
on
the stack, and it causes unnecessary state duplication, as that STACK_ZER=
O
knowledge is often not necessary for correctness, as those zero values ar=
e
never used in precise context. Thus, relying on register imprecision help=
s
tremendously, especially in real-world BPF programs.

To make spilled const zero register behave completely equivalently to
STACK_ZERO, we need to improve few other small pieces, which is done in t=
he
second part of the patch set. See individual patches for details. There a=
re
also two small bug fixes spotted during STACK_ZERO debugging.

Andrii Nakryiko (7):
  bpf: use common jump (instruction) history across all states
  bpf: support non-r10 register spill/fill to/from stack in precision
    tracking
  bpf: enforce precision for r0 on callback return
  bpf: fix check for attempt to corrupt spilled pointer
  bpf: preserve STACK_ZERO slots on partial reg spills
  bpf: preserve constant zero when doing partial register restore
  bpf: track aligned STACK_ZERO cases as imprecise spilled registers

 include/linux/bpf_verifier.h                  |  34 ++-
 kernel/bpf/verifier.c                         | 274 ++++++++++--------
 .../bpf/progs/verifier_subprog_precision.c    |  83 +++++-
 .../testing/selftests/bpf/verifier/precise.c  |  38 ++-
 4 files changed, 285 insertions(+), 144 deletions(-)

--=20
2.34.1


