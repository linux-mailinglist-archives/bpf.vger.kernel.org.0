Return-Path: <bpf+bounces-17885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB42813DE0
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406E01C21E80
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DDD6A34B;
	Thu, 14 Dec 2023 23:02:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807861FD9
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEJRstS013259
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 14:50:34 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uyqg7qyj7-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 14:50:34 -0800
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 14:50:32 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 70E623D2A781D; Thu, 14 Dec 2023 14:50:24 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 0/2] BPF FS mount options parsing follow ups
Date: Thu, 14 Dec 2023 14:50:14 -0800
Message-ID: <20231214225016.1209867-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: --WgHrsSwb1aCPPuSIS6LGAlpaiIMvA4
X-Proofpoint-ORIG-GUID: --WgHrsSwb1aCPPuSIS6LGAlpaiIMvA4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_15,2023-12-14_01,2023-05-22_02

Original BPF token patch set ([0]) added delegate_xxx mount options which
supported only special "any" value and hexadecimal bitmask. This patch set
attempts to make specifying and inspecting these mount options more
human-friendly by supporting string constants matching corresponding bpf_cm=
d,
bpf_map_type, bpf_prog_type, and bpf_attach_type enumerators.

This implementation relies on BTF information to find all supported symbolic
names. If kernel wasn't built with BTF, BPF FS will still support "any" and
hex-based mask.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D805707&=
state=3D*

v1->v2:
  - strip BPF_, BPF_MAP_TYPE_, and BPF_PROG_TYPE_ prefixes,
    do case-insensitive comparison, normalize to lower case (Alexei).

Andrii Nakryiko (2):
  bpf: support symbolic BPF FS delegation mount options
  selftests/bpf: utilize string values for delegate_xxx mount options

 kernel/bpf/inode.c                            | 249 +++++++++++++++---
 .../testing/selftests/bpf/prog_tests/token.c  |  52 ++--
 2 files changed, 243 insertions(+), 58 deletions(-)

--=20
2.34.1


