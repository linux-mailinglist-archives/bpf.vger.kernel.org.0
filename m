Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FBE3D93D8
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhG1RFq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhG1RFk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED66C0613D3
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f13so4147736edq.13
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxySBhmvimi4ZKs2eujmLdd7HTtzSlS7O6wcYvbvLCE=;
        b=n2YSbg6qGoYEIaxxb71PgaB/RzkW2abc35KbLZe0e83sUYyEPo5Kq85f1iszYJh2pS
         nM79vFlmSozKc2kXuegtqtE1YEqZN4bDL5sbyyZ/IAZp45/j1slnwhaOaLP38rdogc3H
         mejVkMgSTUC6CRG+TbsUaKd3JfXCEHEON4wyZbGLWxEVk2CHAFVDvJcamUyUWoiQzZXP
         +j0IE6yMKnaKzmbF4X6xs0RWwmrZvsld+pMzokDrVLev6SGJqVxeNM8dQQDZAED0VZo+
         y3ATMLnIBNwLBm3dHqdkw7MjUmbPpT3/VMOmaxAmmBQKxaSmvyAYrHgQvNCe+LUevsqg
         wqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxySBhmvimi4ZKs2eujmLdd7HTtzSlS7O6wcYvbvLCE=;
        b=pc0rZLSpq+5XkE6NwwArpsuO5GGkyn+7QWSdVSbUtAsp7tcT17aa+g01I74VUsjUFT
         wmOn/J4ennWPRtq1xLobvSlriXMRgPrZXSlO5g/apI91CgH1XbxN4888wgI3jjdj4/9Z
         dxrvzluC68cNyKx6zQ4/ByKPUSIVPEcxH4pwdDJ5QxXlUa16cQKSJBxg5AkSDBUrS8e7
         nQB9nwwDgdpCQMTNc/dV4Hzct2ubmZG9qjgYAUXqRTvM3EkM2R4iMp1i+X+dO9gJ8U0b
         VZ11+xl3GfrPpfJGPYWZMjoZdZ+MV3i9XCmwd1Xvyh6tQlTpI6UES0cRX4os8Ih0HyMd
         tehw==
X-Gm-Message-State: AOAM531NPdLDEFYiDPik3xah/otr6B93+YwwLmmZ1rregX8StxGpz/JC
        aqqQXwpfH1PemavY8ooIENKvDg==
X-Google-Smtp-Source: ABdhPJyPynATMhopF/SueiSrsW9YsQCEpPM++w6Vbi1wFmBLB+HBoSYhFYeMfP9tnzgSevyVlPTa/w==
X-Received: by 2002:a05:6402:7c9:: with SMTP id u9mr949994edy.387.1627491936074;
        Wed, 28 Jul 2021 10:05:36 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:35 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 06/14] bpf/tests: Add more BPF_LSH/RSH/ARSH tests for ALU64
Date:   Wed, 28 Jul 2021 19:04:54 +0200
Message-Id: <20210728170502.351010-7-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a number of tests for BPF_LSH, BPF_RSH amd BPF_ARSH
ALU64 operations with values that may trigger different JIT code paths.
Mainly testing 32-bit JITs that implement ALU64 operations with two
32-bit CPU registers per operand.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 544 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 542 insertions(+), 2 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ef75dbf53ec2..b930fa35b9ef 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -4139,6 +4139,106 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x80000000 } },
 	},
+	{
+		"ALU64_LSH_X: Shift < 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 12),
+			BPF_ALU64_REG(BPF_LSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xbcdef000 } }
+	},
+	{
+		"ALU64_LSH_X: Shift < 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 12),
+			BPF_ALU64_REG(BPF_LSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x3456789a } }
+	},
+	{
+		"ALU64_LSH_X: Shift > 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 36),
+			BPF_ALU64_REG(BPF_LSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU64_LSH_X: Shift > 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 36),
+			BPF_ALU64_REG(BPF_LSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x9abcdef0 } }
+	},
+	{
+		"ALU64_LSH_X: Shift == 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 32),
+			BPF_ALU64_REG(BPF_LSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU64_LSH_X: Shift == 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 32),
+			BPF_ALU64_REG(BPF_LSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x89abcdef } }
+	},
+	{
+		"ALU64_LSH_X: Zero shift, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0),
+			BPF_ALU64_REG(BPF_LSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x89abcdef } }
+	},
+	{
+		"ALU64_LSH_X: Zero shift, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0),
+			BPF_ALU64_REG(BPF_LSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x01234567 } }
+	},
 	/* BPF_ALU | BPF_LSH | BPF_K */
 	{
 		"ALU_LSH_K: 1 << 1 = 2",
@@ -4206,6 +4306,86 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x80000000 } },
 	},
+	{
+		"ALU64_LSH_K: Shift < 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_LSH, R0, 12),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xbcdef000 } }
+	},
+	{
+		"ALU64_LSH_K: Shift < 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_LSH, R0, 12),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x3456789a } }
+	},
+	{
+		"ALU64_LSH_K: Shift > 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_LSH, R0, 36),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU64_LSH_K: Shift > 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_LSH, R0, 36),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x9abcdef0 } }
+	},
+	{
+		"ALU64_LSH_K: Shift == 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_LSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU64_LSH_K: Shift == 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_LSH, R0, 32),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x89abcdef } }
+	},
+	{
+		"ALU64_LSH_K: Zero shift",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_LSH, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x89abcdef } }
+	},
 	/* BPF_ALU | BPF_RSH | BPF_X */
 	{
 		"ALU_RSH_X: 2 >> 1 = 1",
@@ -4267,6 +4447,106 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
+	{
+		"ALU64_RSH_X: Shift < 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 12),
+			BPF_ALU64_REG(BPF_RSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x56789abc } }
+	},
+	{
+		"ALU64_RSH_X: Shift < 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 12),
+			BPF_ALU64_REG(BPF_RSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x00081234 } }
+	},
+	{
+		"ALU64_RSH_X: Shift > 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 36),
+			BPF_ALU64_REG(BPF_RSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x08123456 } }
+	},
+	{
+		"ALU64_RSH_X: Shift > 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 36),
+			BPF_ALU64_REG(BPF_RSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU64_RSH_X: Shift == 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 32),
+			BPF_ALU64_REG(BPF_RSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x81234567 } }
+	},
+	{
+		"ALU64_RSH_X: Shift == 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 32),
+			BPF_ALU64_REG(BPF_RSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU64_RSH_X: Zero shift, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0),
+			BPF_ALU64_REG(BPF_RSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x89abcdef } }
+	},
+	{
+		"ALU64_RSH_X: Zero shift, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0),
+			BPF_ALU64_REG(BPF_RSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x81234567 } }
+	},
 	/* BPF_ALU | BPF_RSH | BPF_K */
 	{
 		"ALU_RSH_K: 2 >> 1 = 1",
@@ -4334,6 +4614,86 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
+	{
+		"ALU64_RSH_K: Shift < 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_RSH, R0, 12),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x56789abc } }
+	},
+	{
+		"ALU64_RSH_K: Shift < 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_RSH, R0, 12),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x00081234 } }
+	},
+	{
+		"ALU64_RSH_K: Shift > 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_RSH, R0, 36),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x08123456 } }
+	},
+	{
+		"ALU64_RSH_K: Shift > 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_RSH, R0, 36),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU64_RSH_K: Shift == 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x81234567 } }
+	},
+	{
+		"ALU64_RSH_K: Shift == 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU64_RSH_K: Zero shift",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_RSH, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x89abcdef } }
+	},
 	/* BPF_ALU | BPF_ARSH | BPF_X */
 	{
 		"ALU32_ARSH_X: -1234 >> 7 = -10",
@@ -4348,7 +4708,7 @@ static struct bpf_test tests[] = {
 		{ { 0, -10 } }
 	},
 	{
-		"ALU_ARSH_X: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
+		"ALU64_ARSH_X: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, 0xff00ff0000000000LL),
 			BPF_ALU32_IMM(BPF_MOV, R1, 40),
@@ -4359,6 +4719,106 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xffff00ff } },
 	},
+	{
+		"ALU64_ARSH_X: Shift < 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 12),
+			BPF_ALU64_REG(BPF_ARSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x56789abc } }
+	},
+	{
+		"ALU64_ARSH_X: Shift < 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 12),
+			BPF_ALU64_REG(BPF_ARSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfff81234 } }
+	},
+	{
+		"ALU64_ARSH_X: Shift > 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 36),
+			BPF_ALU64_REG(BPF_ARSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xf8123456 } }
+	},
+	{
+		"ALU64_ARSH_X: Shift > 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 36),
+			BPF_ALU64_REG(BPF_ARSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1 } }
+	},
+	{
+		"ALU64_ARSH_X: Shift == 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 32),
+			BPF_ALU64_REG(BPF_ARSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x81234567 } }
+	},
+	{
+		"ALU64_ARSH_X: Shift == 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 32),
+			BPF_ALU64_REG(BPF_ARSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1 } }
+	},
+	{
+		"ALU64_ARSH_X: Zero shift, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0),
+			BPF_ALU64_REG(BPF_ARSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x89abcdef } }
+	},
+	{
+		"ALU64_ARSH_X: Zero shift, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU32_IMM(BPF_MOV, R1, 0),
+			BPF_ALU64_REG(BPF_ARSH, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x81234567 } }
+	},
 	/* BPF_ALU | BPF_ARSH | BPF_K */
 	{
 		"ALU32_ARSH_K: -1234 >> 7 = -10",
@@ -4383,7 +4843,7 @@ static struct bpf_test tests[] = {
 		{ { 0, -1234 } }
 	},
 	{
-		"ALU_ARSH_K: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
+		"ALU64_ARSH_K: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, 0xff00ff0000000000LL),
 			BPF_ALU64_IMM(BPF_ARSH, R0, 40),
@@ -4393,6 +4853,86 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0xffff00ff } },
 	},
+	{
+		"ALU64_ARSH_K: Shift < 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_RSH, R0, 12),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x56789abc } }
+	},
+	{
+		"ALU64_ARSH_K: Shift < 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_ARSH, R0, 12),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xfff81234 } }
+	},
+	{
+		"ALU64_ARSH_K: Shift > 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_ARSH, R0, 36),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xf8123456 } }
+	},
+	{
+		"ALU64_ARSH_K: Shift > 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0xf123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_ARSH, R0, 36),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1 } }
+	},
+	{
+		"ALU64_ARSH_K: Shift == 32, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_ARSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x81234567 } }
+	},
+	{
+		"ALU64_ARSH_K: Shift == 32, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_ARSH, R0, 32),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1 } }
+	},
+	{
+		"ALU64_ARSH_K: Zero shoft",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_ARSH, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x89abcdef } }
+	},
 	/* BPF_ALU | BPF_NEG */
 	{
 		"ALU_NEG: -(3) = -3",
-- 
2.25.1

