Return-Path: <bpf+bounces-71628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD27BF8872
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825D53AED4D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3B1A3029;
	Tue, 21 Oct 2025 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anmNp/FL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6126FDBB
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077030; cv=none; b=sXZ+kU30vT4fsx9R7w3VwF86lR9M0z7lYnqnwyzLD9oO8XteR1wOsm8+NbJ/kfv+PDJ4xMf4i9xBncnDk8vnnPiOCIWGsJMRo9ETkCGaI5OPUbit1c82EgsQjL31CfZeTm/VeR/1x4WM/4Q/HQsUQ2bkxCPy2cQ1PJncBWbtMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077030; c=relaxed/simple;
	bh=oNUFvWfInTuGrt36stksFp67gbQekI9BJskeo8/qH38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzAd6ugfIF2AxPcilb90GLpUBVGYZnCdYVlnBfZFujOnsfN7LYYsYBpQ3AW17CVu5AVkHxs2lY8q+1zJK0yUssUYJetXJ4tKSNkP0nYKkhVg4O64ZiertDgiFA4dOU0kTeWpsZ3P/LmvZHL5ms3plOOJPLcx8JWTtw51AkDVw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anmNp/FL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471b80b994bso42659685e9.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077027; x=1761681827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdeR4xOE21nSUSdowOevNyf+AEOxeu6NhRwR0H0Qhm4=;
        b=anmNp/FLr9CfwyNDVgU9GhthCvJNUyOO5FeFiNqLN4SGMV2GGHG90szHrxA3WLDwmK
         neb3EcwAgdYtCPUHg90r/Jbqe8LHdQVDtWeqADUkHN9tmAcIHYjVGyMr+X+h2KyngoLb
         EaHKyxhixKtse3AThXV/UmJdH4wt+0923aH7B+xXoiJEBWzXvmz2mPuVHOzSk8UwAgiL
         sfASHLf6WxxH86XrWo2asyy9pnijgNKpItcFntoXlwD4J1IU1SfhIyfNqa0QbTG2JHxE
         nyP7JuQ9NQ5oxLhUMR68I4giTM70hybcJzu28kBkj7131GWneJlhKY5BJrFV9gS+ORf+
         gE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077027; x=1761681827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdeR4xOE21nSUSdowOevNyf+AEOxeu6NhRwR0H0Qhm4=;
        b=YcUBJNJetiu+PJ5dFGzGbiCuurQ0CDuANpsOZCkxOOZzSM2q0oe0T8IprQkOaZqpEp
         d55kuTV/lhRkjy2AHfIL/fr0PP7Vl/VmWJSRHGd2p2JJKZVTzxeJJaCtYLiTJB0IYsY+
         XXShxTgSXbNq5LYJRUAy+35DBlN8F7vTxiJfn0PuhhGLwf8ygHcKB1PljaUMwxeRLzLQ
         Zt2EsURduOoS9BBQTDFExU6VKJCu4zEu/fmRuT+jO+VxhWhdZ2N7uiPkJn7p8/5TDNX0
         1PvQegjREQcF7U8e2VFE2VKo8mpN0/raG84H/T5UcOUECS+DlfGf+l7WLmcLoYTlKX1u
         0uxg==
X-Gm-Message-State: AOJu0Yz6Zk8tNK4q8G+smTmwrhpjskV3qJ5+1+Rln3Hq4Eop75K3Mjgs
	iDbRmoBzMIwjFy1LvMvVQHl3EnPTMEldSv7Y8WzUuwtuH1wW1jkO1eN51e4acw==
X-Gm-Gg: ASbGncsMtwxYLi3BPIClUjuTeWGxfzDYuynqsYqbxBFAlhHW5JwBvze2FsmEoASAjF3
	R1nKVgBISI0YembZ9Zs011hameC0G1w9R5bzeXF/AJ7BBS5lHuo+dkfUD9iAl/oQ5+bzG+Wse9b
	kFOFf++QyqiYslsxRT2epk8+N8EIup4A7ET5TlZ1qk1Jvj8lqDP3ZO7K7sOTRYyxH7RU59HPzYU
	b0AFb5cj0Pv78H7NgTWwwxwCmFXTtzt3izkDfKtisiuL3kujjqmfMl66WRi/i3qGOiKTE/5972E
	+U6qkcSdWDnzb57UlFplSBfUxCW8ssRwMrf2HgONg6wMggx3zKckJhRG6h6kJ1+kIpirE7UVvdu
	sSeMXPAY5JCcTyGhpaPjmdaLNsME16E+NrHTiHkM3i7UCygLQggeJI8uzORjRfjggpdhIRzA=
X-Google-Smtp-Source: AGHT+IGPpT6CakIp6rkx2J0eHGiJFBWxVs0wBfnNhdhIaByD1kgFM2RWo9efxxBrV+oqjM8QddgYmw==
X-Received: by 2002:a05:600c:190f:b0:470:feb2:e968 with SMTP id 5b1f17b1804b1-471178b125amr134040735e9.15.1761077027383;
        Tue, 21 Oct 2025 13:03:47 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428dafesm8140565e9.6.2025.10.21.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:46 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 05/10] bpf: verifier: centralize const dynptr check in unmark_stack_slots_dynptr()
Date: Tue, 21 Oct 2025 21:03:29 +0100
Message-ID: <20251021200334.220542-6-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the const dynptr check into unmark_stack_slots_dynptr() so callers
don’t have to duplicate it. This puts the validation next to the code
that manipulates dynptr stack slots and allows upcoming changes to reuse
it directly.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b4f6920f79b..157088595788 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -828,6 +828,15 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	struct bpf_func_state *state = func(env, reg);
 	int spi, ref_obj_id, i;
 
+	/*
+	 * This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
+	 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
+	 * is safe to do directly.
+	 */
+	if (reg->type == CONST_PTR_TO_DYNPTR) {
+		verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
+		return -EFAULT;
+	}
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return spi;
@@ -11514,15 +11523,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	if (meta.release_regno) {
 		err = -EINVAL;
-		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
-		 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
-		 * is safe to do directly.
-		 */
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
-			if (regs[meta.release_regno].type == CONST_PTR_TO_DYNPTR) {
-				verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
-				return -EFAULT;
-			}
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
 		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj_id) {
 			u32 ref_obj_id = meta.ref_obj_id;
-- 
2.51.0


