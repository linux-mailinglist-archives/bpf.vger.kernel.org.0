Return-Path: <bpf+bounces-75191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E8BC765EB
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA64A35B4BA
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A863612F9;
	Thu, 20 Nov 2025 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRg5qdDt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607922ED16B;
	Thu, 20 Nov 2025 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673926; cv=none; b=SfoUKpxOeq2LtUQNnn32JREGxJ2DRWbFFkK7muHbIRqi3WacmiA2L4s/c/ulBHp7DUvz4YsNEEdfKnIOTlBjjSXmmuvbLjGLgbr4rJXnwiZSCtOkDwqfGBq7DN3ViboAdKDJ7FJegW8qxCnWOIGiVSqLjkQsgg0E/RlYimzoxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673926; c=relaxed/simple;
	bh=Mqo7EJXWsx+FIdks6hO54RzctmDz89Zob5j/Foh8C5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZHXEG3wKEG0u87E7uqJzkUzAI0G1L9xJ5a4Isd3VjfrS1yfePESoK2vW5GeD3kmgRgnG0EaLvSLEUKMmOjgoR+F4hLdZWuwu7g+DS1XVLfPqidh0ioV0O7KP0EPrvsxQhGnkI1VZtgQRE09+TasIz5a8B72fxbBfDc1BT6wr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRg5qdDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2804AC4CEF1;
	Thu, 20 Nov 2025 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763673926;
	bh=Mqo7EJXWsx+FIdks6hO54RzctmDz89Zob5j/Foh8C5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRg5qdDtc1bbMIuHUS7oV7q4fVldJSAs/eOXXb7KurtnJxPv9/edGgaZ64jo9BdDF
	 Qd9z8LAa63AqLrYxBJp+DilczhZFAtY8dQItBTOQs1fNHBF9cFXQaHJUnWGWr0v9CM
	 izWVLofNcXUz4w5M01+Uwly/Xg6dT1RsyRb8Bx4rRhI1Za0tDaP+lMySoTKAafggbV
	 1wssL8k2PGjPO7L4FlyPCNz5Xn1h/y5rPJDFzuntWQJJivlsOffHRQqoW/VH9KoAR4
	 qVrd3Xn7neGlbOF8alonNIyewGVs3p+4zhB3GwTPMQ5AAzwEX2591hbqMSefZ3LeXy
	 KXI/zGrCUKnGw==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCHv3 bpf-next 7/8] ftrace: Factor ftrace_ops ops_func interface
Date: Thu, 20 Nov 2025 22:24:01 +0100
Message-ID: <20251120212402.466524-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120212402.466524-1-jolsa@kernel.org>
References: <20251120212402.466524-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to remove "ftrace_ops->private == bpf_trampoline" setup
in following changes.

Adding ip argument to ftrace_ops_func_t callback function, so we can
use it to look up the trampoline.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h  | 2 +-
 kernel/bpf/trampoline.c | 3 ++-
 kernel/trace/ftrace.c   | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 4e2c0ed769fc..5aa37dec0081 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -402,7 +402,7 @@ enum ftrace_ops_cmd {
  *        Negative on failure. The return value is dependent on the
  *        callback.
  */
-typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, enum ftrace_ops_cmd cmd);
+typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, unsigned long ip, enum ftrace_ops_cmd cmd);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f33693061c2e..d8762f7990ed 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -33,7 +33,8 @@ static DEFINE_MUTEX(trampoline_mutex);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
-static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd cmd)
+static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
+				     enum ftrace_ops_cmd cmd)
 {
 	struct bpf_trampoline *tr = ops->private;
 	int ret = 0;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5243aefb6096..b0e4d7a5d47c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2049,7 +2049,7 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 				 */
 				if (!ops->ops_func)
 					return -EBUSY;
-				ret = ops->ops_func(ops, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF);
+				ret = ops->ops_func(ops, rec->ip, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF);
 				if (ret)
 					return ret;
 			} else if (is_ipmodify) {
@@ -8976,7 +8976,7 @@ static int prepare_direct_functions_for_ipmodify(struct ftrace_ops *ops)
 				if (!op->ops_func)
 					return -EBUSY;
 
-				ret = op->ops_func(op, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_PEER);
+				ret = op->ops_func(op, ip, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_PEER);
 				if (ret)
 					return ret;
 			}
@@ -9023,7 +9023,7 @@ static void cleanup_direct_functions_after_ipmodify(struct ftrace_ops *ops)
 
 			/* The cleanup is optional, ignore any errors */
 			if (found_op && op->ops_func)
-				op->ops_func(op, FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER);
+				op->ops_func(op, ip, FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER);
 		}
 	}
 	mutex_unlock(&direct_mutex);
-- 
2.51.1


