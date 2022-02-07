Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F424AC210
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 15:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbiBGO46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385168AbiBGObv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 09:31:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F3C0401C1
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 06:31:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id qe15so3508509pjb.3
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXNjobteD4303IlTJKYjX/d4r4arS0f5hmVSStJtZ8A=;
        b=eIs/29atF2WaImTnT9T3qdWXEP48fpD/QG6bUX3I3+gcocYMDm7HqTLFP+jlZVUwbX
         C+xBrr7IXD31LYwLpTXOX/J59d9NYdLd+eT+GRhHwGzok+Q98viJ/cvAH81JdLBWo/Bf
         tYJHx2euPz7Tc5XBYB21JC16wjzfWp250KRGvC+xXVrIC+ZuKkcRs1ycPxexX4t2Otsn
         IfspbuemR6zM1UOKdK0+GH7sg6yhW//VHs8HlNlKJl3flwYP9o0ZwgIbjSux7dDxj3U9
         GC4byKjAp7VVqxz3tzEk8mTUHq++GxaND4MsJtATotZM/siRyXO+gCX9/QfVnLnQ7lci
         VJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXNjobteD4303IlTJKYjX/d4r4arS0f5hmVSStJtZ8A=;
        b=CghrTyU5J9OydFpcq5ALab8HBSoB6j4w1qx13vuuurx0d1TWpgRHVRnW6C7SHSgEvN
         CqsWMKvB9JIYx+YQNfAOJPb6Gmsy1zgtvZ6TXxrS3VTxbMIhQTwaWyaYZfVVbuL+oDW2
         7J1Ms2D5PoDYAQvAFv0wcfmfyUJrq1qiV6wX15mSpYx22zwV3rJB9m1bw0bR3e0mUUsW
         QALg4+1iRj9WyyKCuhNdmT+Wwjivf/FgHY49AAbrdwy/3qtp3zY77JNvjUHYWva4HHYE
         ad0oe7oBsWCB4U7Yu72BmFt4zTwjTZNluwSd5hNuj02xJa8nB+7nDI3/X9SF+O7Yyg4Q
         Ge9A==
X-Gm-Message-State: AOAM5303Uz6b4EHdIK6XHR19u+7Aex+pp6gkPNLUJpruBt4MK9LB4d2Z
        EngLYzNNh3wIkPgaVLdjFKNmZ1s7ZjU=
X-Google-Smtp-Source: ABdhPJz7a+nki0rWbpqpju4zwxSBmEd3F+uFGRDxE9EvJkcKrxJ85Aj3+vQN3zzc5vjjOn8PoLUT/A==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr16252636plr.150.1644244310031;
        Mon, 07 Feb 2022 06:31:50 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id s84sm8928747pgs.77.2022.02.07.06.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:31:49 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3 1/2] libbpf: Add BPF_KPROBE_SYSCALL macro
Date:   Mon,  7 Feb 2022 22:31:33 +0800
Message-Id: <20220207143134.2977852-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207143134.2977852-1-hengqi.chen@gmail.com>
References: <20220207143134.2977852-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add syscall-specific variant of BPF_KPROBE named BPF_KPROBE_SYSCALL ([0]).
The new macro hides the underlying way of getting syscall input arguments.
With the new macro, the following code:

    SEC("kprobe/__x64_sys_close")
    int BPF_KPROBE(do_sys_close, struct pt_regs *regs)
    {
        int fd;

        fd = PT_REGS_PARM1_CORE(regs);
        /* do something with fd */
    }

can be written as:

    SEC("kprobe/__x64_sys_close")
    int BPF_KPROBE_SYSCALL(do_sys_close, int fd)
    {
        /* do something with fd */
    }

  [0] Closes: https://github.com/libbpf/libbpf/issues/425

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/bpf_tracing.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index cf980e54d331..7ad9cdea99e1 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -461,4 +461,37 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)

+#define ___bpf_syscall_args0()           ctx
+#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
+
+/*
+ * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
+ * tracing syscall functions, like __x64_sys_close. It hides the underlying
+ * platform-specific low-level way of getting syscall input arguments from
+ * struct pt_regs, and provides a familiar typed and named function arguments
+ * syntax and semantics of accessing syscall input parameters.
+ *
+ * Original struct pt_regs* context is preserved as 'ctx' argument. This might
+ * be necessary when using BPF helpers like bpf_perf_event_output().
+ */
+#define BPF_KPROBE_SYSCALL(name, args...)				    \
+name(struct pt_regs *ctx);						    \
+static __attribute__((always_inline)) typeof(name(0))			    \
+____##name(struct pt_regs *ctx, ##args);				    \
+typeof(name(0)) name(struct pt_regs *ctx)				    \
+{									    \
+	struct pt_regs *regs = PT_REGS_SYSCALL_REGS(ctx);		    \
+	_Pragma("GCC diagnostic push")					    \
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
+	return ____##name(___bpf_syscall_args(args));			    \
+	_Pragma("GCC diagnostic pop")					    \
+}									    \
+static __attribute__((always_inline)) typeof(name(0))			    \
+____##name(struct pt_regs *ctx, ##args)
+
 #endif
--
2.30.2
