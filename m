Return-Path: <bpf+bounces-5392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB93A75A304
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF63281AFB
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A27363;
	Thu, 20 Jul 2023 00:02:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F098160
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:02:11 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C2172D
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:10 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMLs2E024175
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=duew0+7MDXqASo6vQ9tKGsZ9MkaoJ4yhuSCyjcW0CgI=;
 b=cKsCJ7YhG4Miz2uTmMtNSdmPhfm10b6SwBgaXfnd7ijHdYmvGj4Dj7wbWrXGLJadphd6
 E+5l63nNDkiAR03qSkOIb8TEwK2eQwTNdphitNPl17HpioBamRhARZcg1V1Pkpx0uXv4
 w+klxhZM67SzGKnPFB+6zjQZXI7ddQ+GOng= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rx7na8kbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:09 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:02:08 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 500CC2354E975; Wed, 19 Jul 2023 17:01:57 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 10/17] selftests/bpf: Add a cpuv4 test runner for cpu=v4 testing
Date: Wed, 19 Jul 2023 17:01:57 -0700
Message-ID: <20230720000157.108411-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DSzo29LHBkEuGq9iUTFZVMXlsMVJ4ZXN
X-Proofpoint-GUID: DSzo29LHBkEuGq9iUTFZVMXlsMVJ4ZXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similar to no-alu32 runner, a cpuv4 runner is created to test
bpf programs compiled with -mcpu=3Dv4.

The following are some num-of-insn statistics for each newer
instructions based on existing selftests, excluding subsequent
cpuv4 insn specific tests.

   insn pattern                # of instructions
   reg =3D (s8)reg               4
   reg =3D (s16)reg              4
   reg =3D (s32)reg              144
   reg =3D *(s8 *)(reg + off)    13
   reg =3D *(s16 *)(reg + off)   14
   reg =3D *(s32 *)(reg + off)   15215
   reg =3D bswap16 reg           142
   reg =3D bswap32 reg           38
   reg =3D bswap64 reg           14
   reg s/=3D reg                 0
   reg s%=3D reg                 0
   gotol <offset>              58

Note that in llvm -mcpu=3Dv4 implementation, the compiler is a little
bit conservative about generating 'gotol' insn (32-bit branch offset)
as it didn't precise count the number of insns (e.g., some insns are
debug insns, etc.). Compared to old 'goto' insn, newer 'gotol' insn
should have comparable verification states to 'goto' insn.

With current patch set, all selftests passed with -mcpu=3Dv4
when running test_progs-cpuv4 binary. The -mcpu=3Dv3 and -mcpu=3Dv2 run
are also successful.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/.gitignore |  2 ++
 tools/testing/selftests/bpf/Makefile   | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
index 116fecf80ca1..110518ba4804 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -13,6 +13,7 @@ test_dev_cgroup
 /test_progs
 /test_progs-no_alu32
 /test_progs-bpf_gcc
+/test_progs-cpuv4
 test_verifier_log
 feature
 test_sock
@@ -36,6 +37,7 @@ test_cpp
 *.lskel.h
 /no_alu32
 /bpf_gcc
+/cpuv4
 /host-tools
 /tools
 /runqslower
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 882be03b179f..e14da9a4705b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -44,7 +44,7 @@ TEST_GEN_PROGS =3D test_verifier test_tag test_maps tes=
t_lru_map test_lpm_map test
 	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
-	test_progs-no_alu32
+	test_progs-no_alu32 test_progs-cpuv4
=20
 # Also test bpf-gcc, if present
 ifneq ($(BPF_GCC),)
@@ -383,6 +383,11 @@ define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
 	$(Q)$(CLANG) $3 -O2 --target=3Dbpf -c $1 -mcpu=3Dv2 -o $2
 endef
+# Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
+define CLANG_CPUV4_BPF_BUILD_RULE
+	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(CLANG) $3 -O2 --target=3Dbpf -c $1 -mcpu=3Dv4 -o $2
+endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
@@ -425,7 +430,7 @@ LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(foreach=
 skel,$(LINKED_SKELS),$($(ske
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
 define DEFINE_TEST_RUNNER
=20
 TRUNNER_OUTPUT :=3D $(OUTPUT)$(if $2,/)$2
@@ -453,7 +458,7 @@ endef
 # Using TRUNNER_XXX variables, provided by callers of DEFINE_TEST_RUNNER=
 and
 # set up by DEFINE_TEST_RUNNER itself, create test runner build rules wi=
th:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
 define DEFINE_TEST_RUNNER_RULES
=20
 ifeq ($($(TRUNNER_OUTPUT)-dir),)
@@ -584,6 +589,11 @@ TRUNNER_BPF_BUILD_RULE :=3D CLANG_NOALU32_BPF_BUILD_=
RULE
 TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
=20
+# Define test_progs-cpuv4 test runner.
+TRUNNER_BPF_BUILD_RULE :=3D CLANG_CPUV4_BPF_BUILD_RULE
+TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
+$(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
+
 # Define test_progs BPF-GCC-flavored test runner.
 ifneq ($(BPF_GCC),)
 TRUNNER_BPF_BUILD_RULE :=3D GCC_BPF_BUILD_RULE
@@ -681,7 +691,7 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) =
$(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h	\
-			       no_alu32 bpf_gcc bpf_testmod.ko		\
+			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
 			       liburandom_read.so)
=20
 .PHONY: docs docs-clean
--=20
2.34.1


