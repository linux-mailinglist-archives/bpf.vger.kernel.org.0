Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329861AF5E0
	for <lists+bpf@lfdr.de>; Sun, 19 Apr 2020 01:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDRX1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Apr 2020 19:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgDRX1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Apr 2020 19:27:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCFDC061A41
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2020 16:27:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so2792484pjb.3
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2020 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cUB7vdca0MZaJN7908SrqMzaWtQshCgrQGTimt6WXAg=;
        b=SHBqs5TvQq09m2V0itEAb9laKJVkdszNqUOMrH3jL2JPNyTiR2palwCZTYkoAhmx7D
         21HzuuAMqYhvz44uZleZWuYu+EpMZDZSRCl5UJnqfDLrESBxndlSJJNaCDXcHwLhXYTD
         i0HCoVM1GorPe52KBFFHPYNewpeJR9fRfWzy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cUB7vdca0MZaJN7908SrqMzaWtQshCgrQGTimt6WXAg=;
        b=JMjfBPdOl4rS9Ijw7yMiWTMCvYpTIa1/nVWioh5zvh2OH4kEP9oQtmDgabLrHGHtk5
         xCMBdsT7A3SH+AtTujUho4jMajQWEB7GpvMsjsn/gZj++HJTQBVnuU34KqdJVpQrBCFO
         1k0IaeiB25N3F72E9g5zczJzmfZMonv1rdgBEts2dqda3MnbyZ8QxWb1zXLX87C7BLy2
         kXgCBrxWQM0yAHgDADkwzFdXj5rPLHVUCxvfPvur7Rx2gDjJBSQNMs32+5RgP3/1aVoN
         m0dldZpRQQl6wGm+JrFcLdU63PyncAGXLo3jf+C75qx7pfZVztIVbd8pBQd6AAT8h8BS
         dvLQ==
X-Gm-Message-State: AGi0PubtQhFZmO5y8K3LPAh1S82U9J2pLogLHGfTdWr/fH91if3NPq11
        DoQHrqt5hDPcm+tINwepqe5yH6cH9afwjg==
X-Google-Smtp-Source: APiQypJCCGQF4cugES6slU2mpdEx2GHrEHuPITzBVyuTaVJ/RHTBYfuNwArajpvWKLf808CbnsWMow==
X-Received: by 2002:a17:90a:fc89:: with SMTP id ci9mr5854418pjb.140.1587252423701;
        Sat, 18 Apr 2020 16:27:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id u7sm21429323pfu.90.2020.04.18.16.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 16:27:03 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] bpf, selftests: Add test for BPF_STX BPF_B storing R10
Date:   Sat, 18 Apr 2020 16:26:54 -0700
Message-Id: <20200418232655.23870-2-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418232655.23870-1-luke.r.nels@gmail.com>
References: <20200418232655.23870-1-luke.r.nels@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a test to test_verifier that writes the lower 8 bits of
R10 (aka FP) using BPF_B to an array map and reads the result back. The
expected behavior is that the result should be the same as first copying
R10 to R9, and then storing / loading the lower 8 bits of R9.

This test catches a bug that was present in the x86-64 JIT that caused
an incorrect encoding for BPF_STX BPF_B when the source operand is R10.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 .../selftests/bpf/verifier/stack_ptr.c        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/stack_ptr.c b/tools/testing/selftests/bpf/verifier/stack_ptr.c
index 7276620ef242..8bfeb77c60bd 100644
--- a/tools/testing/selftests/bpf/verifier/stack_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/stack_ptr.c
@@ -315,3 +315,43 @@
 	},
 	.result = ACCEPT,
 },
+{
+	"store PTR_TO_STACK in R10 to array map using BPF_B",
+	.insns = {
+	/* Load pointer to map. */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	/* Copy R10 to R9. */
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_10),
+	/* Pollute other registers with unaligned values. */
+	BPF_MOV64_IMM(BPF_REG_2, -1),
+	BPF_MOV64_IMM(BPF_REG_3, -1),
+	BPF_MOV64_IMM(BPF_REG_4, -1),
+	BPF_MOV64_IMM(BPF_REG_5, -1),
+	BPF_MOV64_IMM(BPF_REG_6, -1),
+	BPF_MOV64_IMM(BPF_REG_7, -1),
+	BPF_MOV64_IMM(BPF_REG_8, -1),
+	/* Store both R9 and R10 with BPF_B and read back. */
+	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_10, 0),
+	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_1, 0),
+	BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_9, 0),
+	BPF_LDX_MEM(BPF_B, BPF_REG_3, BPF_REG_1, 0),
+	/* Should read back as same value. */
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_3, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 42),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 3 },
+	.result = ACCEPT,
+	.retval = 42,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
-- 
2.17.1

