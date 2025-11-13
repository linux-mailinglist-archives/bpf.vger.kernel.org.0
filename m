Return-Path: <bpf+bounces-74397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A8EC57790
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651DC42055E
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DD134E765;
	Thu, 13 Nov 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIp/VtJR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C02DECA5;
	Thu, 13 Nov 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037593; cv=none; b=QCQu/jOqMDUeTWHGpIOjPH4fzMNKgdFxB/Cxe7l5CSUzHmtFlgDB/hc5yfGcRTdpLKW7cNYsKf53khp03AQ2xEQCKe143tzoCNEiQsDCmicADPoCfT70ckG6G30gY6F0WNXvM9DjEQBv2ZVaSx7b8vdE1sw2pV1OFlIIXlyeRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037593; c=relaxed/simple;
	bh=at2i7Ol3h6uTyE0sfyhwMTAAs3pKddbr5dxMSkFzwxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bulZ6bAJj0hqw2nOciws2uzq5coy5kgPzUM50pyJlsl0ouvHrD/NHyTECShxT1hVD+4CylJO2qL/l0kJy7JV3niu+aTLZicanU/Q8J30V+rOqGPjsFtsuYLYsL6TQ1y4S5MmsCyIJIEr60hJcUOZOJXmjuEkMy1A+psJ1WHYNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIp/VtJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45447C113D0;
	Thu, 13 Nov 2025 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037592;
	bh=at2i7Ol3h6uTyE0sfyhwMTAAs3pKddbr5dxMSkFzwxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIp/VtJRwFnrno3DvYLyPTElwBK7JMYPCmFWSeH04eHsPhQBlG3nnAX+8A1DhKfZt
	 SSKS0JuAGolJs5VXWiUpek5a87k5fwG/snQgOJ598S+CoFOn3V+hwoXLBrX90PXGXA
	 qUik7nG6Sd2JCHmGuiQjk5g3ZYOy/sQ/H3OwFy65UAnq/AtxdRBKpvJcT00ez0i/k+
	 OKnbYfrGLM4qP2FuZoHo6vl5owND+I/XdrWzLt6vsMe7P9Vlm/D3hUkOmtpWG0xn+1
	 u/VjGvGelwZZR4EyvlHNDitqj9Uhr0VQol8kMn8PKyJzAFGhGm7iCf9kQA8Wj90FtK
	 8Gs311iNP2sbQ==
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
Subject: [PATCHv2 bpf-next 7/8] ftrace: Factor ftrace_ops ops_func interface
Date: Thu, 13 Nov 2025 13:37:49 +0100
Message-ID: <20251113123750.2507435-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113123750.2507435-1-jolsa@kernel.org>
References: <20251113123750.2507435-1-jolsa@kernel.org>
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
index bacb6d9ab426..d4246d02ea0d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -394,7 +394,7 @@ enum ftrace_ops_cmd {
  *        Negative on failure. The return value is dependent on the
  *        callback.
  */
-typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, enum ftrace_ops_cmd cmd);
+typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, unsigned long ip, enum ftrace_ops_cmd cmd);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 9ca75b22aae0..26887a0db955 100644
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
index e701516a4a65..03948ec81434 100644
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
@@ -8965,7 +8965,7 @@ static int prepare_direct_functions_for_ipmodify(struct ftrace_ops *ops)
 				if (!op->ops_func)
 					return -EBUSY;
 
-				ret = op->ops_func(op, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_PEER);
+				ret = op->ops_func(op, ip, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_PEER);
 				if (ret)
 					return ret;
 			}
@@ -9012,7 +9012,7 @@ static void cleanup_direct_functions_after_ipmodify(struct ftrace_ops *ops)
 
 			/* The cleanup is optional, ignore any errors */
 			if (found_op && op->ops_func)
-				op->ops_func(op, FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER);
+				op->ops_func(op, ip, FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER);
 		}
 	}
 	mutex_unlock(&direct_mutex);
-- 
2.51.1


