Return-Path: <bpf+bounces-37924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3395C763
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A703B25636
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FBD1422C3;
	Fri, 23 Aug 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqGSTkR8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A613F42A
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400424; cv=none; b=shZ3C9a/2iWVA+dK9G2GVh9Uk9bzH1ZgkR0yv5qeoGchx6y8SMiLAAQyj7h+yoGW4MXYum/4eK2qWIXoxP40iMU93kkeeVivVp+kzvKXVsEYxP0umI6spz0OLDhUMkoTxEFZtPdWlts0EeCOC+tYq79kOse8HQWl6YpkEWiZtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400424; c=relaxed/simple;
	bh=MBXXs1mprhRKqJuL6VFup41CFPrKOCxduNc1b5WKbaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5H+nR7JsWAoqNQE8CMQWFCierjvkWEajrdIeXetprl7CY7kK1dTG+vV94mSfR9Zn0M6GClDyXMTp1OPnuiUi0Hxj8uD19p8sUN3Acrm9UY5mnv2kOS+NVNMvSO6QieBP6o7TjO32EDqfIjIz70VR2xahZO78tpfl15jxvlY4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqGSTkR8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201fba05363so13881795ad.3
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724400422; x=1725005222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8G7SJ1gB25PYRCSCjuMt+UHkI/3Gt0/ihw3FtV7kTI=;
        b=LqGSTkR8qMQ8VsMBKQdCKEY8koxpIG8TvFlXyQPtt+maLSzz+Ka2N0zbs/9vMs+XdN
         O1d3uSSyV+h0iC01ZAx2Rl7uz9dc10PO/Dh2znNUzUZZUpsd5jx83kbIqxsg4BWOLq4U
         rqMD9otwRD+Nep4bdNTiDuDTtDVOXSzmEnaP/9bw1Ybmvn+spP0kLb2fnW3ho8Dda3NG
         E4MX44x0qxhTIEqJ+OiHtu3jc1vDfMh+A/s5gVcNpbaUY/SYVOy/zc1qYhw+9Qa9+Qr9
         oOnI+qm3uAPfRbqowS4FKEdXivW9IpcVidENhTf8GJEDyyTlsbenh8QSfU3qeUnB9Zm1
         s2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724400422; x=1725005222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8G7SJ1gB25PYRCSCjuMt+UHkI/3Gt0/ihw3FtV7kTI=;
        b=dGBsBG0Gaw8M1/08z6YO7bN+5P0LWuTxiFjs/uyPO8kKC4aLTzYSrDu9vptL+io9nJ
         Dmbi/g6vUWCI8DeCWUnOWgOupgHevzNw+CXm2Yg1tmqkITJWq83jYWDR7SDIwOOLLVUH
         j67rfoyRW+I2RaRxZ8te4sndzaLYvi+Zw3OfL9sM6SEBgEThvBhV0QbMtparBkurIqlC
         D+8eJ20mnjRv71T5ZnItIqYZxNL2ZLBVJ43sg7G9RYgPJyUuQePaxpqBXTQeiriMz4TE
         2bmBuxshHX81pbMi23JfOrnSKYueIAZ1TwXKM08K3izJa5wzW0uE81QS/dTWBn+IXyAw
         xzJQ==
X-Gm-Message-State: AOJu0YxRTfTCMrhAcd3boHAyGdnJs4isGMfPnMjTUUrTMFG7HEB8POZL
	OnwZaQjx4BN/DHj2wVKtYtrJyRyZlVLlP5Rx/46hb4iEzKN2DsDcBuuWug==
X-Google-Smtp-Source: AGHT+IFZfPxhpFiCL/8rgzzh+UHSCpDM/0HhM2VJdsHCFspb0edeJol62sgHGuABBdtQg7CdWThuZw==
X-Received: by 2002:a17:903:32c7:b0:202:2b3c:9ac7 with SMTP id d9443c01a7336-2039e6be6d3mr14599035ad.65.1724400421659;
        Fri, 23 Aug 2024 01:07:01 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567f74sm23463925ad.60.2024.08.23.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:07:01 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: match both retq/rethunk in verifier_tailcall_jit
Date: Fri, 23 Aug 2024 01:06:43 -0700
Message-ID: <20240823080644.263943-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823080644.263943-1-eddyz87@gmail.com>
References: <20240823080644.263943-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on kernel parameters, x86 jit generates either retq or jump
to rethunk for 'exit' instruction. The difference could be seen when
kernel is booted with and without mitigations=off parameter.
Relax the verifier_tailcall_jit test case to match both variants.

Fixes: e5bdd6a8be78 ("selftests/bpf: validate jit behaviour for tail calls")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
index 06d327cf1e1f..8d60c634a114 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -59,7 +59,7 @@ __jited("	movq	-0x10(%rbp), %rax")
 __jited("	callq	0x{{.*}}")		/* call to sub()          */
 __jited("	xorl	%eax, %eax")
 __jited("	leave")
-__jited("	retq")
+__jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
 __jited("...")
 /* subprogram entry for sub(), regular function prologue */
 __jited("	endbr64")
@@ -89,7 +89,7 @@ __jited("	popq	%rax")
 __jited("	popq	%rax")
 __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
 __jited("L0:	leave")
-__jited("	retq")
+__jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
 SEC("tc")
 __naked int main(void)
 {
-- 
2.46.0


