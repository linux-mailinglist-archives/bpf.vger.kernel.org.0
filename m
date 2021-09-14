Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A2A40AA9F
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhINJUo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhINJUg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 05:20:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A40FC0613E9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h9so27409714ejs.4
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERmKu9v0BHUkZ0BciNHlQqtuD0MKt7tQcV0WrIj4XsU=;
        b=br1b4Gpsh4L1gd+T7QFk4WlDcguOIRLM+dy0mJo9JywfO2ARsQhT1I4YY2lkXZPyB9
         c6y5cszbTi+asTGjusUf/WAp/LeO332/TecnREF6Kx6z2p6XOMiU9sxmzDSHX9wNWXIo
         WWXKOUoWSzxOcA846eXKUT/BVZIXG+K/sRfVen4ts6wwjpmToDzZOGrKFdY8rtPKo7C9
         8FtjMz6R3dmgiw56ETeLdrRVFM7LO/3mRNK1VAKOcH+kAcUf4yUmf39FsD/p26hzIjxJ
         gPD6tz5fRYCClW6/aTORxHtD6prJHnD6jO9V3NQQiLW+RIdlxlwIekc2jwMG/U+4cLCG
         J8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERmKu9v0BHUkZ0BciNHlQqtuD0MKt7tQcV0WrIj4XsU=;
        b=gTSighE4+53IFPWPLeQkkyBBl+af5IfEEaboChvYTqTePhCwvTdCQyvETg80241/ld
         UJjWJ3CNv9fEeWmXgajL+pyCkLx+jDoF+u2hTf8NsLtH56idYpMFWolaKV2t6Vo5pBxU
         l66TzxI5eAnH+m4zwNbRpqHBlZbBZTjuOyRhVI15jZFthQA9hivI49tRiMQwB8apHUdB
         SdZuXoY2pJ4Y8E+q271zT8coHrZFNTT8wwgQJPHccKoINz3x9Z0qflFaksUyhA5ngNUz
         0+eh/0g/j5Z3uOlb9qUv2g+zhG+aG79remtGhriCSI3XiBRZrtuLmAQ7TH6ijct+NvoE
         8GyA==
X-Gm-Message-State: AOAM533uoe5Fb18G4rBfFxuPXtwXkUC6TuOMjSJOxYY5ZdoeBWbNikmO
        uEVKkCdJIN8Ne6CLmUSoV15FBw==
X-Google-Smtp-Source: ABdhPJxizgeK7CpOOOjxt8cwveMFcwn4cKM0OfSKCr2Tq8arsHVy7KR16pp8WyGdg0+ozBiW45OgcQ==
X-Received: by 2002:a17:906:1d59:: with SMTP id o25mr17712721ejh.431.1631611153906;
        Tue, 14 Sep 2021 02:19:13 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id h10sm4615915ede.28.2021.09.14.02.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:13 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf v4 09/14] bpf/tests: Add JMP tests with small offsets
Date:   Tue, 14 Sep 2021 11:18:37 +0200
Message-Id: <20210914091842.4186267-10-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
References: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
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
index 26f7c244c78a..7286cf347b95 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -10709,6 +10709,77 @@ static struct bpf_test tests[] = {
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
2.30.2

