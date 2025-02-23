Return-Path: <bpf+bounces-52274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F329A41007
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD164188DF7E
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6604A18A6B7;
	Sun, 23 Feb 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlaMP9VZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF25139CFF;
	Sun, 23 Feb 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329038; cv=none; b=EUwYN3rIsVWV4yxw7/pVKDX1Kioq0gixTiV3Pn44AGjNEK2JUKpqKmH18mdIKzEgFFxsnm2euxPk1HQzOj6pFhvMmAUUw7kc+VHuou0jOLP57OZFM6/DTyVw7+cJdZp2v3TzkvPxMg9YPCxFG/iQINtnxip0jP3QpiM+iXptOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329038; c=relaxed/simple;
	bh=j2/wDG0L2QiKPBmNCWrxOGnHtFWO5kAL6+5E33WSh7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZ7SWqY8VZCdZzR7DmS1qMixDXeoUMCqgooAD0rkZNQpp72fYxxItR2V3Rv6y43vcF5kaew3dkTtk3Sxr2C1TK0wjc+zEOYWdJkfdfKXoYjKkORkN4joRxMBN85a3A0/e5sEWEK56E+aqwDwNGJfcwe616wVpqrF4zCzvk3G3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlaMP9VZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220bfdfb3f4so82162245ad.2;
        Sun, 23 Feb 2025 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329037; x=1740933837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZw0QJRtM6IhR4KZmh2KNqroHre3ebnX5GDU+1y6qXk=;
        b=WlaMP9VZRsohRrWYHbk4AbUXEfMt1i+S3ts4Z0o0QfXd32Qs/n4hDfYwpOdOcDa861
         e9aQA0PSgpEDi0krvkfquG+2o+qJxZvHLQU3HmhNIIhhg5SPN3BG6GK2gKko+SLq+zqg
         FgJbB6e5lYguV8TUvOx1jubOmDWCydVw5cFshvmLNZsYVi7tcxk99nNB4aqhjIq0gKUa
         vBFMZLFpnKnSrFkc1j4rAPi6WzN0+qFfhVqkDb9KYsOsiiUUrwYgK2EYGsMkabKDgwXK
         nAixB7L1eualVy1xKOEImoM/Q3TtEb7+6TDPyCQo2HieWvQZep7mR0dxnGSBmFBGuLyu
         nddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329037; x=1740933837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZw0QJRtM6IhR4KZmh2KNqroHre3ebnX5GDU+1y6qXk=;
        b=p41yBlXyuqmsJPVY6WajIlrGsXavFe+nl/Sowd4smJsLDZHf45xp6oAr/3Njo+j7fL
         QbNX4VhjPNGgLUJXHFl3p445mFa9F9h2GRvg3IZJo3B0zKtz1+luzZOt66AwvtDnFvtC
         saekuaTMY80zZ6NBO0g7Ak6RRRtr+9/nWqAAETst+s21aLPMmEBJmAXQboMEAjhPWyzB
         FaOZAKsJo+dcDBpidxKSK/NX4a2pQEWzJ2Kc1YFu1PvWfUP+mSgkyCfKYh4kw8wlXkjg
         pB4QnlpE+NeHBXTZpV+N2EXxixOL51YzOW2RkX38F5BAwTt63c3WpDtB8Vopkc92h3OO
         YWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOp2gewHu93H6bEZVdM7BkpAa7BbOEJZBLeuph5FIwP8i4YPAZT5WPPrkNLMHSw6g6AQB26OJjX+s//to=@vger.kernel.org, AJvYcCVSzoLqGkVN9QyPZfi1+JhDNEY8BP5a2JcVRBrVt6WYEAe41xqcIARZJfYlBKKD6wyWKU737RnnmSM392Go@vger.kernel.org, AJvYcCVlmxxiIOV3CDu9M2Wg7suwL5hzamHjSohg2GJckk4FV/+4M3gGURB7Pmn9GheLiGsWfYTeFGJwcwDTtHA=@vger.kernel.org, AJvYcCWHSWIAThPEQZZfeyuE5LZnc0T6cw+m6cOESGu3XhwQ+OHheDAIZIVjeHc2c7SlZFED1TUCPMM2@vger.kernel.org, AJvYcCX7b1Ne4uYWWU8cd7hpdCVuEvyBnbTZqXUGkD2Dpe7kADjU4qMAlYUPYX3KcOqYEhnS+6rwxS5Ham16HG/AQlA=@vger.kernel.org, AJvYcCXbDJ+VWDfZ9t7nVtz0snv6W+S0EVVc7oJeeG3MX4OlYbpZjR2ebmP/6w5aEMrj+lCbEhU5nHxteVYj9wkc@vger.kernel.org, AJvYcCXt7B5ZwJxm80ChPwPayYE0Vy+hmSRGm/5H58bJwhcL1u4VM/xGeh+hRVckugF6BAB8Cug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fY1fpGZU1a/p2bhSf67ybd5X0pZgPRVh9FArcuOW6yy6VWNo
	e8t5Xrq0jxY7e7IoXAuyOSCosjJtFbdbU/dDOV23oSvPFsfqZaS7
X-Gm-Gg: ASbGnctplhvF5YIZmJrS17fTwkd3nN/JsC9nm60daCRKBUkwO93SG+7tqJkGoVaLq6L
	nWXolo9O3NHcQkwIJqsqc/rFL0YcSq8+lS7ULgbnzfljVm4oQjmwh2koHig33C5IRDX7vHrfdap
	ZhorCzeJyvsRUWv/jBtK4ruaj0Hh3R2VSoIjJ06kGFQpB7T0CklFYqtMUgtly1UXrYb/erzQdWw
	ULMP6w0xKuznLjHWfOQ4GJp+mi+jdfTREQHoQ6ApL89dep70Ml3FtpYK7UE88EDiuZ9dDMwakfb
	9q1MGaYwWfqlxYb+XZzQ8Ud9TTy2A0Jo6lux/Etoc/hlohNYiBXo+A2D
X-Google-Smtp-Source: AGHT+IEgNthmnTYYE27hPhlCIM7V4DPg7XXe7YBwN1u1Fl+WN3rwEYwr5OtCEkA4s1cdBmE2mWkiww==
X-Received: by 2002:a17:902:db07:b0:216:73f0:ef63 with SMTP id d9443c01a7336-2219fff4377mr185099965ad.49.1740329036761;
        Sun, 23 Feb 2025 08:43:56 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:43:56 -0800 (PST)
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
Subject: [PATCH 06/17] media: saa7115: Replace open-coded parity calculation with parity8()
Date: Mon, 24 Feb 2025 00:42:06 +0800
Message-Id: <20250223164217.2139331-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223164217.2139331-1-visitorckw@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/media/i2c/saa7115.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/saa7115.c b/drivers/media/i2c/saa7115.c
index a1c71187e773..b8b8f206ec3a 100644
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
+		if (!parity8(p[0]) || !parity8(p[1]))
 			return 0;
 		vbi->type = V4L2_SLICED_CAPTION_525;
 		break;
-- 
2.34.1


