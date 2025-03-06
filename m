Return-Path: <bpf+bounces-53472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B077A550BE
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A927188EBA8
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66EB21ABBA;
	Thu,  6 Mar 2025 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3thD0kO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20E213250;
	Thu,  6 Mar 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278369; cv=none; b=rVpVa+AdwD8dX8BgyklrEXQVh5rOaICk0MFRPO0DE/g97lfeAGOx+fxpSNOLOOuVcxj9aFIjpHh5vIKEdO2c6tS4zKZlhI2KywDG8a47UpkgFnBFVwSDGmlFKbJX0oy3EbpwafB8QKJrOoL213nukhJMA2Mlvo0BNLSXNR9URGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278369; c=relaxed/simple;
	bh=rGHJGCWU1PTrVgW6elmt7hoIQUKwiu2qrB2w4H98De4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOCDTDctynSC3Z9wqQpWltlpfdBBCN9GbiI5nQad36xFk4vjy7VCpCrKuEwsXzbu4T21zVvfR6aKXgBiPzbAEsBTtZVcLXeDDyR/U/nmCfGRfjY3UG8gab6SUrs+ixlXoEM98uj5xjoeCAsPdNnBfSbzrdpfY3NX6B9/TmrcXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3thD0kO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso451395a91.1;
        Thu, 06 Mar 2025 08:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278367; x=1741883167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bwdp+8POnpYEEnQ2mWPyy8f6+vYv2yxFxSEYWvX3Jsg=;
        b=l3thD0kOl2uJSPjvNq9ZuEpxVrQxNCe9nrp/lZgBrXAiiLQzCYg6AGp1+JyyxEKpeW
         QnyZa3JbI+DYWewnBx1wQxcPaUq1Dt5bcnSX7n48eMhES0MQRU/f/Mg8NSUDYX77wVlF
         ctRUtmDfa8JEwr5XgiZGr3UmEsdes2Vf15p+X3MCO3sZGi9FcuBEhhA5k2pNf1HJvNyu
         gdor5IRNCrxC9Bg38hHmFGt0mPeGdR3spPN5x/0+ycRrCy25Faj9nH74rWdk7KS71nNw
         qEHqqNZJY07FxV03a7szC7LDS/+rRc7+H4h8GbfYRrNpjVLArYHNR1ZkDNQ2xthlAh3s
         4q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278367; x=1741883167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bwdp+8POnpYEEnQ2mWPyy8f6+vYv2yxFxSEYWvX3Jsg=;
        b=GZ/jZavW04npXbVRtFW6IJbxO1FPgsJxaeVAVfOr+u/OYMn7SnXyiZEJBpC2hKneCT
         m2bOlXs3tFpx5tuDxDtnxpoDyCQO6L9JfzLEypdk0BvRwoKBZ0NdvbscAFpcgIrGCTIL
         xF3x2MSAzuDrsghiOAz3eSkJ3q4XvZy1gTNzkOkT8qVoceUGErprpIGwDVf1WhUvHzwB
         WCLpMYvYkx9WP/EhAWpgVvcjZv6bOeLW7piazvbk+ZFHdD7FCAvqR48D7D+QTu2wk2HB
         S0hv+TGpK9gCu9gBrTQye+CE/W2Upd/hYu4GIrUup43fWCjyxFQ08s0oBwdWVbZKN2aP
         o8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Kyo2XYDFmByoiJriZXarwcZlPCeDjOeJDDArfHvJv73TcK0cWf+ayYNBdw3JukoDA+XKhNgrjiP3mnk=@vger.kernel.org, AJvYcCUCYrDxjWuSfeZ2+Gx045aYnfGQU99Gfb07xVVuYsHVvColJQQMc9iXoR5JtLPAVB9TdKY1C6Es03J+UWK3@vger.kernel.org, AJvYcCV+mkfjI0x0L7DmdCZOmVhZyKhR4GVXYJBDnO6Eshwt/drLS6TbyRsQO+tp+vU4Js3SziSf8xq4eTCXW0A=@vger.kernel.org, AJvYcCWlXgIOf8xtQ/8Cs+PkG3G/vzd9ufib4BBhx1beeZPyDiASqZFKOfIhHS3CR0OgkRLAJhI=@vger.kernel.org, AJvYcCXNkaV8b/u0xy8g3ydye/PSXMmMhReE8fFjr7lyXI2H17q1sO0vxpImZdHY0ccDK2k9Y/y0N/xr@vger.kernel.org, AJvYcCXPosAG5khhObHiJkPu1Xgb3q+7dAaYxAkL7f6KmqkB4z9zWe0vup54gAdk220HDIZKitofumSs2z0BbprL@vger.kernel.org, AJvYcCXZIguLPH/GNwjQJhFOQ+KCpTjrHfUWFbrPbnbup8XlMG/d+9a5rM47ogneWMqHqlZpKzGVXdWq83Id6b51m3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQF2q3wAlRk7PJyXnThQhsD96IUaf6QV63eohaW5/8qUO0O7T
	vsR+xDx4WJ9bSK86E2Y4zA8pN7P+Oi/cxaQkn3tuwyN/rDfZZWee
X-Gm-Gg: ASbGnctrGPQ6pnsL+94nNIwcN3m8u6h9GBSBDrOwHjrkcQZ61hyN7HeFInvxDGxXhLG
	VHD+K4HC9EI0w1tEdKQ1NvyxzS1Uaoz4qLsePfpR6WZJJrwM3VRpNIwbCK2OiYiizCdurt4ko4c
	CLZ9UH7lasqfcBIQgJHmYWtNYSpVi7dJVghAWgQwH4xrflsnmula96OI2KaBofHvOEBL3E+6LgT
	4/Co5frqvwaQDPGNYWwSW7FRCINknh7NanZInal2ufr/HWHvGDY7RjyGxpkp7hCUaI1CmiYwt6Y
	hMfnJmZSkWX9WECa5Rpb/oyrkVB2igT4EzSZe5R59gF2HNQLv8+6npRU9iGBJk/jnMgFaMF6j7g
	=
X-Google-Smtp-Source: AGHT+IFHH+1zpB7N9XuTVJAOvoyUY8hkKo2wZOm3e52unMZzsjH5Hx1bGZW2MZ4mGhzudOerhh255w==
X-Received: by 2002:a17:90b:4b44:b0:2ff:7b28:a51c with SMTP id 98e67ed59e1d1-2ff7b28a652mr259914a91.34.1741278367078;
        Thu, 06 Mar 2025 08:26:07 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:26:06 -0800 (PST)
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
Subject: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Date: Fri,  7 Mar 2025 00:25:26 +0800
Message-Id: <20250306162541.2633025-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306162541.2633025-1-visitorckw@gmail.com>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change return type to bool for better clarity. Update the kernel doc
comment accordingly, including fixing "@value" to "@val" and adjusting
examples. Also mark the function with __attribute_const__ to allow
potential compiler optimizations.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/bitops.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f..44e5765b8bec 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -231,26 +231,26 @@ static inline int get_count_order_long(unsigned long l)
 
 /**
  * parity8 - get the parity of an u8 value
- * @value: the value to be examined
+ * @val: the value to be examined
  *
  * Determine the parity of the u8 argument.
  *
  * Returns:
- * 0 for even parity, 1 for odd parity
+ * false for even parity, true for odd parity
  *
  * Note: This function informs you about the current parity. Example to bail
  * out when parity is odd:
  *
- *	if (parity8(val) == 1)
+ *	if (parity8(val) == true)
  *		return -EBADMSG;
  *
  * If you need to calculate a parity bit, you need to draw the conclusion from
  * this result yourself. Example to enforce odd parity, parity bit is bit 7:
  *
- *	if (parity8(val) == 0)
+ *	if (parity8(val) == false)
  *		val ^= BIT(7);
  */
-static inline int parity8(u8 val)
+static inline __attribute_const__ bool parity8(u8 val)
 {
 	/*
 	 * One explanation of this algorithm:
-- 
2.34.1


