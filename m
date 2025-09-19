Return-Path: <bpf+bounces-68941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D417B8A91A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0EA16F776
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA61F12E0;
	Fri, 19 Sep 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5oqmYHo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958361EA65
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299496; cv=none; b=FDC/q3BL3oe/4WUfoU/ykS6K+6xXct5RhMIj4yn+6E8gWuO44NCGIYWE7R5iCgqMZl02XPOaebfYnsmMV7FScB2ZxGdtzQ6fm3M0U6PXFTbQsvYTO3FrYbeqih0DaL5NOf02IiOvPS4d3khIy9oLHjP2Fn8XBfC8euodf77+SPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299496; c=relaxed/simple;
	bh=h62VUoSoiBInOe7Jt+k1+xrKMWEvwWsmBLB82yECg+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bOEg/6cvU0vJP0sTvzllVvjfamVzdvx54+lUfwD8ZwxWudniKrpnGQzI4DSL+o6zdXkOSo+CHtO0FpAq09heW4zMMYI+KXxzxGaGyvttrzTBxO4WqOmS2cNrFa6xQEvrPwb4W55mcI8g0DUO37zbVLFp3TXRnmg25Uj067gTB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5oqmYHo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so1696445a12.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758299494; x=1758904294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kq00Hmy5CM/AXskGBrPvdHQHw1I7DDi7vX1YUv4b3wY=;
        b=j5oqmYHoobhht+XcjBzOsddV/dQL3iNRNCJuhjmoFAV3uJUBxzR/cTfn4KLBaS+0pf
         k9rpAVi51zyFdgDurEhet3AwAX5bMw7iTV4hcJTkRcF/s7xoVOpytrkLQNcZH3cgGndF
         5GuAwwLt9KEhwspM0ahMbAeJU0trsXVz2hdaI/BS5BSSgMDPiJaLKCBXmhscEWc5+Frg
         RVMnqwqQeBugkJDu7EXMvpjoJF5maVqwxJzX+KXclMNsNU+EKINVGnKfkPC12ZsOOiLx
         +3XKgw+yhGC1VcC5y9VjRvq2FyNvl8kQe8KOTAvIAUAU62VZM7rmnVTwtSJSdCmfLDRK
         Cidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758299494; x=1758904294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kq00Hmy5CM/AXskGBrPvdHQHw1I7DDi7vX1YUv4b3wY=;
        b=RC/PrrtA6YgC97I7w9ovoW9B7AIgYwPC49pF72XmDENFHlZ7mEduJEY14CjpvkcMNz
         uBnBbmWFFcGT2pExDRSQIUGgBUFk8U0DZooCxwbWUUN8+HWUmfty1HIjh94sClniNxc3
         IvLTXRD1FyO2yUv1RUUFxoNRFkzKgbpS3ogfszsdefqxb332uqUEB+Such7y/i/rACp9
         /W4GsNhSJauetxL/akv0Tz4ejL3k+WV8V+Lh8Si3biJN/j+ekKAlUGgHjhW6eGOdgNNH
         AFoOxA1Pq/9EinM5N9Hf1SROySxekcea+4TneTS9ZESQZz3ItLBPpjjwI33g8Xl66a/K
         HWCw==
X-Gm-Message-State: AOJu0Yz3mjgmAzHx9MduBwI0Poe6SkxJ1Be1iOasTcIcUN2G1AiMcMaF
	tCOoqYhqIZ0D5st4nQe+rPIrnJdxaH4qD67EyyOe1BhxqUyqbgZUQtyw
X-Gm-Gg: ASbGncswJa8dYFP3DJzJKY9flN9PEl9Ij6N0EjkKAI+kbczKrBcMY0cDonTP/+t415r
	Q3srcz6692EGJdl5KEIqiDPsZg1eQpVwITmUcmeY87tDBeDKmxxE/6x3DQcQ3wCacpFFGfev2Aa
	Ye9UkszzrvXdoIPzXaxC54ruQhbdO3IdwMZZbYTeyJPqatWfi22S8KK4Oig6DfBLrimecgKtdNt
	ypSSsL9V1QsSyMzjoKkHseTlr28Og32c2rmT5YxTm5JgnwnxsNiKEHbJm+Qw+gcvamHehUF10t8
	UdqQhMR+8iNn29VcYhLdQsxr7vtRc6Z53+TYw0F+qwdqw/fXUCZwzZzbzQujddyIs4G/7ZhpmUP
	/vekvp537KekkKorxnLQjLyNFG1uR+A==
X-Google-Smtp-Source: AGHT+IHK5K+7PLiG7wbDHRYGhFvoHbNhZ3CO9GCXrqIMXEl1EKjfytfoh8XbuI+B5p1Z2sSsx3piRA==
X-Received: by 2002:a17:903:2bcb:b0:269:9e4d:4c8b with SMTP id d9443c01a7336-269ba47f2ddmr49179205ad.21.1758299493662;
        Fri, 19 Sep 2025 09:31:33 -0700 (PDT)
Received: from r210.hsd1.ca.comcast.net ([2601:648:4280:48f0::ec9e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800541adsm59704775ad.4.2025.09.19.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:31:33 -0700 (PDT)
From: Vincent Li <vincent.mc.li@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org,
	x86@kernel.org,
	Vincent Li <vincent.mc.li@gmail.com>
Subject: [PATCH bpf-next] bpf, x86: No bpf_arch_text_poke() for kernel text
Date: Fri, 19 Sep 2025 16:30:54 +0000
Message-Id: <20250919163054.60723-1-vincent.mc.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel function replies on ftrace to poke kernel functions.

Signed-off-by: Vincent Li <vincent.mc.li@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8d34a9400a5e..63b9c8717bf3 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -643,10 +643,12 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *old_addr, void *new_addr)
 {
-	if (!is_kernel_text((long)ip) &&
-	    !is_bpf_text_address((long)ip))
-		/* BPF poking in modules is not supported */
-		return -EINVAL;
+	if (!is_bpf_text_address((long)ip))
+		/* Only poking bpf text is supported. Since kernel function
+		 * entry is set up by ftrace, we reply on ftrace to poke kernel
+		 * functions. BPF poking in modules is not supported.
+		 */
+		return -ENOTSUPP;
 
 	/*
 	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
-- 
2.34.1


