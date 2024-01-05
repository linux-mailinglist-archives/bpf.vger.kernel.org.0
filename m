Return-Path: <bpf+bounces-19121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F87825256
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 11:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141EA1C23010
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A78D286B5;
	Fri,  5 Jan 2024 10:47:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4A250E1
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T60X36j0nz4f3lVt
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 18:47:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A81821A0BB4
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 18:47:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAXZw013pdlA+1eFg--.49979S6;
	Fri, 05 Jan 2024 18:47:21 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Factor out get_xlated_program() helper
Date: Fri,  5 Jan 2024 18:48:18 +0800
Message-Id: <20240105104819.3916743-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240105104819.3916743-1-houtao@huaweicloud.com>
References: <20240105104819.3916743-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXZw013pdlA+1eFg--.49979S6
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW3Jry5JF17JrW8ArW8Zwb_yoWxZF48pF
	WfGryIkry0vFW3Kr1Yyr4kZr45tF1DW3yUGrWftry5Zr1DJr97W3W8KrWF9rn3urWrZrn3
	Zwn2gF909r1rXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Both test_verifier and test_progs use get_xlated_program(), so moving
the helper into testing_helpers.h to reuse it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 44 -----------------
 tools/testing/selftests/bpf/test_verifier.c   | 47 +------------------
 tools/testing/selftests/bpf/testing_helpers.c | 42 +++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  6 +++
 4 files changed, 50 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 4951aa978f332..3b7c57fe55a59 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -626,50 +626,6 @@ static bool match_pattern(struct btf *btf, char *pattern, char *text, char *reg_
 	return false;
 }
 
-/* Request BPF program instructions after all rewrites are applied,
- * e.g. verifier.c:convert_ctx_access() is done.
- */
-static int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
-{
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	__u32 xlated_prog_len;
-	__u32 buf_element_size = sizeof(struct bpf_insn);
-
-	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("bpf_prog_get_info_by_fd failed");
-		return -1;
-	}
-
-	xlated_prog_len = info.xlated_prog_len;
-	if (xlated_prog_len % buf_element_size) {
-		printf("Program length %d is not multiple of %d\n",
-		       xlated_prog_len, buf_element_size);
-		return -1;
-	}
-
-	*cnt = xlated_prog_len / buf_element_size;
-	*buf = calloc(*cnt, buf_element_size);
-	if (!buf) {
-		perror("can't allocate xlated program buffer");
-		return -ENOMEM;
-	}
-
-	bzero(&info, sizeof(info));
-	info.xlated_prog_len = xlated_prog_len;
-	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
-	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("second bpf_prog_get_info_by_fd failed");
-		goto out_free_buf;
-	}
-
-	return 0;
-
-out_free_buf:
-	free(*buf);
-	return -1;
-}
-
 static void print_insn(void *private_data, const char *fmt, ...)
 {
 	va_list args;
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index f36e41435be79..87519d7fe4c62 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1341,48 +1341,6 @@ static bool cmp_str_seq(const char *log, const char *exp)
 	return true;
 }
 
-static struct bpf_insn *get_xlated_program(int fd_prog, int *cnt)
-{
-	__u32 buf_element_size = sizeof(struct bpf_insn);
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	__u32 xlated_prog_len;
-	struct bpf_insn *buf;
-
-	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("bpf_prog_get_info_by_fd failed");
-		return NULL;
-	}
-
-	xlated_prog_len = info.xlated_prog_len;
-	if (xlated_prog_len % buf_element_size) {
-		printf("Program length %d is not multiple of %d\n",
-		       xlated_prog_len, buf_element_size);
-		return NULL;
-	}
-
-	*cnt = xlated_prog_len / buf_element_size;
-	buf = calloc(*cnt, buf_element_size);
-	if (!buf) {
-		perror("can't allocate xlated program buffer");
-		return NULL;
-	}
-
-	bzero(&info, sizeof(info));
-	info.xlated_prog_len = xlated_prog_len;
-	info.xlated_prog_insns = (__u64)(unsigned long)buf;
-	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("second bpf_prog_get_info_by_fd failed");
-		goto out_free_buf;
-	}
-
-	return buf;
-
-out_free_buf:
-	free(buf);
-	return NULL;
-}
-
 static bool is_null_insn(struct bpf_insn *insn)
 {
 	struct bpf_insn null_insn = {};
@@ -1505,7 +1463,7 @@ static void print_insn(struct bpf_insn *buf, int cnt)
 static bool check_xlated_program(struct bpf_test *test, int fd_prog)
 {
 	struct bpf_insn *buf;
-	int cnt;
+	unsigned int cnt;
 	bool result = true;
 	bool check_expected = !is_null_insn(test->expected_insns);
 	bool check_unexpected = !is_null_insn(test->unexpected_insns);
@@ -1513,8 +1471,7 @@ static bool check_xlated_program(struct bpf_test *test, int fd_prog)
 	if (!check_expected && !check_unexpected)
 		goto out;
 
-	buf = get_xlated_program(fd_prog, &cnt);
-	if (!buf) {
+	if (get_xlated_program(fd_prog, &buf, &cnt)) {
 		printf("FAIL: can't get xlated program\n");
 		result = false;
 		goto out;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d2458c1b16719..53c40f62fdcb8 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -387,3 +387,45 @@ int kern_sync_rcu(void)
 {
 	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
 }
+
+int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
+{
+	__u32 buf_element_size = sizeof(struct bpf_insn);
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 xlated_prog_len;
+
+	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("bpf_prog_get_info_by_fd failed");
+		return -1;
+	}
+
+	xlated_prog_len = info.xlated_prog_len;
+	if (xlated_prog_len % buf_element_size) {
+		printf("Program length %u is not multiple of %u\n",
+		       xlated_prog_len, buf_element_size);
+		return -1;
+	}
+
+	*cnt = xlated_prog_len / buf_element_size;
+	*buf = calloc(*cnt, buf_element_size);
+	if (!buf) {
+		perror("can't allocate xlated program buffer");
+		return -ENOMEM;
+	}
+
+	bzero(&info, sizeof(info));
+	info.xlated_prog_len = xlated_prog_len;
+	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
+	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("second bpf_prog_get_info_by_fd failed");
+		goto out_free_buf;
+	}
+
+	return 0;
+
+out_free_buf:
+	free(*buf);
+	*buf = NULL;
+	return -1;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 35284faff4f29..1ed5b9200d661 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -46,4 +46,10 @@ static inline __u64 get_time_ns(void)
 	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
 }
 
+struct bpf_insn;
+/* Request BPF program instructions after all rewrites are applied,
+ * e.g. verifier.c:convert_ctx_access() is done.
+ */
+int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.29.2


