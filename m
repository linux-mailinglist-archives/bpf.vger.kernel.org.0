Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B973E4261
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhHIJTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhHIJTI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A7C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cf5so23533337edb.2
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbyizB9gxwj0NE58Kfb+j2+wnsZFNVVFk5dXAvc0BEI=;
        b=pbE9GvYw/TSdKBK1CP/CuJzuworvD2ZiAic7W0XvlF+BfLHGPdPMn9qrm674y7IM/d
         onyVlpuZXJa4j9iqNrwmlnhQV0ELYfx4laOv/93i7Fn+KeoA9Le+NWJPyNwjdHSv2MCr
         nMK200KDQkxu2aYzlhkhGsncDuxd1dburMdcc9OXjdTPjs83VTOfdYWH+fPBzvYuU/N7
         UNtMbTw4HfQ9g2jJ/19o94WgxmslgPChODqTe0r8HkMIgubsypV3X7njq3Reu8YZx8Jx
         hMTwvdHnq5XE3goAp9HJG4hYYJkrm9YwzgR7BixMhLbWyyvKMhOSGwTLrCIP1/XmoK+z
         FowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbyizB9gxwj0NE58Kfb+j2+wnsZFNVVFk5dXAvc0BEI=;
        b=RTg1Xsm8gpSgqTc7FSkdCqHuRI6R40gkYFpSGYSm4JMm1+bH3l2Fw9kD0N8A3hIZQ7
         wjn8fBF+I1WwpJnqgyKfQrnjnsIcWy4I8UxyzdSLjlRy9j286fOidkwhU3xeQ6Q99QFw
         wIm/uaNvbrVQcP6h/NeQvUab//jPkCcACEEHS0Z5xDz0hvThde7JZjakpQv4iAKWJw0V
         5o9KGZIw67iho5UcgVRUJ+3PRhpzOU4PZjLNfuzsIc0mWFjFGFZCqxHGLo8DfS0a0Zwn
         clBBS+klcGrvfJ9EaFewh4Rm59Cl4KaT/gtVzSUND/nGVrBmCGF25nYpSTFHVps7RxI2
         MpDg==
X-Gm-Message-State: AOAM530HF/9alux3gzJXOmUrhSLsavbkSuf+SB7itm0oY+B2nw0ImC8o
        vO4MP2F3WBf733kuCWwEumV/Vw==
X-Google-Smtp-Source: ABdhPJz5KJp2EHRccEaqe9wORM4P1JywUN6mSX3H+0U8DQOeccx1/ycTC41FJnfV+GwFMQAtLoiOqQ==
X-Received: by 2002:a50:8713:: with SMTP id i19mr28865171edb.310.1628500726655;
        Mon, 09 Aug 2021 02:18:46 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:46 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 05/14] bpf/tests: Add more ALU32 tests for BPF_LSH/RSH/ARSH
Date:   Mon,  9 Aug 2021 11:18:20 +0200
Message-Id: <20210809091829.810076-6-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds more tests of ALU32 shift operations BPF_LSH and BPF_RSH,
including the special case of a zero immediate. Also add corresponding
BPF_ARSH tests which were missing for ALU32.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 lib/test_bpf.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 73c2ea0cb13b..8694b1fb8ff2 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -4103,6 +4103,18 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x80000000 } },
 	},
+	{
+		"ALU_LSH_X: 0x12345678 << 12 = 0x45678000",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
+			BPF_ALU32_IMM(BPF_MOV, R1, 12),
+			BPF_ALU32_REG(BPF_LSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x45678000 } }
+	},
 	{
 		"ALU64_LSH_X: 1 << 1 = 2",
 		.u.insns_int = {
@@ -4150,6 +4162,28 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x80000000 } },
 	},
+	{
+		"ALU_LSH_K: 0x12345678 << 12 = 0x45678000",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
+			BPF_ALU32_IMM(BPF_LSH, R0, 12),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x45678000 } }
+	},
+	{
+		"ALU_LSH_K: 0x12345678 << 0 = 0x12345678",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
+			BPF_ALU32_IMM(BPF_LSH, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x12345678 } }
+	},
 	{
 		"ALU64_LSH_K: 1 << 1 = 2",
 		.u.insns_int = {
@@ -4197,6 +4231,18 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
+	{
+		"ALU_RSH_X: 0x12345678 >> 20 = 0x123",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
+			BPF_ALU32_IMM(BPF_MOV, R1, 20),
+			BPF_ALU32_REG(BPF_RSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x123 } }
+	},
 	{
 		"ALU64_RSH_X: 2 >> 1 = 1",
 		.u.insns_int = {
@@ -4244,6 +4290,28 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
+	{
+		"ALU_RSH_K: 0x12345678 >> 20 = 0x123",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
+			BPF_ALU32_IMM(BPF_RSH, R0, 20),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x123 } }
+	},
+	{
+		"ALU_RSH_K: 0x12345678 >> 0 = 0x12345678",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
+			BPF_ALU32_IMM(BPF_RSH, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x12345678 } }
+	},
 	{
 		"ALU64_RSH_K: 2 >> 1 = 1",
 		.u.insns_int = {
@@ -4267,6 +4335,18 @@ static struct bpf_test tests[] = {
 		{ { 0, 1 } },
 	},
 	/* BPF_ALU | BPF_ARSH | BPF_X */
+	{
+		"ALU32_ARSH_X: -1234 >> 7 = -10",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -1234),
+			BPF_ALU32_IMM(BPF_MOV, R1, 7),
+			BPF_ALU32_REG(BPF_ARSH, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -10 } }
+	},
 	{
 		"ALU_ARSH_X: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
 		.u.insns_int = {
@@ -4280,6 +4360,28 @@ static struct bpf_test tests[] = {
 		{ { 0, 0xffff00ff } },
 	},
 	/* BPF_ALU | BPF_ARSH | BPF_K */
+	{
+		"ALU32_ARSH_K: -1234 >> 7 = -10",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -1234),
+			BPF_ALU32_IMM(BPF_ARSH, R0, 7),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -10 } }
+	},
+	{
+		"ALU32_ARSH_K: -1234 >> 0 = -1234",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -1234),
+			BPF_ALU32_IMM(BPF_ARSH, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -1234 } }
+	},
 	{
 		"ALU_ARSH_K: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
 		.u.insns_int = {
-- 
2.25.1

