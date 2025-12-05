Return-Path: <bpf+bounces-76138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB7ACA8946
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D7FE3119959
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70353346FD4;
	Fri,  5 Dec 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx3s/rzO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9479346772
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954746; cv=none; b=Z4C0bAZl2kXariBHZ9U1NWl9PhVRu6Q4akZRInsJ+oSza/FVALiuIFtvyqNeMMgPgkkMd1mN2kAZMa2Fpt07AZfDemxksqehmzLAh3tvu2SqKWA2268oafRGtCzzh6lUGCy6E0CaVglXuQE38B16u3sPDMIlaJr4YjkFYWHKuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954746; c=relaxed/simple;
	bh=pgJ6ff8paldt7V+cFG947O9X9Ylktw6h4GCVRLqVB2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDZQZkk9QZJDULdPa6dF5TUdh52XHol5vOZDVNEz7Dkk5p0y1psiMAYRp3JzY1SeNIYxN7xu8kw8YThbSEAOvGMN5mssCvdkQbxi6ccqjCa11FvHC9E+fC39tCc8XF5Xoc6m1tzwsGiOnK/mXnQ3jaLC7lhrYVfmQXZqd9C4yGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx3s/rzO; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11beb0a7bd6so4118773c88.1
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954735; x=1765559535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvo6P+4Y0aHWjG3Dbxy/Vth64KyTxoqjK/aQ5O3LvqQ=;
        b=Qx3s/rzOxetlefVCd/9b0e6fuf9Fxcyhf4+Un+8WtZbK3GehiKSpqlVaskjOGKoh24
         wHwCCa6SGkX88GU3x0ydtAcq8CyMECYfCUPwW6TJVZQp2tsSAHGaUCnICmM+qOXmfpk1
         uwN7IcFLC5587uRO6q79Qm6CF184uWBz7SzZKFwi4KAIrlnwbLeLAzW2GzlPIHxPmoVL
         Mcaz0CBx+iYDUDGdZd1bM+9DtOSWYzSayQdbswTFCtI86ifHelQnBh6SHPeb35b9cT6K
         MZfYEZakBTlHh0P68RNSk1209SP631YXS2Ik2jeaaY9tNuErPKzvd6THNdLe0eZRf7gB
         RvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954735; x=1765559535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvo6P+4Y0aHWjG3Dbxy/Vth64KyTxoqjK/aQ5O3LvqQ=;
        b=Ai9o0XHw+zvYGRG4Vnc4LOFC+x+JCRRg5dA7W7aCr3X2JBysS2jyhsKCFYq3TyTW20
         LaUUTffZG/EBUbhlDwxyIkGQRfCGMpBqKc4yyCvbuhCU72kLym3xElrUDN5G9daS63QN
         Rl7Fgg/0y2gmcXZVgS0V5rFPM5pWnY9Onzn87MPGQJSi3gG5H7lHD26TcxxKBtXMqvgO
         WAEJyF1j346lk3HJoi1s6XPQklR4KPU9ENH6yAVaePCNhO5X9+Efo3NXySFc5/s3iCUY
         17STsRR4oo22UF19A0tttCKJO3uJON6e6P4ssZjZl8pdROrdGErNvr5dtnkJhbwX6E5m
         rnXA==
X-Forwarded-Encrypted: i=1; AJvYcCX0YaqaanIm9aIOLJf1hXg7mMWVIoXB7+XPuyc3YQGJohgZxW3H6nDx1pbqPVEjItQXHSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy60CBGuyp0sdRGNueq1zh5ny1VxSHkqARasluEgkOLBsjAEnEY
	0hKxZPt7V5NgO96zhzavhumUmXNkkx4OtONwGCJWq3cEl5ePnY+uMHv0
X-Gm-Gg: ASbGncv4h5ulnu0vNrnaHzcB/HyPipKeiWjHDa0I/gU8h5IELdYWCsL/jc6YjPMZeKw
	9a7L2uAPtqrDtxAeWpA6MJWVYudQsCovbnQNgYNh1BIthwZA+A6kMLoEvdQmz1dHgsd4AhosHV2
	EavgxbrmagZpJ7qKOsi2wNLI1s2/2fHiRJgrBAV3nwM1r9t4A9VP7GJwXurW8AB/9nZxJbEk8PA
	pfRlHzyhhNL57oDleFtf0t62ZjQ2Z3nQopegE9eX7XiNHZDSUCdUm2DIBjq8xWEXVur8UHTIxUj
	zbYRGhhozuhyKi1/xiedrG//WVMFodq5aLL9LtlbMZUJxqiAAZ7rxf+fvyP/XLyZyvYvnLrlcx8
	SB+Ct44i+AlooBrGY6/zUwPrJkzSmMY1gt8iYGmTiGykU030rLV3ENNG7o4JnZsmwSZF/iNbO20
	7iJIjPXfiWD4swGlcrjEFyW1I=
X-Google-Smtp-Source: AGHT+IFCC9u36dpszL8LHl6yuqSwEshH6IcGGz8u5zeSSUuddfN+n2v1mO2/tmCjMeVOnHnvUljNXg==
X-Received: by 2002:a05:7022:249a:b0:11b:ca88:c4f1 with SMTP id a92af1059eb24-11df600e305mr6401788c88.20.1764954734841;
        Fri, 05 Dec 2025 09:12:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20698013c88.9.2025.12.05.09.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:14 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 04/13] selftests/filesystems: file_stressor: Fix build warning
Date: Fri,  5 Dec 2025 09:09:58 -0800
Message-ID: <20251205171010.515236-5-linux@roeck-us.net>
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

file_stressor.c:112:9: warning: unused variable 'pid_self'

by dropping the unused variable.

Fixes: aab154a442f9b ("selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

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
2.45.2


