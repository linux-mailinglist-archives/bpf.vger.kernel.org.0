Return-Path: <bpf+bounces-39565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8769748BA
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C96B20BC6
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE77433D0;
	Wed, 11 Sep 2024 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ydhKiXGd"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFFD37708;
	Wed, 11 Sep 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025849; cv=none; b=ESElGoC2ieuTsZdiIkWKEP++urwkyqUrKWQ3OfnwioUu4eY6CbhcvL4hCxo8nWTkI25IE7AzvOKjIHs/jT4RXkNnqvte4sLTkjcYNtm/nFQR+qKYo6XQ6sYm7tbB95MDMrYVUNVc+p0KblvS04TKB1XH6IQYQ8w+By2PXx3kpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025849; c=relaxed/simple;
	bh=yjzfZ0RmwQaNWmpgdz4REgB2axh5G/3VoM2mR8RwPpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/0SylqVUXwGTVWqfr8RB5kHRHNYM6/HNZdXbs0I49YPcz9ZTTCrpANbnqckYndhjGuXXSSYjyvk9T3xOEWOiCKmIiPCFQ6qUlz7ocTGrEA4DHw96JqGOOF4fU3Ckb8qkMRLEDdIwlxSnpX3KnOOJnh6cAjBF93VC4GJpJglhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ydhKiXGd; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726025844; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WwcZsrFs/zwinoTKm43cGq8al6XWxgQc/c+7MSHqMic=;
	b=ydhKiXGdEFhHlWs0dk07tNL4kRkXwdi+K3Os6tLpeFXf5M5FP1FJoSCUGhJg9Ciu2zX1lMpjKcSybglBbRlpUx+f0bEiZwnjWec83kh2tgQ/iEw16xtuONVunGwhjhC68jCiXyPOoE/rZ2gYFZuM/yJS2UAwtjFFUzO7UEUuYhA=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEmEW00_1726025841)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 11:37:22 +0800
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
Subject: [PATCH bpf-next v3 1/5] bpf: Support __nullable argument suffix for tp_btf
Date: Wed, 11 Sep 2024 11:37:15 +0800
Message-Id: <20240911033719.91468-2-lulie@linux.alibaba.com>
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
 kernel/bpf/btf.c      |  9 +++++++++
 kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1e29281653c62..d1ea38d08f301 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6385,6 +6385,12 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
 	}
 }
 
+static bool prog_arg_maybe_null(const struct bpf_prog *prog, const struct btf *btf,
+				const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__nullable");
+}
+
 int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 		       u32 arg_no)
 {
@@ -6554,6 +6560,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
 
+	if (prog_arg_maybe_null(prog, btf, &args[arg]))
+		info->reg_type |= PTR_MAYBE_NULL;
+
 	if (tgt_prog) {
 		enum bpf_prog_type tgt_type;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 217eb0eafa2a6..72c232fc451be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -28,6 +28,8 @@
 #include <linux/cpumask.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
+#include <linux/trace_events.h>
+#include <linux/kallsyms.h>
 
 #include "disasm.h"
 
@@ -21788,11 +21790,13 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 {
 	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
 	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
+	char trace_symbol[KSYM_SYMBOL_LEN];
 	const char prefix[] = "btf_trace_";
+	struct bpf_raw_event_map *btp;
 	int ret = 0, subprog = -1, i;
 	const struct btf_type *t;
 	bool conservative = true;
-	const char *tname;
+	const char *tname, *fname;
 	struct btf *btf;
 	long addr = 0;
 	struct module *mod = NULL;
@@ -21923,10 +21927,34 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 		tname += sizeof(prefix) - 1;
-		t = btf_type_by_id(btf, t->type);
-		if (!btf_type_is_ptr(t))
-			/* should never happen in valid vmlinux build */
+
+		/* The func_proto of "btf_trace_##tname" is generated from typedef without argument
+		 * names. Thus using bpf_raw_event_map to get argument names.
+		 */
+		btp = bpf_get_raw_tracepoint(tname);
+		if (!btp)
 			return -EINVAL;
+		fname = kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NULL,
+					trace_symbol);
+		bpf_put_raw_tracepoint(btp);
+
+		if (fname)
+			ret = btf_find_by_name_kind(btf, fname, BTF_KIND_FUNC);
+
+		if (!fname || ret < 0) {
+			bpf_log(log, "Cannot find btf of tracepoint template, fall back to %s%s.\n",
+				prefix, tname);
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


