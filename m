Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E605E40597A
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbhIIOqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbhIIOqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 10:46:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E7C05BD31
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 07:33:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id me10so4004324ejb.11
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERmKu9v0BHUkZ0BciNHlQqtuD0MKt7tQcV0WrIj4XsU=;
        b=gTjKCfO7qxtjZhGQdKL3u+b0eucxLeEIU9A6Hxa0BToqAXUziZvlZISO8rtor7Xgg3
         bLRmGYx9UbdbCTekF4VNa9XwVnkWpdKYbCNluLQjtyOiRp0iDt4lW3bmmyoI4Tc9KsMq
         iiNg5gz3o5GiZjwBkPEqHeRkawOXF3iwVauWgtuuqUqkWUDPs1wC+3VI7jOc/+zyI7Uz
         8IgZuAlqEw4EJ/z82Te7zj/LBi3DjXdhogD3yAUSBz15StGmLQf2zMHbw03JjaA3paXs
         o0YPVTCY6vPyMC8kyj45PC3BKL4QclL89lXXbmCPvz+ioU0D5F+Gux7u7iJxHCdjfeQB
         KQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERmKu9v0BHUkZ0BciNHlQqtuD0MKt7tQcV0WrIj4XsU=;
        b=OSPpr++cE231x3bIcFv0f2DdKSYRKPjjcT7oZ9wO1/Cj1CNRNvtt080ukQ/8+f90qx
         HOy6q6N58fDPWgVrylPU41fPWasQm+01QVabFNageZKmW+3Lbn5xWnisDGdgO9ZPhIWD
         sHGnqiJNcKCQihdt04fIZxK1y04lqVMSreQ1GgRqFMyV6fSsKLEPOtINDylzo2++rbKr
         qXuBarTKOFfvfmmq3HUhlzoexcH+al5rbTXNB0JKgmF84udwb42dAr3JHzvyGcQG/wzi
         6RH0NCYWfdNhKeYHHln4CKLaJjj4rXZXCRoXg6XrGJZJpRakeEDnl8pHlQSnoXgYPNg5
         wcUA==
X-Gm-Message-State: AOAM531zpgc0rsP/ouRU5lpn0A0GNJS7eiciwsvGTw0RhWbsnwmLFQgK
        nS8BTQt5zFCno6LTRUh19aD/CQ==
X-Google-Smtp-Source: ABdhPJxuUEilMp6W8xGER9lIl4XivhahR7QH8pLR0ofUU3c75VQtrznvaZctbffsXnD0Sm+uik679A==
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr3667337ejk.147.1631198003178;
        Thu, 09 Sep 2021 07:33:23 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bj10sm1030909ejb.17.2021.09.09.07.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:33:22 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v3 09/13] bpf/tests: Add JMP tests with small offsets
Date:   Thu,  9 Sep 2021 16:32:59 +0200
Message-Id: <20210909143303.811171-10-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
References: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
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

