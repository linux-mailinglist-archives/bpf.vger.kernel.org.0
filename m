Return-Path: <bpf+bounces-76136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B5ECA896A
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A9C303A082
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27343346786;
	Fri,  5 Dec 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5tfFdwR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8D33E368
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954742; cv=none; b=oEk1Zfg8SLTw/UXyqixKqKV++kFF0Ka0oxs0JsRwp8WpPbm8DP4Pbn/TOO+OID/kj7F83TBRyM2U8TwA5pGERXSZ4SmuN1SIqYAhwYSMrRJTP/CvBhkZEnwyVAXKZTsfeeHSofJ+OrJXh9MeJw02uM0oix08+spSsilhHR3O1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954742; c=relaxed/simple;
	bh=PeM3U+qiUJyHEyS4FHxgahZdXga3yLayx7E6kX53b3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mks/H3w8KJwQI409YjI36DmBrXzNdcBRyHRdkQWDwFVhM9wZnxAmMWdaSiZ8M1CLZGUqyNEhnjXw698BdzYcQMiYrtxnHQMsTj+42UBRv4oJW+PVmAXZXZCxZ62TeCJXa0f1dhHK6cS5cQvddsRbJJeR6TcuoozRLhpnnO50/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5tfFdwR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297f35be2ffso35956605ad.2
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954734; x=1765559534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4zEaQaL7Pv6lx/OIuxHCiaYn+nBOnbMD8B+U7ZMSws=;
        b=i5tfFdwRm59drgmdOJ3B9RXWJ6Pw/QlX2qAuqLzjNhsfLEdszQVDFpSrc64kLViifo
         VMFbclFJ4Hy9lLUfGfTwS/KukdAPDIWJRgWZ+tIlw2ImlPD899PlZzuTqLarWQqs6Mik
         jfGMMQVqPkKOncjy3H7gzLngj77i216yLhQa7/JDnvXxJrvFpUvwgR+7yU64iwAOXJmX
         2mbkulgGb0umKQiaVEEmpErPHVTCpk2YxublgQE1DShQz4MJ3lAXIpph+tvN+i0JVs2K
         81BQaNaZ7v0ls51Ems+5AmLmWqgO3apSOkv3patmVydLiq0VrfFgEEkXP3gYryMYkTBD
         DDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954734; x=1765559534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4zEaQaL7Pv6lx/OIuxHCiaYn+nBOnbMD8B+U7ZMSws=;
        b=JlNmvvu7ABgHqMvPs8/iaWdCioMj+gYMCuytzigju9cE+8ADAl0u6bqtAbwTo8AQdJ
         8jhHKmGwOIhcfnDpJijnJ9C4uiLN3NYfbmKQ2q49xVLp8xEI6ZGeYsqNdFPfAS7du36W
         DEN+17/NJS8U7wvntVzINTSkXTDS50F/lCUqOGEMz/Qa+qIPA3WMz1dRKWOA4lWa9HOT
         FjVKGqvAqB3SbuY00ImME38m4raaIrRMXoukXCdmzvm/k+geFqE6DftAB9ONKtnKTDVP
         CAcfz+8v1OVrZGKbPyNKbb0RR4kqKNnWIGQ6/bcJWT5TpZqDwGNbosNOQQlBnPzTCLR4
         dODQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZtKM8oMfjK3auHaI1XBzSu8ZMo13knA5DpGOC7gUEG5i0PJmfUcXpxlG+4i7Wvb9zlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13m3Q1k9+1//W/B4TmtlqBBfSInKQ4h8BVS/LAxvChVF5IG6i
	KpgEGepENI26DZQgCj89Z+NA55/uRXaCT6RyYayls4Yx0NPBTBc9nUwk
X-Gm-Gg: ASbGncuF2b2ixjE47CPksGgHOjOyNGTnKaXeJ2jsVH9Y00C7zDmABZ9pWC6tUV1HHZz
	Bl+zBSWY+Z69y+DO3SylBxh2yic1viuVr/Fk8sbf/+CzlfildJBaKxNmyXiaC33oa/HUqsqVQ8q
	I1dqoMFHJgwSknbmgO/LBok0aU4brtKpbACOl/36tKcNyA0+zBMJAPywfNZUhsc/93gSrsmeQHE
	wt90llrqNy2uJqyJmnMslR+amqTZHjFEWualrsHNfcd6hh4KV50w+q/a7FbjIFX5m+C26t08pje
	0NTrf6MEOgdjvlMuOL08bd0hx70lBfsiYgJCcXKi2q34oNtWeLQcBaipRVTjtd6v59JlTLejycG
	kbKGxim2Qhb9946USZXIsHWHs/XkyV+lFBnlR3BBUr14Oy2EQqWddOUtmfIH/qhYnv+jV9kj7g/
	l0UGprxEqhikhIUdVlosK+z/A=
X-Google-Smtp-Source: AGHT+IEILnyUDBxkUqKFnFNQ7Nhkhn0QxxXlIHLswHfB2urPR98N+iL6vUBWuopWt/6R6xiEyOLeuA==
X-Received: by 2002:a05:7022:2596:b0:119:e569:f623 with SMTP id a92af1059eb24-11df0c47020mr6816898c88.28.1764954733575;
        Fri, 05 Dec 2025 09:12:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20697818c88.9.2025.12.05.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:13 -0800 (PST)
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
	Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 03/13] selftests/filesystems: fclog: Fix build warnings and errors
Date: Fri,  5 Dec 2025 09:09:57 -0800
Message-ID: <20251205171010.515236-4-linux@roeck-us.net>
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

fclog.c:37:21: warning: call to undeclared function 'open'
fclog.c:37:47: error: use of undeclared identifier 'O_RDONLY'; did you mean 'MS_RDONLY'?
fclog.c:37:56: error: use of undeclared identifier 'O_CLOEXEC'

by including fcntl.h.

Fixes: df579e471111b ("selftests/filesystems: add basic fscontext log tests")
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch also fixes
    build warnings.

 tools/testing/selftests/filesystems/fclog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
index 912a8b755c3b..d7cc3aaa8672 100644
--- a/tools/testing/selftests/filesystems/fclog.c
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -6,6 +6,7 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.45.2


