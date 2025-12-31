Return-Path: <bpf+bounces-77566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE1CEB4CE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 06:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA6B3026B2D
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 05:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FF930F93A;
	Wed, 31 Dec 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwsrcA2U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942113B58A
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767159383; cv=none; b=nVY/MdTEmipky3B5mI5Q+lzwX18OFdnnNrQEO4T4mESrwIYpSZoMlAHdZgDn3FOqpDA8z2mn8QSt/274y8j4uvyd7qkYYlSlJ0VcCZ7DBRwdjcYk8DzyyHDV5TXUC4XDSypF3i5EIEWdl6q6GW+9g42gnAJ9DrBDeRS5eaIdCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767159383; c=relaxed/simple;
	bh=+xsaz6nF+G0aFSF8r8ClAovUFFFq8WWa6ytRAk/YMM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVR2U+vWi/0oKDuooTCz/KSM+9+II2ZLmF+2mdjMzI1fDYprTgXS+SQho16n47n7tYgicePDe8Urntip10uadk//mn5D6phkuVrveOZEyKZmUeyYGdQFKHjkYBJ2ALRlwOziAbta4qXXADx57KHtNpH3ElNtAbwnyoOJN+uHjic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwsrcA2U; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b80fed1505so10559587b3a.3
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 21:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767159381; x=1767764181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCn7QOxQRmmhgGGjbkUgy7YWxygtnBFEDz7q8tSzXYE=;
        b=PwsrcA2Uq3IFemfgrtBUXDv5g45sXzBPq8oKc1qzvfaOeU2Hsl2mqeOWrjQ3lqaHnE
         YWbkUTFq1abQaIYenGsJDEIq02Msvl8XMFjI97UEZkPQfCH75VGLYT43pplW8Xy4kXnB
         VOazlr0vkNvRE9PYnX/jG593N2CTDZdxbnvydOoG+DdDMgTgpdYxT7sDT/9xQWzdywpz
         BJDHupZEhVywdsf0g9zpgG5NzedJ0oyTxwW92kUO7fSvTxvl3LURTWZETFKhAljrbof0
         WnY8RTppydoXPMxlEcQDeCZUrkTQ7a6cwr7sb4gqqbQUJr25aZQndrxLucPZgQswjMfu
         /mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767159381; x=1767764181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCn7QOxQRmmhgGGjbkUgy7YWxygtnBFEDz7q8tSzXYE=;
        b=Z1eeO0EGRwNaNaUVvp3b2BxliZ+0doTzoL9IFJh2TN/VN6lh7yJPE5Qe+nY/w7Scak
         JzXCqF/nEf1NJvQKBZ+6mZ61H8KmvWG3ZI9gpwSgs3J2Z69ZSALdWIU57SY45iZXil0g
         gImo48DYwxQdwG5zmJowp/ihp+4b0F8TI1thrz1o0JmCuiygS0A+EGqoXS/iN8xBnU+Z
         a/AAezMzqNxIAbNKhE2qNU51nldtWURv3g4LSjjWr8N1Yyh42C9w9YH5eEkUKrMSqqku
         S3oB117ceZcbTeSsdUoE9lGBVfZn2eEeXQBoq4bf2/OoG6JThboOKdVy2XV3Vs0+WqnG
         Vl1Q==
X-Gm-Message-State: AOJu0YzJ5gtuncSVDqnrgH8EAP6VB+5reHl1wUt/VIgU8eAODDQ98if9
	l5HU5HTBF8xbus/tawk+Z9Tmyuv9c5SHDPEsoo0dbZ5jo3i/2E3wx28kkPTeBy5W
X-Gm-Gg: AY/fxX7alGA8GMHA43v9htBphAIFp9jyTbqgMEszCLMcislnZshF0ElMWJGmlHEV10N
	EPvuNyAJHc44KoIa5R6I6kE6Z3GvJGR+eKiz+34xP+FFGZgqey2cit0x0I4ZgXPpNRINd1RQLXh
	Kmxium0hfOWVQ1hWm8ygYf7T7d/eGzhL5i2VqPGJmW3yi/QNjhyFJ73AFPlg+9XO4xJ7X/rMUGz
	ezXSccxQoqvdra6KoiNWerYruGC06njs/oW+4J98D+lgX0s1W1ex2yB/jzYhA7LkorUdADRXEIw
	RJ8kTDA4D56hO19HWWdgTf3Ry51knq3CS1WxFN/f4VkkLAYpihrxY66ETFnZgra/LEEN884pqCN
	/OTwhx8g66GqPbmQBHZSYv9AlKSvX49uq+kYGUSWBi6BlnmwYknILR4l0h8hqzLlPPMAWpmirU8
	cC02CtFzocjwRkrjFBVLZ/SLOTbE6Ue0ilXQ==
X-Google-Smtp-Source: AGHT+IHctfEIhV8IiMs6QfOgNcUa4Cm/Kjga1bPnTSXyNPrE/F//jZBaFr5m+IihWgjD2iPOv33yOw==
X-Received: by 2002:a05:6a00:148f:b0:7ff:a139:4011 with SMTP id d2e1a72fcca58-7ffa139411emr30389859b3a.29.1767159381103;
        Tue, 30 Dec 2025 21:36:21 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm34050165b3a.33.2025.12.30.21.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 21:36:20 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: allow states pruning for misc/invalid slots in iterator loops
Date: Tue, 30 Dec 2025 21:36:03 -0800
Message-ID: <20251230-loop-stack-misc-pruning-v1-1-585cfd6cec51@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230-loop-stack-misc-pruning-v1-0-585cfd6cec51@gmail.com>
References: <20251230-loop-stack-misc-pruning-v1-0-585cfd6cec51@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Within an iterator or callback based loop, it should be safe to prune
the current state if the old state stack slot is marked as
STACK_INVALID or STACK_MISC:
- either all branches of the old state lead to a program exit;
- or some branch of the old state leads the current state.

This is the same logic as applied in non-loop cases when
states_equal() is called in NOT_EXACT mode.

The test case that exercises stacksafe() and demonstrates the
difference in verification performance is included in the next patch.
I'm not sure if it is possible to prepare a test case that exercises
regsafe(); it appears that the compute_live_registers() pass makes
this impossible.

Nevertheless, for code readability reasons, I think that stacksafe()
and regsafe() should handle STACK_INVALID / NOT_INIT symmetrically.
Hence, this commit changes both functions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0baae7828af220accd4086b9bad270e745f4aff9..3d44c5d066239f1f86ec8d2f40d3a6abac222d66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19086,11 +19086,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	if (exact == EXACT)
 		return regs_exact(rold, rcur, idmap);
 
-	if (rold->type == NOT_INIT) {
-		if (exact == NOT_EXACT || rcur->type == NOT_INIT)
-			/* explored state can't have used this */
-			return true;
-	}
+	if (rold->type == NOT_INIT)
+		/* explored state can't have used this */
+		return true;
 
 	/* Enforce that register types have to match exactly, including their
 	 * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a general
@@ -19259,7 +19257,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
 		spi = i / BPF_REG_SIZE;
 
-		if (exact != NOT_EXACT &&
+		if (exact == EXACT &&
 		    (i >= cur->allocated_stack ||
 		     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
 		     cur->stack[spi].slot_type[i % BPF_REG_SIZE]))

-- 
2.52.0

