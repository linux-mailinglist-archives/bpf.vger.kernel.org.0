Return-Path: <bpf+bounces-76063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0ECA471D
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 470A6308DAE3
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32030346E74;
	Thu,  4 Dec 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpNaN9N/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27615346789
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865071; cv=none; b=a3anVwYHBmxYX4IQ/ekK2aN4qY8lxsQE1Xxz334vS9KVlks1hiCPUMvqmTUcHwMdFBwOd5UEUj/wLKG5dCA51t1XAngrVVraRmkSUwLOCNcGMrlPmUuEslTe3ewNa/V8Bc+z/HkKQxn+TA6PZkAuv+MLyhQQqZwufDHLZpvW9Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865071; c=relaxed/simple;
	bh=W/OQe5SBE/hGcbbtQ1DcT8TO1Zhva6jnYh6vp52AP/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aowSF6uVnGP4tlIYMFNfpiv00XVLX/H15eSaxtLQdk8B+LR0Ji7L7HaAvAUSt63wiMeKwXdMCWHkCpBVRWMxMsIfFtQ3+C766RZohC2XqM+6EyAvMKCEPn70N8/Ty+Z7yLvngPTw/LEI1MjG0EnnYHUFJAB232cqDcx9mgz91Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpNaN9N/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1108035b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865068; x=1765469868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqotmNbVaSZDa6RHeR/dZGNbL7atfR/Dwuv0KZcoFLg=;
        b=kpNaN9N/eED3awn5YgAFGIbIBjH6BCEe1ugH6xbjeGnxYPWFTeGm3F/l0EEiL7LRhf
         TkqrvGjrzeAyES8YAIn1YZ7TWcsdD2APybxkrjRUOzG21VrbTHlP0+LuHNPuJnAT7XbN
         d0urJX3LiRN+K4JvOGmr6NwQQLlFf5tHZ/5YwszAlb/261tH9D+Zg+tw93YiMBc43XEv
         ViwDQSJNryP46AJpply7vowXa5KqIWNxnzoHC4LCfGcpb4qMUcnsQRFT2OqdhEp+aP3W
         gHV0Op5fn+tf3xVkrjefB01CWEJ324QGKzrBXILs9/Vdan1a8jLWznDUvbll0sG1xPYZ
         kzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865068; x=1765469868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqotmNbVaSZDa6RHeR/dZGNbL7atfR/Dwuv0KZcoFLg=;
        b=HPADVgtoaLj+dAX/T2dTm9o/ioK8f18aQFfoSaCLtAWMOd3xiRF5BYffYau5fn7nDf
         6Ip+JLnh/52G9sDlO59fpMw/J+1Ve3PmoEhDiytusdjTE3gH2Ib7Rmj4END9WMZTrpDV
         aaa+ZEuka+qzZoD8uhCHJN9MXRCjG6XryTqLVqeAtHGdctLt4wLLBOypnwQ99tZDqd1o
         oHxgdJvramqN86mkOZhEqyI4bc6Vat2Pf6CjprvytlY5vSpSdfR2BgL2f3EGAG/UcHZS
         qNPCfst/U87Uzdi3iAc/lMmJHgl48uC0QwpdGseIa7HYRkqJCcVBG7c1A+yPUyF/uhH6
         71UA==
X-Forwarded-Encrypted: i=1; AJvYcCVbhZuWjIedqh7izJ18idHJwBkCmpMNiTFo/0WesqPtA57on7QWBEn9l3sxNukgjILd1yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXl214uPwh7sqFxbvduWaxNIvpDg6/2nBgsUFL30rGNQRszRq
	o412/tdvyrd8AuKxeeNqusgCiv93eNDuANrJy9JHy1R0viGWW9vxt4Ha
X-Gm-Gg: ASbGncsdeImKVd6fqTUNHE+vLQcgW/9fFYBRXecsV6XJP2f+8evvWSo+Q9KEnw7/om9
	D7Bbq4xZ4zZBx+7QTQHYADQXOJ0qyKOzFnH67G36qTQJkWU7jRT72g3NwXQ4VhU/yCTo0rabJHA
	1kJrbG7/lm7MnHeRKZ2LJp/ZDU2gjOWLTbwDF51E4GCXprhbJZhOEht/4UQF6H6pKsrupmlHiHL
	72fmExC+EApDzwzKgyTAP/eS1qHqqEw27wkvv1LlmEUiIgGAfbeMQpnEUI25T75vSB1XqmukEEZ
	aZUFvdXPlGd5Bke2ihHUXQwAhpnDyNUEx/cfcOfSnpk8NpUWYY+ItOGbrThtrrwRyj0TVDUpskR
	aTMudDRxyXbNZqcJCVNNq3DARfuRfVGE4dCQsuWs0rfEp5ZLXmo2JhAi9TlINIBClnQRpS4Nl1T
	CUhXDAdFjy25WoR9lrLfe2S6Q=
X-Google-Smtp-Source: AGHT+IHVpqKaMcm1FDJ5yjab03bifOuUjE2BJB72SixSC6x+ndj2E9PzKZDdx0HSGekHKIlUwqYNWg==
X-Received: by 2002:a05:6a21:33a3:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-363f5e029bdmr7709680637.35.1764865068434;
        Thu, 04 Dec 2025 08:17:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed2fesm2637768b3a.14.2025.12.04.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:47 -0800 (PST)
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
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 11/13] selftests/fs/mount-notify: Fix build failure seen with -Werror
Date: Thu,  4 Dec 2025 08:17:25 -0800
Message-ID: <20251204161729.2448052-12-linux@roeck-us.net>
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

Fix

mount-notify_test.c: In function ‘fanotify_rmdir’:
mount-notify_test.c:467:17: error:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking and then ignoring the return value of chdir().

Fixes: e1c24b52adb22 ("selftests: add tests for mount notification")
Cc: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index e4b7c2b457ee..c53383d4167c 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -464,7 +464,8 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		if (chdir("/"))
+			;
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.43.0


