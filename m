Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888043D93D0
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhG1RFg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhG1RFe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0914DC061764
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id jg2so5823274ejc.0
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0fLhddyQ8T4QkXj3ygsOR4TrdqOBRtl+K0RjpG50f4=;
        b=g57FhjWNvwhHO2pi93lPzmBa9w+Q6VoSDlvknLXC/6dQl0BtG/rWnaaMcqmmgj5Exe
         9UrZY/VHrwV5V2Etz3jQcwPmhN2Q+k5vKN/S462HhCq9cx3o99o9yUbrpIf9lJXtYeP3
         WtdVOVmzs05iryFHH/yLtIFH00vJBd/17TKBsH5CS7Vp2g10y3Wh/RqBE/kP3KVqApXE
         mf+90r1W+NL7JVWw6iLpx1O7lW5OyueZ/1LkC/v8Lh1zcfeHlq4yyyZ51/SCpMb5RLIQ
         82NFDcfRv7NyBcXMbUNc63w9gYhww0NqAaWBiKZH7vvAkgndBKXMq3clkWluEvvB21uf
         I0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0fLhddyQ8T4QkXj3ygsOR4TrdqOBRtl+K0RjpG50f4=;
        b=CB2yY3MLw9mGOkXzLpQ4s/Gqkp3EDqIjNSJut6SmpcQFa+ZVLx2HcAjQyjz7sXcwa5
         J3tjf9lWnxspBo4alGc5+y4YIZseuQZMfzEET/JqzkSIqsui8up+yDTxQsE9d/YLmESh
         nahHusGYLn9ccHfRlfq1Uw/kEmB9rkqiD3biNyVHC9WQGb7FxBZXqm45WSaLocsr8BHR
         cuGv7y5hNo7FWjzEL0BpcDz+MnkGhAKadFUd/aXoqfme/3MotBkk2dZuzB7wEhk9UylS
         gZEC692qUHkOXpTRt+vgEvo0sbI9ilkVY5wjxq1m/dp7UC0HTiFvz7o1GVncdW80EQMc
         TNlg==
X-Gm-Message-State: AOAM532TykQ/QhMclbyKwWdEshBc68Q4qZCqF9HRSzyjbIhqA2qt3eQr
        y5/dqRnpUk6IwoLWvAHQZU1Lfg==
X-Google-Smtp-Source: ABdhPJzgc2WPN/RKRc9x2ZzWTYie4eo8PPHml9xPdr379XMXQAbdRCMnC2aswjr2q3dYz3hAiitdRQ==
X-Received: by 2002:a17:906:2547:: with SMTP id j7mr411811ejb.491.1627491931381;
        Wed, 28 Jul 2021 10:05:31 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:31 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 02/14] bpf/tests: Add BPF_MOV tests for zero and sign extension
Date:   Wed, 28 Jul 2021 19:04:50 +0200
Message-Id: <20210728170502.351010-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
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

