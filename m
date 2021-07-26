Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21ACA3D5547
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhGZHiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 03:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhGZHiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 03:38:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D80C061760
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id da26so9471364edb.1
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0fLhddyQ8T4QkXj3ygsOR4TrdqOBRtl+K0RjpG50f4=;
        b=PYXkem0JO/gFvvWLr+f17JWiKnJLjmpkOfIw3/xeJpNQgqfLa8xv33fVBA5/3fft1R
         icCfXav2uwHNGPFM37hCQejNt3uVm5HwfSvQlogcYAYFhsRvW4QYzFKoL0gtSKs91oN2
         /yTl+mnoGAGkZmky6ME0vcOUtX+bezWTBlTamNWSSFMfBZC0dgfJzVkwnqSEg8gAHEGD
         sRJFF5JoQXBhq7ZjgL/JPx4HZWlM2zQUt2AoNpBGQkfUkT3fkEW/y1aZ/IdwMGgLQAiw
         d8SaZjWkJTJNzE2eB2l/BGQaWOswbrp2e1oUI3484bTa4OZ1aGVTzq1HwSBwq2XIp2oQ
         X54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0fLhddyQ8T4QkXj3ygsOR4TrdqOBRtl+K0RjpG50f4=;
        b=AGvxll7aEKRNm3v2uDyUADpai2wAZUBRNhkfblpCxvIaFLopS9irmk/6D+bbrAnN7v
         WW/hDEruGHf98eKOuUwjITeDhdNP4Gi6su4QYcwOpoJsbzeBhytO2ZbX1Xs2QILC7lSR
         V7GhcM705S7/D2z0I9y9sWfLG4vGlkqQJQEsIMeOcFzZGJF3z3P3OQ0QtFOz1SpIURiL
         MczhHDT967b0M8HToc3L64J4HVQAJB7paPhewPtocB7+e75QMPe5ci8KPbbChq64M3f6
         5PmuDhGAvDD7Tjvfgs+3YmhKB+dZze+OEHD1ZIGBwm7dm1y4c9S1MvIYN5pqXGqW26We
         iEzw==
X-Gm-Message-State: AOAM530Jx9B/lCXRRVsVWTydiJCdL3H2v/deLHT74ntLOLtZSLzZAfj8
        /UjA9Icr32KOEvIfpdXMatgt9Q==
X-Google-Smtp-Source: ABdhPJyueG1w/H3FrhZQV+QerLdASplkXLL6MR0e6fLkQuWUFCkR3l7eFgHSSQokPcfRSNd/4TKZzw==
X-Received: by 2002:aa7:c588:: with SMTP id g8mr2227599edq.33.1627287510395;
        Mon, 26 Jul 2021 01:18:30 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id q9sm13937539ejf.70.2021.07.26.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:18:30 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [RFC PATCH 02/14] bpf/tests: add BPF_MOV tests for zero and sign extension
Date:   Mon, 26 Jul 2021 10:17:26 +0200
Message-Id: <20210726081738.1833704-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
References: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tests for ALU32 and ALU64 MOV with different sizes of the immediate
value. Depending on the immediate field width of the native CPU
instructions, a JIT may generate code differently depending on the
immediate value. Test that zero or sign extension is performed as
expected. Mainly for JIT testing.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index bfac033db590..9e232acddce8 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -2360,6 +2360,48 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
+	{
+		"ALU_MOV_K: small negative",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	{
+		"ALU_MOV_K: small negative zero extension",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
+	{
+		"ALU_MOV_K: large negative",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123456789),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123456789 } }
+	},
+	{
+		"ALU_MOV_K: large negative zero extension",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, -123456789),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } }
+	},
 	{
 		"ALU64_MOV_K: dst = 2",
 		.u.insns_int = {
@@ -2412,6 +2454,48 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
+	{
+		"ALU64_MOV_K: small negative",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, -123),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123 } }
+	},
+	{
+		"ALU64_MOV_K: small negative sign extension",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, -123),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xffffffff } }
+	},
+	{
+		"ALU64_MOV_K: large negative",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, -123456789),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, -123456789 } }
+	},
+	{
+		"ALU64_MOV_K: large negative sign extension",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, -123456789),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xffffffff } }
+	},
 	/* BPF_ALU | BPF_ADD | BPF_X */
 	{
 		"ALU_ADD_X: 1 + 2 = 3",
-- 
2.25.1

