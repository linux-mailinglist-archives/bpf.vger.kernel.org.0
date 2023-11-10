Return-Path: <bpf+bounces-14662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302027E75EA
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB5128175E
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316765F;
	Fri, 10 Nov 2023 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A627F
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 00:26:55 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580C62590
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 16:26:55 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYZxA029058
	for <bpf@vger.kernel.org>; Thu, 9 Nov 2023 16:26:54 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u97ht133m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 16:26:54 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 16:26:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 1ADF23B3FA034; Thu,  9 Nov 2023 16:26:39 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf 0/3] BPF control flow graph and precision backtrack fixes
Date: Thu, 9 Nov 2023 16:26:35 -0800
Message-ID: <20231110002638.4168352-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: b31lPiIHKZHr1f4lmqR0Us-sYwuZyunk
X-Proofpoint-GUID: b31lPiIHKZHr1f4lmqR0Us-sYwuZyunk
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02

A small fix to BPF verifier's CFG logic around handling and reporting ldimm=
64
instructions. Patch #1 was previously submitted separately ([0]), and so th=
is
patch set supersedes that patch.

Second patch is fixing obscure corner case in mark_chain_precise() logic. S=
ee
patch for details. Patch #3 adds a dedicated test, however fragile it might.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231101205626.1=
19243-1-andrii@kernel.org/


Andrii Nakryiko (3):
  bpf: handle ldimm64 properly in check_cfg()
  bpf: fix precision backtracking instruction iteration
  selftests/bpf: add edge case backtracking logic test

 include/linux/bpf.h                           |  8 +++-
 kernel/bpf/verifier.c                         | 48 +++++++++++++++----
 .../selftests/bpf/progs/verifier_precision.c  | 40 ++++++++++++++++
 .../testing/selftests/bpf/verifier/ld_imm64.c |  8 ++--
 4 files changed, 89 insertions(+), 15 deletions(-)

--=20
2.34.1


