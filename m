Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACB4981EC
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 15:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiAXOTh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 09:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiAXOTg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 09:19:36 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B1C06173B
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 06:19:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 128so16100095pfe.12
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFNto2ZDbv17BLgqSUnizRi7njDl8BMdYOADyx3Bz64=;
        b=a8c9kxs/c0Juc5E0eEvMGe2eHfEdXj5XUEdhuGlhJN1PVSpRgzUIZcgLH+uT7UugPw
         887AWPj97AobRqrYahqRzn2ypoPk+YNA6h98znm6q2FjO2bUcAzx4IScqdvcWeazj4oy
         s6917IVs6/QCRQQ4qGmkXcEH9FopeFLZvxcT+CkOMFWa7XE6LFKvPqZ2KongvtyJsjq0
         HoIOot1+Di1/paX+7XPRLZ+0PX9/xvVzXA8/0TRqQy4mCJBN8cnopH4fDFC8QwYkQ5lK
         auM/DHvXqkGAueE2U+jFQoCqQN4FYj3Gl6Tg6iqDmBgh/7hqdo8sx1imtJzv5Xu6LQDe
         aR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CFNto2ZDbv17BLgqSUnizRi7njDl8BMdYOADyx3Bz64=;
        b=BpI4o5+6x33KKXRTpLz8zLDg6puW6RGMbq0vAJRhkGDY/2frRjOszfvD6+mRnpIDku
         ioPkQR7UFhvI3CsKfI7aCU82brzgb/GCefd9W2y+Xl+mMrUnKCmAGqC+PZfUFlNsq4yk
         CeLPdbC4+GM6Llgni9l/UEBbg5EhpxTv3JnpDPMZw5rtaZX9XF4Bo48sIVeF9YaT5oay
         RlIccqWN+7VcAWrwgyZqmNFSBlm7Azt7D1P3rK9kItbjeVnwaX55j+xziMJKtrGKLaba
         VykmjDeTa6+PFbPQRBGUuCbNiRHEJMmsabASJ1YjfnWI7gSZ79iTpxBHpBjPhkSDfwNG
         lhTQ==
X-Gm-Message-State: AOAM531kXbpxo1c/uBRMJhsts3OgZ0amoW1Oli6RebXgtx+8tGkrPH7l
        HRJxtEFOcAxf3dZg9xS0ViE=
X-Google-Smtp-Source: ABdhPJyeQBG/+/ufrGYiG/junuj7gvMI0zLxU6GHEKKRrkCRNKjg+kORD1VnzMo1QMEIbdL+IIbITQ==
X-Received: by 2002:a63:90c1:: with SMTP id a184mr12017024pge.372.1643033976120;
        Mon, 24 Jan 2022 06:19:36 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. ([240d:1a:2e0:8a00:d1c2:4b2a:8ba8:7b43])
        by smtp.gmail.com with ESMTPSA id 13sm15629855pfm.161.2022.01.24.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 06:19:35 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     andrii@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH v5 2/3] libbpf: Fix the incorrect register read for syscalls on x86_64
Date:   Mon, 24 Jan 2022 23:16:21 +0900
Message-Id: <20220124141622.4378-3-Kenta.Tada@sony.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141622.4378-1-Kenta.Tada@sony.com>
References: <20220124141622.4378-1-Kenta.Tada@sony.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, rcx is read as the fourth parameter of syscall on x86_64.
But x86_64 Linux System Call convention uses r10 actually.
This commit adds the wrapper for users who want to access to
syscall params to analyze the user space.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 tools/lib/bpf/bpf_tracing.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 90f56b0f585f..032ba809f3e5 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -70,6 +70,7 @@
 #define __PT_PARM2_REG si
 #define __PT_PARM3_REG dx
 #define __PT_PARM4_REG cx
+#define __PT_PARM4_REG_SYSCALL r10 /* syscall uses r10 */
 #define __PT_PARM5_REG r8
 #define __PT_RET_REG sp
 #define __PT_FP_REG bp
@@ -99,6 +100,7 @@
 #define __PT_PARM2_REG rsi
 #define __PT_PARM3_REG rdx
 #define __PT_PARM4_REG rcx
+#define __PT_PARM4_REG_SYSCALL r10 /* syscall uses r10 */
 #define __PT_PARM5_REG r8
 #define __PT_RET_REG rsp
 #define __PT_FP_REG rbp
@@ -263,6 +265,26 @@ struct pt_regs;
 
 #endif
 
+#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
+#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
+#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
+#ifdef __PT_PARM4_REG_SYSCALL
+#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)
+#else /* __PT_PARM4_REG_SYSCALL */
+#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
+#endif
+#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
+
+#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
+#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
+#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
+#ifdef __PT_PARM4_REG_SYSCALL
+#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)
+#else /* __PT_PARM4_REG_SYSCALL */
+#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
+#endif
+#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
+
 #else /* defined(bpf_target_defined) */
 
 #define PT_REGS_PARM1(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
@@ -290,6 +312,18 @@ struct pt_regs;
 #define BPF_KPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define BPF_KRETPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 
+#define PT_REGS_PARM1_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM2_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM3_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM4_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM5_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+
+#define PT_REGS_PARM1_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM2_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM3_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM4_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM5_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+
 #endif /* defined(bpf_target_defined) */
 
 #ifndef ___bpf_concat
-- 
2.32.0

