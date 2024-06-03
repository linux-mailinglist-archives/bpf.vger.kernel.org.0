Return-Path: <bpf+bounces-31187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D128D80A2
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 13:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67951C21C1F
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 11:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699683CD3;
	Mon,  3 Jun 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJzAAniK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B277109
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413255; cv=none; b=GwmYe6lvJMEKPxD7u3DqKsKfzeNgsbDCJijYfjqXorZBvGRMTcr/Q37tQzKVvLuW3ZRoecpypddZDakYoVhOCs4H0/dvxYh6Y5VrLLm5AX0a2gjMQBHTHqCeDr4zso+isjlkF1DH5eAEgseYNSeqkyqcpO95l+IicZXL/yXDUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413255; c=relaxed/simple;
	bh=9wexLSzfBmuLLM9kYTPQws6UgtyEoLMiJ8NjdRDp/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHweIydzEPeGN+5fL1uRSPbs5HQwPW0D+FqQ8DiRTje9Wdxlp4l6iCVuOB305S7SLwlbdQI9P/OdqpAUmQaYOA98aSGtCrxRIjWCFXOWBkVC24YOBUp1dIP51ucca/gKLelaDLBmhB7PS/CLLG9puIWto9G+35LhVbOY1gT3IhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJzAAniK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D143C2BD10;
	Mon,  3 Jun 2024 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717413255;
	bh=9wexLSzfBmuLLM9kYTPQws6UgtyEoLMiJ8NjdRDp/FQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mJzAAniKaQp/DdyNdU7EIgGDASLf3P+b12VNilzd8fG3VQMBDFWUCRdEf4vCC2UeV
	 bpl3xa0RKzsiQZHM5HeqvuScclGwScb+KRZrSRfR2R2N51uX+GsXMQ0vf9O+iV/o/n
	 aUtoXmxajYAOGTHcpf+Y0MEFSvj/P70hFE1I0TEfYki3GCgjA9cqKmRX92+2DOOeF/
	 z5Oea384P9+N5PVQBhEk54iH/FXLCMxMpOe9ppJcXd8u6bKuLMdjUFpWIv0kvoOWh6
	 xqzOl+cpmUfHVA9Bor4yQrsIkUA/7p4eT19cC9vgNz1ndoreK9UCS7RYIb6eRr7HGk
	 QmxxEp5YjPv1A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf] bpf: Set run context for rawtp test_run callback
Date: Mon,  3 Jun 2024 13:14:08 +0200
Message-ID: <20240603111408.3981087-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported crash when rawtp program executed through the
test_run interface calls bpf_get_attach_cookie helper or any
other helper that touches task->bpf_ctx pointer.

We need to setup bpf_ctx pointer in rawtp test_run as well,
so fixing this by moving __bpf_trace_run in header file and
using it in test_run callback.

Also renaming __bpf_trace_run to bpf_prog_run_trace.

Fixes: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to access bpf_cookie value")
Reported-by: syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ab78ff125b7979e45f9
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 27 +++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 28 ++--------------------------
 net/bpf/test_run.c       |  4 +---
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5e694a308081..4eb803b1d308 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2914,6 +2914,33 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+static __always_inline int
+bpf_prog_run_trace(struct bpf_prog *prog, u64 cookie, u64 *ctx,
+		   bpf_prog_run_fn run_prog)
+{
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	int ret = -1;
+
+	cant_sleep();
+	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+		bpf_prog_inc_misses_counter(prog);
+		goto out;
+	}
+
+	run_ctx.bpf_cookie = cookie;
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+
+	rcu_read_lock();
+	ret = run_prog(prog, ctx);
+	rcu_read_unlock();
+
+	bpf_reset_run_ctx(old_run_ctx);
+out:
+	this_cpu_dec(*(prog->active));
+	return ret;
+}
+
 static __always_inline int
 bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d1daeab1bbc1..8a23ef42b76b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2383,31 +2383,6 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 	preempt_enable();
 }
 
-static __always_inline
-void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
-{
-	struct bpf_prog *prog = link->link.prog;
-	struct bpf_run_ctx *old_run_ctx;
-	struct bpf_trace_run_ctx run_ctx;
-
-	cant_sleep();
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
-		bpf_prog_inc_misses_counter(prog);
-		goto out;
-	}
-
-	run_ctx.bpf_cookie = link->cookie;
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-
-	rcu_read_lock();
-	(void) bpf_prog_run(prog, args);
-	rcu_read_unlock();
-
-	bpf_reset_run_ctx(old_run_ctx);
-out:
-	this_cpu_dec(*(prog->active));
-}
-
 #define UNPACK(...)			__VA_ARGS__
 #define REPEAT_1(FN, DL, X, ...)	FN(X)
 #define REPEAT_2(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_1(FN, DL, __VA_ARGS__)
@@ -2437,7 +2412,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	{								\
 		u64 args[x];						\
 		REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);			\
-		__bpf_trace_run(link, args);				\
+		(void) bpf_prog_run_trace(link->link.prog, link->cookie,\
+					  args, bpf_prog_run);		\
 	}								\
 	EXPORT_SYMBOL_GPL(bpf_trace_run##x)
 BPF_TRACE_DEFN_x(1);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f6aad4ed2ab2..84d1c91b01ab 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -728,9 +728,7 @@ __bpf_prog_test_run_raw_tp(void *data)
 {
 	struct bpf_raw_tp_test_run_info *info = data;
 
-	rcu_read_lock();
-	info->retval = bpf_prog_run(info->prog, info->ctx);
-	rcu_read_unlock();
+	info->retval = bpf_prog_run_trace(info->prog, 0, info->ctx, bpf_prog_run);
 }
 
 int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
-- 
2.45.1


