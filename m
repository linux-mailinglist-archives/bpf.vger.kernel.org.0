Return-Path: <bpf+bounces-70232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E15BB4F76
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 21:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782203C1B63
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EEB27FD4F;
	Thu,  2 Oct 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhainYZ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80527BF85
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432313; cv=none; b=Fa8ZLLW/me73anOUI1sUfSfinPa6jHlzrPn/SwExj6awdxRlcpFToF9RxSs8gzpFdqodWJyKRRV7B3iAcuTc663P4HaG2arjdtruqbjN7fUFSvcm5f5FT+EebdOWBeBIcgnLXEoaxQr8SWbh+ZUh3XTI+0KJm63BzqBAPb3ttVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432313; c=relaxed/simple;
	bh=sKIvizjPPZ1yqKGgT9HHFFQOHFcY0u2Ek94nZxsZI78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfyvLDTviNbqV9VbzACk5nt0TsNXmWq1q98O9Fylcvov9CLHV1n0FfQsdALNr550O1MQBov8D/daMw6gnFT084k/3d21jnaKir+o3Ctnv/RGtatpeMPphqPB1QiZjb/4HQO5+DhnJyhk4rQsiiocV0rzdBS1LJIJ7N0Ok3V5Qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhainYZ+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so1590973a91.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759432311; x=1760037111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjRVsJq2yWRJJvw628AYAEdcHaXprhayqKIjPBscGEY=;
        b=PhainYZ+gMe6UkrqaoTlmM1+yf+6ZgkDLLGMup7Dn717Ri4mGLxdqz5fnxpfkX5bVL
         VQ3U6SLDVM2+6IxBkXfEpnLSb3WGyAPS+U32w3q9acBmho0MBJCYRNqYHLmIvFzLrLlM
         yhFYabg96rJz9CxZLyIPu/0cWH7NA8/RL6FP6agfg/gXVaGxiTNGxectaWF3NtMOoNL6
         mPdpJ7wxaJbtadwPPasblC1rTftEBNlXSWRQ0IYqpOFjLx//dtm/nxoiihxO/9j5+zJA
         7xVsgtyi+3bzp0aR7Oaukjc3j2SvZUFOk7Wx4vQ1SYGnVvDBhmGqISkVuRtF6TZFBcCJ
         RU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432311; x=1760037111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjRVsJq2yWRJJvw628AYAEdcHaXprhayqKIjPBscGEY=;
        b=OAoWEHi9T+iHY5ccH6WiqVaTD94kcr76xPC34Fq+Nrc+caUWAnvKzp+J0bJQa+vK6d
         2KJXutTVnCHP/fbxhmw8awrSQhHmhwhrBYUEL+9O+e6C6jBZA8grhvX6H5iucPCTR8Wl
         4vOUr+aaBg1YeENrU/sZfkQFdwXmLAVturD8qDzb7XaCisSnFEHzqc8TUh5l3bbbI2OO
         VGx4bHlgV/DCF3AAiOAcnV4VHvoCKKiIBJH/UJektgwwNkzJ3apJuiWwtf1BO5Tbj23x
         ORYf9gXPlgMyaddY7R2AXkU0GGxkJkg/hljW6TS2KpZiIR21SFHNK6Lql0gk7/x2eMLQ
         xHGA==
X-Gm-Message-State: AOJu0YxWEQMnu0pm+vsOyKyqNMHBPcq56kHcO3f5zYNlguU+xPFYL/Pb
	Cxp+M1O92hxng7+iS3esSabT8IJ/i6wUZhieHoyOU4MpP0CIXjtBfYGVsX+MblGSqdU=
X-Gm-Gg: ASbGncseF+NGLLO6Z19AXym1mwg7sZL2CQo+cZW2PduuYaUw6YI3gl1XiHTFpdZRw7Z
	0WBpWh08wxzurI2fzH8wZmnX5tfWR+7vh+qKKS9GRzbV0S2wm8vlLQdZUWOixaWhfz/MugYGH2a
	FV29gy5G+hnp7l8XnU57lKFrTiuz7Rb3RIUtYW9FAd3n8Sei/ZD/dorthwfyHzZ/f2dhxc4BMrP
	7cm8cdUjALML/pgh8xyUuenO5WoW6g65AGFflFJwORNceSwXnlFGRzrDtzPWMBuCcVdcF/dYgGr
	sKDpLzqFyp7hkgxfN7plrYXVpBlfcrZayFIpAoUtQxNdawTMmz/9z9CBGBe5TY22DDod/FTqUc1
	77QGU7KV7LICnkO5NyULgvpl3nzV+SJ3xoZOlxe5N8BsM4Og98cvjg+gMs7Y=
X-Google-Smtp-Source: AGHT+IHsCryDTHTLgYE446Wuf5c/vdiu4eSVlTs9s5sxdCj9QLrYDpY8b7A54NUSTkCv4UObHDUw2g==
X-Received: by 2002:a17:90b:4b05:b0:32e:87fa:d96a with SMTP id 98e67ed59e1d1-339c2784927mr526591a91.26.1759432310859;
        Thu, 02 Oct 2025 12:11:50 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff0d4esm5714025a91.17.2025.10.02.12.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 12:11:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf] selftests/bpf: tests for rejection of ALU ops with negative offsets
Date: Thu,  2 Oct 2025 12:11:40 -0700
Message-ID: <20251002191140.327353-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are test cases for commit [1].
Define a simple program using MOD, DIV, ADD instructions,
make sure that the program is rejected if invalid offset
field is used for instruction.

[1] 55c0ced59fe1 ("bpf: Reject negative offsets for ALU ops")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_value_illegal_alu.c    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index dcaab61a11a0..2129e4353fd9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
 #define MAX_ENTRIES 11
@@ -183,4 +184,32 @@ __naked void flow_keys_illegal_variable_offset_alu(void)
 	: __clobber_all);
 }
 
+#define DEFINE_BAD_OFFSET_TEST(name, op, off, imm)	\
+	SEC("socket")					\
+	__failure __msg("BPF_ALU uses reserved fields") \
+	__naked void name(void)				\
+	{						\
+		asm volatile(				\
+			"r0 = 1;"			\
+			".8byte %[insn];"		\
+			"r0 = 0;"			\
+			"exit;"				\
+		:					\
+		: __imm_insn(insn, BPF_RAW_INSN((op), 0, 0, (off), (imm))) \
+		: __clobber_all);			\
+	}
+
+/*
+ * Offset fields of 0 and 1 are legal for BPF_{DIV,MOD} instructions.
+ * Offset fields of 0 are legal for the rest of ALU instructions.
+ * Test that error is reported for illegal offsets, assuming that tests
+ * for legal offsets exist.
+ */
+DEFINE_BAD_OFFSET_TEST(bad_offset_divx, BPF_ALU64 | BPF_DIV | BPF_X, -1, 0)
+DEFINE_BAD_OFFSET_TEST(bad_offset_modk, BPF_ALU64 | BPF_MOD | BPF_K, -1, 1)
+DEFINE_BAD_OFFSET_TEST(bad_offset_addx, BPF_ALU64 | BPF_ADD | BPF_X, -1, 0)
+DEFINE_BAD_OFFSET_TEST(bad_offset_divx2, BPF_ALU64 | BPF_DIV | BPF_X, 2, 0)
+DEFINE_BAD_OFFSET_TEST(bad_offset_modk2, BPF_ALU64 | BPF_MOD | BPF_K, 2, 1)
+DEFINE_BAD_OFFSET_TEST(bad_offset_addx2, BPF_ALU64 | BPF_ADD | BPF_X, 1, 0)
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3


