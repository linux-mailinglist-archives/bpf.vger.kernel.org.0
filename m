Return-Path: <bpf+bounces-14767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897747E7BAB
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 12:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEBB1C20D95
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A43914A8C;
	Fri, 10 Nov 2023 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="td1ZSRFZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EF1D308
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:05:01 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F092B78B
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 03:05:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MY1RX022422;
	Fri, 10 Nov 2023 11:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=E3t/CzbBH2+mV+aLCIR2r1KVJtdifa2cgOteN2OEKLU=;
 b=td1ZSRFZKYrc98Jcy0xklgYFjjfixm34BiaBmwqfZbyk6HWwhkfpgRGoprgkpa7I1DL5
 Ci1hZl4GtqG5SZ0yBuoR6S51zmjIruNHCLjoi4pBNEtl34N3O6DxtwNMVWew4gGf/oB9
 BPmPdjTWG0YpcpHVdFkB8mmYsTn8keNleizcpnFzTek7zKXynopmlb7qs2HlGfGs+61b
 XcUMyUv+2KiilH0YD6y79anZx9ouQNquqwNw+nYMaTIbgSAXB/nBWQY01K285PfDMgG5
 rshsW22hKle7pkY/mkaYH6XKMXiJNDfWxiOgpDPDXdvrCtVQm021PmiSeUYLjSswuS/b 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2164rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:04:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAA8JiD017516;
	Fri, 10 Nov 2023 11:04:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c01qhfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 11:04:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAB3WgE018454;
	Fri, 10 Nov 2023 11:04:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-193.vpn.oracle.com [10.175.213.193])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u8c01qfd7-18;
	Fri, 10 Nov 2023 11:04:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: jolsa@kernel.org, quentin@isovalent.com, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 17/17] selftests/bpf: update btf_module test to ensure standalone BTF works
Date: Fri, 10 Nov 2023 11:03:04 +0000
Message-Id: <20231110110304.63910-18-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231110110304.63910-1-alan.maguire@oracle.com>
References: <20231110110304.63910-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100090
X-Proofpoint-GUID: y65U0eKKH-z-TZJGHeoTy4Wni0N5aH4F
X-Proofpoint-ORIG-GUID: y65U0eKKH-z-TZJGHeoTy4Wni0N5aH4F

btf_module test verifies that loading split BTF from bpf_testmod.ko
is successful.  To test standalone BTF, add a test that loads
BTF from bpf_testmod_standalone.ko and verifies we can look up BTF,
just as we could for real split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/Makefile          |  8 ++++----
 .../selftests/bpf/prog_tests/btf_module.c     | 19 +++++++++++++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9c27b67bc7b1..5a4421238d5b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -106,7 +106,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features
+	xdp_features btf_testmod_standalone.ko
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -225,9 +225,9 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
-	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
+	$(Q)$(RM) bpf_testmod/bpf_testmod*.ko # force re-compilation
 	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_testmod
-	$(Q)cp bpf_testmod/bpf_testmod.ko $@
+	$(Q)cp bpf_testmod/bpf_testmod*.ko $(OUTPUT)
 
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 ifneq ($(CROSS_COMPILE),)
@@ -728,7 +728,7 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h	\
-			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
+			       no_alu32 cpuv4 bpf_gcc bpf_testmod*.ko	\
 			       liburandom_read.so)
 
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module.c b/tools/testing/selftests/bpf/prog_tests/btf_module.c
index 2239d1fe0332..5470342a1d08 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module.c
@@ -5,11 +5,13 @@
 #include <bpf/btf.h>
 
 static const char *module_name = "bpf_testmod";
+static const char *standalone_module_name = "bpf_testmod_standalone";
 static const char *symbol_name = "bpf_testmod_test_read";
+static const char *standalone_symbol_name = "bpf_testmod_standalone_test_read";
 
 void test_btf_module()
 {
-	struct btf *vmlinux_btf, *module_btf;
+	struct btf *vmlinux_btf, *module_btf, *standalone_module_btf = NULL;
 	__s32 type_id;
 
 	if (!env.has_testmod) {
@@ -26,9 +28,22 @@ void test_btf_module()
 		goto cleanup;
 
 	type_id = btf__find_by_name(module_btf, symbol_name);
-	ASSERT_GT(type_id, 0, "func not found");
+	if (!ASSERT_GT(type_id, 0, "func not found"))
+		goto cleanup;
+
+	if (!ASSERT_OK(load_bpf_testmod(standalone_module_name, false), "load standalone BTF module"))
+		goto cleanup;
+
+	standalone_module_btf = btf__load_module_btf(standalone_module_name, vmlinux_btf);
+	if (!ASSERT_OK_PTR(standalone_module_btf, "could not load standalone module BTF"))
+		goto cleanup;
+
+	type_id = btf__find_by_name(standalone_module_btf, standalone_symbol_name);
+	ASSERT_GT(type_id, 0, "func not found in standalone");
 
 cleanup:
+	btf__free(standalone_module_btf);
 	btf__free(module_btf);
 	btf__free(vmlinux_btf);
+	unload_bpf_testmod(standalone_module_name, false);
 }
-- 
2.31.1


