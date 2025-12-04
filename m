Return-Path: <bpf+bounces-76060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB62CA4891
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601463180F2D
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8F234104B;
	Thu,  4 Dec 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDeuL0LN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A76341049
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865068; cv=none; b=tXaSW6BzRC7M0Xvfa3USjISYyOJyDg6KE+lC7pTp1lAz7WTxGIGMYl7byFraU+VV8Nf5BeLyfSz17RLGJIMmi1vc7PGFrsOIQ2kEsP6G7tQduKHkA/AgXQbTUy8EdKTEtiNycDFAqw9uwKIIu3RW661ouoEKAYzXZAEObPGIXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865068; c=relaxed/simple;
	bh=3ygh4I0glRNwV35GaBKvlTRslUW//cHz3CUI6TSCtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhCYA/DKIEOBK+/mcpJki8+YIm/8i1dMBlYmv/qx3ZBBFEfAmRjZfsC54+kmpROqdiIg+Ggb+ADQRItVVUP7iQmrg6v1veZGbq5LcIxFMNbeMVjG73rBLlwQKHVZaUpbtMdpj5BL+FmoT1034is4qfopxuh96BN6E9iUPHmV5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDeuL0LN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2981f9ce15cso14945575ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865064; x=1765469864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkZnCgx9bxJPZq7l/gRW6dYxX2rEKzxVPCSQ60u6+7c=;
        b=YDeuL0LNnKv6Skf8JFXDETnbrmN4u8CazX+kdfLXew/nNZ7V6ZNP/PIB7UjlMR0EPL
         Uido8y8q61vndAul9btZRNmAk7zZtIiiWZ5KMkzZuFnRq49e2ftmfzPEBFFqHOcFt3CD
         DVmRgZCngvCNXzcxB4cSWYQiFf71iBV0WJKQbZ4VxFVbJyWIbFLWELN1mG3lcRVwJld4
         JPbPsApQDRM/EjWohExjcFaZLJvUJBdOoqrm1ehm94FbdJiiyoz/JuiWMJSFrdlOOKvB
         6wkij27fCrWtbq+gAGi9pJwjtjsKE9ZDF8ecm+EckA2kzeAhZws1hC1d0voeZ+4/+jS8
         A9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865064; x=1765469864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkZnCgx9bxJPZq7l/gRW6dYxX2rEKzxVPCSQ60u6+7c=;
        b=e6Pfju3uSNQyLfTcBMiuV0KxkHVcXeDcC41toEkFwfnxVwt/UOIKqk4Mj+HLkGg3eG
         uLXqgPhGX8JM70v5SGhg5f6Oi8nh/JDrBSXze8TtlTrk5xFNDQlLajNroVtyGObwsrPD
         j9Fg2nqVxd8IfNyWx7oEzrZsmNhCqgjo8a8rIqhPyGIf1nja0J0AI2mJizsQdP/xtQag
         vPBdbLrY45cFh88zT0IA2QCVfgfbD701R1asrjloimrHdEvakXjBVsTYeVrlh+v+exnw
         hcM3mGGpGWZB6dRGCt9Mx9zmB4b6KgfQZ8YO8kVy5Ep7kl7+kiwbyzUdTjKSXAuz7y+j
         lrDw==
X-Forwarded-Encrypted: i=1; AJvYcCU8RaOAUka+QPmZ2ZQHPDoAyOlo9iwOHUyvzl7wZ1BlxjR4h3TAQxWI6nXvPKMRhq8yXV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGsS7QI5Flt5ONQtJaVMjKB0jLDK63nbDrzkX33H3vLQT4yUa
	2VsSvvtl8l4opvPCCW7X7ojIiZIi795gN0ZFkjlBK5sBe2JHZBRvgF5F
X-Gm-Gg: ASbGncsWl+6xS2nxFAxcQQnpun44ejR1qxT4QHDkkBWHAEZcLYwx7so/E4sutD6Wcs9
	p7m83Vigoh5Rfbq7vrSSVkwoeWb3qIAglA0o4iu/yD/GUIy8j3+egotaoSuSWeK4cYBNRKmxLar
	8a8zr/Ummo96lzMkxHRdwdqg6Y8duNEEUy7U+YHh9nx5Fcm0QA+NEERUxTijW/rdWJ/IZGWmjPk
	/bAP2/Utw5QqCVHjq66n4lX848QfUla+ooOristJXUtd7fezD9+p53wbUcz9YegAptYioIA1Gyn
	GDiDoha0cmlA7NmShatfbky6ffQtfDm/tdYDOn/9LWrkww/lMgkHi9Y8c1pGOU/sgBiR6i0iYja
	47FkrOxL1OeLpAhqfNRzFTBxQU9zAk+hdx9RwxebA37VNfS9LVf0yQrz+xa/IRcc0WOTU0YUMM7
	Jg77KIaiGK5BusvQ/z/wrg2BM=
X-Google-Smtp-Source: AGHT+IGvOyPD8rdOIos5LYcmChpa04+Wfxdyx/PwskRd3KR37HKV0AFf3UHo1YnF29GTR+qBDwW4gA==
X-Received: by 2002:a05:7022:996:b0:11b:89f3:aaf8 with SMTP id a92af1059eb24-11df0bd181emr6324640c88.4.1764865064446;
        Thu, 04 Dec 2025 08:17:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm8931800c88.6.2025.12.04.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:43 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/13] selftests: net: netlink-dumps: Avoid uninitialized variable error
Date: Thu,  4 Dec 2025 08:17:22 -0800
Message-ID: <20251204161729.2448052-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building netlink-dumps with -Werror results in

netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: error: ‘ret’ may be used uninitialized

Problem is that the loop which initializes 'ret' may exit early without
initializing the variable if recv() returns an error. Always initialize
'ret' to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..f4fc0c9910f2 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = FOUND_ERR;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


