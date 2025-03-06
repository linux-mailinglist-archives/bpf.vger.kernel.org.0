Return-Path: <bpf+bounces-53481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2ACA55138
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D223B045E
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559E623E32F;
	Thu,  6 Mar 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCkH79B5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E521ABAC;
	Thu,  6 Mar 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278460; cv=none; b=mluZyD6UHvXMePQqaedQddIix5t6MnpbRZMgnBKv7o1V9dTQ7LLs75nfYp2YSLT6finj28XGcJLrHSp3hHL2eYwt5KBd3VfQI5BOoPcue2maR3KncOm0qgrt5wwWKlMvtDrV001Scfzjcv23Sa6wV1M9OwD5t0tKCetLrVlpVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278460; c=relaxed/simple;
	bh=LKQP83Z0dDVRvLCdrMNAz3pPTpKO+Di7Zsh2SQ1o/Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g8McMBOorLJgZZpsTtJsjQA0f0dLMkLEx9Hb0pAZB6CcSmzbKkxNAN0dplnxgIx1ODYDnSwHqP5khMx9kfkHm2B6xHoKMkaiT+zKA4jImCZ8Fkw6qIjC5R6sMKZZj3ciBc8GfJgjs7Np92fy3uyV+WAdRt490zTU1dcfOJHmzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCkH79B5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2feae794508so1529850a91.0;
        Thu, 06 Mar 2025 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278458; x=1741883258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ih00TRqmhmd1Mh0sl7zFiAmpBAeBPMq/8Nno4TrvKu8=;
        b=gCkH79B5MSWsKcw1aoVR5nExf91bJ5xUESnR4bdL6l5wWLDGhTu93cFygAq71TXbic
         eCnQpzgHVtzQZbYqVZ3UmC9MhMhk0ne8mlWEYWus2aIvILgjDb+lrDcZjLibDHTt5ORp
         uUOs0yHS6SRlNDjhE8QG/JmYI71OoOozI9StgAhujG1653R1Bp793reNqcfGuYmGNmlN
         Vv12S9kf3X1Ov27jeh5fuYbgt6s+bIxZCanutZWxvbhIc6IseBUReas+zbGmG6DqgpQJ
         MwPdz4dSi7mUesUEWUZu1ywQXVsuimVXEmqcpbdjcJjU9W56o0xGcJ3xsMDWsg0jO9gq
         JGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278458; x=1741883258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ih00TRqmhmd1Mh0sl7zFiAmpBAeBPMq/8Nno4TrvKu8=;
        b=iPRN5SbLi1qGlKwYbrhl+SDuAPsMRJ+wbTAi5LKPZLo08DaG1aRGYaUz8ex5s1+MQo
         80f62QMw8Ln/s9BM9juOLAXp2fBi9aCb8DtGcHORN0HZuLZvnqMoqlXC5JP5hJQtwJB7
         TooyZgh4NIe0OIk8vHTnvGciNDsY0B73fDW8LcDL2VNC7tNmydcyYj5xt1uT6oScY78l
         JcXqkTqzZ3pxp5lK4HZHppxyiDPhktiLscAT21v8RgG5gTOH5GIwKP4ApPqNVxhaAqkz
         7JGtexvIqxUrEGWq7EfJ/YDpNu86SAkLbe8UFacw2AKiOcrplLbKnrVO1k6CUp+UsqwO
         akFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/o6sNq/ob/FQVdq2rKvnSX8ewaY9LY0kLOXGUt4DuKWDl1EmNvbekABbYDVgeN2vsrHsUb7dFZ4t3+do=@vger.kernel.org, AJvYcCUteYIWz/RRGhECTNMjg+FMJiTzgE+kw9nk0041p/SRLYxPBSy50pKE3/y+dGzFDn9C4buyWvqgKtpxgBY=@vger.kernel.org, AJvYcCV0ucoJ9JyX85kfH7rKhKdLSgh/88ptu/y5OS+KFeWW7DPo/E6Q4+PdqHulQOfwHi151+5KQX9f0juAQ24a@vger.kernel.org, AJvYcCVcOmVBNEWA+QtUlLyveicCz7yVH/uvNkslf1ZYu7BwI80VcPt2f3TQaV6tQXqGOabJuHHsSlsrh/v7n1jb@vger.kernel.org, AJvYcCWBerG6Tcxjfe/z0jWrFmxkqHddzlx76yFpeGsZuXqlEKwY+vCUSCP5gv/NHalfdXYQ9lrscNdH@vger.kernel.org, AJvYcCX6Nq/ILj4/1APomW5Cx405EEawHddJ3GcWi9gjCQwi27JZ74cpbgZhcPPGN1rFGTyTtGjKUBUqv/OmBbX2L8A=@vger.kernel.org, AJvYcCXy+HRKDXjq9Oyd0rv9T3qP7tNWInp3JN5qqzvozNVbNW3No38hmPC0mywBabeFVPV3+HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLGE42Rn2hR6Q2pNoDaw1BQgTZvONh4aVn+bq0esQQGU6vQ7x
	9eIfhgT983dbIVWK8eLAiAiBNe/GtUfp8LldHlNDbRMFOXZTVN/V0ZQxZNYUvRA=
X-Gm-Gg: ASbGncsT/Gi4Pqw+OLQ+wA11x8Rs7uLnMUGUDQN+lK0H3kkepoxRUjhpjMURscJMTzM
	6d4dKUpOaGPA8e4wLawRQjx9/vv1iUSuDZACLCy/Sso8mrNjyDJ4teCYMAdrgGiy3mmFwBOcEiH
	2U15Uf/7na4T8NR3gKctq6ffIk0p3m4CxPHIHF+IvvDB3MNZdWlZAph4CW7PtKTSo4Y+3zZRlEo
	YPT124Lqgusmjvaz/9v+FWDFKt2a9eMsSfgt6+Dx3cjd42C4Eho3ibppuGBNT52ICOOwqPaFY4I
	f/+/GjQqYC9StVxqaWlG7rtfgDTpuLAKg2mezf5OQ7K9v/fYtSW2o6qodDJ0+uR6tqHQ3nJB53M
	=
X-Google-Smtp-Source: AGHT+IHic3IzGXhBZWP6zBd/pJJw64LoRGQ/N6k6+q6inZlCxRIB1pB5KkHjt//av4DrSwa4YWD19w==
X-Received: by 2002:a17:90b:1e04:b0:2ee:a76a:830 with SMTP id 98e67ed59e1d1-2ff49841eeamr12538794a91.24.1741278458615;
        Thu, 06 Mar 2025 08:27:38 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:27:38 -0800 (PST)
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
Subject: [PATCH v3 10/16] wifi: brcm80211: Replace open-coded parity calculation with parity32()
Date: Fri,  7 Mar 2025 00:25:35 +0800
Message-Id: <20250306162541.2633025-11-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity32() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../wireless/broadcom/brcm80211/brcmsmac/dma.c   | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index 80c35027787a..d1a1ecd97d42 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/bitops.h>
 #include <net/cfg80211.h>
 #include <net/mac80211.h>
 
@@ -283,21 +284,6 @@ struct dma_info {
 	bool aligndesc_4k;
 };
 
-/* Check for odd number of 1's */
-static u32 parity32(__le32 data)
-{
-	/* no swap needed for counting 1's */
-	u32 par_data = *(u32 *)&data;
-
-	par_data ^= par_data >> 16;
-	par_data ^= par_data >> 8;
-	par_data ^= par_data >> 4;
-	par_data ^= par_data >> 2;
-	par_data ^= par_data >> 1;
-
-	return par_data & 1;
-}
-
 static bool dma64_dd_parity(struct dma64desc *dd)
 {
 	return parity32(dd->addrlow ^ dd->addrhigh ^ dd->ctrl1 ^ dd->ctrl2);
-- 
2.34.1


