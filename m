Return-Path: <bpf+bounces-53475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD69A550D8
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A9817A3CB7
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0C522C325;
	Thu,  6 Mar 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlodpozr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2EC2147E5;
	Thu,  6 Mar 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278400; cv=none; b=OpW+Ab0JxaJEZW22iVdpB6/5UsFNhwSxSKjqNYRWBsWBCj8FIH35QqfjyGPzBJ9gX6FWJMyhV2ZLbnFwLtJTgkGemo5Y5PiGANU+i7ewpYo10QwIM+sx6gnvwA0Q8JZbRLWdG+g3HuPV8Oq5NiOpQ64VTon2plDww9s72Ad+HBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278400; c=relaxed/simple;
	bh=JIGbdj519hBofglwm1x6Wa4PWHJoF7xJSHZGDTpyM6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eeaWuwIJejNv4Y2OC4U0JCp6FNoCblih5MdKkSyST5d8yvisKkv2i8lqmfsj5SWib/AdUemeKC6y+EaZU1tQ2rQKdG8iOLziMxLZV0FnIUORxL5JvRdwI1mdg4gDYdr1VPTvOhm55zkpvjJeCMbhsuEsIHU6W3ythgBja7IOzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlodpozr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f42992f608so1719360a91.0;
        Thu, 06 Mar 2025 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278397; x=1741883197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0Ho2aCKNYfg5T/o22fFzxZ+UyjSx6Fm0wn6W8o8Gr8=;
        b=VlodpozrEtsyJB7yVBQbWAuEZ3FILQTFZfdq+Sy2YjFV7zKhB77BwEsmW+teTdMZwp
         6vRTtopTGRzNWpOhjWJuHpmggGt6veijCa+kN9han/pU03oPm5uyhSmk/Z0Jq+iVm8fP
         cZVnVa7Rz442OQNSqOTRS1R2WmutVFs9CTJyYpOHvgFWFYNLVeWWz9SLVTuFV3Uh6ciV
         EZa6PND3ParJ9TIltyJcORcWcJh9oLdW/UUdV6lzq8q6xva/82s0qHgcICOK9CiNasHS
         rMGQ6ChY3k4X9VGP8e0OCsKhCa3ZGtbvrT3+5uTkH2fQ7udCKxemYMmnEKo4FtMtJtYB
         UZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278397; x=1741883197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0Ho2aCKNYfg5T/o22fFzxZ+UyjSx6Fm0wn6W8o8Gr8=;
        b=krfQMTMWJqdfaygyaH8N+W9/JvZsdzH2tz5dZpPO3b8IEKdOBNpAL1D2ATg8Sr+GCm
         bU8FbhptZTAa9YSvJdSsTnT98GgSxUfscRSJCJTsxBCiAQbKN84MjeC8ky1MEHxXAqe4
         zFuuLKjmPWFzIe3bR64Rgl0+0Dz4uTkafnf55hM5K5VQEk5o25jXbB5dbzsI19/ycxKI
         2/c2EFo4B2OamREzHIetAPsUEJsCjMUiBzEosT5+G4cdtnDmfCCts55tuu8qE8ax0WaQ
         GsrUfQlv8eboNuOV9KwJtvtjFphgKfFm9BBO1bNvnc8+5g5RRBKG/W4MAeXA44M/braC
         5lqQ==
X-Forwarded-Encrypted: i=1; AJvYcCURv8FIEbEV0YWhZe4Pqs5R+AFO3UwYj0r0kUiX672e2lT2H5muFF28CNtQ018ym/JnGOg0dn0M@vger.kernel.org, AJvYcCUnN03p11Gly4JLiHWbbphMXjT+Rth5joLeHBuN1m2HcojcE/3jVlbyt77AgLe0SgyoCVmy3z+kGEBfN1zCYcg=@vger.kernel.org, AJvYcCVHfKmu03iPISA+WN0Km6dIc6XL7pLhpUX/bv3BsVyRoipSUvFYL6edJIsdxkBkKzDtUk9tJQx1Gw/5AmPj@vger.kernel.org, AJvYcCVoVpY4XDCWkc9GiaWPgtpBFyVxkTNrChkqb/aHytww4kSjYbc/XGYdMG+iJDojSOpxIoo=@vger.kernel.org, AJvYcCVx7KijXj+WKOF88s0FoawDX7wlrHhsmB5e70r8WoDTBEeZutODNVVrfkZpHsLJrBl9f7ytJ46MFTQhMBY=@vger.kernel.org, AJvYcCVykCMGaNNb1hMYqFWgM1bbklTk9c2mPVSc+HVt/paFHZcPoOD0r14UEi0r+VYpa9GkiEaaOOV3rypeMi1z@vger.kernel.org, AJvYcCWGnvBk98+RRQGyeLYsvWP2/7A+tgxpB/8bTjA1FAd0XcXIbSbsM8vEQXU9RzUA6QbHOLWKj73UlqHd2xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9wozAGk56yy+H7ecISZzvBzxYbziQtbW6R8Jyui28te4sPZQ
	lWmRwgi1MnF7k+MCAWagAwh9XVWA7l5ZXdjeNe2vfS1MOiMbhror
X-Gm-Gg: ASbGncuK5+qYVkVLA62UXwB7oDGTOAnUUs/WhpxyB9Enpe8hFitmKWN+AB2YxX3zX8s
	0KGs2mLwPLj1CAwYz451n6+u4vfB2AgUJfcyLUxxNgjVgOAo6fWNlwNvTfmekjsy6sXYvAUdBwp
	3YIPJzrLtWTJN7+j/ENVPtzq8Va7zaJF/JSmBFelNCeX7fA91AXhyLp6bROiYOySYe0tiIC76Cq
	H3tsGsxJTxukuHZwXa+RvIl+WezwYuNdAUJ0g00oTd7nGpFrClbdWO1Ru5uFAYqPhWC2X5gKNnf
	2MwdB9wOdGRDjyjRagtX8v0LjdeW542Oak30TNsLh8Gs3kc9ehZ56fdt5IQ9E5T1FVFvmhH+8rs
	=
X-Google-Smtp-Source: AGHT+IEdHwa48DziWanocz8wQ67fQs43cM3+X1TXQ11+KVNWCpcETjdD+vdPtUkiB0WUQbIndA90jg==
X-Received: by 2002:a17:90b:1cc6:b0:2fe:afbc:cd53 with SMTP id 98e67ed59e1d1-2ff497a62c4mr12413101a91.28.1741278397498;
        Thu, 06 Mar 2025 08:26:37 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:26:36 -0800 (PST)
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
Subject: [PATCH v3 04/16] media: pci: cx18-av-vbi: Replace open-coded parity calculation with parity8()
Date: Fri,  7 Mar 2025 00:25:29 +0800
Message-Id: <20250306162541.2633025-5-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/media/pci/cx18/cx18-av-vbi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-av-vbi.c b/drivers/media/pci/cx18/cx18-av-vbi.c
index 65281d40c681..1a113aad9cd4 100644
--- a/drivers/media/pci/cx18/cx18-av-vbi.c
+++ b/drivers/media/pci/cx18/cx18-av-vbi.c
@@ -8,6 +8,7 @@
  */
 
 
+#include <linux/bitops.h>
 #include "cx18-driver.h"
 
 /*
@@ -56,15 +57,6 @@ struct vbi_anc_data {
 	/* u8 fill[]; Variable number of fill bytes */
 };
 
-static int odd_parity(u8 c)
-{
-	c ^= (c >> 4);
-	c ^= (c >> 2);
-	c ^= (c >> 1);
-
-	return c & 1;
-}
-
 static int decode_vps(u8 *dst, u8 *p)
 {
 	static const u8 biphase_tbl[] = {
@@ -278,7 +270,7 @@ int cx18_av_decode_vbi_line(struct v4l2_subdev *sd,
 		break;
 	case 6:
 		sdid = V4L2_SLICED_CAPTION_525;
-		err = !odd_parity(p[0]) || !odd_parity(p[1]);
+		err = !parity8(p[0]) || !parity8(p[1]);
 		break;
 	case 9:
 		sdid = V4L2_SLICED_VPS;
-- 
2.34.1


