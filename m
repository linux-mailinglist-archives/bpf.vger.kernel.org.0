Return-Path: <bpf+bounces-76064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DDBCA472C
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B1B309CC52
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94259346FBE;
	Thu,  4 Dec 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlHZozYa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E6F3469F4
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865071; cv=none; b=KWG8U7rNOA91jAZouOma8SDqMw4blcMJrYS/qYAaeHloG7joQYkzaOdjRvxpb7UbBkqyiRRf3zLakaguGdN63rbTf5PpY/SbxtlLIp6z9XYSqCnCDu4lAY74NrrmDHZhHWkeWWA+WXg1XVi06Ai3XeH62aLP1JhfcUmxqbJg614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865071; c=relaxed/simple;
	bh=Hqm19qhEtyyB+awO2JFc4zCVn6kCUyIwQGxa8Cui5Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0cufafYykDYA3uzMJIT1EMNW4CT5jv5Xhi/0tKQewuXS5BF/s0EoGJSjx+5GMW22KGaVWuz8aWSHmaq7N5guDH0ZiYBEGptKyDpQ9yxvu9S1sOmQzfJwENVaq+pSIkrvnyZ+6syQVyfVwH8+ctIkC0W1tJSuROyuVtIKGCZp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlHZozYa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1927913b3a.0
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865070; x=1765469870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJNy8994Pot6m22uiY8XadZYdXX9qQFe2i2P88ejpmQ=;
        b=IlHZozYaQzIXfAT4fe4NAmbMeMxptjewtfv9zT5w5petHD1ZrLYnCDMoqGtYgThCK5
         sx1nBvUEemy6Z6XPw4RZXUiX0lhbIfxb0uQlivuW8AVNmTBNBx4odDMhc98ejrFbDvPp
         eyKqney08aEEVr7CuXV/mjgP9VDrGWw0+XucjH4v5tkraHIMnQRlX2Rc66rTDXxZhNOw
         tyJWk+7A4buA8RuKjVkzYL277tWJIqn3qbx+U03764hhj9bX5WSB+OQASrYR6CBbaXnB
         2Irl/EfviE+ACia9RqQKLVbjsIjehzOWT5hgI7b3DEa+8LzW/dpAG/P5OYGdPWKLYxDD
         Ziig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865070; x=1765469870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJNy8994Pot6m22uiY8XadZYdXX9qQFe2i2P88ejpmQ=;
        b=wRRqk50LmhBBxn1Z5h93lvEe8ZhG3EKak3vfccYZX5go9oRDoykAi/Cepyd7Cx4JMk
         WO+Un28fXB+5fkJHr3YUoOdsrOoZxMAwEJdxtAwrr+W37L2oPX6svKqhnoE8REB91H3W
         Ia+bEferbnvKjVK0BAJ3X0la7uK5nzx5cB5OoRbQcVZJ2RBhu7bBwUqyK3YN9HThKzcM
         FN7Mf08+H3qW8od0IoRrlW+cdFKtmA+rNud/Ye7shll9bQbvWkZBTYOfAbHQg/4efAHA
         JEp8gCdJjVuiJae+8zileKwvCllu75E+RA+eTziYuGJU6rG8Hl8Y38IifYq1qyLA3qsC
         gODA==
X-Forwarded-Encrypted: i=1; AJvYcCXvu9YkmG/UwQHEbA9SZjBqnzk04dFvOy5rb8uVCfwHtfxVHZ659CLQZs0hQfLm8lggmwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqF565McLhJG5e9lTEc1aTPXjNrJZK5WocMNTMX6FWRU/GTLD
	NBLIYON/JbhWdtlm4hhQwK6t1aKS8ufEVqtSHME+9i6G4UY7awpWnAfx
X-Gm-Gg: ASbGncseGiwJu3djQK1rPD91jiZmPR606tA5FYnZwexs8GfX8E90B4omkvovB5owN9k
	pXOVE4hJjMCWWQWm655vRa58txJwm3/bc2NOvpnFoZJlcLaVuuXyvSuPJhYh+lJ+u53jGPr9/7d
	RjMgH+U/nH2TRkjeJ4incOkr8BPMLf0IeX3pyK/4i1JIvah3ScdS31MBgyzD166i1rdgCiNGZqu
	F+SyRGjx2de99WlPsly71v40oiRwnjU8NAe37yxIxml+TBhMaekslxsPuu01f2fVh5Wq1vhSMe+
	Q0wGaAsfGcO00OQUKoelgmyhK9EgoHtYuCUpY86mfoxclPUsiZVvzidDWUvY4sd2z0M1aIfXnEu
	y7WAt9QbJ4omCiTVIKbgfF+TaU7R3K/IKzg+pc/ufthf46NzCQHMPi77JHiILQr4RJBzMuI9trD
	boOjiZdN91iC5bugG5pcG+/QJMvK5o3AJvlQ==
X-Google-Smtp-Source: AGHT+IFWkduyk9szNluelpZfGaJjNW90s6UE/NY8hC2k8APw+laM8wvICtCdvTbCpRk3ULmedtT53Q==
X-Received: by 2002:a05:6a20:939f:b0:35e:1a80:464 with SMTP id adf61e73a8af0-363f5e9dd6bmr8075142637.46.1764865069640;
        Thu, 04 Dec 2025 08:17:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf681550446sm2310053a12.2.2025.12.04.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:49 -0800 (PST)
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
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 12/13] selftests/fs/mount-notify-ns: Fix build failures seen with -Werror
Date: Thu,  4 Dec 2025 08:17:26 -0800
Message-ID: <20251204161729.2448052-13-linux@roeck-us.net>
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

mount-notify_test_ns.c: In function ‘fanotify_rmdir’:
mount-notify_test_ns.c:494:17: error:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking and then ignoring the return value of chdir().

Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant running inside userns")
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 9f57ca46e3af..949c76797f92 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
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


