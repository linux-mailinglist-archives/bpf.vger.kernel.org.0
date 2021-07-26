Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE463D554C
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhGZHiK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhGZHiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 03:38:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB42FC0613D5
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hp25so15022564ejc.11
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGsK7ThjsxJ/wrvHMZvAlJUC6vc2a5G3lwvkKPh4lcY=;
        b=Wa6yqxvlcdQYjwEQVSNtVAFMke4N97e9GBHZDY6nHI2ICNG+m1DMU+KvkDdEd1etYp
         +XOydq0goa91pYLIztZWwLi0Qb5H+BcV4YnxcZI/JNrW6gmQ6HAvK60ZM5UYFkyOn28n
         yftYZPTPLjM5k2WkT1YiqayvaGDJdi+5pxKjtZV9F3xp5Co6KASf5loqoVWbs62BN9mM
         cGKdFa+E/aTceR5iam5grXciLf6aOe1CZgPCh3Jcu9m+it703YRSiLKY4z+PjGj8CKpi
         P2ZOGAAhq5nV7v0B85GUZJ7oyOmeEAq6eBPSJHCKXa3ZGcHHZ7oXuHBNMd4C8xZjGHcl
         4gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGsK7ThjsxJ/wrvHMZvAlJUC6vc2a5G3lwvkKPh4lcY=;
        b=hYdyTyzkXjED+phFcnzB0PBhXbBycSiSujpcoYPegwI1PGiYtfUpltWfZlX4ESaN+v
         2WWZdTZJYB0+c+B63D2spaogiMh7XHhanBWBUuiHPnsY0ezrbU5jfQvzf7PII5AiunWu
         xK1v87plu81Ve5P+cLABBoFlPtWw0eLSxMjkuZSu+ATQPTkDFgMriRTASKy7Bs2QdNrL
         wmsQmniOAQiQYs/5H2dNaPqrsXiYppp4h8R8C0e92J14v6DsuzLdivTM7VLyV2LbhLw4
         ArfLAo5WH7TNLhIv0ktYdhT+qs0IuQjGzpXevPqDPdSdWF2Y6jVI9uV7J2sIjR0a+WsJ
         NCgA==
X-Gm-Message-State: AOAM531kntyYY0HxO2E8ahc1tALZ5hYKc+GzFsaMKF8EoS8ygZ2FONld
        LppHJSVISTJD1OOqAXoMW+LhQA==
X-Google-Smtp-Source: ABdhPJz/95pPa/5gn9HjaR5/wNjZNYRzLim2OLDmf7N3ea1OvQXuFhEo2wsSWweDjEGRsO9dBKD0mg==
X-Received: by 2002:a17:906:8a98:: with SMTP id mu24mr4590505ejc.404.1627287513408;
        Mon, 26 Jul 2021 01:18:33 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id q9sm13937539ejf.70.2021.07.26.01.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:18:33 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [RFC PATCH 05/14] bpf/tests: add more ALU32 tests for BPF_LSH/RSH/ARSH
Date:   Mon, 26 Jul 2021 10:17:29 +0200
Message-Id: <20210726081738.1833704-6-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
References: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds more tests of ALU32 shift operations BPF_LSH and BPF_RSH,
including the special case of a zero immediate. Also add corresponding
BPF_ARSH tests which were missing for ALU32.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 67e7de776c12..ef75dbf53ec2 100644
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

