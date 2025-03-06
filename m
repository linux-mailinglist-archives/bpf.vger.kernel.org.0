Return-Path: <bpf+bounces-53477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DCCA550F2
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4810116943F
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351023644F;
	Thu,  6 Mar 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e50dwewd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D772153D6;
	Thu,  6 Mar 2025 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278420; cv=none; b=iLvl0fmd4JU++xwNAbM05sno8yAsJnKG/6pObOJfKp7PhzgBuEuaZfUJju+b3NDNtYsmYgwRnTtNZDMnALeAF0J068qjcWcjVcCvmaz+LNg2feeLgwo2IlJulkoSNgWwii3ZIlH1wyuTB7gAxnAmqQoNpMq6KO5FaidaHCXlSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278420; c=relaxed/simple;
	bh=+p/YAFe+kk9OWZ8tBw9OGe2ynkLFMgdD4C/iDJ1Cf18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRlqmKOUcn/DNk/UztMfesvpdAwsaRVXqH7JKemjkPso7d8uYWpQwPfXguNgmx7STcbHyKOr44eBsjDsTlnY8ZXkLJdUJgEwvh4KaZFCPjjZTT2AkieaXtV+swsqhNKE55XZBxzhPTb3Wlm2BfGcAbLYqOgbCQIV1f7o4uGvLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e50dwewd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff04f36fd2so1704361a91.1;
        Thu, 06 Mar 2025 08:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278418; x=1741883218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLC46Ss2m89bTVvfLJi0Yp7p5tSaqeo4vrmp4oYzA88=;
        b=e50dwewdRGi8g1VNC7UqEKJ5q4nv9j8+RtvsD2S0BP3QF2EAi8WDdYikHxjB6f/GHG
         AfO0VfsEfy/784EpFSsBCtGfRZCSPmZHSulvDLLMUEhul6WtMDd8C6gJQ/m2UhNOC5If
         w5RFv089kK+fq5u2XMyR7G7S1XyS3kylE06hCAeHQRdWuugJ9Ak295MDd4K1rlsjxtwa
         MqFiQucLSjwGwFDQGvprPlwvX2WbcwpcnaTt2Et6Ky2eMsrT2rkdNAxmT87UgkLM/Qmj
         YoB3ANPxXk8++j8y5E2wPauT5f4ieifn3OqqtI5JE0u6Zsfthd6UtGN3p7cr9wItQF05
         uPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278418; x=1741883218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLC46Ss2m89bTVvfLJi0Yp7p5tSaqeo4vrmp4oYzA88=;
        b=Unk1t8fWSQKFSHZdSHwxLNW7MivHYBaPTi/ltKTqRDhQKq0SFMzHeKlsIwmF5NZr2u
         HYL7Y3O5XyDQpivLrD3SpzLUPK9Km4BlVAf0N3Fb1wa9PIjQLyAb7qXEruqv7zdpFsrV
         eAmw1viXzwCA7nwdHci+95IxGmzS4qOwCg7Bvf5Hma5usgpucylpjvXoZFBH+j6biJDF
         yPrfWy2TS2O+qlTLjWlq1ywx14kCDT+nu6ktTM92wRbDCu+3FC5pKUY9KhtXy+TKGwGK
         kyQkXTNBsnEd+P1PliapnzGl1LHD6y4SwC4INGPD95woI0bKUn8iVTfOAqTx1Fjou/Dj
         HucA==
X-Forwarded-Encrypted: i=1; AJvYcCU0OZZIXaNnX9qNEaVbzz9XAzpUv19FJoH12SaWV3X74dggZvNWRqbMkstlL+GPr/M86Go=@vger.kernel.org, AJvYcCUDtgzcXEw4nPINZ+kam3o5XOplp+1SIEj/POGMGqMKkuiMVek7qIgIBLvny5kggMFTKjj3ZkFl7WwsuZU=@vger.kernel.org, AJvYcCVMZLj8leFCt1lJzP/WOTjAAfNfZ2gYXdDOZqdyC1rQkCEOiLz791Heu0SzPVaYEqTn6G7PpU+QFznWrnE=@vger.kernel.org, AJvYcCVYJ4DBtQQC9TZpJBnXxyImc+LcZrT4J5ubi2r23FCCLBGuggzxKkP81hAve/cuwXwmocdVJQEjYbdVw4Go6co=@vger.kernel.org, AJvYcCVYUqmLUYQfulqXubUzVoAi5zhyFebWecqOQkaii0g0/FPYvux5CO9YmbIzdWB3SD1qqxUhgx3rW5T6Ze/e@vger.kernel.org, AJvYcCWr6IYDLyYe71ii4Mpb+4THC8UqR8azC/EqAsaY3KovVyR4aKAcZwvXR51E0QgecN1CLC0e1HAkd5/GBDoV@vger.kernel.org, AJvYcCXkQEqpTaqoilvRWJJDYrD0kxmnJxKXC0E/a430HcGHjv2kWeIpagWyxX+96JzXkalTJYN59KK9@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzYsQTtoySvrMZlgfGCxA+NP9BdCagVnPQAqD1dPmITHSu/1C
	UTxj9tYPMDuGavRIyPGt4CvPEMEjCW3wOVEapZ7T752RwlpbAbis
X-Gm-Gg: ASbGncu6XlFXGK/wHGI4nQeYE/yFavfg7aPrf61ZGTyDxxbd5QtfYkcPRa6wzgs45OK
	hgU49NynSPU+qaabbtMPoZZjGxCHhybKixh97WwNpbEoB80RxBpLoghmtylf9siaXJe90IXK6SH
	w8+QR1kC2XFJAm7W4q2n+Ovd0/n7fexGzs8WM3C0i9Liw3mpeRUYvUVU7pwjVluu8iI4hXzYtF0
	g5L9elP9rWpKKWm6p1kx7MuZ9enjpyMYuSzuesYVp4ZEUf6xqV1jy4xN5fU8G5vopA4Bh2Zm5vd
	vU9j02gb0tURiV68IXFN/FHpArZuGs3TH7Q2IYf35cG/Sdb/TRn1EEUbsnCO/U43IYh7Cs/J+ok
	=
X-Google-Smtp-Source: AGHT+IG03DCzCpNpvI11hw07lC+sk1Ut5naphaEWX0iSJy+1ysJZeXoZKrfH0dsPOSnHxsIbzbSOpg==
X-Received: by 2002:a17:90b:3c87:b0:2fa:15ab:4df5 with SMTP id 98e67ed59e1d1-2ff497ccd9emr10053018a91.34.1741278418239;
        Thu, 06 Mar 2025 08:26:58 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e75bfsm1464298a91.33.2025.03.06.08.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:26:57 -0800 (PST)
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
Subject: [PATCH v3 06/16] serial: max3100: Replace open-coded parity calculation with parity8()
Date: Fri,  7 Mar 2025 00:25:31 +0800
Message-Id: <20250306162541.2633025-7-visitorckw@gmail.com>
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
Changes in v3:
- Change parity8(c) to !!parity8(c).

 drivers/tty/serial/max3100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index cde5f1c86353..419d74043498 100644
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
+	parity = parity ^ !!parity8(c);
 	return parity;
 }
 
-- 
2.34.1


