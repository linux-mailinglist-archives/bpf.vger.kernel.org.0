Return-Path: <bpf+bounces-40649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897498B413
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288361F2430B
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1B1BE23E;
	Tue,  1 Oct 2024 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h583iV8y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC11BBBD9;
	Tue,  1 Oct 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762487; cv=none; b=H9rlTTl23VhifmIfMH3wKwEVj1MJHudA0Id71pQXwGpTYrTQNhsHm4GwWKOrj6NG2kl313LGUJdt5PyjX9C6RRWEldZaaFxzxCsetTAw06Ax/2nR6tyrwvWIUSLub1MkAk9PkfDe/IXOrgAMkxmQKeGRzqC3HFqdPqaaC6C3NkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762487; c=relaxed/simple;
	bh=ieuL/O3/265wxoAQ9SYV+ZrakZmm8ntMC/lUQH0jiok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2Iz7baQUr88DngwaRmVD6n528TR0bGft7G1tdu80LVf1pb40oY7Nm1reEMxrnn15loSaNhp4m0MWDm6Gm/yw1Bd5J697XfH/t2H7iYjaCV8XrJr7WeEP9upaLs4uMt1/5UI+ycnmm/NxCMbeYlpE4SIVr84plPbqsnMMq6XbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h583iV8y; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b833f9b35so16508235ad.2;
        Mon, 30 Sep 2024 23:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762485; x=1728367285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfr8GHfpAnekQQsJ9DXbNrw9ejSWEOElOr5R5vluBYQ=;
        b=h583iV8ynLNhuIOaOC5UgUkHL6yiC86V7Tkv+X1DpMBUtGXPJwRCHoqTR77zo3wtpF
         YT9yOwrIvBLZT4DvCCRdzLQxLR+LIEI2qIXJ1EEl1+kqaDftX1qEZpPvca4ajKqXrq2m
         LshIEmdJD5FCVslHt2GfgtfIQ22noNPQsa5KT7Vh+8dQVUxQnH9HhEiP1Vp4TPGcNWXR
         +yHfrzd8/wZCHLGduwYfY4Of01XxB4tyxHbRlGCD8SV9MJz6E1zuBu2j8i1e0jNHr7aH
         coRujU/Pfwj3IeiNnV4Yzre96cO5Su2SNouxB9oQDurUW7DKDQoGzKf8l2RPSVmH5sZZ
         7dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762485; x=1728367285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rfr8GHfpAnekQQsJ9DXbNrw9ejSWEOElOr5R5vluBYQ=;
        b=kofcji4eDnewwhx1kyxuFonYSgnYbwGlMJrogekikjwXiIkM+oohCgVLMYhNhiAszC
         8eOm1Q3EqFo/mWkJWg5SsEIJgc+gZ8sBWAU0i9ffRMcNU/H0V4RFDXdCC6EpLSkXnVK1
         UlvtyJOgsUC3Gp9Jhs30yVDaE75JUgc/1u11k6GHlkaZtWHRlTLYsUHS3mS6Ft/Bxv8R
         wvqzP0nqBYYk65utHASsaDxXgPkalwa3v+V/dF1z12SmPTloaBkiKQZ4o5UxXs33NP74
         ZQHwmYI+hzGomC18tXONHA8HR5zfrlD02vdAB8up0/jZPEgUFQLLms5zHNt0ALUuR0Wt
         PSkA==
X-Forwarded-Encrypted: i=1; AJvYcCUFsm2+mDgFtYs5m60+V7a9bHeQ7h/L69YozkhqM+SBfzIm0WNEYPF9MKWuo82Jr/a+Kwo1T6e/@vger.kernel.org, AJvYcCW0RsXuU+zYn1O+wfTMVKv1a8DnfIIl1wLZBoSXUoYJ6NObjQ8JFfxzFbsNIw1bcsr/alOaFWK9rifk+VC3@vger.kernel.org, AJvYcCXgla/dc3t/iFC9a3gz0mU9Zr3hI/tpob1HKuadoDYUNBy2nSF1nGOdMT5nm+512BRK2ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBXf8BxBDMdsyPckBH96G4gusNtxiNFndIPsV4YZtYXWx2DNcW
	090qK0MEb1x1g9Hfqj2JQ4TTEmEZHUV5jtE417uL+TYinx2tJ8Qm
X-Google-Smtp-Source: AGHT+IF0pqg6cHdPQNZUnpp0KY3LqcCogvQjVaDIbEAdyFcDi8rMUdKYWPzepWjPauNArtxkGDit+w==
X-Received: by 2002:a17:903:1208:b0:20b:2eb3:97ac with SMTP id d9443c01a7336-20b36ad2914mr4118545ad.24.1727762485308;
        Mon, 30 Sep 2024 23:01:25 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9055950a91.7.2024.09.30.23.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:01:24 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	atenart@kernel.org
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
Subject: [PATCH net-next 7/7] net: ip: fix typo in the doc of SKB_DROP_REASON_IP_INNOROUTES
Date: Tue,  1 Oct 2024 14:00:05 +0800
Message-Id: <20241001060005.418231-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001060005.418231-1-dongml2@chinatelecom.cn>
References: <20241001060005.418231-1-dongml2@chinatelecom.cn>
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


