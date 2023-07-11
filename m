Return-Path: <bpf+bounces-4807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2B74FBD0
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 01:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E332817FD
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D41ED45;
	Tue, 11 Jul 2023 23:24:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5119BBE
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 23:24:14 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C38E74
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:24:12 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 36BMxPqY023965
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:24:12 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3rsgbp86a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:24:12 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 16:24:10 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 869D13461DE14; Tue, 11 Jul 2023 16:24:01 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/2] bpf: teach verifier actual bounds of bpf_get_smp_processor_id() result
Date: Tue, 11 Jul 2023 16:23:59 -0700
Message-ID: <20230711232400.1658562-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: KSeGc0aqsv5nZzzqpMdgRyxJBYpH4eLm
X-Proofpoint-GUID: KSeGc0aqsv5nZzzqpMdgRyxJBYpH4eLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_get_smp_processor_id() helper returns current CPU on which BPF
program runs. It can't return value that is bigger than maximum allowed
number of CPUs (minus one, due to zero indexing). Teach BPF verifier to
recognize that. This makes it possible to use bpf_get_smp_processor_id()
result to index into arrays without extra checks, as demonstrated in
subsequent selftests/bpf patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..81a93eeac7a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25,6 +25,7 @@
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
 #include <linux/module.h>
+#include <linux/cpumask.h>
=20
 #include "disasm.h"
=20
@@ -9116,19 +9117,33 @@ static void do_refine_retval_range(struct bpf_reg=
_state *regs, int ret_type,
 {
 	struct bpf_reg_state *ret_reg =3D &regs[BPF_REG_0];
=20
-	if (ret_type !=3D RET_INTEGER ||
-	    (func_id !=3D BPF_FUNC_get_stack &&
-	     func_id !=3D BPF_FUNC_get_task_stack &&
-	     func_id !=3D BPF_FUNC_probe_read_str &&
-	     func_id !=3D BPF_FUNC_probe_read_kernel_str &&
-	     func_id !=3D BPF_FUNC_probe_read_user_str))
+	if (ret_type !=3D RET_INTEGER)
 		return;
=20
-	ret_reg->smax_value =3D meta->msize_max_value;
-	ret_reg->s32_max_value =3D meta->msize_max_value;
-	ret_reg->smin_value =3D -MAX_ERRNO;
-	ret_reg->s32_min_value =3D -MAX_ERRNO;
-	reg_bounds_sync(ret_reg);
+	switch (func_id) {
+	case BPF_FUNC_get_stack:
+	case BPF_FUNC_get_task_stack:
+	case BPF_FUNC_probe_read_str:
+	case BPF_FUNC_probe_read_kernel_str:
+	case BPF_FUNC_probe_read_user_str:
+		ret_reg->smax_value =3D meta->msize_max_value;
+		ret_reg->s32_max_value =3D meta->msize_max_value;
+		ret_reg->smin_value =3D -MAX_ERRNO;
+		ret_reg->s32_min_value =3D -MAX_ERRNO;
+		reg_bounds_sync(ret_reg);
+		break;
+	case BPF_FUNC_get_smp_processor_id:
+		ret_reg->umax_value =3D nr_cpu_ids - 1;
+		ret_reg->u32_max_value =3D nr_cpu_ids - 1;
+		ret_reg->smax_value =3D nr_cpu_ids - 1;
+		ret_reg->s32_max_value =3D nr_cpu_ids - 1;
+		ret_reg->umin_value =3D 0;
+		ret_reg->u32_min_value =3D 0;
+		ret_reg->smin_value =3D 0;
+		ret_reg->s32_min_value =3D 0;
+		reg_bounds_sync(ret_reg);
+		break;
+	}
 }
=20
 static int
--=20
2.34.1


