Return-Path: <bpf+bounces-76059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B189CA487C
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E683315D1DF
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064033B6F7;
	Thu,  4 Dec 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7XFvaj9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42AC33AD91
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865066; cv=none; b=S3l11hUvdI02nzOrI+xNMp79f5fltN71zecYaNVVZaZl97Gstu1lZA56MJpk7I1s8YZpqPzPL7M+D+w/5u9EyM5hXhBBwnTNBEyAwdKP75zAVJk+I9fzkbV8SYEFVdroj4CBjO3YJsZub3MR2RXQVOyIuYNvTcSAlygDKNi0xZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865066; c=relaxed/simple;
	bh=5B0PgOWPShXER40nv9onVYknLk01f2ENlcdo44PN6+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBUwduAv1YZrgBnXptCy9Ep6NZGX07C46Yox7DC/B0dpIB1mywyvH4BRy7uEhajFdKj/heIWn/75ZAnZM6udHroT4eR/BKa5zu0pU53XD+eJchRoYN0A+CuiL1i1tkAoEzYEdiaTAMovUHwVfQR8OoHjdYBGJ37zFt5Qj6jKhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7XFvaj9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29d7b019e0eso13441435ad.2
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865063; x=1765469863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJUImmdQDjeHGtaLXSfCuWLTyPTXVTEGrMh8pUqqH00=;
        b=C7XFvaj9zQybUoQIo86zSH5P3sN8Cs5+ebYnZ25odOOe4mfe2vAGU/16+r+vPtpLUw
         wCGGRbkdghTn2eFat7lCQXxWXkg3FYn+Dlkn+rzrWpDV3gPkAAZTJDlIbCqYNyas1say
         OXAof19DqGtf+qtjWbjmhmlU65I1Oa6wASqXq7huWjMm4pt0JbCLTNCsiUZwRHzvj3v1
         NrwaHb6Wuy8CNo7fQ2l1HxK50F1BktRNB49WEJAa+j1j6RmOFUwFfyW2HCYZS2kkcP49
         Udi+MhOmQpglctWszcLZrrM364rCwji1GRrhYezxDIFJPlb+C+TgxdVbF5plpRDx1yL3
         Toeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865063; x=1765469863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJUImmdQDjeHGtaLXSfCuWLTyPTXVTEGrMh8pUqqH00=;
        b=nqMDit5saogM41Sb+5bEuTRkpEXUtk3WYzkjY2ME4eG8USf4VTbAZsRQHdNoq7SqDy
         PPY6MOZVE8z6MFOgxECOPRs2juQg5Pj2PneuFEJq/0xyjCbVn9kLpBcuAG5J4c+qp+Wx
         opNCk90Uw9NfAyt8FhfZbf2N+5DI/8Jwnqx5dYHWFnuv41Rx4zcSWO6oOu/xjppSJ/np
         nr0/I6kMhH+aBomr+GpeFAijkR+SVXIJsBbVDIPPkcNhjkzkaYuZdAikRT4O4oym0fTz
         PmO5oD6XiT6tF2MdFYUXTFEYph1AJrtWhwwVd5ySuUmWucNWZsSkDLiFicG4nNgPc0Ni
         4kOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgFr/XMZaOoY/Jftvpdl1CRsVe/7DOEaa/H5osquaJb9xXGxA5p3hMgUaSjAZfSdqGeZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjlIyJTmedqrk3B/Lfu1x9LL8660ZAvSo0vmcRhYW0Nt0asRW
	5nVZHGZIwgCaG6FX/rLFkts8Blc+q20QAzTF9AlRoFXTWlP8uGacVQGR
X-Gm-Gg: ASbGncvZIN4FaY10LavpVh9EMl1DWUwdinu+FLZRP5Qb4JuA2SVFmnxqeU4nGNsyiF6
	yP2TBKyvFsK+kY9Q84RBcqcFaaaEoiHb1De0uTap7En6Dxfo80acpT3aPvnb7aHnC+H6nPMkJQW
	mEGPxJ1+8Y3gnMVZY+J3/CWwoGh8ppjKcpKDVLg8usxwFNkm7Pixy64DoU97LFuvgPC05S6RxFC
	iRHycsE1Zgjv4ZIMjcuwCpjtuhFh3+2+bbtcp6BGBsve5q4N5xhc/hFm5jrqKMdqnSpt0AVVcmb
	t5h6kv4sFw0zsn98Sd6J4TNZKhKcqk1Gq4XTucz438Bdf+BkCxWgt6z2GarOxYucEQvMPhoimVB
	L88KR2rXgCUzYgF+g+IwPn54w7BWvae0SOCr+UFXVGSDTig/pokdEUEqRDHHUB+oQbJHmTe/B3M
	pJbqHdGtu6jkG/JlVqjyJp/ds=
X-Google-Smtp-Source: AGHT+IEp65adRZJkHxaNOxWvtN+myggtoxv0yjR0IEwKZeW5OawGZmYTcub9/vSJLWwxb9bL+b8PmQ==
X-Received: by 2002:a17:902:ccce:b0:29d:9b3c:4fc8 with SMTP id d9443c01a7336-29d9b3c5ac9mr52907945ad.61.1764865062930;
        Thu, 04 Dec 2025 08:17:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf9c3sm23939485ad.26.2025.12.04.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:42 -0800 (PST)
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 07/13] selftest/futex: Comment out test_futex_mpol
Date: Thu,  4 Dec 2025 08:17:21 -0800
Message-ID: <20251204161729.2448052-8-linux@roeck-us.net>
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

test_futex_mpol() is not called, resulting in

futex_numa_mpol.c:134:13: error: ‘test_futex_mpol’ defined but not used

if built with -Werror. Disable the function but keep it in case it was
supposed to be used.

Fixes: d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h")
Cc: André Almeida <andrealmeid@igalia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index d037a3f10ee8..8e3d17d66684 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -131,10 +131,12 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
 }
 
+#ifdef NOTUSED
 static void test_futex_mpol(void *futex_ptr, int err_value)
 {
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
 }
+#endif
 
 TEST(futex_numa_mpol)
 {
-- 
2.43.0


