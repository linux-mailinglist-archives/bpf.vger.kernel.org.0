Return-Path: <bpf+bounces-77729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F020CCEFA3E
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 03:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29D7301C962
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8411F4190;
	Sat,  3 Jan 2026 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri+TV6A0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C71E9906
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767407053; cv=none; b=odXWjCyvkxp/uZHpMq4VulBu9+nOmRCrVms2a8KAF3ctR5W7nrVdkd2POdbVhXZAEAcPDBPx0jgventSIz84Gd47i/2iAf+mONIRQpNIBS5bP9wBBFvkvQ8NPH7Rfz/Xqu4PuHsBiTq999n8CK9T7UYj16eExq93YhLOCN2gHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767407053; c=relaxed/simple;
	bh=K39+sMLnvMlYdI7ySZwN5bVP6/Ab7kc0QdDrfvnNy4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVDPHeFFNrN9vRvivY8F5CTwPWX0JJAV1T6apLgT5Xx0Cu++KS+XXkcul7+WReiRnazbOp9AFiszvpBN0RyDprFv4aawV3oL/VYY0IhxnG/TGVmCYxYCYwlww9lUvp4lTGL4Quetu05f7FXvn/M2qe9b2azot9229bDSuRdIfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri+TV6A0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72823C116B1;
	Sat,  3 Jan 2026 02:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767407052;
	bh=K39+sMLnvMlYdI7ySZwN5bVP6/Ab7kc0QdDrfvnNy4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ri+TV6A01/UJAc7lxjaorGerczfY0BeeyeZBnmIZGOAdaxoJQwLJjtdgxjJoP5N4B
	 7Qzn9GU0PL+Upo/6YolLATMSJdJZITjI7wfPm9ovIISszuAzMQzXDRsQzWCrty3nAg
	 ZpErpxb/29qj+PpzFTmu69v3ptIkMORHZlXePPzFAsFK3k22KJGs9uaMz68dXxsLxt
	 yD6Swl63vmwXx3EvsA1zSZyhp17mohOaXrCDanVOVdAPvMIjhVut4W2U4XR4IuiS1u
	 eAHaJ9wrR7OOVhlAGKgKcJb5hV+BmAKIFWI+faD61aTK/jBoifKE4DyaLp62p5GYH+
	 zJmrf4PA8yVQQ==
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
Date: Fri,  2 Jan 2026 18:23:07 -0800
Message-ID: <20260103022310.935686-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260103022310.935686-1-puranjay@kernel.org>
References: <20260103022310.935686-1-puranjay@kernel.org>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/progs/verifier_subreg.c     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index b3e1c3eef9ae..531674f907fb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -738,4 +738,49 @@ __naked void ldx_w_zero_extend_check(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("s>>=31")
+__success __success_unpriv __retval(0)
+__naked void arsh_31(void)
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
+__description("s>>=63")
+__success __success_unpriv __retval(0)
+__naked void arsh_63(void)
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
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


