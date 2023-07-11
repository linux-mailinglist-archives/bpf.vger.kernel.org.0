Return-Path: <bpf+bounces-4794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96174F7B9
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365A7281929
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF1B1EA87;
	Tue, 11 Jul 2023 18:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575941E508
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 18:00:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1181A173A
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:30 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BHhC3a016208
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=BM8HYDmrXSO/pWVj8vMyHRx+wjF/5CBaLyVdGjIVhPY=;
 b=JyhJxGZYn/f10pusfMpfZ3zEPFNjkgfP0RGWhxvtSEay4PrBGJyi1umG9q+EwTDsCZBd
 jEeIUrAhF14V/3dYH4KtU3Ou3yEYihcHs54PxxKZR+FMyYqd10Dd6bmBZVKiVuNjhKw5
 R5gfV+LSgLbz5RsL8RI/OFKKoPlIJuKIQXg= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rs0p7w53a-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:29 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 11:00:00 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 4407420EAEEBB; Tue, 11 Jul 2023 10:59:47 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/6] [DONOTAPPLY] Revert "bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"
Date: Tue, 11 Jul 2023 10:59:40 -0700
Message-ID: <20230711175945.3298231-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711175945.3298231-1-davemarchevsky@fb.com>
References: <20230711175945.3298231-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ty7yAm5hkiZZgdLJGuwRfkpKR2gBbiEo
X-Proofpoint-ORIG-GUID: Ty7yAm5hkiZZgdLJGuwRfkpKR2gBbiEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_10,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is included in the series so that the test added in this series is
run by CI.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c                                    | 5 +----
 tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..a4949e2442ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11028,10 +11028,7 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a type with bpf_refcount field=
\n", i);
 				return -EINVAL;
 			}
-			if (rec->refcount_off >=3D 0) {
-				verbose(env, "bpf_refcount_acquire calls are disabled for now\n");
-				return -EINVAL;
-			}
+
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


