Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4A4D56D0
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiCKAid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiCKAid (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:38:33 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549061A1298
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:37:31 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AIBPBp030254
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:37:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=HaiSDnw0KGDO4QNgWniTTXWznCBLtybPJJRVMm55UwU=;
 b=RwGcRRBvWfMKoGsry+gx74w7z1bzSBMqcRqBBRQEvaOQii6lscKBJ7SvqOS8eS62NaNy
 czH6L3kMFy3K2mvIgfFcHRuobi0z9BI8879Wcml9+RpteMQk97qdLI+l5W2DJIIrevYA
 YCairqQN41MuBEWtF0YhZq9tYI/KSD12rvA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqee3e49r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:37:31 -0800
Received: from twshared21672.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 16:37:30 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B4CF677303E1; Thu, 10 Mar 2022 16:37:21 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2] selftests/bpf: fix a clang compilation error for send_signal.c
Date:   Thu, 10 Mar 2022 16:37:21 -0800
Message-ID: <20220311003721.2177170-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kEZsPBajeU5nViwT9GbNx1CiWKfYRJwF
X-Proofpoint-ORIG-GUID: kEZsPBajeU5nViwT9GbNx1CiWKfYRJwF
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building selftests/bpf with latest clang compiler (clang15 built
from source), I hit the following compilation error:
  /.../prog_tests/send_signal.c:43:16: error: variable 'j' set but not used=
 [-Werror,-Wunused-but-set-variable]
                  volatile int j =3D 0;
                               ^
  1 error generated.
The problem also exists with clang13 and clang14. clang12 is okay.

In send_signal.c, we have the following code
  volatile int j =3D 0;
  ...
  for (int i =3D 0; i < 100000000 && !sigusr1_received; i++)
    j /=3D i + 1;
to burn cpu cycles so bpf_send_signal() helper can be tested
in nmi mode.

Slightly changing 'j /=3D i + 1' to 'j /=3D i + j + 1' or 'j++' can
fix the problem. Further investigation indicated this should be
a clang bug ([1]). The upstream fix will be proposed later. But it is
a good idea to workaround the issue to unblock people who build
kernel/selftests with clang.

 [1] https://discourse.llvm.org/t/strange-clang-unused-but-set-variable-err=
or-with-volatile-variables/60841

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/t=
esting/selftests/bpf/prog_tests/send_signal.c
index def50f1c5c31..d71226e34c34 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -65,7 +65,7 @@ static void test_send_signal_common(struct perf_event_att=
r *attr,
=20
 		/* wait a little for signal handler */
 		for (int i =3D 0; i < 100000000 && !sigusr1_received; i++)
-			j /=3D i + 1;
+			j /=3D i + j + 1;
=20
 		buf[0] =3D sigusr1_received ? '2' : '0';
 		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
--=20
2.30.2

