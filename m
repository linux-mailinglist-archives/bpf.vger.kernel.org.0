Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC183D93E0
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhG1RFv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhG1RFp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FAFC0613C1
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qk33so5671273ejc.12
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/3mORpxkuB6AYmO7nTlUm+T8wNLmTVSEafeQ3TI9HU=;
        b=zTu9BEJ85uqBUflZ6s237uQXXVTvtcUIoDa4B7I+Xpk/GkZZKhT3HedOepeMz44QsV
         FLvpDFG9Jnp5Bj+TsAGeQiKHYCxnAPiJGaxjZL/l8EHLHv/vYopX+lL4YQ0sLOXR0GBi
         5nrNdrsMX4qmfBbXq0tQpcaK6eyaxvWeIi244jQTk2YRv2eDjzeATP8Uu2Do22+bPd0V
         qh5w2lQsYrpo1KRcBEP0I16JDnTPVI1y91d3icXSOLxTnf3bO3Nt+IICNp1XW0XMyaUr
         yARW8shycR6cDdVHbX3WBYLsvD3oN5qOwu4KWMH/bcH2qqjTz9NeDocsEHQPVwAy1PwU
         Togw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/3mORpxkuB6AYmO7nTlUm+T8wNLmTVSEafeQ3TI9HU=;
        b=eRsTyoQWm/LrUJhm3/mBCGh8l0wpgazWD8ugPKXv9YN/XM6y/wOf9MMeVysGqKXhGv
         ZvL/zoWC8NXgPz960E6DqG4LUGGcbCa5dRvTq3JlyjP/47hfJlHDNQcI7o3WltvOFiR3
         YYxIR0SMuEMv8zpZUIYXl3GY1UB2W1Vu8PbZFuhMS0luN5WYDieVlyFgLp/IHInuWV8h
         Y0ty+ThgqkheUqYzCOlUeumVYJIQeN+T5sXef6fXC/rINL8oVXZPkPUi/iK5iwQukRD2
         3a8rOVb+E15CxNAkMRpcsDWawxgwRk0oBBWpjp93zTM2UI5av6UVm6CcAfEMPtzyjSlB
         fA9g==
X-Gm-Message-State: AOAM531qsMHwGdQ2oys1/KVglzCE6en926RtroilxovylKMGuBkr1i00
        t9GDlOCxAIFwNKOruWO3Ov7f0A==
X-Google-Smtp-Source: ABdhPJwW0hs5zOM54rAu+DDEexNEk6cdseE/NOgpp6cQ95uX4fbZGbYENYE9CSAxlsGjaurpjeYekA==
X-Received: by 2002:a17:906:b0d4:: with SMTP id bk20mr406826ejb.535.1627491941786;
        Wed, 28 Jul 2021 10:05:41 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:41 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 11/14] bpf/tests: Add test for 32-bit context pointer argument passing
Date:   Wed, 28 Jul 2021 19:04:59 +0200
Message-Id: <20210728170502.351010-12-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On a 32-bit architecture, the context pointer should occupy the low
half of R0, and the other half should be zero.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 55914b6236aa..314af6eaeb92 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -2084,6 +2084,22 @@ static struct bpf_test tests[] = {
 #undef NUMER
 #undef DENOM
 	},
+#ifdef CONFIG_32BIT
+	{
+		"INT: 32-bit context pointer word order and zero-extension",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_JMP32_IMM(BPF_JEQ, R1, 0, 3),
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),
+			BPF_JMP32_IMM(BPF_JNE, R1, 0, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
+#endif
 	{
 		"check: missing ret",
 		.u.insns = {
-- 
2.25.1

