Return-Path: <bpf+bounces-9826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F1079DCAA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8731C21433
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708213AFE;
	Tue, 12 Sep 2023 23:32:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561B17C2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:20 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8110FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-50078e52537so10500709e87.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561538; x=1695166338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQyCKvejR05FLvij5SV3MltntkSCOrFj//tSa1rbDlg=;
        b=T+1C/U4aC5a2DAeYtkTGZqY9j2Vpj5P8dxOaLsa/dj+IW/vIFRKi2JIg8vmcIalaHk
         Tezw8RA6n+uc7f2Usm8k2BDQaKFpuQKtfuoREfVQ8WvDFdY1UthMALiPWSmRujrIlr2J
         eh5VWYWgh32aHLpQf6kzcTn8XYlihglwsDqYVBbUNmVtYED1Wiel5Z19Vy+kA8tqLlDW
         dUCm/QKaa7cSEpUEA9Ikarc3B2wVCgEMJtxskSt7i9GbwPekKZVBk0wfdEBSPd5pWCV/
         9e5GgTgEiKA+ePDMLCU7In8y5tnf0Pa72vgoepUS531yICn9AKqxsgZTSjgc4suLhljH
         oMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561538; x=1695166338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQyCKvejR05FLvij5SV3MltntkSCOrFj//tSa1rbDlg=;
        b=j4QKA1CVu+DCG8q+VR2g6TgDCVm5zvSknfyGrLyceVZR8fTrEzzOscIuUyu/h1vgr7
         xrlcAEpS0CImjoNDyQ+QY3XnHHReySFcjuYU/NG6fSeg+ULUuSzKn2ULWPUh2j8eUQKP
         yoUp0JPin1piovs0Fs2UPJEDvYi3dIVf+dIXadmlmF0IXnTf3XxYa9SAMUtXa8IeaEF/
         BjbDXcC3waNG2jiacQuHB6gGhge/fds+Ecj1hrnyKCOL2NQdFQeTMOM58uirOnO8kUU7
         aGFA8jl0o81lzomtZphHWhVEjmK53L1uXEZe+5ZqncP/bgFwg4qLn9SDQJgh41AgPIwe
         SaKw==
X-Gm-Message-State: AOJu0Yxhzc9+2rz3PEocrHq/2X51EQ26eLrss8Hlr7NwXqghMMNW1UYI
	l+C0QiDoVw4+8MaRiBeNmNt8G7+XG2Fn3g==
X-Google-Smtp-Source: AGHT+IGNHVA1tb1cN2M7//o9tjAvSHCrlI27ttuh+KuGqzY1Qw9dzoC+euDpX2UoA++9K5MfpGinuw==
X-Received: by 2002:a19:2d52:0:b0:4fd:d213:dfd4 with SMTP id t18-20020a192d52000000b004fdd213dfd4mr650167lft.20.1694561537503;
        Tue, 12 Sep 2023 16:32:17 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id f20-20020a170906825400b0099bc2d1429csm7460356ejx.72.2023.09.12.16.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 02/17] arch/x86: Implement arch_bpf_stack_walk
Date: Wed, 13 Sep 2023 01:31:59 +0200
Message-ID: <20230912233214.1518551-3-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040; i=memxor@gmail.com; h=from:subject; bh=sgqrFU8/IE1hJC02IhP+Kq/56a74YibDEH8nsdcFXWw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSsX9VVxxLHLIMs4BgGQ8qbLOSOKDyPbyywJ d2bm7Zw9VmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rAAKCRBM4MiGSL8R yk9sD/9tJQFU9+cn3Jdat0Jz9oQa7oy8Vym4WdieonMdqPoTsmuBXOXiYIA8eFxJYRtc+rCIrDa 0iZNErqZSMVJd3S6YrZ/THVgiuXl46htKIlBtlYuqEOFvHZoDFwYuL6+BIIdVnzQXzruxrsLKXp H8pmLuLrpVvu7KiILkDKwk4D+OLjxXDe8mWtBWi6plkpJWAoq2+9NxDZMqvG3cIZrZ6sT+Sjsg7 YIe+dPqIiuVtJrJTEhPVe5sjwwp2Z+T2Gm0Htm7C2DwxXOOsJpexyNG5t2bVaNdWnSm9LEFpN/J hqpTW9vfttlW7vMy8eEoVdFOIaeVAoqS4F3QMtwW2YIbgMnKng/AG83WNAB0hJXPvSvMnM/Lo+L D+LK5zdUwnN0S+UATx0iV+OC+Lml1xonnc4Dbmic2zsSfNuVzGQM5xHol3uKXP4UhyiDY4ybRuf xU6ycpG3rJxrHht7aEaKW++JwZX89CmA3qxjFXDrVr8wcHeuvZxIfjiKXIf5ZY6gGUkcAmd/6SA NB77Dabctx5i1pYCVSw5fW6QIvdOTgyZwTv5vpSd4rHsmQPABumU042Mf7gdoqAfN00NJF12jcY dBSytTHkTh97zExEO00b/EuTjfG9hpT7u3KaiejR+psoNXhQtXblEneAux3uBa+mXPdge+jFQXX QJ6C8GFHshSdNTw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The plumbing for offline unwinding when we throw an exception in
programs would require walking the stack, hence introduce a new
arch_bpf_stack_walk function. This is provided when the JIT supports
exceptions, i.e. bpf_jit_supports_exceptions is true. The arch-specific
code is really minimal, hence it should be straightforward to extend
this support to other architectures as well, as it reuses the logic of
arch_stack_walk, but allowing access to unwind_state data.

Once the stack pointer and frame pointer are known for the main subprog
during the unwinding, we know the stack layout and location of any
callee-saved registers which must be restored before we return back to
the kernel. This handling will be added in the subsequent patches.

Note that while we primarily unwind through BPF frames, which are
effectively CONFIG_UNWINDER_FRAME_POINTER, we still need one of this or
CONFIG_UNWINDER_ORC to be able to unwind through the bpf_throw frame
from which we begin walking the stack. We also require both sp and bp
(stack and frame pointers) from the unwind_state structure, which are
only available when one of these two options are enabled.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 28 ++++++++++++++++++++++++++++
 include/linux/filter.h      |  2 ++
 kernel/bpf/core.c           |  9 +++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a0d03503b3cb..d0c24b5a6abb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -16,6 +16,7 @@
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
+#include <asm/unwind.h>
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
@@ -2933,3 +2934,30 @@ void bpf_jit_free(struct bpf_prog *prog)
 
 	bpf_prog_unlock_free(prog);
 }
+
+bool bpf_jit_supports_exceptions(void)
+{
+	/* We unwind through both kernel frames (starting from within bpf_throw
+	 * call) and BPF frames. Therefore we require one of ORC or FP unwinder
+	 * to be enabled to walk kernel frames and reach BPF frames in the stack
+	 * trace.
+	 */
+	return IS_ENABLED(CONFIG_UNWINDER_ORC) || IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER);
+}
+
+void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
+{
+#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_POINTER)
+	struct unwind_state state;
+	unsigned long addr;
+
+	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		if (!addr || !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp))
+			break;
+	}
+	return;
+#endif
+	WARN(1, "verification of programs using bpf_throw should have failed\n");
+}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 761af6b3cf2b..9fd8f0dc4077 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -912,6 +912,8 @@ bool bpf_jit_needs_zext(void);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
+bool bpf_jit_supports_exceptions(void);
+void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 95599df82ee4..c4ac084f2767 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2914,6 +2914,15 @@ int __weak bpf_arch_text_invalidate(void *dst, size_t len)
 	return -ENOTSUPP;
 }
 
+bool __weak bpf_jit_supports_exceptions(void)
+{
+	return false;
+}
+
+void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
+{
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 static int __init bpf_global_ma_init(void)
 {
-- 
2.41.0


