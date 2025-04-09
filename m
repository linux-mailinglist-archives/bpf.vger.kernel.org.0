Return-Path: <bpf+bounces-55535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A5A82B6F
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918569A2CA9
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104BB268FE6;
	Wed,  9 Apr 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3grMWA+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB025D556;
	Wed,  9 Apr 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213473; cv=none; b=F+k5zeGWqO6XobqXfGpziRvzdRFr5SmdcNvJUK0AZqbFNxLxzgHJn3gqm3VooKISDLN/pMw+O9RTjgfjUnOeUGn4EWYyKJ367HxoHQNoCga8vNlpIJ7W0qSz5rarxyuqHt8tGe5/R0wMNPKH1wgDOhnOkxorJlEZQUpd4M5YkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213473; c=relaxed/simple;
	bh=Dh2iCy49AlSFY/9nHd6Unte6BCO4NJ7RSIG0FCrmwLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FeZLPmpmC8D9uUjx5P2+6tguray0g50sPc6/U9WGxEFRh1gcrAGsp0D/LpP2wnad8NRroBpjU3M4xHpfTqDSqF4TxdFJejrS/EerufpEW6R6w4+0M2pAgwbQzXxPmn+HPhmPssooPWzm6iyEdA2LwNBNrU35e0lZh+i0arZT5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3grMWA+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af50f56b862so4885734a12.1;
        Wed, 09 Apr 2025 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213471; x=1744818271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUUuTxOiF/e6pFbiGJ55Vd+VaZOP/yQaXFZJe/XlPzE=;
        b=P3grMWA+e1iHD/x8gmr9RZaGKL+y35ts6TeeIjR2IueDnvP00TrdUPrUdzulmMe1xq
         Q5L6qoBA7p8tXyuUmSoZmbDWbPp2eccSytVL7WRGeIdRW0bE1Ko+uo3Nb9WPC4l3zNlI
         t17XGTYTHVabMOIbz8E77PKG95PQSXiNVe5Aa2/OvTh+OM0HkUxDiuyIX4bpZ0daU5nw
         3tHcwqltaImNumjvXoztsSYqsjaCd5toL7ilw3auvhdm6cE8X0pVo7gg4UFU/34lbpvG
         bJVdk81DGhBCOvRXN7RzyCp//oHgsklZjh0q8Uv3ToDWNT6XaaLgaCOw+cA6RGaTfwfv
         PWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213471; x=1744818271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUUuTxOiF/e6pFbiGJ55Vd+VaZOP/yQaXFZJe/XlPzE=;
        b=ezqe8+pyKUqnc+U7I4MsmixHZ/N62IHgLEqYlseKrBC0Sk7iR6zB45gFt7BgFK5a6i
         SlSjkiQYIUApV5GBg+BuqzMUZCKqaU98mG9iiaZ9p8uWsLloAYlDdhkbNDYiplBLKDHD
         4YU2aACzOw2DpLdC5X6+QAeshCPcA5icNfJSCcAmN2YzKBBH7zU/Lq1flvdHgdpr9zaA
         Tf0AbgyIsORSWgzwMtrOBuciPwmOxYcctVOM6sFC/gIEOm9tbnq0yf4fnaL2J4jGvShm
         sSaldz6GsCsJT23rA08oLMIJSd1hwijTyLceLyM5ut112rzKP1ZuOtAAS5ElBAx1ZnOk
         WerA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Rkn4zKLojuF+En+gCnkt7gnvUEwbig8/nXjd43ZEHWwFSLZk5AQeu/WPOvEd8AF6eM8=@vger.kernel.org, AJvYcCVVQI3aGGedKFxdxgGuSwwcDF7dQuqBIkBH3kz2rqNTfHTCkLxBFMezKczODU1Z2xQXnJ9djtHSP722oNg=@vger.kernel.org, AJvYcCVbWCGtfoH09WTi/NT7ZM0mmr/BjbwywlW1sD8VUuagcR1NoU9vLRta5StAsnO/EQZ9FdnIaQIV@vger.kernel.org, AJvYcCVt+xlNsSzhjRCzuxojTpKGdLWm2pO5n+Obb9nmffh0lIePo6CIuOnEM2H3lfPyPzsWNDEygonAjF06b3RX@vger.kernel.org, AJvYcCW1MpgD++n9SKyqcFIhRlZ4ZxXpP19nXWgGVc4nxw5ytQBjr7s6TlG+2RxtUN2tKa5NCz0kvIDbuFi1T30=@vger.kernel.org, AJvYcCW5KvcnBShGwAdqpTKairRWKZLSUXjGARoyHsF786h8xuxcanLGPzyWY+WibXG795HK3rCz1SGhrTcWxPzKP2c=@vger.kernel.org, AJvYcCX0ebyTyZ5rFwbJOV5zf12p6QcxlRVb2nT5psEFWReaqaVXL/Assea5FL22YLFv5xn6ODy4izCvnl6TqxE=@vger.kernel.org, AJvYcCXb/E3Bfte9scP4x81Ru3Bu953vgtfS3YbKzXsJypAy881Zu39OqareJY1w/8/nc9m4C2xURHmnSFbHOjZj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fQ2h9tmGG0TTbeTc9aCQDUC8VTVQBjvJpzjMxIWVN/pkC3tV
	l0F9gCb7Pf70zeuWWM4ZxEEVxFV4iOzLPthzyKGheK0T/hTbrmuh
X-Gm-Gg: ASbGnctIjBmpRRcrd3OJMiFcbxMMMyahV5tvXuLqykimg08JBYIbJ6p1BRj/gtEZemT
	5Z4S8QApXGlW9SoHRuBw50AUK3ycBpb5yFRSm/KKs6i8J1yPxN958EDXbuJtRLIYDc5DJP4h0NB
	LQFX4mFIXN4CagYZtDuvEtlypC7vXc9/K/zPTbPSPH20Hp0Y7PD6SDbccyYsGRFJSBAJY3vTvPB
	15zJAyrItCiXfSlVH1C9kzfWeGk+69QMUTVcQuEGEaU9kSVF3CtI86Kn25vcID62xd6AibmkVqj
	qRKfetp7Dmdzy7zsBJpMOPOkwOw288afsfcGgDFJiSgcM90QSJhlNye6lnS8q4aUiJ8Llpk=
X-Google-Smtp-Source: AGHT+IGnoEozOknyoC6We3L6wSu5LW5c8+l3K2S+PrKsnw7nWoi0Lt21fMnvhITP0Puz6RwfcrL34g==
X-Received: by 2002:a17:90a:d884:b0:2f9:cf97:56ac with SMTP id 98e67ed59e1d1-306dd1719cfmr5116718a91.0.1744213470998;
        Wed, 09 Apr 2025 08:44:30 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:44:30 -0700 (PDT)
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
Subject: [PATCH v4 00/13] Introduce parity_odd() and refactor redundant parity code
Date: Wed,  9 Apr 2025 23:43:43 +0800
Message-Id: <20250409154356.423512-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several parts of the kernel contain open-coded and redundant
implementations of parity calculation. This patch series introduces
a unified helper, parity_odd(), to simplify and standardize these
cases.

The first patch renames parity8() to parity_odd(), changes its argument
type from u8 to u64 for broader applicability, and updates its return
type from int to bool to make its usage and return semantics more
intuitive-returning true for odd parity and false for even parity. It
also adds __attribute_const__ to enable compiler optimizations.

While more efficient implementations may exist, further optimization is
postponed until a use case in performance-critical paths arises.

Subsequent patches refactor various kernel components to replace
open-coded parity logic with the new helper, reducing code duplication
and improving consistency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---

To H. Peter:
I understand your preference for a parity8/16/32/64() style interface,
and I agree that such a design would better accommodate potential
arch-specific implementations. However, I suspect there are very few,
if any, users who care about the performance of parity calculations
enough to warrant such optimizations. So my inclination is to defer any
arch-specific or optimized implementations until we see parity_odd()
being used in hot paths.

Changes in v4:
- Rename parity8() to parity_odd().
- Change the argument type from u8 to u64.
- Use a single parity_odd() function.

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

v3: https://lore.kernel.org/lkml/20250306162541.2633025-1-visitorckw@gmail.com/
v1: https://lore.kernel.org/lkml/20250223164217.2139331-1-visitorckw@gmail.com/
v2: https://lore.kernel.org/lkml/20250301142409.2513835-1-visitorckw@gmail.com/

Kuan-Wei Chiu (13):
  bitops: Change parity8() to parity_odd() with u64 input and bool
    return type
  media: media/test_drivers: Replace open-coded parity calculation with
    parity_odd()
  media: pci: cx18-av-vbi: Replace open-coded parity calculation with
    parity_odd()
  media: saa7115: Replace open-coded parity calculation with
    parity_odd()
  serial: max3100: Replace open-coded parity calculation with
    parity_odd()
  lib/bch: Replace open-coded parity calculation with parity_odd()
  Input: joystick - Replace open-coded parity calculation with
    parity_odd()
  net: ethernet: oa_tc6: Replace open-coded parity calculation with
    parity_odd()
  wifi: brcm80211: Replace open-coded parity calculation with
    parity_odd()
  drm/bridge: dw-hdmi: Replace open-coded parity calculation with
    parity_odd()
  mtd: ssfdc: Replace open-coded parity calculation with parity_odd()
  fsi: i2cr: Replace open-coded parity calculation with parity_odd()
  nfp: bpf: Replace open-coded parity calculation with parity_odd()

 arch/x86/kernel/bootflag.c                    |  4 +--
 drivers/fsi/fsi-master-i2cr.c                 | 20 +++------------
 .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   |  8 ++----
 drivers/hwmon/spd5118.c                       |  2 +-
 drivers/i3c/master/dw-i3c-master.c            |  2 +-
 drivers/i3c/master/i3c-master-cdns.c          |  2 +-
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c      |  2 +-
 drivers/input/joystick/grip_mp.c              | 17 ++-----------
 drivers/input/joystick/sidewinder.c           | 25 ++++---------------
 drivers/media/i2c/saa7115.c                   | 12 ++-------
 drivers/media/pci/cx18/cx18-av-vbi.c          | 12 ++-------
 .../media/test-drivers/vivid/vivid-vbi-gen.c  |  8 ++----
 drivers/mtd/ssfdc.c                           | 20 +++------------
 drivers/net/ethernet/netronome/nfp/nfp_asm.c  |  7 +-----
 drivers/net/ethernet/oa_tc6.c                 | 19 +++-----------
 .../broadcom/brcm80211/brcmsmac/dma.c         | 18 ++-----------
 drivers/tty/serial/max3100.c                  |  3 ++-
 include/linux/bitops.h                        | 19 ++++++++------
 lib/bch.c                                     | 14 +----------
 19 files changed, 49 insertions(+), 165 deletions(-)

-- 
2.34.1


