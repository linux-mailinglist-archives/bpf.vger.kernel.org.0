Return-Path: <bpf+bounces-71023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02ABDF970
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD9E1A217AA
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF13375BD;
	Wed, 15 Oct 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqaqqWPK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CA3375A4
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544726; cv=none; b=G19l9eFCJLznWBcy6JjUvRIVgBmcJ8m3dwMoYw9bbMJP4LV/xFzMYsF6Lt5Qi/MdJuvsx3KEBrKb8q2vUDWP8LDNNXIEvPNHzPByg18grfQ3tqFL3losBaet2vzrYTxtKofSe2iLmp4om3upNFpFabmJzYOUs1xTAJ39MjVhIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544726; c=relaxed/simple;
	bh=PZ0uZ6Pbkb5vA3rqXnikGel5ry9DMVB2QZgM2eWoyGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GD9h6LhLq7oFQh7bICNF5bYgQuN2wzVT8cXisO4yOc6nB8NXFyBJJgA4kt2Gg+4ZjclUj+qh7ng2rfFvYLR2vr5quLEXIA/VHlxQunC0Yb9jKxurfcO741evNuaFnagJIfUkzWBMbpbdLnBOaOzdVemd8cDWEIYakjO48Auhf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqaqqWPK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so41615635e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544723; x=1761149523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUSBk3aaHZu/oBfcil8AH0aTuue0KDjY7q1ZRQkIQxY=;
        b=DqaqqWPKzHrglCZAdlKP8N80XNVtUwZ1Q7YJWajCMd8qedWv8ANycIaqJHRGE5Hy19
         uq+YG1MBnrrgx9Z3jm5Aa0IOzr+C0zCNllAyW73UrAdxnVLZpYEc9QWq5wjsCpK7mSA2
         hogCS76Ea7q9xC3kmXbsg34Dgq1OAeB2T6DAmSEBTIokDpC84GSuOC8V/MzIsJMeXKzC
         YB/WnuZIeqQ4Of0EBY4Ztb1lYFq/qlX9qNmIN2A/aX8AE9BXKx6eW99IbkLj0Ig6FjO8
         boBHw3kAcJOCNsVZbcOAOnkaL4jkTReBEIwINaXwgPfzXur17bHwVY3qubQPBSN6PEUF
         lDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544723; x=1761149523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUSBk3aaHZu/oBfcil8AH0aTuue0KDjY7q1ZRQkIQxY=;
        b=cGlhbdPzkJygOA6FgLCUI/tnCIEkpMIgt44TV79GHxfR/AyiB4OqszRGk4qsubpVFH
         Mx1Co9ykuponD59s268QhMZwwj/EVTcXytJHSWcULIHFpyyW2Mj3Rd8EjQ12Du/JstCz
         vQM4HVXa/SpK7dL6HGw8BtZFxrKl6Lm73i3HmjCEsBhA4+BIoySMXdaDIUK+XGSTDsJf
         gOaCNdDo/v0wYfi+LclU7Mhe1kz0A8ldFKzpJerv7rIu6cJLqkKuPGFf47rDNBr103mJ
         kHyysQeEQLBQHQ+QHqJiZw0aKR1r/yrcFBA/NpPbO4zKYq9bigA8XjGW9N5iwY6wddwy
         c0DA==
X-Gm-Message-State: AOJu0Yy2S5WlorcyXwm2ZsF4f3bJgG5aTJ+z4nz/J2ZbJTplRRlT2u5S
	5f4YfqO2QuRZiIe7Wiw6o2zaTxUwCfvHISW0ugeJFICvROACOAn3NzBGl3zdGw==
X-Gm-Gg: ASbGncuW//+622ZcdHgY7EliG1CsJoz10lEX20MJak+9Ooc/u9s8aDBCZThYGDbE9Md
	6RxCJZ0mWZ4YqTms3GC711KaG5NzNzGvsTNjNQAr1YosVkbrcGCP0/vQN1T90EEfx5c3Sv+72u9
	JcOjpK/gnXUWGDENI4CRen/dEJmw/6YagnEIFf0K/IT44m0I4N4OWJf2ijsQYcP6Vhf1SuTGeGw
	YDG2sp//I8KEsGfEP3PC2PBMB1ehV7gMbgfEHIYtCd2N6qtf4lRkjSXFYf5O1szIL7AttZUegrQ
	f80hxgKG9gc3UjFLv8daDP3O3kUEVedUgXB6j8Zad6LUrxRI35QAA3JNNZo9e2cfxnIEVSdAbEQ
	H+5MmYT9mdeaSRpzQbCeVPN7pyduED+heM4Am1F3bc0RJP7xhFba2j7Y=
X-Google-Smtp-Source: AGHT+IHS5WaA1BPERcCBIQEQu3sOy3XMIokHIB0JQDUbmdo3lHcmHyWv9GvXjqNgsemWpmI1IyVbBA==
X-Received: by 2002:a05:600d:d:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-47109da53bcmr3786085e9.15.1760544722794;
        Wed, 15 Oct 2025 09:12:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf71dsm28711201f8f.29.2025.10.15.09.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/11] bpf: verifier: centralize const dynptr check in unmark_stack_slots_dynptr()
Date: Wed, 15 Oct 2025 17:11:49 +0100
Message-ID: <20251015161155.120148-6-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
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
index c908015b2d34..528782835c84 100644
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
@@ -11505,15 +11514,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
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


