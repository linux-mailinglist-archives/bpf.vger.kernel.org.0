Return-Path: <bpf+bounces-76137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE27BCA8831
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99F223044E3E
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67400346FBD;
	Fri,  5 Dec 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShpiucD5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AD345730
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954746; cv=none; b=VM9AVCAsEalTsO2EawMyT1k4h2FluXIfDbSwMRFW4fd16Z28vEug6rIb39IgojTcRCMhzMvfcGk873sC2l4Tr2XFFsJ/ftKRLTcQoYGywgeRWNwT+/b7JZJsIN7CVfwlvoV+Ygu37Pn8iYtNc86/OMA05A2iGJ10hsF+ibaeekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954746; c=relaxed/simple;
	bh=zQXdANrAyobWWcUFn+j7Tv5/akEdbk709MOA4NwiFNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXWxz7Cf8d5h7wbQB7vKOiuDZV4D+QRblNCm3/fo5aHFUwZKCmYhaghxTF43Kgm/A93W7ffeLIwAZQI9RSvlZiYErk+flJdm5oO2QHmTz94Cvh22Ioo6jJDZxbGpymi2XoiRFx6oXsxf8SkjU0iZw4zzA75BY2YqWr/rh07Ae5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShpiucD5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab7623f42so2792630b3a.2
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954732; x=1765559532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGP855q8P483/tvMYnKD3q8c0QVPBAHakO/1UvcTEb8=;
        b=ShpiucD5CfH6RxTe1uOiHmjhJxOqvhW2w1po4HFvFUfjGI/pAp6RVV3JA5fOIig3C+
         agqJZ4DMGXun3iJpTMtrmfX9w5ohDBDvrOuThC4NKa/E5OlbkEI8tu+6Gnl5byhCNLHP
         bWD4KFNvutkrwaaXaCkSGxgH6uLWtiKOvj/3Qp3IGL/jk6+LFJDDKJFm9oaClJe0YgjB
         UGVj3I/kkh8krwY/v9yTYcZNOzWQdFXJyTOUvoOGjQYhvDawnVO+/J+qORctn7HWXxrP
         RANvACI+0+CUGHodyK3CWSL2/CvDWnRoL0oq7sdvW6zwOmilrpXdf7IMMQUdDCVsUMJ7
         qlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954732; x=1765559532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGP855q8P483/tvMYnKD3q8c0QVPBAHakO/1UvcTEb8=;
        b=H3hX96kqtHfqYYBknfRpMGElwvIQZXUn1/ySpQt9vjojaJ97WJ09VnMri6jhlEsx12
         TtaVOB+7KO62eCdaojxv2mnIcZCtuT3qq0GLmTGZLRa5jbwZGTIMjvXJVUgmVzap5hHj
         ZBzfmbuMExWlHhOlUh18MQMymKj3mjeNP1JG0y7PHglaomCa/Cyr4WKfMHjPmrGclIEg
         dfYTKHGmdUchgYQ+lXzQzronSFSaZkQUxd0FBK+4Kyx0YbsQGgNQvEBrbBtmar8ekhZO
         L0AYfBIUrPmPOKOYuSGKe7DnZoOfsdbGpMDbPSe/NOgxrayvxGkUHCsstJS/oFDqorbP
         JZlw==
X-Forwarded-Encrypted: i=1; AJvYcCWfet2W8eylZbM4EygE+b9fLcyZ4Gx8GyEvxL1FGy2k9wUSjhmw/k7XguAKSsT4tfXzKEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZaWD4TamzBqKpngn34XTpmBjkePuVQ1y8+HnUT2oeQ2yGS4BZ
	T8mJ4fj4+IhZizxC84IpioJeoHwjxWGPKF+zW8pnu/l9nHCKSNR3vkDa
X-Gm-Gg: ASbGnctGT2CPQyhd6Wfmk+iKnrwwLbH3fCJnI8sQsqMqwhW61IIYeK49E45mdALy7kB
	ljSjPmo7809y4jJw37XRl7gVCQL6zSLZbvbe9s5jgmxIwdCzZrr6yGRmQL0OjNcRzYE/TQjIE4q
	Fr8Y0ZicoYnuvjwpcCvx2apr/yJvDOBy3Gf1v9SnANid3RKEZu2rkWeKjSDnKPgm2tkYWefJsPZ
	J12FbQILZ4vz6SUKBc5LezIpwT3WmJTIZF6xWp4EGxGYn3RP8rEA6eUT0ASoxw8Hyejsq4JP3J4
	Nl3AS5rLTCOhmDH8NUEPlJ580cA0nxImUA8mt7tqe86KQCFJHSyb0OwYw5pOBC2wnbo217vXaVN
	9a2+784Afkb0Bn5zkSo4c/NVQ9PIWxFEFAyizkg5Zhxwx5CqH+SPpI+v3RDoSNLeE7HK+azaE5H
	mT+VSYCp1NEsyH05o8OpgvjFY=
X-Google-Smtp-Source: AGHT+IHdTvay/STs3LNZkpmmMt8IstasmpTYD+N4EpMd1XG2nuq4zcxaDuN9vSlvYoOBreCnQRf4EQ==
X-Received: by 2002:a05:7022:258b:b0:119:e56c:189f with SMTP id a92af1059eb24-11df0c3bbe6mr8274625c88.7.1764954732270;
        Fri, 05 Dec 2025 09:12:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20697582c88.9.2025.12.05.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:11 -0800 (PST)
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v2 02/13] selftests: ntsync: Fix build warnings
Date: Fri,  5 Dec 2025 09:09:56 -0800
Message-ID: <20251205171010.515236-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

ntsync.c:1286:20: warning: call to undeclared function 'gettid';
	ISO C99 and later do not support implicit function declarations
 1286 |         wait_args.owner = gettid();
      |                           ^
ntsync.c:1280:8: warning: unused variable 'index'
 1280 |         __u32 index, count, i;
      |               ^~~~~
ntsync.c:1281:6: warning: unused variable 'ret'
 1281 |         int ret;

by adding the missing include file and removing the unused variables.

Fixes: a22860e57b54 ("selftests: ntsync: Add a stress test for contended waits.")
Cc: Elizabeth Figura <zfigura@codeweavers.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes build
    warnings 

 tools/testing/selftests/drivers/ntsync/ntsync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 3aad311574c4..d3df94047e4d 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 #include <time.h>
 #include <pthread.h>
+#include <unistd.h>
 #include <linux/ntsync.h>
 #include "../../kselftest_harness.h"
 
@@ -1277,8 +1278,7 @@ static int stress_device, stress_start_event, stress_mutex;
 static void *stress_thread(void *arg)
 {
 	struct ntsync_wait_args wait_args = {0};
-	__u32 index, count, i;
-	int ret;
+	__u32 count, i;
 
 	wait_args.timeout = UINT64_MAX;
 	wait_args.count = 1;
-- 
2.45.2


