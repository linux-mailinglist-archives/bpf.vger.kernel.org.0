Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CB61C710A
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgEFMzk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728760AbgEFMzk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 08:55:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CBEC061A10
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 05:55:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so1641321wrx.10
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqCDXocDO5i14k8cYRHa8RKCuTANFN6tDGlDkASkrpE=;
        b=xuPtNjAPMWquJxSyRYDyUpqZ1kOQCTp3PDWqRw7XofdpT+wYXmoMpp2GrvyiDxty5V
         WeWhGHEB01jLg81zut/sN475g3EBo/6N6qzGmt6JaOHl66uxbhDlXG/h3dAmnjYPQgb0
         q45Xdt5b/2Jz+X65ePYdSFahppTh8oFSai5Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqCDXocDO5i14k8cYRHa8RKCuTANFN6tDGlDkASkrpE=;
        b=sglaQCu5YzlAQZyYwt4cmnfpos1CvS7A7nzUp+yOmTdzz1Gglqlmi5VjcR8dSLM8kG
         lM271tzk1BumyLOLI1XJUJGl4BSvbEZlEj1ebg3ZDRbT2YuDXDEtUkIE2TxxkirrpwqF
         Cf/CAB07LVDY9iI31Yfs2JI89ypoxy7W+jFPBnP9Lfmt9c912Q4rsec7G/Lbz/5bNh9b
         z5jZMjYcvNKV3HGUsHt9QeLX2VUD4TmHSUk47xBlSaoLMc7UtqG6tanTj4n5Ur37pPMj
         OX2+c8zNMKFwp5Fvc2RBQiHBE0adK4rBXM4dotzzynONakLSmortAdoxBiaqB6NNtZv8
         YOsg==
X-Gm-Message-State: AGi0PuYXXFiU1kV7c3tdTr4SxXgkXOtw//p0Ypnd1myilH3RiCQnJRDw
        Kbz0BwY85rg75IwovFrqxEEjlg==
X-Google-Smtp-Source: APiQypLP80LeXjHnXzijysBUf2zzud342z/LdlI0pcTzjFIdpP767ZgBHvcBHF/MJHTUiPgm3eQ6Cw==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr10106526wrt.77.1588769738143;
        Wed, 06 May 2020 05:55:38 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w9sm3013664wrc.27.2020.05.06.05.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 05:55:37 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     dccp@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 15/17] selftests/bpf: Add verifier tests for bpf_sk_lookup context access
Date:   Wed,  6 May 2020 14:55:11 +0200
Message-Id: <20200506125514.1020829-16-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200506125514.1020829-1-jakub@cloudflare.com>
References: <20200506125514.1020829-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Exercise verifier access checks for bpf_sk_lookup context fields.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/verifier/ctx_sk_lookup.c    | 696 ++++++++++++++++++
 1 file changed, 696 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c

diff --git a/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c b/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
new file mode 100644
index 000000000000..167cc3da6502
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
@@ -0,0 +1,696 @@
+{
+	"valid 1,2,4-byte read bpf_sk_lookup src_ip4",
+	.insns = {
+		/* 4-byte read */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip4)),
+		/* 2-byte read */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip4)),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip4) + 2),
+		/* 1-byte read */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip4)),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip4) + 3),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_sk_lookup src_ip4",
+	.insns = {
+		/* 8-byte read */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_sk_lookup src_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		/* 4-byte write */
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_sk_lookup src_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		/* 4-byte write */
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_sk_lookup src_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		/* 2-byte write */
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_sk_lookup src_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		/* 1-byte write */
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"valid 1,2,4-byte read bpf_sk_lookup dst_ip4",
+	.insns = {
+		/* 4-byte read */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip4)),
+		/* 2-byte read */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip4)),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip4) + 2),
+		/* 1-byte read */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip4)),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip4) + 3),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_sk_lookup dst_ip4",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_sk_lookup dst_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_sk_lookup dst_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_sk_lookup dst_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_sk_lookup dst_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"valid 1,2,4-byte read bpf_sk_lookup src_ip6",
+	.insns = {
+		/* 4-byte read */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip6[0])),
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip6[3])),
+		/* 2-byte read */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip6[0])),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup,
+				     src_ip6[3]) + 2),
+		/* 1-byte read */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip6[0])),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup,
+				     src_ip6[3]) + 3),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_sk_lookup src_ip6",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_sk_lookup src_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_sk_lookup src_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_sk_lookup src_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_sk_lookup src_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"valid 1,2,4-byte read bpf_sk_lookup dst_ip6",
+	.insns = {
+		/* 4-byte read */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[0])),
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[3])),
+		/* 2-byte read */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[0])),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[3]) + 2),
+		/* 1-byte read */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[0])),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[3]) + 3),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_sk_lookup dst_ip6",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_sk_lookup dst_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_sk_lookup dst_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_sk_lookup dst_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_sk_lookup dst_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"valid 4-byte read bpf_sk_lookup src_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_port)),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_sk_lookup src_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte read bpf_sk_lookup src_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte read bpf_sk_lookup src_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, src_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_sk_lookup src_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_sk_lookup src_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_sk_lookup src_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_sk_lookup src_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, src_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"valid 4-byte read bpf_sk_lookup dst_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_port)),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_sk_lookup dst_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte read bpf_sk_lookup dst_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte read bpf_sk_lookup dst_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, dst_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_sk_lookup dst_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_sk_lookup dst_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_sk_lookup dst_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_sk_lookup dst_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, dst_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"valid 4-byte read bpf_sk_lookup family",
+	.insns = {
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_sk_lookup family",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte read bpf_sk_lookup family",
+	.insns = {
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte read bpf_sk_lookup family",
+	.insns = {
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_sk_lookup family",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_sk_lookup family",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_sk_lookup family",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_sk_lookup family",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"valid 4-byte read bpf_sk_lookup protocol",
+	.insns = {
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_sk_lookup protocol",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte read bpf_sk_lookup protocol",
+	.insns = {
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte read bpf_sk_lookup protocol",
+	.insns = {
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_sk_lookup protocol",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_sk_lookup protocol",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_sk_lookup protocol",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_sk_lookup protocol",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_sk_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+},
-- 
2.25.3

