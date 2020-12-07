Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757D52D15AB
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgLGQJv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgLGQJq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:46 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC57C0611CA
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:08:21 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id l5so4328337wmi.4
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Eh0QAkzEYKTW8rBGiJb5/3buh2wDb2AdES6MqxFZBbE=;
        b=AiLHCRzXCVOotUmQTXRuenZS+bewnQoSEjfScArGmdvLqkYRL3d/fwJm4E1BEYSNna
         n6emaTnQHwsLsBBB4HsalQUQX9jK1FtJxn4rFspckbWq3t1K9aK7GwbJ3qCQneLhu/TU
         ow5JYSN8dGHK5QmCESdMXYOLGzxfciyQcU4iCukuVXmqhG60mIlBShI8afQBUyPgLTKW
         m3tbmW64mMHyJdWWp/P9+OlNOybIiell+w2hg3O0wxNgKWsRcue6Neo/qGP+z3gxS/Xv
         JeTCNHHAzni5F6h/e5h0nM0H5ivlzFjgx58e4CY3FLK7rwSBUrKlPXlM+rl6BozmJYR8
         Dazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Eh0QAkzEYKTW8rBGiJb5/3buh2wDb2AdES6MqxFZBbE=;
        b=KeZJOSfZp1qSrvG98Pj210W3TlwxbU4bX5KEZ27yQmvz6mLLA8fzCVXGRHq9wSbAS7
         cyLXX3X9ohQBRbr+He7P9z85aSOWdiLbsoJbmW2czHjwYCbytFGZ8nmjfcpPyJXx0fqv
         XfwvFaY/l2U3aO9cvJ3x7UWdFqWoAm2qUeW/NtT35bncgEIyFyGBKZdRPDl2i3SlA1bK
         phY4MOlRzhf+xsKA9UwvdEt2pp3BM9sztAgHcpOJxt+v27TnqfInaxLMbZTry1JREPqm
         DbvF8vL8wiq1XKULJzfE7E7KZRMizRsf1R12zD8Lfdtbc/s0cpLHuq0rit7CsH5iLxis
         MlMA==
X-Gm-Message-State: AOAM530qN/ozN1FEKVw3V/Ky+3iu/7kGJOpq+uIttpErq37VH4jGUuBi
        VaXNG/dXKCZkxllX+FhMsUqkKdjH0g3H8IN2cgUywP3fRTAwNOQhXLcxRpd2xWvT3GN675maQPo
        IwSsTSq1GFiEthnrgSOXiraQLRxAixlDFYX3NwaPIxQf23YAn+uy2K60JwFTiJuM=
X-Google-Smtp-Source: ABdhPJxF5qPW7rCtwzqawfZsGn2gXf0FDegCyMmKUjCRYWsyTgDMY66rM8DqHhxKHAda1XHOTqkXw2rXvBYXXw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:791a:: with SMTP id
 l26mr54824wme.1.1607357299261; Mon, 07 Dec 2020 08:08:19 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:26 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-4-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 03/11] bpf: x86: Factor out a lookup table for
 some ALU opcodes
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

A later commit will need to lookup a subset of these opcodes. To
avoid duplicating code, pull out a table.

The shift opcodes won't be needed by that later commit, but they're
already duplicated, so fold them into the table anyway.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7106cfd10ba6..f0c98fd275e5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -205,6 +205,18 @@ static u8 add_2reg(u8 byte, u32 dst_reg, u32 src_reg)
 	return byte + reg2hex[dst_reg] + (reg2hex[src_reg] << 3);
 }
 
+/* Some 1-byte opcodes for binary ALU operations */
+static u8 simple_alu_opcodes[] = {
+	[BPF_ADD] = 0x01,
+	[BPF_SUB] = 0x29,
+	[BPF_AND] = 0x21,
+	[BPF_OR] = 0x09,
+	[BPF_XOR] = 0x31,
+	[BPF_LSH] = 0xE0,
+	[BPF_RSH] = 0xE8,
+	[BPF_ARSH] = 0xF8,
+};
+
 static void jit_fill_hole(void *area, unsigned int size)
 {
 	/* Fill whole space with INT3 instructions */
@@ -862,15 +874,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_ALU64 | BPF_AND | BPF_X:
 		case BPF_ALU64 | BPF_OR | BPF_X:
 		case BPF_ALU64 | BPF_XOR | BPF_X:
-			switch (BPF_OP(insn->code)) {
-			case BPF_ADD: b2 = 0x01; break;
-			case BPF_SUB: b2 = 0x29; break;
-			case BPF_AND: b2 = 0x21; break;
-			case BPF_OR: b2 = 0x09; break;
-			case BPF_XOR: b2 = 0x31; break;
-			}
 			maybe_emit_mod(&prog, dst_reg, src_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
+			b2 = simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
 			break;
 
@@ -1050,12 +1056,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			else if (is_ereg(dst_reg))
 				EMIT1(add_1mod(0x40, dst_reg));
 
-			switch (BPF_OP(insn->code)) {
-			case BPF_LSH: b3 = 0xE0; break;
-			case BPF_RSH: b3 = 0xE8; break;
-			case BPF_ARSH: b3 = 0xF8; break;
-			}
-
+			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
 			if (imm32 == 1)
 				EMIT2(0xD1, add_1reg(b3, dst_reg));
 			else
@@ -1089,11 +1090,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			else if (is_ereg(dst_reg))
 				EMIT1(add_1mod(0x40, dst_reg));
 
-			switch (BPF_OP(insn->code)) {
-			case BPF_LSH: b3 = 0xE0; break;
-			case BPF_RSH: b3 = 0xE8; break;
-			case BPF_ARSH: b3 = 0xF8; break;
-			}
+			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(0xD3, add_1reg(b3, dst_reg));
 
 			if (src_reg != BPF_REG_4)
-- 
2.29.2.576.ga3fc446d84-goog

