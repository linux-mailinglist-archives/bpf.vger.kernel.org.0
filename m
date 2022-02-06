Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77F4AAF83
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbiBFNlX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 08:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiBFNlX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 08:41:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F3C06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 05:41:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id qe15so842665pjb.3
        for <bpf@vger.kernel.org>; Sun, 06 Feb 2022 05:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lltxwd7ldEvmPt7bJnUNqYqXfLVHgsouvO/vFB7Kby4=;
        b=MsSL+8JryzA9Ic5V++p6EwijaFZzKqBbRVHxDOHJdQhOC/OcbhWDJ4B6wjKH8lf/4Z
         1OSa1hlqQmNq45MmQkgSp5St5GfELpOmQZqQz+k/gDiEP5Sit2AoLGHmN+ZzJ15QPrWO
         gLFGCEupo/7yYQDRaMvC5FqPQQ1/+QfMKD2YM/BDPXYYhiBFuQp7ptwBIBVmN1ojJkOM
         oXz+/6qP97ESvcnlVxE6DuAExBrFliBVwfCVr61I6DIccWO6PpltK9JbO2NWGDn+vbVX
         Zxt3DSbsU3ckH3GfxJ8lBNNbCY7fwlTQEljItTvjFHITlRiKdtVZ+0w9NTDT/Ro150a3
         1ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lltxwd7ldEvmPt7bJnUNqYqXfLVHgsouvO/vFB7Kby4=;
        b=cKtjjtTFKKz8E2PFnJvOfsFr1GSaQF4P0Abzo6Bc8h39S3/xkKFJ64JRAYNp5x7I4U
         ZojhTnmGNpDkshAtJQSF5wTyd2G8LLGngA4sjrP8GfqKRJdCzfNjJD5mCEMuZiotCOer
         ocmXnysAOAsqfLipzXdDB2nrs2ARxC49fMRsR6XOdPsDxkzKkhG6BUhhur4JoGK12WOA
         5SzxLmH6yiD6DxC403ML4akY5pFHoI7fnDbPIE2XeebPQeP1ux/4R8MwbfxVn3xK7giX
         4f0Kf/gv8NS3MVLPhDPZFUVOCkfJSX6kW1rOQoHGFdV30HviucKvR+nr3DiNhka8yJpf
         LONg==
X-Gm-Message-State: AOAM531rML2Q1HZpXSY0bNMTyC2MHlwiIAMJSPTJ+tru57ry5t878iA7
        et9N7cB8tOCvBG8hwKdCytn+l8yEwgWtZfhw
X-Google-Smtp-Source: ABdhPJzj0Ms2SPYAaXNZv8sUEYLAyZJxfQ7Aw0WW36Vpwl2xYscdue5YdTzYPUU7QP+LxDBdWfMTDw==
X-Received: by 2002:a17:902:9698:: with SMTP id n24mr12417684plp.60.1644154882195;
        Sun, 06 Feb 2022 05:41:22 -0800 (PST)
Received: from chenhengqi-X1.. ([113.64.186.12])
        by smtp.gmail.com with ESMTPSA id e17sm8500982pfv.101.2022.02.06.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:41:21 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 1/2] libbpf: Add BPF_KPROBE_SYSCALL macro
Date:   Sun,  6 Feb 2022 21:40:50 +0800
Message-Id: <20220206134051.721574-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206134051.721574-1-hengqi.chen@gmail.com>
References: <20220206134051.721574-1-hengqi.chen@gmail.com>
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
With these new macros, the following code:

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
 tools/lib/bpf/bpf_tracing.h | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index cf980e54d331..a0b230320335 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -461,4 +461,43 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)

+#define ___bpf_syscall_args0() ctx
+#define ___bpf_syscall_args1(x) \
+	___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args2(x, args...) \
+	___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args3(x, args...) \
+	___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args4(x, args...) \
+	___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args5(x, args...) \
+	___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
+#define ___bpf_syscall_args(args...) \
+	___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
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
+	struct pt_regs *regs = (void *)PT_REGS_PARM1(ctx);		    \
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
