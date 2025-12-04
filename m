Return-Path: <bpf+bounces-76058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9CECA47DD
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 950643005F10
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717333F8A7;
	Thu,  4 Dec 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNR+XevY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A7330322
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865063; cv=none; b=fk4G6I5N//+E24BJIdUvxKjJTJ5ExVX57p87l/krySmzlei3b6sVYNuF5c7v6QEQSMLhAkLcsupLvdWCyPBMCF4Pi/qpoihg/il5YbRQYmwn82N1CUC4/+zDwgHHf5wMMHEayjO3Mb5BeR2+HOH9GikKJBLa+oi4tLp+VCj9BT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865063; c=relaxed/simple;
	bh=B6G0T8NkYhcNuCD7QyN8/7gTOKXjs8C98fVo3MBQSMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKOBtJAxFoQGo4QXfD1dwTf03FezmuATJ0Ik9bIqva46mbcQzABYsjLApQLe3JlzLl9oq2tbhMQYDa2fiCS6QGJIqjiqOLu2Jd0NKO15vkQnoNTiBbHh9JWgDO3L7acftcAgUilOBqP122BWh4GC9ILjz4jjkt7G5DsyGKkLRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNR+XevY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ba55660769so990544b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865061; x=1765469861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRkSyL5drvX0oO3m3t25GTllj+dW5z9HXAo2tXvN6FU=;
        b=PNR+XevYIOjkpozR06nB6Au2pT/VG8FvCBkQfpreOrmDVleWwb+VOlCDcdMHvxepBt
         l+s2jt6eOJNDIVPv9Qbi04by3VaPKgWvtDUYgzBbs1UUff7w1tSxGC0ZJkeJdD3/CLRd
         B/tAGTIrjaHGQ2dI5utAtuqDPgkRiWXjoje84fvQ4W8f1/Jz+/mPiuCAlJAPfR1X0ntU
         N4PDDvtm7yVgEkrrwvGwnRah0liNOjtbeZNGQQ634oTNnF5SIh/mfz6KM+4Dgq5BDamW
         dL6TM0LOqmg7WInWnhyvysc2taAu6gfyMpXJq+K6ZWJyStQMzYyjO+A3IhTEVIdYhWIP
         7LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865061; x=1765469861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRkSyL5drvX0oO3m3t25GTllj+dW5z9HXAo2tXvN6FU=;
        b=aWcPV6yGz7ZBTq5H3i1FtarSE6pALaBYE+gETgsPCavh3rs94lm9hdR0G1wK2b0lOv
         nWZ7cRPOgGu9eZ/kJaSknsRy2CCqcr87gdiJkpzza6Sh0qTKHX7xRzbwRsHDfDCsXr01
         4OTaS7ut4k6LOAhdpt59lYCur/WB/Ca/nL7zAlO2lV/qDT8a1kj2ersG1WK4/YOwQ3P6
         R0Dd9uLXnGhe9WWBAI1DdF7JZXjOkEiJnqLfPgAMuTdP+k5SREhrrxI0g2ALtS7RVtZr
         McNWG0QISTJfRSRzlZLQJaZkTihGi+QAFnIviRluF9TlQ1xKfltvJPVpjlP3axFKfk96
         WCpA==
X-Forwarded-Encrypted: i=1; AJvYcCX40EL1iYxeI2LPYrpQ72BpS/OiyTMAUvriPhAdyF5JfkbgLfu4rzlROB7rEXKILSYTCBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMDMcYBMc3A5IwHC6UWBWEYUaOkXGcJDAN3X5uvSIqpnsyoKY
	PBc1bVckawkCcRebiU9lw61whWlLpPtRBGF5y2Dh5gooNHJYoAdutITA
X-Gm-Gg: ASbGnctICP/U18hCkxyOZxyUzBfb02Mk/L6bPvHa/SS0A+sUPQZqJ2Hhh+5KnWWihVh
	9R9qYJvhyiOxghYR2KlR+U90TGt5DjCsGzfhLTr2lF42FVgORsrhMC6W0oiRUceavj739faY74k
	ULBFEdyXxWKeGtHReGWyK0oG3GKUnXmjfHVVq6kqUIgadUD5nj+Bs4OuLj82MmE/hluPgdF5NGJ
	y5U5POjHRO9NQbvI5OVdsO4CkY7aoVRSpQc4HrMTy1HgmxP4l0EKvAEYcLZQYfc0HNz2iSZ9hWG
	3jCxFY80igKViVmWYaYBDZF/TIp5hwOQbCpqsZw3Rgz8LgYSUozy50Y2KeqC3CWKQtNmnZU1ljR
	8ZtAD48NCAgWPu4OU/CdOoFsAQkwgd/qDm7RCvx99cuU/4WDBvAh7v4OQ0++HNoz75qblUxJ4+w
	eLr0LQSmfMepJeXZkn/T8nFrsnguVBAP6FYA==
X-Google-Smtp-Source: AGHT+IHDLLCXyd3NnPostz8f7KrgwicqmyuURH58glMvTXVVktyKcW82yJTvvOqpWuC/DUzj2fEA4A==
X-Received: by 2002:a05:6a21:33a0:b0:342:9cb7:64a3 with SMTP id adf61e73a8af0-363f5e27630mr8448573637.34.1764865061486;
        Thu, 04 Dec 2025 08:17:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e4ec3c32cbsm1541785b3a.46.2025.12.04.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:41 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH 06/13] selftest: af_unix: Support compilers without flex-array-member-not-at-end support
Date: Thu,  4 Dec 2025 08:17:20 -0800
Message-ID: <20251204161729.2448052-7-linux@roeck-us.net>
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

Fix:

gcc: error: unrecognized command-line option ‘-Wflex-array-member-not-at-end’

by making the compiler option dependent on its support.

Fixes: 1838731f1072c ("selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end to CFLAGS.")
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/net/af_unix/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 528d14c598bb..04e82a8d21db 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
-CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
+CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
 
 TEST_GEN_PROGS := \
 	diag_uid \
-- 
2.43.0


