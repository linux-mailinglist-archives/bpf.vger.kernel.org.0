Return-Path: <bpf+bounces-52963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524FA4ABAB
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6354318953A6
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6901E0E11;
	Sat,  1 Mar 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3ndEQJC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B51E0DB0;
	Sat,  1 Mar 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839117; cv=none; b=gNoAk6/cQSX19VzRQSTM5GUOmNgdFqYvEr+m55EMCxwuHbavA+vCSHI6mui0AiKG7IawU8gp1L4QeVZIVa+IPBPmNg+k25kVK38KoKI9YHrFE4GZGvR7H1aKUTTcb9+BLLxCWowmFNzlkXR9V3Z9fkJa0QOoOt6z+r6GxSs5jEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839117; c=relaxed/simple;
	bh=cIgJmn96AbC/m2stobLaS3QgXAnH7idqnvJn+4l7pgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocXxjKUPNZHYxDb8C6vxQNaT+W2BQnHlJjgtomRM74F0nwtAKA8iMJISAPxI3TOInouHWCKFT1lRTuC3cGI2ScnyJ2r16d82IZzJ9uB3xzFlnilosdxUAYFNNjl+cnc3VRyiAotYX5v5ZINItaR/VZLP1RznfhfpXO1EtNO57Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3ndEQJC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2239f8646f6so57445ad.2;
        Sat, 01 Mar 2025 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839115; x=1741443915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNP1gcd9iHRxzh69rYhVl4jkjT7XmE00fWzfP312xis=;
        b=i3ndEQJClmDzMWL3NOKYrEJ4gwyeV+dugWN9ELB8HKagKqg2KPmf8luEz4A3qFaUys
         yko/p+6vq8nD++wEFtdlMMdxlJGf6CjdBA8uHA573gwR1+s7FjHgnI4M4iuEbE/aqgKr
         mlSfcTRXaQNXuBEp3CEttHLdQApbgvY3UW+s81l+uKweh6JyJF6fWv/Cejcyts3vCff/
         KnQ3WgVLSYTUmY1IOsz+5LWO75eLBU4mJH52WzF+XSfd8ziL48DQ8fI1i+9a7M0dI6pf
         h+c1lG/nALmM2hIUeQjnAOR3k9J+zU7OhOkfAlZGcomKZTK8gtm6LuzoGua/dWVCB98E
         zcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839115; x=1741443915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNP1gcd9iHRxzh69rYhVl4jkjT7XmE00fWzfP312xis=;
        b=nzL0UKzKgXsh+dXNjnAjYd66d4t6HTyIzkWvdCLdZJNX9nZ4Jt6084QnthQecnZHkE
         eXs+dDCvO5hvysHYn1XFry+F0c+nE4K4n6HQbCzWh0ZurwYLxtc2pJeck+2aRzuOZkGq
         54QZrrLvY7cZEmXu0YEqIN4k6a5PAlQCGZw7SfzJljPNzuTCAXjIAw54lROnBZ+WZZ6U
         teiFfTqPtFunaNHJsbsJydSL5VAtjEo8HkKUIVHhWIMKCGclo6E1v6Wk6as3vOMntK78
         RfksWeqU5O2bPCyFq73e4PVeuEnfCSE/c0ApOw5TbaQ/2u4iVdZH/GBMMJqSB5mVZNvH
         qA4w==
X-Forwarded-Encrypted: i=1; AJvYcCUioUEt7t7V7c/ZwCt/tPaua6oJmIReFKpkTIvYWgBL0iKfE8QYLx+nZaWN9na1/g7q7shg3ZC4cLbl49Ozgnw=@vger.kernel.org, AJvYcCV/VBIPZ9qQ0vzEuZPv5F97aQQ9rk02srOoMrdcnJfZh16bs9sdKNSqZ6POha5SM8g6QVHyhUkBXUuWxVU=@vger.kernel.org, AJvYcCVTVbxgZeKEVpZvZo0xqZLqe/ti61NbQ6wZCWHwfQS5QGe5lDvRDkOCWNQ6Ymt0hBy5tM2Xpm0vZujEw3E=@vger.kernel.org, AJvYcCVr5yb25BL70ZfQQU1f+BAhXQCs5J/B32dxDr383DaxTl8jpQLhXtezWIV4tcWXBoUQ4Ok=@vger.kernel.org, AJvYcCWhqIm2y/pfqo0w+XbakgaGQwVpgopTl7lhLa7lwc9BZXRXSi0LRdJAca6JFQGXxJZClfU+nyBkhFR4bwfP@vger.kernel.org, AJvYcCXUxRZ9d8ig+DZIocM7n7Hn3Exh1W1FvcVxHkyVuRDo/oZ8Q7ZmRaY9Wlo3pSv6aZOA69nQb7r5@vger.kernel.org, AJvYcCXmNUbVm1Iu/xszePIt0idmKi1dwOki2eCNT5hcSTPA6q1RNy3yH434ahHVn4fHKTW/OYkAU7MTGBf3I3H1@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKu5mdP09HZDzmhGHMiNlt3oKwdbjsKlMHfqOiHjrfo46Xx3O
	b1mX7y+0hYLP53Dizsqb5KvQW5gkvUSeXgujrL6Ce5Ji6iqvbBkm
X-Gm-Gg: ASbGncvIRE7m57OKmUjcluZ342g8I6mAzBzMtTCH5vAz4t15kR1bDCeoMUGNM9gXOmn
	7RcYhQ7wDWuMAWUQYyW+G4yvqdLuUYt5Tczz9HwfM2nPpHLWqhbKP5NuHQKzqq2XDviOUtZr6v8
	6MGM3wmFMyIoSf/B8ppn4F+aTNIjpwoIgb9vET9nbca65Rtl9ctVuJQxN7Pl2d/qN6rqM5Ibbo2
	wtwRAE3OvHGMJ4SsW/+Ct4DLN+4JrFZj0UJBCdmn9vfGgZpZEReUIO4YxH3qjGDpqcGOzq+/OsK
	HVAwhjXwhpG/LLaFnbLArbLVCNjoX1APvWYmVTww3tgWGg+e010QmJQ2U57g2lcVrrN6gkYHCas
	=
X-Google-Smtp-Source: AGHT+IFmQ7+Wt4EJx82M81pMqmqG6vjS1UaCqAsjmQIBhBcvOofXBIwpdWFf7GWkoh7LWsBn9NTlfg==
X-Received: by 2002:a17:902:c948:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2236920765bmr101611195ad.42.1740839114994;
        Sat, 01 Mar 2025 06:25:14 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:25:14 -0800 (PST)
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
	david.laight.linux@gmail.com,
	andrew.cooper3@citrix.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH v2 00/18] Introduce and use generic parity16/32/64 helper
Date: Sat,  1 Mar 2025 22:23:51 +0800
Message-Id: <20250301142409.2513835-1-visitorckw@gmail.com>
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

This patch series is based on next-20250228.

Changes in v2:
- Provide fallback functions for __builtin_parity() when the compiler
  decides not to inline it
- Use __builtin_parity() when no architecture-specific implementation
  is available
- Optimize for constant folding when val is a compile-time constant
- Add a generic parity() macro
- Drop the x86 bootflag conversion patch since it has been merged into
  the tip tree

Kuan-Wei Chiu (18):
  lib/parity: Add __builtin_parity() fallback implementations
  bitops: Optimize parity8() using __builtin_parity()
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
  bitops: Add parity() macro for automatic type-based selection

 drivers/fsi/fsi-master-i2cr.c                 |  18 +--
 .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   |   8 +-
 drivers/input/joystick/grip_mp.c              |  17 +--
 drivers/input/joystick/sidewinder.c           |  24 +---
 drivers/media/i2c/saa7115.c                   |  12 +-
 drivers/media/pci/cx18/cx18-av-vbi.c          |  12 +-
 .../media/test-drivers/vivid/vivid-vbi-gen.c  |   8 +-
 drivers/mtd/ssfdc.c                           |  17 +--
 drivers/net/ethernet/netronome/nfp/nfp_asm.c  |   7 +-
 drivers/net/ethernet/oa_tc6.c                 |  19 +--
 .../broadcom/brcm80211/brcmsmac/dma.c         |  16 +--
 drivers/tty/serial/max3100.c                  |   3 +-
 include/linux/bitops.h                        | 115 ++++++++++++++++--
 lib/Makefile                                  |   2 +-
 lib/bch.c                                     |  14 +--
 lib/parity.c                                  |  48 ++++++++
 16 files changed, 185 insertions(+), 155 deletions(-)
 create mode 100644 lib/parity.c

-- 
2.34.1


