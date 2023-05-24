Return-Path: <bpf+bounces-1192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E2710128
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 00:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD3328140B
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 22:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AF18494;
	Wed, 24 May 2023 22:55:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8010E6
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 22:55:23 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A5899
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:19 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHRoZr029231
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:18 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qsde0e538-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:55:18 -0700
Received: from twshared66906.03.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 15:55:16 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C767C3149A79D; Wed, 24 May 2023 15:54:22 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/3] Relax checks for unprivileged bpf() commands
Date: Wed, 24 May 2023 15:54:18 -0700
Message-ID: <20230524225421.1587859-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WqXKST5wnbmIk_uH_J2CBM3ZSV6RXzv3
X-Proofpoint-ORIG-GUID: WqXKST5wnbmIk_uH_J2CBM3ZSV6RXzv3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

During last relaxation of bpf syscall's capabilities checks ([0]), the model
of FD-based ownership was established: if process through whatever means got
FD for some BPF object (map, prog, etc), it should be able to perform
operations on this object without extra CAP_SYS_ADMIN or CAP_BPF capabiliti=
es.

It seems like we missed a few cases, though, in which we are still enforcin=
g extra caps for no good reason, even though operations are not really unsa=
fe and/or do not require any system-wide capabilities:
  - BPF_MAP_FREEZE command;
  - GET_NEXT_ID family of commands;
  - GET_INFO_BY_FD command has extra bpf_capable()-based sanitization.

This patch set is removing these unnecessary checks. MAP_FREEZE and INFO_BY=
_FD
are deviating from the "if you own FD, you can work with BPF object".

GET_NEXT_ID is a completely safe and unprivileged operation that returns ju=
st
IDs of BPF objects. One still needs to go through CAP_SYS_ADMIN-guarded
GET_FD_BY_ID command to get ahold of FD to do any operation on corresponding
BPF object. As such, it seems completely safe to drop CAP_SYS_ADMIN checks =
for
GET_NEXT_ID.

  [0] https://lore.kernel.org/all/1652970334-30510-2-git-send-email-alan.ma=
guire@oracle.com/

Andrii Nakryiko (3):
  bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
  bpf: don't require CAP_SYS_ADMIN for getting NEXT_ID
  bpf: don't require bpf_capable() for GET_INFO_BY_FD

 kernel/bpf/syscall.c                          | 23 ++++---------------
 .../bpf/prog_tests/unpriv_bpf_disabled.c      | 15 ++----------
 2 files changed, 7 insertions(+), 31 deletions(-)

--=20
2.34.1


