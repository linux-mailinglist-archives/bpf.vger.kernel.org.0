Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDC3A3047
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJQMr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhFJQMq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 12:12:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D505BC061760
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 09:10:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so6954420wms.0
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wh9HJh5QKRsi8UTmSC2Me4kFshyHJOENONjeXSycPDw=;
        b=b9NV4T+vIhN/e2rc3KyiR571LK840a4AsvEQcSHP3xSDqggM61GVv2YEUpmb06M4I9
         eW9l8mW03caMkds5vbmcjWJcyq62lYf9rybxiOniR+yYAoTevONOaHruaKO6lxcCMcJh
         JybQjt8euQzL7tlpV0+Gy3rVhP6pD2U2lON7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wh9HJh5QKRsi8UTmSC2Me4kFshyHJOENONjeXSycPDw=;
        b=e+jNVEyAk6RMlxypKbNUPymbChDK+n51QZHSqNj5Gbi6xbT9z1iHLioI6Hsd/8XEle
         oRamcRvm5UBlRDMYk0+wPVGCrKvnc5madl5byQYjVBC1IB80FBjaO2uT2RYXlZPtZW5g
         z/aGozo2GHFWtiHj7TuWKEy8mQFAgtgQpJM9P1mRSAiGYq+A7xP16u92aB6Sb8G0bUDd
         Bub/2xGiheVVnpl+vy+KHxkX6Z+eF5JIO/ihlXGI5QOjzBrKMNdMx4tkm1vf2BSfwXv8
         lbv7AjTnokc3Jum44Zb8/mFldCrhpK9O1iIXM99REAoMKiPS7D4KBL++lkOIAwz8KF78
         SQgw==
X-Gm-Message-State: AOAM531f9d9Jzacd9qEPETMYSEuAY86txYaQ7mgw9si8DaApivuapa8v
        zSj0P29xyfMZaz7+8ItKsNcDgQ==
X-Google-Smtp-Source: ABdhPJygr8HzD9hbvgcSImlHFRCrj3b6n6c1wexozkE5SHRflbuDw6j0B2l6pPpD1J9xQGVuJt0sNg==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr14427006wmq.131.1623341448372;
        Thu, 10 Jun 2021 09:10:48 -0700 (PDT)
Received: from antares.. (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id z12sm4212383wmc.5.2021.06.10.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:10:48 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf] lib: bpf: tracing: fail compilation if target arch is missing
Date:   Thu, 10 Jun 2021 17:10:27 +0100
Message-Id: <20210610161027.255372-1-lmb@cloudflare.com>
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
Conditionally define __bpf_missing_target so that we can inject a
more appropriate error message at build time. The user can then
choose which platform to target explicitly.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/lib/bpf/bpf_tracing.h | 46 +++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index c0f3a26aa582..438174adb3f8 100644
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
+#ifndef __bpf_target_missing
+#define __bpf_target_missing "GCC error \"Must specify a target arch via __TARGET_ARCH_xxx\""
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
+#define PT_REGS_PARM1(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_PARM2(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_PARM3(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_PARM4(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_PARM5(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_RET(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_FP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_RC(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_SP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_IP(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+
+#define PT_REGS_PARM1_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_PARM2_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_PARM3_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_PARM4_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_PARM5_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_RET_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_FP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_RC_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_SP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define PT_REGS_IP_CORE(x) ({ _Pragma(__bpf_target_missing); 0ull; })
+
+#define BPF_KPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__bpf_target_missing); 0ull; })
+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__bpf_target_missing); 0ull; })
+
+#endif /* !defined(bpf_target_defined) */
+
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
 #endif
-- 
2.30.2

