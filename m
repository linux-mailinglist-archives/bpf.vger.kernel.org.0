Return-Path: <bpf+bounces-15464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351247F2213
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8041B21933
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D1EA2;
	Tue, 21 Nov 2023 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91476B4
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:16 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKN8H6q018312
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:16 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uggutgdcu-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:23:16 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 16:22:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5D90E3BD94283; Mon, 20 Nov 2023 16:22:29 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 03/10] bpf: fix check for attempt to corrupt spilled pointer
Date: Mon, 20 Nov 2023 16:22:14 -0800
Message-ID: <20231121002221.3687787-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121002221.3687787-1-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cKtvA-753iC5x0ltGhFCZwgHNSF_aXRs
X-Proofpoint-GUID: cKtvA-753iC5x0ltGhFCZwgHNSF_aXRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02

When register is spilled onto a stack as a 1/2/4-byte register, we set
slot_type[BPF_REG_SIZE - 1] (plus potentially few more below it,
depending on actual spill size). So to check if some stack slot has
spilled register we need to consult slot_type[7], not slot_type[0].

To avoid the need to remember and double-check this in the future, just
use is_spilled_reg() helper.

Fixes: 638f5b90d460 ("bpf: reduce verifier memory consumption")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c22b557fe30f..357feb27e90a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4359,7 +4359,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
 	if (!env->allow_ptr_leaks &&
-	    state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
+	    is_spilled_reg(&state->stack[spi]) &&
 	    size !=3D BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
--=20
2.34.1


