Return-Path: <bpf+bounces-75455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFEAC850DA
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D424B3506A6
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482D322DCB;
	Tue, 25 Nov 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="1SohpI79"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F73242CE
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075442; cv=none; b=r8kLZw1TCc1XSYAEy2Jbl4qqA1La2H8ngbXn8qmPcrpWSn3Ven1BmGleaH0FPr8R2jaucu4gXm21T83smoWFg4fHh41UFYaV5nokPcSdaQa05ulzBT0YKunQmnKwb3AJXpZq/lFsRssnLcsqGNoLofvSg/7R0BoBqQlR+Tlx0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075442; c=relaxed/simple;
	bh=7ZzIrxOJRqKzVge6YmQSLIt2yMrPQ0MTt9YgIxQnCkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cWukURztJuYJKhF9mFKJbIovX78LC9AgPpb8NcXBy8cttufn+nZ10HK+eWpTmBV61neZZN+QNRmu8hbM+bpGtp+Ea6zkJYZnGIb5AxiDeS3+0ppR+E4NkwBj9MLM11kcvBNF00OqRrRXj7YcesP+RQw7Q4F200LFvTrS45MmAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=1SohpI79; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47774d3536dso42650605e9.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 04:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1764075439; x=1764680239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/b8dcB1rfDp626vBsOSSdpwsZBv0krUFZydPEJFKq70=;
        b=1SohpI79ibtudTNTQq0axG19nnhv3uVe52wYRnGxv2jtNa5oWAIYN72xLSUA8dcmQh
         3bBg56qDdP0XtTVahln60IP8MVCqpYJMs3TWaA4hTn9J5RmPLzZtA/azrRz+zQV26dHa
         dX0XKanJ2/WzM/w1ivTWlJfQXnBHPH9qIJBgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075439; x=1764680239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/b8dcB1rfDp626vBsOSSdpwsZBv0krUFZydPEJFKq70=;
        b=FPWSZJPlGXf+MlyjjjYRM3RknMS0GPt1efV256leavtGjqZmATE1sTOpvQJhhFGJRK
         Ul4cVOpyWDUvMkORkfDjlaf4W5BJZQjOShFBqsMj5OB3tXjAwmrDoYctS1fbuaD39pup
         L/YEnXoi2iRxr0xcq8IUn0dhmNp6fMh9Oi7utJy02sDh93B9qowMrWuzr+0XJEe5zPUV
         6vEMfI6cf4R2JWGiRi+1Te+8NjNbeERY+awXah/oUS5pRuyCZhDGYW8FeTk9qdhkWy0x
         oQUh1CxRcmTwNZHTT9eqiEJT3qLccwg5ddDcNvU8ANuQ8yShGbC82KUS8opkkITWrNda
         pj2Q==
X-Gm-Message-State: AOJu0YzPtbPqxsH57okx+q9UofWzWJlWcWdG9OmJ5743jz+M/zCpZvNU
	aDs3WWcuCURrDWosMwh2OJdjHbzCQJMDL10+478eFsLAngcp1wf3zmGHTOJcJSAhrnFEYfWt/c5
	BG7Axtw9+ew==
X-Gm-Gg: ASbGnct9oDb+FvGTTMjVk0g7C2ajN39l895lHPweVnDymzYCTNv04hZWHGBSGZxb+NC
	Vd+ciNzgCmb42NyavlO2p+WdaKYM5MonMFwHVYq6gjf+S2AwstnNFSXbo0iocaGSyIAyQmUEJa4
	ije3zegOQ9V063iL6itc0pxmajCxhGbBFl75vff31THZ2JeH5ZEELC4a8xtycvZCX1c5k6jSjHy
	I6Occr/y77ewFkoLJ8r/j14dLF4iJFI4OeKchLZYpxzpirOKMElqgNdhHdAr319/PkL0j6UbYSv
	Aa12t1zUJp3EJQARhaIi/HyhrXa0vIjVMTbukRb+CcGkDsuciOfLcMq+c2bJAjy5DoocD5hIbwB
	P8N0ATlvc7qJ2QVLYa6+xaHUmvkJmVCaocuaejDK/HsQZdHeoTzN6LFBmQrgD6U6uYtMNXnnJuX
	skDR6FiWt8sjR2rAhkVyY/KEYxaLPiVFN7gvdGF4lHtNyD9UlsmF7zevhZ0fEixR5/JcWhxzUC
X-Google-Smtp-Source: AGHT+IG/f3PPLOs8o4Z5f4wvLOAwnDx8nKdhz8R0LtRwkz3WsV8jgNZRZdZB6qQ+FvRhC9uHofZtCw==
X-Received: by 2002:a05:600c:4685:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-477c052f04bmr163447985e9.13.1764075438644;
        Tue, 25 Nov 2025 04:57:18 -0800 (PST)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1f3e63sm256668925e9.7.2025.11.25.04.57.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Nov 2025 04:57:18 -0800 (PST)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v1 2/3] bpf: verifier: Simplify register sign extension with tnum_scast
Date: Tue, 25 Nov 2025 14:56:33 +0200
Message-Id: <20251125125634.2671-3-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
References: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch refactors the verifier's sign-extension logic for narrow
register values to use the new tnum_scast helper.

Previously, coerce_reg_to_size_sx and coerce_subreg_to_size_sx employed
manual logic to determine bounds, sometimes falling back to loose ranges
when sign bits were uncertain.

We simplify said logic by delegating the bounds calculation to tnum_scast
+ the existing bounds synchronization logic:

1. The register's tnum is updated via tnum_scast()
2. The signed bounds (smin/smax) are reset to the maximum theoretical
   range for the target size.
3. The unsigned bounds are reset to the full register width.
4. __update_reg_bounds() is called.

By invoking __update_reg_bounds(), the verifier automatically calculates
the intersection between the theoretical signed range and the bitwise info
in reg->var_off. This ensures bounds are as tight as possible without
requiring custom logic in the coercion functions.

This commit also removes set_sext64_default_val() and
set_sext32_default_val() as they are no longer used.

Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 kernel/bpf/verifier.c | 150 +++++++++---------------------------------
 1 file changed, 30 insertions(+), 120 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 766695491bc5..c9a6bf85b4ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6876,147 +6876,57 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 	reg_bounds_sync(reg);
 }
 
-static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
-{
-	if (size == 1) {
-		reg->smin_value = reg->s32_min_value = S8_MIN;
-		reg->smax_value = reg->s32_max_value = S8_MAX;
-	} else if (size == 2) {
-		reg->smin_value = reg->s32_min_value = S16_MIN;
-		reg->smax_value = reg->s32_max_value = S16_MAX;
-	} else {
-		/* size == 4 */
-		reg->smin_value = reg->s32_min_value = S32_MIN;
-		reg->smax_value = reg->s32_max_value = S32_MAX;
-	}
-	reg->umin_value = reg->u32_min_value = 0;
-	reg->umax_value = U64_MAX;
-	reg->u32_max_value = U32_MAX;
-	reg->var_off = tnum_unknown;
-}
-
 static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
-	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
-	u64 top_smax_value, top_smin_value;
-	u64 num_bits = size * 8;
+	s64 smin_value, smax_value;
 
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
+	smin_value = -(1LL << (size * 8 - 1));
+	smax_value = (1LL << (size * 8 - 1)) - 1;
 
-	/* find the s64_min and s64_min after sign extension */
-	if (size == 1) {
-		init_s64_max = (s8)reg->smax_value;
-		init_s64_min = (s8)reg->smin_value;
-	} else if (size == 2) {
-		init_s64_max = (s16)reg->smax_value;
-		init_s64_min = (s16)reg->smin_value;
-	} else {
-		init_s64_max = (s32)reg->smax_value;
-		init_s64_min = (s32)reg->smin_value;
-	}
-
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
+	reg->s32_min_value = (s32)smin_value;
+	reg->s32_max_value = (s32)smax_value;
 
-out:
-	set_sext64_default_val(reg, size);
-}
-
-static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
-{
-	if (size == 1) {
-		reg->s32_min_value = S8_MIN;
-		reg->s32_max_value = S8_MAX;
-	} else {
-		/* size == 2 */
-		reg->s32_min_value = S16_MIN;
-		reg->s32_max_value = S16_MAX;
-	}
+	reg->umin_value = 0;
+	reg->umax_value = U64_MAX;
 	reg->u32_min_value = 0;
 	reg->u32_max_value = U32_MAX;
-	reg->var_off = tnum_subreg(tnum_unknown);
+
+	__update_reg_bounds(reg);
 }
 
 static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
-	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
-	u32 top_smax_value, top_smin_value;
-	u32 num_bits = size * 8;
-
-	if (tnum_is_const(reg->var_off)) {
-		u32_val = reg->var_off.value;
-		if (size == 1)
-			reg->var_off = tnum_const((s8)u32_val);
-		else
-			reg->var_off = tnum_const((s16)u32_val);
+	s32 smin_value, smax_value;
 
-		u32_val = reg->var_off.value;
-		reg->s32_min_value = reg->s32_max_value = u32_val;
-		reg->u32_min_value = reg->u32_max_value = u32_val;
+	if (size >= 4)
 		return;
-	}
 
-	top_smax_value = ((u32)reg->s32_max_value >> num_bits) << num_bits;
-	top_smin_value = ((u32)reg->s32_min_value >> num_bits) << num_bits;
+	reg->var_off = tnum_subreg(tnum_scast(reg->var_off, size));
 
-	if (top_smax_value != top_smin_value)
-		goto out;
+	smin_value = -(1 << (size * 8 - 1));
+	smax_value = (1 << (size * 8 - 1)) - 1;
 
-	/* find the s32_min and s32_min after sign extension */
-	if (size == 1) {
-		init_s32_max = (s8)reg->s32_max_value;
-		init_s32_min = (s8)reg->s32_min_value;
-	} else {
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
-	}
+	reg->s32_min_value = smin_value;
+	reg->s32_max_value = smax_value;
 
-out:
-	set_sext32_default_val(reg, size);
+	reg->u32_min_value = 0;
+	reg->u32_max_value = U32_MAX;
+
+	__update_reg32_bounds(reg);
+
+	reg->umin_value = reg->u32_min_value;
+	reg->umax_value = reg->u32_max_value;
+
+	reg->smin_value = reg->umin_value;
+	reg->smax_value = reg->umax_value;
 }
 
 static bool bpf_map_is_rdonly(const struct bpf_map *map)
-- 
2.43.0


