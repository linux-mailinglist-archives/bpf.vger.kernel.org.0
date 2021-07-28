Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773BF3D93D7
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhG1RFp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhG1RFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6EBC0613C1
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x90so4181653ede.8
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGsK7ThjsxJ/wrvHMZvAlJUC6vc2a5G3lwvkKPh4lcY=;
        b=uAXXGaiZSUeyuzgytsKoFoj2jEQ9uZwzaR2BVNYQa5zsCe2YF9WgLbB3omMY3EMZOn
         r07mqSQmSP5xLh9y+prgDMeGiDWu5saB51XVbhCd+EBzchBpW1GCqvN1nhz+NftnTX76
         HBP4ap7sPVf+qoQwLRV6XuorAKTO1Lg9BU97JanrlJKvjqXmq41vhvgKThjVvXm5cjli
         dRL7mD/sDwT1L38Ldy3aBxFbIERgYPdugdUvC8NWEZS9Q6ONKGte339ZrXFYDvdmYd7J
         cyGS56yyCGxs60+BYqOVmteajfl8GmzY2yI+8NdDFXscYYNuzd70GhHd7xC5qcw2wFhN
         l0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGsK7ThjsxJ/wrvHMZvAlJUC6vc2a5G3lwvkKPh4lcY=;
        b=OTJNTNILYG8qHDpoE/eXe9w833x7nAAOk3XNZ9S5K2N4V9qpWrPlRTYGCiDsQVF0UP
         3m5osBMroz2DAlE6Zd6B3Ez7sXThIyfipoCuOPUp9NeLnxPUf9flFb7ZYzqS4+tpKiny
         iee/yzyrbTDlYglmYOxJbdwRSluP2UmOE9tE3l7ir5/YIkDXtjkfSBUkT5cLy1E43mnh
         1ZtIzTHR8qi3aMmVh7aNa46A71yz3H7vtkY/XPMEi/3AWxPAN/27cOJdK8yiiEIe2j5y
         HeRIS8IdDB+9hXes6GGrECNRpALjtVoImRwizzBcgRaCkyEEaDMOIM9M2HQHuc8sClQC
         10Yg==
X-Gm-Message-State: AOAM530MycThFHN/x/VajDdPbkaMOGrEV/fiAzRufIC/8UOR6VXoYv5A
        VQ2d4Id2jPIHywJ4WWskX1LU/g==
X-Google-Smtp-Source: ABdhPJyGA/w/Zr5skiFil4r/uW54MD0fiOxpNpkX3SgvhV9TdXWa+waF95Ti2F25TI5tNlyy4v5Sjw==
X-Received: by 2002:a05:6402:d67:: with SMTP id ec39mr962037edb.117.1627491934895;
        Wed, 28 Jul 2021 10:05:34 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:34 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 05/14] bpf/tests: Add more ALU32 tests for BPF_LSH/RSH/ARSH
Date:   Wed, 28 Jul 2021 19:04:53 +0200
Message-Id: <20210728170502.351010-6-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
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

