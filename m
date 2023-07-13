Return-Path: <bpf+bounces-4900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ACC751658
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8801C21247
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75904EC4;
	Thu, 13 Jul 2023 02:32:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515987C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:32:58 +0000 (UTC)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C389E
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b9d80e33fbso1770115ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215576; x=1691807576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY7lUvZfaRDtuXJ10+Y5Ag203FYD7K70sHWae4tiFEw=;
        b=phINwnN/NbLSkOQcHpLXZVRHTl7FbyMj/fdXybnmZF6KV3YUrl/t2MmRqNuBHKOZKk
         hHb9SmrfHfoUoXODGxIlQz7lbj0a1aMh/CRFs6wf/lo/frFs3G10+BzVwP2hcDfr2VGe
         4poueWKTu6eA6GE5mp/TjImLofLKQlXUVRikuqxUyQILyRS6f9sbmjM47DR6MRFnUwtu
         UaGfsJuZblcr9QElYQWkh8PuW2+1JupMOka3blEq1ZwNBjxohokn7lHwCXwHnnYvj4mk
         RRVbjEenXuRZVObLGX0f70q3HP6RrkzkOd7oZREt3f5XBvGxicMJ4vOdXpP0+d1HUi5S
         6Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215576; x=1691807576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY7lUvZfaRDtuXJ10+Y5Ag203FYD7K70sHWae4tiFEw=;
        b=gjrqPIxoHIoLST8f0Xn9EHLnUF7sx4p0LALLoSRtLvCOKX1BnmcR10iExIOJaxU1rX
         Ba4A7qKNCCx2/TB4M4jM2qB90kh3p5xdi38fiq9v0IZyb+M6yv+qgpUaLxXkrfc25D1y
         Ky9AwQFLGEIM/iGcCyOOEnQ+TCr8EJ3oLTdq5CL7HF+aoGSTmEaSgI9gyQ7SVBRK+wfL
         vF1q7on64TApC96mo2IbRgSZbabeDTUHkRp5XNRIXJDC8MZefVNa0x2pdDRsKOiez7ge
         shrv9p3xmVBPVFxqVx5tbZkikenVHBLNucS/KyfZEKdH6ca4ojArThQZKtI07uo0hVxy
         H6LA==
X-Gm-Message-State: ABy/qLZHkjqMKXx60CZYnOTdM3Qz5px7nM8Tr5YlTnDWxwF4FxVSnhj9
	B9V5iqquP2hUni1BpS9ePpMoPrXX9WPH1Q==
X-Google-Smtp-Source: APBJJlGA+lRmbi6jgTZM5w0ivRxRsut6HqOD2L0XaEat/sE5LpLbU5oRPdYFRjuFxF+HwJZfv1nOWA==
X-Received: by 2002:a17:902:b286:b0:1b8:6b17:9093 with SMTP id u6-20020a170902b28600b001b86b179093mr273627plr.1.1689215575965;
        Wed, 12 Jul 2023 19:32:55 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b9d335223csm4677911pld.26.2023.07.12.19.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:32:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 05/10] arch/x86: Implement arch_bpf_stack_walk
Date: Thu, 13 Jul 2023 08:02:27 +0530
Message-Id: <20230713023232.1411523-6-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3278; i=memxor@gmail.com; h=from:subject; bh=VQRkAequmejclqTBjBYFceDyxm5b49BZNtvPyADp8Z4=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HHHhg73JaWPy6I3dqWEctAFf/S2Njo8RgVN IuHAA9ku+KJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hxwAKCRBM4MiGSL8R yto1D/40QYxEos/ZxESSSmhKtXqUXsTeJaS0oGCLEqGilQlZyFdHel0/Noq/bc3jYrZtwNG4UNi ufAJlnzPkP9SuIMFa19VWZWPtHJoMiFHdWDHqmGkA6h9buqF6XN43c1I5YpYSNyVhRnRIN3iKMO w+BjZ7xUZg1/xOZIpwryfEWembTJ7E4tYlqSFF3P/f27oR8ZPP65szF73qPGfgseWCOkp0LAEns qRQzkTUtpp2sbMP2MfnCzUtKS8AKNgcWtaKcWip9/0DXeMDt93JyqPMOeq/GbBgMHJ44R/gw7Gd TAfCWWtUmZyBb+mpGMdCAnv53+wyvftbCthT5VC8v8EfH9R6uLVksIkssk8+deuIojEQrN5SIJe mvjAurrrBtDms7eaFlZXYz2uDL7bXp96io8Xp+p85Ozz4BNDP2f3wD0cYUUoVu0tz6osN62f1VB o3hrD9WIMJZI4S061eVtcVhPEBoGQi2lq3SiWLpJrANrvDAquAd1yR/sJHa40J9VDMtlCfVCBDp SwMP3Dhak2NcssqRc9NllV1mYGP6QMykfjFo5X/SNx7QSMTnC06OpbEqubj0Ra3dD08BWovoeRf a4lAcz5zSOjupmg+zaZrKmkfTYD0+N74jL/Xf77ulmUWeWgrtqGqzuvU5bNQPsZLDOIHO0hugS5 gOH1pfCm1/UNwXQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The plumbing for offline unwinding when we throw an exception in
programs would require walking the stack, hence introduce a new
arch_bpf_stack_walk function. This is provided when the JIT supports
exceptions, i.e. bpf_jit_supports_exceptions is true. The arch-specific
code is really minimal, hence it should straightforward to extend this
support to other architectures as well, as it reuses the logic of
arch_stack_walk, but allowing access to unwind_state data.

Once the stack pointer and frame pointer are known for the main subprog
during the unwinding, we know the stack layout and location of any
callee-saved registers which must be restored before we return back to
the kernel.

This handling will be added in the next patch.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 21 +++++++++++++++++++++
 include/linux/filter.h      |  2 ++
 kernel/bpf/core.c           |  9 +++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 438adb695daa..d326503ce242 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -16,6 +16,7 @@
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
+#include <asm/unwind.h>
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
@@ -2660,3 +2661,23 @@ void bpf_jit_free(struct bpf_prog *prog)
 
 	bpf_prog_unlock_free(prog);
 }
+
+bool bpf_jit_supports_exceptions(void)
+{
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
+#endif
+}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f69114083ec7..21ac801330bb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -920,6 +920,8 @@ bool bpf_jit_needs_zext(void);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
+bool bpf_jit_supports_exceptions(void);
+void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5c484b2bc3d6..5e224cf0ec27 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2770,6 +2770,15 @@ int __weak bpf_arch_text_invalidate(void *dst, size_t len)
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
2.40.1


