Return-Path: <bpf+bounces-53471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464CEA550C9
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39C43B3BF7
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC321771E;
	Thu,  6 Mar 2025 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmj5ojKk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE52212FAA;
	Thu,  6 Mar 2025 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278360; cv=none; b=nLnyJlKSu4dAW6A6lp2iR+wS4U+V679bAkJGNKe2JPogAZbkTZzetJfc/RBAM7l5kQIzD8pjOqk/wYmH5URPQxb8s9o2ARUJBENbiNj6H8WmgYEO0BJQp/Dzo2RQO8ZIFNnzYeVugBNs59ezTT8pZ5eagPUFRc3VlGCvfRT6s2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278360; c=relaxed/simple;
	bh=X1osDnOd9IPjfmzORkmuJvIJiGkdvCzDfoi5CFuWloE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MSB5fqwmhU0aaqB0d/KSbcpKRVUplO0iMpkP8/xFdLla/lCD4HSAbtYbSdmDqWtOXvHIPMYYNiNZfee82wuqEGh1dugUSqKClr78hErWhgC2XVhQ/sjauaGoTSpmoqFZNRvaIkwlSq+9IQgrjcW/2Y5T7WcoyRrAHrUdhDgjV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmj5ojKk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso1424943a91.2;
        Thu, 06 Mar 2025 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278358; x=1741883158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1Sq6955SeW7fXdSe6bezpmzNTL9tmkfZyPLC9/YdtI=;
        b=Tmj5ojKk3Y/y3B8NDm7yycDjSt9Ieoe1fK/mJwN0EnDLY1N4fSdHpRUqmlVXrrVuBk
         J9+X7OvoSpe9NH/lF56BIj+uVsl2b6TtrqzETOUiOqHxnvQoNcpyeGFNMfL+4mPlP3RG
         19HDTQ+9qWFdRRkwlXKJXqc/JYKFMFhqmXv/sXgvHpFgCANe4Aeh2tqxBWsYyHfa6hzN
         Zs/UULXxJV5T8dbRc04CO4QREiC2xJ++R9cjjL0vUaSRke9ymGRbFTHEA6iDrZ2Tjycq
         MeOlrqBYUypicJ/fF1pXr9ZyBIAde5vg3zvVXd/pfhe+BwzWpgMGWnenHOrCfYLQHVWp
         gx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278358; x=1741883158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1Sq6955SeW7fXdSe6bezpmzNTL9tmkfZyPLC9/YdtI=;
        b=vhAugXAbiVYnasBckF1rMeqfvIVkTWNn5LiCYoDxxyLa1a/j0pdoguwtLb9Cf+0huj
         84ZUfTNtL53eOTsnepabdGp94+I/Dx4KZPQ0fVQQWNdCgfRw8PZvBnbaga26PqSOz5o/
         dIwp3gf1VkcrTh5ihUB0riJNlx2SLDzFl3307omkEwJO3365o004vQ6tI7f/J+OmM4Ml
         3NPpY+ix+YhOPtxO58aPL8fx+8JeBEhGNYCu8n/QYugobSyi8Kn9wgPhZBc5LRDLvFK4
         1Vg22xkOI5PZzaS2AgQnbr2xXpVBw6Y5zQvx4sy7MWSLG3jRrB9CGTsDhddWh9l3kJ7H
         kM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEMfPcrSxvZ/qNdWlW7I6k1KQS79bRg0Hx+Van65vV9kMbNxy7Qa5ni+i+pHN9dzkZWF8cW7TXjEEhFqk=@vger.kernel.org, AJvYcCUXXg2PVwP2z+brOFLbDp67XNYW4VC4v3NPMt+NlBCD1eQEcnTGIxNyzKs+v0wAHcVq8BJe8L0PKdlkorY/Oow=@vger.kernel.org, AJvYcCVkBRttH3Ycme1KPguOL7zfYvf7bJK/Br7PjmxGIPVq/CLCfawNF5XMRR/piAj2M0PFr7aW1IK01qpLFH0=@vger.kernel.org, AJvYcCVnej78gTmX/VUPAIS+vlvFuDsXyDBaotcjiolQlzlBd9bpr7ZWAmF2W4O/Jv3RMarVfDg=@vger.kernel.org, AJvYcCVvhGKOJ+O4M6G2xptlBq5gabWHMqmejie5GVheOoeGlqKbjzVgzXVQJcRuqVNZDk8gy597ghiC1zp1XqRS@vger.kernel.org, AJvYcCW1JEOjBNEtRD0UnSBcuWdy6pMrFiBl56o/3EPVclYTYVqBe6bcL3pIlJZ0uX21u/kbuRkl4Jt/suipic+j@vger.kernel.org, AJvYcCWpNuTTPpvkYBDBDmTaJATuKpV221TwkVCD32lzmBPegnLLnmazX5jhBK1vqeXCsPNZgoPyaonu@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqFxtc3YLM19EUlu5UtnT8jzqmxbj9h0t9S87vpCCCZ4nZRdV
	gsqT+1joPWeRkisX5yQfpoj4P2kQjOY9bKTuR9V6hXI2mbuqUQ7L
X-Gm-Gg: ASbGncunWJdw5bIvitwVAXxuJwgU2UlLQpzqQhqMjnBHrYQbpuc/P3aELgTDU5tXvNL
	pfjPH71VlyP8sfrA99U11YJETHxQg56eOhttoI+RcR0PZjeH2ZgJpC4p7U3XF2xN9obbRX8Ifuz
	WxqGOOiTeZYSEJSs4U1S9j08DLjUcgWFRtJ7HWjDnh6/puQM2Fz6ED4cocX37qao3DaQpTZJi/K
	uMVl9BD/o4t68fVo/yDnUxe16oLPRxX3jQsU9z9S0bF6rdNfCxHlg6d7Du/t+Cn9eV1SxKgMziE
	qHGmjNanmFlTJtHUOB+BBwJATlpzPkQ6pHvEkBRcuJEajRxFgPo2A4XjTTQ+JhHrCUWX4X0oros
	=
X-Google-Smtp-Source: AGHT+IHx/FA9q9VeYWlT31tM+odxs15FTKCjv2n+9fQOLwshtfFtm1FM7EynPDhqEgIZlabXqJLing==
X-Received: by 2002:a17:90b:2702:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-2ff49775b54mr11884816a91.13.1741278357585;
        Thu, 06 Mar 2025 08:25:57 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:25:56 -0800 (PST)
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
Subject: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
Date: Fri,  7 Mar 2025 00:25:25 +0800
Message-Id: <20250306162541.2633025-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several parts of the kernel contain redundant implementations of parity
calculations for 16/32/64-bit values. Introduces generic
parity16/32/64() helpers in bitops.h, providing a standardized
and optimized implementation. 

Subsequent patches refactor various kernel components to replace
open-coded parity calculations with the new helpers, reducing code
duplication and improving maintainability.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
In v3, I use parityXX() instead of the parity() macro since the
parity() macro may generate suboptimal code and requires special hacks
to make GCC happy. If anyone still prefers a single parity() macro,
please let me know.

Additionally, I changed parityXX() << y users to !!parityXX() << y
because, unlike C++, C does not guarantee that true casts to int as 1.

Changes in v3:
- Avoid using __builtin_parity.
- Change return type to bool.
- Drop parity() macro.
- Change parityXX() << y to !!parityXX() << y.


Changes in v2:
- Provide fallback functions for __builtin_parity() when the compiler
  decides not to inline it
- Use __builtin_parity() when no architecture-specific implementation
  is available
- Optimize for constant folding when val is a compile-time constant
- Add a generic parity() macro
- Drop the x86 bootflag conversion patch since it has been merged into
  the tip tree

v1: https://lore.kernel.org/lkml/20250223164217.2139331-1-visitorckw@gmail.com/
v2: https://lore.kernel.org/lkml/20250301142409.2513835-1-visitorckw@gmail.com/

Kuan-Wei Chiu (16):
  bitops: Change parity8() return type to bool
  bitops: Add parity16(), parity32(), and parity64() helpers
  media: media/test_drivers: Replace open-coded parity calculation with
    parity8()
  media: pci: cx18-av-vbi: Replace open-coded parity calculation with
    parity8()
  media: saa7115: Replace open-coded parity calculation with parity8()
  serial: max3100: Replace open-coded parity calculation with parity8()
  lib/bch: Replace open-coded parity calculation with parity32()
  Input: joystick - Replace open-coded parity calculation with
    parity32()
  net: ethernet: oa_tc6: Replace open-coded parity calculation with
    parity32()
  wifi: brcm80211: Replace open-coded parity calculation with parity32()
  drm/bridge: dw-hdmi: Replace open-coded parity calculation with
    parity32()
  mtd: ssfdc: Replace open-coded parity calculation with parity32()
  fsi: i2cr: Replace open-coded parity calculation with parity32()
  fsi: i2cr: Replace open-coded parity calculation with parity64()
  Input: joystick - Replace open-coded parity calculation with
    parity64()
  nfp: bpf: Replace open-coded parity calculation with parity64()

 drivers/fsi/fsi-master-i2cr.c                 | 18 ++-----
 .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   |  8 +--
 drivers/input/joystick/grip_mp.c              | 17 +-----
 drivers/input/joystick/sidewinder.c           | 24 ++-------
 drivers/media/i2c/saa7115.c                   | 12 +----
 drivers/media/pci/cx18/cx18-av-vbi.c          | 12 +----
 .../media/test-drivers/vivid/vivid-vbi-gen.c  |  8 +--
 drivers/mtd/ssfdc.c                           | 20 ++-----
 drivers/net/ethernet/netronome/nfp/nfp_asm.c  |  7 +--
 drivers/net/ethernet/oa_tc6.c                 | 19 ++-----
 .../broadcom/brcm80211/brcmsmac/dma.c         | 16 +-----
 drivers/tty/serial/max3100.c                  |  3 +-
 include/linux/bitops.h                        | 52 +++++++++++++++++--
 lib/bch.c                                     | 14 +----
 14 files changed, 77 insertions(+), 153 deletions(-)

-- 
2.34.1


