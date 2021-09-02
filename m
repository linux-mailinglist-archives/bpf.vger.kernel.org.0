Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3723FF386
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbhIBSxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 14:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbhIBSxr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 14:53:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174DC061575
        for <bpf@vger.kernel.org>; Thu,  2 Sep 2021 11:52:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a25so6699887ejv.6
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoSasBp8FUxIYX3dqECHvXhlDjnUa++BQhLErp0Za5o=;
        b=r4eSPdEW5uOWjUFSkkKRupcg3/VRTebHijmWQSPbCBsFvK99FLjOJ4Ilclrti07LHk
         d1mJhpgaWJHMPzS3nv+52Xmftu3ke6ohJngVKV0rMcuFiA2ZFCDkjEKsBM2uTI8RXUMw
         Zh3Hq5R/3hMm2O3hNg6DVE+JUp0G4M3zWjcttTVgC5nVVOx7cW3SFQyUgVstTAvLQ2XR
         0uAGgoRUFTdum5O9woCP8XPB0aHx9pJpF7nKuT+vLZvcshlFSIQ2BN7P7W+SF2aQJ3sc
         erBWn9uMx5vNskejdyPv3Xigav7eJmdZ9tarIMPOu/60RXMkb7xyECz/kOyMTnY4i+TG
         eP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoSasBp8FUxIYX3dqECHvXhlDjnUa++BQhLErp0Za5o=;
        b=MsBFAWxVSe1bC3aa6LDw7jHM1sn/M15PNOdJJWCmNvwCAJEYN90DFEVGDrCKyCubiE
         eegA5yCTtZ+gWaVyvqdlxnuzFDyOmsET15WWW2eJaE+QDYC+KIK0Ly4GQQYESp4/e/9G
         yvJzMKHkW4DdOLRc6hMncEGuIAyOldV9aGqdh7t8OIWOwdHovcTiea0QPQwaUkkSN2+9
         nSBDYVboeSoiiWUSmd6irjLlWDA449S+idhGtIuq4Z9ESuPVy7mvvRQYwlWZOr/ngObl
         14/1dAOJEhp08i01RMYkaXbWuZXJYpA5bwE0aQIBFcyElAzqxiee6UBCfGQF8ZZWoJod
         xNUg==
X-Gm-Message-State: AOAM532Od/saeRxiLGixspJudkUrywEnUT2LNhWi8w8EY1yKg7uUAoOa
        shwgWffJcCWS1JNo6NrxFbf7TQ==
X-Google-Smtp-Source: ABdhPJyFhh/dQGREVXttN6PN7G6HJfwwLHedm8uL5JwUnBJRdOZskOWBVIf5g8D1nDf7uBC8BMnW6g==
X-Received: by 2002:a17:906:ff0c:: with SMTP id zn12mr5348420ejb.114.1630608766969;
        Thu, 02 Sep 2021 11:52:46 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id mb14sm1592235ejb.81.2021.09.02.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 11:52:46 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        iii@linux.ibm.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 09/13] bpf/tests: Add JMP tests with small offsets
Date:   Thu,  2 Sep 2021 20:52:25 +0200
Message-Id: <20210902185229.1840281-10-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
References: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a set of tests for JMP to verify that the JITed jump
offset is calculated correctly. We pretend that the verifier has inserted
any zero extensions to make the jump-over operations JIT to one
instruction each, in order to control the exact JITed jump offset.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 183ead9445ba..c3d772f663da 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -10707,6 +10707,77 @@ static struct bpf_test tests[] = {
 		.fill_helper = bpf_fill_jmp32_jsle_reg,
 		.nr_testruns = NR_PATTERN_RUNS,
 	},
+	/* Short relative jumps */
+	{
+		"Short relative jump: offset=0",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_JMP_IMM(BPF_JEQ, R0, 0, 0),
+			BPF_EXIT_INSN(),
+			BPF_ALU32_IMM(BPF_MOV, R0, -1),
+		},
+		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"Short relative jump: offset=1",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_JMP_IMM(BPF_JEQ, R0, 0, 1),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_EXIT_INSN(),
+			BPF_ALU32_IMM(BPF_MOV, R0, -1),
+		},
+		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"Short relative jump: offset=2",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_EXIT_INSN(),
+			BPF_ALU32_IMM(BPF_MOV, R0, -1),
+		},
+		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"Short relative jump: offset=3",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_JMP_IMM(BPF_JEQ, R0, 0, 3),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_EXIT_INSN(),
+			BPF_ALU32_IMM(BPF_MOV, R0, -1),
+		},
+		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
+		{ },
+		{ { 0, 0 } },
+	},
+	{
+		"Short relative jump: offset=4",
+		.u.insns_int = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_JMP_IMM(BPF_JEQ, R0, 0, 4),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_ALU32_IMM(BPF_ADD, R0, 1),
+			BPF_EXIT_INSN(),
+			BPF_ALU32_IMM(BPF_MOV, R0, -1),
+		},
+		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
+		{ },
+		{ { 0, 0 } },
+	},
 	/* Staggered jump sequences, immediate */
 	{
 		"Staggered jumps: JMP_JA",
-- 
2.25.1

