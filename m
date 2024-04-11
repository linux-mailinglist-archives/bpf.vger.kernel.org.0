Return-Path: <bpf+bounces-26526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB668A1663
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 16:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350281C20B85
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 14:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721514E2D0;
	Thu, 11 Apr 2024 14:00:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FBE28FD;
	Thu, 11 Apr 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844013; cv=none; b=iOJhHsXyKVCD893G9XiyeLOXlk+yvjkruNdSiGS3wzpizhnOEVW5HjnY6UxcxrhowpGAXrMu0LmUhlkEHo9xvNb+6mQtwI5Kr0t+XzUbGzEw0WeSsZFVnmFvuGO8Ii+2BjSC6ksLoFw/IT1zxIBw1dH0x7s9EQOXTp62Ezmzhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844013; c=relaxed/simple;
	bh=mlzAIMyGZGOb5ZbZANHXO9/s07fJBEJ676nTka0ZQVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mu8V5Gl26TfgzpUZgdU+qDWRoXvwawzZqYQ47WsmWS2f/6h2Llt+VY0eB8KjepUsxSx4GrFANeZl8sequMdt/gT2GUnvnCvF2i3thcG2Rb3EY29rAGYTk/XSvHhMojyu9qn+2cwLOka0DTCNqYL8nu+YZiW42KAVT+WbWuMnf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d476d7972aso101140141fa.1;
        Thu, 11 Apr 2024 07:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844009; x=1713448809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQTQsAWD0H4IVeRBYnbPwnRSrsgIyM+Tcz4KRrX5YcU=;
        b=iBpZ0/JNsowvaqds3SgvvO1hbl7u0waEG8PESESocIcuBjIq9eqRbzH+OM4cx80DCf
         hqzViBh8gOJBAhhSYEUPewfZedP+tXG2qvqlQqhpn505USJCfnqHeA0IcLY6tbf1otoz
         6H2JHxldyFoABaZPEeIdDKvFtjunnzB4Fw27jnp7XqQGqngiYDEOiqUh2OiMh3tptlOl
         7MbKah5uSXVd8ipiHTBWmJMvwmbmL97GFX+N2v/ezsKKiMpk/UGicHq0pGMEq1c3XTIV
         NTXKny9qJYx0Ac0ENOOfW2s7apBgOw/Ux/kXoyx+ysf2itNIT72oTMKZ7zxe4QrI5b/h
         P8fA==
X-Forwarded-Encrypted: i=1; AJvYcCWcNjmbE/F3dUK31ZpO7zNqwodm1lu4fqCY7me0HpURyRt3XgqM63yNwQQ/W1c7zn9EL89aiZaauwtpOxSVLsjxtMJrlvBXMgB18+860rA2Vn4uBsto9OQfmYTJSt9Nn9vWOrZiZnzKUYLNullO4Oc9SNg2xM6Xmw06mx14Oo+tpjX+uoW2BmB56rHHAeQAOp9yVNdl5iMWutI=
X-Gm-Message-State: AOJu0YxPsHHL5dErUqfcTkhD+zIaOC+x475iCeO/S3okRJOW6S6dK0VJ
	nH+fubd8P+Dad44BhLc5+2KwjJBirSPhGCCWXf1vs10yUZc8b3Se
X-Google-Smtp-Source: AGHT+IESLjyWcXTsaKcjwrLRsOCPb3ACwPBKm09zfGwKsisTsBxp7Z8j7Ziae4Bz2qMfBnvCUtsP1A==
X-Received: by 2002:a2e:2245:0:b0:2d8:781c:7ba1 with SMTP id i66-20020a2e2245000000b002d8781c7ba1mr3849191lji.7.1712844009042;
        Thu, 11 Apr 2024 07:00:09 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id ef8-20020a05640228c800b0056fed6d5664sm357820edb.54.2024.04.11.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:00:08 -0700 (PDT)
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
Subject: [PATCH net-next v6 00/10] allocate dummy device dynamically
Date: Thu, 11 Apr 2024 06:59:24 -0700
Message-ID: <20240411135952.1096696-1-leitao@debian.org>
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

v6:
	* No code change. Just added Reviewed-by: tags and fix a commit
	  message.
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
 net/core/dev.c                                | 57 ++++++++++++-------
 19 files changed, 127 insertions(+), 53 deletions(-)

-- 
2.43.0


