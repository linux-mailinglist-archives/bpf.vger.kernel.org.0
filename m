Return-Path: <bpf+bounces-66194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE57B2F7A9
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900493AAF4C
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8218F23E32B;
	Thu, 21 Aug 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqJoUkKN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94231E9B08
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778608; cv=none; b=rd3USUzpWeELNb5Pms7oIsTI1B3pvLaAz+UkQPv3syu1BK11avd/pHysrWSNqFJq+w1lC1l3NX+qfed47TcU2EXs/PGpieA0MkCD8Gzvd8vhb/kivCWFevxQgcwKYpdjy666nKzAGfjS4i2Glq0v+VdADZajgDGZn4yvePm7iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778608; c=relaxed/simple;
	bh=+Ge4iu2YV0fchUwy+7FI0t+3+SAq29n3oop3xSbvzWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGO4/e81eMOnajyi1B983BBaGPcxfPlNtOrUs4+jEQXTZVN7+fQCKVRe64ZemxoesdtUsRjtmnxhgYxp5U+3VGhbA0wnpKQXmElI8u2Q4hiHLJa/VijLKJA9c+ol9BP9r47h595oTwNpMtqaymjsW2NMvHDCouXEmUapUdUsTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqJoUkKN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so840339a91.0
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755778606; x=1756383406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaBUUIcLmP9bHoHObnAzho7CHq4d9zidwzlZrh7wTgE=;
        b=UqJoUkKNhpRWj/0BbN8W0NYUMpd6eS5/pw3SpONpt40XixMgfAJvAYykIRzmtifoGF
         afcMRIRu0r+5G63xbSm4PKNW4qewTG8RXYa42XYRLZwIxzfPRjvMUR+fjYsz872neswu
         fni5V+6MGfhYDEcPDj2ndXJjHEr63dnGSrdFkVM+ZyfWVAITbayEu5xfWQmBDmA6x9sP
         t3zUotq58hqYK0f31MAa4iFJLdRPCnB3RizwG/NOZZomUDgmxXtsaJHLBh3wdHZsVupN
         4rvADElx5p8IMnd8AQYpI2gwuOm2hcXAqRzEf2lAxcw5B0+JYk01DGtmYNG/Hrz/TxJy
         vweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755778606; x=1756383406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaBUUIcLmP9bHoHObnAzho7CHq4d9zidwzlZrh7wTgE=;
        b=qmTbZFmGtZxU+tcHOAVv5jlmZGYunsQOcBPZJ/GuwiVqejPJECwovi48g/OJzL6liL
         0odeFxpMu28OWI7hxRYtr6lyP9+VUVgyF4bk/VcJJqLldq+GZHC2PZGlQTE+D83LQFW8
         RnXZvTuccXEST5JYmERcDGZuRNAx2R3Lbpj0tgzDlyFW8SYTafkh4VtuOzyJRYxTd9U3
         5E5YhZG65YqgTTgy2HjjjL/1Dqt5XsBP8hiaFgoJXsKCIn1b3ff1LdSaqQKqDAeBZZAe
         g/RbgYT0BrcuPvnoI6y9z4poIe9FLGHmL1WGaqiQmq98vD2ZB6wGtrf5+nf8pLRoC7mz
         QDfg==
X-Gm-Message-State: AOJu0YxtOewsH/BdSnpA/40hc9zZPzLdeV5aae46t1xyagyrEn72hSu+
	NEdnj3acRKtqxSNFwxpY1N41I3JsHptjHASF0iKk9BpfY5pVDvjZdd22
X-Gm-Gg: ASbGncv+nUABPbVAcKMRlP5KN+7718fT4cB9/dchra3yGjuGb6vfKqMkN/8ZQ8pLDKg
	NL99QjpLf/xgTGHJSIq5+W/YSaC7m+KD0HpcuxuUbFGwSTgMpk+aQol652CFqXQ42QE5hH226dg
	3zRP8TqytK6TvaJZS1x/BjQdGJimSPrwR+PbPRoEZvWHm1kgd5wx7kfrFEBqBf8fWihW0qoeKPX
	yGuPlOJheG5ud+7YWb6f7IWMT8h7y3rzISP1FTUsOZ75ipGkY3SIlJqw9e0ZmJrpZMd5FlQjv7d
	ckmw3S6igieHq6MtkIYUFFTT+EJStyN4Bukm8LcKyACZZs3vxujI8Lrgo/LnXPJNwpyoB32gqp8
	dPUzOfm9CrjQL3cp0U3lpOpcKsTOXNmc51JtkC/kg
X-Google-Smtp-Source: AGHT+IFH8FEC5ecYFzMEeiHPciJ7pR9bfdLqQkdFs4MgBYMo4h3DypMts2K1Nohtel3SqaJrVEnq1A==
X-Received: by 2002:a17:90b:530c:b0:321:87fa:e1e4 with SMTP id 98e67ed59e1d1-324ed061386mr3493748a91.6.1755778605703;
        Thu, 21 Aug 2025 05:16:45 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2c48337sm1745442a91.25.2025.08.21.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:16:45 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH 1/3] LoongArch: BPF: Remove duplicated flags check
Date: Thu, 21 Aug 2025 09:10:01 +0000
Message-ID: <20250821091003.404870-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821091003.404870-1-hengqi.chen@gmail.com>
References: <20250821091003.404870-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)
is duplicated in __arch_prepare_bpf_trampoline(). Remove it.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index abfdb6bb5c38..b646c6b73014 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1462,9 +1462,6 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	u32 **branches = NULL;
 
-	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
-		return -ENOTSUPP;
-
 	/*
 	 * FP + 8       [ RA to parent func ] return address to parent
 	 *                    function
-- 
2.43.5



