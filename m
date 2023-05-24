Return-Path: <bpf+bounces-1186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78B70FF95
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 23:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC811C20D5B
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 21:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC122621;
	Wed, 24 May 2023 21:02:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7C182A2
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 21:02:57 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04DE6
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:02:55 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34OHI02i013198
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:02:54 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qs8emy3qy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:02:54 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 14:02:53 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5865431486D53; Wed, 24 May 2023 14:02:45 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH RFC bpf-next 0/3] Revamp bpf_attr and make it easier to evolve
Date: Wed, 24 May 2023 14:02:40 -0700
Message-ID: <20230524210243.605832-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: XObvBBl0uOjzPBSLpgEmRC6PGIOufn0y
X-Proofpoint-GUID: XObvBBl0uOjzPBSLpgEmRC6PGIOufn0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RFC patch set revamping anonymous substructs of union bpf_attr, which wou=
ld
allow nicer and more coherent evolution of bpf() syscall arguments, espec=
ially
for commands like BPF_MAP_CREATE and BPF_PROG_LOAD. See patch #1 for
justification and more details. Patch #2 demonstrates how straightforward=
 it
is to switch to new-style substricts in kernel code (and keep in mind tha=
t
this is optional until we need some new field for a given command, so we =
can
do it completely asynchronously from landing bpf_attr changes themselves)=
.
Patch #3 shows also similar libbpf changes, except for libbpf single patc=
hes
switches over entire libbpf code base to new-style substructs (except
skel_internal.h, due to concerns that users might be reliant on outdated
system-wide linux/bpf.h UAPI header).

Andrii Nakryiko (3):
  bpf: revamp bpf_attr and name each command's field and substruct
  bpf: use new named bpf_attr substructs for few commands
  libbpf: use new bpf_xxx_attr structs for bpf() commands

 include/uapi/linux/bpf.h        | 235 +++++++++++++++++----
 kernel/bpf/syscall.c            |  77 ++++---
 tools/include/uapi/linux/bpf.h  | 235 +++++++++++++++++----
 tools/lib/bpf/bpf.c             | 355 ++++++++++++++++----------------
 tools/lib/bpf/gen_loader.c      |  78 +++----
 tools/lib/bpf/libbpf.c          |   4 +-
 tools/lib/bpf/libbpf_internal.h |   2 +-
 7 files changed, 641 insertions(+), 345 deletions(-)

--=20
2.34.1


