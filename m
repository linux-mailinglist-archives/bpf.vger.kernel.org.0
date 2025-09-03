Return-Path: <bpf+bounces-67282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED535B41E54
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9434858EE
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CE2FAC0D;
	Wed,  3 Sep 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcSuqmWs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83D28AAE0
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901163; cv=none; b=IYadLo8lN+/zCU5n5CBAc90/rRoa12DEsRS7y589QaUjPU2ivaUe4R4AhiQhpE5tAqhDS3zH4cBSDOC6brU1sDQMj5r/5vxyGvMjOXpAc+tfoz8YiNzgasHw0UnGY1suKGB0Z3x/u60fM00hhXloilND+KJWFDdavk6RG9/9PPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901163; c=relaxed/simple;
	bh=5dDbIvJNgmtx4IGzBLZg0NpC0MsewwgLgxb5EiPL5cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxIYynDveEs//m62gBUwt5+DAgJaQThnhznMNhPYqITun2MiLKiGRzENM4F9+Umuj/dRVnwM7dDcVoWtJZ7AqhzeSgVjMDQRz3rqqCHCLGxFMW4uCGORnfZAUuoRrUnGgAGsiG1ewFIDbIog6OclFvbhPuFCMdEkhfrtdNY42Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcSuqmWs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77251d7cca6so2847023b3a.3
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901162; x=1757505962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqjAiWZ1cR1dST2aN/78MxdocUsZPL3/fjHVYRoFUN0=;
        b=IcSuqmWsCM5gv2ZCUH232d8I1H4GVeQc7SXQkIzIurYdtp588xxCJ48aVmy5QMeLcw
         Du4xh/psKd87AfS1ib6Ba5rReOgNhugSdUqvmuAcdTgtsHRDeFo7KeKR8cP5fXAQfWi4
         MGM+3zotre4GLjdFjADKKDAmQX4wlfHN66Pbqa4mRTMnsPga3xKgGPXD7r8yXlMo8XIS
         f4QuPsL5lYepNzFE+6n5z5yEk5OioANzTvJ6PYWy9WRm0jJqqjf9WfmxQrpYFrZs2SlL
         XdSfEr/lJdFltQQm7hG3PeE+bkb/p1uKkmSlK3RgcTxcqv3+IzTEhvRjCHFC/Bnst8AO
         nTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901162; x=1757505962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqjAiWZ1cR1dST2aN/78MxdocUsZPL3/fjHVYRoFUN0=;
        b=XTHJ8u7oSc/vhxAosfYHAmQVTEUiwj1Vy+GVQy/74zID/mN+gWPdt9tPGTjRiKqbRy
         AELNW5v5weD5Tlo/4LdftmOItLHoAyucTKSFS/1GxLQNOaVJEX2ZA1/zMaOIuHGSAu0z
         UsUwa6qCFXuIbgkqH1OuksWSoikOPqsfSIfYtp5WJ8MoPHFJ0rsf22HpiYz/tKLyL3hE
         NPsYJ5TcPPIeSIHCOs4ocWU/3JG3FHFZN09dVl3N42i9P+0iH/7UpD/vO66HzYR5l4Tj
         oIwzHCMQFGARL4Cb/KPoZQ1JWy2Uo8X9RvKlZEiMswBr3BbiSZ6MX6IEod5GtJCdP6xA
         jRjA==
X-Forwarded-Encrypted: i=1; AJvYcCUUb3c+iydi+HEgoXvFgoWvnRbkurRv4UByWRj9WbhOCBuiPTBilh8gmgccYb3Ml93NtpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKVqzK15TNOCs+653QJ9lcJ9wMdlYChZ9cxlpBV+U/zBsRE5D
	M1eSb6/GbXaJoMs3gWF12Id1opY45uj1gAcrhrhIsBt38cxSU1e732Pq
X-Gm-Gg: ASbGncuosqPIxbPsa5VD8SPumYM9x22gCFtZ5ArhyFd76DMXqQjQEq304fOTMSeHMIN
	u/WAoQ9huAmaLd8/6vjLU7oG/58vod+4D73bNf72mwIuZmfHaYfAumSdat3TtpS4jjwsd+gvID7
	FYNLLil6WktEO1oF2CWbS9SW3E4d9K9Lp5qqwmMrw0DgVVxkOWsJrizn2FuDQ+r/rnnHrAZ6401
	jzwkGQ+SLhw3Y3KJ4uy3RHM/HzNcq2G2fRTMfnLJkqFGV3N4vlF7h9zjy344TlLLAwhhno1Zelc
	HwcQsr+3xA5JRJI1oYvygTrKhp+ftnvcQAS6ULXbcb4pDvX0Q01pTJIBZfetFcJtzqkFMz9ClvJ
	4xdOn4oiODmTgsokLZFf3KeGb82zFoMCKlZos5Cio2dOpxySsj4M=
X-Google-Smtp-Source: AGHT+IFvlMGO1VcR9tw6xoXSraCk/hiXxfzc5f5WoxegTxIO0L2E/JLNbw9ljWufdLXNDN5R3m/PgQ==
X-Received: by 2002:a05:6a00:3e04:b0:772:36b1:6352 with SMTP id d2e1a72fcca58-7723e36a2aamr20719726b3a.17.1756901160220;
        Wed, 03 Sep 2025 05:06:00 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:05:59 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 4/8] LoongArch: BPF: No text_poke() for kernel text
Date: Wed,  3 Sep 2025 07:01:09 +0000
Message-ID: <20250903070113.42215-5-hengqi.chen@gmail.com>
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

The current implementation of bpf_arch_text_poke() requires 5 nops
at patch site which is not applicable for kernel/module functions.
With CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y, this can be done
by ftrace instead.

See the following commit for details:
  * commit b91e014f078e ("bpf: Make BPF trampoline use register_ftrace_direct() API")
  * commit 9cdc3b6a299c ("LoongArch: ftrace: Add direct call support")

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 7b7e449b9ea9..35b13d91a979 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1294,8 +1294,11 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
 	u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
 
-	if (!is_kernel_text((unsigned long)ip) &&
-		!is_bpf_text_address((unsigned long)ip))
+	if (!is_bpf_text_address((unsigned long)ip))
+		/* Only poking bpf text is supported. Since kernel function
+		 * entry is set up by ftrace, we reply on ftrace to poke kernel
+		 * functions.
+		 */
 		return -ENOTSUPP;
 
 	ret = emit_jump_or_nops(old_addr, ip, old_insns, is_call);
-- 
2.43.5


