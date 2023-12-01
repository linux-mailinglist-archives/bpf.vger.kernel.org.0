Return-Path: <bpf+bounces-16433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FE8012DD
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7251C20C79
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E8A4F8BC;
	Fri,  1 Dec 2023 18:34:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758FB193
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:34:28 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1I9VcF017146
	for <bpf@vger.kernel.org>; Fri, 1 Dec 2023 10:34:28 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uqbjwkgwh-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:34:28 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 10:34:20 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 153103C6DB4D2; Fri,  1 Dec 2023 10:34:17 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v4 bpf-next 08/11] bpf: enforce precision of R0 on program/async callback return
Date: Fri, 1 Dec 2023 10:33:56 -0800
Message-ID: <20231201183359.1769668-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201183359.1769668-1-andrii@kernel.org>
References: <20231201183359.1769668-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6REe8slEzN1GuJkoZPcL8_nhcEFH66iZ
X-Proofpoint-ORIG-GUID: 6REe8slEzN1GuJkoZPcL8_nhcEFH66iZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_16,2023-11-30_01,2023-05-22_02

Given we enforce a valid range for program and async callback return
value, we must mark R0 as precise to avoid incorrect state pruning.

Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c54944af1bcc..2cd150d6d141 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15138,6 +15138,10 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
 		return -EINVAL;
 	}
=20
+	err =3D mark_chain_precision(env, regno);
+	if (err)
+		return err;
+
 	if (!retval_range_within(range, reg)) {
 		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
 		if (!is_subprog &&
--=20
2.34.1


