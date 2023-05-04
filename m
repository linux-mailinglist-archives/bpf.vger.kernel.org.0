Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE46F6468
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjEDFeH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 01:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjEDFeF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 01:34:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE72212F
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 22:34:04 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3440rqmg028570
        for <bpf@vger.kernel.org>; Wed, 3 May 2023 22:34:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HZIAX8MckQZy4H8kf69h4gro+xRaKTsFPHnD7RW0cjE=;
 b=MnbQ5xG57Xh1x2oHRgiDilHXdugvKE9mEXGTFWyE+Nxjq12JYWDc86elRhNYZHUtcQ6h
 vQHIaZui5CUCvDYUG7wTJWcAaHH5+9isIUSV1WhPWlRvjK1FfWvQgvEFa2z/9FnpBOCd
 JVxj6AsQH6ilgirKszLSqpfbTpIrVhf+Klg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3qbkxdqn0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 22:34:03 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 22:34:02 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 2DFCA1D7BFC4F; Wed,  3 May 2023 22:33:45 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 1/9] [DONOTAPPLY] Revert "bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"
Date:   Wed, 3 May 2023 22:33:30 -0700
Message-ID: <20230504053338.1778690-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504053338.1778690-1-davemarchevsky@fb.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vJjlVfWCrNGCXhS4bFL87lnGBoD2bXbl
X-Proofpoint-ORIG-GUID: vJjlVfWCrNGCXhS4bFL87lnGBoD2bXbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch should not be applied with the rest of the series as the
series doesn't fix all bpf_refcount issues. It is included here to allow
CI to run the test added later in the series.

Followup series which fixes the remaining problems will include a revert
that should be applied.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c                                    | 5 +----
 tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff4a8ab99f08..6f39534ded2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10572,10 +10572,7 @@ static int check_kfunc_args(struct bpf_verifier_=
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
 			meta->arg_refcount_acquire.btf =3D reg->btf;
 			meta->arg_refcount_acquire.btf_id =3D reg->btf_id;
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

