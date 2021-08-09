Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DCA3E425E
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhHIJTU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhHIJTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3868BC0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x14so989207edr.12
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSVyFp6DtLsnXMsAt17DWyMXTqIqmaNFH1NbMMfuogQ=;
        b=RPRBsP+7e9qrRBaxzthWRsefdrbfbgYfk+usx/0Knps5hnaD170DQEbpdY3weSiFIW
         aNGSMNpZi0DdbKmPlAfSGjBEjHktIOMTzmTzmbA1+++1RFakTJsYQnU3xBxtJTQ0hnVS
         jscpm6jPN+X96kvnkhXJ1WGshGzEoIGdPakPF1LmEvC4qPFUVzmDMs6y7HfDCMFdooIf
         9eanhVaf4A80tbovuCoJsTK3WrfWxExsJuhiXzBOhILFgYIvfOt43i0nHMEp/E4ahHDw
         pqyeb4+K4AEIGD/8D6gugtwTtyaQW5OcLDjDthEUM4os67vXnUdLVlFNP5lZn6GsarPb
         YvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSVyFp6DtLsnXMsAt17DWyMXTqIqmaNFH1NbMMfuogQ=;
        b=NAVojuwPJniaDXa3tewbLXOmr+66wGpspwGbhvWPaqG59vOjY+BzS6nWTM1kfoKAqD
         21cGVtkfFUykrmLPptQr++3SxU/DJ0/tnjBjfdNWkIEcCq/rygJL6qdEnvbpBGs+c/qx
         c4hxIu1/fN/zFSzGem8edTCzj5/TtAyHiG/AUxcMT42DBD5u5OThHOY4C3D/eMHKW7r7
         r7jkIVgIxadate+saH5IJS0ycpl1OUlHRkW5c4XAxBv8j/7nprnxYNJ0kgKSLrhtnffA
         UTEWAFvb+1rwH9GorQB4d583pzi1CtwytSs2lMUfemKmt6B+lonm8fA2G+pELjp3Snkt
         SoCQ==
X-Gm-Message-State: AOAM531dMDQuQ6dOac52/c7nqIcy1hCY6xTPVEDVbSjmSJ5vT/J0g7z4
        KUC8Cten6WIjHx1KVUWYjJQ/ZA==
X-Google-Smtp-Source: ABdhPJwnn0EBQTz6HZFwbxxITWzQMPXsZr/82+xKhmli7coFyKB9Rrglt3icyYJx5/PSNb3RMuh8tg==
X-Received: by 2002:a05:6402:51cb:: with SMTP id r11mr5026173edd.270.1628500727757;
        Mon, 09 Aug 2021 02:18:47 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:47 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 06/14] bpf/tests: Add more BPF_LSH/RSH/ARSH tests for ALU64
Date:   Mon,  9 Aug 2021 11:18:21 +0200
Message-Id: <20210809091829.810076-7-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
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
index 8694b1fb8ff2..b95bed03ab1b 100644
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

