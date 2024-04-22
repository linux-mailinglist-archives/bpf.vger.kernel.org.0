Return-Path: <bpf+bounces-27412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19308ACCEC
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611461F21F9C
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2014F9DA;
	Mon, 22 Apr 2024 12:39:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31214F9CE;
	Mon, 22 Apr 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789590; cv=none; b=PZMy2tjW/y2ZjOKpFb2W+IuQVxtaXhLpruHBWf+G8LAR6syd1yRTCnKVQAz7ZaCSjqcAuS2eGUWtciAOmbZxNQpnZRM6vUII5iOI7gPt/xKvpx9o9tn0zfzj+25ioCxe3uj+mzocO4G2XiZQgfiNt+0WFVJNFBvk2kczyUDfoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789590; c=relaxed/simple;
	bh=ohtJ7y8zw787zEakQ6YFydMwx+wGInwZuDF1X+mdHss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o19sxg4dIs/VWvzQtwkEnV8AqVf41uMQMyzhXnASgNfN7uajJXP66c4Fqia0XCevckF/z5icBVgPDTJvR/T9g2tCM0UcbmrDFtgijTe2wXEh1rAnHYn0uHbaGUpwRR7mj6/yAZTc3bTlebrht7Vo+PGBgcri4krk/1Dl8/JFIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a56d7d457a1so57566266b.1;
        Mon, 22 Apr 2024 05:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789587; x=1714394387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbJZnQssCi/hJC/xoZUOS5idPxjZFYtuFqS1Ajkusf4=;
        b=dHvZcKgMjxXfdZiudT99v9iHufjpy7qZi0d/smjq1q4v6w98G6QggcM+tEpDvCzuR0
         Gjs5+YjCADxSrum74mbv28Pjhacn0fN3QxctswedHpdwQ6g4kvo7E6Axh8ab5NKSx/KB
         ldzDr9N1l4kLGXQpJZeDXodz9sjixmIJagKo8G8HMBHb3Mrp5431DjQJ0Siff2IGPGns
         BmsXQoZBQJmBgZ5w6rNx64+8ih8NQGKQuvozXB8WmUo0f5YsA0AtVfjbQQMujafz5Je4
         z60pOWvLevJkZ3zZmaHciRj5kie94sb0fV8vFLjt/ByXRrCrK2DoxUZK+vPV8GzlVTVU
         ELmA==
X-Forwarded-Encrypted: i=1; AJvYcCVaUn6cVsM0LMV6P7BC+Pefw1YWLTzoo3sqzWhAACYvou8JGvrgF4silNzlsUIwBAQPhidmTc7cppOwS4ZWAaEADoaTQEqDE7Q4ycrEqMVqzJpGr+Rfl8Ja+ePejgLIQAQjjYNPVMgYduqx/LYUUIk7OBmBRUtGp2+JynXidvOdf3uDHUFWQmS+XS0G+/HR+aWgnroFENLpxyo=
X-Gm-Message-State: AOJu0YypIbWMtuh9gbvfFZxyT1sY7muEsvUvCfXIt+Nl0IsKzZcfsMnb
	KXSObceM6+bsCRmqIFUB82p4EWScs7S/x1iwf1k4bZ+LC3yodTdV
X-Google-Smtp-Source: AGHT+IFgz1cSAQ4ZHhLBiz7E/9ZRPzAm7gHu5+JNi39+LH9FDyOn8sfX5i//ePdYd5DWE+bbIInw4Q==
X-Received: by 2002:a17:906:5292:b0:a55:90f0:bdf2 with SMTP id c18-20020a170906529200b00a5590f0bdf2mr5064912ejm.32.1713789586720;
        Mon, 22 Apr 2024 05:39:46 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id sa40-20020a1709076d2800b00a5255afc856sm5708684ejc.84.2024.04.22.05.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:39:46 -0700 (PDT)
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
Subject: [PATCH net-next v7 02/10] net: free_netdev: exit earlier if dummy
Date: Mon, 22 Apr 2024 05:38:55 -0700
Message-ID: <20240422123921.854943-3-leitao@debian.org>
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

For dummy devices, exit earlier at free_netdev() instead of executing
the whole function. This is necessary, because dummy devices are
special, and shouldn't have the second part of the function executed.

Otherwise reg_state, which is NETREG_DUMMY, will be overwritten and
there will be no way to identify that this is a dummy device. Also, this
device do not need the final put_device(), since dummy devices are not
registered (through register_netdevice()), where the device reference is
increased (at netdev_register_kobject()/device_add()).

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 44c2d698fd1b..62b39d6b1d8f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11066,7 +11066,8 @@ void free_netdev(struct net_device *dev)
 	phy_link_topo_destroy(dev->link_topo);
 
 	/*  Compatibility with error handling in drivers */
-	if (dev->reg_state == NETREG_UNINITIALIZED) {
+	if (dev->reg_state == NETREG_UNINITIALIZED ||
+	    dev->reg_state == NETREG_DUMMY) {
 		netdev_freemem(dev);
 		return;
 	}
-- 
2.43.0


