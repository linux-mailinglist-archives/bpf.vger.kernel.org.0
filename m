Return-Path: <bpf+bounces-65690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B1B26FED
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA92A1B6279D
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E30245021;
	Thu, 14 Aug 2025 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPyHj37S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4631986E;
	Thu, 14 Aug 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202034; cv=none; b=ihVxSlPu3fWR3li8rXgiot0D+DN0GvUwzBsiEgzxpNXFVzSXFWstFsTAWnRpnbGlfwErpEruJLIy54Ljf1JdAuj3XtyPtwLbv6LVTS2OmMyE8yp+IRH8pS6yGVoIWh4lHXk/Egm72Fc1LLB3wKZBIXHKcoszhZSe/wsUA68qEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202034; c=relaxed/simple;
	bh=2owaul9A+dGf0QynrL5Uey/mmFkKxTm9pfu4odz6WOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQIwNbN9k8Ap4foMvsDHFf+iXM2w+FYreGfwG5kUaLNIGaID3ZQ6GngnqHAGE8A1BdWqCNYdvw6tOCXtPeV8TjAwbcI+O9lOiXJDFnNGa9YgkrLhg8wUXYOc5ec8ROMXuvVMWjOBHRC0ld7/joJb4DNpKCJMESaaWk5YVVHiQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPyHj37S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD3C4CEED;
	Thu, 14 Aug 2025 20:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755202034;
	bh=2owaul9A+dGf0QynrL5Uey/mmFkKxTm9pfu4odz6WOM=;
	h=From:To:Cc:Subject:Date:From;
	b=bPyHj37SnbrR3nIDx/xq0t4zhvLZT9kqcnEYK3dOXx7tsscuNIbRBcJPv1XQdS97F
	 hIn0BQUN57TT5oBOWY8VcBRFNTwkqzB/6g6l6lYgwAEEktGTabNecUELY5hEkgAc4q
	 XvA0seAtol90Kz5bB70BFNZGw6t09rKs2OjedApqpR4VlswR9+RXygWb9QobP25wMr
	 6UAAzFbBbMvI4YN2cKxIEPAuhsWz5VZlkqdcDxsNcfZneKVmA/c+u6GjgQQZm4pZPA
	 CQYgnnNSzpSKvgAo9mYyA9oT/4pcmrvQeW8QBrE6xo3RxTb4D/Shbupvrs6mFqefkj
	 l9f3T66z7Li6g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf] bpf: Check the helper function is valid in get_helper_proto
Date: Thu, 14 Aug 2025 22:06:55 +0200
Message-ID: <20250814200655.945632-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <olsajiri@gmail.com>

kernel test robot reported verifier bug [1] where the helper func
pointer could be NULL due to disabled config option.

As Alexei suggested we could check on that in get_helper_proto
directly. Marking tail_call helper func with BPF_PTR_POISON,
because it is unused by design.

[1] https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v3 changes:
- use BPF_PTR_POISON instead of number 1 [Andrii]
- fixed reported info and ack [Paul]

 kernel/bpf/core.c     | 5 ++++-
 kernel/bpf/verifier.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5d1650af899d..f8ac77d08ca7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3024,7 +3024,10 @@ EXPORT_SYMBOL_GPL(bpf_event_output);
 
 /* Always built-in helper functions. */
 const struct bpf_func_proto bpf_tail_call_proto = {
-	.func		= NULL,
+	/* func is unused for tail_call, we set it to pass the
+	 * get_helper_proto check
+	 */
+	.func		= BPF_PTR_POISON,
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_CTX,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..c89e2b1bc644 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11354,7 +11354,7 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 		return -EINVAL;
 
 	*ptr = env->ops->get_func_proto(func_id, env->prog);
-	return *ptr ? 0 : -EINVAL;
+	return *ptr && (*ptr)->func ? 0 : -EINVAL;
 }
 
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-- 
2.50.1


