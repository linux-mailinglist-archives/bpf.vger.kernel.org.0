Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF512CDAAF
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436632AbgLCQEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436572AbgLCQEb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:31 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C568C08C5F2
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:17 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id b12so1384774wru.15
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AenZbb8RHh2R8IaLCwpQOQzoT8oepJeSVwoaWTZlmMo=;
        b=aCZOUUB+bwEeJ6PQ1cuZQt6eyoTMxi9AzEJG+trdlXUro6emF0uiJoamlpO5y7ojgd
         nUCAxGxe1wRCejF3IX9h1UWPAfUtOd3XUo5JAhQ3U1x50wF4k4EW3iqgzvULpFEo51pB
         bsl5BJcD5tH2fOboJEGdp7TZP8hBcF30Kjp2c+zfUpGOZ0gtmrrG2qh+a5m7hGreyv6h
         /E1W/FIukDCmhLYvLYPaNzbY/ICYAxnaJjDoVt2+eOVakOPmbkJifqqWIfRztkBs79T7
         /UXJm/yWchMXoXS1r1eYMM+oNLNgUKcQnABu8yX3F055F83bg91rhw6iv0BdVSUYARp6
         ovGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AenZbb8RHh2R8IaLCwpQOQzoT8oepJeSVwoaWTZlmMo=;
        b=QQfV14IFYKUHE4zSUrlGijsjostkMS956Y60mvSDUUUJYsx2jX25FbeECJT9L0V6o7
         YKF4HORssMp3/PnnM/CQKCphpg1/6exkClncJOhHEWE2P1iU6AjP2He0P7nH+apwfaxu
         +QoTLnVO1l2hXCExF+RXKNrXiushQMxMRMn6TpS8RL+wG/IrgRhQKQ79G8D6XkQ4OfbT
         eoXcKR5pviO0mYqccYZvjCyLxgbY5OIGqiXFj3Z4EGUD+kUwfOLUlAY+WAwErqoiB8AW
         00ft3524xTRqSUU6muaqgG4qpBbv4bd0E4OaAy928506JngXy8hGjePRRDcP8o2xKn48
         4cpw==
X-Gm-Message-State: AOAM533cqgbiLnvmSreoMGnuaEL6TlnrrtjvdOWMlF7bbc4Xz1Q2nldE
        arwcf0/Uw4wdooYsrAfATGqYZZ5T+OYsvGP1SEkj+H/D0jGlilX9+9h6yNlM9urMZN/vPMoGSod
        GFdScKQccy4nJ+k69l3sMlZr6jGsTFfA/NNC/qBHXM/nbnp02KWxs/mb1DfQ7ixc=
X-Google-Smtp-Source: ABdhPJxRTqFXO8/CUauvDTj5+Jn1Ir5xXFY0JTaftnYynZiPY0ReAKjPE6KjAr8ay26upDKkFD9/c2BU+WWVmA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:791a:: with SMTP id
 l26mr1117354wme.1.1607011395423; Thu, 03 Dec 2020 08:03:15 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:34 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-4-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 03/14] bpf: x86: Factor out function to emit NEG
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There's currently only one usage of this but implementation of
atomic_sub add another.

Change-Id: Ia56743ec26ff5e7bcde8ae94fa17fef92d418d2b
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7106cfd10ba6..171ce539f6b9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -783,6 +783,22 @@ static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 	*pprog = prog;
 }
 
+
+static void emit_neg(u8 **pprog, u32 reg, bool is64)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	/* Emit REX byte if necessary */
+	if (is64)
+		EMIT1(add_1mod(0x48, reg));
+	else if (is_ereg(reg))
+		EMIT1(add_1mod(0x40, reg));
+
+	EMIT2(0xF7, add_1reg(0xD8, reg)); /* x86 NEG */
+	*pprog = prog;
+}
+
 static bool ex_handler_bpf(const struct exception_table_entry *x,
 			   struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr)
@@ -884,11 +900,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			/* neg dst */
 		case BPF_ALU | BPF_NEG:
 		case BPF_ALU64 | BPF_NEG:
-			if (BPF_CLASS(insn->code) == BPF_ALU64)
-				EMIT1(add_1mod(0x48, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_1mod(0x40, dst_reg));
-			EMIT2(0xF7, add_1reg(0xD8, dst_reg));
+			emit_neg(&prog, dst_reg,
+				 BPF_CLASS(insn->code) == BPF_ALU64);
 			break;
 
 		case BPF_ALU | BPF_ADD | BPF_K:
-- 
2.29.2.454.gaff20da3a2-goog

