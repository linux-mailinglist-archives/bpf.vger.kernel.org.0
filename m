Return-Path: <bpf+bounces-54086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C512EA62412
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 02:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB86422690
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E17186E54;
	Sat, 15 Mar 2025 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh/HktVc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288317BB16
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742002245; cv=none; b=agJiuTW10sZZzSgmZLAOQof5m6WIPomeiCMWrrw1NdLWA/+cOOkD8G5FOIsv+XH7gJEdZtxTApptNhYrkXpUyNeVWYlTW3+lgMxQ4p+qosro5pdiYXCZO5mUN+Grue0dHC0fzFs8tXIs2xCjCCjdV2fUA2f1mUtQW+qWqtWsNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742002245; c=relaxed/simple;
	bh=MSVve8x8Hfew+C/jUSI4xb971pA7HyshxzFcHAytYHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHIUnpAkV2MvLRtCgW+rX9Nqy9y/Mf9KbHLJSpm7Z6KTOEe/ceWeDJvOf9DZ0/rHzwYsq7MYRpH/ue2RWuELbICop9BOnwD0/smFUawNKL+EvArfbWEt389HSYaFjaIli+moOItAdk/aWHUqlpU/UfRdi0qFIMpRG2xVcQWCdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh/HktVc; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39133f709f5so1633872f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742002241; x=1742607041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdi+g2EM5BRCiAz+qGNzk40ypE1Pesivf58yYblvhUM=;
        b=Eh/HktVcOBRJ2OWF3mQqEJsH1BPa5pknKFG8Qh/uml4PsPSVlmDkgcChmL9uNdVSda
         34FHOs/qY3arW0NRmg6MML0eShA0ux/u3J123Kky+o1Yv39nDmB7N1esfg5wDhJiOzc+
         eufr56RXA1jear6Zsxvu5uyO/iGZYHTHUTaU6JTIgH37ln3mWY2kXN8dt5MGkCv6hw6N
         HuQVCC9LMcWBdod5boFBNeOPlOhMd71KI5gshC0P2+1oZT8tUikY9mdSX2pe2Fd9EZDz
         htBE3dMRheOMtGaLRRaPpFm/tY0XW8bAk+xzm5776VAhNw/nIQbu2xpdaDhz8SyQe8/D
         uYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742002241; x=1742607041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdi+g2EM5BRCiAz+qGNzk40ypE1Pesivf58yYblvhUM=;
        b=Hw+EmcGu4TDCN+VBZU1r0AHzAQ8FJkw4pbQk12D24+xR86ww2s53T8B/rJ7y/a5oHa
         iyaDxx+px5Dr55iPSTnwwcV7HINqqOj2d1JK6OIhL/fQnPrv3j/4Ykx4uLbvJf6iwFc0
         jokSbL0y+fNDUsOQYPUmIsaEP52+5Yiag8w/spNktq5zG+wDs2yhzVEUjVtBN0dtRyCT
         cohyQ3PHnfW/Bcla+jiZx5spYPwdTQ4bE7ggLF+8kQ83xLJY5nLFIcMLI2yK/oHra31b
         1Z0UYLITwRhy/o4Hg+LAzywmVqkSFyO8+04SgH9xpf3GtKHOwzi+MMUP2q+vdqoc2eCG
         f0dA==
X-Gm-Message-State: AOJu0YyD1XSLY2VRDqsT9+OtOD+efBZdbgTsBSzsrwgrXgBe8w2rgwGi
	buRQekuykNJiWTT16a4/zKkJ8PpRRqeHq2RjTmgsB9CJg+4LQw62RKNvkM0ED8w=
X-Gm-Gg: ASbGncvo+lRHzJFDv3pQUjAYhtkZG+V1KGIS727PQMYzi6HsZiqgUwz23XCdrk/xDnF
	vfLeuR49R1i49Oeob1MTpA5sDayDSPSOnWbLG5RVxyMUPoAWYenULGfjevS78b42blm/Ru2DsSP
	997WxdxWl59RPNnGHEgWA+pZdnttSW8P2rDPTIHeg1dVxRHYP+u3UmkU8Y55MzKkOe6NntBBMzl
	Nn8yJq19JcNK2TGo2QrcWocKYrIEnj/SI9tnXqXAvzxfvIZJLcj0qHuGn5CKT8Epa7p6J0GIOE/
	6HMuZKuyFcTqcwMR4W3ZuNfGuGEynCc=
X-Google-Smtp-Source: AGHT+IEqhjCLqIs6k2ITiiAUnxXdprn3yi352lA9pgsrkthVXi4gQdsAl0C6wHVW316hVHtim15/OA==
X-Received: by 2002:adf:a454:0:b0:391:4ca:490 with SMTP id ffacd0b85a97d-3971e3a5680mr5264919f8f.29.1742002240902;
        Fri, 14 Mar 2025 18:30:40 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35bdsm7015923f8f.5.2025.03.14.18.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 18:30:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] bpf, x86: Fix objtool warning for timed may_goto
Date: Fri, 14 Mar 2025 18:30:39 -0700
Message-ID: <20250315013039.1625048-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; h=from:subject; bh=AinKvz38NcONx+k9dTxLMVMmAsbQcJvinuOMDyvHPl8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1NgUulhB9lsA2UEGXoK/SrL2tm7juhb8u6wdM2Ql PVrjIQOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9TYFAAKCRBM4MiGSL8RyiuOEA CDaVSFboVdMkW/VzBEy+aKr42hM5fsMiNY9V6SmvuaflIIjxrrsKmkTf4pH2z+72G8elyNbieyJjkq GU6CBzwyYw6yfSOmEC55MiZuOmtyLn9tpWoaWhVlRidDNEyWi7Ydt6h2C5qmI9FGdqLipTkoSaa2wV J97J52QLq73Y40L8gn4sF8zRt2raGDNGxxrNX4MXDlMUvN/N7aMEr7vLOe5/dVhLS2wV6BrzQ5W8kX 9ptmAMe+s+LECdl13gqmzzDI9Cd6GgfnJ+LTzCsYLp4mV5H+o2wjS6CrOCAhgmUKSfEQcaVTGmFot+ mjPS00V8bmLedzjL+0+nZYkBVX/IXG8+osaOxxFB3RorGVPpcDPlcCzDgqBdx8KsbGSPOS5kzuzFIU TVSVBC54AYLVZqh7AZdwxLY1Ch/MmGCJbJNSK4UeqtzyB4/uRIZs/1fqn3rZuKyFuftu2z7fdy9oIB uIvA12yvxDvZicUJnMtHzKhVB/kYjJ4dFSnGPrFiI3bQcHwbbplfE2KChIUL1K2eXEEecgp+1+6mNX rjNBpuaYl5RTxyTav/QQaoLvx8JM9Fb6HjHlGzFWtnftJkL2ComT0YSsDC0C2T58Bs86vpOQQ7gMSg 1TFM+7jzyVFNls4XDIsiOTlvFRzytWwpRKlRnezcWW4xvrKidlN7uGAiaMdA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Kernel test robot reported "call without frame pointer save/setup"
warning in objtool. This will make stack traces unreliable on
CONFIG_UNWINDER_FRAME_POINTER=y, however it works on
CONFIG_UNWINDER_ORC=y. Fix this by creating a stack frame for the
function.

Fixes: 2cb0a5215274 ("bpf, x86: Add x86 JIT support for timed may_goto")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503071350.QOhsHVaW-lkp@intel.com/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_timed_may_goto.S | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
index 20de4a14dc4c..54c690cae190 100644
--- a/arch/x86/net/bpf_timed_may_goto.S
+++ b/arch/x86/net/bpf_timed_may_goto.S
@@ -11,6 +11,16 @@
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	ANNOTATE_NOENDBR

+	/*
+	 * r10 passes us stack depth, load the pointer to count and timestamp
+	 * into r10 by adding it to BPF frame pointer.
+	 */
+	leaq (%rbp, %r10, 1), %r10
+
+	/* Setup frame. */
+	pushq %rbp
+	movq %rsp, %rbp
+
 	/* Save r0-r5. */
 	pushq %rax
 	pushq %rdi
@@ -20,10 +30,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	pushq %r8

 	/*
-	 * r10 passes us stack depth, load the pointer to count and timestamp as
-	 * first argument to the call below.
+	 * r10 has the pointer to count and timestamp, pass it as first
+	 * argument.
 	 */
-	leaq (%rbp, %r10, 1), %rdi
+	movq %r10, %rdi

 	/* Emit call depth accounting for call below. */
 	CALL_DEPTH_ACCOUNT
@@ -40,5 +50,6 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	popq %rdi
 	popq %rax

+	leave
 	RET
 SYM_FUNC_END(arch_bpf_timed_may_goto)
--
2.47.1


