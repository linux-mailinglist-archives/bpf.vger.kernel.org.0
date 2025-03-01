Return-Path: <bpf+bounces-52974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3BFA4AC17
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89423BB335
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED99B1EE7A9;
	Sat,  1 Mar 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR8b4VAe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8D1E1A33;
	Sat,  1 Mar 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839231; cv=none; b=GITxkXFBA1ZkTEgLiQ4ywCWPriUzawHGwkSgqpkprfPX6jjDWw06QnGPoool4Zjd907N0sG+Fkg4OELbCUiGhPtV0P3CeO4523t64/KYRTX4DKKVh37XY4iy8j15yCXllzDdVO99xi3b/QVQdB0by/i1d9gwVsO4/XRjEUIJbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839231; c=relaxed/simple;
	bh=LKQP83Z0dDVRvLCdrMNAz3pPTpKO+Di7Zsh2SQ1o/Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1lVMlL3OOa/z2n+cn2Z8rbFHELp/mzZr38gipMrHJoac/10x2+unEbL8jJ/wppxNX7GV4l36nR3bR08ye8Z74IDcO3YKEuR2JCe9dtY1JXC7FbSy2vAk4Bl0vJwRamnMBzXuOT6slC3uVV731fwDmJC3aEBul0E8HcB/v/fSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR8b4VAe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22374f56453so33974835ad.0;
        Sat, 01 Mar 2025 06:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839229; x=1741444029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ih00TRqmhmd1Mh0sl7zFiAmpBAeBPMq/8Nno4TrvKu8=;
        b=PR8b4VAebPDKEvNlDYHQGwovki8tyqWlMq8etsH4lo5bnVGwRDPwnU0KUSKpiLo7/5
         Gd8h9tO6w9lCX8FVk2CEQ2qkM8lV27UzMeMVeQcL+bpmGvlGdE+Y49+Zama9uXsYWzmc
         ICp07UMhpLuabfvpATZ0eDxzXljO7bMq/2H6Wv1lXsTB4ZeODxD+iFaLT7l29gb7rGUP
         VdAfauYlBvL6PiFpH1zMo0EijoybafDoqyI7k1SqcZ7wurWr8uuc7psXpKcnZjeN9MJH
         PIeF3i4DFO+LhfLeQFCtXQIpwZ1HcJS8zuJPu2pGlX+SUq/AjVopz5a6Ax6rzfQhPNVW
         UKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839229; x=1741444029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ih00TRqmhmd1Mh0sl7zFiAmpBAeBPMq/8Nno4TrvKu8=;
        b=pa7JybYWKj+OGHUlmd1J76JJPZCTjJrUf2WIrZsU0TZG7eMPV00K1jQviDwccjaysh
         FA21yodnlFsQ21H6igwTBEUF/KRNARf/jMTWMGGa2EOuh3dk7tozE4kNEHL0PH/VsPyT
         gr0cj5DVCgHecS1o42cOou4Nsn9OUtVpiPLvVfSMLI61wcdOb2K+fuWYmPYhUTEStgWM
         WvrjVUV2H/SePFp8qOkr99IjYZp47yuhzAgj/N2UipqNN64wFluaA73uuZyiRehilykP
         wr9dMn2hkEr/UVFZZsr/l2l/y3C6DC05YgfC/SAoj287nWa9bQqUJFNx2E/Nm0H6fMjM
         TN3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/NVypNLE6YrkzE87RCrj3CDgBZBwUVBBTkDiB2lvMFCtbkG9bRncOhuybDdojksxuv4/lDnO5q8pprYr+@vger.kernel.org, AJvYcCUeHTQAn1F9XD7UFBml9JsDMQi6yzSRhKuECkXpeUgW7OdzGa031cw02eABcS8vtoxDxQEBWV6arK/GjO//Ao8=@vger.kernel.org, AJvYcCUxUEWpMzeXv/Va5dtTPmehP8JWRZgf2wZ+C7oD8iMxi/XspXC81mkqhr03KT/fD9sYqyINBnQ4JXizvKk=@vger.kernel.org, AJvYcCUxa031uqT1KDQ9wXi+jhx1fNLAFzjcK5KkdMaSoz9lNXGzXKdKsfS61pfC4iop0wNDg2acIBUu@vger.kernel.org, AJvYcCW7snzzMx3/S6Bi3JudCOZScCbvrtAnd/K1GCs0j/9g7BFo6fLMrdxivJdX/trtqVcejzrm3jt1LViduxU=@vger.kernel.org, AJvYcCX9lk4/OfZdlhPZNb2+hiDT1KOqFVbuZOMZsJbBDsRWT9qnIVb16Jkb8Qj4qAo63KIKqtdgehekwRWi5PXG@vger.kernel.org, AJvYcCXCdUVXrdNLweZsSmXKiijtkjZ+/jXrM2AWNsvG6hsnAUcRkKKVSwCQvBfJwP6V1/OZlZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjTNgg9TOY3DpNE+qnuLGPAZieVg05RlXZT3vuZhnsIRH0Hvg1
	RLaaAsIY7VYKXp2G8qz+70ArIkFtRO/E3uO06ohDQuoKG+yGccxE
X-Gm-Gg: ASbGncsCetTFNJ7GvGq8CNX/OxiqHnLsWHrTfrh5ox4hWr7HRlIYsnNKWQjlQpjN1eV
	1uP0obh8KcvdlI5l8xmr/14fMjA8swPD8W1IArDMCdmXSw5CSrmixAjPsdfzGxkFrj0RVjKBEY8
	89r9zwX3RUa8ZzQ6c40OEzibZp+ePwx4cWguJxB75BY3YpmlI3IEwTbRXe3GmIg459o09ppf+5r
	OTC1v2DzwJpzxEB57fCXX5SCjQRJ3+y2VLoLfFvQp493AMvtBdBysoA0JeqIrbfE+lDdwqP0X4E
	5oiHWxYI3hBl4LZL99+Aiyhw6EdwnbhDVJRwSqNHtEybhqg/E3HIvQenyN9YEQDdL8JHezSH33Q
	=
X-Google-Smtp-Source: AGHT+IEWIU2a96xKy97Vw2OZbiqRo6ZsV5By1mOyMKGEerXJ25OnWhIdagB26u20PcByLRXKVw2xEw==
X-Received: by 2002:a17:903:32c8:b0:223:2744:cb32 with SMTP id d9443c01a7336-22368f732b3mr142906935ad.5.1740839229452;
        Sat, 01 Mar 2025 06:27:09 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:27:08 -0800 (PST)
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
Subject: [PATCH v2 11/18] wifi: brcm80211: Replace open-coded parity calculation with parity32()
Date: Sat,  1 Mar 2025 22:24:02 +0800
Message-Id: <20250301142409.2513835-12-visitorckw@gmail.com>
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


