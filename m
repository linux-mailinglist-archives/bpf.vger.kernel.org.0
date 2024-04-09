Return-Path: <bpf+bounces-26280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269AB89D98D
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2232F1C23067
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED212F385;
	Tue,  9 Apr 2024 12:58:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B812F36C;
	Tue,  9 Apr 2024 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667508; cv=none; b=XWHaNsA+AVRtt1HyRQapVAJha1iXf8zaa+8+K1TJLOOz7s0uzcZucKD3J3xNAZjCK/xxxpb9CsRdBCvJjNl1Y2JhW7eqM505XbLf+9YY9/L8Twn3EuFW5SWvzBU4C48wE44UciJiC6Apck0gWPiDhdqnFhIR+fDmoAOlJ73bI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667508; c=relaxed/simple;
	bh=OihPLHrM806dO/GNu4hVLz0wiUjmjJPeW8cZYNl/Dr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5dFErkwkLRJjDrMnA8kcRVgrjG0AwUC5pWNs35x8Loxmb5jPCyenJUPA81QnOHBiYuw3XYL5XG9dEVh/mpRYMfotJ1NVorQtRjLNQ7W81dPNo4ze6Vc0NNhb+Of6ixhbXiZpEFYlgyDg7mfp0AExYiy9d5rphHgsHexdkvfYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso2481532a12.1;
        Tue, 09 Apr 2024 05:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667505; x=1713272305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUhpfEWYqP2FV8/YIvHMQS1+mW5LiNeJMicGbuHOQqA=;
        b=l0zFLWf32LSp9XySOQYMug8R9sOSYnPtj9ME9sk37Mx1rXq2hV5nUzRu5skxQfIv0y
         yl/aQtfvwB+SoHg/+f80/gcFp2lMS/XzUJji4IBlVRwWzWHvesWfsRXxFYh2xKQt5hmM
         FPh0U+izXpV6BUy6/IZ4lc0O1GP1SAB3PmOXAKbji0dHbgN2DNwnTxGxBhQhbh+22uTj
         vhnFDmXVn1ELUYnSOU01cUuk2iAxB0LPu2VnHx6UDn7O25pKY5dxGFx7eQ2HCIumd5Rz
         3HO8dXvEtfQp6jDDpR3H2Mpy5V+hiM6OM8RpsR/BcHk49YSgDcsKvNb+t84rWjiF7l4+
         1jJw==
X-Forwarded-Encrypted: i=1; AJvYcCUlEdeX8t2i/bAQqTzo93I+x+oogto6Mlkk6pfSgGhhSTmy75A1V2ABXED8CwKO1Qwsj6EE/vkbbeldXQEVDqJHhWx5UaGgPS6jZ1e1ry8XmGBte0Qx6zDANowDbLIjwW/U90KsFBsZPCML6cspp3c6CaCzmN9W5abIUcB9AF9dt2yLh3Ejdw7/T7JKChF/qTTWTPJmCrlKGJE=
X-Gm-Message-State: AOJu0Yy5VAkQ0z5OeI8j3uzze+toshuoX8VSjKUnE7mH3zyfFIULBvTB
	pwE6eAyKfHrmaQdpl34t5rBF8wbtPem2M0sozvbOOvdI5C+FWOw0
X-Google-Smtp-Source: AGHT+IFu2X6ZpedgoYhXGO+Q+OoGaIGzUSaEFpMawPlTuhVCHDAOIiyjG74dC49hqb1KU2Vp/0neGg==
X-Received: by 2002:a50:a69d:0:b0:56e:2e17:a3d1 with SMTP id e29-20020a50a69d000000b0056e2e17a3d1mr8145016edc.25.1712667504651;
        Tue, 09 Apr 2024 05:58:24 -0700 (PDT)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id en6-20020a056402528600b0056e3e0394absm4377170edb.68.2024.04.09.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:58:24 -0700 (PDT)
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
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v4 1/9] net: free_netdev: exit earlier if dummy
Date: Tue,  9 Apr 2024 05:57:15 -0700
Message-ID: <20240409125738.1824983-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409125738.1824983-1-leitao@debian.org>
References: <20240409125738.1824983-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For dummy devices, exit earlier at free_netdev() instead of executing
the whole function. This is necessary, because dummy devices are
special, and shouldn't have the second part of the function executed.

Otherwise reg_state, which is NETREG_DUMMY for dummy devices, will be
overwritten and there will be no way to identify that this is a dummy
device. Also, this device do not need the final put_device(), since
dummy devices are not registered (through register_netdevice()), where
the device reference is increased (at netdev_register_kobject() ->
device_add()).

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 92f5bddbc2de..bf0a335781aa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11051,7 +11051,8 @@ void free_netdev(struct net_device *dev)
 	dev->xdp_bulkq = NULL;
 
 	/*  Compatibility with error handling in drivers */
-	if (dev->reg_state == NETREG_UNINITIALIZED) {
+	if (dev->reg_state == NETREG_UNINITIALIZED ||
+	    dev->reg_state == NETREG_DUMMY) {
 		netdev_freemem(dev);
 		return;
 	}
-- 
2.43.0


