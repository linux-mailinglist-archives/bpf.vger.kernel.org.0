Return-Path: <bpf+bounces-6642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9B76C184
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764941C21129
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5DC7FA;
	Wed,  2 Aug 2023 00:33:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452A7E;
	Wed,  2 Aug 2023 00:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FBFC433C8;
	Wed,  2 Aug 2023 00:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690936381;
	bh=OvcvmlOI76pkfpQXs2zFIh/F4GMcdY20CG84VmiF7EI=;
	h=From:To:Cc:Subject:Date:From;
	b=Exl77/RZ/iWnsw4gQeQAhwO/pd+ypXuPU6jH/JBJ2LmjHkNvNmBE/xWycY7JNOcji
	 F21fZIjSm/87XJaTG4l5zsJ7A9CB8BYjNeV7tavR4L6K48EAM8/WMMGTTElJrz3I6r
	 C777+vWgstH1LTVBDWj03JoiKKiyAXDcqvTxmEl553b+yPB3EfGviDteut3R8bXZ/e
	 34zBT+MQrssf2svsvl56ldEib4nozr4dkkzFR7rRtWnj31onpfg7lbmS8MXqZ5GHgY
	 ivrAP7xuZCm0TsRYBYyuFw8Y84rKShjPBwyumNJS2EyciixJ9/ZuxPiUbD1cFp4w41
	 aqQvYuCr17MIw==
From: Jakub Kicinski <kuba@kernel.org>
To: ast@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	amritha.nambiar@intel.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 0/3] net: struct netdev_rx_queue and xdp.h reshuffling
Date: Tue,  1 Aug 2023 17:32:43 -0700
Message-ID: <20230802003246.2153774-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While poking at struct netdev_rx_queue I got annoyed by
the huge rebuild times. I split it out from netdevice.h
and then realized that it was the main reason we included
xdp.h in there. So I removed that dependency as well.

This gives us very pleasant build times for both xdp.h
and struct netdev_rx_queue changes.

I'm sending this for bpf-next because I think it'd be easiest
if it goes in there, and then bpf-next gets flushed soon after?
I can also make a branch on merge-base for net-next and bpf-next..

Jakub Kicinski (3):
  eth: add missing xdp.h includes in drivers
  net: move struct netdev_rx_queue out of netdevice.h
  net: invert the netdevice.h vs xdp.h dependency

 drivers/net/bonding/bond_main.c               |  1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  1 +
 drivers/net/ethernet/engleder/tsnep.h         |  1 +
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.h  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 drivers/net/ethernet/freescale/fec.h          |  1 +
 .../ethernet/fungible/funeth/funeth_txrx.h    |  1 +
 drivers/net/ethernet/google/gve/gve.h         |  1 +
 drivers/net/ethernet/intel/igc/igc.h          |  1 +
 .../ethernet/microchip/lan966x/lan966x_main.h |  1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 drivers/net/ethernet/ti/cpsw_priv.h           |  1 +
 drivers/net/hyperv/hyperv_net.h               |  1 +
 drivers/net/tap.c                             |  1 +
 drivers/net/virtio_net.c                      |  1 +
 include/linux/filter.h                        | 17 ------
 include/linux/netdevice.h                     | 55 ++-----------------
 include/net/busy_poll.h                       |  1 +
 include/net/mana/mana.h                       |  2 +
 include/net/netdev_rx_queue.h                 | 53 ++++++++++++++++++
 include/net/xdp.h                             | 27 ++++++++-
 include/trace/events/xdp.h                    |  1 +
 kernel/bpf/btf.c                              |  1 +
 kernel/bpf/offload.c                          |  1 +
 kernel/bpf/verifier.c                         |  1 +
 net/bpf/test_run.c                            |  1 +
 net/core/dev.c                                |  1 +
 net/core/net-sysfs.c                          |  1 +
 net/xdp/xsk.c                                 |  1 +
 30 files changed, 108 insertions(+), 71 deletions(-)
 create mode 100644 include/net/netdev_rx_queue.h

-- 
2.41.0


