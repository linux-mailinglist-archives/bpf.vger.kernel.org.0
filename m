Return-Path: <bpf+bounces-60626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA9EAD9400
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBABB1BC306B
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE422A4DA;
	Fri, 13 Jun 2025 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkQc6NqW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF41F30A9
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837217; cv=none; b=pCUUU72mtkl/jBMuNuIK9LvYMKoI75mNe6OIyALFXUkCdxN4KDHsHdbEzZNdUgY+0gqAFTR23NCw1ZZC1j8rq7Y1FNrLERKy5arL94F6Z/Go+t2IiY3krKTUCEkiARgEdrW1M2gMMVHLXeQpbur5y8VPfX+8WFwBp+JS7ydYN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837217; c=relaxed/simple;
	bh=asBeyhklkpU5JRC+aCbWGr6hq1A/KQ/AgmiZ4/081Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2GMd7PxBFpu6hRsEfh/a+QsvDd3m78GB0elRr1hOngf4qbx6cxuuISuvm0r968CqoR+pZaNI8sXvgTm6c9XoDJfS28OiF8QvkS8lSKS12ok/TSFMDz+rUX+A/Up/uvRDiA3bSeJoNLL7YfPJkpG3/8RCHG1Z0EaQOehlVcoIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkQc6NqW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7d8eb10c06so1806230276.0
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749837215; x=1750442015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGIgZ7sSUEujEpTIk0FmvZsxWU2l+FdLXAcKvD+GlYM=;
        b=fkQc6NqWLgiUQsnUX9YAkFsKlnZiNSw94hJPBGMdZiuIWsgyZIQqj6aoGOMCJIdIPf
         kGHD3JCBP8Kts05SoNJPqxeQcxjcLslxKIZouzx2gm6g1eGeQs+PdGKt7ZhWcVmPDsqj
         P3efDUPGL0sH28E8gjtqPwErd5UDuWFXVGCTDfVsL8R4rt/9UeMURXCiT0gmWFjEfYAS
         rHHGdBnwzonD/zbkZtACf1a1TVUTS5krF3J1HFSw4QHypObKfz1Te7T+VIb9Ho3+qcdt
         BLXtcNl3FIUYuaAQs8rP+yZPFtbPaO2BXtj32AdA9r++ZePkA7MzjxNeNKe/Ve/3jcr1
         5zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749837215; x=1750442015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGIgZ7sSUEujEpTIk0FmvZsxWU2l+FdLXAcKvD+GlYM=;
        b=xHqUga5jpAu6kwsMukWvBVWS7eLPu0/4RC5QZQVe1fKfRwarCaHGfpsV/IxpY+RE7p
         5kY6yKkjeQfEqdJc2wGI5f9YTx0oR5eNSN9MwzXB6HZGRSCRivQRHcbnMeEfAmrigJUF
         zhVDEhfx8Ul/fnAMns/78ea/EHILwfV6FJfUAXZrlCN3r91uscQRM64eX91/WpiZ6O2p
         I/cviiNhfkRrAoq/kuFBpCaoJmgTDvxDjSHAYDtOXZz+1CxD+B6BJXygCU69WmRj0LLK
         sphOUX1B1TqDOsKaNcJgNeD1xFo65WcG9UZKQ1Ihv/s2kgXlni2d626FrxFm494nBndE
         uj6g==
X-Gm-Message-State: AOJu0YznJqbyK7xg56psJ3wj0+LT5Yj2FOadEyTvtkFUOnSxi/S1MbWt
	3lN3xk2KpC85gEYQWjN674NgIPQ3m/5Z0QsIk+ISBtW6I8VRWBU9iqbmZML8Loum
X-Gm-Gg: ASbGncu/Ukh76MuSXw+dz7av0xsywO3aWOQxovNcv44bgGDx+OzldHoOwUrBgLYdJ1F
	jahGtMauOsRU9bNmHyWIY12NOfrhJ05uhTlu/gZjaqMhQzfo69ya9mem+vXQg4H/NGqp9Ps1fw2
	qPGokyS2MyUX8oGTTkqmAWmAuPJax92s4sAmsjRoSUOAUhPB1kxeANcAyRFwKhVDX5xOi+n1QHE
	WKpDd6X1AdVHCWygsjAWZSD411zRv1tWoTGvIY0bD/5IyajYvrh3L06m/mVM3U7UlaJupgtgZ/K
	IPHHGnCAkdfOW2Ojc0IJPQ50mPlQaFL+uHjGPL13heNupLLuUVKAvw==
X-Google-Smtp-Source: AGHT+IGvdyKn3nTJPxOcxkGgxmolznGDQB2nUw0p20SKAsOpdfFfiPYdVQdo6lSQSMUR0/INNNqxwg==
X-Received: by 2002:a05:6902:1384:b0:e82:1a1e:8b04 with SMTP id 3f1490d57ef6-e822acab569mr998103276.33.1749837214822;
        Fri, 13 Jun 2025 10:53:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:47::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e06d2b4sm1202231276.18.2025.06.13.10.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:53:34 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: verify jset handling in CFG computation
Date: Fri, 13 Jun 2025 10:53:31 -0700
Message-ID: <20250613175331.3238739-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613175331.3238739-1-eddyz87@gmail.com>
References: <20250613175331.3238739-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test case to check if both branches of jset are explored when
computing program CFG.

At 'if r1 & 0x7 ...':
- register 'r2' is computed alive only if jump branch of jset
  instruction is followed;
- register 'r0' is computed alive only if fallthrough branch of jset
  instruction is followed.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/compute_live_registers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index f3d79aecbf93..6884ab99a421 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -240,6 +240,22 @@ __naked void if2(void)
 		::: __clobber_all);
 }
 
+/* Verifier misses that r2 is alive if jset is not handled properly */
+SEC("socket")
+__log_level(2)
+__msg("2: 012....... (45) if r1 & 0x7 goto pc+1")
+__naked void if3_jset_bug(void)
+{
+	asm volatile (
+		"r0 = 1;"
+		"r2 = 2;"
+		"if r1 & 0x7 goto +1;"
+		"exit;"
+		"r0 = r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
 SEC("socket")
 __log_level(2)
 __msg("0: .......... (b7) r1 = 0")
-- 
2.47.1


