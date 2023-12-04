Return-Path: <bpf+bounces-16657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AD18042A5
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B1AB20B66
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382C233CC0;
	Mon,  4 Dec 2023 23:39:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D77C3
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:39:53 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KGrm5007860
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:39:53 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3us6mcg0kq-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:39:52 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:39:48 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B39893C9725C5; Mon,  4 Dec 2023 15:39:35 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 01/13] bpf: log PTR_TO_MEM memory size in verifier log
Date: Mon, 4 Dec 2023 15:39:19 -0800
Message-ID: <20231204233931.49758-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204233931.49758-1-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: emxkJeEoGq1Qs4QI2Yll-Xk7jdUmIsl1
X-Proofpoint-ORIG-GUID: emxkJeEoGq1Qs4QI2Yll-Xk7jdUmIsl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

Emit valid memory size addressable through PTR_TO_MEM register.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 55d019f30e91..61d7d23a0118 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -682,6 +682,10 @@ static void print_reg_state(struct bpf_verifier_env =
*env,
 		verbose_a("r=3D");
 		verbose_unum(env, reg->range);
 	}
+	if (base_type(t) =3D=3D PTR_TO_MEM) {
+		verbose_a("sz=3D");
+		verbose_unum(env, reg->mem_size);
+	}
 	if (tnum_is_const(reg->var_off)) {
 		/* a pointer register with fixed offset */
 		if (reg->var_off.value) {
--=20
2.34.1


