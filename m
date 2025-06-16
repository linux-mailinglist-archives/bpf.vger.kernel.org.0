Return-Path: <bpf+bounces-60730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2245FADB3E3
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D856B3B0455
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B60F1DF991;
	Mon, 16 Jun 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc7AwJQS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAB2BF003
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084102; cv=none; b=krLJFwVNJYc7Ivl/ern6hjoFpRnhrgE5ekKXN91kZAWpawauEAvvpiNiGhpyDk4daOmwOPljog1Rwwk9wvw5IXkY9Imbc7hssSo1HxE4Dy85MHDEIJ15kzwKNbwcZvZsjlymnO/YI5qZ3c90Jx2bfWxAoCW7W/DkrNawB6nmKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084102; c=relaxed/simple;
	bh=zog3BYZZog2MvKcRkiH16cmx3wyffyz5RWniaO9sNl4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q4RYrZaWfRoH9Pzcf9Cq8ltCaDLlk2ESUVNt0JaXUqAQRcx/2AlQC4CZx+2PnNvd3+8anQpC2550EHQS9DKRkuQGdiH+LhrR/ZZYefaZH+J6FNmEIyw3E0P99px82YVdyX5jXobbbPA6znNLrQO9eVTdeg8iG+oIvO0mwyMYvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc7AwJQS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so6864664a12.2
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084098; x=1750688898; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tJxn2opgOe+uSyt4KARpfpzWiYmCLuwDv/CzaIgWRAc=;
        b=Yc7AwJQS3qLGmdceCIdlEQDn/rW3Q0734He837GMyQPEpWH9CTeCFxQ0LazJyw3ZD2
         KdBG6KAAX1JeblJ1mBDEd0qLqgDQqmjfHEoUJv0r0u4/SRDff4LHiR9blIrG75dOpUFM
         YVpaecFFIxbEbsN/cxv+I1x1tSC6KOSxnAqjLoJR/arrRr03lRju1+rvMmzB+pyGxXfT
         J1AxbxOPCkbKrdf6Ono8GzGmWxdrGjFwxGlzuZ/vdtovmY4J4aeipAIllUrIZcdtZ1Oq
         UQnfTJUjDxTqr8ecvqKXdCchdC+zEqeu4pSZMx+65iS/Nr9XxV7SqWKoeRgxyS4FIytS
         XNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084098; x=1750688898;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJxn2opgOe+uSyt4KARpfpzWiYmCLuwDv/CzaIgWRAc=;
        b=p/TRHXkC8BtPRt/U+umMuFBZ4lpgfXwg9Qmk2skWs1ozoYRxmmZmle/wXxKm5rFgq8
         U8QhvDVQOMrU7OnDow3zlwVdhoBygZZIaUkIuvhUomhxmYVZyFPwvB4ZapHT9eF0Tv69
         iOBjx4XPZoGGmNqWky5G4wcoFWBMGPmmke9NKE3TNa940kogsoa7ghPhFlDqE7KFM9yC
         gM0XovO8o7RTrLKupFyfFIgVLCU55L1zqP3eMqJjwqDr4culkWvdiTn4krzCYzoNGlqV
         VxkG3SHvTNjsptfasEnM7xDOotIJq1jwOxC7kJpdqH0QR4vj/SllTHUpLpDVESEK1xe+
         XQBQ==
X-Gm-Message-State: AOJu0YykFYLFLZhy3QJK1hLntKO5TnAMAffTRAdkIaWbc9kl5UCBsM/A
	aJE0O52Psgd62Ev5uhOXYMrOCKE/KqHNZmBq+FgER9xhOvKrAa49faxhC2F5mgauGAh5umGZoVd
	3VYAtkTd/Di82KfC0lvG7hvXw1jzK9x8/+duDvf8=
X-Gm-Gg: ASbGncsYbflrXdAZ8UTpBVHMT1CiZE0M/OkOagRP2I9wucDcv85fBh+HbErGlliOJO9
	d9B+OH458PZMnonw9cb/2NVrkO3CnaFdOhKr6gV+atf1z5MuVRJte0jj635DhGwqVnyHBwdkt+x
	2vp4XPGWSgiarRzUVNfDXRWYamwOfwLa0vpPPZbIWPYlA=
X-Google-Smtp-Source: AGHT+IHS+E/lzWubpUb2AMXsCfenZs2pEuHv7cumHvDpCIefj4f3cFB3stgjg3VoAX9tdo9gu4AjCjft5nNy/ZSTrx8=
X-Received: by 2002:a05:6402:2813:b0:607:2a09:38dd with SMTP id
 4fb4d7f45d1cf-608d0999793mr8550350a12.18.1750084098081; Mon, 16 Jun 2025
 07:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Robert Cross <quantumcross@gmail.com>
Date: Mon, 16 Jun 2025 10:27:40 -0400
X-Gm-Features: AX0GCFuS5tAFh5wcPTMPN6AYg_sLrpL4hWyP1Pvbpun7Ouvvow7vQBTLGkR_wKA
Message-ID: <CAATNC47i3bEUScy+nJkEZpuzcLfSRPO+bexSP0ZN4Y6Mw8QHoA@mail.gmail.com>
Subject: [PATCH net] net: dsa: mv88e6xxx: fix external smi for mv88e6176
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

Fixes: 2510babcfaf0 ("net: dsa: mv88e6xxx: scratch registers and
external MDIO pins")
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
+               .p0_mode_mask_override = 0x7,
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
+       /* Some chips use 3 bits for the port mode in scratch
+         * register CONFIG Data2.
+         * If this is set to 0x0, it will use the default mask of
+         * MV88E6352_G2_SCRATCH_CONFIG_DATA2_P0_MODE_MASK
+         */
+       u8 p0_mode_mask_override;
 };

 struct mv88e6xxx_atu_entry {
diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index 53a6d3ed63b32..7f1657eba7a4e 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -255,6 +255,7 @@ int mv88e6390_g2_scratch_gpio_set_smi(struct
mv88e6xxx_chip *chip,
        int config_data1 = MV88E6352_G2_SCRATCH_CONFIG_DATA1;
        int config_data2 = MV88E6352_G2_SCRATCH_CONFIG_DATA2;
        bool no_cpu;
+       u8 p0_mode_mask;
        u8 p0_mode;
        int err;
        u8 val;
@@ -263,7 +264,11 @@ int mv88e6390_g2_scratch_gpio_set_smi(struct
mv88e6xxx_chip *chip,
        if (err)
                return err;

-       p0_mode = val & MV88E6352_G2_SCRATCH_CONFIG_DATA2_P0_MODE_MASK;
+       p0_mode_mask = chip->info->p0_mode_mask_override;
+       if( p0_mode_mask == 0x0) {
+               p0_mode_mask = MV88E6352_G2_SCRATCH_CONFIG_DATA2_P0_MODE_MASK;
+       }
+       p0_mode = val & p0_mode_mask;

        if (p0_mode == 0x01 || p0_mode == 0x02)
                return -EBUSY;
-- 
2.39.5

