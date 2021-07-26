Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F43D5555
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 10:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhGZHiT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhGZHiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 03:38:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6DDC061764
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nb11so15214184ejc.4
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/3mORpxkuB6AYmO7nTlUm+T8wNLmTVSEafeQ3TI9HU=;
        b=EFvWIrJE9buKJTtSmYumCJi3hFL4WZmcPxtCdFjdk5lMga9XOXZSnauRqVtE548LOA
         Lb0VxpPl9RohHkR4FjN1FYj+8Nf5ybpd7mwKbfvCR6t9JWPIwvf6iKnyEq1dhysyFa4S
         oOUPfiHHlS3tS4RhbqwU3GfXK0BKniOZ3MaBPMfb9jJE3/mag1KEGPiqt4lcJw6kVcBO
         O6viSgdfPuAwNw9nAx/5LrcEmuUjOb9JXD6r8PbIEBoK7fn/KQoZheP2kkjKjocfGS3o
         86FVVFhfQjxucN6od5ll//wJtt9A1nO1CWcBNTtk3R8bQ1rxuOgjdDcYdP2sIlW6Djf3
         6gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/3mORpxkuB6AYmO7nTlUm+T8wNLmTVSEafeQ3TI9HU=;
        b=uOjEI1mucbdu3z0PakoF3e4QC+G9r9iPQC4SJFN9spnTLxZm5s4GvMs2EKFNdrt9X3
         G+0aXvCq25RNbs+EU1CawHT4PrjcW3fdFv+uMHnE+ZO1ZKKmtYReE3qQgY1SzVnN8j2i
         JOxRML0H52/c/A3ljJpA0zbQDP+ep6S0UheNdENLlZmZzfItIdxrJ8JPN+178lDMa/Tu
         r1q6becmYciMUqSc19dGu1X8vzXSbYgWLlViLqXoSqBO8SV95o+7Le1m+iapkFB5Ljnr
         coih79P/R8as5Ye7FFTV86H+T2atqMBQUGAbOWsHGj7atpOAPhX2GRDE51VrdGSOnrUj
         EqZQ==
X-Gm-Message-State: AOAM532lpR2AhHaYTZOOWfQvY5jv9gNzbyNTjF6CE42kCPcvL1e0o2pG
        p54QsfrJNf3si/MCxmlHy4Iimg==
X-Google-Smtp-Source: ABdhPJxXWdghP9RHL8bsAIg3jvfVJ7efL+iEYI85sKehCFcC79s1Z7VaNWf/kzxm6S53XxURP48wzw==
X-Received: by 2002:a17:906:ae4d:: with SMTP id lf13mr16053726ejb.355.1627287519177;
        Mon, 26 Jul 2021 01:18:39 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id q9sm13937539ejf.70.2021.07.26.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:18:38 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [RFC PATCH 11/14] bpf/tests: add test for 32-bit context pointer argument passing
Date:   Mon, 26 Jul 2021 10:17:35 +0200
Message-Id: <20210726081738.1833704-12-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
References: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
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

