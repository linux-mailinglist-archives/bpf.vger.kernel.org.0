Return-Path: <bpf+bounces-1643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4AB71F864
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6B61C21162
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152D15A3;
	Fri,  2 Jun 2023 02:27:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690E15C5
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:27:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C411218D
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:27:09 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351NtUor001168
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 19:27:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IMALPJuf/MNN1opfG4ETfKGSVvmPnkhGOfCzAfooE4o=;
 b=ngbYDLsufn2eHabHjNV+m6gkuUh41TAsWAY8ojkBuKMChw3QU9mP/PDqcMzapVUPLqUF
 LdH/FQ3qDf4vn+2egdGUNttQmzbdr04bli4UAStF1mnI3MB1AkF2jx5Nef2hw3Y/fxEK
 iW4bSZ/tT7e52EPGZVtQTOoJNNBr5aG2JrM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxxpa457v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 19:27:09 -0700
Received: from twshared8338.02.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 19:27:06 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 1BF651EF7C85D; Thu,  1 Jun 2023 19:26:49 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 1/9] [DONOTAPPLY] Revert "bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"
Date: Thu, 1 Jun 2023 19:26:39 -0700
Message-ID: <20230602022647.1571784-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602022647.1571784-1-davemarchevsky@fb.com>
References: <20230602022647.1571784-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aq_pfzQLBNg7Wxr57IMeBZf6Ij50wKmz
X-Proofpoint-ORIG-GUID: aq_pfzQLBNg7Wxr57IMeBZf6Ij50wKmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch should not be applied with the rest of the series as the
series doesn't fix all bpf_refcount issues. It is included here to allow
CI to run the test added later in the series.

Followup series which fixes the remaining problems will include a revert
that should be applied.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c                                    | 4 ----
 tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 086b2a14905b..0f04e7fe4843 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10893,10 +10893,6 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a type with bpf_refcount field=
\n", i);
 				return -EINVAL;
 			}
-			if (rec->refcount_off >=3D 0) {
-				verbose(env, "bpf_refcount_acquire calls are disabled for now\n");
-				return -EINVAL;
-			}
 			meta->arg_btf =3D reg->btf;
 			meta->arg_btf_id =3D reg->btf_id;
 			break;
diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/t=
ools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index 595cbf92bff5..2ab23832062d 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -9,8 +9,10 @@
=20
 void test_refcounted_kptr(void)
 {
+	RUN_TESTS(refcounted_kptr);
 }
=20
 void test_refcounted_kptr_fail(void)
 {
+	RUN_TESTS(refcounted_kptr_fail);
 }
--=20
2.34.1


