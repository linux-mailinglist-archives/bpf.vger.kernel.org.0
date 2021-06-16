Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8083A9524
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhFPIjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 04:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhFPIi7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 04:38:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15CCC061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 01:36:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3502824wmh.4
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yI33QXO7o5mOboBJqKlcsQIYZrZ+1KjBdF8A0bBLZiE=;
        b=FngHFoRnto+bBLYvxXTsJKnfqhDGQCtDzyzBKdBBd9lQqhnlKzuZaQaLHk4AoeN+hl
         AqZx41zAvklAaZ7yw8BE6WDxqSMVyMIYAqwGvumH5URiRYw5Z/GXI0ArXLo39pYrIPR3
         nRX2e3cBj2GNCSUyhCsHAmTvjZqgKxo46vymw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yI33QXO7o5mOboBJqKlcsQIYZrZ+1KjBdF8A0bBLZiE=;
        b=uIUooWa19i18COQKjhx7u6biJa9o8gR2yfVaYLb8Y/YypgeGWix2LUu33UzYP8bkjp
         l1AivQx3pOsW7tF1QtHl2DO+VUHKtxxfcLCgpLdSGju/yOzpJkXaaKXJLXgv2MLRzteO
         NdxK8w1oDFcVOv0cBKgzJwxm665sTOYJ221ZvwrDs7KoxnwA6+9xDUIjd1lOnJLXQsST
         dHA46IFJakVGZVhFMhiKOelFpw1NJtBsUOI7hF12/pVtNtoBZpyH//Q336DiDn0m+9B0
         e/5kxYQBbTcqAP92WoASQYNtVZJz351Nry/NYcuUzLzA4hXqWo+2liK4dYCstC6X+fwe
         WqaQ==
X-Gm-Message-State: AOAM533H+BW41TlYq5Z83SBmycotxjo3o33k9MCjHCBMszrJChshyBXS
        i9eQPGVuVkIRfhVKqFBPHrf6U9HYFM9krA==
X-Google-Smtp-Source: ABdhPJyFK1qIGk6TPzXhd0VQ90Tjzc8qEZvXI0wWPbL9vsc6aywxffK9nCfu06zP5fM9S8eh3O0E0g==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr3873982wmc.163.1623832612418;
        Wed, 16 Jun 2021 01:36:52 -0700 (PDT)
Received: from antares.. (d.6.5.c.4.5.7.b.b.1.c.a.6.3.c.d.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:dc36:ac1b:b754:c56d])
        by smtp.gmail.com with ESMTPSA id a1sm1698549wra.63.2021.06.16.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 01:36:51 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 1/1] lib: bpf: tracing: fail compilation if target arch is missing
Date:   Wed, 16 Jun 2021 09:36:35 +0100
Message-Id: <20210616083635.11434-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf2go is the Go equivalent of libbpf skeleton. The convention is that
the compiled BPF is checked into the repository to facilitate distributing
BPF as part of Go packages. To make this portable, bpf2go by default
generates both bpfel and bpfeb variants of the C.

Using bpf_tracing.h is inherently non-portable since the fields of
struct pt_regs differ between platforms, so CO-RE can't help us here.
The only way of working around this is to compile for each target
platform independently. bpf2go can't do this by default since there
are too many platforms.

Define the various PT_... macros when no target can be determined and
turn them into compilation failures. This works because bpf2go always
compiles for bpf targets, so the compiler fallback doesn't kick in.
Conditionally define __BPF_MISSING_TARGET so that we can inject a
more appropriate error message at build time. The user can then
choose which platform to target explicitly.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/lib/bpf/bpf_tracing.h | 46 +++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index c0f3a26aa582..d6bfbe009296 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -25,26 +25,35 @@
 	#define bpf_target_sparc
 	#define bpf_target_defined
 #else
-	#undef bpf_target_defined
-#endif
 
 /* Fall back to what the compiler says */
-#ifndef bpf_target_defined
 #if defined(__x86_64__)
 	#define bpf_target_x86
+	#define bpf_target_defined
 #elif defined(__s390__)
 	#define bpf_target_s390
+	#define bpf_target_defined
 #elif defined(__arm__)
 	#define bpf_target_arm
+	#define bpf_target_defined
 #elif defined(__aarch64__)
 	#define bpf_target_arm64
+	#define bpf_target_defined
 #elif defined(__mips__)
 	#define bpf_target_mips
+	#define bpf_target_defined
 #elif defined(__powerpc__)
 	#define bpf_target_powerpc
+	#define bpf_target_defined
 #elif defined(__sparc__)
 	#define bpf_target_sparc
+	#define bpf_target_defined
+#endif /* no compiler target */
+
 #endif
+
+#ifndef __BPF_TARGET_MISSING
+#define __BPF_TARGET_MISSING "GCC error \"Must specify a BPF target arch via __TARGET_ARCH_xxx\""
 #endif
 
 #if defined(bpf_target_x86)
@@ -287,7 +296,7 @@ struct pt_regs;
 #elif defined(bpf_target_sparc)
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)		({ (ip) = PT_REGS_RET(ctx); })
 #define BPF_KRETPROBE_READ_RET_IP		BPF_KPROBE_READ_RET_IP
-#else
+#elif defined(bpf_target_defined)
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)					    \
 	({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
 #define BPF_KRETPROBE_READ_RET_IP(ip, ctx)				    \
@@ -295,6 +304,35 @@ struct pt_regs;
 			  (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
 #endif
 
+#if !defined(bpf_target_defined)
+
+#define PT_REGS_PARM1(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM2(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM3(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM4(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM5(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_RET(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_FP(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_RC(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_SP(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_IP(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+
+#define PT_REGS_PARM1_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM2_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM3_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM4_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_PARM5_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_RET_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_FP_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_RC_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_SP_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define PT_REGS_IP_CORE(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+
+#define BPF_KPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
+
+#endif /* !defined(bpf_target_defined) */
+
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
 #endif
-- 
2.30.2

