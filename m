Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D084F3D5553
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhGZHiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhGZHiK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 03:38:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890D1C061760
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so9460816ede.4
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRL0VLp6qutZXrZd4cRKeYTVqt51qEo+4j74ZFYX/gc=;
        b=BtHsmB+RrZLYGEilIWKd3ro5Fruw+0KUz/jj7xb9KlhaLSkI91RcRRH2lXN8MoBQYX
         wCRMYIw1pXVLQ03XMgVcMfnNjtPajuZ/V2/YcZ+kzjUhOg3J+QWd05xe6N+EHMDXJI02
         4HII4KJB3ncMYzDjvbeLtvEJ1vWmpVTioLiBm2acbQ2nu2BteQXpB7t+3b6vFwADYgLu
         Q/nZPiSgt5zWKoHwnYf4z5Dty5wDa5WvNirKX574fDkBaGV/mQkQOF4T5+62zhHeCM1M
         o0h1b/1ne2vXTqceBGnuGna7AvOkUPu6P8XJB6N/1TrBy2loqN1QcXZoWsL/0RELNRvv
         VSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRL0VLp6qutZXrZd4cRKeYTVqt51qEo+4j74ZFYX/gc=;
        b=CYDSCs11TeCKedtD7pOpZFQtF83BLilPPX1aCO+QVJcJIyZRxUPDaAx6c4NtmfHndu
         mkUoXV6hEtKmT+Vq0BDlSGQjIut0MexeJWzgvTZq2ZtzacC2eTYqYYLuw6zFCgR54/NG
         ThH51knNOn8PJ1Hi0B0TKProJbsPqIhjtJjTm1SNuqxw2YQi4YkiSftb4UnfslFtGnNW
         qtOXWq1sMgiG5dCzLBOS03/RnVlTldjwfmq5ALA2Wr1VSNJuinutYb7G2RWWkKWZDb/9
         gKJkyv1S+B44iUSAL7HM+jLnHhjRYP9wKPtBCauiSavS43Uv94ewcMH7fUi6JYz15DcJ
         u59w==
X-Gm-Message-State: AOAM532Qu4WRciLdUqFnFUs3ENBMa51tztKpFuscsfnZh1qftvJAnQk0
        KzFHU/rEyeSMNIMgH9NYHIKQAQ==
X-Google-Smtp-Source: ABdhPJxGTrsrwbJ5F+ALRAUAE9uFPYEEbSG6NV2mH3u8WDC5547xpdmNTkKyIy7lOYXEqlfOt303RA==
X-Received: by 2002:a05:6402:37a:: with SMTP id s26mr20498653edw.114.1627287518221;
        Mon, 26 Jul 2021 01:18:38 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id q9sm13937539ejf.70.2021.07.26.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:18:37 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [RFC PATCH 10/14] bpf/tests: add branch conversion JIT test
Date:   Mon, 26 Jul 2021 10:17:34 +0200
Message-Id: <20210726081738.1833704-11-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
References: <20210726081738.1833704-1-johan.almbladh@anyfinetworks.com>
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

