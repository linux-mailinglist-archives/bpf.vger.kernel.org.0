Return-Path: <bpf+bounces-76055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A744CA4876
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 679353179558
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE0F3148B1;
	Thu,  4 Dec 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4h3z6VE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11E30FC18
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865060; cv=none; b=ocpRoaUIQuA3OKiVNg41ONvHkAKkd0/VL+f6y83LIJzUgc6v7EoXcaX3tDZSLMMxiCF84TTfUvcsYCg2REdJEKZ1UT4ZJaxSrHm3SOKBMD+lOZRz/w0hr5+puVLKlE+cnwvbO9gwIv8YLkifVKhXSUcu9yBd9qMNiblcWWfexdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865060; c=relaxed/simple;
	bh=cHyNnZ8pozRIM6qgLhLXjRDWgdbwcNGV7Hft7Uz1QEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgoD9aCWPKLuQsuMcdszYX71xRnzyQGRYjL74ybX40fufAPLDv4BisJUnzdsYfH3NHYX994nKHMywzleCXBYdHa1GmFv04pWQu31atqTmXhAIveFUb0NCbdIIWiiKUyykSGmFraW1JaX+R3x+1TPW/tTyxFF+Q2Qji3QWA3pfSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4h3z6VE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297ef378069so10737285ad.3
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865058; x=1765469858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCNiBdsJRsPUkxld6fkb0mcknawF6lug5Wbao5E0n/E=;
        b=i4h3z6VEd5ahU0ffmehm8MLpVUQu0erDYZo5houI3W2rZG7x1LU4Twa5YgmEPtg0Kp
         FCeLWpL2f7aS2UNWjmdBkNTihxUljqudvbnEFxfNuv/bkAnIFsqnk6O76n31Uk7hCNCL
         UiZj5c8KSkn49qcRh8khR9CQP9HRWT+c49k272E3Dw81fvt5k7rQL6HkNEw14a80GjpK
         brAjfsEE+/Yl+Su0sAROXqkAE4YcYgYcImrv9IZLq0eE9Y+mEZgXSurEcmrpnD+k2rka
         nTnwsr6GuKsHEwJOE1bvzXOFnwkX8wWmQwLNF4FxdLh/3HDtnqTjrZzMyg49DIrTJGy/
         mypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865058; x=1765469858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCNiBdsJRsPUkxld6fkb0mcknawF6lug5Wbao5E0n/E=;
        b=QFOjEmO7s7w8UVQoPBZAB7ysu1RcPrRw6P59ngQtSe2yxXnFiMqdzbcdOWhuZVvfy7
         GxW/doyG+lkj1GzuTyTIQWz621UYW3ATc75xduUAVrZLkhz7dOJ+teEdnqnDRY5yzu/o
         jiohcQDZfgVqeHl5sArCcBJQhQ0VcMlJDkP8pp1pqaQY526rYPRZdHjSY7erXpzSGiLV
         sUNdZYdHfUbAu34CwK5y5WNjkkb5MAjakdCTU38gF92noNz1reaYO7iXJVPoaSdkLALo
         YNWnbn/Oe15WJz25fiPISUY/KznuYxxvBu+iwo8yR2U0YTCjluUYlj98g/H17t+YpdnU
         jHJw==
X-Forwarded-Encrypted: i=1; AJvYcCWfgqfWQFF0VL1Euyuab+zTwXuUirx9gaQ1TDuJzqX4XKuIbJ6x2HGwRSi87kcrTG4pbpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5ieBZMr5OHpiReZAV0PgsBnlEfZDN8CcSBRuQYAESALwQgjL
	98HmuNkGjKjLFPb6jjV7HBpJ4+Du9JCiboUK4xm5MSiKv7YCwVkh9nMO
X-Gm-Gg: ASbGncsXv2WbB41DgrWxDRP6XIeyiEQgpGBpfUfp7hhMbmLFkUZ56YiIpKbmh1FbHgH
	mRxiza1RpPBJgtKHhLrPfXXjK5S23v8oYEFCsiqc8zthZWbVw4yma8rfl/3ItEX6aYCbdMPTcLY
	ugmmAhIQA2cbbQBzEEKgFrcDtSAKLL/8ZPiklrXiHnle3x1WyV1Qi4TFudotDPteS8Gs6HPTDM3
	4kPYb/aPzPlcKTgPu9nHW5t9+kub0uZ0modUGvBQ/o5uPBWwLDugPs0NRyIyTF1gpi96SIFwtbf
	rDekzmeTe4IJFSaYzuxiI8inszgoU4rBN2VRS7U0QR404HRrh4MhppSv7GAdZz4LSUmm6Jibixv
	49OBXCVc1oXJKmu2VdVI61grfS22/tliM45WPOogfBwpjNF9FzL/u4RUP2VzXFFdktTk8GDGvph
	9Te+mOv0Sb5qL5gqTxqgAmYeU=
X-Google-Smtp-Source: AGHT+IF/JV1VOB9h/rEMuCA0EjCehTUVdpJ/24AVQVMYynuhx2I5E1sWEb56yqefP+YuFLCzMcT4rA==
X-Received: by 2002:a17:902:f543:b0:27d:69cc:9a6 with SMTP id d9443c01a7336-29da1eeb31amr41046105ad.53.1764865057641;
        Thu, 04 Dec 2025 08:17:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabf8asm23548875ad.85.2025.12.04.08.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 03/13] selftests/filesystems: fclog: Fix build errors seen with -Werror
Date: Thu,  4 Dec 2025 08:17:17 -0800
Message-ID: <20251204161729.2448052-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

fclog.c:37:21: error: call to undeclared function 'open'
fclog.c:37:47: error: use of undeclared identifier 'O_RDONLY'; did you mean 'MS_RDONLY'?
fclog.c:37:56: error: use of undeclared identifier 'O_CLOEXEC'

by adding the missing include file.

Fixes: df579e471111b ("selftests/filesystems: add basic fscontext log tests")
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/filesystems/fclog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
index 912a8b755c3b..d7cc3aaa8672 100644
--- a/tools/testing/selftests/filesystems/fclog.c
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -6,6 +6,7 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.43.0


