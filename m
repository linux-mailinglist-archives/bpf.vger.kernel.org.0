Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19783BF18B
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhGGVux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 17:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231458AbhGGVuw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 17:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625694491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgBr4LV9SR6/Qelufj3zindVEajUhYS2+l3zjx7rHSU=;
        b=DO+ix10DTo0paD0JC3Z6gRQwV1hNlxs+Tw7p7SR+gW1udXDdL978RBzg1YefvZrWw7UwC0
        Tm3WrdV120A6GWE3W1O5/eBYU+ojRRXnneekzZT+Yzmp3i6dzIVKIOMj0lLpZABGQxA6SO
        VwOs7aEQoUBDTLYweM2NkzN5uOtLyc8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-vkHe6EWrMRSDOmmSOmHnwA-1; Wed, 07 Jul 2021 17:48:10 -0400
X-MC-Unique: vkHe6EWrMRSDOmmSOmHnwA-1
Received: by mail-wm1-f70.google.com with SMTP id m5-20020a05600c3b05b029020c34fd31cfso693114wms.4
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 14:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgBr4LV9SR6/Qelufj3zindVEajUhYS2+l3zjx7rHSU=;
        b=LA/pbRbYXcogS9F4oaBXfbK5Lp18jTKBUXfg5YtK4N5ZbMGa/2RhCYUJ6WWW4ISHR5
         nZPZGxJS/0cnDYPFj0/LfSygPbVTMdbbHBoHHluxRdBa2CkAh0S1xGtdjjMSj9I97bJN
         RIh3k+py3A4CQlt1XN0FrBLU35kKWVm1WDMEffsqobnzNBoAjRBIBnfB4ANpjJPskKgH
         dcamHP9PfCNuTIFpznPS+UKByP0ls5dZs0r4/9xmNYaTLNWviHMVbLpTGIMDJRJGW3JT
         WL+6jQBd16kYSs8xNK+Tba841M9eCDuZLS4nEokM1/kkcUxgHS8/DtgB5Iromznlfr3K
         2XMQ==
X-Gm-Message-State: AOAM532Xy5kszK0yGmQrMgD9oIfzLU+Tew2TmDgrTHkINIhHuFTuUaIR
        oUhez83bWcCtGG7Bosuzw33J3DyCw+6Hjd1ZVbfhLat/BRvCf+V4VX9PPYm+AEl6lOG++Fcmj94
        PCGnPP8YYWlNQ
X-Received: by 2002:a05:600c:3504:: with SMTP id h4mr1321810wmq.118.1625694489445;
        Wed, 07 Jul 2021 14:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxvoBCI3Hwfj+8IIJ0979hrRBL+Mvswms4GyKib5rSXrEUo/bGjX5pem2iEJH+QhrrbUJegw==
X-Received: by 2002:a05:600c:3504:: with SMTP id h4mr1321803wmq.118.1625694489310;
        Wed, 07 Jul 2021 14:48:09 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id v2sm177032wru.16.2021.07.07.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:48:09 -0700 (PDT)
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
Subject: [PATCHv3 bpf-next 1/7] bpf, x86: Store caller's ip in trampoline stack
Date:   Wed,  7 Jul 2021 23:47:45 +0200
Message-Id: <20210707214751.159713-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707214751.159713-1-jolsa@kernel.org>
References: <20210707214751.159713-1-jolsa@kernel.org>
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

