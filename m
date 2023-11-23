Return-Path: <bpf+bounces-15722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8A7F551E
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 01:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285AA1C20BAC
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA163B;
	Thu, 23 Nov 2023 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4vyAJRU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417118E
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 16:04:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a3b8b113so386726e87.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 16:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700697897; x=1701302697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIYD7dpz7/GUpz7/bO3zeaHPpgZOpbTuc6fHVqaZVOo=;
        b=l4vyAJRUZn6idvZOmkdS36mf+XQVUYG8cutUXoWyJmCwciUPXRE9sSnQinF+2RfjSq
         0eMY5Xm1ez4F4Wigq4LCRzw8g+C8J35+t34oHKsJ7g06ryas1PsyS/lpIQeAZN/Hrc8q
         dRzNVJ5DyPFiMkxj11+pjoFNXb8xVeWMhCE7pKZiJpxLsjBQCKTk1ZzHLpKs/WdrggP6
         mYdKV9Tt8YNS1aNJpzuqWxBL1MSXOADxZwHZ1MJrUJVbL0Hj3MT5CB4njjpsgA/wP6dP
         RrUan+K2X7Ud7oRYeGXHkn78JDnXCxSdPrjS+TWBesOajf0nenGyb3vxl3OEXhNwWdXy
         bUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700697897; x=1701302697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIYD7dpz7/GUpz7/bO3zeaHPpgZOpbTuc6fHVqaZVOo=;
        b=HoDeub8WCrUl50MKQD7b2SDLzIQGCgSU2vVidTG67ZOgALTXRZu66wxgXeboZCqTaR
         sRZRnzBjDez/9CdejYVeU1y7NlfQTpA7hNkFLxzniz/Q5iopYZ2c6sUOyfNEV6th+YNB
         kR6YlRyhNakNzse+frrbd4JnjFkp49m5ePzQ3fbBnCfO8iZqWM6RBP7imnV083Lws00N
         DROTiHfH1zBVHyy7aISEvo2KdeJcoWkdBxIfKG4IG45/ChsP+VZNHWBO3en/G490u06r
         qwsaZr/ekEf/CJ2G8+/3zZxvVYZpkElN3r7EwB20eDdD5OlrgmScdJfSB4WOG//8KnJK
         wIkQ==
X-Gm-Message-State: AOJu0YxicbTV1Mbw8MU1SxhoJxym+OBEfii/4aIrE2E5g+c2hHtzfexc
	5vjOGYQGba2cncw6F17En/6E3tmd88Rqqw==
X-Google-Smtp-Source: AGHT+IE3ySfZV8721U8P82jfWcpDwzmhtQLYVbHX/CVtf+2/rJi/9VODCpnkGCh2zqvMWDI7ntOtqA==
X-Received: by 2002:a19:ee04:0:b0:504:7cc6:1ad7 with SMTP id g4-20020a19ee04000000b005047cc61ad7mr2823664lfb.1.1700697896730;
        Wed, 22 Nov 2023 16:04:56 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i34-20020a0565123e2200b0050aa7b89490sm9559lfv.126.2023.11.22.16.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 16:04:56 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] libbpf: Start v1.4 development cycle
Date: Thu, 23 Nov 2023 02:04:39 +0200
Message-ID: <20231123000439.12025-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bump libbpf.map to v1.4.0 to start a new libbpf version cycle.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.map       | 3 +++
 tools/lib/bpf/libbpf_version.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b52dc28dc8af..91c5aef7dae7 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -409,3 +409,6 @@ LIBBPF_1.3.0 {
 		ring__size;
 		ring_buffer__ring;
 } LIBBPF_1.2.0;
+
+LIBBPF_1.4.0 {
+} LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index 290411ddb39e..e783a47da815 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 3
+#define LIBBPF_MINOR_VERSION 4
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.42.1


