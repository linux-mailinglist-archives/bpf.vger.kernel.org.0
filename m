Return-Path: <bpf+bounces-76057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA87CA47D1
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A867B302A76F
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6569313290;
	Thu,  4 Dec 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE+0E6SX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D97314A7A
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865062; cv=none; b=uLMBOh8o8XjTpf/QtLWAJf+7J1t4thmek3HCCL0PJ4/IFJWKLjGXA7fOO97P07srr+n1wTdLLNjJPdpVqtvj+biztf/4AUXnaSWkqC3oXqO9I1xtT+4/u5zb+RpYXCHudmH5hu63bb02PiyX0oehNyNhWi30DLUAHw8r/CcmomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865062; c=relaxed/simple;
	bh=gZJXV78gHZtRTjJ5rWeZmQz5j6YeAgfJSOukEvgm3/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIjlmy9/qOsERon9GVZzmC/wREY7i7eGDb14mIquQ4btfjYbYJxp32uqzbJx3mnxCcuNGNKRkG7U89Z9rqEp7LSPxOWMssxEkrsu0WvOq4Va7CHLkxYNBKU65hjbl1ZeAVFRuO9klcEJScupFYuL682i+NNmDl+j3tA/b6k1wAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE+0E6SX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2953e415b27so12786905ad.2
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865060; x=1765469860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwcxoNWnHgxgVsdrWFj6b2CCDVS/+W82Dey2vlOgJ9c=;
        b=AE+0E6SXDSYSrv/1pbglKIvB20rgVqo6Cj1jL07ptnrRcdXwDKMR8IysFUQYE8SW8q
         li4W0oKSxb7zk3xIfGadhkTRKeXOr6twXHAxhTv94Ekw4s+3hGizUN8KkGm7lZbD4mjd
         GIaAutHP8g8RFakgwYlOn1OnsWWemjPRCnBsD0DAVj/THN3Xloezh/yr8+Cqm4S4wnCj
         VgOkgYmPYlPIfnR+7avDaxvLk3QbXTQEEnSYv5JsPya1q1koJTD2vSiR/KkpESICuY+M
         ggRA8oTQhF3ybVZt659yzPI55aymGl/0HsEaq0NBJkv9fft1326YMrz9ueVY+3Xg1CZE
         OspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865060; x=1765469860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwcxoNWnHgxgVsdrWFj6b2CCDVS/+W82Dey2vlOgJ9c=;
        b=pmht5BMKzS7uWkbs6eR+XKq+WPW9EZC9jaxDSSUj4uVfe/iHVDuGnn8wNvW7txk4gE
         6HJiRlB7OXw61NY+ZPjYUh/lHGrweZZ13Zm+L1L0GbmLSJ09ioUNU0HXIuKiyvcPkZxd
         QtNRBdWCNb0GEYNt7Z0cdGxjVQ6r3s7GoGu2qTJf1W/HDFBxvtP/H0w57mtgrK/ccOcQ
         nizGyyp6t1Ij985Yn+NAlY5GyhH3B6hISdXVmenC/OyVuTc/c62xf9aQg0l6y7EvFfbV
         CL4S7clWWJTAkKQfWTS8j4so2yZa+JkHNTVvEYpoFjnZdrW3J+qUzo8SwG4lvYp0S882
         24cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Sk7O42cVg2jAdY5dLeVzAsO9Gz8nwX0qknTCwcYrFrLD1ByQ836ehHF72tHajj6NhI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnxT2Xqy0hC+SRhsmgBj4fn+ogrSsIfh5ZX7RmS/QjT+pzq7o
	bsn7jmBzpYVOaExIASj4vK6WX5THrl8epC+PBzFvAbyLHcDobKmTvjq9
X-Gm-Gg: ASbGncsUeDSM3o/rFZdz6Mdst1rJ/4H8UUWVx6yHQDc6mM9qIU5NwVO/DiFq7N3bo9+
	qkjeFnAOkpJ4YGQTiQ8BQPWrB6FYg9PR6nVdww5igcszlhlZMHbVnQ50Rr+QPp+W2T8mEUUcGCa
	eBXX6T7q6NL8rgbvSQpuLd6mSjERxmGPr57PggwG5VT5REEsQ9xiveyG/U14n1s5LjKpgDdfvuW
	+KCwpt/VbSvsqbyJZb2AfC5RQdFqQC3AxcHCtPWuVh/b31IemvwNelzY2OYJWjEb7+PpJ1wrzYA
	BdRSiXR9p5c7SxgTljMNSgHl3V+ARNnlOlpJy9ytiB+Sxm5mslkjf488Nyv/saqcIqYrDkUOS4N
	SArjbUqs5rX697Tvhk64txf8RtMh/D0opfLTAZPlSpAooVtXjp5mlPpVBGzI/H3Q5Zm2/fhOGm7
	jdfTr61swftlElb4aAMFhO6uA=
X-Google-Smtp-Source: AGHT+IGzmB6v9ps/YSI3Qm3cpiKTiSzZ8l+4/hp/M5jJOLx8geHlmhJcVZldcne4oworAKr/lAMmiw==
X-Received: by 2002:a17:902:da85:b0:295:9e4e:4092 with SMTP id d9443c01a7336-29da227a59fmr40482655ad.56.1764865060170;
        Thu, 04 Dec 2025 08:17:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabba6sm23744045ad.73.2025.12.04.08.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:39 -0800 (PST)
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
Subject: [PATCH 05/13] selftests/filesystems: anon_inode_test: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:19 -0800
Message-ID: <20251204161729.2448052-6-linux@roeck-us.net>
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

anon_inode_test.c:45:12: error: call to undeclared function 'execveat'

by adding the missing include file.

Fixes: f8ca403ae77cb ("selftests/filesystems: add exec() test for anonymous inodes")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch does not fix:

anon_inode_test.c: In function ‘anon_inode_no_exec’:
anon_inode_test.c:46:19: error: argument 3 null where non-null expected

because I have no idea how to do that.

 tools/testing/selftests/filesystems/anon_inode_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 73e0a4d4fb2f..5ddcfd2927f9 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -4,6 +4,7 @@
 
 #include <fcntl.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <sys/stat.h>
 
 #include "../kselftest_harness.h"
-- 
2.43.0


