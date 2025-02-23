Return-Path: <bpf+bounces-52275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB2DA4100E
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B646818969F5
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D436418F2CF;
	Sun, 23 Feb 2025 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbRdQ1Q+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBC13B280;
	Sun, 23 Feb 2025 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329052; cv=none; b=quE9H6VSbGUZwCWVZ7RZ5THHReQ+dfcJaaY0C/UpiydLo5wYKOHokdXBLUhv3KWOtH3wptI51XhPiy/aYNZ04h9zZxNuJCVHJmGlcTBo64azW3MOTasLIlLbZlhsV47nIMBheGaAVKJI5/IwmQQyY6TWfC/lUcmNFwc9M4uK+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329052; c=relaxed/simple;
	bh=CbnMmjg7M9xhIhYb1IB6TOhn8N272SVk7DyDeXjNNRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LARos1UeyvQduEK6ludAmGLbqekplNefY6AS5yOt6/hFTO6dofALwXoKjKrkO7ejTJCVZ/TixivCKLXXcK9QvABtC2bBVFZ1Lcni5/DO94CBi8evUBwNfDpTsJ3+j6Agew2QTRDWg9MtZ6FC2VN2y9J2EsScXrMeflhGYP0UOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbRdQ1Q+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so7380189a91.3;
        Sun, 23 Feb 2025 08:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329049; x=1740933849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hjFHt0d5k578dEe7TlBSwZUIRnR5xMHf3Vffd2Ioq0=;
        b=HbRdQ1Q+GdmZWRzMcJxD89urrBFY9zS9UDqV4jQgNWcupAYtmuStige1fQV88Vz3U9
         pNoAsF8A5uONFoPNVeez+Ex0AeQwxI76KT86kZWRRHtGeMD3rf6av461N9rfUotVoeDa
         vXkkPwOObp/Gp25xposvXvApYKUhTgc5xmhVY91RXYvvbmzT3oa5hQb9TsfA6H+seKmO
         ntV9WGo2dS5U+Eu85DsIMCz8+PLoFrA7510gA52ldKr0EGuvlWTpsHTaViHqrlWfd+YL
         4sF7vPXfZL0izTqJ5cpabyljhfw1vdW0Ioo3jG30/paAEc/FDkDGzkH+1YPvcT7pDacm
         viRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329049; x=1740933849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hjFHt0d5k578dEe7TlBSwZUIRnR5xMHf3Vffd2Ioq0=;
        b=HYACTSRRr25PAVretGsp/gYi2OcjovPzqFJRwdLnd12ojuhVix2+9AO1sbGTBLW1xk
         6HqTlXajKwGvNgTO8iWWHcyyfRx8aX54awsbBP0UVsTYn35iY6P/Nrgpp+P/S7Akudm1
         LUaIFxgnFL/i4WC/9DQQypoKvAU3j/YDsITUpWp6XfpCWgQtNxcwVUaIz0EUtA4BdTHF
         Z6usMy6X/vhxaMvW2V+Xh4U4pso1eTdiD/Zjv5ZKExdiyd6o+287jHk86vdBAMQv9GzZ
         2Hmv651PpE5Uf9gwlWV5sxzdUpNP2f1GsqcxF4N7ttnxndkBcZ0tqvQ++Lc0ul/uEyRo
         7rfw==
X-Forwarded-Encrypted: i=1; AJvYcCUwLFaxnMiZspWd2e4Stuum3qlcY2yhqjXvuQ4lj/3jKp1F+ExkxHzR8IQa8Lhl4ZKYi5ThRMO0bwfhuQUl@vger.kernel.org, AJvYcCWtBAQ/VVF3p6YoaxFO6fP9Ov/dar46dJKwasMUhC+nV0VIVK3YLbtUvIK8r7vF97x5Lce/NaMGqwyv1oI=@vger.kernel.org, AJvYcCX6WvJTFcPcFFcCb28CDo4XKiONIyj9LS7cohLAbKpzdDAyK9WwUginw3pzEp/4/0Wdtw/GgfM+lA35ATS2@vger.kernel.org, AJvYcCXFTmz92ycJvLCEI4Dw986uEGTO1efApiYCVcx5XPhV+QjaTsvb4/+nBWnbul8fXTOwuvy5yrWtdVbnutCUakY=@vger.kernel.org, AJvYcCXjzUm6cNQD1cA3e7Q2bJSvyVqTb+98XPMzfsULuLodFQsktR7eL1wL7Erf+Br4w2TcY44=@vger.kernel.org, AJvYcCXqVArIe0+HeLr+4vYcguWFrc9sTaKCXnj3XYpAV47TkreQ8wzp0vqpWUZxp4XRow+ua1VWjC/d+qpr2A4=@vger.kernel.org, AJvYcCXw2vthBr+k2sQ4F0mMSg43ZUBGd3pFtPFNXEcwocn8A/oWD0apG7kymqSx7lKxO6Ab4Ilk0vyj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WwoEmhP9+QhEmaEoDxReCFbw+BgoC3Bf1ZuuGwmhS8QH7MDe
	m7uotx7KWG6JGBl5utLEv4d61Z1ZwNy5aFz+rc7TmgVuvskurK4C
X-Gm-Gg: ASbGncteE7DhFci1B4hSeJI5RaBwHA/Pc53YZohcSQ568oh5WeJZF800JGQy+VPEb5v
	heojLglHVI1rsJXXZA9sV7rNCdvBOTQxouRVfEjKNnIFEAO/JuYU6Z2OiqDn6LCYU1gakB5TfDj
	t+ymoxQ98t5K2viCLSD8d/gQbM2fF+e4KfSTQ9K3qLzF/1R4PTYHWFK6zuaiVOEhv3dTkJ1w6QJ
	2JtR7jVrz0mQnWEp7f/JgsRciE7Ix2MixeyohTO08S/PMafuC8GSqtMVIIU2eqYPRw5ZL8V/kbD
	wi562rZ2vgm0ckVZL01VqJhy9cGVJrgkdbJ0J2KeLC0Zfp9mTfibFaw6
X-Google-Smtp-Source: AGHT+IGfwHShsfiPT7dt9SjKmid9dTaP6+iTVws9nn060cC+xpKYlrmp1TQEmd1LFjVUXo+AvslnXQ==
X-Received: by 2002:a17:90b:4f4e:b0:2f9:c56b:6ec8 with SMTP id 98e67ed59e1d1-2fce86adf4emr17900240a91.10.1740329049260;
        Sun, 23 Feb 2025 08:44:09 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:44:08 -0800 (PST)
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
Subject: [PATCH 07/17] serial: max3100: Replace open-coded parity calculation with parity8()
Date: Mon, 24 Feb 2025 00:42:07 +0800
Message-Id: <20250223164217.2139331-8-visitorckw@gmail.com>
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
 drivers/tty/serial/max3100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index cde5f1c86353..f5c487bdc56a 100644
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
+	parity = parity ^ (parity8(c));
 	return parity;
 }
 
-- 
2.34.1


