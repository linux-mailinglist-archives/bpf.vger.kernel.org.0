Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5909C524736
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351138AbiELHnn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 03:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351139AbiELHnm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:43:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB0B1A15FA
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:41 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwXm7014101
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SHm43HEQuqASi86Cw+HM1cSbRzda9LWoQ4hy71JlmWs=;
 b=PaOwYxZgcoXBCYg1r04NiKLvFfGv8CT0fodPhC0UqsiwsjQi3N+Uf29Xu4x/nhvRvcub
 GiVPx1lsN5UY6beZOU4EpIXcec/zp9xMd8gz6oPKHU6bwSALAi+2PIE9tCAI3+CBZC/O
 WXiwbu8W0mxyryUScH/fRZsLB3fffG9StcU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g04tb8s04-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:40 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 00:43:39 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id C103378F7CD2; Thu, 12 May 2022 00:43:29 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 4/5] selftests/bpf: Add test for USDT parse of xmm reg
Date:   Thu, 12 May 2022 00:43:20 -0700
Message-ID: <20220512074321.2090073-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220512074321.2090073-1-davemarchevsky@fb.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7NLalGWQGM-4Cc0h3cVdac2XfdqU9SnV
X-Proofpoint-ORIG-GUID: 7NLalGWQGM-4Cc0h3cVdac2XfdqU9SnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Validate that bpf_get_reg_val helper solves the motivating problem of
this patch series: USDT args passed through xmm regs. The userspace
portion of the test forces STAP_PROBE macro to use %xmm0 and %xmm1 regs
to pass a float and an int, which the bpf-side successfully reads using
BPF_USDT.

In the wild I discovered a sanely-configured USDT in Fedora libpthread
using xmm regs to pass scalar values, likely due to register pressure.
urandom_read_lib_xmm mimics this by using -ffixed-$REG flag to mark
r11-r14 unusable and passing many USDT args.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/testing/selftests/bpf/Makefile          |  8 ++-
 tools/testing/selftests/bpf/prog_tests/usdt.c |  7 +++
 .../selftests/bpf/progs/test_urandom_usdt.c   | 13 ++++
 tools/testing/selftests/bpf/urandom_read.c    |  3 +
 .../selftests/bpf/urandom_read_lib_xmm.c      | 62 +++++++++++++++++++
 5 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/urandom_read_lib_xmm.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 6bbc03161544..19246e34dfe1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -172,10 +172,14 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c u=
random_read_lib2.c
 	$(call msg,LIB,,$@)
 	$(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
=20
-$(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/libu=
random_read.so
+$(OUTPUT)/liburandom_read_xmm.so: urandom_read_lib_xmm.c
+	$(call msg,LIB,,$@)
+	$(Q)$(CC) -O0 -ffixed-r11 -ffixed-r12 -ffixed-r13 -ffixed-r14 -fPIC $(L=
DFLAGS) $^ $(LDLIBS) --shared -o $@
+
+$(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/libu=
random_read.so $(OUTPUT)/liburandom_read_xmm.so
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.c,$^)			       \
-		  liburandom_read.so $(LDLIBS)	       			       \
+		  liburandom_read.so liburandom_read_xmm.so $(LDLIBS)          \
 		  -Wl,-rpath=3D. -Wl,--build-id=3Dsha1 -o $@
=20
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile=
 bpf_testmod/*.[ch])
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
index a71f51bdc08d..f98749ac74a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -385,6 +385,12 @@ static void subtest_urandom_usdt(bool auto_attach)
 			goto cleanup;
 		skel->links.urandlib_read_with_sema =3D l;
=20
+		l =3D bpf_program__attach_usdt(skel->progs.urandlib_xmm_reg_read,
+					     urand_pid, "./liburandom_read_xmm.so",
+					     "urandlib", "xmm_reg_read", NULL);
+		if (!ASSERT_OK_PTR(l, "urandlib_xmm_reg_read"))
+			goto cleanup;
+		skel->links.urandlib_xmm_reg_read =3D l;
 	}
=20
 	/* trigger urandom_read USDTs */
@@ -402,6 +408,7 @@ static void subtest_urandom_usdt(bool auto_attach)
 	ASSERT_EQ(bss->urandlib_read_with_sema_call_cnt, 1, "urandlib_w_sema_cn=
t");
 	ASSERT_EQ(bss->urandlib_read_with_sema_buf_sz_sum, 256, "urandlib_w_sem=
a_sum");
=20
+	ASSERT_EQ(bss->urandlib_xmm_reg_read_buf_sz_sum, 256, "liburandom_read_=
xmm.so");
 cleanup:
 	if (urand_pipe)
 		pclose(urand_pipe);
diff --git a/tools/testing/selftests/bpf/progs/test_urandom_usdt.c b/tool=
s/testing/selftests/bpf/progs/test_urandom_usdt.c
index 3539b02bd5f7..575761863eb6 100644
--- a/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
@@ -67,4 +67,17 @@ int BPF_USDT(urandlib_read_with_sema, int iter_num, in=
t iter_cnt, int buf_sz)
 	return 0;
 }
=20
+int urandlib_xmm_reg_read_buf_sz_sum;
+SEC("usdt/./liburandom_read_xmm.so:urandlib:xmm_reg_read")
+int BPF_USDT(urandlib_xmm_reg_read, int *f1, int *f2, int *f3, int a, in=
t b,
+				     int c /*should be float */, int d, int e,
+				     int f, int g, int h, int buf_sz)
+{
+	if (urand_pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urandlib_xmm_reg_read_buf_sz_sum, buf_sz);
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/urandom_read.c b/tools/testing/s=
elftests/bpf/urandom_read.c
index e92644d0fa75..0ee7aad014e1 100644
--- a/tools/testing/selftests/bpf/urandom_read.c
+++ b/tools/testing/selftests/bpf/urandom_read.c
@@ -20,6 +20,8 @@ void urand_read_without_sema(int iter_num, int iter_cnt=
, int read_sz);
 /* these are coming from urandom_read_lib{1,2}.c */
 void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz);
 void urandlib_read_without_sema(int iter_num, int iter_cnt, int read_sz)=
;
+/* defined in urandom_read_lib_xmm.c */
+void urandlib_read_xmm_args(int iter_num, int iter_cnt, int read_sz);
=20
 unsigned short urand_read_with_sema_semaphore SEC(".probes");
=20
@@ -39,6 +41,7 @@ void urandom_read(int fd, int count)
 		/* trigger USDTs defined in shared lib */
 		urandlib_read_without_sema(i, count, BUF_SIZE);
 		urandlib_read_with_sema(i, count, BUF_SIZE);
+		urandlib_read_xmm_args(i, count, BUF_SIZE);
 	}
 }
=20
diff --git a/tools/testing/selftests/bpf/urandom_read_lib_xmm.c b/tools/t=
esting/selftests/bpf/urandom_read_lib_xmm.c
new file mode 100644
index 000000000000..d5f9c9cf74e7
--- /dev/null
+++ b/tools/testing/selftests/bpf/urandom_read_lib_xmm.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#define STAP_SDT_ARG_CONSTRAINT norx
+/* For x86_64, this was changed from 'nor' default to 'norfxy' in system=
tap
+ * commit eaa15b047 ("PR27829: Support floating point values passed thro=
ugh sdt.h markers")
+ * then changed to 'norx' in commit 1d3653936f ("sys/sdt.h fp constraint=
s cont'd, x86-64 edition")
+ * It's not necessary to set STAP_SDT_ARG_CONSTRAINT for newer systemtap=
 to see
+ * xmm regs used in this program
+ */
+
+#include "sdt.h"
+
+int *f1(void)
+{
+	return (int *)100;
+}
+
+int *f2(void)
+{
+	return (int *)200;
+}
+
+int *f3(void)
+{
+	return (int *)300;
+}
+
+/* Compile w/ -ffixed-r11 -ffixed-r12 -ffixed-r13 -ffixed-r14 -O0 */
+void urandlib_read_xmm_args(int iter_num, int iter_cnt, int read_sz)
+{
+	volatile int a, b, d, e, f, g, h, i;
+	a =3D b =3D d =3D e =3D f =3D g =3D h =3D 300;
+	i =3D read_sz;
+	volatile float c =3D 100;
+
+	STAP_PROBE12(urandlib, xmm_reg_read, f1(), f2(), f3(), a, b, c, d, e, f=
, g, h, i);
+}
+
+/*
+ * `readelf -n` results:
+ * On a test host outside of kernel toolchain (Ubuntu 20.04, 5.13.0-39-g=
eneric, gcc 9.4.0-1ubuntu1~20.04.1)
+ * w/ STAP_SDT_ARG_CONSTRAINT norfxy
+ * 	using system sdt.h:
+ * 		Provider: urandlib
+ * 		Name: xmm_reg_read
+ * 		Location: 0x00000000000011d8, Base: 0x0000000000002008, Semaphore: =
0x0000000000000000
+ * 		Arguments: 8@%rbx 8@%r15 8@%xmm1 -4@%edx -4@%ecx 4@%xmm0 -4@%esi -4=
@%edi -4@%r8d -4@%r9d -4@%r10d -4@%eax
+ *
+ * 	Using a newer systemtap's sdt.h (commit acca4ae47 ("Don't run tls te=
sts if debuginfo is missing")):
+ * 		Provider: urandlib
+ * 		Name: xmm_reg_read
+ * 		Location: 0x00000000000011d8, Base: 0x0000000000002008, Semaphore: =
0x0000000000000000
+ * 		Arguments: 8@%rbx 8@%r15 8@%xmm1 -4@%edx -4@%ecx 4f@%xmm0 -4@%esi -=
4@%edi -4@%r8d -4@%r9d -4@%r10d -4@%eax
+ *
+ * Kernel toolchain:
+ * STAP_SDT_ARG_CONSTRAINT norfxy causes compiler error (due to the 'f')=
, so using 'norx'
+ * 		Provider: urandlib
+ * 		Name: xmm_reg_read
+ * 		Location: 0x0000000000000717, Base: 0x0000000000000738, Semaphore: =
0x0000000000000000
+ * 		Arguments: 8@%rbx 8@%r15 8@-72(%rbp) -4@%edx -4@%ecx 4f@%xmm0 -4@%e=
si -4@%edi -4@%r8d -4@%r9d -4@%r10d -4@%xmm1
+ */
--=20
2.30.2

