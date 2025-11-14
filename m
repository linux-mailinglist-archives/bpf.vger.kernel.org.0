Return-Path: <bpf+bounces-74449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CB6C5B0A0
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 03:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 823534E39C0
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 02:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E0323EAB6;
	Fri, 14 Nov 2025 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei31hcfP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858227456
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763089067; cv=none; b=mx6APEBeFpgXb0LRTX6H2hHlv1gkJmR5OsbTe/BxRfB3QnjHjCz/VuzMeVCxJ1N1JWbgypY2eGP7v2z+p06ow1NJzfT2iHtQ3B4JNPIfCyHMdesKWiul5EBy0PCx2r19dBDwK9TQbc+DRnZmF6SQDl4M6hGKTbFAVBoAkVsHE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763089067; c=relaxed/simple;
	bh=5QfNJ3e4bOz9jjpXVHnuveL+F0hR+Rfb7Jtx/6Higaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wyjqh/twiuifJLnwQDoycSs+LaczAm2hGx1pNOEU9N5Ybdt6QTgVwx7Mt4qgaRs7LlM+GBT+faDAEKxGxfgTcDOaQl32bb0SDRJ/pCyZ6PE9E4c+oTUOyrAO/W5clysg/lPpP7498B9tTGBOlZSwSOBsKtWdWgAd1/KzImGWRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei31hcfP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29808a9a96aso14601875ad.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 18:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763089065; x=1763693865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcSJBFfOSAXquc2dHpscciy0yYklrvzEdyu/rvfXh5Y=;
        b=ei31hcfPaeUt+WkYn5sOZs8O7SE+eKIVxerS552V3Cm8F6UXEDWg4AKK98nDqBjcKv
         UkLmqTMs1dwcxiJ1UW8+LAp+ZdOjPb0pDI/MDRBzewKDlmIHbdI4o3DIW1UZ0OQNTO/D
         DPYmfFtvoEMggphMQd/PsqGTG1kkA5myMJe7aVrpHpvZtx93cq0bn4RZNkoAfUROiFbF
         dnSIZB87/oDE4jeVPcE00nmdx+lAVzjS5zDOhvp1mGkbPp1iBHgmjbJoZ4uSlV5BLRWJ
         VYF7gKc9wTTEWxlzaTUs+c0xr1LU3UZA7J08i+XRpSnRp2vkPyY1mRaWZLe9GccdYj0i
         FrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763089065; x=1763693865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcSJBFfOSAXquc2dHpscciy0yYklrvzEdyu/rvfXh5Y=;
        b=lbqubVCFYc+KDMhUSnSXKIgiN3z9hewfhfrk1qdSNakVpMvb6chXPQs4lIA/70xXcJ
         dhXaDsM4q4mbRaBSYkPZBfi95MVs6CeGj0uklnbdWzHy0T/BUC/O04e7KR4/XbOiY3lB
         S69bE4kpOYWFZRxHWDMFcDRsLw1WDN+LwbSYB2ZxukHvYlP3soo3YEMqLHHLgBfn5Ei9
         kQnNqv0l3Sv8UQDJANq2j2pqtbi61gu3Z2xRDPlsOshuHVV3mC06x2yTqZ+Kiu4blR+o
         n1nFHsk6chpe6qSyGS7sCY8A3DCavrcu+AdfaCs6CNBuOolKGGdzhTjdnulFIbtZ1Ixo
         Dqhg==
X-Gm-Message-State: AOJu0YyzB59g8+Wc6Kw7nhtLUQJVOjYm5UxA+TYAv985mZbUws+ZuwCX
	4Iws8bu2K52wgrYhskUysJUhk+OZhr0TKETEQp+oLrjkB/Cz0FUrUES0TwINeNXO
X-Gm-Gg: ASbGncuH+BvR0PVujxhHuViqrJovVycW5+nhjkJ+2P0WRsaHUB5IN1/YUPu1bQ9MWMj
	gyFA7i8A7H6pGxccEkxg0zQ6f4d+6RBXIG2jiT7dQh1bEydESYYj4frX3+QzKL0/sYI8bExwWFD
	8qqrC/l0fXjmJDEd4PPLmt1FffifUcdBtoU4hI2nOj3gOU/gKe5msrgO95ZBHFFowIvCiqZxnMV
	sR7gHhr1p4O8WLnojCoNU/eXgMjDQSEwmoIGePK2Byq3RimuxhVmEzb22yxVWDX1b6ovRz1ADtB
	Lu6iFXbrL8y2ff1aGuei18Me9nTFrpDMk7QYi+/7x/VqMjm+QM/tbhNj6b7FeeFCQZMzo+ZOEiU
	RafHtxd6UvP7cNM7mEZ0pdw7o87gGdDFqz1C1Ll87kJ6bC57FrlQcpaYnabV2RJ7r+3ms/iUvzt
	jpm3ZKnCJ2nnN8
X-Google-Smtp-Source: AGHT+IGjfxvsWp+7Y/CIH9DTM/E9Bs/4QksfsWh/XK7X88d8nqrf+tctERIhFz0HbbagJaAlQuQqfQ==
X-Received: by 2002:a17:903:8cc:b0:298:33c9:eda2 with SMTP id d9443c01a7336-2986a73b4b2mr14061215ad.33.1763089065189;
        Thu, 13 Nov 2025 18:57:45 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c92sm38579195ad.69.2025.11.13.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 18:57:44 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v1 1/2] bpf: account for current allocated stack depth in widen_imprecise_scalars()
Date: Thu, 13 Nov 2025 18:57:29 -0800
Message-ID: <20251114025730.772723-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage pattern for widen_imprecise_scalars() looks as follows:

    prev_st = find_prev_entry(env, ...);
    queued_st = push_stack(...);
    widen_imprecise_scalars(env, prev_st, queued_st);

Where prev_st is an ancestor of the queued_st in the explored states
tree. This ancestor is not guaranteed to have same allocated stack
depth as queued_st. E.g. in the following case:

    def main():
      for i in 1..2:
        foo(i)        // same callsite, differnt param

    def foo(i):
      if i == 1:
        use 128 bytes of stack
      iterator based loop

Here, for a second 'foo' call prev_st->allocated_stack is 128,
while queued_st->allocated_stack is much smaller.
widen_imprecise_scalars() needs to take this into account and avoid
accessing bpf_verifier_state->frame[*]->stack out of bounds.

Fixes: 2793a8b015f7 ("bpf: exact states comparison for iterator convergence checks")
Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8314518c8d93..fbe4bb91c564 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8866,7 +8866,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 				   struct bpf_verifier_state *cur)
 {
 	struct bpf_func_state *fold, *fcur;
-	int i, fr;
+	int i, fr, num_slots;
 
 	reset_idmap_scratch(env);
 	for (fr = old->curframe; fr >= 0; fr--) {
@@ -8879,7 +8879,9 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 					&fcur->regs[i],
 					&env->idmap_scratch);
 
-		for (i = 0; i < fold->allocated_stack / BPF_REG_SIZE; i++) {
+		num_slots = min(fold->allocated_stack / BPF_REG_SIZE,
+				fcur->allocated_stack / BPF_REG_SIZE);
+		for (i = 0; i < num_slots; i++) {
 			if (!is_spilled_reg(&fold->stack[i]) ||
 			    !is_spilled_reg(&fcur->stack[i]))
 				continue;
-- 
2.51.1


