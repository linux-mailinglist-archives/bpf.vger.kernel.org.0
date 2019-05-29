Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274CE2D9BB
	for <lists+bpf@lfdr.de>; Wed, 29 May 2019 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE2J5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 05:57:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32903 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfE2J5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 May 2019 05:57:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so3959349wmh.0
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jpSPhEMnAmO72c36jozRGy3en6RbnZtMfYABOBGP9fI=;
        b=SnJgyIROlVGCnowCqxlmVmK5rGx2jimHFbeQdgzL4OHoSH4gPtyknBoZEgATtrvrAn
         JJtuKtiKi5UoZywzymah01UA5Fv7Hf6DIzCZ/R30AgukwtbNM3ahSG8WkE++zLQpHI3t
         0JYL5/67h4pm1M5rRhRf+Elq1rUrv/GhJgp+10STbB5yiFqeD1eg6oewo2z1dK/8eiYK
         kGMslYNzkU9bUOncXlbQ/TvT9n3gs9zHP84Pl4no1H3V7kHmT5WbqmRpU9JYtyXpN+SY
         9hWWOe7x21jRo+13Zm+4o7kOCqttOD6oLiIISoVoAMCh5VY5cCPQjfjiwd0TTNONkl+a
         BzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jpSPhEMnAmO72c36jozRGy3en6RbnZtMfYABOBGP9fI=;
        b=rLiLvdbKT9pk0caR2sMebhWEDBCW4fljPxicFr59jqHvGNl7xpUKwEdd4ljdNHrfP3
         El4Ip84Zkekr2pnsJKm/+fWgOPMfEPmCDWK9WoPfu5c7VDgm2lV3mx5y42Sd6yQinf/I
         eeXTsjhrXT/guF3EhorgndlItshzzfPAlqaHyz92QaOAxVnQ1BkQn3jZnsaaHIkTk6nX
         IrS3ojVnh7dP8WS0S7cMPAI+txiChfQJeM+7iAwRYzAoGGsPs/4yax5WsKzUtFwkD5kR
         ZMrK7zHDZZudlu0K07a5NdF1mf9CJCQsqawb6JZqJexDjg1ZuHUFMTFiIQ2i4CCeePze
         MPLg==
X-Gm-Message-State: APjAAAU3JikofeVSwMAVgzRJASNqr25/qRNlJUmGQjSrNKQoUphtqPi1
        vm1SN2XETwWKZVY9TrIkDKbSNQ==
X-Google-Smtp-Source: APXvYqxp1xuoXVxEd2BOxUqqJJKeCQ2XrmJn1Plw0Xt/b5b+7gUpkX6OJr1rjqQeorMUjc6YhwgPmA==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr6539404wmc.43.1559123839129;
        Wed, 29 May 2019 02:57:19 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 205sm6322206wmd.43.2019.05.29.02.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 02:57:18 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bjorn.topel@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH bpf 1/2] selftests: bpf: move sub-register zero extension checks into subreg.c
Date:   Wed, 29 May 2019 10:57:08 +0100
Message-Id: <1559123829-9318-2-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559123829-9318-1-git-send-email-jiong.wang@netronome.com>
References: <1559123829-9318-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is better to centralize all sub-register zero extension checks into an
independent file.

This patch takes the first step to move existing sub-register zero
extension checks into subreg.c.

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 tools/testing/selftests/bpf/verifier/basic_instr.c | 39 ----------------------
 tools/testing/selftests/bpf/verifier/subreg.c      | 39 ++++++++++++++++++++++
 2 files changed, 39 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/subreg.c

diff --git a/tools/testing/selftests/bpf/verifier/basic_instr.c b/tools/testing/selftests/bpf/verifier/basic_instr.c
index 4d84408..ed91a7b 100644
--- a/tools/testing/selftests/bpf/verifier/basic_instr.c
+++ b/tools/testing/selftests/bpf/verifier/basic_instr.c
@@ -132,42 +132,3 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = ACCEPT,
 },
-{
-	"and32 reg zero extend check",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_MOV64_IMM(BPF_REG_2, -2),
-	BPF_ALU32_REG(BPF_AND, BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"or32 reg zero extend check",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_MOV64_IMM(BPF_REG_2, -2),
-	BPF_ALU32_REG(BPF_OR, BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
-{
-	"xor32 reg zero extend check",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, -1),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.retval = 0,
-},
diff --git a/tools/testing/selftests/bpf/verifier/subreg.c b/tools/testing/selftests/bpf/verifier/subreg.c
new file mode 100644
index 0000000..edeca3b
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/subreg.c
@@ -0,0 +1,39 @@
+{
+	"or32 reg zero extend check",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, -1),
+	BPF_MOV64_IMM(BPF_REG_2, -2),
+	BPF_ALU32_REG(BPF_OR, BPF_REG_0, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"and32 reg zero extend check",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, -1),
+	BPF_MOV64_IMM(BPF_REG_2, -2),
+	BPF_ALU32_REG(BPF_AND, BPF_REG_0, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"xor32 reg zero extend check",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, -1),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.retval = 0,
+},
-- 
2.7.4

