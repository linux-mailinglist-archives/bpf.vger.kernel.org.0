Return-Path: <bpf+bounces-52268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C38A40FD1
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEA21895D40
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860B413792B;
	Sun, 23 Feb 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRPIiQjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95953AC;
	Sun, 23 Feb 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328970; cv=none; b=Xt7bgMtqyn8DhpbTo8bLgSn7LF0RTX8j/W7B3YYRDsme63mHrenySPAtp5RCkDp8K+E2jre12HBcWmbKWgeG7XtCD+jGXEJBQRd/yp3LVeQQYkt/cxWG9LfCG5dLuQ2y3yKnSjNd+k4gI35Wf8iJMeKuvtt6rOHWjhk0JnUV+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328970; c=relaxed/simple;
	bh=8XZ+LCP+IJ1T0NsJnmk05Bo9WbAvIux7frjHXYDMeLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GlF6zS9tRay79s6ofn93fFBm5UKOoWuRKowq8Ais8/9vE/4e0fk3yx/UTd5nDX1pns0rtQSurd98bP/4N0G1tlJd9+VHtuAJ3aFj4iOBXjjsXfjt/NexAj4IycmUsIxaFgTjnE/s86lzo10J+8IqtxjWVEmLdEVb1gSHlsLuIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRPIiQjd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso7495510a91.2;
        Sun, 23 Feb 2025 08:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740328968; x=1740933768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cC9XqKWpwoW6kaiQnMTAJRMWrDuUOdRDnNZLQfAjkgk=;
        b=GRPIiQjddhJzUHQpYvDfou3r119xqd1cvidotyv7brVgIKsKxSBxFEK2Z5Erq4RFHA
         1OZegso9ij4SjtTfpI7C2065u5Eh4oc6a+dwKqEQGHaqnBI9NISQ9kW4hFQ9shaw+Tl9
         OaP7LYLPtTmSLDTME+qBh17Lkt93dhJsn6p2Snkt4DFuq1SjR0bPprABAAg/BI85eIl3
         t2Z6xjWyKAUV+9LkHIPyro7+P8XBJF3p/Br2p1EdWFFxogs21zuF+YztoKLzcXY2TOhR
         DaYWahcEmCIQWgBZSvPPNGQ0luNs6Jg+fB1jazhaCImRj4qbeD/F6c0kvi/kXLomdHUX
         ukJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740328968; x=1740933768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cC9XqKWpwoW6kaiQnMTAJRMWrDuUOdRDnNZLQfAjkgk=;
        b=QNEJgEqSDwAVwQ75959ZfU321gFfDPwn6hTmsDIpVEcnVeWItYo6XQpSLRmu67GY3/
         BVrDF0XRr/PgYs14E1f+egTBou/SpWFgdFoUluDmBXSgXfza+Nn0L8t+5tEKAAVB8jWL
         Cv7mPM7c0XlVvQp2PCXXHq4V6jlJSaAhD00zualj96NkVLNsaCEa481NxjoYAWrsJ3wv
         7rchfkSWKLimizObNi520wfhBpLRq4J79iLC9bBVDA+ingRz9XAs6BmrUkGnNQjiXbhk
         8WUkVDBpR6CEyEvoma5ptfmmPecAZVdRxnqixhnWPhiUbwIJqTxAxwVp6jRT2Dlj63kL
         ZD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/uIRslZP3XFTb64BoITBN/aH7egPb39l0YVD2TrIyv6kAzcAJ3cPGpBPmPN2AAjbpVqUYW5mzir0uWT+Xppk=@vger.kernel.org, AJvYcCVJ+ub+8HtMnWObF0w6s0jI2LrrbpzjznlngYp60hL/AAHxufdzRehDCgTpSTMvVozXq9/UJmtBUEJkoYRD@vger.kernel.org, AJvYcCVvxWG0YLv4uPfejjPLiUsomQbNUEzwdIXj3kdbW7f4AA0schy1RBEDQGY8FO3Mv8VeXa5oTBLEgfyrfDk=@vger.kernel.org, AJvYcCWiQ5CWAFrTfyV4cMACS66w6WgFKconxcQbBdR+kTB1zMUbWwcMj5sE02BrO933YbjLMZk=@vger.kernel.org, AJvYcCXPc6wBUuVUrYMRYlAZlMmRCyrsdg1yOAy70ZQa0gnQ+8YeZZwOvlcOcgEOK7BEqka6ElFJi24i@vger.kernel.org, AJvYcCXbdrbSu62NN25npmuZGXb8F1RHS5K35Cj0Nq20FDmf7GYLSJfND8ADgWXvcWcdzVSTD8Yf4vStSXXNMNU=@vger.kernel.org, AJvYcCXt24Qc4P7Zseza7fNMKbJdkgOczuuUmdXOzYYpCJCIslMRY9BEj7UaI0JDDYfp/9ioqbBagHDXa9vN4tGr@vger.kernel.org
X-Gm-Message-State: AOJu0YxwL6DIdY9R8JbMPcjehOUNgMGx9nK9bJxfNGp6UroixcrJWb8o
	ToziF6JBkkq0pO9R+BSqO1jdKLvkUTj/1N5KjjHDrbH8O9S/bHth
X-Gm-Gg: ASbGnctyIKnOAOVAC5bT1M8kPs9AsXj/kDAmYLq7MnlVPoIXqlbPbDJku3d5U1HqPzH
	B/1kU2nOuegqTQdXwbSaZrk1JOfFfbimeJNxIhk22j/eIlXmXST9CVV4JgukJv3+Mwa5lgn8kb0
	78h4zlwBT7tdTScJBiv1/YkQ7AFD83ecqstQv7nR8/VifvoyFpFHTTcaheNp2ZT6O8EhQG1V0lB
	H90Dp0VSZ+4+LabPAWPafuXOb+gxBsmsrV/awCKoyBn6M28xFBMnOKZhBUbkML6+gIRFNVbIIWT
	pYSf33A8Ddl2TdjkPlYM1r3pzj3B6WikGkhj4+Fwz1RcWiQB8vVqzPk9
X-Google-Smtp-Source: AGHT+IE9IoeqkqZm6OQjrr5kPJ0U3iRTenWYdpH7xXhEtXcp87aYt41gR2kUOpfxylsV56aTy8WbdA==
X-Received: by 2002:a17:90b:2e44:b0:2f5:63a:44f9 with SMTP id 98e67ed59e1d1-2fce7b0acaamr15072669a91.23.1740328967814;
        Sun, 23 Feb 2025 08:42:47 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:42:47 -0800 (PST)
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
Subject: [PATCH 00/17] Introduce and use generic parity32/64 helper
Date: Mon, 24 Feb 2025 00:42:00 +0800
Message-Id: <20250223164217.2139331-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several parts of the kernel contain redundant implementations of parity
calculations for 32-bit and 64-bit values. Introduces generic
parity32() and parity64() helpers in bitops.h, providing a standardized
and optimized implementation.  

Subsequent patches refactor various kernel components to replace
open-coded parity calculations with the new helpers, reducing code
duplication and improving maintainability.  

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Kuan-Wei Chiu (17):
  bitops: Add generic parity calculation for u32
  bitops: Add generic parity calculation for u64
  x86: Replace open-coded parity calculation with parity8()
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
  rm/bridge: dw-hdmi: Replace open-coded parity calculation with
    parity32()
  mtd: ssfdc: Replace open-coded parity calculation with parity32()
  fsi: i2cr: Replace open-coded parity calculation with parity32()
  fsi: i2cr: Replace open-coded parity calculation with parity64()
  Input: joystick - Replace open-coded parity calculation with
    parity64()
  nfp: bpf: Replace open-coded parity calculation with parity64()

 arch/x86/kernel/bootflag.c                    | 18 ++------
 drivers/fsi/fsi-master-i2cr.c                 | 18 ++------
 .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   |  8 +---
 drivers/input/joystick/grip_mp.c              | 17 +-------
 drivers/input/joystick/sidewinder.c           | 24 +++--------
 drivers/media/i2c/saa7115.c                   | 12 +-----
 drivers/media/pci/cx18/cx18-av-vbi.c          | 12 +-----
 .../media/test-drivers/vivid/vivid-vbi-gen.c  |  8 +---
 drivers/mtd/ssfdc.c                           | 17 +-------
 drivers/net/ethernet/netronome/nfp/nfp_asm.c  |  7 +--
 drivers/net/ethernet/oa_tc6.c                 | 19 ++------
 .../broadcom/brcm80211/brcmsmac/dma.c         | 16 +------
 drivers/tty/serial/max3100.c                  |  3 +-
 include/linux/bitops.h                        | 43 +++++++++++++++++++
 lib/bch.c                                     | 14 +-----
 15 files changed, 74 insertions(+), 162 deletions(-)

-- 
2.34.1


