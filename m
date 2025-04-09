Return-Path: <bpf+bounces-55545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A7A82BA2
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690423BDCE0
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4F27703A;
	Wed,  9 Apr 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCE9UgMB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA13267B1F;
	Wed,  9 Apr 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213584; cv=none; b=t1D0IJBRDtS8P1WXgk6dzYxiN8Ko3d/0ZQCP37rCTrk/j26Gj0oF+i8ZDsbdGBrCClvXt8BbhhbHeoQJT2k47JDcAgke1k89u9QEippnGUzD2vVFc01RsrP++Ha17gtEiwhmr+AyFmPnajTCjzxDfck1OHNvGkngnPf6XjNFuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213584; c=relaxed/simple;
	bh=rxppiQbYDlsjNOLABuc/VVmyhqbUYZOfS3L0zA2RDZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APTUgvcrugto+hFcI0xV/MbtHl1ioMonJQ0GJUNQ2cGeTr8dfJQUlozmC058XKk656UYkOLhwZIsEhG1v3cNSERB1j8qCpb9ev/3Zy8f/yCNdqdyjXgwE+OMiAG/b1EQ6DbZy6xkn3l2uf3Pv+MP9+fjeZNObKEGq+TpSAYHaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCE9UgMB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301cda78d48so6369862a91.0;
        Wed, 09 Apr 2025 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213582; x=1744818382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbWQUZQwY5O/XbpqxBGOs/Motht++mnKBdeylhl46Ro=;
        b=OCE9UgMBW8wwa4M4Pqcuc6JXkE2gN5fDOnaQNhvnY4FKAb9v8Egth2NYJnUD0X2L4r
         mOoNNWeg6LtSfvjyLIhXka/6y00HQSJwwseGxDzhfAMJe6OhJaNv/5B6ShuNjND2tnDO
         3PB5a7ipQHCJqBctpyBNDsbePwPMUuYvJgMJOSYp8SczZvdqm3/pJH59c0N7wqPqYd3C
         w4RnJ66n65pu751585Dw1YcJSM4PWpzTuyIEfd7SOjwAU9ZwhjfWW4ae/XcducmjG+m+
         D4e+hda8ueYZ+QdNH/gZKqfDb1AEirYHbZ+lJaxjBJ4aEatB2JYg47tRiiaV22E3le5M
         ZGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213582; x=1744818382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbWQUZQwY5O/XbpqxBGOs/Motht++mnKBdeylhl46Ro=;
        b=T4I/p/jlaGyAdcVfGlq2hC+Q5tZHYyxBeLNCYPk5nGDJ0ppfPUFRlxLT0VwJlQpbIu
         ZU0uaK6PLYp7YHDYyhJxbIaHnkglXvWfEfsm5KNfGAKOBSeSq+jraJLhD5j5Kv5cpwNK
         R4ZsdmlGuNYWYg1cQ/OEdOGeDau6lnsEmYPwkT5VbxF9V5Me9njsXsFqs/NmS0sMOiiP
         tDJ1K3J6ak3vxBV2aQhNDRKk7JbDtXBjKnD58zD7oxrUl5/LZ5xGPpeAe8bHKRE2ufZg
         5SX676ZYqRL/Ea5EvPsaA5usfOWGqBfQ1tkaZpg4W8aizEkpGcWzfwwyKRj2GkgUi98d
         dVYA==
X-Forwarded-Encrypted: i=1; AJvYcCU7LwZB9ZsqmlvX/RjTjAzo2OUr0ulf+sZ8+9MH5Bvg5u+iRGI7YFK5JUOa9T2N0EO2gJPZsYLkX67PO9jn@vger.kernel.org, AJvYcCUlatCt4PSkS0yX+StbSyAPY5JOnCFSiPo0HZjRcJguAwOArsYaHyoIH9/JoUwBwx+53p0rTUd7SYrmsbg=@vger.kernel.org, AJvYcCUltoYOX3ge2wbrn69YKRBdao0MEk/oe9c2SfogEL2SsTbCQB9Waw2+jmrocfwvi5wyIP7td0MK3qgPkaM=@vger.kernel.org, AJvYcCVDtSY+xW2C4Ypd2DT4GhIo4tcvoAzLKySugIbmO6esVgcW2O2anF5HBjIt9SNybprXFUw=@vger.kernel.org, AJvYcCVwHWKjgmSXAtyOskv5xXsd+OhtCMjvm930U3foWYANzo2tKepxMs66ZiZMrlLByW2PyU903VTLvObc4IinzUU=@vger.kernel.org, AJvYcCX5I4Gue1UibJiGt+/liBFtC2d/G0rdIKjM2nhs/hHvBfQ0TqNPmXtYDgTIxtgAfpSTaF5Z/PLh@vger.kernel.org, AJvYcCX8zFxIcSXigSaaElhzJ0bEL3ELs8oh24eeLS68OeTPO+GhVg6ba4a5CboQfbJ4yD6qhhYN480GnlDzcGY=@vger.kernel.org, AJvYcCXv21nQ4w+2fVIDx3wLd6h8aZU9KfGIG23zJ0gkPWZhMjOFTRSiTOIQtf/3EbYnEJujGI4QYxMQ95HUN178@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQmdrm3JqHRoNCBoPEm2+uMaetbMufPCiP0tKVFQwD0jxJO2h
	teA0zkE9eF0IyChuPh/9Ldx8ZAyM09SEgme2r244YA8aQhkm0ilA
X-Gm-Gg: ASbGncvqQtWq//hKs8/ff5IEw9o71J16Vv19XgjlcsTnbmoPKewMhnuUuId+deZCxb+
	R0BzQ2STytJJWlRyt0y1uLhuOHU9itv7UuGQZEhLQCVKbHQpqng4uYvqT8suBr+cvh0iNhxoXxK
	GAd1nrMXEJBQ6I25/G+NeaoaV3XOxO1o+p/1byUZnQivVWrb+cY5hQdTh+aV3pdg4iShfNmZtvP
	ZNy7A9FKvf1MIYCj2pH1ZnmwRWbit+LBYrn17qIJzSAjz4kuTKp5zMGEZb9cACWLZxq86n0kJE1
	pxn1DUfpRFk2UXo91oYW6OaCTwmpRuV2kwRx+RteHQ7dUMDuKmx2rzkhURGUF4znVGkzsiM=
X-Google-Smtp-Source: AGHT+IEd3EC/Z0ac7A9mI3otjelgXE3L0dUH+HAICIEWTo12gF8GwwD4nirjVp0rJrYl27/5nkbmDA==
X-Received: by 2002:a17:90a:d60e:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-306dbc2a7dbmr4740684a91.30.1744213582002;
        Wed, 09 Apr 2025 08:46:22 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171991sm1952304a91.37.2025.04.09.08.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:46:21 -0700 (PDT)
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
Subject: [PATCH v4 09/13] wifi: brcm80211: Replace open-coded parity calculation with parity_odd()
Date: Wed,  9 Apr 2025 23:43:52 +0800
Message-Id: <20250409154356.423512-10-visitorckw@gmail.com>
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
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../wireless/broadcom/brcm80211/brcmsmac/dma.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index 80c35027787a..5d7500ee2d3b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/bitops.h>
 #include <net/cfg80211.h>
 #include <net/mac80211.h>
 
@@ -283,24 +284,9 @@ struct dma_info {
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
-	return parity32(dd->addrlow ^ dd->addrhigh ^ dd->ctrl1 ^ dd->ctrl2);
+	return parity_odd(dd->addrlow ^ dd->addrhigh ^ dd->ctrl1 ^ dd->ctrl2);
 }
 
 /* descriptor bumping functions */
-- 
2.34.1


