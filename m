Return-Path: <bpf+bounces-52283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4FA41036
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B087A8EE4
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BDC20D503;
	Sun, 23 Feb 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAyoF025"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06321369A8;
	Sun, 23 Feb 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329138; cv=none; b=ksvvEjbdeJpVQ0odc4zYNYJ/wnN4yOhQzS52ClR3nHkQSkg77T6uC+avaJoVruSkllvKUwZqt9xA+bC8GKQzmPdf8QdH5aPy9+0gdXnr7wZqQVq5ULFSDZMA7acgiZN9UFUfMbVb4UGa4Qjbzvf1Dd9/prvYU4+xQ68nAGOWGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329138; c=relaxed/simple;
	bh=9MLeZfNC/T6rZivDo76ukvYaafOdf3Bq52OJ1FPtYmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AEPSAAoAf0cHolTmBdr8rIMVkGwOk8Q/J16olvfkjXaw/naOIsu+gNG4s52pPJyz/3yeQ+QCcGm72lnwxqU77MrIm9eXdW4XQg/PjqKKn14yqxqYo0HaDSdGacF2lSZuBsWUx+JeBKf91Gajtsl+UUJqOZQWyE+R7kOJdlcWDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAyoF025; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so5646230a91.3;
        Sun, 23 Feb 2025 08:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740329136; x=1740933936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H92cNXD8ivdLBJu7PZvS/WlFHsCPSxa0jaZByFXEmx4=;
        b=EAyoF025vyKYWl/BJTDDxjWmRZjKJ3aFhdeDDQNu7KuymnzF4EcVDc8n6QcWrhbFC3
         q6+KBAgGpACn2HdfWi8F/nn4o+C4+2sFan5APDpwG6sxdmqb7NWGSWfOYWWGzlWtB2Tb
         Q9oxyez01VKwLBOixsuSyIiKOXmW5UvDvT4UjMsOCJohsUbGQRQRDlFAfPFQ+BaIgbSF
         0XcaOvv8isuIrCr5QX4F7t5q4itRVrn4Z6rpf/KYiwB96ien57oYWE4PTD7SUhAHk6TI
         MINdOZYq/WoKoYv4Lbh/tQwNUPYdJKCngb35Iciet5VbA+6HjJB4Lp1uV1vbvFjwXGRL
         1SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740329136; x=1740933936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H92cNXD8ivdLBJu7PZvS/WlFHsCPSxa0jaZByFXEmx4=;
        b=cHWlfJU+9EkgWEgX3WPVk4ju7o6ZlATfoRFyJUGrcnpgQjJUzNtk7G2JiFBXITrT+8
         MvgRvHfcgDeHbI58I+O7Ja2pfzbhFQwIQlmJrX61sVvGHv9k6UTaYaDb6g9QQbjac4Vv
         QhmvqkyRW95TCRXp92zvMo9uu9fsig9bXNJPbtNlC6neKgUR2ArGhD9gozGWyThfzn5E
         YVcTdyQbaG88kt515BWQTRve7jS1FhLz4xIc9bchCr4c2UUw/HI+Ow8DIrvfTKdbtDsV
         EZ7Atv+o/nFYGoNWmUTtZE4dfz2KgdVhdT4N/q+Y5yU+vua2i4rv0/WOpf1Rq5moX9OD
         VbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUogcHBj9T+YK/DjQRmJJZjoaARunJZGCP3o6YQpF6ehbT7f7nhL1g1McJsUgURrOtt1naFhKBqZ3e3xVk2JP8=@vger.kernel.org, AJvYcCVteppFft5qPGu4sIzDG6HuOs+P5m+aisEoFefqCEz8ycNeUKCXD8yMrT1wcTqmHmOr7jGmJnexcDEUTB8=@vger.kernel.org, AJvYcCXBUXxxQ4xiIPlqzq6Dew2bOClorzOFmjsYMfuUgdAbgwCb6zPQiqx6N3fxN54nnLhxeoHURgRR@vger.kernel.org, AJvYcCXLoXZVqDOkPBnur3NTaTHkJ32LXgUhJ8Iqksq86KrmNsAeynlvh6I5m/CWgjL4RoUFM48cwkX66mM5jtQ=@vger.kernel.org, AJvYcCXbdUfOvL8VDAV/yrxS7uTxNXs4rGf/2l2YQpWut1fBoBck1ig3WrMCJy4xDXH260d9znjVm3AS68GCx2bc@vger.kernel.org, AJvYcCXsyn4nCPvqIj80FTtpYcjGLzi9SqQd4xfhq0gsHURUL01Hl1of1cPkV+V0F8i6DaahPI/tPS2YiBaAO/HH@vger.kernel.org, AJvYcCXxgoc9kL3RksGuBj/aj+Dyx3xq+TG3022p4Fd5Tr+yHp/m6ivviXdx6FKVzW18Lc+ZVnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBzlgtc8ZbSThYcUn+jli45lOtxqJDzAcqg6m3wpfxZnZ0YEJ
	vCCQ9cI1TJcVnq5aNOMpGR33uAJdW0CuQ2GukhKuAJqY1rrhcCFk
X-Gm-Gg: ASbGncspRgDZWq3z/0hKoRyKwymPBht5Bx7mPm+/WCs0CKxGWCXcfmszzo89SLafjei
	ZyISKWdeDqNZ+ClE3hhdUZ4yej9gWsj/fVvtkSrR4Q5dqdrVURPW0azmQY6k7UwCw5KkqHgY9ZN
	ILH1IwjkIVufajXYXAYGRHNXh7nasRjzKAQN+OJtrLoYsW0VZ2ItKr8W6ZyzJTL0hPKX1hp8F/+
	upeLtAfctL0J300NRuEYqzc25yVC5uKfpNsqYmK+yzNZZSn2mBS5beAyXD1dZ3URbXLX9eNppML
	h4plL3VjeIJLhr7cgOkkN3dbd+1eFBvMCLqFTHXncT7hO+ZfUhSf1oMA
X-Google-Smtp-Source: AGHT+IG/5m3vxk7XH8yJGRjtosKFh6pQvnNnT6e9O4ZXx67836JTtD9gPOQACi8OqZVBfLdHsuq5WQ==
X-Received: by 2002:a17:90b:2e0d:b0:2f6:f107:fae6 with SMTP id 98e67ed59e1d1-2fce7b1a82cmr15222650a91.23.1740329136041;
        Sun, 23 Feb 2025 08:45:36 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:45:35 -0800 (PST)
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
Subject: [PATCH 15/17] fsi: i2cr: Replace open-coded parity calculation with parity64()
Date: Mon, 24 Feb 2025 00:42:15 +0800
Message-Id: <20250223164217.2139331-16-visitorckw@gmail.com>
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

Refactor parity calculations to use the standard parity64() helper.
This change eliminates redundant implementations and improves code
efficiency.

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/fsi/fsi-master-i2cr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 8212b99ab2f9..8f558b7c6dbc 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -44,15 +44,9 @@ static bool i2cr_check_parity32(u32 v, bool parity)
 
 static bool i2cr_check_parity64(u64 v)
 {
-	u32 i;
 	bool parity = I2CR_INITIAL_PARITY;
 
-	for (i = 0; i < 64; ++i) {
-		if (v & (1llu << i))
-			parity = !parity;
-	}
-
-	return parity;
+	return parity ^ parity64(v);
 }
 
 static u32 i2cr_get_command(u32 address, bool parity)
-- 
2.34.1


