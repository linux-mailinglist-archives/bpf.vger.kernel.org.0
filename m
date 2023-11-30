Return-Path: <bpf+bounces-16267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF297FF111
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC828B210DA
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8824048795;
	Thu, 30 Nov 2023 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B61B4
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:00:22 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SgyWR0SL9z4f3k6M
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 22:00:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 017291A0DDD
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 22:00:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhBslWhlJ5NxCQ--.49902S11;
	Thu, 30 Nov 2023 22:00:19 +0800 (CST)
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
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf v4 7/7] selftests/bpf: Test outer map update operations in syscall program
Date: Thu, 30 Nov 2023 22:01:20 +0800
Message-Id: <20231130140120.1736235-8-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231130140120.1736235-1-houtao@huaweicloud.com>
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhBslWhlJ5NxCQ--.49902S11
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4kXr1kJFW7KryxtF17Awb_yoW7Kry8pa
	yrGa4UtF4rXF43Gry8Xa17WayfKF1vg343trsrtw1YvFnrXr1SqFyIgay7tF13WrZ3Zr4F
	vay7trZ5Aw4UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Syscall program is running with rcu_read_lock_trace being held, so if
bpf_map_update_elem() or bpf_map_delete_elem() invokes
synchronize_rcu_tasks_trace() when operating on an outer map, there will
be dead-lock, so add a test to guarantee that it is dead-lock free.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/syscall.c        | 30 +++++-
 tools/testing/selftests/bpf/progs/syscall.c   | 91 ++++++++++++++++++-
 2 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/syscall.c b/tools/testing/selftests/bpf/prog_tests/syscall.c
index f4d40001155a..0be8301c0ffd 100644
--- a/tools/testing/selftests/bpf/prog_tests/syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/syscall.c
@@ -12,7 +12,7 @@ struct args {
 	int btf_fd;
 };
 
-void test_syscall(void)
+static void test_syscall_load_prog(void)
 {
 	static char verifier_log[8192];
 	struct args ctx = {
@@ -32,7 +32,7 @@ void test_syscall(void)
 	if (!ASSERT_OK_PTR(skel, "skel_load"))
 		goto cleanup;
 
-	prog_fd = bpf_program__fd(skel->progs.bpf_prog);
+	prog_fd = bpf_program__fd(skel->progs.load_prog);
 	err = bpf_prog_test_run_opts(prog_fd, &tattr);
 	ASSERT_EQ(err, 0, "err");
 	ASSERT_EQ(tattr.retval, 1, "retval");
@@ -53,3 +53,29 @@ void test_syscall(void)
 	if (ctx.btf_fd > 0)
 		close(ctx.btf_fd);
 }
+
+static void test_syscall_update_outer_map(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct syscall *skel;
+	int err, prog_fd;
+
+	skel = syscall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.update_outer_map);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_EQ(err, 0, "err");
+	ASSERT_EQ(opts.retval, 1, "retval");
+cleanup:
+	syscall__destroy(skel);
+}
+
+void test_syscall(void)
+{
+	if (test__start_subtest("load_prog"))
+		test_syscall_load_prog();
+	if (test__start_subtest("update_outer_map"))
+		test_syscall_update_outer_map();
+}
diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index e550f728962d..23058abbaabd 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -6,9 +6,15 @@
 #include <bpf/bpf_tracing.h>
 #include <../../../tools/include/linux/filter.h>
 #include <linux/btf.h>
+#include <string.h>
+#include <errno.h>
 
 char _license[] SEC("license") = "GPL";
 
+struct bpf_map {
+	int id;
+}  __attribute__((preserve_access_index));
+
 struct args {
 	__u64 log_buf;
 	__u32 log_size;
@@ -27,6 +33,32 @@ struct args {
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
 	BTF_INT_ENC(encoding, bits_offset, bits)
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, union bpf_attr);
+	__uint(max_entries, 1);
+} bpf_attr_array SEC(".maps");
+
+struct inner_map_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, 4);
+	__uint(value_size, 4);
+	__uint(max_entries, 1);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+	__array(values, struct inner_map_type);
+} outer_array_map SEC(".maps") = {
+	.values = {
+		[0] = &inner_map,
+	},
+};
+
 static int btf_load(void)
 {
 	struct btf_blob {
@@ -58,7 +90,7 @@ static int btf_load(void)
 }
 
 SEC("syscall")
-int bpf_prog(struct args *ctx)
+int load_prog(struct args *ctx)
 {
 	static char license[] = "GPL";
 	static struct bpf_insn insns[] = {
@@ -94,8 +126,8 @@ int bpf_prog(struct args *ctx)
 	map_create_attr.max_entries = ctx->max_entries;
 	map_create_attr.btf_fd = ret;
 
-	prog_load_attr.license = (long) license;
-	prog_load_attr.insns = (long) insns;
+	prog_load_attr.license = (unsigned long)license;
+	prog_load_attr.insns = (unsigned long)insns;
 	prog_load_attr.log_buf = ctx->log_buf;
 	prog_load_attr.log_size = ctx->log_size;
 	prog_load_attr.log_level = 1;
@@ -107,8 +139,8 @@ int bpf_prog(struct args *ctx)
 	insns[3].imm = ret;
 
 	map_update_attr.map_fd = ret;
-	map_update_attr.key = (long) &key;
-	map_update_attr.value = (long) &value;
+	map_update_attr.key = (unsigned long)&key;
+	map_update_attr.value = (unsigned long)&value;
 	ret = bpf_sys_bpf(BPF_MAP_UPDATE_ELEM, &map_update_attr, sizeof(map_update_attr));
 	if (ret < 0)
 		return ret;
@@ -119,3 +151,52 @@ int bpf_prog(struct args *ctx)
 	ctx->prog_fd = ret;
 	return 1;
 }
+
+SEC("syscall")
+int update_outer_map(void *ctx)
+{
+	int zero = 0, ret = 0, outer_fd = -1, inner_fd = -1, err;
+	const int attr_sz = sizeof(union bpf_attr);
+	union bpf_attr *attr;
+
+	attr = bpf_map_lookup_elem((struct bpf_map *)&bpf_attr_array, &zero);
+	if (!attr)
+		goto out;
+
+	memset(attr, 0, attr_sz);
+	attr->map_id = ((struct bpf_map *)&outer_array_map)->id;
+	outer_fd = bpf_sys_bpf(BPF_MAP_GET_FD_BY_ID, attr, attr_sz);
+	if (outer_fd < 0)
+		goto out;
+
+	memset(attr, 0, attr_sz);
+	attr->map_type = BPF_MAP_TYPE_ARRAY;
+	attr->key_size = 4;
+	attr->value_size = 4;
+	attr->max_entries = 1;
+	inner_fd = bpf_sys_bpf(BPF_MAP_CREATE, attr, attr_sz);
+	if (inner_fd < 0)
+		goto out;
+
+	memset(attr, 0, attr_sz);
+	attr->map_fd = outer_fd;
+	attr->key = (unsigned long)&zero;
+	attr->value = (unsigned long)&inner_fd;
+	err = bpf_sys_bpf(BPF_MAP_UPDATE_ELEM, attr, attr_sz);
+	if (err)
+		goto out;
+
+	memset(attr, 0, attr_sz);
+	attr->map_fd = outer_fd;
+	attr->key = (unsigned long)&zero;
+	err = bpf_sys_bpf(BPF_MAP_DELETE_ELEM, attr, attr_sz);
+	if (err)
+		goto out;
+	ret = 1;
+out:
+	if (inner_fd >= 0)
+		bpf_sys_close(inner_fd);
+	if (outer_fd >= 0)
+		bpf_sys_close(outer_fd);
+	return ret;
+}
-- 
2.29.2


