Return-Path: <bpf+bounces-6015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3DB764215
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6861C21471
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDF4198BD;
	Wed, 26 Jul 2023 22:24:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462871BF1C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:24:57 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32D1BFF
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:24:55 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1484223B79FB9; Wed, 26 Jul 2023 15:08:20 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 10/17] selftests/bpf: Add a cpuv4 test runner for cpu=v4 testing
Date: Wed, 26 Jul 2023 15:08:20 -0700
Message-Id: <20230726220820.1100139-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726220726.1089817-1-yonghong.song@linux.dev>
References: <20230726220726.1089817-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similar to no-alu32 runner, if clang compiler supports -mcpu=3Dv4,
a cpuv4 runner is created to test bpf programs compiled with
-mcpu=3Dv4.

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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/.gitignore |  2 ++
 tools/testing/selftests/bpf/Makefile   | 28 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

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
index 882be03b179f..6a45719a8d47 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -33,9 +33,13 @@ CFLAGS +=3D -g -O0 -rdynamic -Wall -Werror $(GENFLAGS)=
 $(SAN_CFLAGS)	\
 LDFLAGS +=3D $(SAN_LDFLAGS)
 LDLIBS +=3D -lelf -lz -lrt -lpthread
=20
-# Silence some warnings when compiled with clang
 ifneq ($(LLVM),)
+# Silence some warnings when compiled with clang
 CFLAGS +=3D -Wno-unused-command-line-argument
+# Check whether cpu=3Dv4 is supported or not by clang
+ifneq ($(shell $(CLANG) --target=3Dbpf -mcpu=3Dhelp 2>&1 | grep 'v4'),)
+CLANG_CPUV4 :=3D 1
+endif
 endif
=20
 # Order correspond to 'make run_tests' order
@@ -51,6 +55,10 @@ ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS +=3D test_progs-bpf_gcc
 endif
=20
+ifneq ($(CLANG_CPUV4),)
+TEST_GEN_PROGS +=3D test_progs-cpuv4
+endif
+
 TEST_GEN_FILES =3D test_lwt_ip_encap.bpf.o test_tc_edt.bpf.o
 TEST_FILES =3D xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
=20
@@ -383,6 +391,11 @@ define CLANG_NOALU32_BPF_BUILD_RULE
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
@@ -425,7 +438,7 @@ LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(foreach=
 skel,$(LINKED_SKELS),$($(ske
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
 define DEFINE_TEST_RUNNER
=20
 TRUNNER_OUTPUT :=3D $(OUTPUT)$(if $2,/)$2
@@ -453,7 +466,7 @@ endef
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
@@ -584,6 +597,13 @@ TRUNNER_BPF_BUILD_RULE :=3D CLANG_NOALU32_BPF_BUILD_=
RULE
 TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
=20
+# Define test_progs-cpuv4 test runner.
+ifneq ($(CLANG_CPUV4),)
+TRUNNER_BPF_BUILD_RULE :=3D CLANG_CPUV4_BPF_BUILD_RULE
+TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
+$(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
+endif
+
 # Define test_progs BPF-GCC-flavored test runner.
 ifneq ($(BPF_GCC),)
 TRUNNER_BPF_BUILD_RULE :=3D GCC_BPF_BUILD_RULE
@@ -681,7 +701,7 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) =
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


