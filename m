Return-Path: <bpf+bounces-60679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDD4ADA163
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C363B3B2C
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EDA265291;
	Sun, 15 Jun 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IblLRluS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB0265603
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977736; cv=none; b=lbefMloybtRCvlg5pcEKnvozHkTBSJ3GWlZv2nHMAoJxzn6azlgtZlggNouGhjPfLXP3jbjJ4h3kbvLKR71RaDrRnD4Fc/1T0QqN6KSLsBEBXeuPbV9X71xaXpxJ7n3r22ZBmptkB93ZQbwz88YWRss/HKetEJkRUN07JJHMIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977736; c=relaxed/simple;
	bh=Llr3ZHhFI6nBY8SUGERPa/QkbfPY1GXOLybKnEWtsCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKomy4ieChN7YNYj2CVFpepa1kcka2goj0aQlPLx8xDwyWcd5Tf4J/PLKNzXnsUFFVcnNmVBXMlB8ORvPzL8G4mFECzvoZmjZGHYNNonTJ365BBJCnEc4YG2UNDZwbudRegM5cYVDgm2KfYFiOVkh+x0cK1MFQ69juBDRcNF8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IblLRluS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a375e72473so1954340f8f.0
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977732; x=1750582532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSKtMRlvYTBBoRVmXZPpL76b2DYRvDC+ACCiLyc+oVE=;
        b=IblLRluSwEqL82zKyZw/qIOqjdlXTIrQdz+b0VfJPhctIU+nRQv8nPAdCY13OTKa5R
         fiaNY52nrOijw4BvtQy5hipk1+m2eGF070k4W/0LnLMjGSDEh7/2c55Z7gfjxHLwxJrD
         3Go8ucqFWAZvlv+OqYLcTkVxV/ijZwiYSEotZA6d/ZYcDO+PL1svQpuBHrM3pcl4kHfC
         XHapTxxVKghyoTH65o4FfldidHLpT7QmiwLv2J8TVuvynXoxin7xYvVtuFx6Iu70khMR
         YSQE/hj6xRNoblLu3VzX9EtevXaXGhUBvCQO9CzlZGCVu+/bPXVExfVWWP+sysgrYBpC
         qTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977732; x=1750582532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSKtMRlvYTBBoRVmXZPpL76b2DYRvDC+ACCiLyc+oVE=;
        b=eC9tz3aEJW7qoElz3dehdejEXBoSKOmrJgoA/3dHeJ8QMwP4hbeLSxe7xCWhLt3B52
         SSHfOo/UQXo1Cox1xpAK+WwzSqE19vFaWBIHQqc2pY/7EuhwxXz8tcalSDhSoPBS/lJ6
         DBDmhOLqRHQHYt4DnqydtnfxIBSE1EX4lMPCBVOQYM3AvicWahdhnwTrP20J9meVEyIB
         PlxxdFmd9fMSI62wZdQ9MCMsAxMIjXzlNB+XPiIUjTOuNg8Bu9s+s9XrM3MIreiapvbK
         BygcxlliMf0PSNquw03ep1dOGMVRjzYCaRPmhfyADjFD7KZzPOFGrapvDzcnwIHY2Aq7
         nDlQ==
X-Gm-Message-State: AOJu0YyjN1fiIrq62zEZ2VmZPPNGk2Yz9Cjsep35gGqC+I71vO0ofDIS
	QK5kkLsDBBd+eDo/mUfueFJZ2K6rly5NEWPTp1o1wgkZ7eThbDpqvnB/u/AErA==
X-Gm-Gg: ASbGncvD8gxPvsgh9ZE+2TTDKtZmhckViAlCfNcWfLhWRPpqVyZwpIAcSpciLbTRo07
	mzVtZa124Iz5QL7g9UBdK11FyIyIMMeFDKYdo8OcTflF7eSN0njc0Y68JXHVnnrtQdRN3NdmXoX
	lq/dtHgnZ+AWkF6WI0Ro82NqYmn2LL5mBvrLFLLyrY3mLWqRwO/T9gjo8cHOTgzc4CdiCUzH7Zg
	+HzBi/oVWi7G/qq4pooUz+7myXA8a7twX6Jc5nWSiJ6sl3JGXbSppd7h5sxrH6IhgNqrOm6loEU
	MmROVNYwN3YJSvTw6jTFksXipRao3jZL1XSxwZooPWZwDSUI6ypq6ToAfzCe1QxGeVxka31ZRwL
	gvRXeBg==
X-Google-Smtp-Source: AGHT+IHBMrZjdkoaqC5uok7+xKcJc+kR+8utF7QaLxmLip+wp2bzZNNIitmBpp87WI2pH2WrIgYOQQ==
X-Received: by 2002:a05:6000:220e:b0:3a4:d53d:be22 with SMTP id ffacd0b85a97d-3a572e5db88mr4789118f8f.58.1749977732265;
        Sun, 15 Jun 2025 01:55:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:31 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [RFC bpf-next 6/9] bpf: workaround llvm behaviour with indirect jumps
Date: Sun, 15 Jun 2025 08:59:40 +0000
Message-Id: <20250615085943.3871208-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When indirect jumps are enabled in LLVM, it might generate
unreachable instructions. For example, the following code

    SEC("syscall") int foo(struct simple_ctx *ctx)
    {
            switch (ctx->x) {
            case 0:
                    ret_user = 2;
                    break;
            case 11:
                    ret_user = 3;
                    break;
            case 27:
                    ret_user = 4;
                    break;
            case 31:
                    ret_user = 5;
                    break;
            default:
                    ret_user = 19;
                    break;
            }

            return 0;
    }

compiles into

    <foo>:
    ;       switch (ctx->x) {
         224:       79 11 00 00 00 00 00 00 r1 = *(u64 *)(r1 + 0x0)
         225:       25 01 0f 00 1f 00 00 00 if r1 > 0x1f goto +0xf <foo+0x88>
         226:       67 01 00 00 03 00 00 00 r1 <<= 0x3
         227:       18 02 00 00 a8 00 00 00 00 00 00 00 00 00 00 00 r2 = 0xa8 ll
                    0000000000000718:  R_BPF_64_64  .rodata
         229:       0f 12 00 00 00 00 00 00 r2 += r1
         230:       79 21 00 00 00 00 00 00 r1 = *(u64 *)(r2 + 0x0)
         231:       0d 01 00 00 00 00 00 00 gotox r1
         232:       05 00 08 00 00 00 00 00 goto +0x8 <foo+0x88>
         233:       b7 01 00 00 02 00 00 00 r1 = 0x2
    ;       switch (ctx->x) {
         234:       05 00 07 00 00 00 00 00 goto +0x7 <foo+0x90>
         235:       b7 01 00 00 04 00 00 00 r1 = 0x4
    ;               break;
         236:       05 00 05 00 00 00 00 00 goto +0x5 <foo+0x90>
         237:       b7 01 00 00 03 00 00 00 r1 = 0x3
    ;               break;
         238:       05 00 03 00 00 00 00 00 goto +0x3 <foo+0x90>
         239:       b7 01 00 00 05 00 00 00 r1 = 0x5
    ;               break;
         240:       05 00 01 00 00 00 00 00 goto +0x1 <foo+0x90>
         241:       b7 01 00 00 13 00 00 00 r1 = 0x13
         242:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x0 ll
                    0000000000000790:  R_BPF_64_64  ret_user
         244:       7b 12 00 00 00 00 00 00 *(u64 *)(r2 + 0x0) = r1
    ;       return 0;
         245:       b4 00 00 00 00 00 00 00 w0 = 0x0
         246:       95 00 00 00 00 00 00 00 exit

The jump table is

    242, 241, 241, 241, 241, 241, 241, 241,
    241, 241, 241, 237, 241, 241, 241, 241,
    241, 241, 241, 241, 241, 241, 241, 241,
    241, 241, 241, 235, 241, 241, 241, 239

The check

    225:       25 01 0f 00 1f 00 00 00 if r1 > 0x1f goto +0xf <foo+0x88>

makes sure that the r1 register is always loaded from the jump table.
This makes the instruction

    232:       05 00 08 00 00 00 00 00 goto +0x8 <foo+0x88>

unreachable.

Patch verifier to ignore such unreachable JA instructions.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fba553f844f1..2e4116c71f4b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17792,6 +17792,27 @@ static bool insn_is_gotox(struct bpf_insn *insn)
 	       BPF_SRC(insn->code) == BPF_X;
 }
 
+static bool insn_is_ja(struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_JMP &&
+	       BPF_OP(insn->code) == BPF_JA &&
+	       BPF_SRC(insn->code) == BPF_K;
+}
+
+/*
+ * This is a workaround to overcome a LLVM "bug". The problem is that
+ * sometimes LLVM would generate code like
+ *
+ *     gotox rX
+ *     goto +offset
+ *
+ * even though rX never points to the goto +offset instruction.
+ */
+static inline bool magic_dead_ja(struct bpf_insn *insn, bool have_prev)
+{
+	return have_prev && insn_is_gotox(insn - 1) && insn_is_ja(insn);
+}
+
 /* non-recursive depth-first-search to detect loops in BPF program
  * loop == back-edge in directed graph
  */
@@ -17866,6 +17887,9 @@ static int check_cfg(struct bpf_verifier_env *env)
 		struct bpf_insn *insn = &env->prog->insnsi[i];
 
 		if (insn_state[i] != EXPLORED) {
+			if (magic_dead_ja(insn, i > 0))
+				continue;
+
 			verbose(env, "unreachable insn %d\n", i);
 			ret = -EINVAL;
 			goto err_free;
-- 
2.34.1


