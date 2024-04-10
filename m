Return-Path: <bpf+bounces-26414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F5D89F3E3
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005FF1C2664C
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B806715F309;
	Wed, 10 Apr 2024 13:17:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14015EFB3;
	Wed, 10 Apr 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755077; cv=none; b=q86/dEKbp5u3iG7jq6TVRYYJT1qCJZaHbhmaTt2KHTfRHsqlFQQIGLD39OJmr+N6T6DVLm0oACbA0QyO6ob/qoemeKiClhnLI51MWMj+wAKTfx6gWo4xfNppNtfspxVw9G1L6wOjKjbjaKudHLX042DlXQpDTioWl5I43397EJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755077; c=relaxed/simple;
	bh=Z9XshNGeaDkZA4YdqrH2pphdBGw4s2CGo/Ima80EU2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG/jy08gKFH3/jWndZTTDlIDAv51Eg6T8ako5QGQVXXLHK18CfQQQsyeajKN0RQ9KOTSQP3bmNu5JKyTstJGdBtmM0a+p9/bKJWdRkTiWBqq3ZbFbzfIGGQNpjhH0m2cR9bdLM/xylw5qJw7rBx3tKJZx8O81h2joQlifom78UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so8242941a12.1;
        Wed, 10 Apr 2024 06:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755074; x=1713359874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCSWo+cbTjbJqU2UMVUeUJFNUS6Yf5iPYegXsbIUp/M=;
        b=E8vKbu6Keyv/TpBvb/tB0MO1y+Wb41cVv5magZIhIBDTmumdpQn5FWTb8UOOYJAIyw
         J5tYAgji1OEM90t7rf2lJf4NGJMIplpDHqDLovTsbQxdwONywZR+AbJ4woOFyh1rIQJC
         jLnSOqiOW52rrAtsJanywZAauMW/qKliIXRssU6JE689umFGd+GnZIkYm6k4izCfmkDi
         SS/3bYinq+qwrDqKlp5u0RBFZV2DSx6CqEoPYvZRRdziK4EFSgoEfKYzLVOClnkhaLaJ
         ORevlV/UR2qTmO1tVMezhTr4uEDpX89sLHaxJULUEOgGuddMjLryBEPeENKkb161Z9eq
         U1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSRs5V5OCAxiD+Of6bcuUFilR/5BdidkmMVTyIjzNKnY0v6P3tCiEKDiyxQngavJvkHdMJ79391LAnU3buN0EjqxhzWFCq3ZCtdjghK9JCOCxqZ0utcX3zqnTB2K+Qe9BGxtwJE5azM0V15TX6HFqX2cJC+JQcP7CAd8O04z6W1bGXWfKe1FwRuDJO48eP1VITOtyX1CnWcDM=
X-Gm-Message-State: AOJu0YzqeR5DgPvePQ+9A0dnvxoIhQp8VWe+HkEPFKR/l4Zi1NHFSecg
	8mEygi9tCOU6keYT2cxWdlDW7S949MO6ktszX8OMK/xcR69Lsjdg
X-Google-Smtp-Source: AGHT+IFzohQ8nifeoYK9ng+dXMVkUWT33vP4drtn7UGXanZmNkg0eJxYz4rgtTa24o9nG26otr90ng==
X-Received: by 2002:a50:baa4:0:b0:568:9d31:2a75 with SMTP id x33-20020a50baa4000000b005689d312a75mr2097283ede.4.1712755073613;
        Wed, 10 Apr 2024 06:17:53 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id y9-20020a056402440900b0056e3707323bsm5689027eda.97.2024.04.10.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:17:52 -0700 (PDT)
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
Subject: [PATCH net-next v5 01/10] net: core: Fix documentation
Date: Wed, 10 Apr 2024 06:13:42 -0700
Message-ID: <20240410131407.3897251-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410131407.3897251-1-leitao@debian.org>
References: <20240410131407.3897251-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bad grammer in description of init_dummy_netdev() functio.  This
topic showed up in the review of the "allocate dummy device dynamically"
patchset.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
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


