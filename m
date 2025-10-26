Return-Path: <bpf+bounces-72280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63AC0B344
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95512189C64D
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826312DF128;
	Sun, 26 Oct 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTEN/F+r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B4201004
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511156; cv=none; b=epjddYqLi6mSKumDKPp46vZno0+if0Bstm8MfDVfegzXrUmbknmOKRjbSOi2b0tlqTZJQIi5b8HAAdpxk35/VK0d8+rwaP+NE1TQMdxW4gV9TvnEaTNBoGHv/LKXRCndRWMKmyrtnsw/4g2Phu0y7sxKWuwHuIocLv1WBoBo29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511156; c=relaxed/simple;
	bh=bxFCWQ8MLDxm9C4m478ZnxhcazmCcgYdyu3G8COQ4JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTTvy7Mt7VPBnFcAXB3yjb/sYAZgRGRkCpTfsDsqiKQmZOYKIDW0yAdCIfShiRa/px3Z93u+plRX6VVE9iEUNJ8A8fc7ZEem/kvb77mNgRXWb/TC8+l75Sy30sAWBCerTjENw1QMLptAf/TQq0yVL1/xoO4qXXMscLKvx40a044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTEN/F+r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so22730025e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511152; x=1762115952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NeqMiBZFpKHMrD2sb/RU3OEv/cnPfru+0gN0rjteKA=;
        b=eTEN/F+rxK1boIKcE0+UEq6Zl9fS/QE8pxUMWk0u/Zm9TkQ8RIX++oX8QlOaf9y1Qk
         a1eH9nn62pgxQbbON/l09+9MDbBp0kkbQkI1i9vzq0q5+sjYPOwCOEnamzdFhP9vvvmE
         d3JWgPPHnjFQmhzCENLNQEQTCPefKum9ulLwVXq58YnNT57SN0ijqYZtEGZhPcbXUXkX
         ONbmao2Di/iq2Szxy0AjLnzFX1Q+S6IPSUCjNg27TV2XZHluKek7lf8eWsUQezDJvT4P
         gc2qXSF7v6QK3Dt8IAmX5eafNQBzvcOBby1saWF6wJ3JaClWD+tcQuKIAnGQ0cGF9p18
         Bg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511152; x=1762115952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NeqMiBZFpKHMrD2sb/RU3OEv/cnPfru+0gN0rjteKA=;
        b=MwLvriSYKabC1koQOlnjj10HxIEpVEI+uAMUSEDg3GogMJ8wJLBXuipciT8ABDe7Ff
         i0twnKL1iEq2jqxUh40Zt6QDAkgyDvvAsdK+LJl05ZAYMxwAf9SItLqTCIPBdfVlcD3m
         Mn52mnx/vKgohsdtOyY/47ux0XWVre7o3PkU+m2HYCrDxcAWa6YOUbxVW3nh6WSkZSNA
         V47bvLImVbBSnaNE5HBHaS2FXVKtR8fb/AaYrEDfSzBy9jB4fPrjoaj/AruKExEOnF2l
         Fm/hzfnqi+oCgzjJXmhC3QVERZ5PIQ7xJaFb5489Txet0qiOH7w+HAlnh0zOZm7sLDQo
         mRbA==
X-Gm-Message-State: AOJu0YxgJy3kRwLBjGGbUIVYqtyzmLTN58K2jAhVTw3iP+SJJzjy0FlZ
	oi+DOeBPkq17P5EhqpM54kdrRF657GMqC0tY296CatSpZ4BhpC2RcxLvpSzT9A==
X-Gm-Gg: ASbGncsds1XU+4AUcLfaNS6AiMtzwvIvE7MFoJQz0K1h1XYT1S4ovFNxUnb/lZeL489
	WmAYuBZ70RRnAKRz5t/OZltTu8DlqCSsm+w+knxp0Zi67l4/3m7VuY6tqAgJqQmXJssaB3VAKQ9
	EY8TI8KvObH9Lzb47G7Wg3dgCwBFeLr6tq9G7ybslHfVVkqrcHHAcsx12InENAtv83zwtdMKenw
	SxmOXz4iZqBJgxMNcM+Pw9/VJfk/eGb+TPLhBYrRegolq56zuYdMpcg+2Emw7Q3GnEvg7shKKK8
	SzHS19XdJQLtD+KMD5L9S1B4fcWj8IR9/XF+R8HmaqBNZSV2iOoS42tIww48w72ycbYxYNKT0CH
	ak9yqEElTNfgFkL7M90OtvB3sAoDW/X+T1Akb081ClR8+gfczhIjBFQHWDMclVXZcmc9qew==
X-Google-Smtp-Source: AGHT+IGsAhmKLeto6MX/Wh7WiW/yMCORdQc4fzxTE/wv8iaLypAjekbtPcgmKTAyDXGVs8sqKegHig==
X-Received: by 2002:a05:600c:310a:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-4770e0911d5mr28168825e9.8.1761511152301;
        Sun, 26 Oct 2025 13:39:12 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddccaaf5sm45943885e9.3.2025.10.26.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:11 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 05/10] bpf: verifier: centralize const dynptr check in unmark_stack_slots_dynptr()
Date: Sun, 26 Oct 2025 20:38:48 +0000
Message-ID: <20251026203853.135105-6-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
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
index 6d175849e57a..f60cfab95230 100644
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


