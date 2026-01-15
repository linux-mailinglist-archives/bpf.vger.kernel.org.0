Return-Path: <bpf+bounces-79063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B3D2532E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 16:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 978DF3012E92
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B293ACEE7;
	Thu, 15 Jan 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMGHb2B2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5073ACA70
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489921; cv=none; b=jNTOhf7Gz4qETQ4c+WgWcY0gKC4ij+2FBqShO+0v78BHIVQvmVMOCHyUuKrrQ9DX9fxqY2pGuVG4tHkASdRZP1X3luXl76ahT+x40VsYaIi087pwok8S1sFlstuVQKj0GT4HMzhT7spFYrDCh9EaNpCwl4LEItXNXqnrKC/w/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489921; c=relaxed/simple;
	bh=iWDKGT4wOEMiEtjG45iGnZaMq4lerKHJSxh5PIwvWMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWl1SbFprUmDuKcLZIJuI06BgJXeAwYahd10pl5HW4QaPizynmclInBK8FR38OInvHLVoC+/8VpMY6Gq4W31WaF2ybp0Tv9OwKAsKk46STyyu4uRV7zE19IFQnhR+8h+C/cMQc6vtipZMOkXzDJ/Q1ataOftSWAnGhetZRKmBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMGHb2B2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191F6C116D0;
	Thu, 15 Jan 2026 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768489920;
	bh=iWDKGT4wOEMiEtjG45iGnZaMq4lerKHJSxh5PIwvWMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMGHb2B2m33veDdmVDt623ecGX6zBep9nRljZN6VV0xv546CEEeFmoNLB8VOHnVdd
	 xCvdLYU7jpi69wG+Ii2mO7CcO035fU/8Urqe+ygAW00fMIoj8HLVUEuTtXJluMcVSo
	 VEVfBZvuVFYYsvBrvi3S6F2xfWg7PlM965tvTsbbcMQv8WnK/Lbno6dfLWmlnLY8M+
	 udavEoQlikM+sByqy5lyYI2CKxiYqGpFxPVeVIKRresDs32QgYStkFgAhl5tOq8BPe
	 6371u43PD0BCTjuD02XuzegUxB2IFZvdGmW0ZRwljSVgGCBU9LDjA5/MVqKrH97EnZ
	 P/hWca/69t/OA==
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
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests: bpf: Add test for multiple syncs from linked register
Date: Thu, 15 Jan 2026 07:11:41 -0800
Message-ID: <20260115151143.1344724-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115151143.1344724-1-puranjay@kernel.org>
References: <20260115151143.1344724-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the last commit, sync_linked_regs() corrupted the register whose
bounds are being updated by copying known_reg's id to it. The ids are
the same in value but known_reg has the BPF_ADD_CONST flag which is
wrongly copied to reg.

This later causes issues when creating new links to this reg.
assign_scalar_id_before_mov() sees this BPF_ADD_CONST and gives a new id
to this register and breaks the old links. This is exposed by the added
selftest.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../bpf/progs/verifier_linked_scalars.c       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 8f755d2464cf..5f41bbb730a7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -31,4 +31,37 @@ l1:						\
 "	::: __clobber_all);
 }
 
+/*
+ * Test that sync_linked_regs() preserves register IDs.
+ *
+ * The sync_linked_regs() function copies bounds from known_reg to linked
+ * registers. When doing so, it must preserve each register's original id
+ * to allow subsequent syncs from the same source to work correctly.
+ *
+ */
+SEC("socket")
+__success
+__naked void sync_linked_regs_preserves_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r0 &= 0xff;	/* r0 in [0, 255] */			\
+	r1 = r0;	/* r0, r1 linked with id 1 */		\
+	r1 += 4;	/* r1 has id=1 and off=4 in [4, 259] */ \
+	if r1 < 10 goto l0_%=;					\
+	/* r1 in [10, 259], r0 synced to [6, 255] */		\
+	r2 = r0;	/* r2 has id=1 and in [6, 255] */	\
+	if r1 < 14 goto l0_%=;					\
+	/* r1 in [14, 259], r0 synced to [10, 255] */		\
+	if r0 >= 10 goto l0_%=;					\
+	/* Never executed */					\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


