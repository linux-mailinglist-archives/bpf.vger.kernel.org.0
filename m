Return-Path: <bpf+bounces-55543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C749A82B4E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7060C176D12
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38C270EC9;
	Wed,  9 Apr 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0WWbKUv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8C269B1E;
	Wed,  9 Apr 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213557; cv=none; b=hx8wIKTjSmla5F02jLLCekNJv/nBE5OYIQkUHHwPRvO0uYNRGWbL6lWKvCf+GqLMsmdXOoN16ssjY5LidlQ/T0APrXFWRQyVCkqKdVpfE0+aGdZqEWsk70O3n8Y8vhAVTGMLxTGtyLw4cCKLmP9jWQ90VXuAFieTdXPcAtFmYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213557; c=relaxed/simple;
	bh=ZVFZHQQQk+HI/N3knvHhmroiCBacVnQihS2YvtGWow4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPwwz7UsMRwQDmOk8bdQdWpFD9+V2jlDBolVuP7l6tNkFeOsz5lmIFkRGVgWgTLQneI5z9rnlw8zBqTZ7t+BJEusfqlBzmBQkK6nKnQV+LxE7Bz/wSAjzssNjs0H50YXh0jzWOuD1ib0fbJ9EP1hxoyOw0smNglIE1WYX9Uc/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0WWbKUv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so3508756a91.1;
        Wed, 09 Apr 2025 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213555; x=1744818355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GTX40p8Eu+tWq8rarx+bIs4dwN06BcTyPGidfavgSc=;
        b=C0WWbKUvv8mvPS2zeiiPUoh1fG0DtaBFEqcWCi9nLlovGQTUrMcx//tMLqkulVxxfj
         jcPKFbpGDLxR9hGix1kfxKYwXBTiNTrWrBG47yUMQisBKCpVTEa9u/iSIXGiubm8luZg
         wcS1JlLl+l4QV0yPPm6MVq4KY7+pnEa6GiA1ejujefMWp5zDjTAkazxf+ZVR5je+SPav
         vPxe/KGDEfewvAOozWSyjRKjT/md9Zyb9bZak2Q4YiBbiwznFNkFLUnRlOMhCO0+hkO7
         mcBGb6dADaHTjRSm45k3pCFdoNS+VA+UEaH55i5wSKvqGcMCN5HHFv9tzyRRV4HKJFAi
         BQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213555; x=1744818355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GTX40p8Eu+tWq8rarx+bIs4dwN06BcTyPGidfavgSc=;
        b=ZwUTwbkXJJ6bZF5tFUfk5eAfVA+Y66t5BhAf5HqMhrJJVZEu4pPTYDa+lOVHb9P1zA
         JRorv6C8e8+Vy6sG8Zy6NXYHBa27Hg01VXWH6wHMtYkfIQcjv6Wbpok9qTrHFVYfweSO
         0INRv7iHpk5JURn0Kz5BCMqrCMEc1fmWUYxQFEfJGqS1C0v7cI0+8WCTj3yh988BgzSm
         SApzcmic+Lpck4gNBPzc2mE7IKDDpPOtg1TpYA8/MG3wAY5FE4hK+fkO+bHlflDc8/TH
         r0UFGymrUoF/1qeK2lB/0yatrlET/+F2Ge9BGFVNHcgyahmGGLWqoQxgRfj4Rs0otRYS
         TlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWGj40yQrHFS20nc5lkx4G/C7auhZLlAdwiBmzXIuf4XMo5P9n/+T94huUoM8PMni8OZzTGSzvnIwkY9LOCY8=@vger.kernel.org, AJvYcCUqCJq4ZXYH4vfedwGuUoz9bgo+xiwGTEPb+Mgv21FejGUCQUSFuP0CTUJQm3awX/dfNps=@vger.kernel.org, AJvYcCV22wZXDpfSlYT7wHvR/tcOrdNKb5c/I+4yJLBGj1u3iA6tIRzSQSeGxcWYF+TQbi1k5vYhg2KSIU2t2Qs=@vger.kernel.org, AJvYcCVSQ6NFYF56Fg6K9a7wAuXVE2JVI6OgwW3pHN5DYaZ5aGUSmf1hcvM0PtrOpRRUjLR4YwAOOk+vdNAMpc/s@vger.kernel.org, AJvYcCVUL0hmwVzP3hJXgLYVtzSRzzUu7Wk/zayX+US/2MYBRU0O08lpwJ7ozhWSzlZDpVaHMQ26BNaFhD7F70I=@vger.kernel.org, AJvYcCVhY/Rf2/Dg8wjo/4XV+shh2M16Jg3dL9Viq8hy5Pmr9RD5oC1cxCoL7t0HFexwDo6PM0wtvv1lgDQfV4U=@vger.kernel.org, AJvYcCX/BedmJ9mDErAkA9mAerkI47WidSS9gEMRDcTx3gJsZhHbWtGOzEPfIV4TkNvkDtpKi2RiEPJNLb4+QwyY@vger.kernel.org, AJvYcCXy1E29a29/T/z4LMcMrZ+ZqC2vplFHHcctcT5NS/zF39gxchLHZGfWD2w6ukDmWc540rRNPVNq@vger.kernel.org
X-Gm-Message-State: AOJu0YxwzGEfYT4Rnrjfwu5IgdS92IuA5g5jgfqKt1ABHz8Wnl6OliYV
	HZ5yxk+8yFa8/8/2lic0nRyE4AiaF0VtxuI0v6rykmJ+ZDPuhZxH
X-Gm-Gg: ASbGncsgoSnZ25gHbJ/L6uET2AIe8wJw59p8Sv6OIy0CP2kUyDn8kXbY7y82UB2UT/Z
	/c7l5CLG5ZBSJvQsIEffh5VJxYdGGFdCE/ukaPveQMvHrFZ4p9990IBssHHpuHjyo0v9YktUby3
	KBEoues0QIYUVPgDUPhAuyWhs78wITCgcfUjHL3Y15Bs6V9D+1uLfc8gNd20KCIXx/MrKqs+/4U
	j2zObwF34pzPh5hYFncLpr8rY1pZbRW543AeH0ZJ0XoMcYNfGJsoyfBrcxzQ+ur6tHzvPXNruNw
	aK/HkyqweI3pwz10xQhvC3wsz2CO65NUdK41wJ9CnzMG1NaPZeZB4yt/j+1qBHDWeuUCjMM=
X-Google-Smtp-Source: AGHT+IG+nlKBY0fzC5EpfikKx++hN068mStMCGrKOPeFQ0KT+ZFhaeW1hEnEku5KKvT2BN4jgM2ClA==
X-Received: by 2002:a17:90b:2dca:b0:305:2d28:e435 with SMTP id 98e67ed59e1d1-306dbb8e7d2mr5088169a91.7.1744213555184;
        Wed, 09 Apr 2025 08:45:55 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:45:54 -0700 (PDT)
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
Subject: [PATCH v4 07/13] Input: joystick - Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:50 +0800
Message-Id: <20250409154356.423512-8-visitorckw@gmail.com>
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
 drivers/input/joystick/grip_mp.c    | 17 ++---------------
 drivers/input/joystick/sidewinder.c | 25 +++++--------------------
 2 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
index 5eadb5a3ca37..e7f60a83a89b 100644
--- a/drivers/input/joystick/grip_mp.c
+++ b/drivers/input/joystick/grip_mp.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/jiffies.h>
+#include <linux/bitops.h>
 
 #define DRIVER_DESC	"Gravis Grip Multiport driver"
 
@@ -112,20 +113,6 @@ static const int axis_map[] = { 5, 9, 1, 5, 6, 10, 2, 6, 4, 8, 0, 4, 5, 9, 1, 5
 
 static int register_slot(int i, struct grip_mp *grip);
 
-/*
- * Returns whether an odd or even number of bits are on in pkt.
- */
-
-static int bit_parity(u32 pkt)
-{
-	int x = pkt ^ (pkt >> 16);
-	x ^= x >> 8;
-	x ^= x >> 4;
-	x ^= x >> 2;
-	x ^= x >> 1;
-	return x & 1;
-}
-
 /*
  * Poll gameport; return true if all bits set in 'onbits' are on and
  * all bits set in 'offbits' are off.
@@ -236,7 +223,7 @@ static int mp_io(struct gameport* gameport, int sendflags, int sendcode, u32 *pa
 		pkt = (pkt >> 2) | 0xf0000000;
 	}
 
-	if (bit_parity(pkt) == 1)
+	if (parity_odd(pkt))
 		return IO_RESET;
 
 	/* Acknowledge packet receipt */
diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 3a5873e5fcb3..fb6f7004a485 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -7,6 +7,7 @@
  * Microsoft SideWinder joystick family driver for Linux
  */
 
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -240,22 +241,6 @@ static void sw_init_digital(struct gameport *gameport)
 	local_irq_restore(flags);
 }
 
-/*
- * sw_parity() computes parity of __u64
- */
-
-static int sw_parity(__u64 t)
-{
-	int x = t ^ (t >> 32);
-
-	x ^= x >> 16;
-	x ^= x >> 8;
-	x ^= x >> 4;
-	x ^= x >> 2;
-	x ^= x >> 1;
-	return x & 1;
-}
-
 /*
  * sw_ccheck() checks synchronization bits and computes checksum of nibbles.
  */
@@ -316,7 +301,7 @@ static int sw_parse(unsigned char *buf, struct sw *sw)
 
 			for (i = 0; i < sw->number; i ++) {
 
-				if (sw_parity(GB(i*15,15)))
+				if (parity_odd(GB(i*15,15)))
 					return -1;
 
 				input_report_abs(sw->dev[i], ABS_X, GB(i*15+3,1) - GB(i*15+2,1));
@@ -333,7 +318,7 @@ static int sw_parse(unsigned char *buf, struct sw *sw)
 		case SW_ID_PP:
 		case SW_ID_FFP:
 
-			if (!sw_parity(GB(0,48)) || (hat = GB(42,4)) > 8)
+			if (!parity_odd(GB(0,48)) || (hat = GB(42,4)) > 8)
 				return -1;
 
 			dev = sw->dev[0];
@@ -354,7 +339,7 @@ static int sw_parse(unsigned char *buf, struct sw *sw)
 
 		case SW_ID_FSP:
 
-			if (!sw_parity(GB(0,43)) || (hat = GB(28,4)) > 8)
+			if (!parity_odd(GB(0,43)) || (hat = GB(28,4)) > 8)
 				return -1;
 
 			dev = sw->dev[0];
@@ -379,7 +364,7 @@ static int sw_parse(unsigned char *buf, struct sw *sw)
 
 		case SW_ID_FFW:
 
-			if (!sw_parity(GB(0,33)))
+			if (!parity_odd(GB(0,33)))
 				return -1;
 
 			dev = sw->dev[0];
-- 
2.34.1


