Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC73D554E
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhGZHiL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhGZHiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 03:38:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A298DC06179A
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r16so9422824edt.7
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pe63UuYeIyMU5x24QHHmiSesESIJt/GDpBcNT8fOBl8=;
        b=F6T8Uz6hzhiXRRAV4usgHT6lK2GMu9oUQ3rnD/dLnwYxOy1qGADhsOMoPdYDQ7CEr1
         uUc+vmZGwjoQeSZqJ4AW1aTpnx7Dv/oDL8JdsTdekA5nUXHXBMoIB7YzEX56U29QcBHL
         PFw4fHLf0Jj3awd+HTBUY7HbTchdUGUM8eg5Up7yFef+9sqZ0oVTDuNzuf5VGkPTjXTa
         SS78bA15b0nnmbAQ1V9fTCFkSDWPPIBvz6/i3O+0rjYjejfUVfd5WuTNfVJcPpCsSPTK
         J3wcty5T/t/1p7vBk2pn5y+JFcQxx9aIfTLWG0IN84W9TFAkXmDO5V8OuIeg878nsmYa
         IaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pe63UuYeIyMU5x24QHHmiSesESIJt/GDpBcNT8fOBl8=;
        b=RFji+YpeKeWF4d1AsuQ1vpoWQ4EcOo18FdBpmE+LPHBLZj5ZzSrtxy4/tyvlJKk6SC
         DVXS+Js7spotbwKsFDaJuNN12OFfSgqnxejPK7j0E4JyA2KfXbIH2EXdDF5K2DNnxgBb
         P5ssBLkank9ENobV/7001z235eKiLWG6qkAZ6UhDQq0g93fIRAo0l+gfYDbJMUomsLb+
         q9NZLIl6Fw9W8VmzzKFytrVZ3bMINVpLEaMo8qcfuTiiilPVkgrsgtmJGvtn9Jovugr3
         zkVHzZAJrAeA2tQisha4tItUcKuNOkKFmy0YcIDB1GvBHfCbUmk7BljSu0ctL2AhC3KX
         7yug==
X-Gm-Message-State: AOAM533rWFYLMQwKw9HAlt7DzzT4QGfM+w1j8mI5H4nlp1K3Y+elk9Zn
        uTjgwuPU2e50mTuY/BNkQIIgMA==
X-Google-Smtp-Source: ABdhPJxsj7TUeD/MhCb0dnq093f+QC5sb6m1zkiAn20HJylcLFJSYXJAIO0KBKlyIya4KFdhodTL2A==
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr20996166edb.175.1627287515330;
        Mon, 26 Jul 2021 01:18:35 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id q9sm13937539ejf.70.2021.07.26.01.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:18:35 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [RFC PATCH 07/14] bpf/tests: add more ALU64 BPF_MUL tests
Date:   Mon, 26 Jul 2021 10:17:31 +0200
Message-Id: <20210726081738.1833704-8-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
References: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
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

