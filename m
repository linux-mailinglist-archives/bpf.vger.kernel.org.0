Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5409FB7A
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2019 09:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfH1HXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 03:23:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34806 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfH1HXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Aug 2019 03:23:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id x18so1625098ljh.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59F0XTFJ9u/clKrNXvOGNB2BB2yJWqdqNbYTvvq+2FQ=;
        b=avJG6Yi9BMBUeH4I94+HFGHGpH1E14QZGdmQPyckMF+8oemMIAv1ITVhOFKiMp/Fms
         eh9V3KylhtIPI96Zr/oYm6VUDHW1639eJwoIqx2C0grAtElT7/WbyDiqUbADFhEE/wa7
         LHd4CifAnzCcApMR4femPILvY79Fvp4cWwsDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59F0XTFJ9u/clKrNXvOGNB2BB2yJWqdqNbYTvvq+2FQ=;
        b=XkX6BUD33nCIQ8aHm9usXVRf9kMch8s7QniTovqC1RKtriK6tWQBetADgzKSIcVCx5
         5eSt/dlQlLyib1+fBn77VI4jG+HEBpjI65+qGtJ1ZVj2MM8lM8UQzKfJw4bh4RDUHYPN
         kkDlxmxYKaY2s6BMG5u6whlY69rQKPSidSHsavHvix6sL1uo5WZrKjdLaofXjbzXi16A
         m+g45edHd7XMCz39GLEpYRzpapjB81eiQipH2ViHFNVL5z1ncSTD6M5CxHIP1sPC7EW4
         2+EbRh07MGz8Aa10DgQnxDgnQ6dZTCLQCq1QmUQqBZgtv63xyRUppnrLRlDHIZwyN0R4
         f0uw==
X-Gm-Message-State: APjAAAWQpHk85UV25pLCp7BFbR5rI9EH5cawP9kJ6V8/0iVa/W+q39g2
        uo8S8tJBYagEzVYjTn/DvRE3eXfEOlm8ag==
X-Google-Smtp-Source: APXvYqz/axBKab5GS3/fSKGhz1S7MvXSDR6jz6UneEL8PxXqv5rlH58IHNbqUR/wAdZEcu4IPEkmdQ==
X-Received: by 2002:a2e:80c2:: with SMTP id r2mr1247933ljg.44.1566976977890;
        Wed, 28 Aug 2019 00:22:57 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id z19sm435710ljj.50.2019.08.28.00.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:22:57 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Marek Majkowski <marek@cloudflare.com>
Subject: [RFCv2 bpf-next 03/12] bpf: Add verifier tests for inet_lookup context access
Date:   Wed, 28 Aug 2019 09:22:41 +0200
Message-Id: <20190828072250.29828-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828072250.29828-1-jakub@cloudflare.com>
References: <20190828072250.29828-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Exercise verifier access checks for bpf_inet_lookup context object fields.

Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/verifier/ctx_inet_lookup.c  | 696 ++++++++++++++++++
 1 file changed, 696 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/ctx_inet_lookup.c

diff --git a/tools/testing/selftests/bpf/verifier/ctx_inet_lookup.c b/tools/testing/selftests/bpf/verifier/ctx_inet_lookup.c
new file mode 100644
index 000000000000..665984d8179d
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/ctx_inet_lookup.c
@@ -0,0 +1,696 @@
+{
+	"valid 1,2,4-byte read bpf_inet_lookup remote_ip4",
+	.insns = {
+		/* 4-byte read */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip4)),
+		/* 2-byte read */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip4)),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip4) + 2),
+		/* 1-byte read */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip4)),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip4) + 3),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_inet_lookup remote_ip4",
+	.insns = {
+		/* 8-byte read */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_inet_lookup remote_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		/* 4-byte write */
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_inet_lookup remote_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		/* 4-byte write */
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_inet_lookup remote_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		/* 2-byte write */
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_inet_lookup remote_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		/* 1-byte write */
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"valid 1,2,4-byte read bpf_inet_lookup local_ip4",
+	.insns = {
+		/* 4-byte read */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip4)),
+		/* 2-byte read */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip4)),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip4) + 2),
+		/* 1-byte read */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip4)),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip4) + 3),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_inet_lookup local_ip4",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_inet_lookup local_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_inet_lookup local_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_inet_lookup local_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_inet_lookup local_ip4",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x7f000001U),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_ip4)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"valid 1,2,4-byte read bpf_inet_lookup remote_ip6",
+	.insns = {
+		/* 4-byte read */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[0])),
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[3])),
+		/* 2-byte read */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[0])),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup,
+				     remote_ip6[3]) + 2),
+		/* 1-byte read */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[0])),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup,
+				     remote_ip6[3]) + 3),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_inet_lookup remote_ip6",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_inet_lookup remote_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_inet_lookup remote_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_inet_lookup remote_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_inet_lookup remote_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"valid 1,2,4-byte read bpf_inet_lookup local_ip6",
+	.insns = {
+		/* 4-byte read */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip6[0])),
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip6[3])),
+		/* 2-byte read */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip6[0])),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip6[3]) + 2),
+		/* 1-byte read */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip6[0])),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip6[3]) + 3),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_inet_lookup local_ip6",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_inet_lookup local_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_inet_lookup local_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_inet_lookup local_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_inet_lookup local_ip6",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0x00000001U),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_ip6[0])),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"valid 4-byte read bpf_inet_lookup remote_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_port)),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_inet_lookup remote_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte read bpf_inet_lookup remote_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte read bpf_inet_lookup remote_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, remote_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_inet_lookup remote_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_inet_lookup remote_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_inet_lookup remote_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_inet_lookup remote_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, remote_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"valid 4-byte read bpf_inet_lookup local_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_port)),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_inet_lookup local_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte read bpf_inet_lookup local_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte read bpf_inet_lookup local_port",
+	.insns = {
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, local_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_inet_lookup local_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_inet_lookup local_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_inet_lookup local_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_inet_lookup local_port",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, local_port)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"valid 4-byte read bpf_inet_lookup family",
+	.insns = {
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_inet_lookup family",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte read bpf_inet_lookup family",
+	.insns = {
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte read bpf_inet_lookup family",
+	.insns = {
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_inet_lookup family",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_inet_lookup family",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_inet_lookup family",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_inet_lookup family",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, family)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"valid 4-byte read bpf_inet_lookup protocol",
+	.insns = {
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte read bpf_inet_lookup protocol",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte read bpf_inet_lookup protocol",
+	.insns = {
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte read bpf_inet_lookup protocol",
+	.insns = {
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_inet_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 8-byte write bpf_inet_lookup protocol",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 4-byte write bpf_inet_lookup protocol",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 2-byte write bpf_inet_lookup protocol",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_H, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
+{
+	"invalid 1-byte write bpf_inet_lookup protocol",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 1234),
+		BPF_STX_MEM(BPF_B, BPF_REG_1, BPF_REG_0,
+			    offsetof(struct bpf_inet_lookup, protocol)),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_INET_LOOKUP,
+},
-- 
2.20.1

