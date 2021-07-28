Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95F3D93DB
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhG1RFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhG1RFp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045EBC0617A4
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r16so4192913edt.7
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRL0VLp6qutZXrZd4cRKeYTVqt51qEo+4j74ZFYX/gc=;
        b=KRfqerB4VTDxxbA3y6UzEebVUH0ALRUnLBb3IjTdzlb2dtDlof8ZjWQUf7+xVeZDOP
         TtaWQ+fntm89vMX06hrbgCd0IcGVvDItsvRthw8CxsAjQWmp0IKG3YH9rbTyMiYuoMN4
         o9a655OWi10lrM2U1wdtz9EgSH6ddQvwa40jvo59XqtkL0L8ElFqip1aowa4Cdk5ZSmk
         qohiTk2mka5LOo/rz0zXHAyxiabNqx7Srxr9DhI/JChErvpDIoFH4Kz5UT5taK3s16ZH
         bURl9a9Ps22Whw4c0u87lZ0jakDZOm82veT8hizsJUAg9pZ8+NOJPTFs/4k6V1UAkAID
         tK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRL0VLp6qutZXrZd4cRKeYTVqt51qEo+4j74ZFYX/gc=;
        b=ILechpwqGHVAxL9XDQsSixtH+0qEsFTNEedu3p+PIT981OqH9FcGo1kWf1N59Lkvs2
         wLLr2pZAbvqSM4CE/Tc+4kw9WEjHotY+MryLcut2Qvu724LErsnx6vD6IeFrWxEisI55
         lSZgT7TwMWQtJ7VTB+ew/9mTNYuZbQqd6AFUTcNUDMhZ2RLUAW8ypaUyDwq0kFv1ektA
         u8LONzjovNe/MXTNwN6XwjtpGhPaxRMG2UXEF9KPWh4qVvtW2qcCX3Z5yBZtkqHfYdb7
         LE9kmMmk4cjDmSuW+D6KLXw3FSDbA+kFiFRagdVJ//aQWcX8m+43Ukve7JPschUutyaH
         Cmpw==
X-Gm-Message-State: AOAM533/YIMn9t6nA6YfllUBkRACUUDBR1chWTh9KS+j0MXD/yVT8SqW
        L/1pQLL5avjqhrctlmjkJidgSg==
X-Google-Smtp-Source: ABdhPJzEl6xuRN5mlrhZ5qK3Q+xJly8EfAb/H8Lwegn+sSFyypw9tAcur2O0cxMRQw+fZWuUoEEVpw==
X-Received: by 2002:a50:fe10:: with SMTP id f16mr965092edt.85.1627491940668;
        Wed, 28 Jul 2021 10:05:40 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:40 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 10/14] bpf/tests: Add branch conversion JIT test
Date:   Wed, 28 Jul 2021 19:04:58 +0200
Message-Id: <20210728170502.351010-11-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some JITs may need to convert a conditional jump instruction to
to short PC-relative branch and a long unconditional jump, if the
PC-relative offset exceeds offset field width in the CPU instruction.
This test triggers such branch conversion on the 32-bit MIPS JIT.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 8b94902702ed..55914b6236aa 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -461,6 +461,36 @@ static int bpf_fill_stxdw(struct bpf_test *self)
 	return __bpf_fill_stxdw(self, BPF_DW);
 }
 
+static int bpf_fill_long_jmp(struct bpf_test *self)
+{
+	unsigned int len = BPF_MAXINSNS;
+	struct bpf_insn *insn;
+	int i;
+
+	insn = kmalloc_array(len, sizeof(*insn), GFP_KERNEL);
+	if (!insn)
+		return -ENOMEM;
+
+	insn[0] = BPF_ALU64_IMM(BPF_MOV, R0, 1);
+	insn[1] = BPF_JMP_IMM(BPF_JEQ, R0, 1, len - 2 - 1);
+
+	/*
+	 * Fill with a complex 64-bit operation that expands to a lot of
+	 * instructions on 32-bit JITs. The large jump offset can then
+	 * overflow the conditional branch field size, triggering a branch
+	 * conversion mechanism in some JITs.
+	 */
+	for (i = 2; i < len - 1; i++)
+		insn[i] = BPF_ALU64_IMM(BPF_MUL, R0, (i << 16) + i);
+
+	insn[len - 1] = BPF_EXIT_INSN();
+
+	self->u.ptr.insns = insn;
+	self->u.ptr.len = len;
+
+	return 0;
+}
+
 static struct bpf_test tests[] = {
 	{
 		"TAX",
@@ -6892,6 +6922,14 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 1 } },
 	},
+	{	/* Mainly checking JIT here. */
+		"BPF_MAXINSNS: Very long conditional jump",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper = bpf_fill_long_jmp,
+	},
 	{
 		"JMP_JA: Jump, gap, jump, ...",
 		{ },
-- 
2.25.1

