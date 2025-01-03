Return-Path: <bpf+bounces-47820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6292A00296
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 03:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131991883C35
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 02:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB8B136349;
	Fri,  3 Jan 2025 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UedJ4dqh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BF1862
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869889; cv=none; b=tiw2XlyAE5c9TG+rdOqIKW7j+eUIXyfQMKux8hs4ujLj44t/CvQeWontBLzn20qruzYZg8FE6dgc2v4Df94vR0hy6nktnzA7EoDf3WstscwE/l46rrzQ2mzgnM3D7m6BFpgk/1emA1vJvKJTT6SLg10F8XYJVR6CNYlagmsp5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869889; c=relaxed/simple;
	bh=cXAi7bBYPwuN2p39neBGKD3ONxci6buooHsHLy2tIIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jr3i1ofACrMQpqMqtq43zgypOubvE1LJBFL1U38OrN/fxcEzx2e+nBSgG/68h5D4n7IQo+ph08xq61JRh1e5nI1NAJthCmeSHm3PuvgqMryzdhu38gkkaeoWngsTK/gtOoJHUklM/1NVwF7Uxl+/GIpgkqSVEfFtjs6qfwTWNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UedJ4dqh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2164fad3792so154847185ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 18:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735869888; x=1736474688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4UjZolz5E/NeRAD/hPdz8QuR6mdLUg8da+IaKtziAes=;
        b=UedJ4dqhgQ+sbcktpUWyYJlkixyb0RTwurNbfY4bOQ+7JjI4GSx5R96WWcgZYQXL2w
         WYFBJcvnFXpy64EXwUedvQW2dT7wPkdAvMQ6eUqXK849u1ksUg8vDQC203sLN90e9n3j
         vRutQ8KAS8931Hw+xR1c3iZvXeAGwKYnCsbXY+EdCq7aGuOkJu+XprpbVvBJMh8SGimB
         7p8qA9RdOgifcQ0KfpUkkxfSIQNPItCwQwtc/v7BEHiAz5Y8ue2E41eJ3GKZxA/DIbPV
         sRCg3VkLe5/0Omi+d6vqXxkbNTG2PQbNab3uaSfL/COAi3Wjf8FcDJ0uFO+PZPHrz6Ga
         iDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869888; x=1736474688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UjZolz5E/NeRAD/hPdz8QuR6mdLUg8da+IaKtziAes=;
        b=GivvWXzxeb6BPCq/kD6tGYcSg0bAbGz1nKxcUjTZfmqoDIcwHK9LuhGn3+USlPwY1I
         1MBBXjjdBZUx1hcz9xAWlxkJasf2YWXx+hietBT7AZHJJHhskoh8yJTalusJvygHw4Ec
         GKS+aExHaAzBmmtlRyqtdVOWu5/z8H0DG25UakkwhvE+9Edvug9Cs1YJfBe9vxmyI0Xh
         2UqP9YnggZcWCj2Z1r1ZW+UvesNcIshFMys3gwUzCEyyfcRXrloeROLB5Rcj/3Z7qR+5
         4xPM7wfSOfkGiVnhabs6Gmo2U5IaPni4+56ld7LrN6kYDG8EScltRn0H/LDl/lLRV4pm
         IBfA==
X-Gm-Message-State: AOJu0YwpY5Pfo0TDAUAZXM+gLTDJkf4WriGQnvMRvLmBnwvM6e2fn5/m
	i3aWKolPZHaEdlHYSngRpQehrXDTKV7kXyeL2Tp24Y2/gx/rrXeMqgwm/ahmwNTKcEXMKNob4zR
	3CJrZS1ShluMn+5rQZi6nUdU6W9VIr6BKlpQRazDwH0qRZkrA5u4RGmHDIe/77b/2otJGBx+jpL
	LeyMNa15AoEol1oS/38bwN4gPGZ/MVXTLe4jHc+Uk=
X-Google-Smtp-Source: AGHT+IFn9sa16Ybx9bMnT3j8/6v7ZyNcSwDP48OOodsufyBW3mKo0tvoS5jljQA1jigXnWx+/SHMhWvEv0+uPw==
X-Received: from pfbc2.prod.google.com ([2002:a05:6a00:ad02:b0:725:eeaa:65e2])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7896:b0:1e0:d9a0:4ff7 with SMTP id adf61e73a8af0-1e5e08011d6mr82625682637.32.1735869887482;
 Thu, 02 Jan 2025 18:04:47 -0800 (PST)
Date: Fri,  3 Jan 2025 02:04:18 +0000
In-Reply-To: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <9ad3034a62361d91a99af24efa03f48c4c9e13ea.1735868489.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 3/3] bpf, arm64: Emit A64_{ADD,SUB}_I when
 possible in emit_{lse,ll_sc}_atomic()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently in emit_{lse,ll_sc}_atomic(), if there is an offset, we add it
to the base address by doing e.g.:

  if (off) {
          emit_a64_mov_i(1, tmp, off, ctx);
          emit(A64_ADD(1, tmp, tmp, dst), ctx);
  ...

As pointed out by Xu, we can use emit_a64_add_i() (added in the previous
patch) instead, which tries to combine the above into a single A64_ADD_I
or A64_SUB_I when possible.

Suggested-by: Xu Kuohai <xukuohai@huaweicloud.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
change in v2:
  * move the logic into a helper (added in v2 2/3) and use it (Xu)

v1: https://lore.kernel.org/bpf/953c7241e82496cb7a8b5a8724028ad646cd0896.1735342016.git.yepeilin@google.com/

 arch/arm64/net/bpf_jit_comp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8ee9528d8795..8446848edddb 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -662,8 +662,7 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	u8 reg = dst;
 
 	if (off) {
-		emit_a64_mov_i(1, tmp, off, ctx);
-		emit(A64_ADD(1, tmp, tmp, dst), ctx);
+		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
 		reg = tmp;
 	}
 	if (arena) {
@@ -734,7 +733,7 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const s16 off = insn->off;
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
-	u8 reg;
+	u8 reg = dst;
 	s32 jmp_offset;
 
 	if (BPF_MODE(code) == BPF_PROBE_ATOMIC) {
@@ -743,11 +742,8 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		return -EINVAL;
 	}
 
-	if (!off) {
-		reg = dst;
-	} else {
-		emit_a64_mov_i(1, tmp, off, ctx);
-		emit(A64_ADD(1, tmp, tmp, dst), ctx);
+	if (off) {
+		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
 		reg = tmp;
 	}
 
-- 
2.47.1.613.gc27f4b7a9f-goog


