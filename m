Return-Path: <bpf+bounces-45316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED169D4526
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A94282FF4
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552717741;
	Thu, 21 Nov 2024 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvgULgss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECABA3D
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150420; cv=none; b=qPPgPolES91ItV/OyfEYjX78ALgoDvdOuD2GRogoKOlVJDf6axN1NxUnw2C3Lcd3d38FO8ALItrRIw6xy06a9ybjujTchTBSZXMVQnuJ9FhYKo2cYO/aRDjkFQdgdKia3vmh1CdlBIBGdVmeOv1C4LV2JBiAHYzPZ/kkbgyV83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150420; c=relaxed/simple;
	bh=au67/hzqFENstmM5aJNjBVKZHUdGnPgaPmyxDVoTQ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKyvXfD0mmdTZybZ5Lq1jFF3++zYPs0wTeBvBMrimbH3V5DCM+2OUmJ3CzDz9sKFPXmdG7Tp0bkdoECpLt4qDC3B2pHTrP8VyrgJZ9Jyjpom04vLM09CCTjCgdVvxD9kVTm32p2+6wRp8YYrgSvj4Q71or3z1AmwWM45iR1YC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvgULgss; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-382378f359dso191333f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150416; x=1732755216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGsoG7M1oYGL+lMn+vL7PI02L0w38AIEIFUvT7cyaFA=;
        b=MvgULgssj/7R63UgetUUm0V0TLWCX4AqB48W/jw2oyjE+4NKx95mEKRJsMqlDeRrYa
         ypWcVp79VN4e9FrKkTVyaGv/285pPWAmyweVSgVH3Yzc9VwLMfQRouOj77+rZBWVHu71
         hGox7YLPCG5r5bR19GnE2WBpH+Q+3GgQUuAhO8aVR+mdxv09IftzQstrwJLiuR883uSJ
         H8VRU3jYk2CmA2XWSMIsDAGF0GgS8UarAsuwONoaLL6Vd2MRmcF/IvXyIfVs/3Gw0H5l
         myiDcbtOZVWk9VNnorQs03CNg7C9QX3JIKczYZPT+/O+7R4Y3qxi3DvZ8REkO/dtJbw4
         s7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150416; x=1732755216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGsoG7M1oYGL+lMn+vL7PI02L0w38AIEIFUvT7cyaFA=;
        b=tr75E7R+M3Lt15rpJe3iLZqLqX2/MANl0M3+XB/bDK4fl9QNY+R2TZlBGkvXhWlAJN
         /ipL3+99uU1/k7OyW/97RLjqkoFzBbwXXTDEwKR50rqZMhlixs59/dQrGccy1m2uwb7C
         4y4L0ADaNzhWJJ0Q9kINaYtIGeNOi6C1GE5+fsnAj4RYP7L0/XGrmdTSIXJIV0qOnRfs
         k+qWnZEyFc2L+aHs/HMVvUctWeu2cL7mUJll3TJybvoCld14w4/+bZeYuCc3zRZtxixj
         epqjP6PejpagRKu2lL/zNiDFOmWXXPKGL17zSgY+EWhXiHecdMVNLesZ7pOIyMDlZeKX
         XhDA==
X-Gm-Message-State: AOJu0YxPSVQeN7hcXkTYTH3BlCzcXjv4tLiFqW7Tsf3jNCNCj1eUs7pN
	6b8DJq0zViGnjbRlZWiXM+JzKwg6jQaAjgnRUwpSfMwkRaekEwhtGcoaBGgthqA=
X-Google-Smtp-Source: AGHT+IHM9IG+sSNKbL5vhtDVdJ2QLHq/KZyOpQ4bFYf0oVI4TXTqJtqGQ+cZugFEAvt7Vq66y2ZlIw==
X-Received: by 2002:a05:6000:1885:b0:382:4eef:28a with SMTP id ffacd0b85a97d-38254b0e1c5mr3390153f8f.43.1732150416350;
        Wed, 20 Nov 2024 16:53:36 -0800 (PST)
Received: from localhost (fwdproxy-cln-112.fbsv.net. [2a03:2880:31ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254905396sm3404490f8f.15.2024.11.20.16.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:53:35 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 4/7] bpf: Refactor mark_{dynptr,iter}_read
Date: Wed, 20 Nov 2024 16:53:26 -0800
Message-ID: <20241121005329.408873-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121005329.408873-1-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2742; h=from:subject; bh=au67/hzqFENstmM5aJNjBVKZHUdGnPgaPmyxDVoTQ5c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnPoQ2zp/F9TUDgzPZWmGhI1JcwdV4ANo81gmjcvls WDJLPMWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZz6ENgAKCRBM4MiGSL8RyiBTD/ 9wHI5f6kpfhHcJBqsK+GOYVQFwzEcNem2IYmD+3E7WQPFFBEaRbuzQQhYUCnYhYuGT0ULUSFuXPJNw qUCV4IdC1xXJwLl1jBHYIiW/D6ZiSAFb7jXBHyaoBm5g2XM2jPm/wRxkcdkzSznrqBa0E1ayFYctk8 Nw7aRTeoQWKdZSck0wN7WDyBAE8rHI+66ZYxnXzU7HICI/x4Bk97YU1BuJ9Lbf7Ywbydb/I+EFXUog EmGHERkVUtXxp99C/j12w1MIhAnE03iJS1nDMkRAxBK7ENbRE+WLyF/kzJqgSLg09j+uhj83Gw3A7E Yhe3YKjMwf6XZkuOTvmCGQd0kqOJiQpDRaBZJRNONns+wiCkomJwDtmMOWq1ZKKv/CH6SIpvnOcgCE +6hFD4kQlHu6nNxsU8Bw7kXm8aMIhrsrV1/3VxicFMDo/8tG5bEFfZHA7oI89GuXtxxhko5E39P1F6 YJ6GNo6EzCftysj8RaWgi/vvnOIUq3qcQGPisBM4LmekXeR7WRwcwkYMD0l3LunRkXDEExRviHrlgd MqNiLlDOyFvvNmhAAElYe4mSOyBC1HBwZLWNdUkx+vDyozBDDUyC+GLKQzESQhL2kYqAw3FUb1dnJw bj0wuMd78P0TkUfkoQXfytTON6sfwdNjs5lzP82v4c0ikELcdpOIFXAHazLw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There is possibility of sharing code between mark_dynptr_read and
mark_iter_read for updating liveness information of their stack slots.
Consolidate common logic into mark_stack_slot_obj_read function in
preparation for the next patch which needs the same logic for its own
stack slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25c44b68f16a..6cd2bbed4583 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3213,10 +3213,27 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				    int spi, int nr_slots)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ret;
+	int err, i;
+
+	for (i = 0; i < nr_slots; i++) {
+		struct bpf_reg_state *st = &state->stack[spi - i].spilled_ptr;
+
+		err = mark_reg_read(env, st, st->parent, REG_LIVE_READ64);
+		if (err)
+			return err;
+
+		mark_stack_slot_scratched(env, spi - i);
+	}
+	return 0;
+}
+
+static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	int spi;
 
 	/* For CONST_PTR_TO_DYNPTR, it must have already been done by
 	 * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
@@ -3231,31 +3248,13 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
 	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
 	 * read.
 	 */
-	ret = mark_reg_read(env, &state->stack[spi].spilled_ptr,
-			    state->stack[spi].spilled_ptr.parent, REG_LIVE_READ64);
-	if (ret)
-		return ret;
-	return mark_reg_read(env, &state->stack[spi - 1].spilled_ptr,
-			     state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
+	return mark_stack_slot_obj_read(env, reg, spi, BPF_DYNPTR_NR_SLOTS);
 }
 
 static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			  int spi, int nr_slots)
 {
-	struct bpf_func_state *state = func(env, reg);
-	int err, i;
-
-	for (i = 0; i < nr_slots; i++) {
-		struct bpf_reg_state *st = &state->stack[spi - i].spilled_ptr;
-
-		err = mark_reg_read(env, st, st->parent, REG_LIVE_READ64);
-		if (err)
-			return err;
-
-		mark_stack_slot_scratched(env, spi - i);
-	}
-
-	return 0;
+	return mark_stack_slot_obj_read(env, reg, spi, nr_slots);
 }
 
 /* This function is supposed to be used by the following 32-bit optimization
-- 
2.43.5


