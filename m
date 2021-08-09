Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B93E425C
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhHIJTJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhHIJTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D88C061798
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f13so23490234edq.13
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhJU/1ad/ZW3iZ05XUZhhQ+cb6MRN1NcaxmyJCG/h/Y=;
        b=du9Bj+nd1yctokvLRgNa8UZWXabh49I6ukxEghF+aZOCFluOGwzKHImMdRi0oQhIyD
         dHOOpEfJgIoH1YgBuJ+L7t6IaSUgBVwWUDdV3ltsOwzrbV8CljUUHbIK97JMiu7FSL4o
         3skrIm3Y0gM9GbSvsYpZRByNpDjA1hNEXE8yP29k/XokESaSNF0o8NBtxj5MhgdJc7Eo
         QSV8kE0SrE9+ciKZOltcLJ54QoY5mTwfbtE96KytE0RbhLBH1pL6p5y/auWZyIyRtF2k
         p6HU3DTXTZ1Vdg094FlxxztodH3vcl92efbg8xapd87YQUhYMIMNXNNxxAw0fHNgWFNL
         tvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhJU/1ad/ZW3iZ05XUZhhQ+cb6MRN1NcaxmyJCG/h/Y=;
        b=l5Zzyn6zGZn9DJsVEGJ4mc/lggccSJ7j9YxDzHGYzbWRxxq+4UWQcNeOu0f153ngqv
         Wycsk5pqlZBTEiqL2VnTKIytvqoNeVqHIKxHL9w8KpJ//1kN5ma5qQ0XHaE4zIyPsrSf
         k4S7YMIn/+KIeuPQrLGo4/hStYOus1dcnHBZv32XXhHL18JH7VKyyEQhJACMlfVecFB0
         HVFGkugS1CdQgt9yULfEq9Na5bHCTt9rVd7XwR3qZCYfRSUIzfEIESJxfg+/TG0sFurC
         cx/2yekjvQnVFM+cpP6inTFET5GZNZC0vyVWIuKCg8abk9USP1U+ot3OTHtahpgQheRQ
         65Hw==
X-Gm-Message-State: AOAM533Bp//Mr65bzs01uiLOqM5b0mAvszsmoCLv/W9IteuWYU+mDhj4
        jKrdhS2WVmTzIZR34K7PFxqDUg==
X-Google-Smtp-Source: ABdhPJyHNU/Oqc1arIj7/7asJ73vEnN3Wa7W4gtFcIQEgM+T+Ocw+p2U/nJ5+tDyNAY3Ef2kn5rkfw==
X-Received: by 2002:a50:a455:: with SMTP id v21mr11006484edb.369.1628500723253;
        Mon, 09 Aug 2021 02:18:43 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:42 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 02/14] bpf/tests: Add BPF_MOV tests for zero and sign extension
Date:   Mon,  9 Aug 2021 11:18:17 +0200
Message-Id: <20210809091829.810076-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
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
Acked-by: Yonghong Song <yhs@fb.com>
---
 lib/test_bpf.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 377e866764cb..450984433140 100644
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

