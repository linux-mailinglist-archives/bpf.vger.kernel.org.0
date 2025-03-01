Return-Path: <bpf+bounces-52975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78DA4AC12
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AADF7A6E2A
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABE01EF08A;
	Sat,  1 Mar 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmcxOvOa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C01E5203;
	Sat,  1 Mar 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839242; cv=none; b=Ohl0athp5m1aO0GSluMVf5D/dQD9og1+sdZJOnzhlvjUE4JLTIotY1PBWF00gfStTJd0yjthyLRB5Jtyg+YLmflE7WI1PsplAVh4ay+VsXxrCD8/HyuB26LqpOzjrMp+o4Ox65XRZr+C14P98TNJNKqVEhRnitGD+rs0JaSdSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839242; c=relaxed/simple;
	bh=TwYwZvCrklNfcmQ95nA9Xu2F+v+lRRPBTM6pl81qOZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sOzC0dufZ/BIpVsYAHCEqR+vTzVIg874uYseIz+/iIAbvB1bKFirOfhpjnT89MyBxkaXWe7sC/QHXPTeUQYDbP7vFW3L0AJpu7FZkCWpyfTA7yGtkAru4wCW2DgR9yK4fJuwUmWo3COzi/A6gen/G+GGF930D5meetaq86rFXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmcxOvOa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349bb8605so62045745ad.0;
        Sat, 01 Mar 2025 06:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839240; x=1741444040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQRFKAla41Ay10wYFnrS+X/WAyPF0gKgODKhC/FC/AE=;
        b=jmcxOvOaWwV82srI2S19lOgw5wKi7T0oGVEH/mRKYexf7AEd1T3hxdvUmOuOS1OaHQ
         mKShHn2F9tCaVzcTaplBiHgiq5byzYW2Hz+SWLJEapsH6Rd3Ci6QZbRc+t83QRj6tKAA
         UyBqocdeDlURF4Coeuvn7at/fy94YYl6VDZ4xwrjk2VSB3QkByvfeG9Dy5mQ/3XBxJ83
         Zj9xoHb2gOyHRid4CrCQ2mtlebM+6Xs0eSciDPt4j/6IS7xAfzNHVPnRo8VWcnvZ2ToS
         qgJlh5y8cCw/HIH0h8AU90pcfqY5ZMZevyhE6swz/qi7LAlkIEjQSjh7Wc5O6HhJRwhp
         vLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839240; x=1741444040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQRFKAla41Ay10wYFnrS+X/WAyPF0gKgODKhC/FC/AE=;
        b=KuKWET4fyx6a1wsmgl/tgX7LBZuIr3ZxkllNP/IzFHvu8orTVYKIWKur3t1xjxJRNP
         zHd4GEZAosYuIzhW4+qYRJtpFkb/h8sWb3QmfFLvI74oMornVcFBOtt66WbN7QlK7mLl
         xbX9i6aHSp02qktOh9YqiYyopF60G9SP5r7vcwzmaw+11mz1+RshWgxymFHITPLFnZJc
         ODlyT7K+aqivq+bSKdeecCSmCq5yKZn5j5Ym+reA3tXlZvQMKTlA8Al6e+/g1iYgL3Kc
         BtWIzhX+FUwcjfX9rEw+ae857tVKTXnpIUgGI73xfpttJFHvvSXmCgzU/BMx1xGrePAn
         1GTw==
X-Forwarded-Encrypted: i=1; AJvYcCUdo3ywFhRntRud7SpDoCEbF6xoFBLp+YB7Nh+znPbhxZ5/gb2ZLtuVMIQ90U+Jhdy3I1o=@vger.kernel.org, AJvYcCV63fsFy3evuhfVnPhlMtJA4W4wQylPMDlMbZ7/UnH2NX+bwsrb7Rg6lfGW0B8qzc05vKt3xTIE4tXMyLHn@vger.kernel.org, AJvYcCVc30RhDIsx6klayDJCEaDVZIH/ZArwquvE8Tpvd9uTGaQQ7u/5dURjHnMqf2WTrcKnB8n5iMly@vger.kernel.org, AJvYcCWELitVN1rhUmf0mr9fa9LvQAyJAoeasdueKOQPCIAAV82X7BZuZ9QiFrGKQdHATq2Hac/ieFLbM8vp8B8=@vger.kernel.org, AJvYcCWR5cYSPoOWbS6y6FIxItpXu9/Uw6rRGkBjlglQsqiE6UF7F1t3apdb2pgDWAeFCB/tXvrHW7D571tF9Yuu+7o=@vger.kernel.org, AJvYcCWSm2nYVaMBh014q5vZ7wquu0n8x3MXC+HgOi0iilNe1ZfP5IdHek5/D96VB1FygvaCSVIGi0dBAGQcyaFP@vger.kernel.org, AJvYcCX5KFecbZWNLLFf86Zb20ZS7vhfHvU8JWA1UIc5N1PUjnrF4ayc+1fXLIOVDCVfRQYxQTRFvJDwxWKrQr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6ABf/lOUu0HNY7MZQ/wrIxanANsB/EgyGbnaNTLpRME4Lms+
	Vq6Jdoo6paQMfgwzu0Q9tgf6mGMqR581/XtwCG9RFBAFUGySWZzUf8/CiPj29K0=
X-Gm-Gg: ASbGncux9vYo/G11L8pULOQE7cB+SpXlYqz5P0yea3U5DKcpfQzY/xt5g1LxZrqLhso
	DfHqcWWzUMbBi3+GKw7gOs/Jhyd8Rm8yC1n2oyH1b48A8glNJyquqZZCdghAEDnxll1CCe7lG62
	YE3FbbLLefsfvw1IS/mXeR81a0xTivLZbtOQWEWIsoeeSudpdYxX+ALfRv2NE4u9F7v+E4pGlgZ
	7HjbUcyqlmtyUMDS76vA1BihirGtzMA73nBJFIqAgO+IEImTaTwaJzQP/7zjpVa4EQQVRqZQn3p
	9PrVrr5+7cbkvsRug9/hAwON/gX8ZfLmT0wuwZXff+3le0kiMIMpt0UNQ7Ya+MedCIIZdSPizI4
	=
X-Google-Smtp-Source: AGHT+IFWKqiV0JEURaPP9WsTXinyvBYz5p+Da6Z0sy2B13n/BlJ3FGZeHRzY7pPlUCpj+eVU13KkqQ==
X-Received: by 2002:a17:902:d4c6:b0:215:7446:2151 with SMTP id d9443c01a7336-22368f61abbmr99234975ad.4.1740839240264;
        Sat, 01 Mar 2025 06:27:20 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:27:18 -0800 (PST)
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
Subject: [PATCH v2 12/18] drm/bridge: dw-hdmi: Replace open-coded parity calculation with parity32()
Date: Sat,  1 Mar 2025 22:24:03 +0800
Message-Id: <20250301142409.2513835-13-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301142409.2513835-1-visitorckw@gmail.com>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity32() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index cf1f66b7b192..833e65f33483 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
@@ -4,6 +4,7 @@
  *
  * Written and tested against the Designware HDMI Tx found in iMX6.
  */
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -171,12 +172,7 @@ static void dw_hdmi_reformat_iec958(struct snd_dw_hdmi *dw,
 
 static u32 parity(u32 sample)
 {
-	sample ^= sample >> 16;
-	sample ^= sample >> 8;
-	sample ^= sample >> 4;
-	sample ^= sample >> 2;
-	sample ^= sample >> 1;
-	return (sample & 1) << 27;
+	return parity32(sample) << 27;
 }
 
 static void dw_hdmi_reformat_s24(struct snd_dw_hdmi *dw,
-- 
2.34.1


