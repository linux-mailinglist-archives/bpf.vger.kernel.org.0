Return-Path: <bpf+bounces-76146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27889CA89AB
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FBA63221742
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DE26A0DB;
	Fri,  5 Dec 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgLQK5KO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1174346E5E
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954761; cv=none; b=JgfxYAwQDDvTJyPg+GmfnKLydmPNzxXq4p4Z2mOCOV/72Xk/7GGrv/pPR0e2F6I6VPyQDEeHwcetVqM9ltNdF0WNvkR5QlwtEqEiUFullGvJJwD4e6GDuXivC0JvsCg7UvWCDwerPrpcpO4ekdTcTup2LFlclW5bvzPQh70AJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954761; c=relaxed/simple;
	bh=yuIIgf/alWIG+QnlbE0mlEBwwSslOpyY/5j2tQg/iS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jV1dHAwKz1kaj5FGk2+sCRjo2E/gvwjw1EaRMk2LtGMcI5iPhSr1xAOIHsfw/yBBv6f650opvqMFPlikSF9w7dqk4pgzLmfBBOUD+hgLc8LM/T3mzAEZANJGqtsBux35SszX4Bzp5r5UWXNDLAPWAqlIjoDu2HP33i7VVK1uYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgLQK5KO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so4083228b3a.0
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954744; x=1765559544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld7Zfx8+1mGBDI9kHG+7ggDCtFZChlITAxT8Fla3YiA=;
        b=HgLQK5KO1PT5LLG8pa1wfajjkS3nhaQVsSlNLlmuAp7tLqBCnx64dM3Nqr/H/dQKRu
         1bs3e6eJXb10j5mBn2YJPHLC4vdf9keDT3y3jFI2+k88UXm2CFM/S9Y0gvrLtAr3brDR
         Z2sdrXHDlj/3+VOVBOist5mCdzbnCZFVjlknMYK6N3KrbM3tYO17YQfhxg5exdA/0Gb0
         qZ4ABMR+iDEz+sowXHc0Szym3OAOuWm9bII03Jn0e8pRCOcD/LgqGvSg7X6uUQDlXShK
         vIxuIaDa9K53v/02iFIEU5XuQe+5RXz6bgrYhXNMxTnNYkn1bG6THXdUnLPTVukCBoV9
         Dp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954744; x=1765559544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld7Zfx8+1mGBDI9kHG+7ggDCtFZChlITAxT8Fla3YiA=;
        b=cbxOyv+h2U0+cJShiqLnhiGVSS3XVWgBBVK+jD7x9ctdJklAx8KlVUDtDKoD60wikk
         7j0fh1VYCQrCMoFKlMGFdGDUwDroP0vyzV0CFdn9bIO/+jnYURzcay7pKvB0iynye8Ak
         C/xKV43DOUPdQrfdG/9WxmqYRHvBMoiz/SRDq2cMJIZwkKZbn/msNA8nq8AtEDEjclHB
         D6RA2QX6S74iFb1Scko38VPnZ0kXaLx/LG2SJPbwOn7GnuksRR2MzQ/uLTneXq871nH3
         M5c69Br4r8UkW+cRIrpaq1dkc2OUbXr9arMYQ2khBBzQ6i2u1z8E8+IvbSsVphB680lK
         NHdg==
X-Forwarded-Encrypted: i=1; AJvYcCX0gLooa37e+Rwz3cXlK6uqEMQwcZFOi5s/6tD78Tnde0zNuiMX4Ws+UAMd/m76zLqWFBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HIByqsVfs9yuCQM3+y82l+iKCMsRptSQ4IwyFSwBxfUSU3rt
	itt6MSdWy+jdExAVpYYCe5NqBTk/k0eWvXDpkK33Uiswn+vQr+rdSxw2
X-Gm-Gg: ASbGncskRYET36CQiNpVk/fMmoJWGe7kI7p9atdkGUcvMf20muL0SUpspNT+Bgtkua3
	N5J40/nQTeGyRSv/vYZUmJvRhagI+g8w8BLXbFa60XBf/7CjnXt2kHV/73zQut4PZreynkb6Mnu
	nZGTEidiV4c9/q4WiiIlVg17/VzHKdrwq8EgUBML2sBZh18BymXCzffOZYPsj0ASEiDEYUBOrSx
	osgDdF0T5i2T80xjO4jJCc7ZSbZ/isD78LIhsOaCwR0QeA2+ddnlKwa0GipoRIzul5RbL1ydFzh
	nUMzq3YQgFqzAGzVlhDFYGXVLSjkEVdV3AHV1aaninWlF6PTs2YIqcljjaguy5cQWJCVUYK6hfh
	s3o7cKnKvEpNPwKb2nl2+W0LAD2Lfxj6mPWAFv0BOCX8vwF9kMxPP5gvFQDt6EbE2G0/7h45aIo
	nqMGZ3SukzYph8jnJEGPYeGX0=
X-Google-Smtp-Source: AGHT+IF6pVDWfDwXkq4xnlvBOGGFZK9hjfQ59/B+jw1lZUA9k+IMOEvrgSx0HezsT2H83Dv+hHEutg==
X-Received: by 2002:a05:7022:4191:b0:11b:8161:5cfc with SMTP id a92af1059eb24-11df0cd9712mr8471296c88.36.1764954743550;
        Fri, 05 Dec 2025 09:12:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm20210155c88.4.2025.12.05.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:23 -0800 (PST)
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
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH v2 10/13] selftests: net: Fix build warnings
Date: Fri,  5 Dec 2025 09:10:04 -0800
Message-ID: <20251205171010.515236-11-linux@roeck-us.net>
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

ksft.h: In function ‘ksft_ready’:
ksft.h:27:9: warning: ignoring return value of ‘write’ declared with attribute ‘warn_unused_result’

ksft.h: In function ‘ksft_wait’:
ksft.h:51:9: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’

by checking the return value of the affected functions and displaying
an error message if an error is seen.

Fixes: 2b6d490b82668 ("selftests: drv-net: Factor out ksft C helpers")
Cc: Joe Damato <jdamato@fastly.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes build
    warnings.
    Use perror() to display an error message if one of the functions
    returns an error.

 tools/testing/selftests/net/lib/ksft.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/ksft.h b/tools/testing/selftests/net/lib/ksft.h
index 17dc34a612c6..03912902a6d3 100644
--- a/tools/testing/selftests/net/lib/ksft.h
+++ b/tools/testing/selftests/net/lib/ksft.h
@@ -24,7 +24,8 @@ static inline void ksft_ready(void)
 		fd = STDOUT_FILENO;
 	}
 
-	write(fd, msg, sizeof(msg));
+	if (write(fd, msg, sizeof(msg)) < 0)
+		perror("write()");
 	if (fd != STDOUT_FILENO)
 		close(fd);
 }
@@ -48,7 +49,8 @@ static inline void ksft_wait(void)
 		fd = STDIN_FILENO;
 	}
 
-	read(fd, &byte, sizeof(byte));
+	if (read(fd, &byte, sizeof(byte)) < 0)
+		perror("read()");
 	if (fd != STDIN_FILENO)
 		close(fd);
 }
-- 
2.45.2


