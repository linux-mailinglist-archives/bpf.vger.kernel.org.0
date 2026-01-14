Return-Path: <bpf+bounces-78871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C324D1E5FF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 874A3301C5D6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007738A288;
	Wed, 14 Jan 2026 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5bB3AE5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC35393DFE
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389942; cv=none; b=Tci/yacHtbtmRSsMHfvIkd3LT6AGNIb03z+gk5WMu1Hkc/eVhEzvvWFLS3w6icRXFD9fpQkYFxbriNTEPKmdsJYnFUANk4y/Plrw7u7CYZsY2nYLJRHvFNAwl1CM02Q28VjJLS6JcJ2wb0JA75G0pCgh94TssZ/8R6LqlPTCN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389942; c=relaxed/simple;
	bh=njc5VBttLt+1CPKAc/GCSJecFJgEiE58fSaXDZrQm9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNOejB7ODKussMhoSfJtfWqzS+ldaBUcYAN3Ts2ex/KMgHy2wcrl2E6RfgPkqt4NxN+qz2mDIOqtP5QUOi8PlEkfpDwPXP8WR/RsTyiDu9jLT6peaeeYFR+o+YhXNHrsfDWcuggBPEQ6qWSh+aLAQduLehcAE7I8MuAxC7xXTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5bB3AE5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8712507269so461181366b.3
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768389936; x=1768994736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pcb3fMpfMgMGt1pdSds+Jf+fYTHEHGnLxuTp9fnjko=;
        b=V5bB3AE5Frj/6lXQQZTWSABvlvrtYapF2kyehxzHtMvO2RJ/TytK+t9/DwGrqWBKjM
         h0EEf5VVBDhYdgWJTy7f3y67ttR6V6Sx5j1N4Nkmx2/53mjiBaxLmqXFWRGVQ+dAgikq
         RUWTN/AI/dM6l0wAF60nexV6CbqReLqzhcrAv9rxx+W+DI63Gv/WNwRQh28QOO+TkU+q
         1PVy5p6UCbe1U3QA21WEAthfx3sDSK/ZkBoNnqN+HvDaIa7t+quexSx6UNf9Xn8tfHXW
         qPOAfviHnD6maZtTzmjoF6/k7rR4dqg0zWEaN1O+kuUJyAawhOdC7QdDDt304EEqRAnJ
         mZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389936; x=1768994736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Pcb3fMpfMgMGt1pdSds+Jf+fYTHEHGnLxuTp9fnjko=;
        b=J8Z33OX6R21b8B1nPovNLbaWZP/doCLUd7XT2eGpEqxSAxDI3rrz4Yz5tU5RpSdnFI
         q/6DHRZEN7mfsDYk8/l1xParb4WdUWYd4a6eF157Lt8rAy8YIovyQAEINpTNFXpFXD5f
         XoQQcSBjE5ntADSwaXavSIJORv7de/03UDf4IeD91ITGXzOSgyvOCKxQxjz6RgwTtmKh
         35/v/Puck4icskg5/cgN5CsCTHOPpQ8c3MiX94E8kF4gwfPaU2J+HM6foxJq4PguDcSS
         lSwCoexXsbbVaRVMMyP4JEBf6OQt2WfCFPq+gIlVy7JmQQl/OAE193IR1M7LJwUPLXWQ
         CkkQ==
X-Gm-Message-State: AOJu0YwrY0VpEpTL8n7kSKIYd6s5naBXD9g18zTG7UyJsSRmn8FNEKWr
	2TlmzmnsjCo4hlJlum43e4KsfliAPvywkP74XfjbOj8u9UicRozOlL7SqT7kbA==
X-Gm-Gg: AY/fxX7EVib58V+uBxl7CtC764FF9gt5IjMwtP+F6x3WcdKW6Bvdv7dnQAt+e+nwKGu
	CvDtuk74KWbWR74PzTriqEjk3/z7036KuujlFOadjHK4wLUZ4M/1SCuyI/jV/eU0t9FqgvXIoNW
	2NSy37WGnjtvmjk0E36GB3pxMsRSSOY4Lyn0DvGhVmpirVVf86UgVPuzmFQR/nqnmGwq3ePqfQl
	Kgy3eO1a2xQcuBKEbpgk2XXiLodBEHGChF4eQWVJruG18KpbqgmhsEGqIoXJuu5UxNQknozqZqY
	4/9iYfPX8p/VrxBhUsJde4N+Mjj+p6prL9fChB71N5oH5mxDN/T4Q9FE8EpvvAAqhiezhf/GY6T
	R6Ojfj3mPuvLuzF3rb0ye5ZJzEuzSHd5kBlGntFEbiWnOflhMU9AftP4dIndEB3EUBAq4k7JLot
	rajh22WiehELJaua+ahZyN/FyrmBRrpPl+hDiIvs9i
X-Received: by 2002:a17:907:9412:b0:b4f:e12e:aa24 with SMTP id a640c23a62f3a-b87610994f9mr202887466b.22.1768389935955;
        Wed, 14 Jan 2026 03:25:35 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871188ec63sm980423266b.1.2026.01.14.03.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:25:35 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Extend live regs tests with a test for gotox
Date: Wed, 14 Jan 2026 11:33:14 +0000
Message-Id: <20260114113314.32649-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114113314.32649-1-a.s.protopopov@gmail.com>
References: <20260114113314.32649-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test which checks that the destination register of a gotox
instruction is marked as used and that the union of jump targets
is considered as live.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../bpf/progs/compute_live_registers.c        | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 6884ab99a421..fad91c599095 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -431,6 +431,43 @@ __naked void subprog1(void)
 		::: __clobber_all);
 }
 
+SEC("socket")
+__log_level(2)
+__msg("2: .1........ (07) r1 += 8")
+__msg("3: .1........ (79) r2 = *(u64 *)(r1 +0)")
+__msg("4: ..2....... (b7) r3 = 1")
+__msg("5: ..23...... (b7) r4 = 2")
+__msg("6: ..234..... (0d) gotox r2")
+__msg("7: ...3...... (bf) r0 = r3")
+__msg("8: 0......... (95) exit")
+__msg("9: ....4..... (bf) r0 = r4")
+__msg("10: 0......... (95) exit")
+__naked
+void gotox(void)
+{
+	asm volatile (
+	".pushsection .jumptables,\"\",@progbits;"
+"jt0_%=: .quad l0_%= - socket;"
+	".quad l1_%= - socket;"
+	".size jt0_%=, 16;"
+	".global jt0_%=;"
+	".popsection;"
+
+	"r1 = jt0_%= ll;"
+	"r1 += 8;"
+	"r2 = *(u64 *)(r1 + 0);"
+	"r3 = 1;"
+	"r4 = 2;"
+	".8byte %[gotox_r2];"
+"l0_%=:  r0 = r3;"
+	"exit;"
+"l1_%=:  r0 = r4;"
+	"exit;"
+	:
+	: __imm_insn(gotox_r2, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_2, BPF_REG_0, 0, 0))
+	: __clobber_all);
+}
+
 /* to retain debug info for BTF generation */
 void kfunc_root(void)
 {
-- 
2.34.1


