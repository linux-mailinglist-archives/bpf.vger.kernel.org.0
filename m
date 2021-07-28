Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B233D93E1
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhG1RFx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhG1RFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF39EC0617A1
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qk33so5671061ejc.12
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BV0g4jcYTdScS9hJerOKHAsgtkMy07OGBzUAP0n2p64=;
        b=1EgDVk9XUee01DEmamomECqencYCWb2Ifv2YxRfl7pH5T2RMdU1eiUTJlK5KDymJqy
         FRLGUunnhkJ5nzBS+NwSGtZbE4YarPRnjKxWkoYYdSsBMDPZ2BIjSrFXrUiGQ0mhsHzE
         mj5tsOePVxIqEnuuwtGN21h2cOhrA4h+gGAEoYGGzAatKWXRKt7f9CzPyPfBlVvrtGHG
         1WSGLJif8lCm0ySql4Ra8gw79drNQFybMaftu98EiBMbIi/1uraQtD29Nhh8/TdyCBhd
         jgnHSM9862GCOaV/0/7npj1WdwK1UuYjj/1L+9qG2PaNEZHcbXmRuz0zlGSUvFS+NGi0
         1csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BV0g4jcYTdScS9hJerOKHAsgtkMy07OGBzUAP0n2p64=;
        b=HdHOutQbNdyrtjvX7eZL/W3oZN6zQzmbjs5QdXY1f3USxi7dW4bJ1V0Ghn5vFOn5J5
         9UHDDyDCwrpmdwTE0ebSLX4k14kZJppYcXIQ6pJJGm7I5WgOQwPKi6ZVmQPrJpPmczXW
         l8bsfWmB1tlYM1G765mzzk9Zx/n/t6+Q3DGbScUOmzqoopetmOgST4kr2Eb4+7+f4HBQ
         RZMSHIr4VdyYuYTrYPee5+n+wG0nyn0UcOBzuEBlyjT7mUT3pPmWYjTsPdMUJkepsAGr
         ekZ7ZVWnUtZg95U1yd7rlzLLE2h5X/e+lqQ9rJ4iGS+LV+ZHXE8mPRH9HO/udfsYOQqs
         J2yw==
X-Gm-Message-State: AOAM533lRUSQerjqqfSBBXe/kfurjpo2sRzqUmSZBdUKAqwip1B39hYT
        CkQ55at618dGuYlygTJcC4uWzw==
X-Google-Smtp-Source: ABdhPJyTLyPC5ZiZNt2Ngm4s3tutaX0w/34TS6SZRQIGzuL3DPp3wub2mKwX4tEHkThI6HQS+5StbQ==
X-Received: by 2002:a17:907:1c92:: with SMTP id nb18mr458345ejc.191.1627491939489;
        Wed, 28 Jul 2021 10:05:39 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:39 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 09/14] bpf/tests: Add word-order tests for load/store of double words
Date:   Wed, 28 Jul 2021 19:04:57 +0200
Message-Id: <20210728170502.351010-10-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A double word (64-bit) load/store may be implemented as two successive
32-bit operations, one for each word. Check that the order of those
operations is consistent with the machine endianness.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 1115e39630ce..8b94902702ed 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5417,6 +5417,42 @@ static struct bpf_test tests[] = {
 		{ { 0, 0xffffffff } },
 		.stack_depth = 40,
 	},
+	{
+		"STX_MEM_DW: Store double word: first word in memory",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0),
+			BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -40),
+			BPF_LDX_MEM(BPF_W, R0, R10, -40),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+#ifdef __BIG_ENDIAN
+		{ { 0, 0x01234567 } },
+#else
+		{ { 0, 0x89abcdef } },
+#endif
+		.stack_depth = 40,
+	},
+	{
+		"STX_MEM_DW: Store double word: second word in memory",
+		.u.insns_int = {
+			BPF_LD_IMM64(R0, 0),
+			BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -40),
+			BPF_LDX_MEM(BPF_W, R0, R10, -36),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+#ifdef __BIG_ENDIAN
+		{ { 0, 0x89abcdef } },
+#else
+		{ { 0, 0x01234567 } },
+#endif
+		.stack_depth = 40,
+	},
 	/* BPF_STX | BPF_ATOMIC | BPF_W/DW */
 	{
 		"STX_XADD_W: Test: 0x12 + 0x10 = 0x22",
-- 
2.25.1

