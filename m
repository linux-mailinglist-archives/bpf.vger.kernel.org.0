Return-Path: <bpf+bounces-78618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51657D152E0
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CB63068BD1
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B0F326D70;
	Mon, 12 Jan 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwIpGCGJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3532ED30
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248883; cv=none; b=MyHN//lKN0z7liz+h7wSo5KtwQCI8ulw7LwEpORduS9FN8fBuini5BZ/FAhN0K0ip81nDaVenROEqfweFo3ur+WKV96kfAxMmIFGNnLN++6m7io0U1QQACrbahNqeIIyQ0r1FvZGXLf7eBXIqdUoI+d7jmyecBFIggezwkrghgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248883; c=relaxed/simple;
	bh=7cApDmQnrj5Q33R73DgQX8gAq7qFFzafo1wJeSyEp+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtQ+8goV6FXbK35gIiz+lWcyka/msOuvzC1CsGSvsCySEp/ok6gJkQZ5IG5ds8ASiEJgqUTXey7QNGsj6GAK/IUsKCnvDOu0rjffox56f8/ld+3DKrYGlpzKEAFSVsq5crGDiIWvV8mrIQBXnrbcviJQBYI9LGC1tboYitQ8XDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwIpGCGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43D5C16AAE;
	Mon, 12 Jan 2026 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768248883;
	bh=7cApDmQnrj5Q33R73DgQX8gAq7qFFzafo1wJeSyEp+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwIpGCGJfQ0SUQfCi5IobOVETXEzAqw4uvxdXgZ7tT2wqJPLGYUkvSGUxLKgo6kKo
	 sey9IirjM43dhx1b2svUm4WQ/nF6WR7SNoyqHmb7/WOpOuvXAj5LED29Vy5sNUcuxa
	 ceahdYghieAs+28KgHYd8TKfvZdAr6rJspCNKt6B1j4Rhi1+1NxSFclydt4jJVyU21
	 o+MkEn6y9q6k8BUFYYl/UTk4kZoLm7S+smvrjz9Q6CePLG1Eyfz0EGudcCPffOhMQe
	 eVD4/dY9w3YyYXLETJxYoKgqIca/2TdvM1TA5ATp6rPGLnLXmuhB+Iw7CkIsj3j3Kr
	 Ttv9XjTuY2Lpg==
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
	kernel-team@meta.com,
	sunhao.th@gmail.com
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
Date: Mon, 12 Jan 2026 12:13:58 -0800
Message-ID: <20260112201424.816836-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112201424.816836-1-puranjay@kernel.org>
References: <20260112201424.816836-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add tests for special arithmetic shift right.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Co-developed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/progs/verifier_subreg.c     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index b3e1c3eef9ae..be328100ba53 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -738,4 +738,89 @@ __naked void ldx_w_zero_extend_check(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success __success_unpriv __retval(0)
+__naked void arsh_31_and(void)
+{
+	/* Below is what LLVM generates in cilium's bpf_wiregard.o */
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w2 = w0;					\
+	w2 s>>= 31;					\
+	w2 &= -134; /* w2 becomes 0 or -134 */		\
+	if w2 s> -1 goto +2;				\
+	/* Branch always taken because w2 = -134 */	\
+	if w2 != -136 goto +1;				\
+	w0 /= 0;					\
+	w0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __success_unpriv __retval(0)
+__naked void arsh_63_and(void)
+{
+	/* Copy of arsh_31 with s/w/r/ */
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	r2 <<= 32;					\
+	r2 s>>= 63;					\
+	r2 &= -134;					\
+	if r2 s> -1 goto +2;				\
+	/* Branch always taken because w2 = -134 */	\
+	if r2 != -136 goto +1;				\
+	r0 /= 0;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __success_unpriv __retval(0)
+__naked void arsh_31_or(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w2 = w0;					\
+	w2 s>>= 31;					\
+	w2 |= 134; /* w2 becomes -1 or 134 */		\
+	if w2 s> -1 goto +2;				\
+	/* Branch always taken because w2 = -1 */	\
+	if w2 == -1 goto +1;				\
+	w0 /= 0;					\
+	w0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __success_unpriv __retval(0)
+__naked void arsh_63_or(void)
+{
+	/* Copy of arsh_31 with s/w/r/ */
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	r2 <<= 32;					\
+	r2 s>>= 63;					\
+	r2 |= 134; /* r2 becomes -1 or 134 */		\
+	if r2 s> -1 goto +2;				\
+	/* Branch always taken because w2 = -1 */	\
+	if r2 == -1 goto +1;				\
+	r0 /= 0;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


