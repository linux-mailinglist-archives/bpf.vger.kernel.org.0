Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747BB1B2E07
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgDURQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729406AbgDURQJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Apr 2020 13:16:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B5C061A41
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 10:16:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g30so6876145pfr.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JLSvbU4rb+oShXf3/xaOIk/8iC3V7cv0pXPIaRB7gas=;
        b=FXIQhFbyFxDd0yfZDoveFyAYihbUpl0AsbLQrJYGlMwBXwAiFuFrmwg33A6vQn9BxY
         0hEWwUtLK3H2dHb5eKlhTwcqQlbUJRC/m041/yaerXwlJ+oEz1DO1rViNnSaOP0nh/tm
         3iYPRWmJY3YmVlhE1BeKRDTOjICFezTU+5Ld4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JLSvbU4rb+oShXf3/xaOIk/8iC3V7cv0pXPIaRB7gas=;
        b=AGWolQijjFd6bfWqyEwWpSrIOI52nKGj3UcABDZWq4C0wDzFafE1PmvpEyT5bKx9EJ
         PoRXlS35V6MdOzH0zp4+KG5ynPX7Q/f1WAzFIJc6+fLnMyFcJijC37K+7zZchwiL13Ba
         S4THjuvI1VO+p9/G9LXEtH5CyiSJ2zmIyxPy6oC+nBdwtQTB3MZ6LMDvnoerlSzxAoNq
         zYgOnYjFgu4mvbFqOmufG87VVCARJJ7V+oNRtoT2FuMiywUlV7cQ2/yd5qnU11HuTXy6
         /QA3v73+9sNBNTcFXaHqYu3SSWaq384zLm72Ok00EpYu9+FSpW5y9dMJtKOzVdG43pp+
         4Veg==
X-Gm-Message-State: AGi0PuaDriQDr8DHySOuCVdNVd9nBp+y9fN7K2v++WtqpAL/l+R318AR
        TMtBLkFuTWpN8cIwKuFPtSZBSxtA3Y4cPw==
X-Google-Smtp-Source: APiQypJPoDAmSxZXe01yomlBdjPcOGDJGtKwAq2V7OtTrQuozGcBYLfIfUYNkfTKOSgfuq3DcKg29A==
X-Received: by 2002:a63:b23:: with SMTP id 35mr10303567pgl.170.1587489368378;
        Tue, 21 Apr 2020 10:16:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id mn1sm2911459pjb.24.2020.04.21.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 10:16:07 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Wang YanQing <udknight@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/2] bpf, x32: Fix clobbering of dst for BPF_JSET
Date:   Tue, 21 Apr 2020 10:15:52 -0700
Message-Id: <20200421171552.28393-2-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421171552.28393-1-luke.r.nels@gmail.com>
References: <20200421171552.28393-1-luke.r.nels@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current JIT clobbers the destination register for BPF_JSET BPF_X
and BPF_K by using "and" and "or" instructions. This is fine when the
destination register is a temporary loaded from a register stored on
the stack but not otherwise.

This patch fixes the problem (for both BPF_K and BPF_X) by always loading
the destination register into temporaries since BPF_JSET should not
modify the destination register.

This bug may not be currently triggerable as BPF_REG_AX is the only
register not stored on the stack and the verifier uses it in a limited
way.

Fixes: 03f5781be2c7b ("bpf, x86_32: add eBPF JIT compiler for ia32")
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index cc9ad3892ea6..ba7d9ccfc662 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2015,8 +2015,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_JMP | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_X: {
 			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
-			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
-			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
+			u8 dreg_lo = IA32_EAX;
+			u8 dreg_hi = IA32_EDX;
 			u8 sreg_lo = sstk ? IA32_ECX : src_lo;
 			u8 sreg_hi = sstk ? IA32_EBX : src_hi;
 
@@ -2028,6 +2028,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					      add_2reg(0x40, IA32_EBP,
 						       IA32_EDX),
 					      STACK_VAR(dst_hi));
+			} else {
+				/* mov dreg_lo,dst_lo */
+				EMIT2(0x89, add_2reg(0xC0, dreg_lo, dst_lo));
+				if (is_jmp64)
+					/* mov dreg_hi,dst_hi */
+					EMIT2(0x89,
+					      add_2reg(0xC0, dreg_hi, dst_hi));
 			}
 
 			if (sstk) {
@@ -2052,8 +2059,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_JMP | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_K: {
 			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
-			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
-			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
+			u8 dreg_lo = IA32_EAX;
+			u8 dreg_hi = IA32_EDX;
 			u8 sreg_lo = IA32_ECX;
 			u8 sreg_hi = IA32_EBX;
 			u32 hi;
@@ -2066,6 +2073,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					      add_2reg(0x40, IA32_EBP,
 						       IA32_EDX),
 					      STACK_VAR(dst_hi));
+			} else {
+				/* mov dreg_lo,dst_lo */
+				EMIT2(0x89, add_2reg(0xC0, dreg_lo, dst_lo));
+				if (is_jmp64)
+					/* mov dreg_hi,dst_hi */
+					EMIT2(0x89,
+					      add_2reg(0xC0, dreg_hi, dst_hi));
 			}
 
 			/* mov ecx,imm32 */
-- 
2.17.1

