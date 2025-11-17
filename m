Return-Path: <bpf+bounces-74733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1964C6448E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F993A9028
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E8314A86;
	Mon, 17 Nov 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUVdDG/d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7932F75B
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384874; cv=none; b=r8WBeIGGRt8CJa9j/zQIH9mUNNq87X+lfdShkN7g6V/FhyJmKnNi4PmOi3sZLXh9rJlq6FxnFjcOpZ4TqVY6G+ur4Tx/Y6gDqG2HwqkLhBWJ2gdCrhjzUn8Q0djTHmnMZOIl21GOnbrd2mtp/LKSUgkaY1wEyUoWw4C4x2tLC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384874; c=relaxed/simple;
	bh=Ivh/2KVnSZdkNU5Ff1BAUEqgaIlJMOPNSdwqg1XDvSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INqxHCy97w359tj3hhebfvqKRHFLNIPNOphI+p1/3PAeDegKi3YjqlFx8grCvpfI8jHuSZAl0Yn9Em4qqcqNaN+gx+GeO+ku27qeNxIpRcweo8uKOBeA8obF5wlpTklDv7q166/wjcLYXjUwivU1SrjjnpkR8Kg6kdbbDKcoeGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUVdDG/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4549EC113D0;
	Mon, 17 Nov 2025 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763384873;
	bh=Ivh/2KVnSZdkNU5Ff1BAUEqgaIlJMOPNSdwqg1XDvSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUVdDG/dbX79kQIL84p9xwVksUNRo/kIk+x5IUJkWHyX95NdVMRxMGsd/xHIUI15M
	 uy7hw+m/o8SWfbypUDRwdWyBS5Pm+DSz6ImN8bvg8nM1rPlJ51l2yYWrYDpZS64Vth
	 JZE0kuX3SMHCkg6ZiMiVPySYzls9QB+7Kt3iQ2qeA1uE6MLZcj81ySquyPU8Y4IzE0
	 DHuFnXfZRmFLQgIfHSB+qYhWYCKz9fOiO7exFPXHCY2WBBNEvl6e9JwbHaDFvtZEbl
	 BDeFGIwL6KZ5ZK1vTKSN06P/X2ifOj9Kb7C0Jg8ovqpKoTT/mqL3dpWH2B2+zw7UI8
	 jJUFIj3UbNQ1Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftests: bpf: Enable gotox tests from arm64
Date: Mon, 17 Nov 2025 13:07:31 +0000
Message-ID: <20251117130732.11107-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117130732.11107-1-puranjay@kernel.org>
References: <20251117130732.11107-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 JIT now supports gotox instruction and jumptables, so run tests in
verifier_gotox.c for arm64.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_gotox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index b6710f134a1d..536c9f3e2170 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -6,7 +6,7 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-#ifdef __TARGET_ARCH_x86
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 
 #define DEFINE_SIMPLE_JUMP_TABLE_PROG(NAME, SRC_REG, OFF, IMM, OUTCOME)	\
 									\
@@ -384,6 +384,6 @@ jt0_%=:								\
 	: __clobber_all);
 }
 
-#endif /* __TARGET_ARCH_x86 */
+#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 */
 
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


