Return-Path: <bpf+bounces-55541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED35A82B40
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F27217EA98
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276526FA4F;
	Wed,  9 Apr 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwx4GzSW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE73264626;
	Wed,  9 Apr 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213529; cv=none; b=kfyFEIlkwWGuYH8hklY1PrXCKPD2ZYYlrjqdYZpkZ8vgH6rQJwwyF+EF83eM20FVhqZSS4OPknGordB3oFov1kmrbppYAxbbKLpT/TGyO9t76sbYmWDgq6h5C9UwkJWlroa17pzRj/u/tzu2uhtyDTZ0j0ELlYZsv+xrwYDodQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213529; c=relaxed/simple;
	bh=jkjX77x+yr1fdHrJPGX688zF46uEgQ4FpItcHmWaXzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qOA7AsqbFWsrBMAmNj1nIOYSzCUmkrVz4X5yzp7F+L8PafP/xa+uA69f/qZsMTMgoJLAeBj/U7TX968/5jA/AmexDw9e6uKNZy0h23169UJzxwd0VeF7WuAsEqvXVxGEpjl1Kc766JR7BCIWzgYjT/Mi2e5cwfwzeGlTX2w6Tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jwx4GzSW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af6b02d9e5eso4882001a12.0;
        Wed, 09 Apr 2025 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213527; x=1744818327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUZBDj1ge3+4V9XGnjqkyMjyFYeNbBPtxuQpoO8Pkmo=;
        b=Jwx4GzSWKVoAMYuvxL1oFBashdRJfPsc1Y46XwiuMl0Zq46nNMxK1GQsBzEATCsI1o
         5I38VxZHPWlHvYL5rV417U067Fngva4xvUR2KhjU8pVev68tOZRAac0Ck9s642u5mJUm
         BlzmRkhFKM9COpBrHa1eJAI6mq8Uo2Pa+LGXLOL1J7ixV1Vy0/jIxfn2MFqpzNqnr4CO
         ahD4wXGSQPAvOFlm1LCENlngI8dJchp93QMyLnmN3X6TKHY42V0DrJTCCk9NgKj07xe3
         Ox4O/Mlq8d/9KvxZfMTC9aobBzNEMsI/SaOKEcv3003N3kRhieVrtCkYKj8Yfdc/6ukG
         kR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213527; x=1744818327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUZBDj1ge3+4V9XGnjqkyMjyFYeNbBPtxuQpoO8Pkmo=;
        b=tO6l9ADceb7ksduzC67t9aWbUHBOAJ2rfxDV6pJmnuZQw5BZJy3LWPBTgKb8YJlC/q
         6x1tAzEFJFA8JmkKFeM9Um+gpwfTrIQo8+1qcR9R0cKyTSKOWsdfY38820md4MdyIFx4
         ZIGaA9ZQX38+zRErW0NHMsvEkq/MK+Twxo45FizPMLkJybzYNWSn55v9faAG9rNsaw3v
         LUF0ns7KhpDcIx6+oGApvGKylpjofutyL+t+SqbdJvvJdSqFV5TRRxxb+ayNdMe5vrLp
         8qrH8N8t5hQrKviAor5rhT9vaOWzIp6MeZzHSeq45Faq8KeFzoQ6Ahd5A2iXC+p8WAMl
         qCRw==
X-Forwarded-Encrypted: i=1; AJvYcCUIrRVS0d9gJLXkXTpWNH/47iXnNewq5/kfmTlIJ1xErVD8jUJTZ0tbX5AIovhmN0XyovWkWGbE5RGVOc+O@vger.kernel.org, AJvYcCVCKLJpTFFdqJNUpuSL4afjdhKSStMRfzYDTWN+N+40uWnBg6eWE95OxdaYh/SvcVnVmkq+VYHHAGFJEPY=@vger.kernel.org, AJvYcCVWDPrcGSBqvXn6EksbD+sGqbszUCMBTErgxCV3SWjzlfywMzZNcLGU0WuYF+Ua/YKow0w=@vger.kernel.org, AJvYcCVciIRnoVBAXxv86W2dv+3ZVxJpYn4qpf/dxRw+TdQuztmuOKi0UySfi7shAarLK8zgyczRsMD9/TEi2tk3wsA=@vger.kernel.org, AJvYcCWR28KIV3cT4oRurZaY8e0gwExtDUUkVP9+FYCa1ci2UetFO+0WUskOOwCFlF4/byUM/NQHJ+m/g9KCBOY=@vger.kernel.org, AJvYcCWup+1p0mZCh8m85Ejfuwo1R2ktDXgG4MFx0ylvrxjYWr3cq73SOqkZ8ncY14Ozoi3MJLmu/tcs@vger.kernel.org, AJvYcCXXNIe5dEdEeUHZdls4cUHs4raaugyhL1n8SfDmwZA0zTqS8gHsbJCjO2Qp2aHWQTqZJHnkqmjAbfdesPk4@vger.kernel.org, AJvYcCXj2ii+pY6S0ssIB+9VttiErAIh2jdOzN9aUKkFKoUDngMfP91jgDE9q/EEw99APFmLjpRSNhZeg1WojX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfB0CIZ/iVzZi83GOcsFt7/ZcRr01VaX3BT3+wxmK8vXGXMU8y
	k+5T1O0iW2llSKxh7v23FCzH73Mr8Ha+Ex0cMoCQZ6lxLNdaNEpJ
X-Gm-Gg: ASbGncuEhqpFUU2whkL683vDSQqL7bU1lqc5KijEuf7Pwa2pE2pNIjBpFEnLA6LqoCO
	ONMsqOId2C8A4Glzjv5CezgHaegxtzlHyCX3Me7Bums7rsghRLQgll0LqCVxoHHU1F+q2goTYD3
	5JOBbsD2TA1Ub2tkEKdhDK74vk/IwsjWIFHY8vF9Uitcnbg1Hf4s0Pmjgk7POpbpFVMMU7StOSy
	lvDr+YVLvI8/vSw3gX0yQO8lD9MVVgdeC42s6JtJxioDBDPv2kzD8AnMfYfeNHYmFEWiPd0tQA8
	eOkPHfwBXbDgYoJcFbSSG+YL7/X+2gR2d6gmAt+810TUUMlahYv885YjIuSLKTNdeNnnAig=
X-Google-Smtp-Source: AGHT+IGnNb2L5TPy8ZRk67DQoWNz3EnKr3D/3b81/wzKSzl4+H+Bebt+R4hGqZaj7Jkg168nL9a84w==
X-Received: by 2002:a17:90b:2e4b:b0:2eb:140d:f6df with SMTP id 98e67ed59e1d1-306dd3247b3mr3471228a91.1.1744213526748;
        Wed, 09 Apr 2025 08:45:26 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:45:26 -0700 (PDT)
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
	akpm@linux-foundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	alexandre.belloni@bootlin.com,
	pgaj@cadence.com
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
	Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com,
	andrew.cooper3@citrix.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH v4 05/13] serial: max3100: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:48 +0800
Message-Id: <20250409154356.423512-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409154356.423512-1-visitorckw@gmail.com>
References: <20250409154356.423512-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity_odd() helper.
This change eliminates redundant implementations.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/tty/serial/max3100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index f2dd83692b2c..36ed41eef7b1 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -16,6 +16,7 @@
 /* 4 MAX3100s should be enough for everyone */
 #define MAX_MAX3100 4
 
+#include <linux/bitops.h>
 #include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -133,7 +134,7 @@ static int max3100_do_parity(struct max3100_port *s, u16 c)
 	else
 		c &= 0xff;
 
-	parity = parity ^ (hweight8(c) & 1);
+	parity = parity ^ parity_odd(c);
 	return parity;
 }
 
-- 
2.34.1


