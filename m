Return-Path: <bpf+bounces-69490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFB4B97A7C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 23:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1886B32222F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC4311C19;
	Tue, 23 Sep 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh7VPZ0p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE430E82D;
	Tue, 23 Sep 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664405; cv=none; b=XnfgGHHqcsWgcT7ZArZswbdEcWxkLD++zhGTUabFlk0q4mKV6IIDe/qPwDN9p0k6Lx9FlxHL9RNsaQRnBZZKVFZmTOhkOg6yQrM0mgTkJehmIf2WAZPb/0E2DsHPnXKKNVusLmwHWum4Ub2S1/+f7xoMsxGmI+P3fsTELm0gzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664405; c=relaxed/simple;
	bh=OpzLg/8ZZk8IB4Rmz2mXM8LnzYXPoiDOAj+Xzo3GFkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHyT8GGQq964UGV+I9zP4c+2KZ5cktJkiupvUEKHweR5UpNsXo3vKvigOeenv2CtVTuRlyeIzSWcs30/WV7Q+r/wFLMQPL0NFqhjGJ9zzYXg1UiFuiNm0dI1rEz2Ja9hSt0m1401WKGZ5CXkyOPyHrihuwjbI7NnWoc/GzRavFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh7VPZ0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD203C4CEF5;
	Tue, 23 Sep 2025 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758664404;
	bh=OpzLg/8ZZk8IB4Rmz2mXM8LnzYXPoiDOAj+Xzo3GFkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mh7VPZ0ppE54wcUXXtdWf/h4beC0/2JSrie7Qwn/1/Hsvl159FNkdrv6cncih/LT8
	 TGW0xy+bLrW0b9Q+K8G5+KMpM4lfVH4zTaho2hSERtcoXUm6FKGE4mUJdR9ISk7+Yg
	 kRb2Fx+aukn8sfS4VBpkrJ2tRf5k1TycG7Fg8gyhznkXiinKdsCoi2tZPcIVOmCnop
	 Hwki4MyaA2oSMH0b3VNLUHm/u9zTcAoSz/wO99NPeNKq61oEsh+NkPQWdKIBXwDxjp
	 fo8iWIQpnsGPOzHpT66QneK3cdvN0vgVsu5IVAe8740bH+9WXe6gww7WvFQFap4Qla
	 VIULln/yaqa7Q==
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
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH 8/9] ftrace: Factor ftrace_ops ops_func interface
Date: Tue, 23 Sep 2025 23:51:46 +0200
Message-ID: <20250923215147.1571952-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923215147.1571952-1-jolsa@kernel.org>
References: <20250923215147.1571952-1-jolsa@kernel.org>
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
index 42da4dd08759..98e983d3d6b3 100644
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
index bdebaa94ca37..3464859189a2 100644
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
index 6e9d5975477d..2af1304d1a83 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2036,7 +2036,7 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 				 */
 				if (!ops->ops_func)
 					return -EBUSY;
-				ret = ops->ops_func(ops, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF);
+				ret = ops->ops_func(ops, rec->ip, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF);
 				if (ret)
 					return ret;
 			} else if (is_ipmodify) {
@@ -8740,7 +8740,7 @@ static int prepare_direct_functions_for_ipmodify(struct ftrace_ops *ops)
 				if (!op->ops_func)
 					return -EBUSY;
 
-				ret = op->ops_func(op, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_PEER);
+				ret = op->ops_func(op, ip, FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_PEER);
 				if (ret)
 					return ret;
 			}
@@ -8787,7 +8787,7 @@ static void cleanup_direct_functions_after_ipmodify(struct ftrace_ops *ops)
 
 			/* The cleanup is optional, ignore any errors */
 			if (found_op && op->ops_func)
-				op->ops_func(op, FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER);
+				op->ops_func(op, ip, FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER);
 		}
 	}
 	mutex_unlock(&direct_mutex);
-- 
2.51.0


