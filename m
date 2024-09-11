Return-Path: <bpf+bounces-39568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2F9748C0
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EE71C25554
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFCB3BBDE;
	Wed, 11 Sep 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eY88Uns3"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F64D8D0;
	Wed, 11 Sep 2024 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025853; cv=none; b=R53uyECQFg94Cw3LOKslH4BBl39ozn78iXKNvzmQpQLwjDE/H1/kHGFpdMrkIl3J8UHIo+1YoUclAFZJKOK8QGhpiWtjdNiAhEuxq2/pURjnEXXG7EEzzH0UJ7QK0EoGp1iCPQjGUd0/r/nTFPAmO0UWR/Y43K+iYPS+mzvN8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025853; c=relaxed/simple;
	bh=fQA4ZmvJjUsqFOFX7s+On/lT0lNIldNAFmE9GyYmXH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0bYsW6pzp6QCxTL7CHm5otLTV4QW6FsikCSHvW5O6AkOq5IGOvsqtht0j7x+yythnfm/E7Zlu0aNf/OVSgpaBPnj1N1Xb3WYbrxP4a7JBr3aPj55Qohn1PEuhdSiB+zf138ofP7/EA/66PZbhoMZoi21J4Vz0oNgA/1w5LFor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eY88Uns3; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726025849; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kt0hxrOo2gJqVz1HQLnyjblcCFmCzmyTJPG3om2eI2M=;
	b=eY88Uns37ojjTnGt4S10fZDjIUyfsiTGgqdEKL22BL9tFoxbOozZMdqPjjN5IADeoISgrQ6adDINp924ZtUZ4kiUkj1/3UVz39Hekc6smbqZtsG5odMU2aptMb7nGUNHc3OwPbHkavOxMjvikB+LSaWB4oRGdKKMlqseNCDNR18=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEmDPhO_1726025847)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 11:37:27 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	juntong.deng@outlook.com,
	jrife@google.com,
	alan.maguire@oracle.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	vmalik@redhat.com,
	cupertino.miranda@oracle.com,
	mattbobrowski@google.com,
	xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Expand skb dynptr selftests for tp_btf
Date: Wed, 11 Sep 2024 11:37:19 +0800
Message-Id: <20240911033719.91468-6-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240911033719.91468-1-lulie@linux.alibaba.com>
References: <20240911033719.91468-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 3 test cases for skb dynptr used in tp_btf:
- test_dynptr_skb_tp_btf: use skb dynptr in tp_btf and make sure it is
  read-only.
- skb_invalid_ctx_fentry/skb_invalid_ctx_fexit: bpf_dynptr_from_skb
  should fail in fentry/fexit.

In test_dynptr_skb_tp_btf, to trigger the tracepoint in kfree_skb,
test_pkt_access is used for its test_run, as in kfree_skb.c. Because the
test process is different from others, a new setup type is defined,
i.e., SETUP_SKB_PROG_TP.

The result is like:
$ ./test_progs -t 'dynptr/test_dynptr_skb_tp_btf'
  #84/14   dynptr/test_dynptr_skb_tp_btf:OK
  #84      dynptr:OK
  #127     kfunc_dynptr_param:OK
  Summary: 2/1 PASSED, 0 SKIPPED, 0 FAILED

$ ./test_progs -t 'dynptr/skb_invalid_ctx_f'
  #84/85   dynptr/skb_invalid_ctx_fentry:OK
  #84/86   dynptr/skb_invalid_ctx_fexit:OK
  #84      dynptr:OK
  #127     kfunc_dynptr_param:OK
  Summary: 2/2 PASSED, 0 SKIPPED, 0 FAILED

Also fix two coding style nits (change spaces to tabs).

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 36 +++++++++++++++++--
 .../testing/selftests/bpf/progs/dynptr_fail.c | 25 +++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 23 ++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 7cfac53c0d58d..ba40be8b1c4ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -9,6 +9,7 @@
 enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
+	SETUP_SKB_PROG_TP,
 };
 
 static struct {
@@ -28,6 +29,7 @@ static struct {
 	{"test_dynptr_clone", SETUP_SKB_PROG},
 	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
 	{"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
+	{"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
@@ -35,7 +37,7 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 	struct dynptr_success *skel;
 	struct bpf_program *prog;
 	struct bpf_link *link;
-       int err;
+	int err;
 
 	skel = dynptr_success__open();
 	if (!ASSERT_OK_PTR(skel, "dynptr_success__open"))
@@ -47,7 +49,7 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
 		goto cleanup;
 
-       bpf_program__set_autoload(prog, true);
+	bpf_program__set_autoload(prog, true);
 
 	err = dynptr_success__load(skel);
 	if (!ASSERT_OK(err, "dynptr_success__load"))
@@ -87,6 +89,36 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 
 		break;
 	}
+	case SETUP_SKB_PROG_TP:
+	{
+		struct __sk_buff skb = {};
+		struct bpf_object *obj;
+		int aux_prog_fd;
+
+		/* Just use its test_run to trigger kfree_skb tracepoint */
+		err = bpf_prog_test_load("./test_pkt_access.bpf.o", BPF_PROG_TYPE_SCHED_CLS,
+					 &obj, &aux_prog_fd);
+		if (!ASSERT_OK(err, "prog_load sched cls"))
+			goto cleanup;
+
+		LIBBPF_OPTS(bpf_test_run_opts, topts,
+			    .data_in = &pkt_v4,
+			    .data_size_in = sizeof(pkt_v4),
+			    .ctx_in = &skb,
+			    .ctx_size_in = sizeof(skb),
+		);
+
+		link = bpf_program__attach(prog);
+		if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+			goto cleanup;
+
+		err = bpf_prog_test_run_opts(aux_prog_fd, &topts);
+
+		if (!ASSERT_OK(err, "test_run"))
+			goto cleanup;
+
+		break;
+	}
 	}
 
 	ASSERT_EQ(skel->bss->err, 0, "err");
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 68b8c6eca5083..8f36c9de75915 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include <linux/if_ether.h>
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
@@ -1254,6 +1255,30 @@ int skb_invalid_ctx(void *ctx)
 	return 0;
 }
 
+SEC("fentry/skb_tx_error")
+__failure __msg("must be referenced or trusted")
+int BPF_PROG(skb_invalid_ctx_fentry, void *skb)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	return 0;
+}
+
+SEC("fexit/skb_tx_error")
+__failure __msg("must be referenced or trusted")
+int BPF_PROG(skb_invalid_ctx_fexit, void *skb)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	return 0;
+}
+
 /* Reject writes to dynptr slot for uninit arg */
 SEC("?raw_tp")
 __failure __msg("potential write to dynptr at off=-16")
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 5985920d162e7..bfcc85686cf04 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
 #include "errno.h"
@@ -544,3 +545,25 @@ int test_dynptr_skb_strcmp(struct __sk_buff *skb)
 
 	return 1;
 }
+
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
+{
+	__u8 write_data[2] = {1, 2};
+	struct bpf_dynptr ptr;
+	int ret;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* since tp_btf skbs are read only, writes should fail */
+	ret = bpf_dynptr_write(&ptr, 0, write_data, sizeof(write_data), 0);
+	if (ret != -EINVAL) {
+		err = 2;
+		return 1;
+	}
+
+	return 1;
+}
-- 
2.32.0.3.g01195cf9f


