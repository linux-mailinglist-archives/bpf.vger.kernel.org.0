Return-Path: <bpf+bounces-21261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F484AB14
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 01:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD522890C2
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 00:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFDC1109;
	Tue,  6 Feb 2024 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBIhhHAG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC829ECE
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178965; cv=none; b=ch0gRulkFdh0bZxa50xy+0IxiTuscpm8g6VVvixu6MyVAf33kO/s6iZoXvVcAaIN01Im9OHXAvQ3ZtLtLOO6XuAFjr4X5NlUAocP1AmrSd+bVKwUwU51NSI4wH16/YFneYumq/Bj0SVNTCJ6RGwIIJDz0pguSQFazTTf4VkHST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178965; c=relaxed/simple;
	bh=xXm1Ba6E4s/Yxbh83u7nS3rODDJlquPCKY1CkVqOjDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PRcHYgoHsEvqZZZ0slPPTi7/5EITgSitq9dqIWQ2j44TeqcDPTMukMG/QS/sGg0l/9k8Nm7oaT8wwcGq7MmUsLPBZEmnuMzXxpdN9stjyHvRemRMc/ir6vlNdZy80n5NAkO4EIo7t3MMi7soMOE+K0/xUj7ryx3oM4VqxGwzXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBIhhHAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C07C433C7;
	Tue,  6 Feb 2024 00:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707178965;
	bh=xXm1Ba6E4s/Yxbh83u7nS3rODDJlquPCKY1CkVqOjDM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZBIhhHAGwNhTdUix8t83OFr9Q3Dm7fC5jWIFbTBwko10rv7sFtdMqskxyjfhaPAhp
	 Qu8FqMUhWPz3+0A39LUESKQJHUwLrvyBJupTbhP7qjcbrxu9yZx9PR8ebcIX/LUzZS
	 d7pndHeS40KHqMTzNuGbwFUxuMSC6/a0N3JeH/kxWY374J3Vdktpd+MZiq/AGs3a+x
	 SOjk+0fXyvkTo2q7ssVx+a58A6boQaSiNKKYuoWQNhAN7JM8fcKXPudtwUc8JCATFN
	 GIwrt6AscODr/wOjagfEBbxmi59DTEXzd9eDBv9uczEfT8B0Givaweii2b/ixZRZef
	 4+wWxuXU+jeWQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: fix return value for PERF_EVENT __arg_ctx type fix up check
Date: Mon,  5 Feb 2024 16:22:43 -0800
Message-Id: <20240206002243.1439450-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If PERF_EVENT program has __arg_ctx argument with matching
architecture-specific pt_regs/user_pt_regs/user_regs_struct pointer
type, libbpf should still perform type rewrite for old kernels, but not
emit the warning. Fix copy/paste from kernel code where 0 is meant to
signify "no error" condition. For libbpf we need to return "true" to
proceed with type rewrite (which for PERF_EVENT program will be
a canonical `struct bpf_perf_event_data *` type).

Fixes: 9eea8fafe33e ("libbpf: fix __arg_ctx type enforcement for perf_event programs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6932f2c4ddfd..01f407591a92 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6404,13 +6404,13 @@ static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_pro
 	case BPF_PROG_TYPE_PERF_EVENT:
 		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct pt_regs) &&
 		    btf_is_struct(t) && strcmp(tname, "pt_regs") == 0)
-			return 0;
+			return true;
 		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_pt_regs) &&
 		    btf_is_struct(t) && strcmp(tname, "user_pt_regs") == 0)
-			return 0;
+			return true;
 		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_regs_struct) &&
 		    btf_is_struct(t) && strcmp(tname, "user_regs_struct") == 0)
-			return 0;
+			return true;
 		break;
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
-- 
2.34.1


