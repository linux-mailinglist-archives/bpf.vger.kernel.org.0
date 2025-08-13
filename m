Return-Path: <bpf+bounces-65518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4932BB24AC5
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739C11BC50D6
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610882EB5CD;
	Wed, 13 Aug 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWJUZnn/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101A2EACE3;
	Wed, 13 Aug 2025 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092325; cv=none; b=HksKEmgQHNLjmbRrUEgvi/AJvfmegT+PrZfPmOUkPe3+YSI9jGh2XqmwAT/w+LIPxr1j2WICmcdIBitq4YCLcteJwL2WxI1TAQSX0vI4ixjmH6kAuGT7UNxLiHHk4ZJiz25NjoCMWiIlT4bbzxu97V6OQkBYs9Q0I6CcCNrYrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092325; c=relaxed/simple;
	bh=ivvFjuUqHzq8vh6cPGasq+coVZaTL9iXxS+y7Na9OoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iChBCqWKpefMfMag72OdHLtSWQSenoL6ecqXQdBr1+ohz4mEeGbUI8d5Z3LIwL/tp5E4ix9aZQq2+U4R//NtqL6exSfNYsCF2po5sx0yimOlcTyoTlyakd4C79cSa8B+cofzl5dZrHQ2blnsAs3bhraif955+6qTZXn4eJ2QYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWJUZnn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4638DC4CEEB;
	Wed, 13 Aug 2025 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755092325;
	bh=ivvFjuUqHzq8vh6cPGasq+coVZaTL9iXxS+y7Na9OoE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZWJUZnn/UdlayvDFuuUQ+rTqYYAql+NQP7TYz1+omiOFcC4vqd7qb9okw/uLBWxN5
	 wAqgEPJRmggdExVl9bdTCygsWD+z9VQ7D0aUHQ9NkAqpHnRRrPWPZtqj2o0OVV7iTH
	 WxjlidS/DIEPytnJ+bUIwI2UqUWgNJCef7hsptyr+hGG2QzwqU8+PXm5tQ4prCITUo
	 faniEBs3i//a9nMFwvvzcaG6rtVBoi02S9EvEMtmoVQLCO67zv1QxGGMjWGiqWDNup
	 1Tse6dGIOPPH8Ts6hHjeV3Q6+xT5EgzBA3IlqcfCnJHDVPcHZGWgWzYglmqy4vgjvV
	 h/EzV0Ynor/VQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf] bpf: Check the helper function is valid in get_helper_proto
Date: Wed, 13 Aug 2025 15:38:32 +0200
Message-ID: <20250813133832.755428-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <olsajiri@gmail.com>

syzbot reported an verifier bug [1] where the helper func pointer
could be NULL due to disabled config option.

As Alexei suggested we could check on that in get_helper_proto
directly. Excluding tail_call helper from the check, because it
is NULL by design and valid in all configs.

[1] https://lore.kernel.org/bpf/68904050.050a0220.7f033.0001.GAE@google.com/
Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
- set bpf_tail_call_proto.func to -1 so we can skip the extra check [Andrii]

 kernel/bpf/core.c     | 5 ++++-
 kernel/bpf/verifier.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5d1650af899d..0f6e9a3d9960 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3024,7 +3024,10 @@ EXPORT_SYMBOL_GPL(bpf_event_output);
 
 /* Always built-in helper functions. */
 const struct bpf_func_proto bpf_tail_call_proto = {
-	.func		= NULL,
+	/* func is unused for tail_call, we set it to pass the
+	 * get_helper_proto check
+	 */
+	.func		= (void *) 1,
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


