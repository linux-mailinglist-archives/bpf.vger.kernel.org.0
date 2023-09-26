Return-Path: <bpf+bounces-10883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842F7AF392
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CA681281894
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5348823;
	Tue, 26 Sep 2023 19:00:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229E3B7B0
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:00:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403CC1BB
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:35 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QIhqlB016777
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tc0h1k16y-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 12:00:34 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 26 Sep 2023 12:00:33 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 48EF02500687C; Tue, 26 Sep 2023 12:00:26 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        <bjorn@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 0/8] Allocate bpf trampoline on bpf_prog_pack
Date: Tue, 26 Sep 2023 12:00:12 -0700
Message-ID: <20230926190020.1111575-1-song@kernel.org>
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
X-Proofpoint-ORIG-GUID: 9KBMXjgCD0LrJ56xoG6xiCiTjYzIgaPK
X-Proofpoint-GUID: 9KBMXjgCD0LrJ56xoG6xiCiTjYzIgaPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This set enables allocating bpf trampoline from bpf_prog_pack on x86. The
majority of this work, however, is the refactoring of trampoline code.
This is needed because we need to handle 4 archs and 2 users (trampoline
and struct_ops).

1/8 is a dependency that is already applied to bpf tree.
2/8 through 7/8 refactors trampoline code. A few helpers are added.
8/8 finally let bpf trampoline on x86 use bpf_prog_pack.

Changes in v3:
1. Fix bug in s390. (Thanks to Ilya Leoshkevich).
2. Fix build error in riscv. (kernel test robot).

Changes in v2:
1. Add missing changes in net/bpf/bpf_dummy_struct_ops.c.
2. Reduce one dry run in arch_prepare_bpf_trampoline. (Xu Kuohai)
3. Other small fixes.

Song Liu (8):
  s390/bpf: Let arch_prepare_bpf_trampoline return program size
  bpf: Let bpf_prog_pack_free handle any pointer
  bpf: Adjust argument names of arch_prepare_bpf_trampoline()
  bpf: Add helpers for trampoline image management
  bpf, x86: Adjust arch_prepare_bpf_trampoline return value
  bpf: Add arch_bpf_trampoline_size()
  bpf: Use arch_bpf_trampoline_size
  x86, bpf: Use bpf_prog_pack for bpf trampoline

 arch/arm64/net/bpf_jit_comp.c   |  55 +++++++++-----
 arch/riscv/net/bpf_jit_comp64.c |  25 ++++---
 arch/s390/net/bpf_jit_comp.c    |  56 +++++++++------
 arch/x86/net/bpf_jit_comp.c     | 124 +++++++++++++++++++++++++-------
 include/linux/bpf.h             |  12 +++-
 include/linux/filter.h          |   2 +-
 kernel/bpf/bpf_struct_ops.c     |  19 +++--
 kernel/bpf/core.c               |  21 +++---
 kernel/bpf/dispatcher.c         |   5 +-
 kernel/bpf/trampoline.c         |  93 ++++++++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c  |   7 +-
 11 files changed, 292 insertions(+), 127 deletions(-)

--
2.34.1

