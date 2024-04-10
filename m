Return-Path: <bpf+bounces-26413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B237289F3DB
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B903B2371C
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A1815E801;
	Wed, 10 Apr 2024 13:17:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706015B576;
	Wed, 10 Apr 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755072; cv=none; b=Ktw0ExcwEcArJwTUC/cJPnNw6aE9mZyLN47PyZy2EyeUvWFEi4f79d2SEkRLOucIhhoes0pHYsiUMhbpS641k/fbkP+8gNZAjCbTmsUSOw/Iio7eGgag25ZoExkX1XkPqen4hJQCGYj5RCJUA6U2JJvC7Pmc+56fTYOsn4Wgxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755072; c=relaxed/simple;
	bh=orGm0Aw7qKaF1ixL74Hd4m13SwR3N1yeHXHZYtr8+A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bL7GRsPi2BPikI84hXwSlTT2tHAhl1htbpGdlo3R0L/6Z1R0eVoU2X6pGeAetw1HgolBnJ7O2mTgLr/FhfLPXEPlnLMH50e/RQTgo6i0OevD+6qwyDHjR1ufR997Uv9TlMsdOyZaCJb/YnxOkUww6j9lP5gMjfgM2N1j0OPHXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e6646d78bso3463472a12.1;
        Wed, 10 Apr 2024 06:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755069; x=1713359869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK/ebucV8gkQdirPclBiNQxag+qh5mnAVP3hrQ1KOiw=;
        b=gWo3NGavqRD5ruilC+fureWlSQVoSm3G5wjrcOTOWhnPRJiyDyBMdsJeDedRROL6/Y
         2o4k/fvvwsdQ0Us4o9Pvxnm25GE5+aZ8plKfDxaRRmNJNzgPSWiuZ3cUwyQZGAV8wovm
         ADtfOavQPeJkcGY117f6TMQPLUv0strrhMmIonPoGfFVNrPycozjvSKk0YUT0NZUuvp5
         Yq4tG1cuID2DD7kMVzwJkBfd5YygP36K7f3unrQVvnfvR7EqAjOL0iqRRg74cbI8GcwC
         JRUYPSC76QCUMosUgFsJYajZow2USn7F0O5dLeWYqMEmXzINuI2tP8i8m3hh0nI4OM3O
         gUNA==
X-Forwarded-Encrypted: i=1; AJvYcCXkZBXURUmEyBSgNxy5KWoNx/IH1SKLmS2C8Ly6kj6CTocLLyvAtkoWaPZoFqb6vZ73V0xSWaCNTjF/gmJ+1d8gioMtUu+wL+YVsDZXVBHUcsKVGBVvgGiVsFcpBujFdmsTKTutg2NRYecGIq9HuTxXjs1RzjsWN1R0zYZ4/pF1oeQ3+y2aGOPmgEjxcHVOgynTM0QHluaixtw=
X-Gm-Message-State: AOJu0YzIr0BDNOYqfqZdeE9JJ5KT+/flF3tQkUf8+zWNpFeCKhh6VtaM
	SY/HfaLwg26KEFw4/K+AECBA/REdThCABZC3MLMuVYq/Xj3tc5ar
X-Google-Smtp-Source: AGHT+IFSd0Sg381tqtWe29jdXXqCNujDjWni8Ms+Iy/hEjPdANID9QF0uHrZU2yu/2/4I7NBrTO3cw==
X-Received: by 2002:a17:906:4f17:b0:a52:140c:571b with SMTP id t23-20020a1709064f1700b00a52140c571bmr735783eju.3.1712755069216;
        Wed, 10 Apr 2024 06:17:49 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id jl7-20020a17090775c700b00a4e70ede2b7sm7016390ejc.174.2024.04.10.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:17:48 -0700 (PDT)
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
Subject: [PATCH net-next v5 00/10] allocate dummy device dynamically
Date: Wed, 10 Apr 2024 06:13:41 -0700
Message-ID: <20240410131407.3897251-1-leitao@debian.org>
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
v5:
	* Added a new patch to fix some typos in the previous code,
	  suggested by Ido.
	* Rebased to net-net/main


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


