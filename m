Return-Path: <bpf+bounces-54154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3993A63AD8
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 02:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80113AD040
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93538DEC;
	Mon, 17 Mar 2025 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKzyfMIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B355199BC
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742176692; cv=none; b=fTl/EMs3EelcihsX2OGt5uRxkUoSkIwB28RaA53cIIPnsWaqygniwSrBVxCky2jImO7Qre4I/pRW+wkRoGj3z0XqgaIcjb44TGvfAfgZTA+nuYbk8yRhZ1jGzZw0+p7KRqeH2neQF+8eVmu28ZW8SwvFWDHABNuiwZ/tFXwqbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742176692; c=relaxed/simple;
	bh=a4JdCD3BsEmNOHBRufM3YOkdQanMwoOybstzT8e9gd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFgrvGGZjVUuYBLGTCa5w35wZekP4LmFp38sLnHIbvbiKRqbewqD9QUCvIl+wdEAkFhqDaaLe5QqOZbWz/uG71eI8+/B682MvGzwFUBJGFSbYuxSznKM/6kwCpPgVnvD91yRepN35UC3KdP+QQXOgT+fm/swTfXcnTBXe4QzhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKzyfMIQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fb0f619dso60855075ad.1
        for <bpf@vger.kernel.org>; Sun, 16 Mar 2025 18:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742176690; x=1742781490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr+PZ9C3ll2NSSQdspls9bOCus20ykgzWKM9RCRpL9o=;
        b=EKzyfMIQgflQTTYCaAAbpnJTZ6HPKjvh+L/kndYyAFcgHoOMK+t+lwZBDmlLD2lXhK
         PmpKvrrGpz0Czmk7v4i97EC6x1XzbVzEjCkEk9iphbQeUmv3aidlB5olve7+uPk/0p5I
         oe6uhaCZC2fWZsoMelzeSOqIQ+rXyhgwsyZkR8ynUGYgV0eMh/d3fjsCXFjmQj8l5Z+h
         0IFPvR/VYot/xC1D7Z+WICddQpLwAs+8358UvARca0zQqOOLTMN5m7OCZSspvaHsiPbq
         M7wldixMrBST/H06pw0VigTYufRBaDsi0Zc+Q+dr7ltPHbU+hmmDS2G7+Wzh+hIuwccQ
         2Z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742176690; x=1742781490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wr+PZ9C3ll2NSSQdspls9bOCus20ykgzWKM9RCRpL9o=;
        b=dxgci+YNDQhKRVXTcdgYLcglo0pFIZUcoThfl8n3+ImbqaaLIljI/EA3ZafR35e0eZ
         OQTtfgrIpFuQMl3vC5oieqR4E45hWcucVNf3QiGrbiMMw7tyUleoVsGXmCD7C8/3rg9a
         Mm+0v/wiXdgrnaWszeXhypXJ2gDLhO/gTcbs9AHlAEiVpUJ9tHTLvG9y0Iu50ejPr89p
         ztKFKOJ26NWYrqFX3hC2HCj4+bGasuRz9wcP8I/7/DnHlLMTLzVd0xWsYdd7Cx0Q1o9m
         EHoPVepVYjX1xxRWHZnW6rBC1d8t0VYY1KcXJA+V0dD/hzsvjOsEbyPuQoM+89fC8W2h
         6PiA==
X-Forwarded-Encrypted: i=1; AJvYcCWS/rT9+DA5j1F7NzAdrx43MWx/LnCYW75Ih6Vjd5NxcAKuGR/KhBI23Gg5m3O0OB/qf80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDT8baT45TKLjt8AF0yCscnfL7UmzG1aLaW9m+ZFMbyGSBgap
	FrVrLugBbQl8V8LRhUj9kF54mx+cZ45my7YqVPFEipQBykVCA274
X-Gm-Gg: ASbGncvz8NnW+QxcjjOZ+5wfjbDtv7ibDXI12ARzMD3XQfglKY/eY5pmGgPGx/847na
	2u/JewGo5CtzccAcbuZYqdsWX7zBDYS2V7lK8D8QlqIa1eY6aYcw2ffE8ln5m46UUjyVXlNgIq2
	fDv9sDvEP+e2hUbzOpXw4iBkvAkGj9GppcX7kk1XXauFSfiX8MQAZckulIoC3RZwBDvEmB9f57k
	ZrGCwmC7fQM56H+JWeQG0mWQnGqI1N0UTpiyycBZbLWCWaceVjywPteK6JuqIV7SzrCz1xaD8lv
	CKR2s4uO5h8T1rPS6BUUhx5qTeBcnDFKstPLTEzaqDJ6TTaZ9MnrrQHBeEdMtMVo0beOAOoqqDp
	thDm0
X-Google-Smtp-Source: AGHT+IGy50NnLmPbc3/N3BdRHwVuZHsZX+6C1d9drBaxvMt697gIhy00T72iiF0t4DBhlnJtVf0mxw==
X-Received: by 2002:a17:902:c949:b0:223:5945:ffd5 with SMTP id d9443c01a7336-225e0af042bmr134345835ad.32.1742176690457;
        Sun, 16 Mar 2025 18:58:10 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-225c6bbe960sm63432075ad.200.2025.03.16.18.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 18:58:10 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Cc: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Vincent Li <vincent.mc.li@gmail.com>
Subject: [PATCH] LoongArch: BPF: Use move_addr() for BPF_PSEUDO_FUNC
Date: Mon, 17 Mar 2025 01:57:55 +0000
Message-ID: <20250317015755.2760716-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vincent reported that running XDP synproxy program on LoongArch
results in the following error:
    JIT doesn't support bpf-to-bpf calls
With dmesg:
    multi-func JIT bug 1391 != 1390

The root cause is that verifier will refill the imm with the
correct addresses of bpf_calls for BPF_PSEUDO_FUNC instructions
and then run the last pass of JIT. So we generate different JIT
code for the same instruction in two passes (one for placeholder
and one for real address). Let's use move_addr() instead.

See commit 64f50f657572 ("LoongArch, bpf: Use 4 instructions for
 function address in JIT") for a similar fix.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcalls")
Reported-by: Vincent Li <vincent.mc.li@gmail.com>
Closes: https://lore.kernel.org/loongarch/CAK3+h2yfM9FTNiXvEQBkvtuoJrvzmN4c_NZsFXqEk4Cj1tsBNA@mail.gmail.com/T/#u
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index ea357a3edc09..b25b0bb43428 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -930,7 +930,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	{
 		const u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
 
-		move_imm(ctx, dst, imm64, is32);
+		if (bpf_pseudo_func(insn))
+			move_addr(ctx, dst, imm64);
+		else
+			move_imm(ctx, dst, imm64, is32);
 		return 1;
 	}
 
-- 
2.43.5


