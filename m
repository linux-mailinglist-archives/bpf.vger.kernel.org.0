Return-Path: <bpf+bounces-53479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D4BA55101
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4003B16D29D
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43223BCE5;
	Thu,  6 Mar 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih+Z/hbI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CBF218AC1;
	Thu,  6 Mar 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278441; cv=none; b=Jb/0cSDBJy3bvXUWxnzU3CHcRS1ikhRdnlLrZgYtnAh+P3Fjev64UPg2kPi+S3rOMoDUU6o+uINLofUjuWPVZqfSem4HiGkbbbEoM0Ud1BCrVNphYs07pbhUbIbVgrIhrSTxNQlb9OlNSN7fYq8zdchk+NJUaqNeXFpch2sshnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278441; c=relaxed/simple;
	bh=3j2xCVO3a9Gv7A0MIU2nyyU4C5wyCWXboaTPOU2Xcdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+jfx20D9gtUCFqq+mV1+o96uJ9fA2PqIcNmJCFYvIl9IJTGPtY07DCJuojo9CUqOu+/In4sV9FpXg3DHFQ9b1ZEqu2hd3GUIS4EEmcNqouHdtfpX5dF+cXcCMy3jq5DHopa+2SYCnGB3jWdxr1jtRH6oLyx1/g6l0Xa9QUXEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih+Z/hbI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349dc31bcso16486155ad.3;
        Thu, 06 Mar 2025 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278438; x=1741883238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN5ImNH6dAdBfCykY87Jt3WvSMwHnviLIgPuEMqr3Q4=;
        b=ih+Z/hbI3yODcyYkdU52WfMC7XbuTBiiAWIc15+EbeYZca2nPvR9OI3OPJ0XvjnHun
         B2k20DQlSPVNk876jlsfGQWBJA6Yg/9GrRW1Qlpt1Kp7fXFImbYBodc4x2+eSiZRPA96
         hr9gieEfI3pxfWZrbCFPI1sQY/R/A+ecmCXMqSSznRbMm3z7HR5ljZaeqKman8l8vP81
         3zuJJlBBUTzNyEcJY6PWXUQgrUGQEK4ze1vQr/+hh/ezXOjq+36Y66iE1Gzb+uQYo9kq
         lGaGBCIZ4m+q7NnPzs8wLunSAGmTMim5tU8zNxREcj+TmaJzflWJhBXPYC5lTXhtRKx9
         aQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278438; x=1741883238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN5ImNH6dAdBfCykY87Jt3WvSMwHnviLIgPuEMqr3Q4=;
        b=lrjHft2NeI4dwjLPPNKZeYvfrFeXDs+eRp6jJgb8X2AFtOlnmiho76Z5yb6ItDzFhg
         SoNYFMy22OUc+pwnsjcAB0UhE6FqZkPbS8ST9B/Kz9FCkttPNFCDnJAtJzyERMaC1M7P
         0AyU0AHF5CxPRASvaxuRlvilS25NxyQMwY+t1aWc6LJYrkK1wJUGTFR96ASqYhxRQ/P7
         0NigqCzTdfklT57uMOsqfyP1KvL46JCFa8gFEUfnvqNilyIYmoRwK9UNe9ynOJtgQWoB
         Iety5bg0Uvm3OlO3w0B7a6P+cNz96l31LFbIAtw/wxHqCM2znTDO2pwt7HkrXQjfEpMQ
         RFTA==
X-Forwarded-Encrypted: i=1; AJvYcCU7TBqiUVBNiU6jQgIIxI0ZGhiGTAZjJINrL9wUQx7e31dzvqh/o+unQpOnBxEP0r4mLXPOlYOyTvirkFE=@vger.kernel.org, AJvYcCUs1fjJJeUvhJFdYYtd2mvwOK5B+WSuSOQkadm34wwfswpauUEhr+UuLSLlgix5XpBJq8c=@vger.kernel.org, AJvYcCVAAfbQgmcEJcv3j7uRa3JX3vr58PAQMnVx6J4UiEkv5L5ZjHDIWOyAp7RQgNgyRVUCo13ZTOoDh3tSdFjP@vger.kernel.org, AJvYcCVaFelyxMNUV/nnqgkxe2oLoEotsL/W1qoZAtivkIOjoHzJJyP8NOuWf0KkfOfwj6M4hX4/2CQ9z3gfAQUvvng=@vger.kernel.org, AJvYcCWDIMY0QoGh/J4anx9ejVkbgjam4XxBqKu1Yi7s3AqzX5UJcntUTEqwfumxDYDtpArPnn4R03Hi@vger.kernel.org, AJvYcCWRrATOD96ggCG/gR0erX1k+E4DSh+w/fxzdl9bi5wcQhO7rd1kDtzrMGRjvWZ7jCOc8+wU/4nRsklGWJJT@vger.kernel.org, AJvYcCXCidEQ83//UTWDwfB9kpMoHkR0dFCyo9cbZqjS52/74xJNBurKF+1xKzgFZzwmCxr9b1d9UNfLnxeG2IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgUoFq89MunKDTA/G53OfuS6S9P3hj6zIZvFLSTGym1zbqGp9
	HLWV03oXEiJHEsCmeO/8oZL83g255kXhK3SFV5Ey2DLyp5g3IS8S
X-Gm-Gg: ASbGnctCPzSvmJkVCz1phQm2Mx+T9cnK1aqgWI44iQ14SxkMsxzzKnN/Aa/dfqG5LZz
	dJ2vMMgTBawr27KgfY0pnDUaOEYVzW0W9U2vvJJ7Ty8VykUBhPlQZ996YYfenAWDB0+sV+yQ9jg
	0EJtNu84nOP5+D/lPMpCMT2WnL7F7wTH7qspSOL7v05InItxwBZF7k8sSwfYFPDgaqc/Ja4/s7q
	GVMiEl1irt7w7JrnHz/XUj9Spnt/Yp1470Iak6bNPNTp/+xYaqxvQ+oZZsIq9ODByoBXJCKE07n
	eMPMJCCWHqQjS4n38hiUVVmROakKVxW1wAJUPIlT7oHRuLpGD9w432sDLxTOciCiWbC0imz6T1Q
	=
X-Google-Smtp-Source: AGHT+IF18uiSk+IKiG1ozkM3lMeST4qvi8jhpDhJUoUXK6z5h5Y70JgwenicEaPtYCl0NNS2nVYnUA==
X-Received: by 2002:a17:902:e5cf:b0:224:1eaa:5de1 with SMTP id d9443c01a7336-2241eaa5f50mr17212195ad.18.1741278438234;
        Thu, 06 Mar 2025 08:27:18 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:27:17 -0800 (PST)
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
Subject: [PATCH v3 08/16] Input: joystick - Replace open-coded parity calculation with parity32()
Date: Fri,  7 Mar 2025 00:25:33 +0800
Message-Id: <20250306162541.2633025-9-visitorckw@gmail.com>
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
---
Changes in v3:
- Change condition if(parity32(pkt) == 1) to if(parity32(pkt)).

 drivers/input/joystick/grip_mp.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
index 5eadb5a3ca37..26a7ae785942 100644
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
+	if (parity32(pkt))
 		return IO_RESET;
 
 	/* Acknowledge packet receipt */
-- 
2.34.1


