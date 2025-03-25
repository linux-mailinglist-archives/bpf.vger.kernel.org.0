Return-Path: <bpf+bounces-54684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF2A70362
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 15:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27CF3A7FE4
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ABC259C8D;
	Tue, 25 Mar 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8NIPyTB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F0254AF2
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911875; cv=none; b=kRU/qwOkzJtZbUTmyXkQ4saWpN16BGC++ClrHCKSiMN6+crWYWqPOmj7dJalei/2Huoh6Uet4e06WDMfHKf1Mk7XRaNFE4l3IxvD2WludFGkq0xuAJdWw+zkxFHSNfXsvKEH7qPeObcFsclKfgoQ7B/QYCBMkurO0jt2SpsSEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911875; c=relaxed/simple;
	bh=m5Rf71rIgy5GkGGzXBi5Ik4Xt/g0V0ssPzWjnP0LN/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRsTz7MyoIDjMXtdcgGH6hXjvUky4b9NL7wr1gC0CBlLcXDOV8RHML/tE2c0K5F4mG1cmviPMzgAa4BdjmJf7gnJWfkCEcI0e99G+STs9uR7oAriG2thsKMx1f4E7aqbxKLcWOwn2nGyLGDmSUcWoy8gzIaVvD3GVnC+8CR1p3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8NIPyTB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so13040177a91.3
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742911873; x=1743516673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyT+32LK+A27PsW6quCOsG6ro+lQiaS6tL1T9+kWwRw=;
        b=U8NIPyTBhLTJ9fh24aHhkKHJvo3P5hV+pa8oNBDEWOCRnHARj6+4wqcqu+3pYYNfN7
         +tpNIkuqns+aerS2DwXrE7Tf3wM8K81wmQ9+EgLq31JWgZgJkSGRyw1KyH1R0Din81w1
         Q9HTTemv3TCqKYcNGmiTAHoKibM47T2fF34ZhcJAajMKPx9vmxX9l6wORDm1x8/2ysm9
         pooFSpu2xDP71PfxYiJkd1enW73ZBcphBJT8V/rwKkFcwa8ak2HXNCM3N2V0rA8cvkyo
         mHy0uDmmAJ8tZdzNBYI+pXyE3sC6sIeP4iDsEgEq04IRpHuZylgyeNi4O4rkwm31Nwvp
         CydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911873; x=1743516673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyT+32LK+A27PsW6quCOsG6ro+lQiaS6tL1T9+kWwRw=;
        b=ZQePsWboVxOS9Vy5mOYeOhQbt1KfBYzEQZIvnr9xqheaCyNfso0xOPNk6fWh6sL6r0
         oJtywVHAVYUQDCwYGpMP2RO5A8GKLqgbl0huwVBEcD4LcickP1wtIihsXnxdGMLGZLpo
         vuHyV3Pw9SNlLJ9ycJWsVByBFcn64AxFud5lYUYWuoV/KqWWsX3LiLrwBpPKFc1i3uxV
         rMW5EYszsGp85XCkrRj1qAmB7Ug3BcwfBBHetlvEJ6YMlA51emeIuy9026A0R4dh2n9i
         l4u0JC5cdzpu2cTnWwKBdfJsz2iqOOymgycQuxUBUllClt2Dy/B31Q8RlbKVPtB1z5g+
         EtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY5oFP5F+dl8ViQcI7GjwK0o9w94k9h99MKGLW3bviy2Z4K4nAv8D2+mfE/zNMgKr/kHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeP1BOSuocq/JElFOR05tkyiE+LdIPR+jA5UUw8Bya8I0dB1V0
	AuoM2B5dEJm/JFJykPZEqcZwDqx9o9tC3gZ6CNcV1y+drAHbtLaH
X-Gm-Gg: ASbGncuyQz7pVcRhrfpDK0Ey5SGFve1U38vunV91rPf42X2L3A7t/DKnJKuldyVBCOg
	KJHNL4UezoJIJ8ST5FVi70XDJY/xTfz3BEs7Zz5CZHIj74XAfnn5Yw/YXRZ/J5AInT/B8xs1PND
	Qfu8dyMCNkdERNfWNOYMCi4OJ7xxeBOsxW+IPd2Ouc+47tg5o69pyh+THnDkZEOfIwyyRpxVcDZ
	A5cZovXJo8o4x853c8hzSf7Mi+jvlRN39aGGD5nyZEhI4ZbrDll2cIJdRKJZQHxFNqvlQPdql2t
	tmVRRxY1NrpDHCb0MwQUl5tBf+f5rScRBi6uDzMY9Ln04nY9NqtgBzt9OsZvcPrW6TR0MNPo4sB
	x0dj2
X-Google-Smtp-Source: AGHT+IHKVKtahgG1m7Tdx6vHXjWe+CS9GOWBxJwwA8IFIs2F6eJ/pV/0atMx/qpIbWs2P/FAtiNZXw==
X-Received: by 2002:a17:90b:4a8d:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-3030feb1386mr24995855a91.19.1742911873106;
        Tue, 25 Mar 2025 07:11:13 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22780f4a670sm90556965ad.86.2025.03.25.07.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:11:12 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Cc: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	john.fastabend@gmail.com,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH] LoongArch: BPF: Don't override subprog's return value
Date: Tue, 25 Mar 2025 14:10:46 +0000
Message-ID: <20250325141046.38347-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier test `calls: div by 0 in subprog` triggers a panic at the
ld.bu instruction. The ld.bu insn is trying to load byte from memory
address returned by the subprog. The subprog actually set the correct
address at the a5 register (dedicated register for BPF return values).
But at commit 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
we also sign extended a5 to the a0 register (return value in LoongArch).
For function call insn, we later propagate the a0 register back to a5
register. This is right for native calls but wrong for bpf2bpf calls
which expect zero-extended return value in a5 register. So only move a0
to a5 for native calls (i.e. non-BPF_PSEUDO_CALL).

Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index a06bf89fed67..73ff1a657aa5 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -907,7 +907,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 		move_addr(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
-		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
+
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
 		break;
 
 	/* tail call */
-- 
2.43.5


