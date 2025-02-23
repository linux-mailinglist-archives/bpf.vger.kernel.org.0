Return-Path: <bpf+bounces-52272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD50A40FE2
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9FC3B6E0C
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34A15886C;
	Sun, 23 Feb 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyfZG0Xq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7D1411DE;
	Sun, 23 Feb 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329016; cv=none; b=Ejmx1oaS82IdH9AgpIEKw/qpVzmH7qOrHDNJzQebuwjii8vOCGymNfCTVVj6gI6jbTkQ/jkseGsdxmpyAsYGT2J5XxJAxDAIabu/+gCHYPmue5aFYrj0VyjnPNYVeUzhd3oTqWeuxqP5gfX1RXebkJlEkLyPYDO0p5z3pHT/yqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329016; c=relaxed/simple;
	bh=090s4Ovpl+A5aROx9Sbb2Y+qxVciWEvZposjEggOoUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5C0l2hbOaafyRVjOnqLoXS0MsX/dyLmUOxIkpbOyiRN/Lw3ksnC5IaTKSWe+6QqpsVS1uVEA+eDUx69fq49/6+9mRZCUcf0huN6ZzSxanW6AdDRuAWDrJs/iaxEyRKDuacCwXjh9lwwIxRQIx4Q5OGvto3KJrzDluml+kWjTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyfZG0Xq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c2a87378so61384815ad.1;
        Sun, 23 Feb 2025 08:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329014; x=1740933814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ7uyC7/exlluLKkDx5P6Zr0yOli/KDaWMiD/A1Io8w=;
        b=iyfZG0XqaBs1MjoxkMddkcRwbf7kSoMFC1zG3W02EKxfB+o1Jp+vD6q7whfyCYA12v
         6mxV35+D82fqynspjP5NfXKmdvvhsPRSPfwthshrZhzwAts7YhxhzXJr1A7A00+uq4SF
         7k6yZvQmrswme7r1gLZLfJlnvnLNmLsmCXzDj8ROCTT6ohM87/HSJFKn53HQlGz7safB
         /rLZbThr0U0OOpbgQXdEzjWuwHieIJwnwVs5wu5WF49gHBbTDdJFBv6o1QvbOdpTdtd7
         LN3txgD1pRLWDfETIWeNYVSyg/nvZG5y7OVy8eTff33ywVjjzfMEMRTCnvEbn9PRNWFn
         wg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329014; x=1740933814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ7uyC7/exlluLKkDx5P6Zr0yOli/KDaWMiD/A1Io8w=;
        b=SIRi99hzq4p4a+l7XpiqcWL6peXLfciaAsUwSb5xzX4Cx25cXrl15jPwSIK1T47PFV
         6TEaakVzq3wSnG6SSmac1ctGL6fuGx+k+bQj5LCUQt5onA7np+Z9SU+23I/pawrLSEpg
         +0s0DoXl54/YOGfFk/FykcvH1woFtlri0YtaIChRefd33HkFJHREhnTmUtX5n74/CJDY
         AQ7a1xUzmIWCUVzxqhIzxlGWed/RrwTVNjcbioEZM40zX8JmRmmEhekw8fMR5XGDrpMZ
         KBuTqdbrQ06LwLvN5bI/Go0h07/05WItn0qHrNvOUSCtaaDzOk6bDA7dWkGc3gXhqu3f
         SsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3W+I3bIrTcjgFXHOPxzRsilUWmmodLwNnkvY+/gcVH0lNfEMDRUsvX0h3XGXNMygOfqmjntZHTWuPfew=@vger.kernel.org, AJvYcCUK/qSFOcO5h/qRmxeWCz/7JImpmwV+Tx/QcZhOJ/n/UlAdailrpPiTY9NdbiwrJLiUEhykoD5PYf0mjc3A@vger.kernel.org, AJvYcCUNO2IshK6LYZETi1i9gyVHCU5D+Y7hwqKl5VjRUPgdn9m9pFRKZ1mrbMc7OX8+GgZcmt6xNaXmNc8K7ryukD4=@vger.kernel.org, AJvYcCUl6lR/whG71J520Nca84FGj6tWf9ONO7VVSc3A7MUNHlKOHycfCyindoD/eRQ077YnyVy4knbw@vger.kernel.org, AJvYcCVXL2YUrwgUECmTS3a3cazGPKwKi2/QYfERno2kuQ7I+tts6oOLsjgrsE8NAnxOXgQFXP0eAXQSfKyCHYg=@vger.kernel.org, AJvYcCVmff/MA38timfkUDAN+C1yaRzqAeuWDZ0Pc1qA7zEiYP8wn3wT3IL+KG7W6aUJ5Hs+e4N8zsqe5ln7hnqa@vger.kernel.org, AJvYcCXBZUkgzlqvJZvVWUc5pYZk39ouBJUbAsJziCaCW8fCfEkMRrxmfIkmlfOAHk8iuPeU8Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhBJy+678ebhk+rL+NFZj71kDq2xi+jSvSa12wU430oVpz9aL
	sdDkLkyVrZiEq4RpMC65tCENIcCiITws3Ac1p6LPptnOjxQsUWFo
X-Gm-Gg: ASbGnctr2Vdd4kZQJeRo2/bZuqpcAXhMx40E1sjtVLNjAeu0oNE2bf2whlDZ1EqK6Az
	ViQJ0rzCDfzA4eLH0Cybt8HhzRulHfC9IuDyhQ/iuTYgod3dZjJeosFSUJbwdrH5YF2n+kh4P8r
	IPKNoZk4g2/HAlCAbtr/liBJK4XT+QTcWiIFt76Ka7GF796V8aBwRPJbUV9bi+oZ9FA0CpDClZ2
	UCaZcpbi07VdJkh4pJ9ymRfhxvHu0k5JAGMqR9L0ob9eXIHlNnZJIAyjJ677ZuwMIUFpXoIAdvO
	Uq9dfuFR+wdKRpLkhf3+kQIdgb1efwsgPIrPPg1zi2JcgnONDWYNf5b4
X-Google-Smtp-Source: AGHT+IGEf83VZ2oIxRJRK+CnkiI3bN9hJqE3s48Hx05CleZdaHJAPpPthd1i56ltfHnEYIca1Ehjjg==
X-Received: by 2002:a05:6a21:394c:b0:1ee:cdda:b8ea with SMTP id adf61e73a8af0-1eef52f7d5fmr16011633637.19.1740329014620;
        Sun, 23 Feb 2025 08:43:34 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:43:34 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	jk@ozlabs.org,
	joel@jms.id.au,
	eajames@linux.ibm.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.torokhov@gmail.com,
	mchehab@kernel.org,
	awalls@md.metrocast.net,
	hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	louis.peens@corigine.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	parthiban.veerasooran@microchip.com,
	arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	yury.norov@gmail.com,
	akpm@linux-foundation.org
Cc: hpa@zytor.com,
	alistair@popple.id.au,
	linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-serial@vger.kernel.org,
	bpf@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH 04/17] media: media/test_drivers: Replace open-coded parity calculation with parity8()
Date: Mon, 24 Feb 2025 00:42:04 +0800
Message-Id: <20250223164217.2139331-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223164217.2139331-1-visitorckw@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/media/test-drivers/vivid/vivid-vbi-gen.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
index 70a4024d461e..90fafa533ccd 100644
--- a/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
+++ b/drivers/media/test-drivers/vivid/vivid-vbi-gen.c
@@ -5,6 +5,7 @@
  * Copyright 2014 Cisco Systems, Inc. and/or its affiliates. All rights reserved.
  */
 
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
@@ -165,12 +166,7 @@ static const u8 vivid_cc_sequence2[30] = {
 
 static u8 calc_parity(u8 val)
 {
-	unsigned i;
-	unsigned tot = 0;
-
-	for (i = 0; i < 7; i++)
-		tot += (val & (1 << i)) ? 1 : 0;
-	return val | ((tot & 1) ? 0 : 0x80);
+	return val | ((parity8(val)) ? 0 : 0x80);
 }
 
 static void vivid_vbi_gen_set_time_of_day(u8 *packet)
-- 
2.34.1


