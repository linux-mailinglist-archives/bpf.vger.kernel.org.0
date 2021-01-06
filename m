Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A252EBA1C
	for <lists+bpf@lfdr.de>; Wed,  6 Jan 2021 07:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbhAFGlj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 6 Jan 2021 01:41:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbhAFGlj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Jan 2021 01:41:39 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1066PUA6006497
        for <bpf@vger.kernel.org>; Tue, 5 Jan 2021 22:40:57 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 35w24kh7rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Jan 2021 22:40:57 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 22:40:56 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id E3ACE2ECCF1C; Tue,  5 Jan 2021 22:40:51 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next  1/4] selftests/bpf: sync RCU before unloading bpf_testmod
Date:   Tue, 5 Jan 2021 22:40:44 -0800
Message-ID: <20210106064048.2554276-2-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210106064048.2554276-1-andrii@kernel.org>
References: <20210106064048.2554276-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_04:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If some of the subtests use module BTFs through ksyms, they will cause
bpf_prog to take a refcount on bpf_testmod module, which will prevent it from
successfully unloading. Module's refcnt is decremented when bpf_prog is freed,
which generally happens in RCU callback. So we need to trigger
syncronize_rcu() in the kernel, which can be achieved nicely with
membarrier(MEMBARRIER_CMD_GLOBAL) syscall. So do that in kernel_sync_rcu() and
make it available to other test inside the test_progs. This synchronize_rcu()
is called before attempting to unload bpf_testmod.

Fixes: 9f7fa225894c ("selftests/bpf: Add bpf_testmod kernel module for testing")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/btf_map_in_map.c | 33 -------------------
 tools/testing/selftests/bpf/test_progs.c      | 11 +++++++
 tools/testing/selftests/bpf/test_progs.h      |  1 +
 3 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
index 76ebe4c250f1..eb90a6b8850d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -20,39 +20,6 @@ static __u32 bpf_map_id(struct bpf_map *map)
 	return info.id;
 }
 
-/*
- * Trigger synchronize_rcu() in kernel.
- *
- * ARRAY_OF_MAPS/HASH_OF_MAPS lookup/update operations trigger synchronize_rcu()
- * if looking up an existing non-NULL element or updating the map with a valid
- * inner map FD. Use this fact to trigger synchronize_rcu(): create map-in-map,
- * create a trivial ARRAY map, update map-in-map with ARRAY inner map. Then
- * cleanup. At the end, at least one synchronize_rcu() would be called.
- */
-static int kern_sync_rcu(void)
-{
-	int inner_map_fd, outer_map_fd, err, zero = 0;
-
-	inner_map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 4, 1, 0);
-	if (CHECK(inner_map_fd < 0, "inner_map_create", "failed %d\n", -errno))
-		return -1;
-
-	outer_map_fd = bpf_create_map_in_map(BPF_MAP_TYPE_ARRAY_OF_MAPS, NULL,
-					     sizeof(int), inner_map_fd, 1, 0);
-	if (CHECK(outer_map_fd < 0, "outer_map_create", "failed %d\n", -errno)) {
-		close(inner_map_fd);
-		return -1;
-	}
-
-	err = bpf_map_update_elem(outer_map_fd, &zero, &inner_map_fd, 0);
-	if (err)
-		err = -errno;
-	CHECK(err, "outer_map_update", "failed %d\n", err);
-	close(inner_map_fd);
-	close(outer_map_fd);
-	return err;
-}
-
 static void test_lookup_update(void)
 {
 	int map1_fd, map2_fd, map3_fd, map4_fd, map5_fd, map1_id, map2_id;
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 7d077d48cadd..e3fbca25696c 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -11,6 +11,7 @@
 #include <signal.h>
 #include <string.h>
 #include <execinfo.h> /* backtrace */
+#include <linux/membarrier.h>
 
 #define EXIT_NO_TEST		2
 #define EXIT_ERR_SETUP_INFRA	3
@@ -370,8 +371,18 @@ static int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
+/*
+ * Trigger synchronize_rcu() in kernel.
+ */
+int kern_sync_rcu(void)
+{
+	return syscall(__NR_membarrier, MEMBARRIER_CMD_GLOBAL, 0, 0);
+}
+
 static void unload_bpf_testmod(void)
 {
+	if (kern_sync_rcu())
+		fprintf(env.stderr, "Failed to trigger kernel-side RCU sync!\n");
 	if (delete_module("bpf_testmod", 0)) {
 		if (errno == ENOENT) {
 			if (env.verbosity > VERBOSE_NONE)
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 115953243f62..e49e2fdde942 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -219,6 +219,7 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
 int extract_build_id(char *build_id, size_t size);
+int kern_sync_rcu(void);
 
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
-- 
2.24.1

