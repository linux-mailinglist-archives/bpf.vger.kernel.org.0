Return-Path: <bpf+bounces-42354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27F79A3260
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 04:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A521C21DC7
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 02:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B327E110;
	Fri, 18 Oct 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujr7TRQT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833020E326
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217004; cv=none; b=GAnFKPgEkzBJiSwI6wr2ER6PJw9veeye1WNWZZPgzRQLtER8w3cHF0uDIumHSUBMzhGDMESH9B4OzGwfcFeRZVsYZrRBhkgSKAFlcJ1AF2c1kstkyWyShCpdxwkpgCxhrB37cDB4QK8BJXhNmg2s1PxjTm9jwQPhZLAZTAvqgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217004; c=relaxed/simple;
	bh=p6SSN4os+4yDpIS+8RGCRvE9ScZCpcjKRlkUFn+lSlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikhvqIijYTzyolwWhoyo3v6mi14HNE4N15EQDlJtIkC/rxcc/HOWZAXxr1L8xi95JvemZNJtqPBfYpjx3G+3PrPVd5/N9bNy2u8wUQ12AlrmMc16a2J00Gp2L5oNoOLqw9u3T8d6nLNOuTO+ltUCikElGR71sTG9q3w6FIXOkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujr7TRQT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cdb889222so16911115ad.3
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 19:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729217003; x=1729821803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaDNnr3hakhJqAiWa5aPSnbqXeJJN9gSynPqaIASC3g=;
        b=Ujr7TRQTUuvdGCE1xJZwwE+3Kt+VkN8i1Psz1mMS1juiej1ytxyO3WpIOv0t3j69Xe
         4z8qArEKDDsOrh2epOnTxD75tolmjAF84WgA0Z44J2Fxg7X1YYOqRqXo4xzY/wDm+AyD
         kyP8Sj+RdVolqAmU7XgkG328QqlF5ofiMpYNow+8sEi4dFmsiF8ychpr+svnoMecc18U
         nlzw8301eu5YIxqdp0hdY+jCamIiuf0dGw/7BoieltWoxuVtOjzO7VnxIqBwFhH3saoS
         B/yMJU1FPKvpkYiOY3oI5Qvhe6dawVw15fF4M7nL9dIWA4FWsGWb/5+JNeJgjVRqG6qK
         CXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729217003; x=1729821803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaDNnr3hakhJqAiWa5aPSnbqXeJJN9gSynPqaIASC3g=;
        b=ef+zmWiqFxQZgDAR2EMG1hpwPVEGZkwl1Zhws++fthi0UvtcKddrJIVgzMqMu7OsAE
         eZ4Lv9n5DPHeZZk4nej1fhRQtDiX11KL27JcTfs+ID6fqQJApcxYA0sr8Jqcl9TtMfkV
         W1Elm4tHyc7NoIRQdDlAq0Gi/LXURA7r9rlN/5gvplWUsl/BiUOVgrzX466xh8OTm4yI
         j/g1dCc/L+RTq9MrECynkrsXwYXV0/iPEJmq9Qef/YDtLuYDFcUATy+EFZEy7DeOpBCV
         2sLhpww36+78wWA7WNS98WYc9mSUiLNljDfjqUD1dncAiAYmKXvJYvwsyamir58VoCup
         HOsw==
X-Gm-Message-State: AOJu0YyTf6MoDkhoTCR65MExJVd1fn8J/4HQkXnzIsxF+rMQgJ9vZ3kD
	Bn12B0V9ZBMrBysKIOJoZ6T/hHogDoBk0Ya0530gIiKKJkozua2ZpYD4Dg==
X-Google-Smtp-Source: AGHT+IEwQTzYPh+HLod60MUNrC18fqjJMwg4ng/2h8vB3Ul2pLPOoZx5zkfmdEgU58aTUV2SI4ICrA==
X-Received: by 2002:a17:902:d4c9:b0:20b:7a46:1071 with SMTP id d9443c01a7336-20e5a70d006mr14334925ad.4.1729217002545;
        Thu, 17 Oct 2024 19:03:22 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a915348sm2781285ad.283.2024.10.17.19.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:03:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: test with a very short loop
Date: Thu, 17 Oct 2024 19:03:07 -0700
Message-ID: <20241018020307.1766906-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018020307.1766906-1-eddyz87@gmail.com>
References: <20241018020307.1766906-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test added is a simplified reproducer from syzbot report [1].
If verifier does not insert checkpoint somewhere inside the loop,
verification of the program would take a very long time.

This would happen because mark_chain_precision() for register r7 would
constantly trace jump history of the loop back, processing many
iterations for each mark_chain_precision() call.

[1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_search_pruning.c       | 23 +++++++++++++++++++
 tools/testing/selftests/bpf/veristat.cfg      |  1 +
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
index 5a14498d352f..f40e57251e94 100644
--- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -2,6 +2,7 @@
 /* Converted from tools/testing/selftests/bpf/verifier/search_pruning.c */
 
 #include <linux/bpf.h>
+#include <../../../include/linux/filter.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -336,4 +337,26 @@ l0_%=:	r1 = 42;					\
 	: __clobber_all);
 }
 
+/* Without checkpoint forcibly inserted at the back-edge a loop this
+ * test would take a very long time to verify.
+ */
+SEC("kprobe")
+__failure __log_level(4)
+__msg("BPF program is too large.")
+__naked void short_loop1(void)
+{
+	asm volatile (
+	"   r7 = *(u16 *)(r1 +0);"
+	"1: r7 += 0x1ab064b9;"
+	"   .8byte %[jset];" /* same as 'if r7 & 0x702000 goto 1b;' */
+	"   r7 &= 0x1ee60e;"
+	"   r7 += r1;"
+	"   if r7 s> 0x37d2 goto +0;"
+	"   r0 = 0;"
+	"   exit;"
+	:
+	: __imm_insn(jset, BPF_JMP_IMM(BPF_JSET, BPF_REG_7, 0x702000, -2))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/veristat.cfg b/tools/testing/selftests/bpf/veristat.cfg
index 1a385061618d..e661ffdcaadf 100644
--- a/tools/testing/selftests/bpf/veristat.cfg
+++ b/tools/testing/selftests/bpf/veristat.cfg
@@ -15,3 +15,4 @@ test_usdt*
 test_verif_scale*
 test_xdp_noinline*
 xdp_synproxy*
+verifier_search_pruning*
-- 
2.46.2


