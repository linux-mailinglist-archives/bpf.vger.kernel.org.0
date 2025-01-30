Return-Path: <bpf+bounces-50118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB6A22C76
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82211661FF
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E71C302C;
	Thu, 30 Jan 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="dzqaP9+h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D8F1B6D0F
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236247; cv=none; b=jU3yT2UKm86cpIIApOFoJlqE4fcqiPEWKk602zdkgxGLbbH4Wkn72rG+VLKbUesxBG2jpj/IilX2iYQNjoPXB2KX38ppMEq++IjUAKWfwavI3zpIdDVsXO+CfLijLvSWoQt46Feuq7FQWuUsnS0OL+Z8yTUQ7uDCMbKsmexDFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236247; c=relaxed/simple;
	bh=ir14bMQFsNYp32aOA6f0D6ULmpCPLRrhToUomfBUGXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aamrZj4kzVwiZm0n/++G2Gk1j0Qlm3h+Cmx1wGhNPzQB7A4UobH3h8HMLR0UAq5LvLgvKvhTS4m5EyXrTa7XHqdf+m+g5n+ZcrlLLQ162j+MQZ+6LvEibliqk5qIqMwke+f6Jm2Ga5SwuoTr6J4kM4DBBk/nijggylsfGEqTS+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=dzqaP9+h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43626213fffso11621835e9.1
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 03:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1738236244; x=1738841044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io1jYVOEhBj2nb/i6PNa0znOjf7UI5FGujFQE4rV18s=;
        b=dzqaP9+hdA1lbdJKLVNEo3uGSU7+WFsaCxl/I5OFBRglnzXk23VPefs+EaO/LJYnrF
         poBJfzBOwoEXSOcJ1Ikh6TAJt2ATuMPQl4GwNxooPP15VO1BqtPwSatJicLNs0rjdBI+
         WdtmIkLAThdqme4C0YFxyzOYJWQ2lxgKaD2Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738236244; x=1738841044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io1jYVOEhBj2nb/i6PNa0znOjf7UI5FGujFQE4rV18s=;
        b=UbsaBxa5NjIKW5ddBKLdVZoHqwGlgmCsn29q3qH3X6GlSrA9dUFauwyZcbhB9qkQzl
         evdeFz9R07PoZoUyWO+8b7pl4Br4lR6aHIgpg1WEOk6p1yLvNED5iib4cjjP05gua70y
         u4NS374TTW3TlxH3F7fM+1BnJ4Sr0KnvGjROkNwQl2MQOiZfWm0Y8cRRKJ1LVhRBJ/QJ
         ID0nIhyx2IYdAuaxGyc831k0bu5elhUbUeTmJzehqp6PVYdvWPMONc9vqJx/id9enaWC
         YxCEfrlJsAoAIuD7NRxvBVUabpCGnknlOmW17nGbiRauRl6NyJs0eta62JuSSZCndCMc
         AarQ==
X-Gm-Message-State: AOJu0YxM4mOqHN9eymiNTtuiChbinKaG0v3r++q0gXQc28OSpZgmcZ4I
	T8i2aVdTDh0hWu6AdKwUIx0swbbhbSTEuWFnSi9cTEGsl2hqRQLyBlGnhHnH+Yi7VfuKwXNWJ6L
	Noh0=
X-Gm-Gg: ASbGnctbw33sYmR7tzA6CBcSxAVatdQHgnUyLRrwklBoh7jPIAE1lx9IT1zCG4VqEhI
	yMDZ033uU4VPR2MADgEwK8rRlmC7IKDJpePM6Zvs0a+kDFXrzmqMfTT5Ejx85F3l6xq72w4C+hL
	xmnEQbx+KUc1MPwL0eAingTd/qD9gPWL6nnbuBfOqOEcn0RIAl3qT8SImV+gB7KSAtdBeIYHa5u
	sy+4TLAFeIDpK1giVz0JyflQIvs0Tey3HVz2eW4Rx47O4JyYuETF/DVTcZTNYdAKrEMQroprXkj
	KlJ3c3Othspgt/2l3EmNKai8ZxuJkh96kX3OD54VV5oNKlSLX9XfIPA=
X-Google-Smtp-Source: AGHT+IHA0i+sMu6BzcszTqP8lGj75Bic4aD8JZOvjRjSwo+iF6c/Uloni+KAfZ6f8naAmSB7ScGclg==
X-Received: by 2002:a5d:6d0d:0:b0:38a:6183:77b9 with SMTP id ffacd0b85a97d-38c5a95722cmr2586107f8f.6.1738236244292;
        Thu, 30 Jan 2025 03:24:04 -0800 (PST)
Received: from localhost.localdomain ([85.196.187.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b51e1sm1678981f8f.77.2025.01.30.03.24.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jan 2025 03:24:03 -0800 (PST)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v0 2/3] bpf: verifier: Simplify register sign extension with tnum_scast
Date: Thu, 30 Jan 2025 13:23:41 +0200
Message-Id: <20250130112342.69843-3-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
References: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch refactors the verifier's sign-extension logic for narrow
register values to use the new tnum_scast helper.

The general idea is to replace manual range checks in
coerce_reg_to_size_sx and coerce_subreg_to_size_sx by deriving smin/smax
and umin/umax boundaries directly from the tnum via tnum_scast.

In the original code,some coercion cases with unknown sign bits triggered
a fallback to worst-case [S64_MIN, S64_MAX] ranges. With these changes, we
can now track bitwise uncertainty more precisely, allowing for arbitratry
bounds like `[-129, 126]` when upper bits are partially known.

An example for such cases would be:
For an 8-bit register with var_off = (value=0x7F, mask=0x80) i.e known
lower 7 bits, unknown sign bit, the original code would  default to
[S64_MIN, S64_MAX] for the smin, smax ranges, while the tnum_scast
implementation will bind smin = -1, smax = 127, while still tracking
uncertainty in the upper 56 bits.

Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 kernel/bpf/verifier.c | 124 +++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 85 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..a98dba42abc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6661,61 +6661,35 @@ static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
 
 static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
-	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
-	u64 top_smax_value, top_smin_value;
-	u64 num_bits = size * 8;
+	u64 s = size * 8 - 1;
+	u64 sign_mask = 1ULL << s;
+	s64 smin_value, smax_value;
+	u64 umax_value;
 
-	if (tnum_is_const(reg->var_off)) {
-		u64_cval = reg->var_off.value;
-		if (size == 1)
-			reg->var_off = tnum_const((s8)u64_cval);
-		else if (size == 2)
-			reg->var_off = tnum_const((s16)u64_cval);
-		else
-			/* size == 4 */
-			reg->var_off = tnum_const((s32)u64_cval);
-
-		u64_cval = reg->var_off.value;
-		reg->smax_value = reg->smin_value = u64_cval;
-		reg->umax_value = reg->umin_value = u64_cval;
-		reg->s32_max_value = reg->s32_min_value = u64_cval;
-		reg->u32_max_value = reg->u32_min_value = u64_cval;
+	if (size >= 8)
 		return;
-	}
 
-	top_smax_value = ((u64)reg->smax_value >> num_bits) << num_bits;
-	top_smin_value = ((u64)reg->smin_value >> num_bits) << num_bits;
+	reg->var_off = tnum_scast(reg->var_off, size);
 
-	if (top_smax_value != top_smin_value)
-		goto out;
-
-	/* find the s64_min and s64_min after sign extension */
-	if (size == 1) {
-		init_s64_max = (s8)reg->smax_value;
-		init_s64_min = (s8)reg->smin_value;
-	} else if (size == 2) {
-		init_s64_max = (s16)reg->smax_value;
-		init_s64_min = (s16)reg->smin_value;
+	if (reg->var_off.mask & sign_mask) {
+		smin_value = -(1LL << s);
+		smax_value = (1LL << s) - 1;
 	} else {
-		init_s64_max = (s32)reg->smax_value;
-		init_s64_min = (s32)reg->smin_value;
+		smin_value = (s64)(reg->var_off.value);
+		smax_value = (s64)(reg->var_off.value | reg->var_off.mask);
 	}
 
-	s64_max = max(init_s64_max, init_s64_min);
-	s64_min = min(init_s64_max, init_s64_min);
+	reg->smin_value = smin_value;
+	reg->smax_value = smax_value;
 
-	/* both of s64_max/s64_min positive or negative */
-	if ((s64_max >= 0) == (s64_min >= 0)) {
-		reg->s32_min_value = reg->smin_value = s64_min;
-		reg->s32_max_value = reg->smax_value = s64_max;
-		reg->u32_min_value = reg->umin_value = s64_min;
-		reg->u32_max_value = reg->umax_value = s64_max;
-		reg->var_off = tnum_range(s64_min, s64_max);
-		return;
-	}
+	reg->umin_value = reg->var_off.value;
+	umax_value = reg->var_off.value | reg->var_off.mask;
+	reg->umax_value = umax_value;
 
-out:
-	set_sext64_default_val(reg, size);
+	reg->s32_min_value = (s32)smin_value;
+	reg->s32_max_value = (s32)smax_value;
+	reg->u32_min_value = (u32)reg->umin_value;
+	reg->u32_max_value = (u32)umax_value;
 }
 
 static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
@@ -6735,52 +6709,32 @@ static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
 
 static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
-	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
-	u32 top_smax_value, top_smin_value;
-	u32 num_bits = size * 8;
+	u32 s = size * 8 - 1;
+	u32 sign_mask = 1U << s;
+	s32 smin_value, smax_value;
+	u32 umax_value;
 
-	if (tnum_is_const(reg->var_off)) {
-		u32_val = reg->var_off.value;
-		if (size == 1)
-			reg->var_off = tnum_const((s8)u32_val);
-		else
-			reg->var_off = tnum_const((s16)u32_val);
-
-		u32_val = reg->var_off.value;
-		reg->s32_min_value = reg->s32_max_value = u32_val;
-		reg->u32_min_value = reg->u32_max_value = u32_val;
+	if (size >= 4)
 		return;
-	}
-
-	top_smax_value = ((u32)reg->s32_max_value >> num_bits) << num_bits;
-	top_smin_value = ((u32)reg->s32_min_value >> num_bits) << num_bits;
 
-	if (top_smax_value != top_smin_value)
-		goto out;
+	reg->var_off = tnum_scast(reg->var_off, size);
 
-	/* find the s32_min and s32_min after sign extension */
-	if (size == 1) {
-		init_s32_max = (s8)reg->s32_max_value;
-		init_s32_min = (s8)reg->s32_min_value;
+	if (reg->var_off.mask & sign_mask) {
+		smin_value = -(1 << s);
+		smax_value = (1 << s) - 1;
 	} else {
-		/* size == 2 */
-		init_s32_max = (s16)reg->s32_max_value;
-		init_s32_min = (s16)reg->s32_min_value;
-	}
-	s32_max = max(init_s32_max, init_s32_min);
-	s32_min = min(init_s32_max, init_s32_min);
-
-	if ((s32_min >= 0) == (s32_max >= 0)) {
-		reg->s32_min_value = s32_min;
-		reg->s32_max_value = s32_max;
-		reg->u32_min_value = (u32)s32_min;
-		reg->u32_max_value = (u32)s32_max;
-		reg->var_off = tnum_subreg(tnum_range(s32_min, s32_max));
-		return;
+		smin_value = (s32)(reg->var_off.value);
+		smax_value = (s32)(reg->var_off.value | reg->var_off.mask);
 	}
 
-out:
-	set_sext32_default_val(reg, size);
+	reg->s32_min_value = smin_value;
+	reg->s32_max_value = smax_value;
+
+	reg->u32_min_value = reg->var_off.value;
+	umax_value = reg->var_off.value | reg->var_off.mask;
+	reg->u32_max_value = umax_value;
+
+	reg->var_off = tnum_subreg(reg->var_off);
 }
 
 static bool bpf_map_is_rdonly(const struct bpf_map *map)
-- 
2.43.0


