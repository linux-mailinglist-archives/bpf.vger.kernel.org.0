Return-Path: <bpf+bounces-59688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E016ACE6A3
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 00:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E184E18941D6
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A11224B0C;
	Wed,  4 Jun 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CadooqUP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7D1EEA47
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076120; cv=none; b=JU0nNJegtnxa5DlTvhzYsXX+1rSEX8CmBSfsmzH4DXxuEhN/VhjgFxa56XmfMoob+D+eAA+NxG4tPtZrMoUgmFE3ektx6E+8RlGeMLcYS44HuDa6O5wxTNVbxO7wDIpDlUgE+t3WGX/qlDgxSFIjPl3a2uCNHR3jQ8XsQI/KT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076120; c=relaxed/simple;
	bh=JulR6YDheKBFIv0bV10XP1SH3fbjy1Qy4GJ1A0ayWHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBjrBsHj2El9E688xTzHTtTXsIEq82AKscp1B/aFrA7R69MSAR7Xnn7Aj5nRgFyt+5spNc/mgEpwDP4Y2vafejQbiLYFScHUoTi0eMufdE/+z8knTS94+pJHq5DbGQ0G+cL8PFaud9Vpx1sZUKaVbs6eyjmT3Kf65j5PSim/uI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CadooqUP; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554MPElY003313
	for <bpf@vger.kernel.org>; Wed, 4 Jun 2025 15:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	s2048-2021-q4; bh=3aCvM8ARGYrChwqR6feZB5BeukHj72Z8ChBJGFcJYyI=; b=
	CadooqUPA8gYiQduxN9z8lhClg82p4Dgzlv3txyNZt8J+PQsajO3sTROeeOzrVcV
	kMrzwa9pZHVCdbRFGeWb2hfFdPvk0//Idk5FTY2skBHLfmFYHE/xKVuyIxCiLmyn
	+VcnQqhFT2dkVE0IFLizbEhFOAfbnZy4KmK/hATECRVetIi1kERyOFPVkwq2yGUW
	Osp5KSoBzBd4wBYZO4q7EmrAUXWeIPlnlmiaa+rAL/LZhRcKDEQ2f0L0zTGYZKXz
	97hsCXZo67QaAII2MZ4EP5aH25crsbxBhk6xp/YF33Z6iFWZmMsdk9+Ku5wr8ODM
	kG2b6DLNyC+iGeU/GI9h3g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 472mnjw8us-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 15:28:38 -0700 (PDT)
Received: from twshared77120.48.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 4 Jun 2025 22:28:13 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 1E54646C87B; Wed,  4 Jun 2025 15:27:59 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <eddyz87@gmail.com>, <mykolal@fb.com>, <yonghong.song@linux.dev>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: add cmp_map_pointer_with_const test
Date: Wed, 4 Jun 2025 15:27:28 -0700
Message-ID: <20250604222729.3351946-2-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250604222729.3351946-1-isolodrai@meta.com>
References: <20250604222729.3351946-1-isolodrai@meta.com>
Reply-To: <ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE4NSBTYWx0ZWRfX4XTkWeIMwDP3 5bZDnD85hU1u0V5+QiEDB6b41TtuyJlglLohZlHb0y/j9+qOYXvU6SI4kfsJnLGwAvFiylsR57h SachABzRo/bXmDwQqUZNYmW/+tU+9kAqg2GBR08s9lWRx1XNYBs1TWM2j/NX8ABHG3byzYMWLQF
 5d89usog9+zSG+QxuIuB7CBQj31eYymggv9OH4tjOENrtObHVH/AkvU9etPcGePd1/x6aicJFm/ ajQmg9iNp77tt1uWR3nu6HP6Cge0KUGJzUSyiSZChYM1THi02DUozLisf3C79qtOS5lVRG5NiZm keUDmGfcofN/GqkmNHOygRYZXklBgFi253lPByApps5oqtwArElAeAxN83TmnjVdERyU3C0z4xv
 cFuG0S/fRLd6G8gi264sTahLiHwQbepbR7IdSsq4TRAXwrgRjtFGZB93BOUuKmN7naQRXZZF
X-Authority-Analysis: v=2.4 cv=S+zZwJsP c=1 sm=1 tr=0 ts=6840c896 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=ucs8h2RCo5JdfC4RZmEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 7CsqgC1QUZxKi-qIR9_EemUd394EVRM_
X-Proofpoint-GUID: 7CsqgC1QUZxKi-qIR9_EemUd394EVRM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01

Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
BPF program with this code must not pass verification in unpriv.

Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
index 28200f068ce5..c4a48b57e167 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -634,6 +634,23 @@ l0_%=3D:	r0 =3D 0;						\
 	: __clobber_all);
 }
=20
+SEC("socket")
+__description("unpriv: cmp map pointer with const")
+__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibite=
d")
+__retval(0)
+__naked void cmp_map_pointer_with_const(void)
+{
+	asm volatile ("					\
+	r1 =3D 0;						\
+	r1 =3D %[map_hash_8b] ll;				\
+	if r1 =3D=3D 0xdeadbeef goto l0_%=3D;		\
+l0_%=3D:	r0 =3D 0;						\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("unpriv: write into frame pointer")
 __failure __msg("frame pointer is read only")
--=20
2.47.1


