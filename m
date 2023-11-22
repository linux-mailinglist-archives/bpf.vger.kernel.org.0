Return-Path: <bpf+bounces-15618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB77F3B21
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F6A282ABB
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B417F7;
	Wed, 22 Nov 2023 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC8197
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:53 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM0Yd0U028672
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:53 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uh3g9hwue-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:52 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 17:17:24 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DFF4D3BE88949; Tue, 21 Nov 2023 17:17:15 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 08/10] bpf: enforce precision of R0 on program/async callback return
Date: Tue, 21 Nov 2023 17:16:54 -0800
Message-ID: <20231122011656.1105943-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122011656.1105943-1-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jrsvB_HcupPxzChiLG2XCNZHg-7wRjpX
X-Proofpoint-GUID: jrsvB_HcupPxzChiLG2XCNZHg-7wRjpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_16,2023-11-21_01,2023-05-22_02

Given we enforce a valid range for program and async callback return
value, we must mark R0 as precise to avoid incorrect state pruning.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 87d720d44e0c..1a0a545aec9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15003,6 +15003,10 @@ static int check_return_code(struct bpf_verifier=
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


