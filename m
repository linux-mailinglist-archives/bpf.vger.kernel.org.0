Return-Path: <bpf+bounces-67279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D420B41E58
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91C77B8905
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E62528C01E;
	Wed,  3 Sep 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXih9X6A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682C2C178E
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901152; cv=none; b=labtpZkmmokF+bdqd6dxHLsYGxXM8rG1qc/5FGtpfTyslZTH2vQr21oHv8OcVNnIWroavbXagPwrcon5HF13KodqoTqTEupIbwVysxDSmmDBKehDN8KKCiJhNgHRYzKT3uy7/znEX4PDHneQefZ4WNBWwuP0+NbVy+3b6O3G0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901152; c=relaxed/simple;
	bh=jtB0lg4+UxGfKcVnXtonmLXk9WpPXLrO8CmyZwEGNVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnQV7zucRuZ0j2g5WIP9oZUGLYjo5m9vOF2tssxDRqISKUHSPgC/NjCsyrfAjvvQCEjT1m3D0qdp+8UJHVgmiayPDufYwJ+u4iLkDzAe3TdA8rJ8XXpmj+EI9CzUvXw/uzk8yUrL9ZnNVijwRrD/LKw6i59Uulu37kNpEjSk8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXih9X6A; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32b4c6a2a98so1491790a91.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901150; x=1757505950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaPFkpRKUnfmHG1h2XpW/23dJvc07ZUJRoXsS06YXxc=;
        b=kXih9X6Aw0QvLi/mDtS0NXJl42gS75HvoqURQpaeahMLkpgRzUmVPo5VzTjTJzVFIQ
         /GU85MUOVr5Wp0tZ4hiqnwMxWNEiFTWdsR/bB9yccB1+BVWt5TAHU76IihDc5G5qr6aK
         QBnbW0VgBVmiTKfngvDU3BE2fLdY5ox7Mn26EhVGo49HwY0n9YhiAI2lS/8Dh66q13ks
         R5QxQLQZsX/O7hMXJpBCXV1KvqK0FP/TBV0uzF5Nr4Z+Y2pj9ScGpw3SN2cJyGIue66n
         jflwRqu/6DzRocisaJb+X9fI13SuBy8DnedInFEVXe5Wx+aTOQ3uXIFhh0s6d7Jnbl6v
         Bzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901150; x=1757505950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaPFkpRKUnfmHG1h2XpW/23dJvc07ZUJRoXsS06YXxc=;
        b=ZA+GfQNf68mJSRodJzuPHtRt/O3nnptcIHjg7mNeGP11UDdGGdNnsgix5aFQLkJhim
         ShlDznmK+Fc841pTss5h2gPt+rYn5zKRNyuo+M6673pkDHj9rpx/t8hyWPNrmet14PUb
         bBOgfWPgbsSR+M15iSDZzoP0dE+O4IQ9GQ4+xZFyyfFjbBKcFNOFmIoL6Cv8iWLiy01d
         iiVRVbXdj2dVehC70L5bnCwHIP4qZY82QfvDT3cfCnmfXLvX8e6niS5ObTYu0+ncwly1
         p4TrW4aa6efZz55MdSgIQwghZDOFwAuV43u4Ny5BFETckZq2aDGhg3HNp2tQZ2/mF0t0
         JNKg==
X-Forwarded-Encrypted: i=1; AJvYcCU8XPBG/8E9J3QNocAxndfKc8xy1B1x8qAVCet63ZaOBA4mSgUc8CoVOzGvE9ezKAewt0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxnSbTkGyY68CzlI8Yuv5FL/lK1YPYIFXr3zVKAyO+khsY6Akb
	W+ZxEwFzYhjWQGIPuZUMzizXlgGO2ce6SCmp2DwuFx1cXJdL+GsaQBvqLBJA114ifvA=
X-Gm-Gg: ASbGnctYfYTbYLKP7jGHhTxF7YLSgAyGFvgx6QzahPMWr9RPZrK9+nmQ74tMbHzkj2E
	N2ghJ6AXk8MDct78wZ7LAxPoSv+THMt8b745wrPHyEvN8/4MZTz11U0IX2vyDupc9VN4jKyVIvm
	C0DRf5L7G3FWle8vO9y+QcvbY3ZXWQqGa1IJVmIUa5zu3UB7yVRdw68ruWov6Mwi/VYPmLQYlLk
	DxH4p3dUA7iAok3L5FTOcV9F4guHvNySxAGQlddExfU0n1EGsn1c1I76X+MAnEh929GYkA5ygf8
	ZL3qhSrjU+p8x5wyhj/Cu6yPt2UsZDYgMNrSMmQCZ+A73VHsiFjz6YC2YiFDlB50lQojS37mpO3
	8zqribjs29DD3sTvxCfi3kJ8V8G4B/hd4jLOHdStZ4zCTXdoDn1Q=
X-Google-Smtp-Source: AGHT+IFbmpMARNy0bQl+OCKbkvIceYcRiqKcNI1sC/X9AoyWJsP6W3vcuWyE+o1vVvKLBk5bL0xfzg==
X-Received: by 2002:a17:90b:1dc1:b0:327:8c05:f8a4 with SMTP id 98e67ed59e1d1-328154140a1mr17793434a91.1.1756901149471;
        Wed, 03 Sep 2025 05:05:49 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:05:49 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 1/8] LoongArch: BPF: Remove duplicated flags check
Date: Wed,  3 Sep 2025 07:01:06 +0000
Message-ID: <20250903070113.42215-2-hengqi.chen@gmail.com>
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

The check for (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)
is duplicated in __arch_prepare_bpf_trampoline(). Remove it.

While at it, make sure stack_size and nargs are initialized once.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index abfdb6bb5c38..77033947f1b2 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1453,7 +1453,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 					 void *func_addr, u32 flags)
 {
 	int i, ret, save_ret;
-	int stack_size = 0, nargs = 0;
+	int stack_size, nargs;
 	int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
 	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
@@ -1462,9 +1462,6 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	u32 **branches = NULL;
 
-	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
-		return -ENOTSUPP;
-
 	/*
 	 * FP + 8       [ RA to parent func ] return address to parent
 	 *                    function
@@ -1498,10 +1495,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
-	stack_size = 0;
-
 	/* Room of trampoline frame to store return address and frame pointer */
-	stack_size += 16;
+	stack_size = 16;
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret) {
-- 
2.43.5


