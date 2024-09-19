Return-Path: <bpf+bounces-40093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63BF97C75C
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571B9B2714A
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B73719E96B;
	Thu, 19 Sep 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0/2UBAw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81919DF4C;
	Thu, 19 Sep 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739014; cv=none; b=V3pDta3vXl35ds6zBhKZS78jd60w6AbbjEYC0cfIxk8wbI5AFQVPLj+ui8reQgXF9+aNJmlm6HgfruGh6XoSmvvim5+3YozstTm7UYDad+XIs7Zxz9LR5Jd3WrpcIYLYRLnFMvQwI98Oc5pLjPTX9cHkRSOX4lUaAsnJFNYgz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739014; c=relaxed/simple;
	bh=ieuL/O3/265wxoAQ9SYV+ZrakZmm8ntMC/lUQH0jiok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKEACobH1/UN+n3A7VHuszoE2Z64RCbB2VNw874z8rNTkCLjsMjG1zvzdB6dTP2jg4G5yAB5wseD9PjGTt/eQd9mKKwKLJ6htFqA4hN8umiltBJQ3end5Px2BveoAyL6AIpx3gZrPCKSFk5M4I+1v7/ZD7q16LHP1X1pfIT39YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0/2UBAw; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1357626b3a.0;
        Thu, 19 Sep 2024 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726738993; x=1727343793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfr8GHfpAnekQQsJ9DXbNrw9ejSWEOElOr5R5vluBYQ=;
        b=B0/2UBAwma0VutdNcINHEGSOz7zx/GIYaWWqDwYJA/iu0aDIEJmvcqj1wHE/JHyjXb
         JLpawxRcFngs7m6CXEdnxAUhwqhN11Bwza70UuFiInPyChXyBXDSvGyXKl1jZVnb4xUR
         qckkYBy8TzwGVcajZRQLbnd6tv+mIZXyoBqkmtFvKX2qTY/3Ccii1vxBwkm5e4K42PlL
         9Cgg4xvva9Fyl9MixcYHi34QPZ42fk+0MVQABvAQc8VU0XtySWMp5rViVR+ku9GxpAhJ
         +bKUpB8O6vY1i4jT5Kp/Rxv/Tbs+dgSTl5fxCAlwHRlUfNzDsoXOm4Dn0xau098EqZz+
         9RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738993; x=1727343793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rfr8GHfpAnekQQsJ9DXbNrw9ejSWEOElOr5R5vluBYQ=;
        b=TO/Pm7fxQvUAxN7vrcididwKo9qHEdSpJIW8eCX2qd9ExR2KrkveO1hY7/hp6PaIqG
         wNjSGZ4NewfcylRoCqNBiFTey+jqSubbxm01dHerqltY57/+F53dllk5UI/yvvyvPQwR
         l4g7Vnvgyd7RcuMW/tk7LQFV6ZYrDdw1BDZz+gUKIPvUiCuRA8Y+HMF7pBzIMG+pF79c
         +NgpsjT+PeCqxcpFWk6r8Ciy65NP98i636+m4h/Riyu1bv5bZO59DOaoHkLsKGq1A8Hn
         ig1Wu2qVQMwIe+HQT+mDTeHmq+rYHi74jwIvKGvABYVSfe9tZIo5FNogVm2EZod/uNxP
         hOiw==
X-Forwarded-Encrypted: i=1; AJvYcCW0IW4s1r3KDnokPEXiSOvxGhwn1WRsMLGJIKNcnSd10b8rCBk5mJ/yw81+5t1zPndzRoEp3mW6Pp137Rfi@vger.kernel.org, AJvYcCWfRaAYKmkMcv0ayAm15K9GyjhZFruwJmOtYStj620FxS04OewKd2kn6oLQP6rBoSbxmrVHSWNk@vger.kernel.org, AJvYcCXGA7MWWWtfSDFCLjaHMF7bm2LG9tLNE1iBbGGJkIdQJ24OHLVNEOpFTRebhvSvYbGKzhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKV8ZB5nmkeIaM983T6H6BAvWXpazuSzs0sM/XbsM4GCzvQ93
	Z6zVgxETDRDYh8rs3cjOpRuCM9t4AXTAS2vF7KczE/IBdYEO4356
X-Google-Smtp-Source: AGHT+IFX1KD+RvJbrJVzp6geUXTu7trq7flY/gtaClnP3+TUmI1zNKnGzoDcQrqHbOfBTw4UhC+0rw==
X-Received: by 2002:a05:6a21:168d:b0:1cf:6d67:fe55 with SMTP id adf61e73a8af0-1d2fca179c2mr3744940637.5.1726738992908;
        Thu, 19 Sep 2024 02:43:12 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab4b36sm7927086b3a.47.2024.09.19.02.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:43:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dongml2@chinatelecom.cn,
	bigeasy@linutronix.de,
	toke@redhat.com,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH net-next 7/7] net: ip: fix typo in the doc of SKB_DROP_REASON_IP_INNOROUTES
Date: Thu, 19 Sep 2024 17:41:47 +0800
Message-Id: <20240919094147.328737-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919094147.328737-1-dongml2@chinatelecom.cn>
References: <20240919094147.328737-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a copy error, and SKB_DROP_REASON_IP_INNOROUTES should correspond
to IPSTATS_MIB_INADDRERRORS in the comment. Just fix it

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3d1b09f70bbd..a68235240f6a 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -366,7 +366,7 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IP_INADDRERRORS,
 	/**
 	 * @SKB_DROP_REASON_IP_INNOROUTES: network unreachable, corresponding to
-	 * IPSTATS_MIB_INADDRERRORS
+	 * IPSTATS_MIB_INNOROUTES
 	 */
 	SKB_DROP_REASON_IP_INNOROUTES,
 	/** @SKB_DROP_REASON_IP_LOCAL_SOURCE: the source ip is local */
-- 
2.39.5


