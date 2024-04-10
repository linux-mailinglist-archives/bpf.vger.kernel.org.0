Return-Path: <bpf+bounces-26415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C017089F3E7
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19E61C24C77
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C615FA6E;
	Wed, 10 Apr 2024 13:18:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72AC15F326;
	Wed, 10 Apr 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755081; cv=none; b=cxxMOTQOf/R0Fkb1Vvd4ODZozZ5dIZZulmE0zenykarWN5gYXsW0l8H210RtyoWmxefSHUR65DOKRGV+kV6yVyjxgRpJjkOaXxzCsTKuLEhXNq1JJV0JnvGcf7+z4eLhOBCSNyHhnrZQyCfM/bB0KpBm/qK3isiin96Sfz2/l9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755081; c=relaxed/simple;
	bh=IjSM+bnQOTa8MUkSmM1LUl9F5EDiZx+DiNz4nR4/uGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAAraEWnxn+pOEFdqOoC30bFBE5l1ZPd2+HMPFa44hKuH/jxbws44rsqwnxocxPNo2X4QPGsQanfnqjGH4YzqmzZ+eEAlAQVGp4dNFQ3lT5MZc6TuwHkUIzb9JYcmtY70Q7tZkmfuHIqi8XHSgsIF0i3OItkJ/JnTGn+KCb652g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so5218645a12.0;
        Wed, 10 Apr 2024 06:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755078; x=1713359878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=occnMuVDkr0AXBDmVEHk6wT/diJ6dvMaufRR7UkwoZc=;
        b=IXYyc9iD5aRrmdVaCuuvq7slx5lGdSLxzVzUMZZtZhaIO9dZ04IKT7XegS5zs+cNb/
         rXobiHZoJT2hXe8Lv5y2sWOY2m7VBrWujFB0yU0dAIOmFHj26qAvyAy4tf2exa6AxFi0
         ZZmrY08qYPPFtWyvvSzjAMrlVPBtQM2v3tjpAxvhjiGawYFVaMGDlvAV97spONA/55F4
         vJ9Nh2Dvx2JPm9H5LFoV0rO+QwUJ9ml1kKP68s1Z8ce/QM4PlFSn/GIHfK6Ti1l0pkms
         4Bn9qKNz418LwY4xWqec7BioslgACcNI0MHgzlvnPQ3gNtZ8knEf7oIuxFgOuXasZicq
         UD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz0FBVRlUkj0bitS1GIGjdsBGJUVa9qxwt6lIX9Ihr10hliDJgL1jZeOwjV2vnour/MRmQDVwlgFU/CY+pMGZskFL4xdQ6+Vv73p+4uhqGWaVFm6crsQ5XcgPLnXGaDX5jVNmRF/VQ3apBY7CWCeF+uV8dbMSj4alveOFdWoVk432ZyErrf6QcAeOXcV61JPRTYGrqeoj6IRM=
X-Gm-Message-State: AOJu0YzV1C0DxGKQrmdRs6npGC282tA9/lj8UCaOC72daxHDwpFnY/Qh
	escVPFe/WnkTgE8C8hHmYliV+lFF8nNX7xGXurOkizW+3EQ+dmUZ
X-Google-Smtp-Source: AGHT+IFYz6nezPO0nvcRaOh3691IM+U3aDTWAVz3mLdQiEXd+y4Shu3fXDmKe+RO4EdGoiCoIVd5pg==
X-Received: by 2002:a50:8e50:0:b0:56d:f3a7:60e with SMTP id 16-20020a508e50000000b0056df3a7060emr1782120edx.22.1712755077926;
        Wed, 10 Apr 2024 06:17:57 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ij6-20020a056402158600b0056ddd9427d2sm6504617edb.58.2024.04.10.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:17:57 -0700 (PDT)
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
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v5 02/10] net: free_netdev: exit earlier if dummy
Date: Wed, 10 Apr 2024 06:13:43 -0700
Message-ID: <20240410131407.3897251-3-leitao@debian.org>
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


