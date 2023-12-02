Return-Path: <bpf+bounces-16502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B108A801DFD
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA631C2092E
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629D81D69C;
	Sat,  2 Dec 2023 17:57:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BFA125
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 09:57:24 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B29HxEb025373
	for <bpf@vger.kernel.org>; Sat, 2 Dec 2023 09:57:24 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ur1guhq7j-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 09:57:24 -0800
Received: from twshared21997.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 2 Dec 2023 09:57:21 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 39D653C7A814E; Sat,  2 Dec 2023 09:57:12 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v5 bpf-next 03/11] bpf: enforce precision of R0 on callback return
Date: Sat, 2 Dec 2023 09:56:57 -0800
Message-ID: <20231202175705.885270-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202175705.885270-1-andrii@kernel.org>
References: <20231202175705.885270-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8QCCh8qm9U8oGzxjngQfcbprDn9e17C7
X-Proofpoint-ORIG-GUID: 8QCCh8qm9U8oGzxjngQfcbprDn9e17C7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_16,2023-11-30_01,2023-05-22_02

Given verifier checks actual value, r0 has to be precise, so we need to
propagate precision properly. r0 also has to be marked as read,
otherwise subsequent state comparisons will ignore such register as
unimportant and precision won't really help here.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25b9d470957e..849fbf47b5f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9590,6 +9590,13 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
 			verbose(env, "R0 not a scalar value\n");
 			return -EACCES;
 		}
+
+		/* we are going to rely on register's precise value */
+		err =3D mark_reg_read(env, r0, r0->parent, REG_LIVE_READ64);
+		err =3D err ?: mark_chain_precision(env, BPF_REG_0);
+		if (err)
+			return err;
+
 		if (!tnum_in(range, r0->var_off)) {
 			verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
 			return -EINVAL;
--=20
2.34.1


