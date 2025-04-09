Return-Path: <bpf+bounces-55536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A210AA82B6C
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221BA9A6668
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF40526A0B3;
	Wed,  9 Apr 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZkk3AYz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3AB2690F0;
	Wed,  9 Apr 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213484; cv=none; b=CCce8i9SxhiL4OIZOCwqS79OfgPxU/lUoFu4T//SAJ8bzjBmpaA30XorBhbukGyEa2EKO2rOnHPZLZ0VdO22khf/U0Upl/RGbKSV37yPVw/HAGoVqsbMPpxz26roLePMZnZ3hO2F8s1caDBofsJcxyYBavAnie/BYeDP6Hl/Bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213484; c=relaxed/simple;
	bh=oHQrnfjD6zGDvLMJt8UwAGBX2UA7OK99C+0viCcwLZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fnss4sRvMEflxIJALq5dtiIsNxWX4SqDTPHiFcUkjyav3sYVXEjeHdHP1xiGklzieAnh1RJpWHvzvWq2CIJKyBQ5WYOKSusTqPE79/kvmm2ZA2oDVB/eDZQ5Khub0p+LNCQE2jw9tSpNR2xOS5OKLW8/HR6ssEyshNZVZgeknt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZkk3AYz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so5428331a91.1;
        Wed, 09 Apr 2025 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213482; x=1744818282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW4oOCfCNW1Ikfi6N7oqyzQRlobsbPmX3F7QqOKxP+I=;
        b=OZkk3AYzM0K1F4tFQPWAnzVc7Gpyz9UFMGmHg9OJY4k4Lad3CFd5AEC9NTlYTza2ZB
         GfHJhO2r58nlojrEIN6m8dPPRdS9QG/RlQ/J5Gy4Xxe8JNZJJbhbxW/em3sBimXlkkED
         mg9wtbwj86GWZUq5gBGyQA5XUduxnJByM0ReDicIju9jwnMcW5VwI4hY1cjSQI4qcpof
         Pq1dP0ygTXrs1PPB/GnK6/H7Ku29c4Ol5HqBgjBIU+MB1ytRBEaMjBilTItqAViPAbha
         AsWesA1l15A2WHJXRXNDw7/V9vAN80BUzH/2ZBv7JPO4Fwy9cQWYeSfZbbe8itLa6N7Z
         5yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213482; x=1744818282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lW4oOCfCNW1Ikfi6N7oqyzQRlobsbPmX3F7QqOKxP+I=;
        b=ofYc/okxukpmfNNmq5lEY9gCzkGVC941gGDwh/HOSJy0ba7B0MWTMvB2irBTkAX7Fr
         LYuPOsp6Vz6vnYzjWbbVBnPiLNIRMx6ENkeBTq50UvfhmbIXtwxgy0DkmJdT25HTh53R
         wANHD0VctWIDhglrtDSHJ8HnL20DPXWItqJL3RCl+bQeI5kJNhYXMw57JSr01T39+h+d
         zV2hxd2OK0abGKjaWIplAcKcB4bzSNc4+mjJU8oQKTnwhMusKQF8O+42Vzm0zAXhlw6U
         zBQto1zR11K0cJFvL9ZbHS5LIjCGYXpcZgAi15K0V6xjuS4N25MryEYrVnHjt0q6L/ta
         gO9g==
X-Forwarded-Encrypted: i=1; AJvYcCU+JHljL1lIESve2J+ul4gjzX7oNeiqU6JyfB+5PLo9jpirgI7xOlxpclWpdkU3MUU2XzW4ub5A7YTWTv4l@vger.kernel.org, AJvYcCVH51bwfIyCoxEiqHrKSCGz0/pZ9oIYQtzmE2JTZV6Yb9JMvOG+nq8Pv4ACPit9iQ2Wv1HJrnbtOPmlHh4=@vger.kernel.org, AJvYcCW/McT06FkOER44RSSf2tBIqx7kdC01mVCjEcb3TPDYgLAfuGIyqNO2JvHuvpGpQ+U236dt+fCN0pEAdGWT@vger.kernel.org, AJvYcCW5Py4HJ2LJbMruzJt05WVyatVb9MSyI0d6oXwgYU+Xj0Pit3GMaLNrsFO927LQvBA0YzE=@vger.kernel.org, AJvYcCWDyA+wrvUCy6L8SzuFtLNPbGhKftZUjRlaITT8v5UFHrDo5oekz2LPhyWwTjV74wjmLelChcJYvAhTQpy4bN4=@vger.kernel.org, AJvYcCX+zwotQJW7sB/YHdEMALaiLxZPHPxTJaMV2e4JdWQu9stp5m6ksyqwCuVZt36ndPRi1TEnM7LhXcEE0eM=@vger.kernel.org, AJvYcCXQFILzi/D9TOrod92IfwviVNNNJH0Fg/xKDzOeH1bAU4a86zi+si0vSGYKtHymxqrV6laKATiQzeuEc3Q=@vger.kernel.org, AJvYcCXikMymRuknE0owslHdOHpgTJjnwk3T4yrRVk/TusZxoYIWg6yDxbU1bwMXN3YVf8IbdMnzS3dB@vger.kernel.org
X-Gm-Message-State: AOJu0YxCL2o2S47N54ibVo/xWLrGMbKL7HbctzYirC8Eh8fBh6lsGmZ9
	i+UeFloeFIbvI7Uf4x0Gvh0/2AyFXnTku43wJeSwRrUDNQwj+aCL
X-Gm-Gg: ASbGnctXYBW4eFetOwdUXfSdWIEfMtaRIZwyqKBu4TmhC110FfUV0EmdqRrkLChx9ls
	GqmbvbXljWgB5G1r0hzHHHRnwIO+eBjaVq5dLbws0bCmZfcs2B63LBgqaqb/EWTJOvGaGTSJV3q
	SnO/bhS1M8ifvScT1wOO/aCLkDTPBmU7qe+iGUTimNhr0lC+WINrYYkpER4V+cMDAYIdSvb7GsR
	UAHjWZA6hy1GVt/ezr5XMaDqRgY6q4jzBTQm3Dgch4ZPy2pZSUKecZDFT0X+t0SGNIADTVf+hwQ
	SadKBtcfeydr66zZeNLu/sQiex6lF5gRVX6yoJL3lGXT/x0j+KOso+T97BBY8I2Bgbh0O5M=
X-Google-Smtp-Source: AGHT+IGgg0DBuH33oW+E+873bMYyZA/oUaltEXJsqFjgXBWTSXKYJ4mXYIMoJApL4m1vTMrn1nnOpQ==
X-Received: by 2002:a17:90a:f946:b0:2ff:4bac:6fa2 with SMTP id 98e67ed59e1d1-306dbbc1e1emr5446016a91.16.1744213481930;
        Wed, 09 Apr 2025 08:44:41 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:44:41 -0700 (PDT)
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
Subject: [PATCH v4 01/13] bitops: Change parity8() to parity_odd() with u64 input and bool return type
Date: Wed,  9 Apr 2025 23:43:44 +0800
Message-Id: <20250409154356.423512-2-visitorckw@gmail.com>
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

Redesign the parity8() helper as parity_odd(), changing its input type
from u8 to u64 to support broader use cases and its return type from
int to bool to clearly reflect the function's binary output. The
function now returns true for odd parity and false for even parity,
making its behavior more intuitive based on the name.

Also mark the function with __attribute_const__ to enable better
compiler optimization, as the result depends solely on its input and
has no side effects.

While more efficient implementations may exist, further optimization is
postponed until a use case in performance-critical paths arises.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 arch/x86/kernel/bootflag.c               |  4 ++--
 drivers/hwmon/spd5118.c                  |  2 +-
 drivers/i3c/master/dw-i3c-master.c       |  2 +-
 drivers/i3c/master/i3c-master-cdns.c     |  2 +-
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c |  2 +-
 include/linux/bitops.h                   | 19 ++++++++++++-------
 6 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
index 73274d76ce16..86aae4b2bfd5 100644
--- a/arch/x86/kernel/bootflag.c
+++ b/arch/x86/kernel/bootflag.c
@@ -26,7 +26,7 @@ static void __init sbf_write(u8 v)
 	unsigned long flags;
 
 	if (sbf_port != -1) {
-		if (!parity8(v))
+		if (!parity_odd(v))
 			v ^= SBF_PARITY;
 
 		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n",
@@ -57,7 +57,7 @@ static bool __init sbf_value_valid(u8 v)
 {
 	if (v & SBF_RESERVED)		/* Reserved bits */
 		return false;
-	if (!parity8(v))
+	if (!parity_odd(v))
 		return false;
 
 	return true;
diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index 358152868d96..15761f2ca4e9 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -298,7 +298,7 @@ static umode_t spd5118_is_visible(const void *_data, enum hwmon_sensor_types typ
  */
 static bool spd5118_vendor_valid(u8 bank, u8 id)
 {
-	if (parity8(bank) == 0 || parity8(id) == 0)
+	if (!parity_odd(bank) || !parity_odd(id))
 		return false;
 
 	id &= 0x7f;
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 611c22b72c15..dc61d87fcd94 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -867,7 +867,7 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 		master->devs[pos].addr = ret;
 		last_addr = ret;
 
-		ret |= parity8(ret) ? 0 : BIT(7);
+		ret |= parity_odd(ret) ? 0 : BIT(7);
 
 		writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(ret),
 		       master->regs +
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index fd3752cea654..df14f978a388 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -889,7 +889,7 @@ static u32 prepare_rr0_dev_address(u32 addr)
 	ret |= (addr & GENMASK(9, 7)) << 6;
 
 	/* RR0[0] = ~XOR(addr[6:0]) */
-	ret |= parity8(addr & 0x7f) ? 0 : BIT(0);
+	ret |= parity_odd(addr & 0x7f) ? 0 : BIT(0);
 
 	return ret;
 }
diff --git a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
index 85c4916972e4..d692a299607d 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
@@ -114,7 +114,7 @@ static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
 	dat_w0 = dat_w0_read(dat_idx);
 	dat_w0 &= ~(DAT_0_DYNAMIC_ADDRESS | DAT_0_DYNADDR_PARITY);
 	dat_w0 |= FIELD_PREP(DAT_0_DYNAMIC_ADDRESS, address) |
-		  (parity8(address) ? 0 : DAT_0_DYNADDR_PARITY);
+		  (parity_odd(address) ? 0 : DAT_0_DYNADDR_PARITY);
 	dat_w0_write(dat_idx, dat_w0);
 }
 
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f..7c4c8afccef1 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -230,35 +230,40 @@ static inline int get_count_order_long(unsigned long l)
 }
 
 /**
- * parity8 - get the parity of an u8 value
- * @value: the value to be examined
+ * parity_odd - get the parity of an u64 value
+ * @val: the value to be examined
  *
- * Determine the parity of the u8 argument.
+ * Determine the parity of the u64 argument.
  *
  * Returns:
- * 0 for even parity, 1 for odd parity
+ * false for even parity, true for odd parity
  *
  * Note: This function informs you about the current parity. Example to bail
  * out when parity is odd:
  *
- *	if (parity8(val) == 1)
+ *	if (parity_odd(val))
  *		return -EBADMSG;
  *
  * If you need to calculate a parity bit, you need to draw the conclusion from
  * this result yourself. Example to enforce odd parity, parity bit is bit 7:
  *
- *	if (parity8(val) == 0)
+ *	if (!parity_odd(val))
  *		val ^= BIT(7);
  */
-static inline int parity8(u8 val)
+#ifndef parity_odd
+static inline __attribute_const__ bool parity_odd(u64 val)
 {
 	/*
 	 * One explanation of this algorithm:
 	 * https://funloop.org/codex/problem/parity/README.html
 	 */
+	val ^= val >> 32;
+	val ^= val >> 16;
+	val ^= val >> 8;
 	val ^= val >> 4;
 	return (0x6996 >> (val & 0xf)) & 1;
 }
+#endif
 
 /**
  * __ffs64 - find first set bit in a 64 bit word
-- 
2.34.1


