Return-Path: <bpf+bounces-7334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF08775DE7
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED021C211B0
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F418008;
	Wed,  9 Aug 2023 11:41:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE317AAB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:41:39 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D771F1FDE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:41:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-52307552b03so9181438a12.0
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581296; x=1692186096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgCPWqiXQwFRSb/lWNuSAajZm2LK6U9DM3Wtj4eKKQc=;
        b=Y3m4rSCTWPn93+g3X2Bs+fktPej342y7vEpLBk8tF3gbs9jeymFpKk7kR0ROpsZ6KA
         O5zS0SAv7RSaG0+5ZC3HGf7fB+iTzYwjUPFNmauUwedZtu9IFEkHko+zlse+mALAp18t
         H+06WhAD2CUczWFb4m+xrbKYfPpSyFCjxu5KDgvDvZnARdFcAPMd2yAc6Zc48HiXRPxX
         sn3oIDdg3YjCwPeHfiBmGImvcPqLMoOUyCLT4IfaZxAa2GbJWHBolGjboN87A4nrZbA1
         xyxAmU+XpdPBqUeRYHFKH+xIe3KmPYU+Cy2FDN3y2vqHHp327dUAskjrmystFjRbqMgH
         f0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581296; x=1692186096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgCPWqiXQwFRSb/lWNuSAajZm2LK6U9DM3Wtj4eKKQc=;
        b=de3Z1n84IiBtE/No8ID8jnzzD5UEP7J0Cik33nV/nPrMLy7aHlfH6lgxevxE+6mYH+
         W6JuLD67XzSfnQidDnQi3zYefIZyQuGWbFw1y3u1LSgmKk9tOPNdGqZ8ZnI6hMeuHmTL
         oM3TrznSQ9bXRj6eLFAEw2ftYfjuKt7PtsB47HtDgKT4kelPo6Ivt4x+f39JDFI1Gyrb
         0/gW1k3mRGftAK8GH7Qsgi4wKgf2WZdN+D/lRDtjldTvF6vSsp4ODfoGAwVF6BokmuE3
         9WGyUBN62AxEfmkR2y1ZZq0iIBxZEYExe++5E4paOaDGk5jTCeAHEAoEyPx+Oc1d0dot
         YD/A==
X-Gm-Message-State: AOJu0Yyo1Eh4JS8Wg6sZFuYE/159E2AIlK/BhiazfHfSBlGbQVDCwoWq
	o4QP4o7EPR5fXJUQyPGj4eV0NUb1sthNHeCh1gs=
X-Google-Smtp-Source: AGHT+IF3iBrirqGTSOJFGjx5Hum/Pf+fSLQ9zoiASnCu3HINXrcqsRVJxlY0N0vL2ZyM/nB1iE2iAQ==
X-Received: by 2002:aa7:df82:0:b0:523:4bfa:b450 with SMTP id b2-20020aa7df82000000b005234bfab450mr1679392edy.27.1691581295551;
        Wed, 09 Aug 2023 04:41:35 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id k24-20020a056402049800b005236b47116asm350808edv.70.2023.08.09.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:41:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 01/14] arch/x86: Implement arch_bpf_stack_walk
Date: Wed,  9 Aug 2023 17:11:03 +0530
Message-ID: <20230809114116.3216687-2-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040; i=memxor@gmail.com; h=from:subject; bh=4m7z5DYbfWvxVqsPDw9pgoNOX0kO5cOAvWd6mcbLs8M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rI2qah9PJ77xfT5vRzBVHfsjMRNZvJvVBhP LCerXVx/waJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yAAKCRBM4MiGSL8R yiK1D/90dZCkDWvHPX2/zPWKxvtkvW4SgqjiFv0WW7YNADiShaoasfhSFLitdJRA69dLE5zVWyK PsjHDUsTY4RkTtTU3RXpWaLbb9+YJEfBbJkzScJP06i4Q/vOisDxmg9MAdHtHVeKckPDmL1ZuEe aYhOiBo1yt+9+CiY+9oZpvL1Mo28B6WJIWw0BDbNMrstPA2LUGTEXIVhgey/5Din0tLyykYhRkj 8Qqa8BX6vtryJl5XSRcyF4PaWskldhnT2mIqHmCALtKqP/3mtYJ44drzWk2Gu3fZwFguVY/ybKE ljFIqbaNOWIZ4Sfpy44BNah1bFmpMpbecKyWs9rkirj8HbFNQdYXDHrCWAt8FO9ion2FACIJ64o G1oPKQd0OKVnfwNrOVhHVQHGSyJawvmviQdov8o7NovwhcUi4TbeAcgJO/juhDqmUYw5frsbbBu FHgBx6q5wyp32Cdk2STktAUNcbPr0lPyvGwUDgu/iGmGLZDXUPXNSY6OtpMGs3V4y+xa8cMv/qg vTvmlW55/FloA6Q0CL2lQjYVFWM7gOpLjYeKvfyyHVh27mykbgjzyFp98cPNfedCp47vjc1fFPD LfUsGY5eUcWnNL9RkgVt+aCelnUyvbH+iC57U3OVH68iLDS7aowUfHNb+S/WQRT2MX2UIwadPgH s0rS1RbFL+bsGwA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index a5930042139d..a0a0054014e0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -16,6 +16,7 @@
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
+#include <asm/unwind.h>
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
@@ -2913,3 +2914,30 @@ void bpf_jit_free(struct bpf_prog *prog)
 
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
index 0f8f036d8bd1..526059386e9d 100644
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


