Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE453C81EB
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 11:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbhGNJrF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 05:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238927AbhGNJrF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 05:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626255853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=js7ItpLeBG6341HxQnnXIxzAVMeXbOzDGxLGSYjQe08=;
        b=EoxHcs2fIOcmbgqNkbxEmAh9O9c9MeZDQCIubqV4lj7hEqH+amDcdDl5HlzOzSH1RGAQaL
        eKySBWaVDu6L+4h0Ur9G9R1b6L8BMt8eza1VLABQx/XWkUpQvwjSTlqrXJefwwquvodsDt
        SQwOEkP6weX+Fzdo8ORkDFCrh6iebDg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-w4i8xMJMNUu0CqN57NwOHQ-1; Wed, 14 Jul 2021 05:44:12 -0400
X-MC-Unique: w4i8xMJMNUu0CqN57NwOHQ-1
Received: by mail-wr1-f70.google.com with SMTP id r11-20020a5d52cb0000b02901309f5e7298so1248124wrv.0
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 02:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=js7ItpLeBG6341HxQnnXIxzAVMeXbOzDGxLGSYjQe08=;
        b=XAYiOPcv7ZSEkUyz5HFIoCg+kq5v46k5Sbt289wzwciHV7SDt0eAwp7of8P60EDG26
         mjqKX0xThADr5AxxgPFIaN1LxLQfQcvgngcZ2fq1g20udiB6p/Gg5YvBE14PR49u+QvZ
         gnVe8b3kk+8gRXMI2uoM9Sub7U+aYsOYQnxiGx5fPW9yWBkOUKmad1CHAMPxG6+eN0LY
         wXs/VndjlSa/XoMpgQ/a3AEBtJx16MEzcGRiqapKsPer0ca2EGlpHhNd8EjMlAPhwn74
         w9i4vg/7fEQLUsCjYbYJSYkPifjnXBgHnbkLU/7Uq6iw//NchN3pz/540BqDGc3VaN4W
         xZ8g==
X-Gm-Message-State: AOAM531yOQJP9jXwUdaF8jWc7tDxg17o9zQkmm32OCuE9l+Z1VjxqAyy
        RmeJJ20c3qH+qQp5lFpOAe9Y4r9v4dj2T83FmiyyiJ8WVELVltJmIKqX4DSYlq4H0OxgNs40vj8
        3Yc9htse/6t7a
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr11631525wrf.32.1626255851364;
        Wed, 14 Jul 2021 02:44:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9wxWDgLR+XvYeobeH3N2tpea63Gzr0Is8aqeGRFYHharxAcPTxU0MECVMqK95yblgf8g04w==
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr11631497wrf.32.1626255851148;
        Wed, 14 Jul 2021 02:44:11 -0700 (PDT)
Received: from krava.redhat.com ([5.171.203.6])
        by smtp.gmail.com with ESMTPSA id g15sm1502900wmh.44.2021.07.14.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:44:10 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv4 bpf-next 1/8] bpf, x86: Store caller's ip in trampoline stack
Date:   Wed, 14 Jul 2021 11:43:53 +0200
Message-Id: <20210714094400.396467-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714094400.396467-1-jolsa@kernel.org>
References: <20210714094400.396467-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Storing caller's ip in trampoline's stack. Trampoline programs
can reach the IP in (ctx - 8) address, so there's no change in
program's arguments interface.

The IP address is takes from [fp + 8], which is return address
from the initial 'call fentry' call to trampoline.

This IP address will be returned via bpf_get_func_ip helper
helper, which is added in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 19 +++++++++++++++++++
 include/linux/bpf.h         |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e835164189f1..c320b3ce7b58 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1951,6 +1951,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	if (flags & BPF_TRAMP_F_CALL_ORIG)
 		stack_size += 8; /* room for return value of orig_call */
 
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		stack_size += 8; /* room for IP address argument */
+
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
@@ -1964,6 +1967,22 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
 	EMIT1(0x53);		 /* push rbx */
 
+	if (flags & BPF_TRAMP_F_IP_ARG) {
+		/* Store IP address of the traced function:
+		 * mov rax, QWORD PTR [rbp + 8]
+		 * sub rax, X86_PATCH_SIZE
+		 * mov QWORD PTR [rbp - stack_size], rax
+		 */
+		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
+		EMIT4(0x48, 0x83, 0xe8, X86_PATCH_SIZE);
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -stack_size);
+
+		/* Continue with stack_size for regs storage, stack will
+		 * be correctly restored with 'leave' instruction.
+		 */
+		stack_size -= 8;
+	}
+
 	save_regs(m, &prog, nr_args, stack_size);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4afbff308ca3..1ebb7690af91 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -554,6 +554,11 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_SKIP_FRAME		BIT(2)
 
+/* Store IP address of the caller on the trampoline stack,
+ * so it's available for trampoline's programs.
+ */
+#define BPF_TRAMP_F_IP_ARG		BIT(3)
+
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
  */
-- 
2.31.1

