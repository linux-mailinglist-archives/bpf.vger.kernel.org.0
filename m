Return-Path: <bpf+bounces-54300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CCDA672F6
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215F14201B4
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D620A5DC;
	Tue, 18 Mar 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyRRBtiy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495A3FC2;
	Tue, 18 Mar 2025 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298375; cv=none; b=YZnH6NOXyJXAi1Z5Znv3XkbvI/GWh9wghtIZVkLLbNam+zaqo746Ffd+285t/gDsDoPkk38VYVhwCMCjV0SfE3B1lk/EZmCo5msdpogTbqtL87cAZbNRXejLWXdwFiL+iyAiWK3seTxrlH5BhG7qs5kPHlsj/baghGIprzGNXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298375; c=relaxed/simple;
	bh=Wbt+cMfNuda8a8GObInFe/jXMq6FMLgwE5BGIkGdW8w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ksop74xgOZll9FJFGOzXGd79RheUDMGB7LbtLrwwvamAAlre5WC+VpojBUgb1qV8Jm+ET4qPoLb69UlHG8niMq9f5QNCIw2DeBxO+NBJs6lIn+oTps8Ljmih+0IVzvagDtAbK2/3Qw+GzMapB1hfH3ysZGfMx5PYZrvPM6l2SfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyRRBtiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1F5C4CEEF;
	Tue, 18 Mar 2025 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298374;
	bh=Wbt+cMfNuda8a8GObInFe/jXMq6FMLgwE5BGIkGdW8w=;
	h=From:Subject:Date:To:Cc:From;
	b=FyRRBtiy3eE2pXRRsGVl2QciJzEzUqLf77qlVZGsB6PS5eu2gTI+cmjziqBaBW75A
	 9x6Z7ZlmUYcNaBSvTwRyWMu145OWD03vb77HTd0z0pzSpeFs8iyM1LQeaTxmFQJ7Bp
	 VtReMp70OIErmAC5XUueVATCgOFx1Fg/WxOrCmmI248/4H/PgfE3XAjsVZFz/o6GmW
	 qtuX3GFdPRBU7ZJuh7YmUlo44G5z/IqBrp74u3Ssa6hqsReW4kPbvs/kaeoJeRYN3f
	 NhJXRNrY93/UAhAzDXGAXkcBm153I7ThToQZcF9oZoLUbziJxfV+lU/SCVVP9ShRyt
	 rc041qQICrxoQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/7] net: xdp: Add missing metadata support for
 some xdp drvs
Date: Tue, 18 Mar 2025 12:46:04 +0100
Message-Id: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxc2WcC/2WNyw7CIBREf6W5azE8qhZX/ofpgsClJVpooCE1D
 f8ubeLK3ZxJ5swGCaPDBPdmg4jZJRd8BX5qQI/KD0icqQyc8gsVjJIpe1wUWc1Mpj0IpEZ1aNt
 WdlBXc0Tr1sP47CuPLi0hfo6DzPb252J/rswIJeKqLdNS3iTFxwujx/c5xAH6UsoXJkY/La8AA
 AA=
X-Change-ID: 20250310-mvneta-xdp-meta-3e0da8ef4498
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org, 
 Michal Kubiak <michal.kubiak@intel.com>
X-Mailer: b4 0.14.2

Introduce missing metadata support for some xdp drivers setting metadata
size building the skb from xdp_buff.
Please note most of the drivers are just compile tested.

---
Changes in v2:
- Improve commit logs for each patch specifying xdp headroom size for
  each modified driver.
- Link to v1: https://lore.kernel.org/r/20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org

---
Lorenzo Bianconi (7):
      net: mvneta: Add metadata support for xdp mode
      net: mvpp2: Add metadata support for xdp mode
      net: netsec: Add metadata support for xdp mode
      net: octeontx2: Add metadata support for xdp mode
      net: ethernet: mediatek: Add metadata support for xdp mode
      net: mana: Add metadata support for xdp mode
      net: ti: cpsw: Add metadata support for xdp mode

 drivers/net/ethernet/marvell/mvneta.c                  |  5 ++++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c        |  8 ++++++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 13 +++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.c            |  7 +++++--
 drivers/net/ethernet/microsoft/mana/mana_bpf.c         |  2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c          |  4 ++++
 drivers/net/ethernet/socionext/netsec.c                |  7 +++++--
 drivers/net/ethernet/ti/cpsw.c                         |  6 +++++-
 drivers/net/ethernet/ti/cpsw_new.c                     |  6 +++++-
 9 files changed, 44 insertions(+), 14 deletions(-)
---
base-commit: aedfbe251e1c56034cb6ffd87eabe5895b31ae5d
change-id: 20250310-mvneta-xdp-meta-3e0da8ef4498

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


