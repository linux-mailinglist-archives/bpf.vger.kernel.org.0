Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2B47B9B6
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 06:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhLUFxw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 00:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhLUFxw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 00:53:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674AC061574
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 21:53:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k64so10697517pfd.11
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 21:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h5QnTrFhmy5tkCOL333g8+mzCEEe2uGwZdxuh6g3Ngg=;
        b=dL6sBZAtD+Iy5AJb5lKhj5z+/gnKIyRI/9aR2yoDe9IsbrdN4F/xPNTn6I2P+zVVr1
         tXBWVx2udZAhk3FgDAUWjpsDcnuq/0K3++FN9PGrqjyV8fgtDazVXmMULlk3BErWODHH
         e8krJwzgrMViY5yU68siiG0I2M39VMEiURXhLt8xFzJRtYK6vzxiUxfWcdGiG0sWF5UV
         VzxRC+m343042skksQZTiUdfSqMs687vwsETI2wyCcZX1ZwjcsDMJQs0rJYVOcpB7vtG
         aJk/Hvn9albeMJeg636k6CMWiuIjCS69dqg9NiKhoR60qJmMB8tFy+kd4JC6g2xCJpFe
         MKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5QnTrFhmy5tkCOL333g8+mzCEEe2uGwZdxuh6g3Ngg=;
        b=emBX4COaVKyc2lT8xhIgR3dmYIq2vp3dzqF8SZ+8wo5FreDfPmkxbGRFnpKG+uaj1/
         e5lBcoO24pbSHPw8Xwo55bfpgtQMlQQNrjKS2qcrjO48WYr1v6IqDpqTU6JBkwa4XKvD
         cu6KymJL4mGbzbhuOC3fTFKxtT3XmaFa91aIyKNBnQRz423xi5z45s7kAyJNwXmmr/n5
         gQs1Kj0FZPsh1E5sag+S5gMoIcGHQt+N6mhh8tWwUQMII32mvbRoXufaBJAPjMDWWMLA
         wYhIAeMm26h/by6q98KHan+v6PpEie89g3SLgFnSeseP0xV14daGMM31wF4nura1aLg5
         xbvg==
X-Gm-Message-State: AOAM533C4ft9E3cV5lHaum+dqPdlSTEW7UsuAyJv0iEfNQa1YQCDJUy0
        E5BGuSnLNFu6XTXFigIQV8MWoGuadRu/gw==
X-Google-Smtp-Source: ABdhPJzrCJTOI3WRzbFxWCEzuy4G6Zqihkemr24SfjP0vI9E9mA2CS2KvzyNJE0CYvqtIU2bOBLxUA==
X-Received: by 2002:a63:484c:: with SMTP id x12mr1545845pgk.111.1640066031690;
        Mon, 20 Dec 2021 21:53:51 -0800 (PST)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id s16sm20441330pfu.109.2021.12.20.21.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 21:53:51 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] libbpf: Add BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros
Date:   Tue, 21 Dec 2021 05:53:11 +0000
Message-Id: <20211221055312.3371414-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211221055312.3371414-1-hengqi.chen@gmail.com>
References: <20211221055312.3371414-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add syscall-specific variants of BPF_KPROBE/BPF_KRETPROBE named
BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL ([0]). These new macros
hide the underlying way of getting syscall input arguments and
return values. With these new macros, the following code:

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
 tools/lib/bpf/bpf_tracing.h | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index db05a5937105..eb4b567e443f 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -489,4 +489,49 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)

+#define ___bpf_syscall_args0() ctx, regs
+#define ___bpf_syscall_args1(x) \
+	___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE(regs)
+#define ___bpf_syscall_args2(x, args...) \
+	___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE(regs)
+#define ___bpf_syscall_args3(x, args...) \
+	___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE(regs)
+#define ___bpf_syscall_args4(x, args...) \
+	___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE(regs)
+#define ___bpf_syscall_args5(x, args...) \
+	___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE(regs)
+#define ___bpf_syscall_args(args...) \
+	___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
+
+/*
+ * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
+ * tracing syscall functions. It hides the underlying platform-specific
+ * low-level way of getting syscall input arguments from struct pt_regs, and
+ * provides a familiar typed and named function arguments syntax and
+ * semantics of accessing syscall input paremeters.
+ *
+ * Original struct pt_regs* context is preserved as 'ctx' argument. This might
+ * be necessary when using BPF helpers like bpf_perf_event_output().
+ */
+#define BPF_KPROBE_SYSCALL(name, args...)				    \
+name(struct pt_regs *ctx);						    \
+static __attribute__((always_inline)) typeof(name(0))			    \
+____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args);		    \
+typeof(name(0)) name(struct pt_regs *ctx)				    \
+{									    \
+	_Pragma("GCC diagnostic push")					    \
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
+	struct pt_regs *regs = PT_REGS_PARM1(ctx);			    \
+	return ____##name(___bpf_syscall_args(args));			    \
+	_Pragma("GCC diagnostic pop")					    \
+}									    \
+static __attribute__((always_inline)) typeof(name(0))			    \
+____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args)
+
+/*
+ * BPF_KRETPROBE_SYSCALL is just an alias to BPF_KRETPROBE,
+ * it provides optional return value (in addition to `struct pt_regs *ctx`)
+ */
+#define BPF_KRETPROBE_SYSCALL BPF_KRETPROBE
+
 #endif
--
2.30.2
