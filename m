Return-Path: <bpf+bounces-20836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB98443FC
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC40428307E
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D7112AAC4;
	Wed, 31 Jan 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XC31bmbf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D912A146
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718038; cv=none; b=gs9YmojXJQAZLhi26vGdrFuYSNIDfRS/fMjV74INmzoYfQq19qpmVAnVdG+NJZs42UXuvl43AvWpZZ6BOFgqmK8JJmBWjxV3Iqukpq7e2jorZg3r5FRcZVoOQ4hfDs6VS/9e/1yIKmlG4qe4hRaNdAc8ll+91+LNaFKwAJuzucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718038; c=relaxed/simple;
	bh=61UGaGLuOAyWUh0tpr94FBWnJuvL1oHWt9IH+RN3S6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQdzKJrsRgnvD1U8M7SHU0r5N38Q6y2kzcrNoYKaHQCGmKES+PSRHRjA+YIDWG8Spau6HGQ6l/y9bPag0GvvWANeBOLzbItQq7NUQia1N/OCqL89UcmJJi2ZjOV1ZeWd2KTsTNW0a3XlSn0+NUaipIlAxFefgt/OYdb2Cm11sfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XC31bmbf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEx2Zr009196;
	Wed, 31 Jan 2024 16:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=cZqgQAFrP9bKVuMXNOjSlBXsFmnPrNuBj3Sxxz3eWBI=;
 b=XC31bmbfoYTr/betYqHY1dgWpmcdQe54HSLLMHnDuPakoDKSPiPupCKgvARuXupztDEP
 uEBLNPm5jhW6jgXiaLejVExHrvTmd8sZEK42nR+TI9DW6GuqphBz3E5BNqkWqaqqsipU
 x9OR8r5rq7yXua0VK7vNuPniVILDE9bRxPZNgBtreb417LUR++wS4jdBBFtlDM3SXEL5
 rRBOpA5K0FiODZdCvXa40wx1s8mcNCZj3sBcDNQq7l2hj0xEByJBvRMly0hIPGON4C5M
 iabSuYYl3tD7ab2sjkDCCTIF6LufVSo68Njhy65EvieLJNYk4yismgg6IlxMJAW+hn8O Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm429de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 16:20:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VFTlrk025877;
	Wed, 31 Jan 2024 16:20:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr99ax3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 16:20:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VGFbtr033723;
	Wed, 31 Jan 2024 16:20:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-217-87.vpn.oracle.com [10.175.217.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr99awvm-3;
	Wed, 31 Jan 2024 16:20:15 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 2/2] selftests/bpf: add tests for Userspace Runtime Defined Tracepoints (URDT)
Date: Wed, 31 Jan 2024 16:20:03 +0000
Message-Id: <20240131162003.962665-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240131162003.962665-1-alan.maguire@oracle.com>
References: <20240131162003.962665-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310126
X-Proofpoint-GUID: EzNO08sZrWgBlKCjqkr4WmF5sY1QnCC1
X-Proofpoint-ORIG-GUID: EzNO08sZrWgBlKCjqkr4WmF5sY1QnCC1

Add tests that verify operation of URDT probes for both
the statically and dynamically-linked libbpf cases.

Ensure probe attach and auto-attach succeed, and argument counts,
cookies and argument values match expectations.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/prog_tests/urdt.c | 173 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_urdt.c | 100 ++++++++++
 .../selftests/bpf/progs/test_urdt_shared.c    |  59 ++++++
 4 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/urdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_urdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_urdt_shared.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd15017ed3b1..d21acb95a3e1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -39,7 +39,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
+LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread -ldl
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
diff --git a/tools/testing/selftests/bpf/prog_tests/urdt.c b/tools/testing/selftests/bpf/prog_tests/urdt.c
new file mode 100644
index 000000000000..725d064d78f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/urdt.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+
+#include <dlfcn.h>
+
+#include "../sdt.h"
+
+#include "test_urdt.skel.h"
+#include "test_urdt_shared.skel.h"
+
+static volatile __u64 bla = 0xFEDCBA9876543210ULL;
+
+static void subtest_basic_urdt(void)
+{
+	LIBBPF_OPTS(bpf_urdt_opts, opts);
+	struct test_urdt *skel;
+	struct test_urdt__bss *bss;
+	long x = 1;
+	int y = 42;
+	int err;
+	int i;
+
+	skel = test_urdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	err = test_urdt__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* urdt0 won't be auto-attached */
+	opts.urdt_cookie = 0xcafedead;
+	opts.urdt_nargs = 0;
+	skel->links.urdt0 = bpf_program__attach_urdt(skel->progs.urdt0,
+						     0 /*self*/, "/proc/self/exe",
+						     "dyn", "urdt0", &opts);
+	if (!ASSERT_OK_PTR(skel->links.urdt0, "urdt0_link"))
+		goto cleanup;
+
+	BPF_URDT_PROBE0("dyn", "urdt0");
+
+	ASSERT_EQ(bss->urdt0_called, 1, "urdt0_called");
+
+	ASSERT_EQ(bss->urdt0_cookie, 0xcafedead, "urdt0_cookie");
+	ASSERT_EQ(bss->urdt0_arg_cnt, 0, "urdt0_arg_cnt");
+	ASSERT_EQ(bss->urdt0_arg_ret, -ENOENT, "urdt0_arg_ret");
+
+	BPF_URDT_PROBE3("dyn", "urdt3", x, y, &bla);
+
+	ASSERT_EQ(bss->urdt3_called, 1, "urdt3_called");
+	/* ensure the other 3-arg URDT probe does not trigger */
+	ASSERT_EQ(bss->urdt3alt_called, 0, "urdt3alt_notcalled");
+	/* auto-attached urdt3 gets default zero cookie value */
+	ASSERT_EQ(bss->urdt3_cookie, 0, "urdt3_cookie");
+	ASSERT_EQ(bss->urdt3_arg_cnt, 3, "urdt3_arg_cnt");
+
+	ASSERT_EQ(bss->urdt3_arg1, 1, "urdt3_arg1");
+	ASSERT_EQ(bss->urdt3_arg2, 42, "urdt3_arg2");
+	ASSERT_EQ((long)bss->urdt3_arg3, (long)&bla, "urdt3_arg3");
+
+	/* now call alternative 3-arg function, and make sure dyn/urdt3
+	 * does not trigger.
+	 */
+	BPF_URDT_PROBE3("dyn", "urdt3alt", y, &bla, x);
+
+	ASSERT_EQ(bss->urdt3alt_called, 1, "urdt3alt_called");
+	ASSERT_EQ(bss->urdt3_called, 1, "urdt3_notcalled");
+
+	ASSERT_EQ(bss->urdt3alt_arg1, 42, "urdt3alt_arg1");
+	ASSERT_EQ((long)bss->urdt3alt_arg2, (long)&bla, "urdt3_arg3");
+	ASSERT_EQ(bss->urdt3alt_arg3, 1, "urdt3alt_arg3");
+
+	BPF_URDT_PROBE11("dyn", "urdt11", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);
+
+	ASSERT_EQ(bss->urdt11_called, 1, "urdt11_called");
+	ASSERT_EQ(bss->urdt3_called, 1, "urdt3_called");
+	for (i = 0; i < 11; i++)
+		ASSERT_EQ(bss->urdt11_args[i], i + 1, "urdt11_arg");
+
+cleanup:
+	test_urdt__destroy(skel);
+}
+
+#define LIBBPF_SO_PATH	"./tools/build/libbpf/libbpf.so"
+
+/* verify shared object attach/firing works for libbpf.so */
+static void subtest_shared_urdt(void)
+{
+	LIBBPF_OPTS(bpf_urdt_opts, opts);
+	struct test_urdt_shared *skel;
+	void *dlh;
+	void (*probe0)(const char *provider, const char *probe);
+	void (*probe4)(const char *provider, const char *probe, long arg1, long arg2,
+		       long arg3, long arg4);
+	struct test_urdt_shared__bss *bss;
+	long x = 1;
+	int y = 42;
+	int z = 3;
+	int err;
+
+	skel = test_urdt_shared__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	err = test_urdt_shared__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* urdt0 won't be auto-attached */
+	opts.urdt_cookie = 0xcafedead;
+	opts.urdt_nargs = 0;
+	skel->links.urdt0 = bpf_program__attach_urdt(skel->progs.urdt0,
+						     -1 /* all */,
+						     LIBBPF_SO_PATH,
+						     "dyn", "urdt0", &opts);
+	if (!ASSERT_OK_PTR(skel->links.urdt0, "urdt0_link"))
+		goto cleanup;
+
+	/* test_progs is statically linked with libbpf, so we need to dlopen/dlsym
+	 * probe firing functions in the shared object we have attached to in order
+	 * to trigger probe firing.  If a program is dynamically linked to libbpf
+	 * for probe firing, this won't be needed, but we want to make sure this
+	 * mode of operation works as it will likely be the common case.
+	 */
+	dlh = dlopen(LIBBPF_SO_PATH, RTLD_NOW);
+	if (!ASSERT_NEQ(dlh, NULL, "dlopen"))
+		goto cleanup;
+	probe0 = dlsym(dlh, "bpf_urdt__probe0");
+	if (!ASSERT_NEQ(probe0, NULL, "dlsym_probe0"))
+		goto cleanup;
+	probe4 = dlsym(dlh, "bpf_urdt__probe4");
+	if (!ASSERT_NEQ(probe4, NULL, "dlsym_probe4"))
+		goto cleanup;
+
+	probe0("dyn", "urdt0");
+
+	ASSERT_EQ(bss->urdt0_called, 1, "urdt0_called");
+
+	ASSERT_EQ(bss->urdt0_cookie, 0xcafedead, "urdt0_cookie");
+	ASSERT_EQ(bss->urdt0_arg_cnt, 0, "urdt0_arg_cnt");
+	ASSERT_EQ(bss->urdt0_arg_ret, -ENOENT, "urdt0_arg_ret");
+
+	probe4("dyn", "urdt4", (long)x, (long)y, (long)z, (long)&bla);
+
+	ASSERT_EQ(bss->urdt4_called, 1, "urdt4_called");
+	/* auto-attached urdt4 gets default zero cookie value */
+	ASSERT_EQ(bss->urdt4_cookie, 0, "urdt4_cookie");
+	ASSERT_EQ(bss->urdt4_arg_cnt, 4, "urdt4_arg_cnt");
+
+	ASSERT_EQ(bss->urdt4_arg1, 1, "urdt4_arg1");
+	ASSERT_EQ(bss->urdt4_arg2, 42, "urdt4_arg2");
+	ASSERT_EQ(bss->urdt4_arg3, 3, "urdt4_arg3");
+	ASSERT_EQ((long)bss->urdt4_arg4, (long)&bla, "urdt4_arg4");
+cleanup:
+	if (dlh)
+		dlclose(dlh);
+	test_urdt_shared__destroy(skel);
+}
+
+void test_urdt(void)
+{
+	if (test__start_subtest("basic"))
+		subtest_basic_urdt();
+	if (test__start_subtest("shared"))
+		subtest_shared_urdt();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_urdt.c b/tools/testing/selftests/bpf/progs/test_urdt.c
new file mode 100644
index 000000000000..82d5fbdc5744
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_urdt.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/urdt.bpf.h>
+
+int my_pid;
+
+int urdt0_called;
+int urdt0_cookie;
+int urdt0_arg_cnt;
+int urdt0_arg_ret;
+
+SEC("urdt")
+int BPF_URDT(urdt0)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urdt0_called, 1);
+
+	urdt0_cookie = bpf_urdt_cookie(ctx);
+	urdt0_arg_cnt = bpf_urdt_arg_cnt(ctx);
+	/* should return -ENOENT for any arg_num */
+	urdt0_arg_ret = bpf_usdt_arg(ctx, bpf_get_prandom_u32(), &tmp);
+	return 0;
+}
+
+int urdt3_called;
+int urdt3_cookie;
+int urdt3_arg_cnt;
+long urdt3_arg1;
+int urdt3_arg2;
+__u64 *urdt3_arg3;
+
+SEC("urdt//proc/self/exe:3:dyn:urdt3")
+int BPF_URDT(urdt3, long x, int y, __u64 *bla)
+{
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urdt3_called, 1);
+
+	__sync_fetch_and_add(&urdt3_cookie, bpf_urdt_cookie(ctx));
+	__sync_fetch_and_add(&urdt3_arg_cnt, bpf_urdt_arg_cnt(ctx));
+
+	__sync_fetch_and_add(&urdt3_arg1, x);
+	__sync_fetch_and_add(&urdt3_arg2, y);
+	__sync_fetch_and_add(&urdt3_arg3, bla);
+
+	return 0;
+}
+
+int urdt3alt_called;
+int urdt3alt_cookie;
+int urdt3alt_arg1;
+__u64 *urdt3alt_arg2;
+long urdt3alt_arg3;
+
+SEC("urdt//proc/self/exe:3:dyn:urdt3alt")
+int BPF_URDT(urdt3alt, int y, __u64 *bla, long x)
+{
+	__sync_fetch_and_add(&urdt3alt_called, 1);
+
+	__sync_fetch_and_add(&urdt3alt_cookie, bpf_urdt_cookie(ctx));
+
+	__sync_fetch_and_add(&urdt3alt_arg1, y);
+	__sync_fetch_and_add(&urdt3alt_arg2, bla);
+	__sync_fetch_and_add(&urdt3alt_arg3, x);
+
+	return 0;
+}
+
+int urdt11_called;
+int urdt11_args[11];
+
+SEC("urdt//proc/self/exe:11:dyn:urdt11")
+int BPF_URDT(urdt11, int arg1, int arg2, int arg3, int arg4, int arg5,
+	     int arg6, int arg7, int arg8, int arg9, int arg10, int arg11)
+{
+	__sync_fetch_and_add(&urdt11_called, 1);
+	__sync_fetch_and_add(&urdt11_args[0], arg1);
+	__sync_fetch_and_add(&urdt11_args[1], arg2);
+	__sync_fetch_and_add(&urdt11_args[2], arg3);
+	__sync_fetch_and_add(&urdt11_args[3], arg4);
+	__sync_fetch_and_add(&urdt11_args[4], arg5);
+	__sync_fetch_and_add(&urdt11_args[5], arg6);
+	__sync_fetch_and_add(&urdt11_args[6], arg7);
+	__sync_fetch_and_add(&urdt11_args[7], arg8);
+	__sync_fetch_and_add(&urdt11_args[8], arg9);
+	__sync_fetch_and_add(&urdt11_args[9], arg10);
+	__sync_fetch_and_add(&urdt11_args[10], arg11);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_urdt_shared.c b/tools/testing/selftests/bpf/progs/test_urdt_shared.c
new file mode 100644
index 000000000000..2cdb181f73bd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_urdt_shared.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/urdt.bpf.h>
+
+int my_pid;
+
+int urdt0_called;
+int urdt0_cookie;
+int urdt0_arg_cnt;
+int urdt0_arg_ret;
+
+SEC("urdt")
+int BPF_URDT(urdt0)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urdt0_called, 1);
+
+	urdt0_cookie = bpf_urdt_cookie(ctx);
+	urdt0_arg_cnt = bpf_urdt_arg_cnt(ctx);
+	/* should return -ENOENT for any arg_num */
+	urdt0_arg_ret = bpf_usdt_arg(ctx, bpf_get_prandom_u32(), &tmp);
+	return 0;
+}
+
+int urdt4_called;
+int urdt4_cookie;
+int urdt4_arg_cnt;
+long urdt4_arg1;
+int urdt4_arg2;
+int urdt4_arg3;
+__u64 *urdt4_arg4;
+
+SEC("urdt/./tools/build/libbpf/libbpf.so:4:dyn:urdt4")
+int BPF_URDT(urdt4, long x, int y, int z, __u64 *bla)
+{
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urdt4_called, 1);
+
+	__sync_fetch_and_add(&urdt4_cookie, bpf_urdt_cookie(ctx));
+	__sync_fetch_and_add(&urdt4_arg_cnt, bpf_urdt_arg_cnt(ctx));
+
+	__sync_fetch_and_add(&urdt4_arg1, x);
+	__sync_fetch_and_add(&urdt4_arg2, y);
+	__sync_fetch_and_add(&urdt4_arg3, z);
+	__sync_fetch_and_add(&urdt4_arg4, bla);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.3


