Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6356DFC48
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDLRHZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 13:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjDLRHT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 13:07:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA6903A
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 10:07:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGEqOa008983
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 10:07:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pwr0duc6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 10:07:10 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 10:07:09 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 10:07:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0C3D32DDA75FB; Wed, 12 Apr 2023 10:06:55 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: remove stand-along test_verifier_log test binary
Date:   Wed, 12 Apr 2023 10:06:55 -0700
Message-ID: <20230412170655.1866831-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1RAFZakeG3gXrsdWCsV8BhCb0rO_V0iJ
X-Proofpoint-GUID: 1RAFZakeG3gXrsdWCsV8BhCb0rO_V0iJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_prog's prog_tests/verifier_log.c is superseding test_verifier_log
stand-alone test. It cover same checks and adds more, and is also
integrated into test_progs test runner.

Just remove test_verifier_log.c.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../testing/selftests/bpf/test_verifier_log.c | 175 ------------------
 2 files changed, 1 insertion(+), 176 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/test_verifier_log.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b5ffdd89b86f..c49e5403ad0e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -36,7 +36,7 @@ endif
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_verifier_log test_dev_cgroup \
+	test_dev_cgroup \
 	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
diff --git a/tools/testing/selftests/bpf/test_verifier_log.c b/tools/testing/selftests/bpf/test_verifier_log.c
deleted file mode 100644
index 70feda97cee5..000000000000
--- a/tools/testing/selftests/bpf/test_verifier_log.c
+++ /dev/null
@@ -1,175 +0,0 @@
-#include <errno.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/time.h>
-
-#include <linux/bpf.h>
-#include <linux/filter.h>
-#include <linux/unistd.h>
-
-#include <bpf/bpf.h>
-
-#define LOG_SIZE (1 << 20)
-
-#define err(str...)	printf("ERROR: " str)
-
-static const struct bpf_insn code_sample[] = {
-	/* We need a few instructions to pass the min log length */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-		     BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-};
-
-static inline __u64 ptr_to_u64(const void *ptr)
-{
-	return (__u64) (unsigned long) ptr;
-}
-
-static int load(char *log, size_t log_len, int log_level)
-{
-	union bpf_attr attr;
-
-	bzero(&attr, sizeof(attr));
-	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	attr.insn_cnt = (__u32)(sizeof(code_sample) / sizeof(struct bpf_insn));
-	attr.insns = ptr_to_u64(code_sample);
-	attr.license = ptr_to_u64("GPL");
-	attr.log_buf = ptr_to_u64(log);
-	attr.log_size = log_len;
-	attr.log_level = log_level;
-
-	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
-}
-
-static void check_ret(int ret, int exp_errno)
-{
-	if (ret > 0) {
-		close(ret);
-		err("broken sample loaded successfully!?\n");
-		exit(1);
-	}
-
-	if (!ret || errno != exp_errno) {
-		err("Program load returned: ret:%d/errno:%d, expected ret:%d/errno:%d\n",
-		    ret, errno, -1, exp_errno);
-		exit(1);
-	}
-}
-
-static void check_ones(const char *buf, size_t len, const char *msg)
-{
-	while (len--)
-		if (buf[len] != 1) {
-			err("%s", msg);
-			exit(1);
-		}
-}
-
-static void test_log_good(char *log, size_t buf_len, size_t log_len,
-			  size_t exp_len, int exp_errno, const char *full_log)
-{
-	size_t len;
-	int ret;
-
-	memset(log, 1, buf_len);
-
-	ret = load(log, log_len, 1);
-	check_ret(ret, exp_errno);
-
-	len = strnlen(log, buf_len);
-	if (len == buf_len) {
-		err("verifier did not NULL terminate the log\n");
-		exit(1);
-	}
-	if (exp_len && len != exp_len) {
-		err("incorrect log length expected:%zd have:%zd\n",
-		    exp_len, len);
-		exit(1);
-	}
-
-	if (strchr(log, 1)) {
-		err("verifier leaked a byte through\n");
-		exit(1);
-	}
-
-	check_ones(log + len + 1, buf_len - len - 1,
-		   "verifier wrote bytes past NULL termination\n");
-
-	if (memcmp(full_log, log, LOG_SIZE)) {
-		err("log did not match expected output\n");
-		exit(1);
-	}
-}
-
-static void test_log_bad(char *log, size_t log_len, int log_level)
-{
-	int ret;
-
-	ret = load(log, log_len, log_level);
-	check_ret(ret, EINVAL);
-	if (log)
-		check_ones(log, LOG_SIZE,
-			   "verifier touched log with bad parameters\n");
-}
-
-int main(int argc, char **argv)
-{
-	char full_log[LOG_SIZE];
-	char log[LOG_SIZE];
-	size_t want_len;
-	int i;
-
-	memset(log, 1, LOG_SIZE);
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	/* Test incorrect attr */
-	printf("Test log_level 0...\n");
-	test_log_bad(log, LOG_SIZE, 0);
-
-	printf("Test log_size < 128...\n");
-	test_log_bad(log, 15, 1);
-
-	printf("Test log_buff = NULL...\n");
-	test_log_bad(NULL, LOG_SIZE, 1);
-
-	/* Test with log big enough */
-	printf("Test oversized buffer...\n");
-	test_log_good(full_log, LOG_SIZE, LOG_SIZE, 0, EACCES, full_log);
-
-	want_len = strlen(full_log);
-
-	printf("Test exact buffer...\n");
-	test_log_good(log, LOG_SIZE, want_len + 2, want_len, EACCES, full_log);
-
-	printf("Test undersized buffers...\n");
-	for (i = 0; i < 64; i++) {
-		full_log[want_len - i + 1] = 1;
-		full_log[want_len - i] = 0;
-
-		test_log_good(log, LOG_SIZE, want_len + 1 - i, want_len - i,
-			      ENOSPC, full_log);
-	}
-
-	printf("test_verifier_log: OK\n");
-	return 0;
-}
-- 
2.34.1

