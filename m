Return-Path: <bpf+bounces-52418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE90A42CBE
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CBE18993EE
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513E203710;
	Mon, 24 Feb 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4q+SHA7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757591EDA0F;
	Mon, 24 Feb 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425229; cv=none; b=cclm2t5G++aynQHLJLWuhmPXQudPRbQpYBMYlxI0aCcMwSypjiVM5YLCv0A/LAdvoRuMuMXa9eSjl19OsZYifb+dtZS33lJMeGf3C8R2+c9hyw21JEl1KxmbLNpCm8smqWlhZaRpagbX/VH6qJtEo8lOP4qos79BmMQCFiRjJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425229; c=relaxed/simple;
	bh=zms8AwfScWDNRnCzKtbTRceK4ozgPM3XizahJfE+6tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7GhyiyUVnT1yRTNL9fMSdPDqtmE9zMWFrlg0KRKnm9PPQpJZhIHWjqiiX++MNWCV3jyhJ7jYg+G7UYOxbFpFrKrbHuj95Fbu+UW+mAa7vxz19h1b1JcVs0m9kSi1DXYKuTympQXLNUqXnr1Y/KeBZBQapdbt+ypynVFUv93Eag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4q+SHA7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so9616717a91.2;
        Mon, 24 Feb 2025 11:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740425227; x=1741030027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fNLdUwijT6W41ZsoblnFA+2AFZPup2ylwdIktRpNhS8=;
        b=j4q+SHA7EXf0knh8DM6GL/5Og6eZo6oZM6cSRjq4gqADlhgYT4gukZ1QGPtCsBihtH
         BLVVI/DwEe7J2F1a6rAtV5SfbhncGYtNJAlYgBx9h13EUPh1uJzqn5Dmffa80o/2fLBI
         1tUd26LAmdyunCp4Eh1Oj5Yg8Tv8YfsmGn8HfqITk1P0UfX4NApKA4uo0q0m6FJBDPlN
         3Rfzmw4XyjCFV1NkjafHGKrrjAVgbLOXxGNEOZZEXCTtFi2DUty88sIq7BWcT1xHmzmo
         y5DirFpC3T4gSE3b4Q5z14px4GdYPctnLMkWXL0nuLeGmiUx+dzOamueqQC/UkyIM3ss
         oKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425227; x=1741030027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNLdUwijT6W41ZsoblnFA+2AFZPup2ylwdIktRpNhS8=;
        b=kgp8QZIxb98RP24ZmcHLLgN0vAPgBaP4qfG63wyVJ04U41fDbvOZ4K4KNEyCoIEMqp
         nCmsjsc7/dOSzHPhuTl6CVXxea/2WMqYkozT4SgRYe/IG6s50IZ8muaARJrM38722MJD
         +DBl+mQwfpndVY9fBFmqesHJ7LKaqRksWMUzm2Dr2EJeyvEquhXvZAdXzmKEkrn1qn33
         lQVgcFUdL6Oku3Sd9oLyzQwHrO/bCx1Fhs3+Zvh5Kn4ba9FYOsgcoGkGfzFqn7pwc/n7
         CJtAE1en4JL+sI0gGV8+gmJvZ5XI2ft0n/WLFPcbgswOvWK1JG4e3PvfIuc1pu6r0hkU
         Fusg==
X-Forwarded-Encrypted: i=1; AJvYcCVo+24H2n6s1NmNizHYw1Q3Q4YtGmWl4l8Eg1wlxo+WSR8Ri69zUjh7zvBViKkVG+7dmchvCwgQak0vZa0=@vger.kernel.org, AJvYcCVo6wzUwuk1Sa5Ghlc6klClWEcsEuJsj0ayuXvLaHwEd24vlVNswETrj9Gf7WcxtZv4usE=@vger.kernel.org, AJvYcCW/8tFvT2PEFpPLVjI8A1G7IVa0aFk5EUmUJ+Ynrx5jpC635ZpY3kg77SoZWa07zs/0E76WsIe5NJ7Iay3Ni30=@vger.kernel.org, AJvYcCW9uELGb6sfcagREh6YWsJyYOvlTb+/MXqU5B7X0vCyLda0XtPyR6+/t6mIU/+Ao44iO3/6a7NnPjDaHc4E@vger.kernel.org, AJvYcCWAJPTxxwInFlBgAS/ehVMhO2fT6Y07TpxBz4Twa09BsdwE16eXYY30kM5MD8fBNO/6hr7Xn0sllnf92eY=@vger.kernel.org, AJvYcCWlo1rtLxuGqu62bLDODjtj8ItqOTX2tn2CnGFwjGtGNAWi1O7yWcWR5fE4iwikr61j56i8UonCx7nshIew@vger.kernel.org, AJvYcCWpr2XrYzwJq/kf4Zu2ElH1yxXfaGA5jYPJrwCHT/CEe56zweEu1SHE4/h3nFq8xch/ybAAQZ53@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1z2cWOtNzHmZC1FeZL25CsRi53MqFEN7IfGOX7XQR0OLFvu9x
	wBnDqX14OHOuyqqQQ6+HlHb87viLHqHQ1n5D/yYMeUDlbRj0zO2S
X-Gm-Gg: ASbGncsGuZ7wjRMB2Gjp/GNDozuepRqQFwiZ2aYesZi0E9cJi931jagv+n+W71ZYH4l
	7Dkkzi//rwVlwxEP5dDXt+yxLX4wVxrftANsfBqsOQIU6ZixJRh2AdOvhfNMSAP3Nf9wyAof58r
	Uza6656YWI6MKHMV1uNwieo18izVgj/ZyL537+uEPwY6H0/Uo+DwH3p64cEDwdHRoFCnbpGMwUV
	6/S3olmjAthWDxq9kZ7Ta6pqRZz3hIixcBKTsjd0UBBUMjx5Ghj0u5FMtn4S0i8BUu9hOf/KUf6
	aUZaiZYgZ0UbxBaHPtkr64O/4Q6BouUOm6jIxZHdny/4brC+jA==
X-Google-Smtp-Source: AGHT+IH68TTuhENvYMBVibjVTmGrUAIBmwlMSF4lzlrMkZQD90CN6i4oKdfqdXSCYQRlTI+LIK96VA==
X-Received: by 2002:a17:90b:38ca:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-2fce86cf118mr21465186a91.19.1740425226496;
        Mon, 24 Feb 2025 11:27:06 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3da759sm31947a91.13.2025.02.24.11.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:27:05 -0800 (PST)
Date: Mon, 24 Feb 2025 14:27:03 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
Message-ID: <Z7zIBwH4aUA7G9MY@thinkpad>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-3-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223164217.2139331-3-visitorckw@gmail.com>

On Mon, Feb 24, 2025 at 12:42:02AM +0800, Kuan-Wei Chiu wrote:
> Several parts of the kernel open-code parity calculations using
> different methods. Add a generic parity64() helper implemented with the
> same efficient approach as parity8().

No reason to add parity32() and parity64() in separate patches
 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  include/linux/bitops.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index fb13dedad7aa..67677057f5e2 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -281,6 +281,28 @@ static inline int parity32(u32 val)
>  	return (0x6996 >> (val & 0xf)) & 1;
>  }
>  
> +/**
> + * parity64 - get the parity of an u64 value
> + * @value: the value to be examined
> + *
> + * Determine the parity of the u64 argument.
> + *
> + * Returns:
> + * 0 for even parity, 1 for odd parity
> + */
> +static inline int parity64(u64 val)
> +{
> +	/*
> +	 * One explanation of this algorithm:
> +	 * https://funloop.org/codex/problem/parity/README.html

This is already referenced in sources. No need to spread it for more.

> +	 */
> +	val ^= val >> 32;
> +	val ^= val >> 16;
> +	val ^= val >> 8;
> +	val ^= val >> 4;
> +	return (0x6996 >> (val & 0xf)) & 1;

It's better to avoid duplicating the same logic again and again.

> +}
> +

So maybe make it a macro?


From f17a28ae3429f49825d65ebc0f7717c6a191a3e2 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 24 Feb 2025 14:14:27 -0500
Subject: [PATCH] bitops: generalize parity8()

The generic parity calculation approach may be easily generalized for
other standard types. Do that and drop sub-optimal implementation of
parity calculation in x86 code.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 arch/x86/kernel/bootflag.c | 14 +-----------
 include/linux/bitops.h     | 47 +++++++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
index 3fed7ae58b60..4a85c69a28f8 100644
--- a/arch/x86/kernel/bootflag.c
+++ b/arch/x86/kernel/bootflag.c
@@ -2,6 +2,7 @@
 /*
  *	Implement 'Simple Boot Flag Specification 2.0'
  */
+#include <linux/bitops.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -20,19 +21,6 @@
 
 int sbf_port __initdata = -1;	/* set via acpi_boot_init() */
 
-static int __init parity(u8 v)
-{
-	int x = 0;
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		x ^= (v & 1);
-		v >>= 1;
-	}
-
-	return x;
-}
-
 static void __init sbf_write(u8 v)
 {
 	unsigned long flags;
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f..29601434f5f4 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -230,10 +230,10 @@ static inline int get_count_order_long(unsigned long l)
 }
 
 /**
- * parity8 - get the parity of an u8 value
+ * parity - get the parity of a value
  * @value: the value to be examined
  *
- * Determine the parity of the u8 argument.
+ * Determine parity of the argument.
  *
  * Returns:
  * 0 for even parity, 1 for odd parity
@@ -241,24 +241,45 @@ static inline int get_count_order_long(unsigned long l)
  * Note: This function informs you about the current parity. Example to bail
  * out when parity is odd:
  *
- *	if (parity8(val) == 1)
+ *	if (parity(val) == 1)
  *		return -EBADMSG;
  *
  * If you need to calculate a parity bit, you need to draw the conclusion from
  * this result yourself. Example to enforce odd parity, parity bit is bit 7:
  *
- *	if (parity8(val) == 0)
+ *	if (parity(val) == 0)
  *		val ^= BIT(7);
+ *
+ * One explanation of this algorithm:
+ * https://funloop.org/codex/problem/parity/README.html
  */
-static inline int parity8(u8 val)
-{
-	/*
-	 * One explanation of this algorithm:
-	 * https://funloop.org/codex/problem/parity/README.html
-	 */
-	val ^= val >> 4;
-	return (0x6996 >> (val & 0xf)) & 1;
-}
+#define parity(val)					\
+({							\
+	u64 __v = (val);				\
+	int __ret;					\
+	switch (BITS_PER_TYPE(val)) {			\
+	case 64:					\
+		__v ^= __v >> 32;			\
+		fallthrough;				\
+	case 32:					\
+		__v ^= __v >> 16;			\
+		fallthrough;				\
+	case 16:					\
+		__v ^= __v >> 8;			\
+		fallthrough;				\
+	case 8:						\
+		__v ^= __v >> 4;			\
+		__ret =  (0x6996 >> (__v & 0xf)) & 1;	\
+		break;					\
+	default:					\
+		BUILD_BUG();				\
+	}						\
+	__ret;						\
+})
+
+#define parity8(val)	parity((u8)(val))
+#define parity32(val)	parity((u32)(val))
+#define parity64(val)	parity((u64)(val))
 
 /**
  * __ffs64 - find first set bit in a 64 bit word
-- 
2.43.0


