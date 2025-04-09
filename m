Return-Path: <bpf+bounces-55540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3DA82B9D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B5C9A80E7
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D126E143;
	Wed,  9 Apr 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp5neykf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA95268FF4;
	Wed,  9 Apr 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213515; cv=none; b=RWlG4ZELquys+etRNx1GW0UokW5wLPPi3dieGcuaU0IeBlpCG9zLLJvERAtKSFYhh0QX+/nZQn2dS4fo5DIThq0mZlG/gbG6nfNsyRY85LWN8C3djGekbVk/fM052wcxH3JnqeJGKceUOD2HoJ2QVPfHba7ecIWKExJ8+lTELl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213515; c=relaxed/simple;
	bh=K0cAwDEVmURUDqUksW8EcGktpkwwMicB1j4NdDMd+qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EG7HahJMy5uEswSSTS0UxAz99MemAmWKo/HqgOnCAZF+5eq59HXTj7lFb/xet8VQchGXEANTDQLYUp7gvvwUR5GhP5FAmPeC44rvSlfUEnqeZ3dD33VCwNzyFImTCeGtdTF6XEdumUwMJE7cc9xkBaY5x/Z5eGzOOunV/p9JRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp5neykf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so5428840a91.1;
        Wed, 09 Apr 2025 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213513; x=1744818313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vmckaFkj9v1ziFLew45kxKFqGeGwuFVGwp5LAE34T4=;
        b=Yp5neykfhTG0SHt2a7y3GvtiN8o0sZoy0Q1IxBIKAAort5+PNOBMwqT01t/kGWPA6r
         rU6k2PjfJRSwNFohdChg+ni6HD0WgTpaGb8AEvS0UqmJE19vqbjtUU2yjIzZRElFXl1N
         Ka8TlYzmrufh9pQ4HTu4RNLosHVmB+e7HtByyhi5dGRl4kEhAQyENDGf2nSMePbipKnx
         UQGMKoecLeDNk+wOpsfjjAgo5m7S8wxN8+BkHMC2EkG6ozAsHUXKqa1ek3D9MKP89tSL
         fuUmnfD6w6z0MoQ1o12/IIKWOCRactbWr2WGbfXcJ7V0GuEwIrGF1161+1sfHr0Ugtck
         Lw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213513; x=1744818313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vmckaFkj9v1ziFLew45kxKFqGeGwuFVGwp5LAE34T4=;
        b=UuBeuuzWDb/HWtMSizY0SRYSRBnRRUnzwoHaw1GvsAU4QsWEqjGxh8QtlH5fUnDzbm
         hQCarK0ivsnGzyhQWTXXOuxw7v+zIbKToCRH2+IPSkINcG4Zjezo1H4wq3SCgFyHam5K
         h1FPaHqF84tm0b5kl/xAjggQoM3dje4p4D8uSf3m7HoToO9VqYdrXjVq3Re6ukuP9AyB
         hpbryIG78opEENHe2MWBNY0m32lOEmBNcihraKyXXZ1w1ndL9r8kLgQPl3gR+d0WKIJr
         x43ASo+8oE3e2oWyH+J/qsxSC8k4UXndN9UKyPllBqLUF5tCZfyUeEyWt4MY9rvSBmtp
         7NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCULa3qIUkuVjfMMQuN4kHFDle4wFMu+QyAtSXj02d45FE5Eha8l+A9lnlnrqZrZbuVfvkIA0Vy7Ra3xglI=@vger.kernel.org, AJvYcCUoQBCMxXywFm4IML7ls0qo5+IDipmJbrpouaZ9KTJOfvKKwdMsjdni0OoDyryUE6BYM+4=@vger.kernel.org, AJvYcCUqqdVzJ+flURfiIeQNWvOj5HxrKlNFeu6/EK2BH6CrYbCTmCOjTaqFCddKcU+Yh+s+jGwiHvMLTsUvRUo=@vger.kernel.org, AJvYcCWBqtKS/nli2oYvbH+UfeqY6UKE5UbPNMLC9BVembZvl4wEGzVE9z2LUFJT9259j2jj5wuwEqKkhU0S55BR93E=@vger.kernel.org, AJvYcCWCT0d5/wRAxwRlajjU8k/Rm2gJnmlAdQj9RF9fV7jmF+B97833a8FouvcMWQ3hWuwYtHO5UN3dZFNv9brf@vger.kernel.org, AJvYcCXLNAxrS/WEOwyIF2nt6FxWdqGpvGVp7TFr+aKyaCmA86QhgPDGKP0QBEiR88OezUYzAXpM4ekS@vger.kernel.org, AJvYcCXT7TaJq84nHcXc78Cn3z2Ul0ox9L65QT5I+trT6+4odPxrl3IHhJyKXc8szVHwx/L/JMw+wNOkgLARBgc=@vger.kernel.org, AJvYcCXWigFXP54oyv76pkkuIf0qt6p0nac5S8AYQnuFzr/+GnqByv/0rcjSEI/K+2AiVzvkxyFhGRGg4Aj9dKzv@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSdGkFTP/iJCKsYnAW0dLFcaIoXLzEI9sfKqvkuQ4hTASvJpU
	URF4vtI9iY4MTwXU3cdBxZdnWf5odWTaCbuSMzCXu08vk0Q7WE81
X-Gm-Gg: ASbGncuiorhqT01/DW1OqWxcpv75CHYqBXtc/jeJNOY6vEx1OwnGO/XgwqZcCdMTkCT
	WYj202+kLCF7EELxZ0ssgICrE6G7H3tdUg0CXJyzFhVfaNKiZhcLp7h9S3E19nfDX15YK8eDdry
	Q29AnCQ4v0skQx80iEYVLDKynYPT3SDqhXl89IIBPWsHEQ4x9gGgancKpRTs6rXkdzmz7qPWIFM
	lpRlIycdAQUS48lOfFWSD53qt9W8o+ANgS9E5kMswWEFvvFma3e83EwK3US4EdiuFvqFZ/Pv4W3
	57/QoiPpPWL0wpjOq2EWSRphLZqvbG0BkhbbuvG0HaA8GKC563HR1p8Xs3Vqh5sFlAPY5II=
X-Google-Smtp-Source: AGHT+IFGakXWHWi8mPXKxnYyjY+QGe+hrJ1DKxm8mqQTtmCR5lZ2ol4+lqNevSMOwq7LjWocz+r/eA==
X-Received: by 2002:a17:90a:da88:b0:2f9:c139:b61f with SMTP id 98e67ed59e1d1-306dbbb557amr5410743a91.14.1744213513621;
        Wed, 09 Apr 2025 08:45:13 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:45:13 -0700 (PDT)
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
Subject: [PATCH v4 04/13] media: saa7115: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:47 +0800
Message-Id: <20250409154356.423512-5-visitorckw@gmail.com>
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
 drivers/media/i2c/saa7115.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/saa7115.c b/drivers/media/i2c/saa7115.c
index a1c71187e773..a7886269dcfc 100644
--- a/drivers/media/i2c/saa7115.c
+++ b/drivers/media/i2c/saa7115.c
@@ -25,6 +25,7 @@
 
 #include "saa711x_regs.h"
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -664,15 +665,6 @@ static const unsigned char saa7115_init_misc[] = {
 	0x00, 0x00
 };
 
-static int saa711x_odd_parity(u8 c)
-{
-	c ^= (c >> 4);
-	c ^= (c >> 2);
-	c ^= (c >> 1);
-
-	return c & 1;
-}
-
 static int saa711x_decode_vps(u8 *dst, u8 *p)
 {
 	static const u8 biphase_tbl[] = {
@@ -1227,7 +1219,7 @@ static int saa711x_decode_vbi_line(struct v4l2_subdev *sd, struct v4l2_decode_vb
 		vbi->type = V4L2_SLICED_TELETEXT_B;
 		break;
 	case 4:
-		if (!saa711x_odd_parity(p[0]) || !saa711x_odd_parity(p[1]))
+		if (!parity_odd(p[0]) || !parity_odd(p[1]))
 			return 0;
 		vbi->type = V4L2_SLICED_CAPTION_525;
 		break;
-- 
2.34.1


