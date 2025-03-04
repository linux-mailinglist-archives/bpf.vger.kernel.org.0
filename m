Return-Path: <bpf+bounces-53236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0548A4EE71
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD662175280
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2B259C83;
	Tue,  4 Mar 2025 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cA1kN4Fx"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7B2777F4;
	Tue,  4 Mar 2025 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120316; cv=none; b=aHy35+zr7y8tWjdSkE/COgcChOVHwE2nElgrjSXtp12LAiXHB76G7cCUrvcs3sqPUZILt4ji9qNIqF2ifM0Qx+a7iagTJ4cBvnKc/jEr4KUwlM2AEcYy5JlkSHGiALSclwLG6NulFNZaIOZhrtT0A5lbk6fMGN6GxUW7de3Ou9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120316; c=relaxed/simple;
	bh=DbBCeYxwhU12Z1AD0LUBN11wkEtClumhwC6GKULbuYA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mT75fs1iT0GHn1wIzr4xcqK/s25Mi8YI+UGqMv0QpRpytC7TJ+RrJPZAJwuEBV2SJIAia3oYYfBzOS0tRLfAiUybzXHpI6YxgoXH7aaxxiTwOAs3VuZPrXzuTn5SncVJB8tIjDSWVs9QOwEdPLmLTjM6FQrW/L9EOal9Zoryesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cA1kN4Fx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 96F6F210EAF6;
	Tue,  4 Mar 2025 12:31:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96F6F210EAF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741120314;
	bh=1vDCsCYtHONRoZYBzDfIeYb+QcQ4PVYzhGi1zBWDUQQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cA1kN4FxmKMgAWVVp692gzTIzK4nbbhDFOlYkrmAG/vCQDaI2yWnOJEUuqxcdYf2Q
	 Kr4hLTofZvJJ1owLMbKJYAIiPpiOPbEaNabzjyEFpuPxWwXIHRaY0xGmchO3d39fgW
	 YnukwzKEcT+A+KDwOplM2XT/xN7jk14SujVF1p8Q=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	bboscaccy@linux.microsoft.com
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to LSM/bpf test programs
Date: Tue,  4 Mar 2025 12:30:50 -0800
Message-ID: <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The security_bpf LSM hook now contains a boolean parameter specifying
whether an invocation of the bpf syscall originated from within the
kernel. Here, we update the function signature of relevant test
programs to include that new parameter.

Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
---
 tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
 tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++---
 tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
 tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
 tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index ab3a532b7dd6d..f85d0e282f2ae 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -242,7 +242,8 @@ int inproper_sleepable_helper(void *ctx)
 }
 
 SEC("?lsm.s/bpf")
-int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, unsigned int size,
+	     bool is_kernel)
 {
 	struct bpf_key *bkey;
 
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
index 44628865fe1d4..0e741262138f2 100644
--- a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
+++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
@@ -51,13 +51,13 @@ static int bpf_link_create_verify(int cmd)
 }
 
 SEC("lsm/bpf")
-int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	return bpf_link_create_verify(cmd);
 }
 
 SEC("lsm.s/bpf")
-int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	return bpf_link_create_verify(cmd);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index cd4d752bd089c..ce36a55ba5b8b 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -36,7 +36,7 @@ char _license[] SEC("license") = "GPL";
 
 SEC("?lsm.s/bpf")
 __failure __msg("cannot pass in dynptr at an offset=-8")
-int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	unsigned long val;
 
@@ -46,7 +46,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
 
 SEC("?lsm.s/bpf")
 __failure __msg("arg#0 expected pointer to stack or const struct bpf_dynptr")
-int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	unsigned long val = 0;
 
@@ -55,7 +55,7 @@ int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
 }
 
 SEC("lsm.s/bpf")
-int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	struct bpf_key *trusted_keyring;
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/test_lookup_key.c b/tools/testing/selftests/bpf/progs/test_lookup_key.c
index c73776990ae30..c46077e01a4ca 100644
--- a/tools/testing/selftests/bpf/progs/test_lookup_key.c
+++ b/tools/testing/selftests/bpf/progs/test_lookup_key.c
@@ -23,7 +23,7 @@ extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
 extern void bpf_key_put(struct bpf_key *key) __ksym;
 
 SEC("lsm.s/bpf")
-int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	struct bpf_key *bkey;
 	__u32 pid;
diff --git a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
index 2fdc44e766248..21fce1108a21d 100644
--- a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
@@ -7,7 +7,7 @@
 char tp_name[128];
 
 SEC("lsm.s/bpf")
-int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	switch (cmd) {
 	case BPF_RAW_TRACEPOINT_OPEN:
diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
index 7e750309ce274..18ad24a851c6c 100644
--- a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
@@ -49,7 +49,7 @@ int BPF_PROG(tp_btf_run, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("lsm.s/bpf")
-int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	struct cgroup *cgrp = NULL;
 	struct task_struct *task;
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
index 12034a73ee2d2..135665f011c7e 100644
--- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
@@ -37,7 +37,7 @@ struct {
 char _license[] SEC("license") = "GPL";
 
 SEC("lsm.s/bpf")
-int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool is_kernel)
 {
 	struct bpf_dynptr data_ptr, sig_ptr;
 	struct data *data_val;
-- 
2.48.1


