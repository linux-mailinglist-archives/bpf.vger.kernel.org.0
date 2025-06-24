Return-Path: <bpf+bounces-61465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F80AE734B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 01:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450E93AE72E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64326B2DC;
	Tue, 24 Jun 2025 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMS2nKvX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B225D20D
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808021; cv=none; b=eN4XFJ0f9uvvH6Xl4Sy66B2jh8z4Iz6bQSbo9aU0p+nL5qAD7DR/v1Y4g8bGQBhtveE167jp3VcZrkmk9j+Qdfd7JssqBhsY9a5bOgCp2ky54zPwvLbYDRSqiwWBczHzXk0/c6BU6KqiOXOpnu1YNheWoZCxI1q5H0hyR2+DCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808021; c=relaxed/simple;
	bh=wiyXjFCr0vzH3k0goxeMxAlFdoQ0auzW5PJZxNpJEIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njvDnA2EfqUVtu5VnoorSpp+L0Y6P5lbrnpLJAAQel2WvVnsCcrwEzZvAEN1otLHXKhyDZKQ9d5ezng2MCgFLNaSLTMw7/qNMYT/QauKPbQZ+nI4F5Y3sKAz1D2LkN9wZ4nbdTSLV/LM27sLiIYKfx+PaxqhIUgY/gLycPben40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMS2nKvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F060C4CEE3;
	Tue, 24 Jun 2025 23:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808020;
	bh=wiyXjFCr0vzH3k0goxeMxAlFdoQ0auzW5PJZxNpJEIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMS2nKvXwIyZ7V/iuM6NVXj9OO5GMyuZfXl8pl/J/scOH/5HntlbWjhU7d0CVI5sK
	 +pEmKNSRN5fLZExPIeGeG53ACFtWFNJr3jXJR89QqA6qWvGeyRF5STfHoet66v6uM6
	 MqXS7LAi06ZSv3+lCRVhpSMeeuyYLZEJlvnwv5PCzMHxjxcmdkfd5Ae9oOmoI0fGfW
	 B58N+OGxUh/0AzWGy0oMCGxeR6HKUcxemnOVNacisnCYFyBFB/pxGEIHfsSiHapoBM
	 SswZ/biLG5n8AqjjDaFquR5YyNjgHM0aBoeYcWqbDQlNpcaOqB62nJ0WHrXy+LfGoh
	 yZcwBr2mvDaRw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Add tests for BPF_NEG range tracking logic
Date: Tue, 24 Jun 2025 16:33:28 -0700
Message-ID: <20250624233328.313573-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624233328.313573-1-song@kernel.org>
References: <20250624233328.313573-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_REG now has range tracking logic. Add selftests for BPF_NEG.
Specifically, return value of LSM hook lsm.s/socket_connect is used to
show that the verifer tracks BPF_NEG(1) falls in the [-4095, 0] range;
while BPF_NEG(100000) does not fall in that range.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/progs/verifier_precision.c  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 9fe5d255ee37..73fee2aec698 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -231,4 +231,74 @@ __naked void bpf_cond_op_not_r10(void)
 	::: __clobber_all);
 }
 
+SEC("lsm.s/socket_connect")
+__success __log_level(2)
+__msg("0: (b7) r0 = 1                        ; R0_w=1")
+__msg("1: (84) w0 = -w0                      ; R0_w=0xffffffff")
+__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 1: (84) w0 = -w0")
+__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
+__naked int bpf_neg_2(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -1 is allowed
+	 */
+	asm volatile (
+	"r0 = 1;"
+	"w0 = -w0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm.s/socket_connect")
+__failure __msg("At program exit the register R0 has")
+__naked int bpf_neg_3(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -10000 is not allowed.
+	 */
+	asm volatile (
+	"r0 = 10000;"
+	"w0 = -w0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm.s/socket_connect")
+__success __log_level(2)
+__msg("0: (b7) r0 = 1                        ; R0_w=1")
+__msg("1: (87) r0 = -r0                      ; R0_w=-1")
+__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 1: (87) r0 = -r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
+__naked int bpf_neg_4(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -1 is allowed
+	 */
+	asm volatile (
+	"r0 = 1;"
+	"r0 = -r0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm.s/socket_connect")
+__failure __msg("At program exit the register R0 has")
+__naked int bpf_neg_5(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -10000 is not allowed.
+	 */
+	asm volatile (
+	"r0 = 10000;"
+	"r0 = -r0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


