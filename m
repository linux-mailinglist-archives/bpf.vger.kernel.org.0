Return-Path: <bpf+bounces-76145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD037CA89A5
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016013209E31
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E634C130;
	Fri,  5 Dec 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfQwJsZZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96733E368
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954760; cv=none; b=Ztfv62GlR2/qnlpW6ViL2VIjwXM+nC7hiG8vZiGievff+qVDWSjCpcdnyJIGq+hOfryFvvahKV2GJUAkGG5etT6I0+TV3OUmdUHZ97lUHjlESYVjZ4aW9vPPff5oBqZ+4M4iO0UubVr0dR96E0DrwukEsliclKvJZHfFZMujIk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954760; c=relaxed/simple;
	bh=cB31pmWNA2px7ozTCQpqrnxwkRY3wOGmMDqxO5JNm/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3KjrhFoO+ENbOkXErKWEn8ibldro3RLULjTEeD0I7d5FViy8hcFT1F/P0AziqQbYO34tC/W3O0KHRxnP0LSI6QDISdrWgsNVQr/W/ndONEbYICupwxrcWupeAGhyWS6s08WvuGIpvmt4SDR/dY3yMJDA/U06ImHbt0KBtMYk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfQwJsZZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ba92341f83so3086765b3a.0
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954748; x=1765559548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svZn1kMXxy5/37Gn195RmY55SpZYbLuXKcgjq6f2gyc=;
        b=YfQwJsZZt8EeG5RqAGBuA5u5gBhg1ugiIn9F3uGvTiQMKOFqclk1jo2vOeJAOZKkXI
         /Zqq60gioILstAST97YWja/cjbCeuy1f59u+bGfbeek56t42pwW8rSMa4XaLJFiYI7qi
         toLn2qqti9jPuSz/5asy0JN3IVomPfBRFgkDEshrrgurJ+cgIoQFZtW/bn3rGd8eCI/y
         2i14X6a+bKdra7M5ZQJOaGO4YTawkah4oLdtf8gcR2fTrMjsg+VAz/P8A0u4NxYCWBeQ
         UVvpsIjtJSGDE4a7FGsg3aXls3BNqZS015JmwB+k+WXmFDZcqHKNGDYad8BY3r6idv+z
         Ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954748; x=1765559548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svZn1kMXxy5/37Gn195RmY55SpZYbLuXKcgjq6f2gyc=;
        b=wMQjDZhzWKoRhHRFJdhD5hw5VfQi4lnvTsi6XOSN74N0BxHlTVEnsbGuiFpXjSJyHi
         8pJkzGfy/8O7sKVplzr9j6QgBqKRClNrbWeDbm6m0f0cvHq9+qnxrhNL0e4evzYB/W9s
         no5I+kbpj/5wsjnkH9d+jktrE4ZRz2Lr269L0JkJy0gv0H97iXng5NkidsnG2E+kQIuC
         pj2YVbMTs8XBYjrXVNOsEW5T5yxayPmWCcTZH1YWCjNA0pIDfeft7yyJsnzQijbzvM9R
         KEBgBRFAKTxsVnhl2gDVfwn5doiFMKwZqsfDFsaj3JW4PK9k0sXlurL2bsoEJRVTTPp2
         rTiw==
X-Forwarded-Encrypted: i=1; AJvYcCWI3aOpoGUjgLq3Ak06oVia1jIesf1dWcpcz6Kc6zZyVpbb03a852LRgDUpK70iLRLoWEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+Tt32QsbAkFhr/k2W1fsZ+EiFgdM5Q7IRs0Ue/wZvlJLxl7Z
	heWVvIYJn78P1/XwtkcVETFPWKyt4SUVwp7+joofTcnbW44lGqlDaHZX
X-Gm-Gg: ASbGncs1ar98ynN8IOQzy7ryKFZi2+IicEQHoMSSeGLGb1JsiHuz08k4naD/UKg7E/Y
	1vTvDBjpBzPld0CWjC5lQPIZQfjUIyTRUFziREfeV6ClYOpzoiyzePxwxKiDpnqs2bu4uWbfLFJ
	ekstCNqHsZETeUt8qIDmvByil+j6zwTo0iiV5FXjPJ1D639cONYqNIc4YyT/wR/xLbM0ZO1m6ol
	ioBJ6CnrIf9TZMuN1tM8ABBcKPFHv6M76LsbJC83GAzVyzskDa43guy0azk/LC97pJLRgPztrh3
	qt31uP51DjaeJytFH0Oxg7sbT/l/I3PlFvvQfSKrFOlp0Kk2mJVj4S03rNpdkoXplHoJ2wybf/2
	IhMH6orHM3epHfAP29ux9GjFyrDA55bKdEXfsEvIXsg7qyeTMq/+WGaFmfRsWYKMMu9xFjolDmq
	GO2Gy+niUZXiAJ9jmXihTl67s=
X-Google-Smtp-Source: AGHT+IGHDjpBTcigzNC5fmT2HMSl2OIXJF4Ntvq8YICmSN0m9lTSarMT6qdvBRwyf5R5o7dnkTdLEQ==
X-Received: by 2002:a05:7022:6988:b0:119:e56b:c758 with SMTP id a92af1059eb24-11df649fd93mr5077082c88.29.1764954747801;
        Fri, 05 Dec 2025 09:12:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7703bd7sm22124088c88.10.2025.12.05.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH v2 13/13] selftests: net: tfo: Fix build warning
Date: Fri,  5 Dec 2025 09:10:07 -0800
Message-ID: <20251205171010.515236-14-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

tfo.c: In function ‘run_server’:
tfo.c:84:9: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by evaluating the return value from read() and displaying an error message
if it reports an error.

Fixes: c65b5bb2329e3 ("selftests: net: add passive TFO test binary")
Cc: David Wei <dw@davidwei.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning.
    Use perror() to display an error message if read() returns an error.

 tools/testing/selftests/net/tfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index eb3cac5e583c..8d82140f0f76 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -81,7 +81,8 @@ static void run_server(void)
 	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &opt, &len) < 0)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
-	read(connfd, buf, 64);
+	if (read(connfd, buf, 64) < 0)
+		perror("read()");
 	fprintf(outfile, "%d\n", opt);
 
 	fclose(outfile);
-- 
2.45.2


