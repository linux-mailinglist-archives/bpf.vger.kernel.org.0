Return-Path: <bpf+bounces-47679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C05E9FD853
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 00:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6914164436
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4DC1607B7;
	Fri, 27 Dec 2024 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASyg5kLW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446B7082D
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735342632; cv=none; b=l4c+FgDKWyO7CLcN3IfhQpl8GwlB2nG5spaw6Fq+oUSlw+NNhVWWUJs+wV/N5mGFJQ2Ntnuz/V6o6Q5ZdEgyg6E7a3PXKaQiqvJnFcSfQ7QRBr/SuPl6KRh3n+q/ChHSRH8O6GZmeSguDXXqvSQrScFB92QyZFD3LiEP8tjbOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735342632; c=relaxed/simple;
	bh=jeYGpNbfMGy/V90Rw3DjheGF1B7L4iKDd6Yfn7EfS3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BI42wt8xbOxE6d69Sjtkg0KEZIcUUcK28VCvwyIMPXt7WXujg/4fYrIJKbwCxnZ21efOATguM4kNOcUnWeidujehO5zSQhC1I+fmeS8caiX3870I8IrpD8A3iYvvDqR6hMRZ37prKU0KsibS6cXgMJ/sxHY83MoE/86lGEWIel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASyg5kLW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so15517685a91.2
        for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 15:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735342629; x=1735947429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1Jom10EOQH/PKFAAJHq8N5xyHFec0ta56+9r5GmZ5A=;
        b=ASyg5kLWVKJfTr1YOPU16bTh9bRIwNm7o60clWtsocgd2kuN70hNCQQShzqwxAL9Ef
         3jxntJFkL6iJddeuRQsmA7ZjPsrKxLgJ1B3r4aCPN5YXTgeKDu18eM+yNmetpudC+Zow
         p1a0iUN1qPzWc6GMBV2i2Gdtc8WajM+n5hei+9xAmwotfl4xbZdpbQSoem7iDqtJa0PF
         lIvPY1c1oeCfEN/Zn9K64zuRoVbrTLTme9Td81KcvWttPvDuHH5swL+jFw4vS6m8yPhB
         MlGzyqRrd3MbDIwtkSA7p7914O/xkSE0KuEgWbu/Y4Kl8QHA6f52ayMITjeHI+linyCp
         V+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735342629; x=1735947429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1Jom10EOQH/PKFAAJHq8N5xyHFec0ta56+9r5GmZ5A=;
        b=CosmXbQWOhMQUdrBpIlzBFJD+x/1a5Updq/oknJsioWHJTmJPN+vsjomRufdPxaOIO
         Jf2sFfU/uLwgwoMMfqo/WO+hYI1GZRhdQ6v6cgXeo8tn6u7FNeRqq8V2Lp6QnLDq5Y8G
         H6U5jGXPo1SKy8bGoItjAIX0zXu1PWMhoa8T968+om2fPzTSVuHc0C+x5ExEWm1Uow9O
         fX/r+6LuqKKrWGBHKUD22nF/CGzR3h/p6I8nWAl9aYPfRaQ4+57CYsv1nC7laO67B5py
         C9loPdTX7huAQV3r5K1Gk57H6lSwE8V7VMzDB2vxSXxe5M+5McTanTZgWHaHotjul6Co
         +vwg==
X-Gm-Message-State: AOJu0Yz5yvKK1Tz2IorLbb1BDgI5vPNrY5c4e7C+IssW1OkR440MBXfX
	q/Gu+A1iJFMAO0XZLqe8pkP7fiN1+EDh7Do4hJyQPnEz4P2oTCNN21cQmdgzH9XbrqN2I65CJm1
	zWzbH9wdpwLxcHfGf+83JGIwc7VWv0e4ULPyEs6VPosb3u+dLGaUX57NdmtTloRcdh6F5jPkynv
	1YOQbrJpA6YJaO1yQoJhK0hxpkfTBRLzaiwMbFV+Q=
X-Google-Smtp-Source: AGHT+IHLqDFBZY1ka2PsyCGmywlPi9etlGqovVDfnWYdL0s2CLTlisPa8ylI+ySeYFuG7avGHeJOt2PnDcL76g==
X-Received: from pfbf11.prod.google.com ([2002:a05:6a00:ad8b:b0:728:e916:1a4f])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:808f:b0:724:59e0:5d22 with SMTP id d2e1a72fcca58-72abdebb934mr45961712b3a.20.1735342628610;
 Fri, 27 Dec 2024 15:37:08 -0800 (PST)
Date: Fri, 27 Dec 2024 23:36:22 +0000
In-Reply-To: <3b84fa17ab72f3f69e09e0032452d17eb13b80db.1735342016.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <3b84fa17ab72f3f69e09e0032452d17eb13b80db.1735342016.git.yepeilin@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <953c7241e82496cb7a8b5a8724028ad646cd0896.1735342016.git.yepeilin@google.com>
Subject: [PATCH bpf-next 2/2] bpf, arm64: Emit A64_{ADD,SUB}_I when possible
 in emit_{lse,ll_sc}_atomic()
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
to the base address by emitting two instructions, for example:

  if (off) {
          emit_a64_mov_i(1, tmp, off, ctx);
          emit(A64_ADD(1, tmp, tmp, dst), ctx);
  ...

As pointed out by Xu, we can combine the above into a single A64_ADD_I
instruction if 'is_addsub_imm(off)' is true, or an A64_SUB_I, if
'is_addsub_imm(-off)' is true.

Suggested-by: Xu Kuohai <xukuohai@huaweicloud.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
Hi all,

This was pointed out by Xu in [1] .  Tested on x86-64, using
PLATFORM=aarch64 CROSS_COMPILE=aarch64-linux-gnu- vmtest.sh:

LSE:
  * ./test_progs-cpuv4 -a atomics,arena_atomics
    2/15 PASSED, 0 SKIPPED, 0 FAILED
  * ./test_verifier
    790 PASSED, 0 SKIPPED, 0 FAILED

LL/SC:
(In vmtest.sh, changed '-cpu' QEMU option from 'cortex-a76' to
 'cortex-a57', to make LSE atomics unavailable.)
  * ./test_progs-cpuv4 -a atomics
    1/7 PASSED, 0 SKIPPED, 0 FAILED
  * ./test_verifier
    790 PASSED, 0 SKIPPED, 0 FAILED

Thanks,
Peilin Ye

[1] https://lore.kernel.org/bpf/f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com/

 arch/arm64/net/bpf_jit_comp.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 9040033eb1ea..f15bbe92fed9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -649,8 +649,14 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	u8 reg = dst;
 
 	if (off) {
-		emit_a64_mov_i(1, tmp, off, ctx);
-		emit(A64_ADD(1, tmp, tmp, dst), ctx);
+		if (is_addsub_imm(off)) {
+			emit(A64_ADD_I(1, tmp, reg, off), ctx);
+		} else if (is_addsub_imm(-off)) {
+			emit(A64_SUB_I(1, tmp, reg, -off), ctx);
+		} else {
+			emit_a64_mov_i(1, tmp, off, ctx);
+			emit(A64_ADD(1, tmp, tmp, reg), ctx);
+		}
 		reg = tmp;
 	}
 	if (arena) {
@@ -721,7 +727,7 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const s16 off = insn->off;
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
-	u8 reg;
+	u8 reg = dst;
 	s32 jmp_offset;
 
 	if (BPF_MODE(code) == BPF_PROBE_ATOMIC) {
@@ -730,11 +736,15 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		return -EINVAL;
 	}
 
-	if (!off) {
-		reg = dst;
-	} else {
-		emit_a64_mov_i(1, tmp, off, ctx);
-		emit(A64_ADD(1, tmp, tmp, dst), ctx);
+	if (off) {
+		if (is_addsub_imm(off)) {
+			emit(A64_ADD_I(1, tmp, reg, off), ctx);
+		} else if (is_addsub_imm(-off)) {
+			emit(A64_SUB_I(1, tmp, reg, -off), ctx);
+		} else {
+			emit_a64_mov_i(1, tmp, off, ctx);
+			emit(A64_ADD(1, tmp, tmp, reg), ctx);
+		}
 		reg = tmp;
 	}
 
-- 
2.47.1.613.gc27f4b7a9f-goog


