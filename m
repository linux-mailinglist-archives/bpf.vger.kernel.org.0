Return-Path: <bpf+bounces-52970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E45A4ABF6
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C3C3BAB7E
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4731EA7C6;
	Sat,  1 Mar 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDkziE3I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF21E0E0D;
	Sat,  1 Mar 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839189; cv=none; b=fVSuUrshaoaa2bETxesUi1Naf1Rrhb6HO73a8MZCgEtHOSlWmbDtlnvtYesL93at28gy8LY+y5Wnz/3MmWPxgcJocF/5WBqt+Ib98kh6XoHbshIg9uGdB+tFPczYVs/U/8SDT9rd5fsVhuLUeuszkEc3RJcy4RoloiRGIYh4fiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839189; c=relaxed/simple;
	bh=fpYEQHVmom7fh6D/Q1MDqtnrl6Xu5v8oqKaAQat+kYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nGZDiBHcor02l3yiXYy2zCRF6WXhLFvZoat/ELshWUCNsNcDG21p0DpjlpxVaRqQEKhTCMq8Ot+MvJQBDoa/tHyh/W9Ehlzm2Rhy+kD1+V7XW5xgAgm3A/2fXv/vvQhDId9eTdh0E4DKCfJx8p0GdeZ629Iuk5HbzLtX2Q6ROGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDkziE3I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223594b3c6dso51918675ad.2;
        Sat, 01 Mar 2025 06:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839187; x=1741443987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp3kGqc16FF01of4e/8WmkeqsdCblTk7qrBu9qHKlh8=;
        b=XDkziE3IP4A6E64xMhr765g/non2Ln+M5KjDeulP2jUAEdwTi2V/apuQyL5IZ7rRjX
         je1pgVKz7D4zoUJcbUhcdZDgNvbkB2SLYFwLZ3pxuc93vhcTdUsKMU/lzuokTHZDsY2w
         3/hYCpjXBppFP/4O9n/tTc1kGbDTK5bKh+EsjO5fUV4LxnsXNsQTzZQhHEZ4szRreVh9
         8Ke+WtLnH5p0Q6cxk3mL7ivDtbGBbzEC27IWajiQlgf7Duo5+BtWvccL9h48ZPlgyIHO
         rePmYS4hoFmgYgx6EjMC4C3rcuM4sk0jQzJDz/zmG0obQzU3TlWs0hRjterF39Z7WS9v
         GMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839187; x=1741443987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp3kGqc16FF01of4e/8WmkeqsdCblTk7qrBu9qHKlh8=;
        b=aecsUtuVl3rkJwBP/Gcle1cpsLHuRsoDR+/8fyflYSBtPU8OMQFGLiYPM1dKu2VT5x
         qZhZyi4dvgj4fHGSIja79pCxfxirEohQ+wbktGeLf7LDhGdrYSbab6UXFksccXoDWPrE
         cMMai61ZgjCivbhCVTPhI6+03uLyGTHxx2Cxpf51Nprsfz11FUBOzFWB136y8mkwGPE+
         lXX4RxacWGW90om2roGJ0Le8Zvq0YcnNZXgElh5KK/tXIuKFW8yuf5TYuD4C6MMQVscv
         jzZM4u1Jcax8n8K0zw3zpY2W/SpoV4+W7DgpSkqEaMFRfWyiyBE6L+GfYEBeBz2OG9b6
         Ib8A==
X-Forwarded-Encrypted: i=1; AJvYcCU71szTG6jnxFkT5EBQaOdCiZHLLN7LLc7Ii+mjwyxN8oc+ywzvDST7kYkt4EGhd0MyuhSHgAlkoYQF9e04@vger.kernel.org, AJvYcCVAtR1PBBoFhC507j2wBMkYOWms+z94V6wtqqNXBKIgjzGaq1Hm7qsDxRnOuN/GhtnryMGXnLSS20lHscJYZgM=@vger.kernel.org, AJvYcCWXQaVtRutCNAc+a118rVFGsYwqOUXoRnmgO+w1yvxhL8qXcOxIEsQOXNSIPAMufva1VRI=@vger.kernel.org, AJvYcCX57v38CWyptd/G2op6swXdhOiiNkcBezDlCKfEoChibCSH43abbLX1ki7NhJaxkHNTzRTyPhok@vger.kernel.org, AJvYcCX5NyWUtEaIn4JzkEjcji9fyvCUphPEtrPmgYxqfcp8BDmVUp2TLWuD4mbSHIEzaEz9BHvtUJ70RgvR1G0=@vger.kernel.org, AJvYcCXCwaLsTtjQNco9Zxv/ZCnFsFHQ/6+kSuEOksHYtzuefOVMNmnJpuhoHTW8lQ470c06AWZezwccXkD7WjQK@vger.kernel.org, AJvYcCXReJHVcrfUHL9CaL3qLAYFwuDly+QDzkIGV8+EnmzGXsQdVdJz4w6othP4vLcymSHkZg2n1EvJVcKrFZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzktQrzboXZ0PmbLSgSR9I6xb+u7WYoKYWioqjh16BqUr7I53N0
	dgtLe7Tycud+oSRs3YRPIjWyHTTOPnioYmpk4UYJt52TxjMSG8s3
X-Gm-Gg: ASbGncszr7xph+POQgLi9Mj6kus7tHhtnChONsdwIq4a35BBrXZbm1Ax7VlNtAkR/Rd
	z5wznhoYuaTlnXUD5xcIGVIfjdWLyCqHyaDftKFuO443kTkZXS6O2snXH62ldys8LOA+cfRRV6+
	eUKCJG6S4shRVQufOeeLimbvJt6weM4dZrN4qR2WwX3/bWBbfS1jc5ccaM2kmLAzEgKY9W+h0+I
	DjxY6f9bYAlSLvmt7kLyJ606+BMWLuClS9cGYywQ5T8vbaeCxNW9PYZ/eFEhTskjS5la/meDbhw
	SRrvD5ytXTjSSkaE/Fmn6FdUJ4twmXIq8OrVX7VcLtpBYMvx9N6ocFcJhllF5sYg0X/ao1pPW44
	=
X-Google-Smtp-Source: AGHT+IGHEYprq9u4C7FchZ9I6Y/Ibnse4qNPj1GVk/AdnINX25zgN7NgXyYUydYVyaa9stUlYFgdnA==
X-Received: by 2002:a17:903:198c:b0:220:e1e6:4457 with SMTP id d9443c01a7336-22368fc987fmr121177295ad.26.1740839187181;
        Sat, 01 Mar 2025 06:26:27 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:26:26 -0800 (PST)
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
Subject: [PATCH v2 07/18] serial: max3100: Replace open-coded parity calculation with parity8()
Date: Sat,  1 Mar 2025 22:23:58 +0800
Message-Id: <20250301142409.2513835-8-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/tty/serial/max3100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index cde5f1c86353..3b05ed113a67 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -16,6 +16,7 @@
 /* 4 MAX3100s should be enough for everyone */
 #define MAX_MAX3100 4
 
+#include <linux/bitops.h>
 #include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -133,7 +134,7 @@ static int max3100_do_parity(struct max3100_port *s, u16 c)
 	else
 		c &= 0xff;
 
-	parity = parity ^ (hweight8(c) & 1);
+	parity = parity ^ parity8(c);
 	return parity;
 }
 
-- 
2.34.1


