Return-Path: <bpf+bounces-14934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625857E8FCD
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8602F1C2040C
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A67479EB;
	Sun, 12 Nov 2023 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="goFMqafW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225D525A
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:50:00 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3C2D64
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCiiJl006420;
	Sun, 12 Nov 2023 12:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=j/xT3Hk030zCDc/bbVIEG56D3U6crXbdraI3B6XtZKk=;
 b=goFMqafWrzyoqKMTBEgQ+zWDfi7U9iBjUiO2UWsoJjXMVE1F84x6SgmO6DnzmEWavJkz
 KnuYSDmus/nq78H6LyGhICnkRXsAzHr2nvEhBoE2eBbxSdkis8W8+a2poCwJklcoEr0I
 Poui9g48scO1cALj/rwpZULCyq9G2yhjEoyCzD0thw9QCi394AroPNcs3JURz+BK8vUk
 GlVhnBta+eDQ2hCZAkwdvV5N2ut7FjmFg66nDNHqVBl1A/Cq3C0aEmDkBsYCmF7PGNhX
 QydlxuqRDK4UjojTcI6K5C6C2ssstXnk4gF6lFv+LZaWD3MtJq474Nu/rBlyOV3NMvbD xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n39e2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCFCuH009374;
	Sun, 12 Nov 2023 12:49:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceW029718;
	Sun, 12 Nov 2023 12:49:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-16;
	Sun, 12 Nov 2023 12:49:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 15/17] selftests/bpf: generalize module load to support specifying a module name
Date: Sun, 12 Nov 2023 12:48:32 +0000
Message-Id: <20231112124834.388735-16-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-GUID: 4Ht93aZbbui6vi2lS5JlGpD2xuWUO6kb
X-Proofpoint-ORIG-GUID: 4Ht93aZbbui6vi2lS5JlGpD2xuWUO6kb

This will be used in testing standalone module BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/bpf_mod_race.c   |  8 +++----
 .../selftests/bpf/prog_tests/module_attach.c  |  6 ++---
 tools/testing/selftests/bpf/test_progs.c      |  6 ++---
 tools/testing/selftests/bpf/test_verifier.c   |  6 ++---
 tools/testing/selftests/bpf/testing_helpers.c | 24 ++++++++++---------
 tools/testing/selftests/bpf/testing_helpers.h |  4 ++--
 6 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
index fe2c502e5089..c4aeb40390a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
@@ -48,7 +48,7 @@ static _Atomic enum bpf_test_state state = _TS_INVALID;
 static void *load_module_thread(void *p)
 {
 
-	if (!ASSERT_NEQ(load_bpf_testmod(false), 0, "load_module_thread must fail"))
+	if (!ASSERT_NEQ(load_bpf_testmod("bpf_testmod", false), 0, "load_module_thread must fail"))
 		atomic_store(&state, TS_MODULE_LOAD);
 	else
 		atomic_store(&state, TS_MODULE_LOAD_FAIL);
@@ -100,7 +100,7 @@ static void test_bpf_mod_race_config(const struct test_config *config)
 	if (!ASSERT_NEQ(fault_addr, MAP_FAILED, "mmap for uffd registration"))
 		return;
 
-	if (!ASSERT_OK(unload_bpf_testmod(false), "unload bpf_testmod"))
+	if (!ASSERT_OK(unload_bpf_testmod("bpf_testmod", false), "unload bpf_testmod"))
 		goto end_mmap;
 
 	skel = bpf_mod_race__open();
@@ -178,8 +178,8 @@ static void test_bpf_mod_race_config(const struct test_config *config)
 	bpf_mod_race__destroy(skel);
 	ASSERT_OK(kern_sync_rcu(), "kern_sync_rcu");
 end_module:
-	unload_bpf_testmod(false);
-	ASSERT_OK(load_bpf_testmod(false), "restore bpf_testmod");
+	unload_bpf_testmod("bpf_testmod", false);
+	ASSERT_OK(load_bpf_testmod("bpf_testmod", false), "restore bpf_testmod");
 end_mmap:
 	munmap(fault_addr, 4096);
 	atomic_store(&state, _TS_INVALID);
diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index f53d658ed080..9f1f00c63d30 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -89,21 +89,21 @@ void test_module_attach(void)
 	if (!ASSERT_OK_PTR(link, "attach_fentry"))
 		goto cleanup;
 
-	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
+	ASSERT_ERR(unload_bpf_testmod("bpf_testmod", false), "unload_bpf_testmod");
 	bpf_link__destroy(link);
 
 	link = bpf_program__attach(skel->progs.handle_fexit);
 	if (!ASSERT_OK_PTR(link, "attach_fexit"))
 		goto cleanup;
 
-	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
+	ASSERT_ERR(unload_bpf_testmod("bpf_testmod", false), "unload_bpf_testmod");
 	bpf_link__destroy(link);
 
 	link = bpf_program__attach(skel->progs.kprobe_multi);
 	if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
 		goto cleanup;
 
-	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
+	ASSERT_ERR(unload_bpf_testmod("bpf_testmod", false), "unload_bpf_testmod");
 	bpf_link__destroy(link);
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 1b9387890148..a3a89743e7aa 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1659,9 +1659,9 @@ int main(int argc, char **argv)
 	env.has_testmod = true;
 	if (!env.list_test_names) {
 		/* ensure previous instance of the module is unloaded */
-		unload_bpf_testmod(verbose());
+		unload_bpf_testmod("bpf_testmod", verbose());
 
-		if (load_bpf_testmod(verbose())) {
+		if (load_bpf_testmod("bpf_testmod", verbose())) {
 			fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
 			env.has_testmod = false;
 		}
@@ -1761,7 +1761,7 @@ int main(int argc, char **argv)
 	close(env.saved_netns_fd);
 out:
 	if (!env.list_test_names && env.has_testmod)
-		unload_bpf_testmod(verbose());
+		unload_bpf_testmod("bpf_testmod", verbose());
 
 	free_test_selector(&env.test_selector);
 	free_test_selector(&env.subtest_selector);
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 98107e0452d3..b712424d6a10 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1804,9 +1804,9 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 	int i, passes = 0, errors = 0;
 
 	/* ensure previous instance of the module is unloaded */
-	unload_bpf_testmod(verbose);
+	unload_bpf_testmod("bpf_testmod", verbose);
 
-	if (load_bpf_testmod(verbose))
+	if (load_bpf_testmod("bpf_testmod", verbose))
 		return EXIT_FAILURE;
 
 	for (i = from; i < to; i++) {
@@ -1836,7 +1836,7 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
 		}
 	}
 
-	unload_bpf_testmod(verbose);
+	unload_bpf_testmod("bpf_testmod", verbose);
 	kfuncs_cleanup();
 
 	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 8d994884c7b4..d5cde3f298f1 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -338,45 +338,47 @@ static int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
-int unload_bpf_testmod(bool verbose)
+int unload_bpf_testmod(const char *name, bool verbose)
 {
 	if (kern_sync_rcu())
 		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
-	if (delete_module("bpf_testmod", 0)) {
+	if (delete_module(name, 0)) {
 		if (errno == ENOENT) {
 			if (verbose)
-				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
+				fprintf(stdout, "%s.ko is already unloaded.\n", name);
 			return -1;
 		}
-		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to unload %s.ko from kernel: %d\n", name, -errno);
 		return -1;
 	}
 	if (verbose)
-		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully unloaded %s.ko.\n", name);
 	return 0;
 }
 
-int load_bpf_testmod(bool verbose)
+int load_bpf_testmod(const char *name, bool verbose)
 {
+	char koname[PATH_MAX];
 	int fd;
 
 	if (verbose)
-		fprintf(stdout, "Loading bpf_testmod.ko...\n");
+		fprintf(stdout, "Loading %s.ko...\n", name);
 
-	fd = open("bpf_testmod.ko", O_RDONLY);
+	snprintf(koname, sizeof(koname), "%s.ko", name);
+	fd = open(koname, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
+		fprintf(stdout, "Can't find %s.ko kernel module: %d\n", name, -errno);
 		return -ENOENT;
 	}
 	if (finit_module(fd, "", 0)) {
-		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to load %s.ko into the kernel: %d\n", name, -errno);
 		close(fd);
 		return -EINVAL;
 	}
 	close(fd);
 
 	if (verbose)
-		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully loaded %s.ko.\n", name);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 5b7a55136741..831329ad5091 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -30,8 +30,8 @@ int parse_test_list_file(const char *path,
 			 bool is_glob_pattern);
 
 __u64 read_perf_max_sample_freq(void);
-int load_bpf_testmod(bool verbose);
-int unload_bpf_testmod(bool verbose);
+int load_bpf_testmod(const char *name, bool verbose);
+int unload_bpf_testmod(const char *name, bool verbose);
 int kern_sync_rcu(void);
 
 static inline __u64 get_time_ns(void)
-- 
2.31.1


