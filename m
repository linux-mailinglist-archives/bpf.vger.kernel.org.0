Return-Path: <bpf+bounces-26527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F58A1668
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE731C20E5C
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435AF14EC7D;
	Thu, 11 Apr 2024 14:00:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47228FD;
	Thu, 11 Apr 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844016; cv=none; b=WLI0XnxR8Mh5e64N76m5GvIB/JjT7G5pDRaT4RjEE5ju1NfrpqV935nJUCoY5coFx75lBwsHBWneP+MSnBZ7s1MbvUWeC5pILEK0Fmg0kXny2cT/ZoKyOPUUgZ5VzlPhGfDHYrlOoHVITFaYugeV+sNYkjGgWWsVE8a/ZJgpk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844016; c=relaxed/simple;
	bh=3aNAAVmZoAB/TxiMFpKmxPd+4cdVBshAwrqwkiPvd9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPG6NUhm3UY4Hn2iRFfUYfXG3xEG+Euvty22gU5yBYAhERwpb7M5VJcqDMSR8eU5Erwn6wn9GPCFmtAkiohaK9uore9O8II/p226h/rn6SCFsT5fm4I4ig1XLsvVDx4Mn41b5NAsyzpZKqw4Vjv4B+IUMOlv/D0U76pNx0uyzMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516dc51bb72so6693368e87.1;
        Thu, 11 Apr 2024 07:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844013; x=1713448813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miI9xGAlBZQu0akspfN3cRlFcXGyCJhvWho9XnQboUM=;
        b=hK0HEu7G2RMUI123L8v9iqbxYg4C6sjDOH/kdMYKCx4R6GkvUcsZDDfeQtUHFbWz97
         IESPSKFhX0pdmtQQX9iRojFrirUtCwQexPOmXdQ8UAC69OgwxdNxrN0nkpqAyjf/GmB/
         jGIhAV/6qnIAS5W2rgWKocFF0j96pfnoQkU50YpQAytGe7+BqnbvDOcwbomogwxMe83o
         Bc22Vq5OKAY93Uk80Ki7D/V6sSuvKbOKxMyGJuiXdbDZpAVqXArFfk+ilMLa3SZOhuif
         D9npuLJ6G7JYqu2yO8rk7nCe2neK8fBiU0cfpJBXtKuXsbhIdB4P6/NJPappcATtVO7p
         MN1g==
X-Forwarded-Encrypted: i=1; AJvYcCWOSgzVGAiucNU3kU9leQZ8yN9NPcmjJ0JJNHKVy2cMkancvmH3OlWdAr6MZv5z4jDHKmlZ+T4Yh2ktsI3pj0XXAWniyWwCxsfdyznFhVznZvsIcitQS3f+V0h+Qangsz1l/lsEmsBxyx5SFg+g3FrrP5XkzzWoZ7rpwjd6PTemSUXnFqIMLSCrKmpWpB1RnVt+uom3LFuicls=
X-Gm-Message-State: AOJu0YykTV2aC33MFbpd4cm+Z2zYfoPinDq1K9Q+/Jr4UrB/wK6tEan2
	h6WOLVYCVDA5TYyewyBVBJY2xrm1PEwATJLkAqRNu+wAC24WM4fM
X-Google-Smtp-Source: AGHT+IHY9+zh8lZE7k3z/nqra7TA3HH8AsJ5/ve/ktV2rxzWinDpyQg8luGGcQ1ckKlMeJnaaBKNsQ==
X-Received: by 2002:ac2:44c9:0:b0:513:2c56:f5e2 with SMTP id d9-20020ac244c9000000b005132c56f5e2mr3622069lfm.60.1712844013345;
        Thu, 11 Apr 2024 07:00:13 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id wp20-20020a170907061400b00a5226f9542dsm429609ejb.27.2024.04.11.07.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	taras.chornyi@plvision.eu,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	geomatsi@gmail.com,
	kvalo@kernel.org
Cc: quic_jjohnson@quicinc.com,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	idosch@idosch.org,
	leitao@debian.org,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v6 01/10] net: core: Fix documentation
Date: Thu, 11 Apr 2024 06:59:25 -0700
Message-ID: <20240411135952.1096696-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411135952.1096696-1-leitao@debian.org>
References: <20240411135952.1096696-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bad grammar in description of init_dummy_netdev() function.  This
topic showed up in the review of the "allocate dummy device dynamically"
patch set.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d8..987039ffa63c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10418,7 +10418,7 @@ EXPORT_SYMBOL(register_netdevice);
  *	init_dummy_netdev	- init a dummy network device for NAPI
  *	@dev: device to init
  *
- *	This takes a network device structure and initialize the minimum
+ *	This takes a network device structure and initializes the minimum
  *	amount of fields so it can be used to schedule NAPI polls without
  *	registering a full blown interface. This is to be used by drivers
  *	that need to tie several hardware interfaces to a single NAPI
@@ -10427,7 +10427,7 @@ EXPORT_SYMBOL(register_netdevice);
 void init_dummy_netdev(struct net_device *dev)
 {
 	/* Clear everything. Note we don't initialize spinlocks
-	 * are they aren't supposed to be taken by any of the
+	 * as they aren't supposed to be taken by any of the
 	 * NAPI code and this dummy netdev is supposed to be
 	 * only ever used for NAPI polls
 	 */
-- 
2.43.0


