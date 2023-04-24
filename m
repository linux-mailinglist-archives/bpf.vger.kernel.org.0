Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA12B6ED642
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 22:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDXUnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDXUnh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 16:43:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6AF5BA7
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 13:43:36 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OJjHls017312
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 13:43:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=u6epOuiUtC4Bor081jYAvVOFuv9FCdnfEX627whjhJ0=;
 b=Zf8LuuwSMG0XKqO5HkHEq6WIvR6Z8XR6GR9ab1wg3oBqOmlxgydZz6gowCtWJclccZ4Q
 mLuR25hBy7ktGDVsueCtdETMXIf1e1MUJii1gSOCcwPg6CrRsVP0tbCjG2L2/5JT9mgr
 3XHpqt7kgn5/dQBzqtIGGMlrprpGdqU4k/U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q5x089c2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 13:43:35 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 13:43:35 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id CA0481CBC26D0; Mon, 24 Apr 2023 13:43:22 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH v2 bpf-next] bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed
Date:   Mon, 24 Apr 2023 13:43:21 -0700
Message-ID: <20230424204321.2680232-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GlPOzurAFyJZMukjJdRYQy7DySMurS8r
X-Proofpoint-GUID: GlPOzurAFyJZMukjJdRYQy7DySMurS8r
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As reported by Kumar in [0], the shared ownership implementation for BPF
programs has some race conditions which need to be addressed before it
can safely be used. This patch does so in a minimal way instead of
ripping out shared ownership entirely, as proper fixes for the issues
raised will follow ASAP, at which point this patch's commit can be
reverted to re-enable shared ownership.

The patch removes the ability to call bpf_refcount_acquire_impl from BPF
programs. Programs can only bump refcount and obtain a new owning
reference using this kfunc, so removing the ability to call it
effectively disables shared ownership.

Instead of changing success / failure expectations for
bpf_refcount-related selftests, this patch just disables them from
running for now.

  [0]: https://lore.kernel.org/bpf/d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xyut=
5qnwivyeru@ysdq543otzv2/

Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c                                    | 5 ++++-
 tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c | 2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d73139ee4d8..5c4aa393f65a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10509,7 +10509,10 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a type with bpf_refcount field\n=
", i);
 				return -EINVAL;
 			}
-
+			if (rec->refcount_off >=3D 0) {
+				verbose(env, "bpf_refcount_acquire calls are disabled for now\n");
+				return -EINVAL;
+			}
 			meta->arg_refcount_acquire.btf =3D reg->btf;
 			meta->arg_refcount_acquire.btf_id =3D reg->btf_id;
 			break;
diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/too=
ls/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index 2ab23832062d..595cbf92bff5 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -9,10 +9,8 @@
=20
 void test_refcounted_kptr(void)
 {
-	RUN_TESTS(refcounted_kptr);
 }
=20
 void test_refcounted_kptr_fail(void)
 {
-	RUN_TESTS(refcounted_kptr_fail);
 }
--=20
2.34.1

