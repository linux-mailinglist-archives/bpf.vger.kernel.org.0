Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F464DB775
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 18:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350743AbiCPRj6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 13:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348212AbiCPRj5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 13:39:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581203B2AB
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 10:38:41 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GHCee7016469
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 10:38:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tkkGZM4qrDtDVMFyXTalmkVs/dWF6ighWJuR4ImVaAc=;
 b=P4GqLS2fou4sDbWaLnrBjOl573pSL9BF3Ydqun4T8Bs+pMgucBBmh3xLEVgessQGvejx
 eJ6txc7OPeCXv6dts4NKSk7OZD35x7fr1fTfUObL9/Pohhsob3RD9bB/jpxpqf2s9Oxh
 GT935zGWmtp4Pg1O/iaOAGpym4bC+uSX1hA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eue4bk4c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 10:38:40 -0700
Received: from twshared27297.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 10:38:38 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id D98A62186705; Wed, 16 Mar 2022 10:38:35 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 3/3] bpf: selftests: Remove libcap usage from test_progs
Date:   Wed, 16 Mar 2022 10:38:35 -0700
Message-ID: <20220316173835.2039334-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316173816.2035581-1-kafai@fb.com>
References: <20220316173816.2035581-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dPm_yzBDUsCew_yZw6fmGdwlWQ5Yu0oQ
X-Proofpoint-ORIG-GUID: dPm_yzBDUsCew_yZw6fmGdwlWQ5Yu0oQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_07,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch removes the libcap usage from test_progs.
bind_perm.c is the only user.  cap_*_effective() helpers added in the
earlier patch are directly used instead.

No other selftest binary is using libcap, so '-lcap' is also removed
from the Makefile.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/Makefile          |  5 ++-
 .../selftests/bpf/prog_tests/bind_perm.c      | 44 ++++---------------
 2 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 1c6e55740019..11f5883636c3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -25,7 +25,7 @@ CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) =
$(SAN_CFLAGS)	\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS +=3D $(SAN_CFLAGS)
-LDLIBS +=3D -lcap -lelf -lz -lrt -lpthread
+LDLIBS +=3D -lelf -lz -lrt -lpthread
=20
 # Silence some warnings when compiled with clang
 ifneq ($(LLVM),)
@@ -480,7 +480,8 @@ TRUNNER_TESTS_DIR :=3D prog_tests
 TRUNNER_BPF_PROGS_DIR :=3D progs
 TRUNNER_EXTRA_SOURCES :=3D test_progs.c cgroup_helpers.c trace_helpers.c=
	\
 			 network_helpers.c testing_helpers.c		\
-			 btf_helpers.c flow_dissector_load.h
+			 btf_helpers.c flow_dissector_load.h		\
+			 cap_helpers.c
 TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko=
	\
 		       ima_setup.sh					\
 		       $(wildcard progs/btf_dump_test_case_*.c)
diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/t=
esting/selftests/bpf/prog_tests/bind_perm.c
index eac71fbb24ce..a1766a298bb7 100644
--- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
+++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
@@ -4,9 +4,9 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/capability.h>
=20
 #include "test_progs.h"
+#include "cap_helpers.h"
 #include "bind_perm.skel.h"
=20
 static int duration;
@@ -49,41 +49,11 @@ void try_bind(int family, int port, int expected_errn=
o)
 		close(fd);
 }
=20
-bool cap_net_bind_service(cap_flag_value_t flag)
-{
-	const cap_value_t cap_net_bind_service =3D CAP_NET_BIND_SERVICE;
-	cap_flag_value_t original_value;
-	bool was_effective =3D false;
-	cap_t caps;
-
-	caps =3D cap_get_proc();
-	if (CHECK(!caps, "cap_get_proc", "errno %d", errno))
-		goto free_caps;
-
-	if (CHECK(cap_get_flag(caps, CAP_NET_BIND_SERVICE, CAP_EFFECTIVE,
-			       &original_value),
-		  "cap_get_flag", "errno %d", errno))
-		goto free_caps;
-
-	was_effective =3D (original_value =3D=3D CAP_SET);
-
-	if (CHECK(cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_net_bind_service,
-			       flag),
-		  "cap_set_flag", "errno %d", errno))
-		goto free_caps;
-
-	if (CHECK(cap_set_proc(caps), "cap_set_proc", "errno %d", errno))
-		goto free_caps;
-
-free_caps:
-	CHECK(cap_free(caps), "cap_free", "errno %d", errno);
-	return was_effective;
-}
-
 void test_bind_perm(void)
 {
-	bool cap_was_effective;
+	const __u64 net_bind_svc_cap =3D 1ULL << CAP_NET_BIND_SERVICE;
 	struct bind_perm *skel;
+	__u64 old_caps =3D 0;
 	int cgroup_fd;
=20
 	if (create_netns())
@@ -105,7 +75,8 @@ void test_bind_perm(void)
 	if (!ASSERT_OK_PTR(skel, "bind_v6_prog"))
 		goto close_skeleton;
=20
-	cap_was_effective =3D cap_net_bind_service(CAP_CLEAR);
+	ASSERT_OK(cap_disable_effective(net_bind_svc_cap, &old_caps),
+		  "cap_disable_effective");
=20
 	try_bind(AF_INET, 110, EACCES);
 	try_bind(AF_INET6, 110, EACCES);
@@ -113,8 +84,9 @@ void test_bind_perm(void)
 	try_bind(AF_INET, 111, 0);
 	try_bind(AF_INET6, 111, 0);
=20
-	if (cap_was_effective)
-		cap_net_bind_service(CAP_SET);
+	if (old_caps & net_bind_svc_cap)
+		ASSERT_OK(cap_enable_effective(net_bind_svc_cap, NULL),
+			  "cap_enable_effective");
=20
 close_skeleton:
 	bind_perm__destroy(skel);
--=20
2.30.2

