Return-Path: <bpf+bounces-76053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B2CA47C2
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97C113035D59
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D853101BC;
	Thu,  4 Dec 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SspbDLhI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B4309DC0
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865058; cv=none; b=qZNYPLWfOe7pAKedDcYNEJGUqnNHI/VqdudeEDHfYM66KeDNtq/Tqeigr3ABoRHdDuZHQAvqBS0SqnmpbknVKX9v4cmu8oVlA0AP17eFip9Xt7JG9d/He7gg+d2GAJg+Xc+1jhSxDzy7MPBcRt+BR4WyugMMpJH8tKNpEkYrOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865058; c=relaxed/simple;
	bh=4YXW8OG0rCOOXlu8/hY+ND05Jy2SB13kOh4JqU1k2XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWj2+qfxn5NinGSSBOokhgyC0QXA5YEKooHyamn+jalNDXf0GWyG8CAiiuMLZ3cVGfeM5PPYt4wSw1LyIUEt1zpvTq8piscqRStUb6jVCV6VYnJu5IiC1HQRFhNdpEDY0QZtFDgyKKjNiQuqM8W5bUcIhijpQzQ/tHUSXOogsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SspbDLhI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298250d7769so8674365ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865055; x=1765469855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgJlpBD9Oy6edvzJI48obEDsgxUSySjXL9hrT+JA5cI=;
        b=SspbDLhI5HsDxGVZqEkyNWiMNsuX753+cCaiAZIgB8ja/LnTkCv0hG5ErwLr4gqqUU
         jeqHih/fgsW20UzUUkYfIkGQ4Yjopy7S0lqZx89sP+7ZLi0lwRW4RPMDCOekq0I7Ki1c
         v4zgFqfY+PN04JgIDwguvTOZXpzlpmdzwhpMND9g06ks1FiSE7NWW8YdjP6+CM24uqM2
         LFd1XjqoW7nkUWBBOU0C9FQfRVkdJ9UjOjJyJ72pZA180qbx5FilzdzQfnWuY0bSEa83
         euu8FvwJoSP7r4fSj1Ru0KU+LW+IY9o4S7WGgKjWOU5rkSz4lJXZGSN3P8m42eqYHz6f
         CUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865055; x=1765469855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgJlpBD9Oy6edvzJI48obEDsgxUSySjXL9hrT+JA5cI=;
        b=il0V9XGqBDDu937YI+d/V1dEkSbaNPm4l44npOY5pAaIVlJhh646PC2zHfxGEosF6v
         Y7gH5/c13BJwSQsB3gxycDQjL6sZntLO5Bw61Bn5HsqnYRiWXf3ycqbW8Pt24u8l964a
         Tp+Xxdz+y4KdXqkDWJnYcZo0u5g3mqNxp1UKS2N6LMaI0Ymhv5LXlG2kTvddNyaxc7fA
         44NjLWDb5xLxSczSqfz8tZJDtvTtonAQxpjoRaq4KdhHKlATuHZ/I4JAfR4FmZBIanp4
         R3kPpxBu0eIi5EHivn+BSVMM2H4vBy9pfU7uA8QwLWoKOyPHSms3E3J+W0tp+AUpAqXq
         sl/w==
X-Forwarded-Encrypted: i=1; AJvYcCXzq8VgAbHUECkGMse8PO7rq2On8eR3MFKLLW0vEZBFYX1HThbquKmt6p1M6IcDfa3JrKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhJhRZz2WVrsoNV7K6ZHtQaeu16Fswmnmnwx9TdnsgOzPBAk8
	EEsZ5F1Vr5yjH4SfNpq18yBlPFalyCH9PSG2X6xg9aMWCfdDngivTSJe
X-Gm-Gg: ASbGnctwmhgknRF2fiMaNsaKeiUZ5F8nmT03GVuFqjw1SZOqVS8nHJIpQQI+gP0JiF9
	hbpnLTNpM/jajKL663b4LFVEngZUnMQyi+mac/up1Ed5e4tIzj2udlb54UBZsXPti15b5r9GyrT
	30+2KTVFSLquC1HYolGZxU/NCv4Z4ZzK3wd5JJKv7hbjpVT2Lpcc450qGcKp/zTwwdvblGRAYSC
	NaX0oGpSMSUhwPvyQHPytnBrRqJENMnezMSxXDMp/uQSf96Fmj6ZOrdoac5Y3Ydi7IhedEBK/0E
	8TBlE0+Au+0gKZJ3dl8/CZUf6WpPqqG99B39jkaM+GH9X1+6eTZEXYX9Jp6rYfYOTade8aowzkR
	Sn4PA0K2aYmxCvPtJlvcGGCODZAK785iQwiNd23WCS2Y8qGsWX57VjjRxq+25HZfx+hLGCLLVj0
	fVctHq70C7g4okH7iRhkkrI5IuPu9qi9hnSg==
X-Google-Smtp-Source: AGHT+IGaXC6rcyg8E4GPS8vJXLuydedpCNwD1tzv65eDrwpYnZVI13Qf3ZD8xny7+gJkE7253VSp2Q==
X-Received: by 2002:a17:902:cf4a:b0:297:e1f5:191b with SMTP id d9443c01a7336-29d683254cfmr83648775ad.11.1764865055241;
        Thu, 04 Dec 2025 08:17:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49b196sm24694395ad.17.2025.12.04.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:34 -0800 (PST)
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
	Adrian Reber <areber@redhat.com>
Subject: [PATCH 01/13] clone3: clone3_cap_checkpoint_restore: Fix build errors seen with -Werror
Date: Thu,  4 Dec 2025 08:17:15 -0800
Message-ID: <20251204161729.2448052-2-linux@roeck-us.net>
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

Fix:

clone3_cap_checkpoint_restore.c:56:7: error: unused variable 'ret'
   56 |                 int ret;
      |                     ^~~
clone3_cap_checkpoint_restore.c:57:8: error: unused variable 'tmp'
   57 |                 char tmp = 0;
      |                      ^~~
clone3_cap_checkpoint_restore.c:138:6: error: unused variable 'ret'
  138 |         int ret = 0;

by removing the unused variables.

Fixes: 1d27a0be16d6 ("selftests: add clone3() CAP_CHECKPOINT_RESTORE test")
Cc: Adrian Reber <areber@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 3c196fa86c99..976e92c259fc 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -53,9 +53,6 @@ static int call_clone3_set_tid(struct __test_metadata *_metadata,
 	}
 
 	if (pid == 0) {
-		int ret;
-		char tmp = 0;
-
 		TH_LOG("I am the child, my PID is %d (expected %d)", getpid(), set_tid[0]);
 
 		if (set_tid[0] != getpid())
@@ -135,7 +132,6 @@ TEST(clone3_cap_checkpoint_restore)
 {
 	pid_t pid;
 	int status;
-	int ret = 0;
 	pid_t set_tid[1];
 
 	test_clone3_supported();
-- 
2.43.0


