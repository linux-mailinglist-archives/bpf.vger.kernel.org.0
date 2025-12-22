Return-Path: <bpf+bounces-77293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ABACD62A9
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 14:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BC0303E01F
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13922C376B;
	Mon, 22 Dec 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncL5OeDv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA22C030E
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410400; cv=none; b=lIepQVgTlqlVWokRBbKfOmcCXNIcCuAi8BLRlYzQLtHZ0JJqNfTQsbQL5zbuFDwQEw98bzvsShXbQrDyJjr2n5rBvTzawBHFJ/rGxcwn14Trz9UyLHA+J9rV/6YLXk/QnfC8D4Qr0Ivucp15PdZK+MmM91OzCvt9tWwbXXEd0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410400; c=relaxed/simple;
	bh=uaYxyv0felBEGKBVXY58Kixs5yOsbGRFm2fO6pbfCsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PajZx5GLZC+SdJvCK3kjuWNuy9ZLcn634WS7QznUspjLiZyHMbszR7tALMXDIKoU34ouJOTMXYuoMohquaau/u8KTXWoVWOi+JU7SvkpGCBmLFUPXADnGA6xbeoH8aP1ZYufWEJdVPYpLUff/jARv2yNTfkr5hNMt3WdPqS6e5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncL5OeDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A04DC113D0;
	Mon, 22 Dec 2025 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766410399;
	bh=uaYxyv0felBEGKBVXY58Kixs5yOsbGRFm2fO6pbfCsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncL5OeDvrtPjIh2me+iCpybiMtoYuqtp4sKFl3PEnOtjnCxglzGMlhrnyZxkT55Zm
	 MW6TtNIJtqCH/FELue4z0X4IdLO4eTLELB1tk0WTe/HpAb0NE+07KTtAk2jiAKIV5R
	 b7TCYrck/nKl9w18Wb4JzLU5NAEkfo16zGs2eGqso78g/NvDHH1MMbFIfI6NSCRqMW
	 KVut6TUCTc04kVDJl35i4CfTPmNM/Q02TxM+4xVM6apIcI7mbpVCNx6N+usvGRn7u8
	 h95kF2pAB4LlbSWdXYhOfVqWXNroyTg7+GBR4Jas1pA2BKyrncEfs6o3XEqPCSudu0
	 U0Ax1UASSNiuw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests: bpf: fix tests with raw_tp calling kfuncs
Date: Mon, 22 Dec 2025 05:32:46 -0800
Message-ID: <20251222133250.1890587-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251222133250.1890587-1-puranjay@kernel.org>
References: <20251222133250.1890587-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the previous commit allowed raw_tp programs to call kfuncs, so of the
selftests that were expected to fail will now succeed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c             | 2 +-
 .../testing/selftests/bpf/progs/verifier_kfunc_prog_types.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index dda6a8dada82..8f2ae9640886 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1465,7 +1465,7 @@ int xdp_invalid_data_slice2(struct xdp_md *xdp)
 }
 
 /* Only supported prog type can create skb-type dynptrs */
-SEC("?raw_tp")
+SEC("?xdp")
 __failure __msg("calling kernel function bpf_dynptr_from_skb is not allowed")
 int skb_invalid_ctx(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
index a509cad97e69..1fce7a7e8d03 100644
--- a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
@@ -32,7 +32,7 @@ static void task_kfunc_load_test(void)
 }
 
 SEC("raw_tp")
-__failure __msg("calling kernel function")
+__success
 int BPF_PROG(task_kfunc_raw_tp)
 {
 	task_kfunc_load_test();
@@ -86,7 +86,7 @@ static void cgrp_kfunc_load_test(void)
 }
 
 SEC("raw_tp")
-__failure __msg("calling kernel function")
+__success
 int BPF_PROG(cgrp_kfunc_raw_tp)
 {
 	cgrp_kfunc_load_test();
@@ -138,7 +138,7 @@ static void cpumask_kfunc_load_test(void)
 }
 
 SEC("raw_tp")
-__failure __msg("calling kernel function")
+__success
 int BPF_PROG(cpumask_kfunc_raw_tp)
 {
 	cpumask_kfunc_load_test();
-- 
2.47.3


