Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB53D93D9
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhG1RFq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhG1RFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE89C061796
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r16so4192656edt.7
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pe63UuYeIyMU5x24QHHmiSesESIJt/GDpBcNT8fOBl8=;
        b=WGtY+++TLY6T/IMgDHaKgIFx1Aw7rqwzXPSjDHr9+r5RpefXYxU+un+luzXZRrO4EH
         EIFM9rDBvrLLi9xXrNKg78dF5idiiAOPg2Cz3aJKgMjXU7/FmGE7Eal1BunqjSrV0Mt8
         e/uQq1HiZiZl/La7bIv5ACs6LOrSBQWMNJ6MkX3xV65X1j3L3kTXxckppz5YFNTpE6Gx
         ws1NMvik6/BN888cnmITvbRV0JFk9s35sCMPVw4MX0Dlz4Ys264+7fiip+/3XPoID4Mn
         lTSKTCjcdhQo2wiQhSmw8yc4QddeQX6b07voZRjenB9zr9PggXVPyO+gIp8o+8Et7vxp
         jLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pe63UuYeIyMU5x24QHHmiSesESIJt/GDpBcNT8fOBl8=;
        b=Oy/y3Qh1bq9Ctn/q7e+9xQpMaa+RW+8z7Zgoum5pSDDGmiUBQdtFFNcEoShCbWpJpv
         nzRaVFcpjZmnFqgxG5MrWWcKXW3b5H4Ye0zpRvbbga3nqgwmeiSYaA/4KHt4d58HhxwR
         7nBCG2+tQcw/jSXkdRhPQY21Xw6ubiiTmwLDoHvRSBcSYfGlPr4ORoA4YlET0R0XvFVb
         8eolqzFAfExdheHkYj8f40hVrJ4DkkFBq9wu/ovaVKaZjYW733e9WJxvQSNf9rXee09M
         US0uICmqQM7mnvO2hjoMXw6ALVlCqiAY/wSbMa5QrmrK6Dt5JviDohb9flYymsZR+h96
         HQnw==
X-Gm-Message-State: AOAM533Prow0GaZtnPqwkCNFED1sfJdbMfiFoDXBcYe460UNqtDWVcvl
        285pnn4cdlW6JvjaCkK2Gsp6oQ==
X-Google-Smtp-Source: ABdhPJw2eyzsO92f9niYPFPLfLvBxvF1Dy0y1ScBOfA9gO7bDCKXU4v3/kzRKGX/DXHdRv1U1zdk0g==
X-Received: by 2002:a05:6402:2074:: with SMTP id bd20mr981974edb.123.1627491937197;
        Wed, 28 Jul 2021 10:05:37 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:36 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 07/14] bpf/tests: Add more ALU64 BPF_MUL tests
Date:   Wed, 28 Jul 2021 19:04:55 +0200
Message-Id: <20210728170502.351010-8-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds BPF_MUL tests for 64x32 and 64x64 multiply. Mainly
testing 32-bit JITs that implement ALU64 operations with two 32-bit
CPU registers per operand.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index b930fa35b9ef..eb61088a674f 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -3051,6 +3051,31 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 2147483647 } },
 	},
+	{
+		"ALU64_MUL_X: 64x64 multiply, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
+			BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
+			BPF_ALU64_REG(BPF_MUL, R0, R1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xe5618cf0 } }
+	},
+	{
+		"ALU64_MUL_X: 64x64 multiply, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
+			BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
+			BPF_ALU64_REG(BPF_MUL, R0, R1),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0x2236d88f } }
+	},
 	/* BPF_ALU | BPF_MUL | BPF_K */
 	{
 		"ALU_MUL_K: 2 * 3 = 6",
@@ -3161,6 +3186,29 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
+	{
+		"ALU64_MUL_K: 64x32 multiply, low word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xe242d208 } }
+	},
+	{
+		"ALU64_MUL_K: 64x32 multiply, high word",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
+			BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
+			BPF_ALU64_IMM(BPF_RSH, R0, 32),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0xc28f5c28 } }
+	},
 	/* BPF_ALU | BPF_DIV | BPF_X */
 	{
 		"ALU_DIV_X: 6 / 2 = 3",
-- 
2.25.1

