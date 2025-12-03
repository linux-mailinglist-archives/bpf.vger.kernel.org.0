Return-Path: <bpf+bounces-75996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CECA1F7B
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2038430124F0
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE12F39B7;
	Wed,  3 Dec 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg2WMdbG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304542D6E71
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805073; cv=none; b=J/P5dKa1pkHNpVV0HC1AT2GafZzeg+JcUY2Hd7wELHgoNEUztTPEliRqExU3XBnMR3JeArZPSSLYpnZBbGPugJ/HSaGor8MqAyxg7EtAjkEMMWO33NbSaaj8M/iLsZPJZul+qXOTSZWCMwujhyVs2y+HKLY/0et2846SWS6qs18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805073; c=relaxed/simple;
	bh=s3Tn9SkRs09gJByiuwQCrfleWqMJzWzc1aZJMz+zu24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0J23NGBy/r1DWWufIvupSOPt1irD0DDxGBnsTH2xQBnrrcL71gYK9rIyPwEq7OP/bYDLTeFQ7tSzu+Eq4D7u3RzDv9zxdFLv6qNg71PpW/xGSj37sQ1hlee+lgyykbkR32/3SknFciv+LwWft0Su8XIawqjdZWeLtmjj1JsNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg2WMdbG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7baf61be569so331848b3a.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 15:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764805071; x=1765409871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekV5LbMRCL3PW/okAcUN12KpTwKDf2CumBGoDPrJ+Fk=;
        b=Qg2WMdbG9hZ8THhSymc+ZgJjohOIkLOR//yKbO7QXEI+uAowqKllvoa22i8ff42muD
         SCg9nMEGAs1vtU/PWmojtVhJ4TNxwOtpEofHF8VzAfJlubI5P3tk1Ia97gTEGZ9DvP5x
         6aSMV6OjEWQqKjzfSCANW8hhMrByPqgQWkSO+ZBmVBekXUoHyc6LnQgk+go5KuWA9TiO
         gUqzbXhA74sxes4DkBqu/lSenOwUOy/cD6Z50QdSa+b/oeGS8LN+tCzecq8fLnItOQWy
         3XEriBFPsszWS8eabo0Yu/I8+XCp2F8kDUSFa3mX0C7/x/LUOmLw3CMPzjQ9yfOgzxb3
         sWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805071; x=1765409871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekV5LbMRCL3PW/okAcUN12KpTwKDf2CumBGoDPrJ+Fk=;
        b=cHhbNB6ebDInCuAyaBODciuvyfC9t2z3gEybQxeDsstz/TWK7wHFu+tdJzhnC3IXHj
         d+AtkXRynMTPap8xZew3mFgMLnXVa6pCZapJWauV0WHsGd/bsrn9hFwE3SZR/uT62eM7
         /h8Jp6Vih3yAsnb0GYqj29btWhBVQnboT2n8bAegEENJgKD9ZcumKqZB9hF6rMV48L5y
         8o/BT8eu7FDVVsRSp6AwXgThOIg/vPNmlNF6+PWc0n4dIBM+OlQ4W77CigkZ+xP2rv1q
         m3TGvbEYq8FnlAkGkZDxv5XpHZfom9MVWb9S0XevKsIOPBwymId8/niHXQQTyfCUN6D4
         RO5A==
X-Gm-Message-State: AOJu0Yyu0rNxnw4qr1tEWiNI4zD6T2/uAqDsyFrJBX2iSE9ro5TgdsU5
	ntDHuxIhNetFdy2SxtB3ficXjIxqdlF3p+HNeDYRpE/dM69qDkx6bgpFxR7Jbw==
X-Gm-Gg: ASbGncvc0Q+szJQG7pL+QvBFKMZ6Pv0kr8074C5NCENrsfEM3iRgCrNTNCqzyWNCNo6
	UxPMekk/ObccID7byz6uW+nxlGiAsVQmoopm0pnnBl3X2lVngSufBKEiNJl2GJmDjWWRxW+pq9n
	zYaf0XKrWv7yC7r2g7uu8XfPoLIQ3kSLe0PKs+TLmvWxdnKEbMEWaH93+4GO8ckfI5uw8DTDijj
	dw2HHBVdEHOlKPA51JAXsckvhhYAnFCT/R2u32TVhDXEhOuv3qp6EpT6Gfbwkb8rTrPzvkCkDiM
	r/l2Uf2EgMkUxA8K7tanfU5+FZSFYcZygHypyJF6WgCo8pUA2bt4XQYvrKVfxeDJvzpmeUDwJnM
	Cysv1S1XNxDVA58NnIH0ZEE00WlBG27uoW43VC0qrR8fE8XZdv8N3YcZ6ZgKZdqV7CmaQTuFRrG
	lDE8HX4EJ3AbOJTxLxKsOuSg9F
X-Google-Smtp-Source: AGHT+IFp0KYLuIdo0/5qfJhzrnefF2YCLr/97kGu6iI3gn1HHUkpf6Yx21geAPS9IeFywgDxK4Oupw==
X-Received: by 2002:a05:6a00:3a1e:b0:7b2:1fb0:6da3 with SMTP id d2e1a72fcca58-7e00e79273bmr4388874b3a.24.1764805071263;
        Wed, 03 Dec 2025 15:37:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ecf89sm114134b3a.12.2025.12.03.15.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:37:50 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 1/6] bpf: Allow verifier to fixup kernel module kfuncs
Date: Wed,  3 Dec 2025 15:37:43 -0800
Message-ID: <20251203233748.668365-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203233748.668365-1-ameryhung@gmail.com>
References: <20251203233748.668365-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow verifier to fixup kfuncs in kernel module to support kfuncs with
__prog arguments. Currently, special kfuncs and kfuncs with __prog
arguments are kernel kfuncs. Allowing kernel module kfuncs should not
affect existing kfunc fixup as kernel module kfuncs have BTF IDs greater
than kernel kfuncs' BTF IDs.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..bb7eca1025c3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22493,8 +22493,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-	if (insn->off)
-		return 0;
+
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.47.3


