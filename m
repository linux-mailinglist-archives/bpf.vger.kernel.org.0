Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C64493AE4
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 14:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354688AbiASNNU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 08:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354629AbiASNNS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 08:13:18 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E08C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 05:13:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e9so2580002pgb.3
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 05:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P49HwgYZwnX/XanLDvLOTv6YF4UZWCF2ZZxxfmEClh0=;
        b=B6xcRsWM1hiPZETg3PGAGpQneUJE6t11wmSr726FxWqn2bumurA5ALjgnD4RH4wq8u
         r0GGBpnjF6vzFx61MQny3Icx0gYnOGBevDbWh/jpL/2aRJu2gAZAZFeeGWP2bcpRtRXz
         Cth81BuWCNEwmp9u/alzYsIMAGyB9Mc/oKWuDIZ2No7JLMu7f34tsdflKFnd/CMVBH/d
         MzvFYdvxLbPxnUNgGMTU5W93RDeqEOvMurm6qUUDO++06D0IPBDowvnULfITGnjLxdO/
         n7t4B9xb+JK3KCSJQX9OiYJ5XIm5WJ5K5+5kAc/68NznGy5Vc30WIuPbHgRXhvOFmFPy
         YjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=P49HwgYZwnX/XanLDvLOTv6YF4UZWCF2ZZxxfmEClh0=;
        b=yw2jHIGDZXuHsfu98gfcSpo03YtIKD/zq34xcoVo3Maa7x7V2INCbyEYrW67zCwtY5
         o0Wsi9NdePN7G4JPBPPRZ7arDJEUKBnnEy0nsgx8TM5JAxysdGbJrm/R4+V2TKJ+vPO8
         5yE3p7F/4+Af0PpZhW03x8XkdO3Wt1tx6KZH21RO5cFuqngdavmZq1mQhima/EbyMSTA
         UJvlop4qn+VHZp9o/5C2Mocp3wwS9/Z2DX0NRsmP9V3tz52X9K4Ps1OA+/rwOPQTQ0fz
         CKnLLe+Ng3pgxfk5bwogfQe63r+Esv4tIuGhufpmCHmJVt6N2co3j0kwrgg3HSCKJzNa
         SwQQ==
X-Gm-Message-State: AOAM531142SN9c+/t0WC5NURuXIvgwMsiqMzb6Kvr/iuHkfZnpwXKqYb
        N65EmhMfD3WFAeo0ncbCqRc=
X-Google-Smtp-Source: ABdhPJwI0xGT06GE7J1Km2pmMFsW1lLFFb9/pW1To0ElnDAqzqOyKmczxRaQzRMFyqRyr8uHdgpUQQ==
X-Received: by 2002:a63:5007:: with SMTP id e7mr26906953pgb.295.1642597997809;
        Wed, 19 Jan 2022 05:13:17 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. (fpa446d38e.knge002.ap.nuro.jp. [164.70.211.142])
        by smtp.gmail.com with ESMTPSA id v13sm3603208pjd.13.2022.01.19.05.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 05:13:17 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     andrii@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH v4 2/3] libbpf: Fix the incorrect register read for syscalls on x86_64
Date:   Wed, 19 Jan 2022 22:12:08 +0900
Message-Id: <20220119131209.36092-3-Kenta.Tada@sony.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119131209.36092-1-Kenta.Tada@sony.com>
References: <20220119131209.36092-1-Kenta.Tada@sony.com>
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
index 90f56b0f585f..81673a24973e 100644
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
+#define PT_REGS_PARM4_CORE_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)
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

