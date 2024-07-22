Return-Path: <bpf+bounces-35281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86B93970A
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB797282797
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E8861FE7;
	Mon, 22 Jul 2024 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWyKTmbJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539121CA84
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691551; cv=none; b=IEytNdSgSdmI5bjIk/6oboUGNc68BlkapTPfbYdzJaJVzeJ1dNXIqjbUaPIJueNyy7/GbhyR+DYp8ML2ePb0AmndCt8IujltefU1CZNEklONiTAbOzmdN00sdalrRj6cc6+T/G+ataYL+26nxlgPOduvWqmSACwvZgV0pQVvX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691551; c=relaxed/simple;
	bh=mTa0FlsUd4wu8JZDmu51GrykMgteny49iMvgbRMf5oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok2SsGG1nuouqwvpbrcY7TOif3yr3/cSnNFU6kk/4OKIXpHt13YYa80gGVoLoIOg68lKyhSxYVWMByB1JfKV+sXZMLT7eLvjCFajUqW7Os+5PDUEQslF9j62ZqT2eXlICuuTxhicxGf0wFQnzM3k7d3udhuMFJ3zaOGvMdIzfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWyKTmbJ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-26106ec9336so1812319fac.2
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691549; x=1722296349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUQIB1ATCYLDD/quSMfA2n7TrUJ4YpIDhe2ogbedOHM=;
        b=KWyKTmbJyzo3hlaZsjQVBoe7JQZpcltZSF91uwvYCS2FB8fBW5BJVMiIy5yDRT0qnn
         Q5/Mc1VOKF4vZYbHNR66Ab+zO3YYOP76YWlgODnGMVQrGfwqmbwWSiWDTwfUBCQTZSuZ
         PP5kL9kWNo+wXQuuhFfIdwTHCmEEJHGrBzpC8Rjjnp+GuZTUN9cx9Y29gHC4TFb/9YCV
         dO31RFDvX/K5QlUQggn6M61uWac652c32rg5sBWqL/s9QpYzqAVf3gsEo2jWTXw/4zA0
         avkEl7zCWNCDscPZw+kpbNm7qP1gIDtY4qUkq1wDB13TtwY867kDtpmzQVhoaSoSMSbv
         cRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691549; x=1722296349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUQIB1ATCYLDD/quSMfA2n7TrUJ4YpIDhe2ogbedOHM=;
        b=aQe1D63Cxk6i7KodfVwQwGcoiQOtzCcGitgs6i7h8+Fo8SHTlbNDxkY3jdXeqIurid
         Int2XuNEv3YU0+l71hiQlOZBbNRzO/HfM/OnYbA3V3vT9Blbpf6XDa70QNoUrWyws3ab
         8abuRRT83e/FKwOOlYHq4HtqZsbEVVe7FBubiPEKwbWL23uw1eL/eFZrZFffv5DcNT50
         snMpqLM8V/K7sQOxb0IzSoDP2Nk/GloLjVGRSOm+lotG+Se3GLIDSpBHLESd4nOjEcon
         RGU3S6eMN9viDCKo2VmmMkEw9/JIyjzxKm83cAPS9JLXKbhvNjGBnV6EDQjfSW9Vjv+E
         CAKA==
X-Gm-Message-State: AOJu0YzTE8hPlZI6wlNgBGB5g+/KWoC2edch181hMDgokI3TfuuAlzzM
	DVUIu30wLmSec11wRnFDf2k4I/SLL1qviu4VtM3Odiq+tCQwLZsUBC2WikZRT2E=
X-Google-Smtp-Source: AGHT+IH7+5yqssW50+s2w57ydX1epU19YMvzz26v7x13MxGBimOMCP/U8Mj48vIcyCtE6x7r4kb+tA==
X-Received: by 2002:a05:6870:8a21:b0:25d:ff4c:bc64 with SMTP id 586e51a60fabf-2638df894b2mr5477869fac.6.1721691548950;
        Mon, 22 Jul 2024 16:39:08 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 03/10] bpf, x86, riscv, arm: no_caller_saved_registers for bpf_get_smp_processor_id()
Date: Mon, 22 Jul 2024 16:38:37 -0700
Message-ID: <20240722233844.1406874-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function bpf_get_smp_processor_id() is processed in a different
way, depending on the arch:
- on x86 verifier replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0;
- on riscv64 jit replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0;
- on arm64 jit replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0 and tmp registers.

These rewrites satisfy attribute no_caller_saved_registers contract.
Allow rewrite of no_caller_saved_registers patterns for
bpf_get_smp_processor_id() in order to use this function as a canary
for no_caller_saved_registers tests.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c  |  1 +
 kernel/bpf/verifier.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5f0adae8293..d02ae323996b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -158,6 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
 	.func		= bpf_get_smp_processor_id,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
+	.allow_nocsr	= true,
 };
 
 BPF_CALL_0(bpf_get_numa_node_id)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b2845eca539..1a5dda4142b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16043,7 +16043,14 @@ static u32 helper_nocsr_clobber_mask(const struct bpf_func_proto *fn)
  */
 static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 {
-	return false;
+	switch (imm) {
+#ifdef CONFIG_X86_64
+	case BPF_FUNC_get_smp_processor_id:
+		return env->prog->jit_requested && bpf_jit_supports_percpu_insn();
+#endif
+	default:
+		return false;
+	}
 }
 
 /* GCC and LLVM define a no_caller_saved_registers function attribute.
@@ -20747,7 +20754,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
-		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
+		    verifier_inlines_helper_call(env, insn->imm)) {
 			/* BPF_FUNC_get_smp_processor_id inlining is an
 			 * optimization, so if pcpu_hot.cpu_number is ever
 			 * changed in some incompatible and hard to support
-- 
2.45.2


