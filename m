Return-Path: <bpf+bounces-14531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617317E60DD
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914011C208D2
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1737150;
	Wed,  8 Nov 2023 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430D36B1E
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:11:58 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1D0258D
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:11:58 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8KMEmB000450
	for <bpf@vger.kernel.org>; Wed, 8 Nov 2023 15:11:57 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7w3dt5yg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 15:11:57 -0800
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 15:11:56 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 13E383B2E7DB7; Wed,  8 Nov 2023 15:11:53 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/4] BPF control flow graph and precision backtrack fixes
Date: Wed, 8 Nov 2023 15:11:48 -0800
Message-ID: <20231108231152.3583545-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nRHAOyLNwlRiZKKdjAjEkwTlvISLpAaP
X-Proofpoint-GUID: nRHAOyLNwlRiZKKdjAjEkwTlvISLpAaP
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
 definitions=2023-11-08_10,2023-11-08_01,2023-05-22_02

A few small-ish fixes to BPF verifier's CFG logic around handling and
reporting ldimm64 instructions, and also too eagerly reporting back edges.
Patch #1 was previously submitted separately ([0]), and so this patch set
supersedes that patch.

Fixing above CFG issues uncovered one interesting edge case in precision
backtracking logic, which patch #2 fixes as well. See the patch for details.

All of these fixes seem to cover quite obscure corner cases that don't come=
 up
often in practice. And they all are applicable only to privileged BPF mode.
So targeting bpf-next seems appropriate. Also note that [1] is also touching
get_prev_insn_idx() function, so would conflict if they land in two differe=
nt
trees.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231101205626.1=
19243-1-andrii@kernel.org/
  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D797781&=
state=3D*

Andrii Nakryiko (4):
  bpf: handle ldimm64 properly in check_cfg()
  bpf: fix precision backtracking instruction iteration
  bpf: fix control-flow graph checking in privileged mode
  selftests/bpf: add more test cases for check_cfg()

 include/linux/bpf.h                           |  8 +-
 kernel/bpf/verifier.c                         | 85 ++++++++++++-------
 .../selftests/bpf/progs/verifier_cfg.c        | 66 +++++++++++++-
 .../selftests/bpf/progs/verifier_loops1.c     |  9 +-
 .../testing/selftests/bpf/verifier/ld_imm64.c |  8 +-
 5 files changed, 136 insertions(+), 40 deletions(-)

--=20
2.34.1


