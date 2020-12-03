Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C657C2CDAB1
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436649AbgLCQEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436594AbgLCQEb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:31 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C84C08E85F
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:19 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id l5so1503462wmi.4
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2Q2lne0lXLlvS3rxE7b9vuMB9y2K2LQZIZMl35a4JXk=;
        b=vcJ4+79//CdUXs9AdX9SPf05uB/G63aUP5cG4KzyXo/tvvxbbWt6n+3Qx73s7O3Dpb
         v1L95XWtfWCpKts52CEIq8d2OwA88kBC67aOerfydzROVWbBDykc1fntIekGZgB/OjKX
         sR3DEEv/H6mFORpM0vcEOlh3GxtOvqkMfy/89+7ORcFWEBgSAHd8U0pWVWjwYSsmym14
         +FAYpqcpU5vR/l8ZboEngQxDOMgFyrXSemfzZloks/lv/qLV0QZxN7kjkm/Hz18U3ugR
         ffZn/FTZkJVMZ2GVSfcGAsWqtz8S4AfL15VPP2ma04FHcF249DECceWDLAGs5TuAId8+
         UdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Q2lne0lXLlvS3rxE7b9vuMB9y2K2LQZIZMl35a4JXk=;
        b=Ym4qsVlwgFPmok4usZrTI1eRMM+8HV3fuCYXrFtwj0ZrhNiRCr+KIH3Ps+RwAwOfKs
         OmaciDukejrGP2FqF8AM72uv6NTUfd3nvJzTn6684mbVIvEKgotq68iojSTcc6IIJWVA
         f9BLzRAFv4Z9CFMLO8L+jKCVFC+iBGUh9fGEtRgsWxW5D6D/gtS/5+mrbXiXkz25WfAq
         eEYgcZshtBBXK1y05X45nUIuWrjC1HtfM+yMIQfW/g9+gYxcS7co1MjtrNg+KoaMZHs3
         1FCQoq3vXtkMdW8Jmf8zo9uKW0p1vR3nTEECYbxrP/v49ZSjYWEr0eEIb+jB2G/sS4Jv
         YfcQ==
X-Gm-Message-State: AOAM532MHVmKdMfX7g13ZDJL8DAcNqbX71cYbirSS56V6TDsGVOQBj0/
        KsCJ1ROWoZ1yP7QXzMTWLcziWDqAUUaliKwFgMsECSxTMbjxHA3yKjGwuexAkkyj16RzI4zgGrs
        BKDmMBtHhhOelXALfHLYSupvxczTp5b1WT2SRpWihFjaQTwFUkCf1VjMyL9C6dg0=
X-Google-Smtp-Source: ABdhPJxfEnzmya6LLLPB13rIOUwk19exrmqubviCzrWxYezPhfMxbEy9yh2kt8fPqjD23AGjw7yuMAHbib0fbA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c8c8:: with SMTP id
 f8mr1117092wml.0.1607011397822; Thu, 03 Dec 2020 08:03:17 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:35 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-5-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 04/14] bpf: x86: Factor out a lookup table for
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

Change-Id: Ia6888f9fa65da6225c33b530ea16911bf2f70750
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 171ce539f6b9..ee7905051ee9 100644
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
@@ -878,15 +890,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
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
 
@@ -1063,12 +1069,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
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
@@ -1102,11 +1103,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
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
2.29.2.454.gaff20da3a2-goog

