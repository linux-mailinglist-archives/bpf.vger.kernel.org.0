Return-Path: <bpf+bounces-76056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8CDCA4888
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1724C317A2D2
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4E3164A0;
	Thu,  4 Dec 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5v2143l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF6313520
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865061; cv=none; b=USV6LdjUxI/mXkzMn6TZ8dbSAMGf4JueYNf2lVKYoOTKml0izAY5QVn5D3CFLkNEG08fyZncs7mF1UPmwcTjAKf/2H85fgEbXMaNrHHh12hlPbHgOfHB/kPLb8t1fTRXtCtoZBArYwrN/OXT8zaGho/2DvtXyU8PbbGlMdhRjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865061; c=relaxed/simple;
	bh=uojvQcHou5oXqNNEnLZdn5nZm+d1gWRdW3OC5Z/daso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4SrsDC3cP7evNc2awDUg/5c03ng+CKbiAKubN3U1yIxQmSN/C4ZqhchS8a8lgCeoynytZtgNME7OfMblEY+WxL640s1MBXKlbe6rdM8ECmwT2wjzVBQ1LNmaKZbMVj0w7+3YSCntD4tHLtx28hshu1xVVS3IoKH+hTxgg45uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5v2143l; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298456bb53aso15049495ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865059; x=1765469859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOzZfIH9Lo6vEdAA49vWqjJXfX2W8pQl4mAmhvon218=;
        b=R5v2143lgd8e48JQqvoXR8DoQj9CWMt1B7SZVQ2YY4soQMeaNeafYH4NkvCtuZLVvI
         inn7nPPGC9nnu0dD0mg1b7pxXofWCMu4631B24LEAk/iHQQsfzOXtZRpsnHgOwregXSe
         haKnwQyPGz3RU/9Mi0+QY9oKM9P+pZu7Cq5ZAM9KoTyb05udMISW+cazO/G3n2Zx60Rd
         9A4rcYXaZLDjfxRUEpHhQz2cdXhFzf274gZ6fl5Mr+MD1FMFU6i2cZsgAOXFkGSNwiKo
         2n1QUt2eaxh9f3LDvsW1oizDoyx0Evv4+J7NUtFt21Ta7C1how4kOlY+WZDayVinOPrc
         5+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865059; x=1765469859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOzZfIH9Lo6vEdAA49vWqjJXfX2W8pQl4mAmhvon218=;
        b=UUTGtT8DPp3HRywmKs2QY58H5Zaf2vrT1B7IHbgF/V16gLzN2fdxlqbRUb6cAkRSkI
         z32u1QcgkpcglAZAhWTr3Q7nfwHGYd1LrS0Csg+GLr86rarRkReddm/6tFVhosUZHx6G
         DrZm1lvH3mTkQtjTbM1RKL9MJ0vPkHLvuuwy6dUcnBLIIWN1eZYSfQFeNMgvbhyDuu4R
         nDt1aJBAzbC2wsblhb/Xi1B3ulzpD9Qx3iCW72HYlulx3MbB0e/qDaOhmQxfKA6rr1NB
         LniPIfgJaXV99dilOv74Ib9qOCgk0KNIzZVHHHqcs6XEBup7+niku56mYpW7K4uw8vd6
         JGJA==
X-Forwarded-Encrypted: i=1; AJvYcCW7f40vkSYgCPj0+/dQAsPHO0UoXzm82M1/FSSmAiOt1dW4YwlXMuDka51yiMjmM1d6zyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX21LC8tZe8zJkyF4qlitSetBaoT6GwMlXSjV7B2Yx1sosc5hd
	wJ5/3E7EHD0FNZQD13PC5tS/KgQuX2gGUp0av90MaAsOcdGmRXY9wyWq
X-Gm-Gg: ASbGncsBMKgfbo6H7tcChJQnT1NRiYCfANxGgMOXK3TQz4hwMNmrvMAp5qieSSmoXsB
	CgsoBA04MakacqrH1Ch+V6Mj8WfnuGysG1q3v92O7Pag+s9ei4/iGyH+rbVUgpVn/bpHMLDDMpe
	dRUp0PfRSXqdHCFfiZqp5XV9z4qJ9gOJfIcVNIskJ4YhB3YXo/UJpaxaUimFtKLWVcKTAlcBS54
	VtOXNXWtMMtKKMUTb+AM/XXh5a0BhK6ia4/97ya+RIv3Ln3bAV/xi2r9qbixK3AHzWvrh/PH/uA
	FybkGeo3s6JF1S9Bvds+ZDlz5ioj5+AlpbJZcLWNJXdZl6SXFlhakLYedXFGb7VYOpptt1XVSiO
	Gj4EL5Pm0elfEpNBvsd+f/u54iiaXyHhI2lfsv7w7C51egmAVnvcw0fJ/UsCXj56bLWqaVeZKZd
	Nvjv5maISpjTLf2cyJ682IE18=
X-Google-Smtp-Source: AGHT+IEhqjbEuXaysSF/wkAXhEmzAlPFdTVX3OMfc8S/rfmItTqonwqGE1/z5t8WZPXeAov5Rk8BdA==
X-Received: by 2002:a17:903:3504:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-29d683eb3a8mr83132745ad.61.1764865058842;
        Thu, 04 Dec 2025 08:17:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f1cfsm24139315ad.55.2025.12.04.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:38 -0800 (PST)
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
Subject: [PATCH 04/13] selftests/filesystems: file_stressor: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:18 -0800
Message-ID: <20251204161729.2448052-5-linux@roeck-us.net>
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

file_stressor.c:112:9: error: unused variable 'pid_self'

by dropping the unused variable.

Fixes: aab154a442f9b ("selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/filesystems/file_stressor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 01dd89f8e52f..4f314270298d 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -109,8 +109,6 @@ FIXTURE_TEARDOWN(file_stressor)
 TEST_F_TIMEOUT(file_stressor, slab_typesafe_by_rcu, 900 * 2)
 {
 	for (int i = 0; i < self->nr_procs; i++) {
-		pid_t pid_self;
-
 		self->pids_openers[i] = fork();
 		ASSERT_GE(self->pids_openers[i], 0);
 
-- 
2.43.0


