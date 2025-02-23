Return-Path: <bpf+bounces-52270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C362FA40FDB
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 17:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF273B6A98
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9814EC77;
	Sun, 23 Feb 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKsdnawl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF188139D0A;
	Sun, 23 Feb 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328995; cv=none; b=bLtQwgyAIOmzxpCzrMgpfuHnBl7cmZYzisnn9UAVxbQAQdHGRiUp6FrXx4a6Rk7/ytTexhep9kE3rfG5PGmH2NXhhkarNP0mFVEWOlIxUcpHArrEcS1KBqEkQHB0lU3yPLcduZ3dJWn5XhyaoxjtszSjQCzP4f3kVRjsBt2N+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328995; c=relaxed/simple;
	bh=43hnaHhMRxNK7BTgr+5PulsKt9J23D55SyRDpX/bt90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3zv3GQiZpfo6IW2RcctFiIJlUaa/6uWm8lq5uDKV4/77jEIo+xFTPJeOqLw2Km1S/lElfV6wb2ZjrbeHLLZBaZ4CW7L2VKz0Z5w1Kuk0Bd1za6udMRuStDjWbLmqgiMQ5rSp6fHH+NaDtbozqkKd8+XlrlAFfVCsX/3r0pIzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKsdnawl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e989edb6so99060595ad.1;
        Sun, 23 Feb 2025 08:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740328993; x=1740933793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwB7nlCWtszUSdGoti59nJGyNKtl99nOClvJi35M3DI=;
        b=TKsdnawlw0n7oMwMyT7nm8NDvayL3m0UL27ebyhZdvFUvOn7ii0ls86EUMK9Nhm0kt
         zju+zYHGjR9quGbP837NNf36tZSe93J0GCbCJ9dS5wJNGKPJ+slEH9iF10ccKds8DDEB
         oudKmvjeK8fK+2UtGb1SpiA+dH8IQ2oWeBv53ltzPWPOwq4itCdwWa5e754iqEGBfpJX
         hyVFqkn2bEOXUXXHdVTPKFBns15BSbOmndxYtNpcGhDbLaS8crWYrf1LiCVOQV7y+KIf
         goSLYEk2U8pv9xIYKCO/GNTjKQ2CQpxP2mv0o2h+UXfHWNAGhxqZqTpF+iygfvJIMf1M
         GQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740328993; x=1740933793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwB7nlCWtszUSdGoti59nJGyNKtl99nOClvJi35M3DI=;
        b=fDXDgz8F+dIuQKJqe7e12PzMFHIyJm32A5XT2vBtXUF07PLs/MqbBtjVWtICZauHGh
         9WTQOWhLPFlDzFsTnwjHi4g4JPgIuS81Or+4thMKFFSWsKO0O9UVOuNa7+vKW+bos653
         7aKQKdW8XIzTFL+w4w6WR8DiMRX7PiZnWEOxXqRubbc+K3O1CfyWGdgY4KZZNjr0+I5m
         O5N71R73e1ZRTWAD6AaGOqbqOLLQlKMnSLHRtCEYk3okHBUswnP0JAaki9ZEFTILLP3F
         +ZjwEmeaeuRB080RFEiNEFt4Pt4VQYrpeTBu30ixNbbvvAMFO9BCCp+rmjrbioHwVEwW
         WHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5MIdi0zb9aIlxdNXVfxllpy79CZKi2f8sL0iJuwGF2bkLc4i/S3X8JDxcswnhT34o7e0=@vger.kernel.org, AJvYcCUR3DX4pIo3afByBH0Mdza/1TrN8iN2tgsw5UFi4JXK0OeAyv8DZ5WHj3UEBi6v/i73FRM1/dI4QW2uRQ8=@vger.kernel.org, AJvYcCVXWvvwyMsqVx0FoCXqYavYWTAjbnHyY1MdeUMDZf79WqrZDBpCP2oBRofI/3E5AiuIFlOSPbcrRjcJLPzTfhA=@vger.kernel.org, AJvYcCWJReCJbfQtoraICHwfUO0hgH1h3txpoE9yLxt0kfD06KRGNYQq+kVdvCjCfERZLF+PyIuM1jQ9@vger.kernel.org, AJvYcCWLMrBiFrjMt7Cch+kNF3cfszGLg3bFLn3jO8WFXwi9b/xnmFxnfzKgyJnyAAGg9vr+SOofLAF6ojSQzMqJ@vger.kernel.org, AJvYcCWPJZYA8tcFuBsxbcIDX1RIpxH43FS4OHcKBzL5wYabadKL4t8spw7cWANrD7Sq+q+7ebOsj1bStTvTLf4E@vger.kernel.org, AJvYcCWwm5TLzrsBv85nEWeXFUyyGw5E6DWAfU1VIqIx83QpqTwhkJqEdowm0uZ6pxX3cU59tQZmW2UmaXHDXIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCDLf8N6ZTO/u8XP2Y7hZMcaexQABDHyuh+TUMEHkE5R68U5d
	UKH1x/WeIuuAz4xUqej0RL88fwp7XWL76um+dxrMiSYHrAtYgCJe
X-Gm-Gg: ASbGncvfskBEGdJ5pEt/+YPukeq8IgIvfZj7k+W+dVTe51gEtTak6OzLrVWQqKE9lnr
	MapmqJdWgazClGqAo1H2CG4GZRR36uxb4q1MF2CcgdHODQ37+1kLXcKd6lJfxgrEOgpv9JYSrot
	dZ26S1e9If+knQq4wSyyXskWR74yryL1cl3b3VByhk4kOWRAbWzfqB8QL1ArJV1iF52fX4doNdM
	NTXMUDcFAYkqDiYE/xzfzBeUd71dZsLiufkAdiAH51QUkzgeLQfi4WX3UHd+njHoCu6KyzXE4gS
	oNE4BCOeH9/Qo0ukfXr0i56RrjrvYwefL7NlDyw6mUMf9j5pJqbogN/P
X-Google-Smtp-Source: AGHT+IE58QWfaLQcoNHwIYpospn75AI8MBIDPjCyLRCCZKoYKvgXR3FRMWiJgPdm5hfaVo9o7EyRAQ==
X-Received: by 2002:a17:902:ce05:b0:21f:baa:80c1 with SMTP id d9443c01a7336-2219fff2c88mr180524175ad.53.1740328992776;
        Sun, 23 Feb 2025 08:43:12 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09f6e0sm4935080a91.44.2025.02.23.08.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:43:12 -0800 (PST)
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
Subject: [PATCH 02/17] bitops: Add generic parity calculation for u64
Date: Mon, 24 Feb 2025 00:42:02 +0800
Message-Id: <20250223164217.2139331-3-visitorckw@gmail.com>
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

Several parts of the kernel open-code parity calculations using
different methods. Add a generic parity64() helper implemented with the
same efficient approach as parity8().

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/bitops.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index fb13dedad7aa..67677057f5e2 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -281,6 +281,28 @@ static inline int parity32(u32 val)
 	return (0x6996 >> (val & 0xf)) & 1;
 }
 
+/**
+ * parity64 - get the parity of an u64 value
+ * @value: the value to be examined
+ *
+ * Determine the parity of the u64 argument.
+ *
+ * Returns:
+ * 0 for even parity, 1 for odd parity
+ */
+static inline int parity64(u64 val)
+{
+	/*
+	 * One explanation of this algorithm:
+	 * https://funloop.org/codex/problem/parity/README.html
+	 */
+	val ^= val >> 32;
+	val ^= val >> 16;
+	val ^= val >> 8;
+	val ^= val >> 4;
+	return (0x6996 >> (val & 0xf)) & 1;
+}
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
-- 
2.34.1


