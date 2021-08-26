Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C83F8EF4
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbhHZTlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243589AbhHZTlr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aB69aifL1zI8vrW5XNajMWuHmZ5MVDONIdA/rCm6EsU=;
        b=MM/yGe4J5Qw3TSVXWp93tQ5cWeXzJHyP3qr1xIjQim0RI3pSPUYJVIAXiP5+ACQiGfhoe9
        KMTpMLdmbA31xVxnxtBs45KOBXu5+cgQOwaGPcK2KbLK8ojABH4MAcShBkBEJhlZMEXkiE
        DGH/OKcETCLoHJrHAUKavN5v+Alwgp8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-QyQ-obSbOp6nhS7EXNwf5Q-1; Thu, 26 Aug 2021 15:40:58 -0400
X-MC-Unique: QyQ-obSbOp6nhS7EXNwf5Q-1
Received: by mail-wr1-f72.google.com with SMTP id h15-20020adff18f000000b001574654fbc2so1202058wro.10
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aB69aifL1zI8vrW5XNajMWuHmZ5MVDONIdA/rCm6EsU=;
        b=H0mudDtb1QgcJ9i5Awfq49nZE1lE77G+ogDcRCLEWBJiW7xkvVu7io57VczK0WXa3W
         soETps0m9LzC+pQHrBU6kzeds2FXzbNxupTKO315sVLOo/g1qL4w+aCnaUTW+821cWYl
         m6Tn/s1kG7hxAnyBemGZJKxI970lrg2+KEGmImZFC/9TrRkcsnSXNTi+bjWtUw+XT1vi
         x13MAhlzwR4vTOXCbEHldmjj7Fo0eKBeioM9HODyL2hh7W7m0EJ2goee8wN1TF/Q3wBe
         K9yNLkEe3DWIxwioQgGmHgdzVeG5gIbU4bESvNTSgH+xyIAFbKhUXfl8T8vDHSqMvAbL
         tFeA==
X-Gm-Message-State: AOAM533bW122qm4LF+fzLW90fy4ZPIw2QvFLUIPfG2bnEyS1DB7x/J4q
        MbG1G1eov09aTOrJhacpaXjgzTQkXCSSvN7kIyqEbup7PUtvejY2cZBoHudnupMh7deKTfSVKKM
        IJnXnOes1Ex5I
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr5120207wmn.20.1630006856789;
        Thu, 26 Aug 2021 12:40:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJximqozMr0/Jm9W8qaJJ+TOp3iu2uH+xdipTy7sLT+cli5O3p4fnfXEZvgGgFYa01EeiwtxAQ==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr5120188wmn.20.1630006856586;
        Thu, 26 Aug 2021 12:40:56 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id x21sm2507342wmi.15.2021.08.26.12.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:40:56 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 15/27] bpf, x64: Allow to use caller address from stack
Date:   Thu, 26 Aug 2021 21:39:10 +0200
Message-Id: <20210826193922.66204-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently we call the original function by using the absolute address
given at the JIT generation. That's not usable when having trampoline
attached to multiple functions. In this case we need to take the
return address from the stack.

Adding support to retrieve the original function address from the stack
by adding new BPF_TRAMP_F_ORIG_STACK flag for arch_prepare_bpf_trampoline
function.

Basically we take the return address of the 'fentry' call:

   function + 0: call fentry    # stores 'function + 5' address on stack
   function + 5: ...

The 'function + 5' address will be used as the address for the
original function to call.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 13 +++++++++----
 include/linux/bpf.h         |  5 +++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0fe6aacef3db..9f31197780ae 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2024,10 +2024,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, nr_args, stack_size);
 
-		/* call original function */
-		if (emit_call(&prog, orig_call, prog)) {
-			ret = -EINVAL;
-			goto cleanup;
+		if (flags & BPF_TRAMP_F_ORIG_STACK) {
+			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
+			EMIT2(0xff, 0xd0); /* call *rax */
+		} else {
+			/* call original function */
+			if (emit_call(&prog, orig_call, prog)) {
+				ret = -EINVAL;
+				goto cleanup;
+			}
 		}
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f0f548f8f391..a5c3307d49c6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -584,6 +584,11 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_IP_ARG		BIT(3)
 
+/* Get original function from stack instead of from provided direct address.
+ * Makes sense for fexit programs only.
+ */
+#define BPF_TRAMP_F_ORIG_STACK		BIT(4)
+
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
  */
-- 
2.31.1

