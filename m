Return-Path: <bpf+bounces-60738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59955ADB6AF
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1875618816BC
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26221287512;
	Mon, 16 Jun 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ5hE9Kn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E63286D4C;
	Mon, 16 Jun 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090917; cv=none; b=XB79kGYd/F0lOImTY2W4gY2eLbrGM/0fn8o/J892S41NYlZaNmpqH8//LbDvH6sUXh2I47FCv4CbS9natdJ6lNy22pwAXj+P3JRaRW2RmT2NQjtqNt8m/ta8VKyu21C7xz52CadR7TKqyn6IvSWwFzPpyZUIYYBdkrrB3iW8zW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090917; c=relaxed/simple;
	bh=RfRvUUYoMKCxEmMrEwHViOmEyxcA6EnHNTWW62LCo3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvRYQn2Xl3JoRqK3+UO0rKutNSFSP9qao8/RsIxgTpM0vG8te0LZXSK0TSXftNK+w02Wi+I129WuYk3a7InHITt8CcUfmx5GnF+6XIG73JA/RLjzroVWTGd2ASumsPIl67OM7ushdPlaohzPLT2rzrkWLSpn9/aQ5qDb1yZCkm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ5hE9Kn; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a589b7dd5fso75867011cf.0;
        Mon, 16 Jun 2025 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090915; x=1750695715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jFLMSnoLv/CTUlJyxBIiOWdEUWj3gdBoK2X2AHkWCds=;
        b=NQ5hE9KnhtQIP1yT6s+mD2afxS3Bpc4mpjC6ctAB6qD/3XL0FeWcM3AMPlTARSOpFy
         7qMawJRKZfnpXOjoak4pzMhtwm9q0Wbuuw6J1iHfbGRrhTznlIrQqiXEMc8Vt1cxlMbI
         hf0c92Uvg0Ze31WBztuoeqDs3e9qWliozk2ek4E+i8giQvnp3LBFcxSnCUQAzVtuACtT
         GhErPpg6NdzNF+Bgq0hn5MXe+dexu4WDOuMAEDQotJApFRDJXe62eaHPD5loQkL3vsGH
         YHRpDnBWBrxIXP2P7E+XOqjgCwFkHxMeL1p3nmqymSF3q/VBV0HQH/Cp7iS6NkuicJsJ
         XG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090915; x=1750695715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFLMSnoLv/CTUlJyxBIiOWdEUWj3gdBoK2X2AHkWCds=;
        b=YyDwn/uj0+SvYx7Cl2GoZ9+gtP1PR37p3JevAPz/C70QTRBbsG7dRqY+oW3134QdNN
         59TJWzC9bKo04gjAqbVb6ea9ABBQ9PUmX7qyiSek9maIXCFdorrsjb9WH7Kfof6CAWDz
         IVmJY8Lgo0HeRVSNJ5vOMBkZ2ytHTPHtAtvpNTsRP75K4I8n4lGKav3JngAOc7Itr3gA
         Ys3rX1G5XKZNlegjxTIOYCr+ciYKRB5cytiwvgna5GT44rbVPwgm0AjnPEL5x6onYReJ
         msSDpxT4JzxaTlPvGM7nAW9i1e4QNWmViusArjF5kpptAwhIWsq38ogXbwssKyNB8l3N
         JiiA==
X-Forwarded-Encrypted: i=1; AJvYcCWxj8leGOE0hYORg7KbdYYpj2muJYRerOeFEif64UXhKPWuVhUS5eiIbbvLgz4hI4+G1fERFW+siGXd1pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDu1ahOurbjyaD6POAiQMCtQddNB5y8YjYM/yPBErpTtynO+C
	lGpHJc+ovfDGDe79How80pLe1mAYDrq6wjnNQ2+3qQb3HyJgp+hDkGCd94Ruc18LCik=
X-Gm-Gg: ASbGncu+5QRC0UCrovkcFI+W72fKbvKAnBBs0My9tL6jOeF6/KXrE7YxxwZ8XuMaoxX
	HfqG3C8dmJOnThRwtQ6WzErTsafqd1BozRKB5RLkCvMj3YI2WBQYGiJey/Mo8D7QE3yRgiTvYIh
	8cpXFf64ZuKN+PIvFhV65HEe0OKbmWuvHrcsLsAIytX98QT3mMkwLBrPOs4mr33pmKB1NmeGTgx
	9hSBFlvOPnfjfZ8kkQAxrqoYcPddXp9iZdhpdPbXVtP02F1vJjJK7YxGRHtkELflOaW4tc+aiHa
	tC4gpHpG6bD/HmKNX+pv3Ue950upS5tFktHaR+blREXIjYhvuOE30tz0m+UpZANEBL8iOACTB6e
	Fo1VvPW4uw6xGG8w0fAap06Dctwy8SynM6CVVlxNK/A==
X-Google-Smtp-Source: AGHT+IEOSfILcG9gkykewKvy4dyQpZ/6LjMM3OZLq4alndr+S6qX1BPsy940UsDGx+W57yjmAUHP5w==
X-Received: by 2002:ac8:7d85:0:b0:477:64b0:6a21 with SMTP id d75a77b69052e-4a73c50a741mr165042891cf.23.1750090914508;
        Mon, 16 Jun 2025 09:21:54 -0700 (PDT)
Received: from localhost.localdomain (syn-184-074-055-142.biz.spectrum.com. [184.74.55.142])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4a72a5298f2sm50952041cf.80.2025.06.16.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:21:54 -0700 (PDT)
From: Robert Cross <quantumcross@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Robert Cross <quantumcross@gmail.com>
Subject: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
Date: Mon, 16 Jun 2025 12:20:25 -0400
Message-Id: <20250616162023.2795566-1-quantumcross@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Sorry this is my second attempt, I fixed my email client)

I was trying to enable external SMI on a mv88e6176.
mv88e6390_g2_scratch_gpio_set_smi() would return -EBUSY when checking
the scratch register Config DATA2 p0 mode to ensure that the external
smi pins are free, but on my device, bit 4 of p0_mode was always 1,
even if the port was completely disabled.

Unless someone with the datasheet can prove me wrong, I believe that
at least for the 6176, the mode mask here is 3 bits wide, and the
fourth bit is irrelevant or reserved.

To fix this, I add a field in mv88e6xxx_info to denote a
p0_mode_mask_override to use. If this is set to the default
value of 0, then the definition of
MV88E6352_G2_SCRATCH_CONFIG_DATA2_P0_MODE_MASK will be used as normal.

I can confirm that this allows me to use external smi on my mv88e6176!

Fixes: 2510babcfaf0 ("net: dsa: mv88e6xxx: scratch registers and external MDIO pins")
Signed-off-by: Robert Cross <quantumcross@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c            | 1 +
 drivers/net/dsa/mv88e6xxx/chip.h            | 7 +++++++
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 7 ++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 2281d6ab8c9ab..0fe7b6fc7016c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6013,6 +6013,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ops = &mv88e6176_ops,
+		.p0_mode_mask_override = 0x7,
 	},
 
 	[MV88E6185] = {
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 7d00482f53a3b..6307c225ce94c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -178,6 +178,13 @@ struct mv88e6xxx_info {
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
 	unsigned int internal_phys_offset;
+
+	/* Some chips use 3 bits for the port mode in scratch
+         * register CONFIG Data2.
+         * If this is set to 0x0, it will use the default mask of
+         * MV88E6352_G2_SCRATCH_CONFIG_DATA2_P0_MODE_MASK
+         */
+	u8 p0_mode_mask_override;
 };
 
 struct mv88e6xxx_atu_entry {
diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index 53a6d3ed63b32..7f1657eba7a4e 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -255,6 +255,7 @@ int mv88e6390_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 	int config_data1 = MV88E6352_G2_SCRATCH_CONFIG_DATA1;
 	int config_data2 = MV88E6352_G2_SCRATCH_CONFIG_DATA2;
 	bool no_cpu;
+	u8 p0_mode_mask;
 	u8 p0_mode;
 	int err;
 	u8 val;
@@ -263,7 +264,11 @@ int mv88e6390_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 	if (err)
 		return err;
 
-	p0_mode = val & MV88E6352_G2_SCRATCH_CONFIG_DATA2_P0_MODE_MASK;
+	p0_mode_mask = chip->info->p0_mode_mask_override;
+	if( p0_mode_mask == 0x0) {
+		p0_mode_mask = MV88E6352_G2_SCRATCH_CONFIG_DATA2_P0_MODE_MASK;
+	}
+	p0_mode = val & p0_mode_mask;
 
 	if (p0_mode == 0x01 || p0_mode == 0x02)
 		return -EBUSY;
-- 
2.39.5


