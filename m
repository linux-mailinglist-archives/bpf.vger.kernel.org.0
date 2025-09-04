Return-Path: <bpf+bounces-67428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F0B4393D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 12:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B873A8FF5
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B32ECEB9;
	Thu,  4 Sep 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+tuJKtB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F127461
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983102; cv=none; b=lD9a3MZIaWAHJ/4P34LGxXGtykVpCwle1e4gR5m+hZlUlA2ve7LagyVO9YNEkVto7IW7OO5jRx9RRCGTgLgd5Rr+WYX2sJWFipceo0uBVr3OL4DkTCDPu5F3WwBPrcf4c+zn8ExafU4pgeACNLG6C1c1bkkeAjx+92l8a7MXeCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983102; c=relaxed/simple;
	bh=KurW8R4orjFMAxoWwbZoKPLMwIdOxVUUgSsHzsQYKh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPqwF15BQAz8qwcuyWGmGrNnXzpWGVuCVtxxhoDmvMA2tAuMC0a7DmmpdG2JyLLi4Vl7n4APVa7uawGACGdXbIxm8U6K9cD7pHpQBZa2wHPXYZAOwbhIYOTyX2JiF9RvxG2uFHA6ibuaHuEMyEUVlnXZa63EknEC6SFrTKVx9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+tuJKtB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77287fb79d3so862222b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756983101; x=1757587901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7jQbVfvjjy4s26/KcS6dbO1yAkMslYFuaBzKbU8/+A=;
        b=A+tuJKtBq1PHT4bN0xkkuboTl+W0epl4QfoT/uOW2olZE+1ISAs1ZuBbXZ5SFvL/Tw
         wlpkROUFXImO9Xdb8C1neyoIsk1I36/ua3TM10YMMmtcDnD/IKdtL71eDLOSM3FXB87a
         2ZaHNkkttp9JzaRzD1hQlNlnj8vJVT72Adwuq0apgZv0SclINx+Dyr/NnQMa+57IBrVR
         2Fa83+K9/tY3oG+np2HJfZy6g97gPHO5H5wGU204W0txJWdV6sGytg/RyTCOQGoIreER
         IabP5/hiASJ6qF8H+fmOjNtFBuFxLQEWuH9aooRhRjv7IKFr0mOMQSlgzQV7K7nDwY+G
         buCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756983101; x=1757587901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7jQbVfvjjy4s26/KcS6dbO1yAkMslYFuaBzKbU8/+A=;
        b=SWgByEdniRkIr17I5Ghvoua5xZzRzEgRxDyr8bumIlzWdCl5N9F7kDSuRNgB0frRqr
         u4dMAosy2ZWVaGBCM978JJWMsXNihR58PEvV1CqxyZDUUc49dIoJ11mVZkBDQE3akKsT
         AJpRDsG/Ni9SL0MjTUnZOYJ0hxL1+lh9nVXPn8iLhRkffMgOH7aX5XLSonz4jkctcIu4
         uHEaXj0OpM4Gkq5xFn/CzarpK4w04ltxp+B0UdSsN6Y+cdBUAhpEevxRGY+uXPgbKYNa
         7g59EMaPCcWV2c8MgJfFhWAlcdv2mCudg3A0SwAystYBCI39+xC9ITtKBV7LU3q3rx4U
         2Yyg==
X-Gm-Message-State: AOJu0YyWqW5DbvlvOylVhXdejnWHU/b8N+CjQAnf4/cYxHmQEVxfVpDm
	vIHXd1gHD/Dm2xsrujZ1/IpZJlYRgRhnY9rlZkIuNzf5yYZwBsByUm3EmUHlrYyAooM=
X-Gm-Gg: ASbGncu6vVunu8lxcJkFHo9uLGLiBq0HY816zyoQW0fZPdkSzZL4I0mgaQt3DOXj1gn
	KXntaRo49iKTZ6pMgL5gjVyCijUxUP5V4tdtVn4DB8LMWQMsKbHeEyruTbYO/MvxxrXyWe+zeoz
	D4sPhL+eIpa64L/Rz5IedoBlL06xOAqEs7u31myVRjsJFNsmFZL57+TsALN16wxVgDxXulhI6jb
	rjqnBeZRgN1Px6p8B/0xKh2Y0YHURfwrsiEZkbRu4Hwb5VO09dUS+spVMtPnUJlkeBB+dk+W+P+
	F5IAvh/RhRJ/ds55u7ZdkvUXbMn2U4HAQSWKeyFr4grut9t5pn53hLVZjp1CxzXBUSQJC/ipAAZ
	hJB365khmcPWkZbP5n+/34DJCvJjEN3P0Gp+CHDXGPgyoq4c4amw=
X-Google-Smtp-Source: AGHT+IGsqHfcYn1HKs9rJ6BOzzQ0f8SkFW4i15uSMDVYFJ4sqMTx8DnbC+WafRushmd718na10DSTA==
X-Received: by 2002:a05:6a21:99a2:b0:248:b2c8:5cbf with SMTP id adf61e73a8af0-248b2c85fa6mr7775770637.58.1756983100730;
        Thu, 04 Sep 2025 03:51:40 -0700 (PDT)
Received: from ubuntu.. ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb7d391casm2795224a12.7.2025.09.04.03.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:51:40 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org
Cc: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next] riscv, bpf: Remove duplicated bpf_flush_icache()
Date: Thu,  4 Sep 2025 10:51:18 +0000
Message-ID: <20250904105119.21861-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_flush_icache() is done by bpf_arch_text_copy() already.
Remove the duplicated one in arch_prepare_bpf_trampoline().

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c7ae4d0a8361..3fcc011c6be4 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1305,7 +1305,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 		goto out;
 	}
 
-	bpf_flush_icache(ro_image, ro_image_end);
 out:
 	kvfree(image);
 	return ret < 0 ? ret : size;
-- 
2.45.2


