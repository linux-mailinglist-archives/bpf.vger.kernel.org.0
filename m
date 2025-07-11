Return-Path: <bpf+bounces-63087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BC9B0259F
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 22:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD87F1C87DB1
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04E1EFFB4;
	Fri, 11 Jul 2025 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="NtcblmHA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48858F7D
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264733; cv=none; b=abVyhbZ/P9RfLvwJOOGhho0Igvzw1C/IYS1fTtiNm+btpvmk7CNVz0nYZ+kMwwm3iM9xB4Yk8vkWRpo/1novzPyJ3BxIavyWIvqQeZbMbgyrDC44MqFrbPVP3vugPDlCqutLJOwfumR8EjjUDz8rVqUFQZmfXkV/AkhAcdqYtqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264733; c=relaxed/simple;
	bh=nYBIC1cfNhcOSNos5d0rruIfECn9sPTg6nAnq9AbfuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jnf1RUE32AZsT0Wr717xlCT/30dZ9UNLhse0MHjY+UBrjqPSqtrsy0+t+cUSu0/vqRaubLbpXz70FyJ+V4ADfYTp6PEF9SJ7Bxubezxd86ym4G99JCDyw5t8eSaraWvcSarwpnnRmHS+r9TOqDxPGwjqu1HxpIjVaGFXyGyFXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=NtcblmHA; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a585dc5f4aso30200301cf.2
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752264730; x=1752869530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gVnBw/jHbFm/CiXCRb8gj3cs9NgJcH3mTdOU/L7Hito=;
        b=NtcblmHAVKqWOTm1Hk8eRXbBXHJbH1NWGIwj0/baWKpRmOgPNMPjGQpcdEqdhYjw3+
         BAM4jnbvWGVeI+uB9RphG9mQwwKkq58fGsxJLIvE5txRXGBdnXLnrp1KZSqxxfLGfZH0
         wAJuhPDNwEB8gQ9CV1UJI3KzW0PdbHlKatStlFNWc249PQ97ZUi37VZmGOHnkbxjRM05
         DKh8733bfL84bTw+Huj2o9GUjxYzzGuRc7Z+UuZulgAlWdwif8aq0n4vb//glGn/Etxe
         9jc19DnUujmuIaukw53e2NSjJfDnC5fD2xu0XfPwuMgmmYm8UnaSSzBxlzlohG+P7i96
         n76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752264730; x=1752869530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVnBw/jHbFm/CiXCRb8gj3cs9NgJcH3mTdOU/L7Hito=;
        b=MO/tmjnQJ5X+A3pw2Qi9jUbdKmEstQLL6S3LibRp0iJxNyMnkEV2hIvhdiAFZ4IRjz
         hsP4anKiWRnTEaU0qOJ/HYxOhdrCmoPbZ0JsmqtybTk1/NBiKF8af5qKM81GGymN48ID
         jDpNFz+KleyKWRHGJg3FnwJzb6mpkYZsL1eKwXTSL9jU0jLRIaBEoAZfQxy5hYIcojUO
         k56evuih5Q3kMlIRbCzZYYBFRrYiYRtZbHScpgiFCY8N9Z+CpPW37wjLG44lrYk5zrZZ
         h1CphC4P/poahdItOCkNOkh3gs4mdPcHJJlNzRDcEhyrMnlX2/+Bl1X9j/6p0hQ5Kagd
         CPLw==
X-Gm-Message-State: AOJu0YxTXOBufeZE/SYB9x1zD2z3wJuN+slzKczvpckiFCzlvGWefYWJ
	r4TDXf87lIu6XW+nobjPYKqW6FumLd2cGXE9AfbmWtuV43zQ8zg6YCRH8b6MUdySmMUYbitRVtF
	O70M04Lk=
X-Gm-Gg: ASbGnctXbLXRoU8GVwUuAKBmblB9J3Eli4FHmQFxpZE5fEzaYIfyFUIYCqgT9Gsuamh
	8s8NZQe6ih/SFQ+yS0Rt5dmlQI57thzvhIDlIItyTcUkQh9ozdyd4X5Qjj7l3SNUZRj2an2YIQ6
	ivlhAImXcuOLBMBRTB5j/bT8hkNmR9f7rRqXeXQ5Dc6xQSS2fjQfDmi86jwKcqSz2On4fW33pTk
	ltkgsqZQTBg2TRi3pEgXU+6u04EZ7fNZ1lxeKCsvpndPLSI0Z8hCjazgKhA8E7vJd4+2jRvdAxu
	jb1zmbHVzUYLBrK95nmLQFZAMyj9QuAto0ZKACX8AU2qu00VJPg2Wh3vJxQssW+JvZVzHipEkCM
	0hT4CEehppzvlLUmHPkE=
X-Google-Smtp-Source: AGHT+IGUpayLT5iSJowHpRR8b8NrC0zUvVnEv/pjBZ1BpI5AZ74xmTQa99E3+224vikFWyZNxYvWsg==
X-Received: by 2002:a05:622a:4684:b0:4ab:3b66:55dd with SMTP id d75a77b69052e-4ab3b6658aamr33462231cf.17.1752264730346;
        Fri, 11 Jul 2025 13:12:10 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edefb923sm24392771cf.75.2025.07.11.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:12:10 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH] bpf/verifier: factor BPF_F_TEST_RND_HI32 flag check out of opt_subreg_zext_lo32_rnd_hi32
Date: Fri, 11 Jul 2025 16:11:59 -0400
Message-ID: <20250711201159.75592-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs can be loaded with the BPF_F_TEST_RND_HI32 flag to instruct
the verifier to randomize the high 32 bits of a register being used as a
subregister. This is done in the opt_subreg_zext_lo32_rnd_hi32 pass that
scans the BPF program instruction by instruction, regardless of whether
the flag is set or not, and testing the flag on every iteration. However,
the flag is not modified at verification time, and the function is a no-op
if it is unset.

Gate the randomization pass behind a single flag check instead of
testing the flag in the main loop of the pass.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..dc0981205d6a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21062,9 +21062,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	int i, patch_len, delta = 0, len = env->prog->len;
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct bpf_prog *new_prog;
-	bool rnd_hi32;
 
-	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
 	zext_patch[1] = BPF_ZEXT_REG(0);
 	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
 	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
@@ -21080,9 +21078,6 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			u8 code, class;
 			u32 imm_rnd;
 
-			if (!rnd_hi32)
-				continue;
-
 			code = insn.code;
 			class = BPF_CLASS(code);
 			if (load_reg == -1)
@@ -24700,7 +24695,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	 * insns could be handled correctly.
 	 */
 	if (ret == 0 && !bpf_prog_is_offloaded(env->prog->aux)) {
-		ret = opt_subreg_zext_lo32_rnd_hi32(env, attr);
+		if (attr->prog_flags & BPF_F_TEST_RND_HI32)
+			ret = opt_subreg_zext_lo32_rnd_hi32(env, attr);
+
 		env->prog->aux->verifier_zext = bpf_jit_needs_zext() ? !ret
 								     : false;
 	}
-- 
2.49.0


