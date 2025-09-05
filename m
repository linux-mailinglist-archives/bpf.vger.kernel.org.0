Return-Path: <bpf+bounces-67645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9944AB4667C
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 00:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B101A3BF7EC
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A745221271;
	Fri,  5 Sep 2025 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2RAeupD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91559315D40;
	Fri,  5 Sep 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110548; cv=none; b=AYyJeCccHwhc+WXqqBeNLhT44/a5Bu4Q9TbpOy842QyhS5gZ3mwRBuTti/lriOIDPNQ5Vqyirz/appD+m8pXTEY4QjpBTs7SFCQ0frUZoGPOubRyUD4ExR4v2XsrU+6LY0MCLAjmyRTVlUKmoIMFGUiYMkDnA6f/dHxQdr+TX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110548; c=relaxed/simple;
	bh=tPVP2AtzstYcdkvHMUKIrAW/kPxEUF3jM06Z7zLivUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usOaHCglBIWgsp7kHLuy4XwZcajaRFspZhzTYE2J//+Ov+WLHHC7BVK0/P6dhMFGF8fS/Ch05ZB0oD+hDzKIHDe+wM/kquh8S7nblCJLfk4/ihPx9RMVnchQW92s5L7wd5CSk9Rczmb/bETrGoDTSyBFJH3HIA23G9AtJyo0emo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2RAeupD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180CFC4CEF1;
	Fri,  5 Sep 2025 22:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757110548;
	bh=tPVP2AtzstYcdkvHMUKIrAW/kPxEUF3jM06Z7zLivUY=;
	h=From:To:Cc:Subject:Date:From;
	b=G2RAeupDxYw0sEAa4K/qYkm1be9JogSH/vlQULZ7aTBDGTUBfrtVOm0dyW+nIbkGd
	 HkrRH57tKAM794IAaA327DRwp3uiypxjHSkm9kU146jpJ/k7gpZ/WSdF0QCPq7QX2Q
	 iyP4ZRf8dCJpTKUKoByrbSXenPGcndSCcp1O7SIOY0XEKB3EfuliSgKkT65Xw4eOhD
	 Rgowl5ZiRyPnB5brbvY6m3xy2L0Zxm+bmk5UQtWLMpPG7tTlO2XimGXAhjIsr5F0Xu
	 wOks8T+1JzwTJ72IZEXZd/WqhXSjQb28UZDxpuYc7StYGfB31iMY1zNLW7+DAd2rXW
	 xQ0RIc8fm/H9A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	michael.chan@broadcom.com,
	anthony.l.nguyen@intel.com,
	marcin.s.wojtas@gmail.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	jasowang@redhat.com,
	bpf@vger.kernel.org,
	aleksander.lobakin@intel.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] net: xdp: handle frags with unreadable memory
Date: Fri,  5 Sep 2025 15:15:37 -0700
Message-ID: <20250905221539.2930285-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make XDP helpers compatible with unreadable memory. This is very
similar to how we handle pfmemalloc frags today. Record the info
in xdp_buf flags as frags get added and then update the skb once
allocated.

This series adds the unreadable memory metadata tracking to drivers
using xdp_build_skb_from*() with no changes on the driver side - hence
the only driver changes here are refactoring. Obviously, unreadable memory
is incompatible with XDP today, but thanks to xdp_build_skb_from_buf()
increasing number of drivers have a unified datapath, whether XDP is
enabled or not.

RFC: https://lore.kernel.org/20250812161528.835855-1-kuba@kernel.org

Jakub Kicinski (2):
  net: xdp: pass full flags to xdp_update_skb_shared_info()
  net: xdp: handle frags with unreadable memory

 include/net/xdp.h                             | 38 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  7 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 15 ++++----
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 15 ++++----
 drivers/net/ethernet/marvell/mvneta.c         |  7 ++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 23 ++++++-----
 drivers/net/virtio_net.c                      |  7 ++--
 net/core/xdp.c                                | 21 +++++-----
 8 files changed, 69 insertions(+), 64 deletions(-)

-- 
2.51.0


