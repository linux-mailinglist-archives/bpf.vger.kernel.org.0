Return-Path: <bpf+bounces-67284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE9B41E7D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86FE7BA1FB
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EC22FCC17;
	Wed,  3 Sep 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aau/etg3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDB2BD597
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901168; cv=none; b=jG9N+9JnIj6cPlGS7jW30FcbK3uSqY0Ntxxqo9XzCKrGjxpezXitCxjJbT8gd4eXZuaRs6Tiiy5+GeHtUG6mRlpPfT+O5bveOCUQOIDN0Fp0SrOodsikEPJafbohOBpJaLjj6mXFOMrVS9e+Hm2KYnEHIZiWK173g2fbm2IAwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901168; c=relaxed/simple;
	bh=0OMtucW60YAzR5hU4oEuQTn0vNb0HaJ3df68UwygFuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvw/wLP9BMCKnB6+CaVKj3SsHdUYAX5kcSYWU+R8PkC6pbQ6NCAsFgqGdu6OPOxnAvQsrfm+Nah7uJkQ5XcerX1rro4HVSt8UFV7JN7KSj25l0Eh8k/CELDjHo+2jtj5W+pmpIoWM0LOf4SDarQGBiZK/O8+rVIBRM2qmxmiSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aau/etg3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so880996b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901167; x=1757505967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeOtodTRI+OBS50kot4CSeaPmna3ks2JaD3tu8/xt+o=;
        b=aau/etg388rXFWOM/hzXhucnfRZhXFbjTOTOv8THMohJqu9+5FrE1dOfh6/dP0WC61
         q0o6XjuwYBRXwPhvH1i+2qF4j6t6zOrLERXX8+zKBtvbVLilJL6G99Oa7IJkLGgnzVO2
         SHu5MNcYH8Mhzp7n/vQtswqweWtpPsEeqmxoN3iLi4dn62NBsgqU6FFZbcRxWduaDT5s
         TAglnBSpQoFAbsYHUP80Cy63DN/P/UY5q5OIeW78Gdrv5OhroL76zC9Q6jGQyWkh2ZGl
         8+Vj6p9rUAsQehs42ZBsyRSzVSLmcFYW2d6+vSWEYSBwkPglDu5+ixAbMB+8deHtitP1
         GjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901167; x=1757505967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeOtodTRI+OBS50kot4CSeaPmna3ks2JaD3tu8/xt+o=;
        b=YHmERW9Sax6qrTDlzDmV8qw8TFNjmInnvS5dPCdbT6ac7JV1fr9rLAzJz7CpugqfoP
         hDJfaUNizRP5O7toC1EjJQMZeHM+cXxF5HklWndKdO4iixiiohaNPaMCjL00rXj8U8pK
         i3qcVlIeR4DFAbgkq7MbO2oFYMUBbCwLFFaxKa0IVANFLIMdbV/mEf5fcpnpspHWuU2x
         tE1t7JQ4Y0h30Rl42OwenTYqpyMu4iG/xfrjKMwYRzNzTaDeqFLh3yrw4OForyDiimxV
         c3oyoJs/HsvJpyLFQAkjE5hKy05PZQiUdq6153BGlwUTx112cru+XxPCct2soNqVRdSu
         Rm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgmRU96GnKKwJ+zDBQRN/Xp0bx8NscMekwg5/NT6aiGilTw4aDzzvdt4VrlT+BM34MxK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVTabLim3DrI7z7xAcSo0FdSPqlVRcmhgptaL7eDx5jwxyBxj
	2XaATfiIGeKgaA9J3Bq6SDVtJpYduXeCe1GlSmLKFjo6BZsqHsQ8S2sJ
X-Gm-Gg: ASbGnctkS/O0kxt553QLJvgNLCI41U2+jTq6w6UN8UFWQHqAg7LRAeW8jHrqznohz2m
	LJS9USSF6OKfPCOh4V0VURNekvEeoiDsB/Xix09LAY5UoL9hxAeSAcivCGh4kJtPgsDeJouWdmv
	NbilpF9V2uOthS4XFtgIxOVNoJirjzDAESXrDHNcdIF03DpMMRhTGVGlBB2XcALRLrz3mT5sJx7
	jHBmD1csiwhMAoYv7VZKipwE29ig893VOeAVVKPPDybn+AqMXQvQPeWMMrKhVT1bIemOMUybuez
	nf/AIALRmFUNWALgPim5XZtI1QWUcR8QyFBJseqDmGIoow5iKQCMuHnZY+dh+GNIIzX/7VNNlLW
	VpRFb/JTPQh6i5YWsqZXz7xT1n3tTsPl7PJr7n2NQjiJl5yJHTo4=
X-Google-Smtp-Source: AGHT+IEgLpaebfrGWFEDqZ1Vr8B2710uXLEoN/+Sw96hSPwPaY07+Omw+Jui0vIxxxqP75bjS2Hxiw==
X-Received: by 2002:a05:6a00:a85:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-7723e2578c1mr18564170b3a.6.1756901166565;
        Wed, 03 Sep 2025 05:06:06 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:06 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 6/8] LoongArch: BPF: Make trampoline size stable
Date: Wed,  3 Sep 2025 07:01:11 +0000
Message-ID: <20250903070113.42215-7-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903070113.42215-1-hengqi.chen@gmail.com>
References: <20250903070113.42215-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When attach fentry/fexit BPF programs, __arch_prepare_bpf_trampoline()
is called twice with different `struct bpf_tramp_image *im`:

    bpf_trampoline_update
        -> arch_bpf_trampoline_size
            -> __arch_prepare_bpf_trampoline
        -> arch_prepare_bpf_trampoline
            -> __arch_prepare_bpf_trampoline

Use move_imm() will emit unstable instruction sequences, let's use
move_addr() instead to prevent subtle bugs.

(I observed this while debugging other issues with printk.)

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 43628b5e1553..07ca32c673d5 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1599,7 +1599,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		orig_call += LOONGARCH_BPF_FENTRY_NBYTES;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
+		move_addr(ctx, LOONGARCH_GPR_A0, (const u64)im);
 		ret = emit_call(ctx, (const u64)__bpf_tramp_enter);
 		if (ret)
 			return ret;
@@ -1649,7 +1649,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->ro_image + ctx->idx;
-		move_imm(ctx, LOONGARCH_GPR_A0, (const s64)im, false);
+		move_addr(ctx, LOONGARCH_GPR_A0, (const u64)im);
 		ret = emit_call(ctx, (const u64)__bpf_tramp_exit);
 		if (ret)
 			goto out;
-- 
2.43.5


