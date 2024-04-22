Return-Path: <bpf+bounces-27411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C88ACCE8
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C2B2818EC
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A814F10D;
	Mon, 22 Apr 2024 12:39:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14324146D5F;
	Mon, 22 Apr 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789586; cv=none; b=gg447vUfVXq64AkB2grjMxWKBPLXOkUNo9r4XCB63h35aLBXPJO2nMVKI4U4shQZm33IMwLWoVH5BqgyRmziSaFMgNXquykMYpvvv4o6a9/FNBV0Izb4o+lHeEkU7CVg/C9/XLH+aMh/uAzBscRXRjNL0ZmVESjXRPDHoD/SWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789586; c=relaxed/simple;
	bh=Fmr+7UDSIjLKMs43QuC2kTOPm/JegyQmo0KrwLPs74Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6SC64aXmH15iDfjr9rG3w68Zmp9swxx07aZwH5AjL1gdVqV0dy3r7T6l+EBciQIrEOwZj7ihE8lYGgK2PBYjgazFJ4zA4GocI30v4c4xFf5sxbD9TOmGrql+4jVKfwEQpFaiLTm0TK/CTg9EHGic//Gin7auPaiRcu32glCqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso55315011fa.0;
        Mon, 22 Apr 2024 05:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789583; x=1714394383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtbQVvvytm2FvKdHddRJ6/OPEdy67XedVgC8G6QI7mE=;
        b=qfV50iJgYAOOddpJp9ofQc7W8c9PVJfSYRJaACwXOPaJ1ECz6We45cGK5HAWikQ97V
         zseazoCzn8ugO6W20N1avnnDuZ3lNdhQiutZ9dn/Fx7sgQBP9ch6NLSrj6XSclbvmhvQ
         H5iGM63f59nLu4iPNT8TrkT6nMrxrP+XoowjSmIizoRlbB+78Gc9WDpscVOGRmcm8iO9
         leUBg4/pfohYNIxMBc2/sgUH/CyWiCeauaxQYZt8BKGwpmU54bPh5iRWtEH77OP5l4nR
         zQlAf0IpXwVFlH8JIxSouAR7W4AYxKCeOfo+ppj7B7wYSpyxaFtfhBBpXhsqpiITrClz
         bt/w==
X-Forwarded-Encrypted: i=1; AJvYcCUHNZXtfXFYp6XVvOLNcpNBCBk4zoknw6EZ4Z01VPtPTcRnOgl+UlGSg7zWf7GToCUzez51Tk0svBu8GYUzrXvuoQ/y6exMHI7by6k5DXgsTmGXjgmY/94OUju4w+tj0EU9rA7dJVRITecepYmukzEuKH5TJ3GdjIWFydVdojcHPGijmdC3WAedc19A8jteW3nIGSeoeOUxkS4=
X-Gm-Message-State: AOJu0YwJ47V7gT96aQziBMSe5EoreHuZAl/2gsvhNNP8ivwhFxp3cuzE
	+eQPwDUUSaPmCGd3vOSxRaHZTR7rkHco5ZgI5+Zp/vDB/VcwPAEP
X-Google-Smtp-Source: AGHT+IFjwu09Igjhit00FwgEXKxmKwFyLCPy0CniLE6C/q3K4O4DuOoAL8L+d3hMfAKTAbKTgdLqGw==
X-Received: by 2002:ac2:4ed0:0:b0:515:cbf1:9fda with SMTP id p16-20020ac24ed0000000b00515cbf19fdamr7518637lfr.61.1713789582986;
        Mon, 22 Apr 2024 05:39:42 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id bu13-20020a170906a14d00b00a5816a7381bsm214578ejb.141.2024.04.22.05.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:39:42 -0700 (PDT)
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
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v7 01/10] net: core: Fix documentation
Date: Mon, 22 Apr 2024 05:38:54 -0700
Message-ID: <20240422123921.854943-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422123921.854943-1-leitao@debian.org>
References: <20240422123921.854943-1-leitao@debian.org>
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
index 8bdc59074b29..44c2d698fd1b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10424,7 +10424,7 @@ EXPORT_SYMBOL(register_netdevice);
  *	init_dummy_netdev	- init a dummy network device for NAPI
  *	@dev: device to init
  *
- *	This takes a network device structure and initialize the minimum
+ *	This takes a network device structure and initializes the minimum
  *	amount of fields so it can be used to schedule NAPI polls without
  *	registering a full blown interface. This is to be used by drivers
  *	that need to tie several hardware interfaces to a single NAPI
@@ -10433,7 +10433,7 @@ EXPORT_SYMBOL(register_netdevice);
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


