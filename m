Return-Path: <bpf+bounces-26528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5658A166E
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107011F23705
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502714F9C7;
	Thu, 11 Apr 2024 14:00:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5028FD;
	Thu, 11 Apr 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844020; cv=none; b=rc540m9GTd/ioQgsFgwnkZlGS7XkG6z5rTpy6UQUmnnB4jwkMyKL7hpDQZRFyOWmPI0vlj78zG1dLYMOycwnLAjhGpKj4dMoVHi5zqD/a+9hg8/rSScZxKY5DMfrCE0ZP0VeQ5O4WsLUa565WXVS6Syj5TqJyUfwAAcgXnnOFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844020; c=relaxed/simple;
	bh=ROuCieYBIUuh42rm/xdBciRyV0NH3gcZwwKs9aVuGVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNO6pd+7W2Vqdc6W7Y6WT5w+R9+JKGKidmxntSpnL1eXjITf+dE7br6vHo6aJpcDITIiPojVtwFTIJEoh8jDKExei3H9Y6SoWucwKjupFzR+eO4p8jB5+CDMY8ZK7EoDo+pP7E1AN4AeiwwG5cERMcHySfVuStBgkXdvNMKe0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so7683913e87.2;
        Thu, 11 Apr 2024 07:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844017; x=1713448817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48LVrXVS7hCk3whDT2bfgm8Paw2cUTHxHkmOyfqwerk=;
        b=WKVpt4CnPUBDxeM0XN2z+E6hrSsjNZ4XHS0J4tnbUhRoaOm/fhsrBNAMCLIWxqASCA
         qCWhIQkQI9qstkHAgQn+mT9F1DlZdzAkhiphSSGc4febX4HvYIuaNX6KpTj3NvwWLJXG
         vT5uWF7DpuYJQU0hC5ZQMMmasz5a4qrxW2E6NACZvr3BjtP54QCuGLUjTriYhJoeTt1a
         PIRbO8DZ1l16ErtF84mw7NZMdMzSGN438r2YI5MXCaxy8vQIckW5ltb8fg2Bp64ItWOM
         cBQYCjxnPn79IRyvNeGU60MSZ2qjyb7icjIH2fKzwVWwiqy3Pfab898W4FZxPGNcIzmA
         fm8A==
X-Forwarded-Encrypted: i=1; AJvYcCUzHKmpO5o40Vii8qfXGGshL5pv1hd1RjWn+XiHOdg02oYdXZWgfeOPP8V5DjU5T7R82WStWXj/XnTukyDsAWq9Veqq/ImcBK6b7weU35rp3e+BUpEQgORkEcoBdDMQU5rZe4K021DuE4CvGH8tYvFfvj49E0Zz6bMRe2fRNe5NV5DVE7rMLkobElr3l+LUQ38SZ2soF0sUKGc=
X-Gm-Message-State: AOJu0YwvmFSIiUcQVNY+cs0CgeR02UQE+cApbjEej0igVeWrbymalkyf
	u/oJX38JGcFrx6uMdgf0A/6th2HkM7sw2DynS+Owsk6Ix5GP3iCL
X-Google-Smtp-Source: AGHT+IGrPLMoxbFZfdOPsWa0B79xpULXw8vQTkF3ZWlBdhuRM6Z4gSoOA0lmdY0K24jYvaydEzayKg==
X-Received: by 2002:ac2:5df9:0:b0:515:d4fb:907f with SMTP id z25-20020ac25df9000000b00515d4fb907fmr3578453lfq.27.1712844017308;
        Thu, 11 Apr 2024 07:00:17 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id zg22-20020a170907249600b00a51b18a77b2sm771309ejb.180.2024.04.11.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:16 -0700 (PDT)
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
Subject: [PATCH net-next v6 02/10] net: free_netdev: exit earlier if dummy
Date: Thu, 11 Apr 2024 06:59:26 -0700
Message-ID: <20240411135952.1096696-3-leitao@debian.org>
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
index 987039ffa63c..c74b42bc6888 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11060,7 +11060,8 @@ void free_netdev(struct net_device *dev)
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


