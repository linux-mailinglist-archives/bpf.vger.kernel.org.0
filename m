Return-Path: <bpf+bounces-52280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837AA41031
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122BE188C3EA
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684D20AF9F;
	Sun, 23 Feb 2025 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJrRDO4H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D7209F52;
	Sun, 23 Feb 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329106; cv=none; b=t6iQcEDrvoTrhIadD8lJkO2fUraZcLTkck85/+vemiMD3uKKwZjtJTvA5648s+WuPM8yPehIqPxKKWJ4ct4yikiuRLAChNdibo6v/STkUzL2qRRlk7QtM238RycKy14BcE5kePFiDaQzsE9qiU0Eq8qfgqRR905EsDZxFCIcBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329106; c=relaxed/simple;
	bh=TwYwZvCrklNfcmQ95nA9Xu2F+v+lRRPBTM6pl81qOZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2sWytL9Bksbl4MTRYAdNQ5SkkG4uERxPVLEsV7ECrCHCwbSnuMBrMQFW7jm1O1rAlXSCrGN6J4Mc4veBFGsXEYmO43LdgUuoBjJXtcp4id6Jt/LxcfJ8tYO+LSPsR8J6a7Exljo+0sAHYLuhhyh4ztLyY0W76v2VajSO/hOK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJrRDO4H; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fcce9bb0ecso7231962a91.3;
        Sun, 23 Feb 2025 08:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329104; x=1740933904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQRFKAla41Ay10wYFnrS+X/WAyPF0gKgODKhC/FC/AE=;
        b=WJrRDO4HwGn1ZbY5wFm3Tq38zpYftE+Y3tkiAGJsV7pKU/czwr+UfVg/uNFacEELDA
         KNyHEX0lYtuBx8KmMBaaw+vfEuNbgBvNWvQ6w2qge5IfSmEl9D7slkaGD0mWFEgAVSbV
         VyM99H48P/JvlPd/Vw9g183RePBp0XNuL7FE2uKk4OXmII2Y115xb/1gHPSt4gGRXBtS
         dUhpEtjnE1bVgWs0LnKoV5Ua4CkbePvbXCYrDCjEEDM5ryFVvOKHS1Js+kujfDpO6mPm
         hOZjmSMskwTEmWlCAjiYhVUmn5KgN+v1muo2gUsjkY5mSd0VgLMlOm96XYE5K5zqaUtB
         GYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329104; x=1740933904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQRFKAla41Ay10wYFnrS+X/WAyPF0gKgODKhC/FC/AE=;
        b=FcG1wJ2EB4qQazt58TiHedsFLTWwRbes5wDhhxvNSLHLrDuMDFd7p82rwggV2LgrO6
         kuhUhZdmQNIq2+G/WlTRVkUb8bsvwi+LzDdd/NXM5TYBpTZyTmSZ3wbqEGVrtk8XK0I5
         8rV3BwptjM0yZZPswqMul3IDhNFbN+efDDBNMkw3IwCSMU4iXA08EnISrRLsWu3qJj7v
         Kj8RgLXkbCxi1W/sSnhJw/zmRysryoT6SyLQhDVpgzdMWuqoS+rWvsfBE55I5dP0K8ZD
         IMLyS/biQjZsQ/PzRnH5VA3qY6hN/iREjXNQWKntF4PgN7AEgM5BRHLXGSzPW6bSZKh6
         DL1w==
X-Forwarded-Encrypted: i=1; AJvYcCUu8yHzO1pXoP+l2ElT40uAaRKK0EusGJpkwGZ1/eyu6zQXeGLUO66XTTOa//8hfwNcet3evX43OhIUXUQ=@vger.kernel.org, AJvYcCVh0VPfD33lnFTAmim6cr9rQDL3TyHaM+ztP3yuRGHNK2AWQHccS3P78ytI7Ar84Z61fFCfbxK4vn7+zwA=@vger.kernel.org, AJvYcCViOgQ7BkC6KsmEWwkBUZWta3E4QmuCXUMLP6/5jd9JrOK84AX/w5WSNjszXP0SJPPokms5/vU+eMIo/NrZ@vger.kernel.org, AJvYcCVpldCENwX8uGAIUTT6oDIMCj026OKc1PSuRBqPpjlQit7upspLe4M2ztm2Pn+FtYNpVeI=@vger.kernel.org, AJvYcCWCTAsUxtm/Ck1ZcNVoe8+iHi5Fl1nCK9W2rCyaoXBgGOzqFFtDt7Si1UzheYVnBzeLODQjtEWz80ai74Lb9yg=@vger.kernel.org, AJvYcCWbUrD2XRBuBqK70efe5/cPWQrbRlTll6iFJV2QK4JFNI0tm3AVwL2GcWiW0Bd/0ZphEDDLUnppOG6hfF6k@vger.kernel.org, AJvYcCX/56P0qRkLWWbdixhr72ip8PflClQvlOd1viMpn2VHsJ8hJKp8vg82RtAxysiBmjZ+1lSo2Kmt@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/zSJYG9db96yeiW/p8SQgUcTsXciW+V/jB4Igq5ECSxCH+gD
	jRKizmGxEKAVMoFfdPS1HrLy/4g4x/pFlg0GwDiNZ8GQ8pEYlXjv
X-Gm-Gg: ASbGncuTydqelhzyEFXc+mr+PV1G2HIH5umt18oanO9xfM3XZz3jLhAuWI6DH0zvAVb
	e6bPml7B0WhRcvRAVy8Hios+BOnvHXiRHZoZAfCML05QrlQNmEQA7OKAnye/AsHIYfoxXyCi0vk
	ieq2O3cBvEXltqg52JJyK5zxAHUXsl0Oly/aFavvunTJ3E9hG5edgaU1PKMJYJ2rEF9fKIcTBoz
	rSj5+O2lgpZAGrZE/HoJpkQI5bNpzccP3dI1BiNuHEadcGxrXChsrcn3gzk8DIn4eRa4Adjukcv
	iVLtt+3VXapdvWTh4T5RfwJ3/K4ygPbZS75Nb41ydV7SyzdCiGmFzNb2
X-Google-Smtp-Source: AGHT+IGJMVNjh2ZkbH600/jnGa2+6i7gpIXMvZAnEqRCXvTYi+XMSGJQL5WK3aQh+mNtGiJ0yE3iuQ==
X-Received: by 2002:a17:90b:2590:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2fce75e1b18mr21089922a91.0.1740329104301;
        Sun, 23 Feb 2025 08:45:04 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:45:03 -0800 (PST)
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
Subject: [PATCH 12/17] drm/bridge: dw-hdmi: Replace open-coded parity calculation with parity32()
Date: Mon, 24 Feb 2025 00:42:12 +0800
Message-Id: <20250223164217.2139331-13-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity32() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index cf1f66b7b192..833e65f33483 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
@@ -4,6 +4,7 @@
  *
  * Written and tested against the Designware HDMI Tx found in iMX6.
  */
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -171,12 +172,7 @@ static void dw_hdmi_reformat_iec958(struct snd_dw_hdmi *dw,
 
 static u32 parity(u32 sample)
 {
-	sample ^= sample >> 16;
-	sample ^= sample >> 8;
-	sample ^= sample >> 4;
-	sample ^= sample >> 2;
-	sample ^= sample >> 1;
-	return (sample & 1) << 27;
+	return parity32(sample) << 27;
 }
 
 static void dw_hdmi_reformat_s24(struct snd_dw_hdmi *dw,
-- 
2.34.1


