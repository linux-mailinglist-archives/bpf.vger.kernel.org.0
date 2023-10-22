Return-Path: <bpf+bounces-12955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D407D25F9
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 22:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53481F217DD
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C334134CA;
	Sun, 22 Oct 2023 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F21134A2
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 20:58:16 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A44DD
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:15 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MAS7ws032420
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tvdy6mubm-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 13:58:15 -0700
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 22 Oct 2023 13:58:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 33C253A33D2EC; Sun, 22 Oct 2023 13:57:58 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 5/7] bpf: try harder to deduce register bounds from different numeric domains
Date: Sun, 22 Oct 2023 13:57:41 -0700
Message-ID: <20231022205743.72352-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022205743.72352-1-andrii@kernel.org>
References: <20231022205743.72352-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 629ocigsF9kIZhVycQQzbimmMspMTfQP
X-Proofpoint-ORIG-GUID: 629ocigsF9kIZhVycQQzbimmMspMTfQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_19,2023-10-19_01,2023-05-22_02

There are cases (caught by subsequent reg_bounds tests in selftests/bpf)
where performing one round of __reg_deduce_bounds() doesn't propagate
all the information from, say, s32 to u32 bounds and than from newly
learned u32 bounds back to u64 and s64. So perform __reg_deduce_bounds()
twice to make sure such derivations are propagated fully after
reg_bounds_sync().

One such example is test `(s64)[0xffffffff00000001; 0] (u64)<
0xffffffff00000000` from selftest patch from this patch set. It demonstra=
tes an
intricate dance of u64 -> s64 -> u64 -> u32 bounds adjustments, which req=
uires
two rounds of __reg_deduce_bounds(). Here are corresponding refinement lo=
g from
selftest, showing evolution of knowledge.

REFINING (FALSE R1) (u64)SRC=3D[0xffffffff00000000; U64_MAX] (u64)DST_OLD=
=3D[0; U64_MAX] (u64)DST_NEW=3D[0xffffffff00000000; U64_MAX]
REFINING (FALSE R1) (u64)SRC=3D[0xffffffff00000000; U64_MAX] (s64)DST_OLD=
=3D[0xffffffff00000001; 0] (s64)DST_NEW=3D[0xffffffff00000001; -1]
REFINING (FALSE R1) (s64)SRC=3D[0xffffffff00000001; -1] (u64)DST_OLD=3D[0=
xffffffff00000000; U64_MAX] (u64)DST_NEW=3D[0xffffffff00000001; U64_MAX]
REFINING (FALSE R1) (u64)SRC=3D[0xffffffff00000001; U64_MAX] (u32)DST_OLD=
=3D[0; U32_MAX] (u32)DST_NEW=3D[1; U32_MAX]

R1 initially has smin/smax set to [0xffffffff00000001; -1], while umin/um=
ax is
unknown. After (u64)< comparison, in FALSE branch we gain knowledge that
umin/umax is [0xffffffff00000000; U64_MAX]. That causes smin/smax to lear=
n that
zero can't happen and upper bound is -1. Then smin/smax is adjusted from
umin/umax improving lower bound from 0xffffffff00000000 to 0xffffffff0000=
0001.
And then eventually umin32/umax32 bounds are drived from umin/umax and be=
come
[1; U32_MAX].

Selftest in the last patch is actually implementing a multi-round fixed-p=
oint
convergence logic, but so far all the tests are handled by two rounds of
reg_bounds_sync() on the verifier state, so we keep it simple for now.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4bb0a121e31a..31c64b1ef2dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2327,6 +2327,7 @@ static void reg_bounds_sync(struct bpf_reg_state *r=
eg)
 	__update_reg_bounds(reg);
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
+	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
--=20
2.34.1


