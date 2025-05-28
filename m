Return-Path: <bpf+bounces-59102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16FAC6064
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274D51BC328C
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4D1F0E34;
	Wed, 28 May 2025 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXZ2g+VE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5021A95D;
	Wed, 28 May 2025 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404206; cv=none; b=BQ9Rz1L4MLc7UP8plny7HAiZriQTnCJQKt2vLRBW6M15CKC41WR3uhLv8zqdVHzilTBggGt4teAk9TiE/WgmSrzHQvkHxW+VpW/x9FsZzH8AIaBHT1qO2plt6sSsF8ss2P2rrJBc91JJCezOapjcQsPiVM2TH5pFC0Mp9CpOzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404206; c=relaxed/simple;
	bh=3+KAGe0mMKvHWbDVS0yeauVnAfqDNvt543iPPCKcClE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtMvdUbmxfiGx58QK5Pc0HNSCIDYktq7pTMdQqzN/Unbt4yI2ScXHAHUMFxwS7XFPRlHFVaRBmaLcgelS7ekRYXnF3qoFu06Sfxr4wBDH/bAGoon3wePwphlOVEqge59OdNavbuy4XPnwBts5LZeQ/4gxZ1V7RSDu2OwNvOP4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXZ2g+VE; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-234ade5a819so11270205ad.1;
        Tue, 27 May 2025 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404204; x=1749009004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AN7saxVdEQOZ24jtiS71Z11sBzLh/We020pOkc7UII=;
        b=XXZ2g+VEFzqp0pnYOxZjzwe6ct9wMDfdr9Ik8fn07GC9NPiAjZrnqQdMRMLZa5T7dp
         PcBkMqLbJxNxkoZ/VDKqbDMeh/SXGYfrJ40wKD+5Zx5rwBrv8cyd1+dyTTJgLHks71OC
         RME/R+dYepZW2WOFi2bhWFZQ3FETDLeZxYI62BKFmw22fpRpk+g4wrTZz/eR5XmHnbIp
         7pkhCMixv+1/GodCoe8tKd2yCvYjIlrvyKzorYHCUVDK3/JxYIu0WWLxpj1GUN5vgWwZ
         X0XvnIuQFvh24kLkyymheDX38EcV/dtFQYgIY/PTxfCYirMVbwb7mtBrnyXKKHp+sHwh
         piEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404204; x=1749009004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AN7saxVdEQOZ24jtiS71Z11sBzLh/We020pOkc7UII=;
        b=nHX/FBZpJuCvzG+Hrrw4F+HY+97AM1OnDdvBpWCfS0K3fMQnRHCIvX+1jiDD5IhtWV
         5qo2i5zz/mfHMuogx0f5oGzHJ9hHiuoSS5qoSZPiGOA59nvvqMz4j8rnoBcGI6lwG8Bt
         kux3KGqcPg5nr4I5A4lH3gwQJzugiBYNxE5Xut2HFiBO7/2ct3wi5YpjbRJkV6CnPJD5
         byZInVpuD52gagr7K0V3Sxiq0TIE13cYtIClN9A7hjMJH8d2daim8ZRnggXoSjq/IjIJ
         FYZB+sWjTmE5WjvhlsZw2ZwfB4GURYxLBdVGMTSgO+TuTrGZpXWZL7jkechaRIORSsXN
         kZNw==
X-Forwarded-Encrypted: i=1; AJvYcCW+ewUNqneKWGkNG0znThPT8IXca7MuyiH758X+WptgT621kPo3W0c5zQZbdhyBqiVqEbP+nDMZFtllFn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoFVDDc20ODeHEnOBmBTFfmnB13LNRK3AX9cV4UOfj6S0kYDC
	37oNyOwELMqRS+nWMiBMe7xbFI6iuyNMxOGaHmW3e4K7rGkcJ++qekTj
X-Gm-Gg: ASbGnctU6UrOHzKiXZfon89E9Ui5H4p2Y7kQ82AaYTkCVWrNt3npnpKHDCWv3kNcj0d
	V7QW/CjsQmrDGdjikUSs5a7DebeCb9d8guMVnXOlqGXtt8VQmUZUsoDDgagkwXY7ab+afvaNbE7
	PjhBLxI0LxD8WehUAryLLDA8XEQjEvEcizDfUqLjNvVaxc2oiCJEMblK/oPfBADLQJm0QMNfs9A
	qSMvAiPL31xr9IuWo3dUB9NJRtki/cmP2KRnaQrHxgnZi4PxdLcjGSnO3BMGol1xCINP7hlrWMZ
	3A87b2mvx+bLyoUDMPzfnQYQJW2sLl/C3M6GSj6UyhJePgozlKBSYsWok2umM/kadzsr
X-Google-Smtp-Source: AGHT+IG+E65Yzbk/55Dmvh6JNx45fYvnIXnjlLRmlCxJdxBJ3L66qt+G/U2TIaq1ic9zNbrT29lP4w==
X-Received: by 2002:a17:903:2290:b0:234:d7b2:2ab9 with SMTP id d9443c01a7336-234d7b22ca6mr1525905ad.12.1748404204531;
        Tue, 27 May 2025 20:50:04 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:04 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 13/25] x86,bpf: factor out __arch_get_bpf_regs_nr
Date: Wed, 28 May 2025 11:47:00 +0800
Message-Id: <20250528034712.138701-14-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the function __arch_get_bpf_regs_nr() to get the regs count that
used by the function args.

The arch_get_bpf_regs_nr() will return -ENOTSUPP if the regs is not enough
to hold the function args.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++++++-------
 include/linux/bpf.h         |  1 +
 kernel/bpf/verifier.c       |  5 +++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9e5fe2ba858f..84bb668f3bee 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2945,6 +2945,33 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	return 0;
 }
 
+static int __arch_bpf_get_regs_nr(const struct btf_func_model *m)
+{
+	int nr_regs = m->nr_args;
+
+	/* extra registers for struct arguments */
+	for (int i = 0; i < m->nr_args; i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
+	}
+
+	return nr_regs;
+}
+
+int arch_bpf_get_regs_nr(const struct btf_func_model *m)
+{
+	int nr_regs = __arch_bpf_get_regs_nr(m);
+
+	/* The maximum number of registers that can be used to pass
+	 * arguments is 6. If the number of registers exceeds this,
+	 * return -ENOTSUPP.
+	 */
+	if (nr_regs > 6)
+		return -EOPNOTSUPP;
+
+	return nr_regs;
+}
+
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
 	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
@@ -3015,7 +3042,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 struct bpf_tramp_links *tlinks,
 					 void *func_addr)
 {
-	int i, ret, nr_regs = m->nr_args, stack_size = 0;
+	int i, ret, nr_regs, stack_size = 0;
 	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
@@ -3033,15 +3060,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
 		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
 
-	/* extra registers for struct arguments */
-	for (i = 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
-	}
-
 	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
 	 * are passed through regs, the remains are through stack.
 	 */
+	nr_regs = __arch_bpf_get_regs_nr(m);
 	if (nr_regs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c35da9d91125..080bb966d026 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1221,6 +1221,7 @@ void arch_free_bpf_trampoline(void *image, unsigned int size);
 int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr);
+int arch_bpf_get_regs_nr(const struct btf_func_model *m);
 
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d2e70425c1d..9c4e29bc98c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22901,6 +22901,11 @@ static int do_check_main(struct bpf_verifier_env *env)
 }
 
 
+int __weak arch_bpf_get_regs_nr(const struct btf_func_model *m)
+{
+	return -ENODEV;
+}
+
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	int i;
-- 
2.39.5


