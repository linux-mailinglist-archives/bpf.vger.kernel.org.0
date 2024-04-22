Return-Path: <bpf+bounces-27410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFA8ACCDE
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320B9B21D90
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FC1482F8;
	Mon, 22 Apr 2024 12:39:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E30146A93;
	Mon, 22 Apr 2024 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789579; cv=none; b=SOfGwSjTplOrgBBe/be17lMN39059U8J5KG3JK39VXFMGwcZeQ4U3nuvsrO2eaP2Reb5ggt/gngs3zXEb1Lm4JRyZBHRsYx8UlQjupetVIFNn07IfxPdh65WLQ2/zeEsWzmqWkPTbi6fjLdtJ9SWmJAtjIzlzwWA5Co+h0XwMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789579; c=relaxed/simple;
	bh=yxR46rGU3Aqnq5NTBddw5GE+9vGxcjEQcLz0queXR3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FjUewH5PzV0fserXKHpiyjni8DLNrwXH4gTo/LwxofeZNcgln02ijpnBIoFlNWwImuQqCqVGpmDcp4W3gmdtosXiEIvhM9Weg7wjOnYuy+qfgW9viWiBl4OGGR4mwD9etKS9gEVeMVja7i5PjSP5HSysfZmaSfR+5/HRNUC8eE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-518a56cdc03so5281683e87.1;
        Mon, 22 Apr 2024 05:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789576; x=1714394376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iz0ikdoTMPeoGlY7AzEyABEuqkNB0Gjgw6bWzoieFE4=;
        b=FHH9Cz9NESk4CUdnzGBzUPoGF/71XXkUlZcSlqnw1ThuPdAVTkcg2LtUPZcZHkQrhG
         qCcISFYRZRsEqHZQSvgHC/iZbj7AP3ZqMIVwn7ykXFGiLXOcijL9axonheGNQwcxX5VP
         aPwYP+eL91QZpG7KhTNy7kO7LmEA3FC7icknlr8E8Y1Iuv17dS7odp6aw2u9t7Nwequ+
         +TDXv6yRqacCZ0N/I3sIxOX+U3KtK7/9pvJczt7TRFvuTaBOguua4w/SQVrjEYSwrwFP
         qBFdDzIbWr0HFmHg5wRTlJG22dYiJxnz6QZcqbtx4aobRqcD14jBKB3HfX4HkUeTbyii
         KykQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fitlaIUpjwnoUUZ5I5RTi8ccjLVCqti3pDJZ0NorDV50X/d7BohPWGTFAzVVLva/eE9BKmVHjSu417DjWVS+Ep+pmStWBxWQdTN3j86Mrl1JQWKyTrjoNma44pNCLUQKgWEYuKWWdNpncHT0Ri4R4y5ncKaHnrm+3VTNKx5CkHbNXhhr4Ctq02qjLaSnC3UzyrmXzE/kOEc=
X-Gm-Message-State: AOJu0YwEln7ff7cUg7LRTYedsHx8SkqV1qU2ihnHX771xd4hhfyRPo++
	h+aFJwLP4cxfsMP9wUH+1jlBbMT98O2an5ygrVHl5H6HQcA+l+GR
X-Google-Smtp-Source: AGHT+IF5YTCCg6KEsN0PmqluDOTi/5NrwJEUq5lvraAub+lxIQJqUtef+oDOn/RubcUZafX5KbdePw==
X-Received: by 2002:a19:ca4f:0:b0:515:c195:d6b8 with SMTP id h15-20020a19ca4f000000b00515c195d6b8mr5518092lfj.60.1713789575968;
        Mon, 22 Apr 2024 05:39:35 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id og14-20020a1709071dce00b00a55ac4c4550sm1906884ejc.211.2024.04.22.05.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:39:35 -0700 (PDT)
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
	kvalo@kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: quic_jjohnson@quicinc.com,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	idosch@idosch.org,
	leitao@debian.org
Subject: [PATCH net-next v7 00/10] allocate dummy device dynamically
Date: Mon, 22 Apr 2024 05:38:53 -0700
Message-ID: <20240422123921.854943-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct net_device shouldn't be embedded into any structure, instead,
the owner should use the private space to embed their state into
net_device.

But, in some cases the net_device is embedded inside the private
structure, which blocks the usage of zero-length arrays inside
net_device.

Create a helper to allocate a dummy device at dynamically runtime, and
move the Ethernet devices to use it, instead of embedding the dummy
device inside the private structure.

This fixes all the network cases plus some wireless drivers.

PS: Due to lack of hardware, unfortunately most these patches are
compiled tested only, except ath11k that was kindly tested by Kalle Valo.

---
Changelog:

v7:
	* Document the return value of alloc_netdev_dummy()
v6:
	* No code change. Just added Reviewed-by: and fix a commit message
v5:
	* Added a new patch to fix some typos in the previous code
	* Rebased to net-net/main
v4:
	* Added a new patch to add dummy device at free_netdev(), as suggested
	  by Jakub.
	* Added support for some wireless driver.
	* Added some Acked-by and Reviewed-by.
v3:
	* Use free_netdev() instead of kfree() as suggested by Jakub.
	* Change the free_netdev() place in ipa driver, as suggested by
	  Alex Elder.
	* Set err in the error path in the Marvell driver, as suggested
	  by Simon Horman.
v2:
	* Patch 1: Use a pre-defined name ("dummy#") for the dummy
	  net_devices.
	* Patch 2-5: Added users for the new helper.
v1:
	* https://lore.kernel.org/all/20240327200809.512867-1-leitao@debian.org/

Breno Leitao (10):
  net: core: Fix documentation
  net: free_netdev: exit earlier if dummy
  net: create a dummy net_device allocator
  net: marvell: prestera: allocate dummy net_device dynamically
  net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
  net: ipa: allocate dummy net_device dynamically
  net: ibm/emac: allocate dummy net_device dynamically
  wifi: qtnfmac: Use netdev dummy allocator helper
  wifi: ath10k: allocate dummy net_device dynamically
  wifi: ath11k: allocate dummy net_device dynamically

 drivers/net/ethernet/ibm/emac/mal.c           | 14 ++++-
 drivers/net/ethernet/ibm/emac/mal.h           |  2 +-
 .../ethernet/marvell/prestera/prestera_rxtx.c | 15 ++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 17 ++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |  2 +-
 drivers/net/ipa/gsi.c                         | 12 ++--
 drivers/net/ipa/gsi.h                         |  2 +-
 drivers/net/wireless/ath/ath10k/core.c        |  9 ++-
 drivers/net/wireless/ath/ath10k/core.h        |  2 +-
 drivers/net/wireless/ath/ath10k/pci.c         |  2 +-
 drivers/net/wireless/ath/ath10k/sdio.c        |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  4 +-
 drivers/net/wireless/ath/ath10k/usb.c         |  2 +-
 drivers/net/wireless/ath/ath11k/ahb.c         |  9 ++-
 drivers/net/wireless/ath/ath11k/core.h        |  2 +-
 drivers/net/wireless/ath/ath11k/pcic.c        | 21 +++++--
 .../wireless/quantenna/qtnfmac/pcie/pcie.c    |  3 +-
 include/linux/netdevice.h                     |  3 +
 net/core/dev.c                                | 59 +++++++++++++------
 19 files changed, 129 insertions(+), 53 deletions(-)

-- 
2.43.0


