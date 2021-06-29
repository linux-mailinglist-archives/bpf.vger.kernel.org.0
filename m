Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34BB3B78A2
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 21:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhF2TcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 15:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234171AbhF2TcV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 15:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624994993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgBr4LV9SR6/Qelufj3zindVEajUhYS2+l3zjx7rHSU=;
        b=jN8Mb9waVl6aEdlN2rQLLeHjomuDBp9x8ciwcANSFVFpozF/uqAb6xfNq7F9MUZn59D6eb
        y2ZRJUlXJt68i2qwTAH33bGCiI4jv1iapnKYGhosqK8MSAfED3yh1SvW3YbolvTYhqzFm2
        tcLB+SQ9KTqQ47ZBo4uMBCjR2WlmvAk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-Vxx7jdzFOOOXDqgx8g9TZA-1; Tue, 29 Jun 2021 15:29:51 -0400
X-MC-Unique: Vxx7jdzFOOOXDqgx8g9TZA-1
Received: by mail-ed1-f71.google.com with SMTP id j15-20020a05640211cfb0290394f9de5750so11368172edw.16
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 12:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgBr4LV9SR6/Qelufj3zindVEajUhYS2+l3zjx7rHSU=;
        b=pKy0F901A8IgaurZYhAdYW699Nhp/DzR9FbNY4F6PU54hUXOg9MJFJQ096LWGrZ8xr
         nv4AP+IvWJaGuyHZZ1EMgejSOSBc7x+fXaDpNxZCEzhSv0XUTfu8o7jzX3XOcypyfY7w
         vWp5EjnPMOjYCdNV6ttGg3BXhjwHcoKCqJkNqJ+gtmW21Yvg9+j9Hw/n4wIpa/rKXvpD
         DmpQtgje6v5B5etWDRFFRRDVOZUdx+0asAjCrbvj31w9l/44hnhom9o+1rlaT36pIhbH
         M2sDuduciEpP3H8DdDNY++xeztXQkrDwvI57N47fho3xO4s2bbR+7QO/Vq9mvoBxjlk7
         qcUA==
X-Gm-Message-State: AOAM530t19hitjViRFUxrOy4HrhX+987L+me0X+3Q8R6tbg5iocD0UK9
        Wxsogc96JapudIZA4GxkASTGVOZBHc/9SMTZq0iqkO1hP1WWW9nyKIPI6gz6Sh/lxf9lbFJuLhb
        odKkZPZHXy/Sb
X-Received: by 2002:a05:6402:1c11:: with SMTP id ck17mr29205326edb.370.1624994990334;
        Tue, 29 Jun 2021 12:29:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXHlbTwtU81vylTCzW77E+j+DPUwj3/0W67M0b+va71aRhfz4ja1tt1bjornX+DBMxs/e2RA==
X-Received: by 2002:a05:6402:1c11:: with SMTP id ck17mr29205314edb.370.1624994990153;
        Tue, 29 Jun 2021 12:29:50 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id n22sm472559eje.3.2021.06.29.12.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:29:49 -0700 (PDT)
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
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 1/5] bpf, x86: Store caller's ip in trampoline stack
Date:   Tue, 29 Jun 2021 21:29:41 +0200
Message-Id: <20210629192945.1071862-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210629192945.1071862-1-jolsa@kernel.org>
References: <20210629192945.1071862-1-jolsa@kernel.org>
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
index f309fc1509f2..6b3da9bc3d16 100644
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

