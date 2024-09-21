Return-Path: <bpf+bounces-40159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293197DDF9
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 18:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CF5281851
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB0176FB0;
	Sat, 21 Sep 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvZgflTH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E631547DA;
	Sat, 21 Sep 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726937587; cv=none; b=Uvb8QS85rEc3bxVGo0Z/lSs6KoEJRgrEelkmOcHJaAH16kfjeZFQ3jzb5BjYmHeatjIWYGnYPF0UhSLl8RzyX6mO1W9sOr6u0UHp3x8Dsmc8OLmiRWaHPICxERNJcAtg3cEeL3WTqCbW5GM/of8DwMQWbpxtOARYlD9oCxZdVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726937587; c=relaxed/simple;
	bh=3DcqSOF/2OUCezVBG3TW/2mi74Vittpx3O4Bq7D530E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gglm2cE2MnQbMvVfRRwtCayLEjEaSd6tdnWz7qLpI4iDCen7+qLaap0pmHDL/U0cXX+YZbuuwRwtfJYEySPfekxH8g1Rkui8UFOlDTGTWveYJrFDG8AoWKhbfih1ua1NtujpcSfMEZj2STBw4OSxlZwZ3ImXbJr3nLqmpzNRIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvZgflTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A4AC4CEC2;
	Sat, 21 Sep 2024 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726937587;
	bh=3DcqSOF/2OUCezVBG3TW/2mi74Vittpx3O4Bq7D530E=;
	h=From:To:Cc:Subject:Date:From;
	b=mvZgflTHVHw8FcQSB0HTmTUe0PReDu8ac0Ptt9TgciEUburqdfqLdHfKeUtAfXRp9
	 dT/fR60pFaascXawuuChzCkLfALQErQ9NI+fxLZtf3ckjxq4NqvzR2WVv6bnXlD7n5
	 46TQOWgSD76K+cQd6x95ZWOfSMcQG2x8iBW4jdZFoaZ8OMVxJ/e4UJqS/iQh2/swAe
	 5HAkxJUEPg5hk0arYhWSEUfa7atczRZeo/lvmknUdbCm//aH1iINb0+qEIJnmslirS
	 hQF00/n7PXc2gqoallb0faO/HSH69QHgcOxzDb0anGn3CJeehea0fUHEmDYP1ni82I
	 9dl//9BFZ3zFA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	toke@toke.dk,
	aleksander.lobakin@intel.com,
	sdf@google.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	mst@redhat.com,
	jasowang@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Subject: [RFC bpf-next 0/4] Add XDP rx hw hints support performing XDP_REDIRECT
Date: Sat, 21 Sep 2024 18:52:56 +0200
Message-ID: <cover.1726935917.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the xdp_rx_meta struct in the xdp_buff/xdp_frame
one as a container to store the already supported xdp rx hw hints (rx_hash
and rx_vlan, rx_timestamp will be stored in skb_shared_info area) when the
eBPF program running on the nic performs XDP_REDIRECT. Doing so, we are able
to set the skb metadata converting the xdp_buff/xdp_frame to a skb.
Update xdp_metadata_ops callbacks for the following drivers:
- ice
- igc
- mlx5
- mlx4
- veth
- virtio_net
- stmmac

Lorenzo Bianconi (4):
  net: xdp: Add xdp_rx_meta structure
  net: xdp: Update rx_hash of xdp_rx_meta struct running xmo_rx_hash
    callback
  net: xdp: Update rx_vlan of xdp_rx_meta struct running xmo_rx_vlan_tag
    callback
  net: xdp: Update rx timestamp of xdp_rx_meta struct running
    xmo_rx_timestamp callback

 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  9 +++
 drivers/net/ethernet/intel/igc/igc_main.c     |  5 ++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  3 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  8 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  3 +
 drivers/net/veth.c                            |  9 +++
 drivers/net/virtio_net.c                      |  3 +-
 include/net/xdp.h                             | 79 +++++++++++++++++++
 net/core/xdp.c                                | 29 ++++++-
 9 files changed, 146 insertions(+), 2 deletions(-)

-- 
2.46.1


