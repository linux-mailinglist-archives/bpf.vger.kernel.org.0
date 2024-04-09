Return-Path: <bpf+bounces-26279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF5B89D989
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 14:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B0E28C08F
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86212E1F3;
	Tue,  9 Apr 2024 12:58:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0047172F;
	Tue,  9 Apr 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667504; cv=none; b=QrQmI6XwTsBwD5ylH5YNcWpqfeo17LG6ZJbidEv3G1EaxL9MSU1rt3zIby8TGpxyCW3cVv56ckn9me3QR0xXH6nkgbeUmQwOzC7xuUjDHHEoD+UYn8qlKXXsQqEbC2rxSJPQj0hWH59VrNcLSsSktvrrsx+puf0v3mTcXUI2iuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667504; c=relaxed/simple;
	bh=sXW5qAwjO0ptd2u/oyzCh/TK3jJ88gKM9HgSZ3UYqsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBlLRBHcqt+vgxvFteYJHi3ta45+QHQfFWPl802ycMO1W4a0obpERJtSYAQoTZT541FCDCsTOmgaaMaLWVrukT9b4IIuk18I8TVVD64a/s4rTqRZUkUkLsi3GxWRSmZw1g2pn7zhVO5r7AXlxLozT3gxKrmuLHDjBWt2lDUQ/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343e70dd405so3603923f8f.3;
        Tue, 09 Apr 2024 05:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667501; x=1713272301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFDdytT0v09rWVgCaqJM24d+bAkOK5uzvp9jq8SPpic=;
        b=VLSMc4NmcOwbH0/fRUgrbjW00HF3X2KY8+zYs88IS4nQEemIIbaPWlh9TOuRwTgIkr
         vhDTUExfsZJoXnuzl59ci7xfKZJLYUJGYQAdcZ/pIu0kXss7/CLWuqLkCRO4G7+ZCe4V
         BwL/8KopP2+6xXQXFmMX9rmDbnSnMdF5ucVi5crqpf+VM05Rd67W9EUymIlEooPn/Uje
         u3V9/ZGLVkQUBFu+cHbOvedBJ9ik5WMHTeLmI9LfbM1Lm3BQjceK01pDWdiLhaRBF6aD
         6qu0IS0lDX3cvLI4TmnruYnU6OCgFTvtjH7FgiMQkMIOWMOhl/DjbIla+NNraU1LQnHh
         8G+w==
X-Forwarded-Encrypted: i=1; AJvYcCXi10y7CUvDmyL3k2/VyjZz8HGNQg5wW7k6GzGzpYHjkiUw+Ism16KzfM6hgj1uwPSHXHLfhMuYDnbT0lUm+S1RZLiP2/qBvig/BlFGPDeEREHrXN3FShNIc/znSL8vMcK60pV4Ultxs9/HE6b0SJ0XbaV4JJgwsLNVELYGRS9aKZeolWe4ll7Uz4c8Pj/4C3LR//rB+krpD8o=
X-Gm-Message-State: AOJu0YzCyCbRr46rTtXHn6pXanhBPDYh9JvhOOk3WutL3OS8aONZoPGo
	R2l0N0JuXVe6fRH7InzlEXuroVoI7H/Plwdnk3mzIqCknJt7DHH6
X-Google-Smtp-Source: AGHT+IF5sJSCYs5v+qNFkqjxztOrDHFXX8CMXk5zRc/0XtJPRH8TOBlSdoo+czWfsit+YhsaIA7hyA==
X-Received: by 2002:a5d:438f:0:b0:33e:ca28:bb59 with SMTP id i15-20020a5d438f000000b0033eca28bb59mr10807960wrq.57.1712667500650;
        Tue, 09 Apr 2024 05:58:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906270d00b00a4e98679e7dsm5644168ejc.87.2024.04.09.05.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:58:20 -0700 (PDT)
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
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 0/9] allocate dummy device dynamically
Date: Tue,  9 Apr 2024 05:57:14 -0700
Message-ID: <20240409125738.1824983-1-leitao@debian.org>
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

v1:
	* https://lore.kernel.org/all/20240327200809.512867-1-leitao@debian.org/

v2:
	* Patch 1: Use a pre-defined name ("dummy#") for the dummy
	  net_devices.
	* Patch 2-5: Added users for the new helper.
v3:
	* Use free_netdev() instead of kfree() as suggested by Jakub.
	* Change the free_netdev() place in ipa driver, as suggested by
	  Alex Elder.
	* Set err in the error path in the Marvell driver, as suggested
	  by Simon Horman.
v4:
	* Added a new patch to add dummy device at free_netdev(), as suggested
	  by Jakub.
	* Added support for some wireless driver.
	* Added some Acked-by and Reviewed-by.


Breno Leitao (9):
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


