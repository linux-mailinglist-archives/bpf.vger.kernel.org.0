Return-Path: <bpf+bounces-38962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93F96D0F1
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DDF285BDE
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06BC194AD1;
	Thu,  5 Sep 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="doEQQoTG"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1319340D;
	Thu,  5 Sep 2024 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522997; cv=none; b=UnY+kKHIqDOcoJcD0ggeWGJozfzEgCxGl2CFz1BfsS/YBbyHCljmuxmXVdRLKFQWa74qyi8aTYUAuBP5+8K2DdH0/9XMPBIOMUAHP29C3kpOiC/WVbj6PrWrw0fLoVLbiRj/oiUKiRfvae1Jm8dA5N4B5lH3MHIZ2WbtvXa23Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522997; c=relaxed/simple;
	bh=67C+ySKUMFOl/Vw/EWHL5BU7fz6lIct5OzmIokYnQIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yk3T06kUhWX9e0aLjWc7YM0RZqkzu1ZLQA//De9Ba7IPXBCVFlEc57QLIN7YJuI/J6FuigDM1x7R1xpfZoNRepgIJcSPIEFWYiayV3VbDnCvbgbDQamnlerSMCuvKjbsU9HvJSVTeWT0TF4X7oCyfj66It6bPsuFbR9jAnfSyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=doEQQoTG; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725522986; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XIpXmKG/dvqtkO380OYf1vfqjzkl8IpnbYNB+J/73MQ=;
	b=doEQQoTG/kdjL2Y7oLNSv/Y5ZA0ZtaZJs/d8Kl+YgCImoiCicQ+F1ePQi8tZ9J9Y4dSwb+EEY9iZtUu0rZymLtLvf/4pIsZHaGJTuh3vPHEFknPKVQlo4J2BdXQ2mHRBuF7gFsTJ+uC0KJmQhAwSkOzXUjizYAAQAYeeyTwYxss=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEKrrCP_1725522983)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 15:56:24 +0800
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
Subject: [PATCH bpf-next v2 1/5] bpf: Support __nullable argument suffix for tp_btf
Date: Thu,  5 Sep 2024 15:56:18 +0800
Message-Id: <20240905075622.66819-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240905075622.66819-1-lulie@linux.alibaba.com>
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointers passed to tp_btf were trusted to be valid, but some tracepoints
do take NULL pointer as input, such as trace_tcp_send_reset(). Then the
invalid memory access cannot be detected by verifier.

This patch fix it by add a suffix "__nullable" to the unreliable
argument. The suffix is shown in btf, and PTR_MAYBE_NULL will be added
to nullable arguments. Then users must check the pointer before use it.

A problem here is that we use "btf_trace_##call" to search func_proto.
As it is a typedef, argument names as well as the suffix are not
recorded. To solve this, I use bpf_raw_event_map to find
"__bpf_trace##template" from "btf_trace_##call", and then we can see the
suffix.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/bpf/btf.c      | 13 +++++++++++++
 kernel/bpf/verifier.c | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1e29281653c62..157f5e1247c81 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6385,6 +6385,16 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
 	}
 }
 
+static bool prog_arg_maybe_null(const struct bpf_prog *prog, const struct btf *btf,
+				const struct btf_param *arg)
+{
+	if (prog->type != BPF_PROG_TYPE_TRACING ||
+	    prog->expected_attach_type != BPF_TRACE_RAW_TP)
+		return false;
+
+	return btf_param_match_suffix(btf, arg, "__nullable");
+}
+
 int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 		       u32 arg_no)
 {
@@ -6554,6 +6564,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
 
+	if (prog_arg_maybe_null(prog, btf, &args[arg]))
+		info->reg_type |= PTR_MAYBE_NULL;
+
 	if (tgt_prog) {
 		enum bpf_prog_type tgt_type;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 217eb0eafa2a6..9ee68ed915dfe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -28,6 +28,7 @@
 #include <linux/cpumask.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
+#include <linux/trace_events.h>
 
 #include "disasm.h"
 
@@ -21780,6 +21781,8 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+#define BTF_MAX_NAME_SIZE 128
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -21788,6 +21791,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 {
 	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
 	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
+	char trace_symbol[BTF_MAX_NAME_SIZE];
+	const struct bpf_raw_event_map *btp;
 	const char prefix[] = "btf_trace_";
 	int ret = 0, subprog = -1, i;
 	const struct btf_type *t;
@@ -21795,6 +21800,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	const char *tname;
 	struct btf *btf;
 	long addr = 0;
+	char *fname;
 	struct module *mod = NULL;
 
 	if (!btf_id) {
@@ -21923,10 +21929,34 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 		tname += sizeof(prefix) - 1;
-		t = btf_type_by_id(btf, t->type);
-		if (!btf_type_is_ptr(t))
-			/* should never happen in valid vmlinux build */
+
+		/* The func_proto of "btf_trace_##tname" is generated from typedef without argument
+		 * names. Thus using bpf_raw_event_map to get argument names. For module, the module
+		 * name is printed in "%ps" after the template function name, so use strsep to cut
+		 * it off.
+		 */
+		btp = bpf_get_raw_tracepoint(tname);
+		if (!btp)
 			return -EINVAL;
+		sprintf(trace_symbol, "%ps", btp->bpf_func);
+		fname = trace_symbol;
+		fname = strsep(&fname, " ");
+
+		ret = btf_find_by_name_kind(btf, fname, BTF_KIND_FUNC);
+		if (ret < 0) {
+			bpf_log(log, "Cannot find btf of template %s, fall back to %s%s.\n",
+				fname, prefix, tname);
+			t = btf_type_by_id(btf, t->type);
+			if (!btf_type_is_ptr(t))
+				/* should never happen in valid vmlinux build */
+				return -EINVAL;
+		} else {
+			t = btf_type_by_id(btf, ret);
+			if (!btf_type_is_func(t))
+				/* should never happen in valid vmlinux build */
+				return -EINVAL;
+		}
+
 		t = btf_type_by_id(btf, t->type);
 		if (!btf_type_is_func_proto(t))
 			/* should never happen in valid vmlinux build */
-- 
2.32.0.3.g01195cf9f


