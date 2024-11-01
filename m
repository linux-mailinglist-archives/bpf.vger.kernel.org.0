Return-Path: <bpf+bounces-43713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37F9B8EF2
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C83284E5A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657A17C990;
	Fri,  1 Nov 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldn7hfZP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349116F0F0;
	Fri,  1 Nov 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456338; cv=none; b=buzyejJFvsgnP72IBBGKmBUlu/zMgIK7VCBWPO0g/WjtMbdsHx7SElJhHI8JHBHHkXZk0onZvrS03eeKKUv6tvXwQpeKn2dOD2ijKuI43Cdb07JXNxJ2XSE2xwdDDRoSiMqWzfVLnhPABgH1Qow5gILUhcM6D+JiseVweqv7duQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456338; c=relaxed/simple;
	bh=P+LAG5iGyPUm1XVaYHrFDfKhXgiqkDk1rig2SDd0alo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qnYn9TExI3a7gZDhw96x19fhc0Ssy2AcN+AYO/Itp2JzSDP+773Jyqlme/6La63i5bo+ShUixKZICb4ZbNHMpIgDCzWkE2bGaKBH1VYhKamRpMEKHVxlHITpDmeVNxFPIgEcYdopTSmPipRZkN51zE/T8pFlnrQxrtyNEGvw1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldn7hfZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9740C4CED2;
	Fri,  1 Nov 2024 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730456337;
	bh=P+LAG5iGyPUm1XVaYHrFDfKhXgiqkDk1rig2SDd0alo=;
	h=From:Subject:Date:To:Cc:From;
	b=ldn7hfZP3krF5wgacMhPk8C4/kwiVEiBFCc1BAlpPxdfLBZpjdJ2GgyOyk4XyvOqn
	 Ie++rvTpqfd+Hl8yRvJpsKN0Ad+DLK5DzB8Hv2aHswajI2tsF7O7mQ4CLlG0A8cnG8
	 TcNZDPtqHGF/gnfOvgYz9DKJehRJYKgefzWDNxzp7mB4okhxvE++WAq5b5JilFNDv9
	 m96t5EDkgaSdMRCg9LqBmGBZKp8LiyvWPQxQ1nCrfHKAN5MOqAWe+llY+Ylz+IytOj
	 a5lM22oTcsKk/6p+RgAG6zSmK9CUd0hRo9IM87oAUWt/v+yC7vu2/HDTpTmMhC7OoS
	 7gcpGeaUTyrZQ==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net v3 0/2] net: ethernet: ti: am65-cpsw: Fixes to multi
 queue RX feature
Date: Fri, 01 Nov 2024 12:18:49 +0200
Message-Id: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAmrJGcC/33NQQ6CMBAF0KuQrh3TlhZaV97DuIAyQBUKaRExh
 LvbEBe6cfn/5L9ZSUBvMZBTshKPsw12cDGkh4SYtnANgq1iJpxywShPoegzCWYMT+gf3WTBL3D
 LobYL1LrgTOgSs6oicT96jPVuX4jDiVxj2dowDf61/5vZfvrQ+g89M2AgeGYKRaVmypzv6B12x
 8E3OzvzLyql/ygeqdJIQVVeUiWzH2rbtjdWo2XREwEAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>, 
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=P+LAG5iGyPUm1XVaYHrFDfKhXgiqkDk1rig2SDd0alo=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnJKsNU7P1gMfpFzzTrNeb+xEGmIkG5D9bvQEUd
 qbwezo0K1qJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZySrDQAKCRDSWmvTvnYw
 kz1ZD/9Fm+QsxrSyeUWHYs//ThOtkufcdggJ2xf3wAjTR4ckKca9BfOH7mHXpTZmqV38UVrpMMR
 9PAKGYj7vqu1/A2gFMVzoCim7RiF6GX46GsC9XcwI0eeKzTYzSxcRkPz6RhA9U2DQevwMzgMMYw
 h8LeFPZYI/RSKp/zqmczlmLiuqWc/xcwRydnlA1cFSv6pu/m9pgIYfYQSNc71gw5pfDXWn8Bd07
 Z1h6i2OKyf16S0l3WUHgelY6owdGyr1D3cBf0nS23B2ZNkQsz7qrvJFQGYLjMSt9vS2cRZaIgfW
 Y86ZvaMHmH6hOpgR3oN2iJnKJHJmSAC2vccsNCVrW/FpUF2q43fu8QQQAh/d0/sbXjN1FnHNBEf
 A1n1P/x9rUX2iEeJsDXPMqC83n2dE90UW9gviP4JWClSNxn+ItlJjQs0s4puIovWb4Y2vUzT2fQ
 YhMOwK6+1i1KZzpuQDFLBc+xJLS9sncEI48ENrzpDTUm2JiEse4qUbj50Lt2zJLgZPh+frdb3UZ
 ksjIiZMH4+QfQKFozPXBxsODk3LlRggjxMS+V49yljH9cbSCS4sb5shajvgyqcAmHAOXX5cZW5A
 kqrWfBEDaBuUgN+76a/rz2X5jxVtT2jYyDGVBogpbxMTw6fowZ2LThearmD3/NXzq6ukRkVj5nI
 htJp9EwOZ65BmGg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

On J7 platforms, setting up multiple RX flows was failing
as the RX free descriptor ring 0 is shared among all flows
and we did not allocate enough elements in the RX free descriptor
ring 0 to accommodate for all RX flows. Patch 1 fixes this.

The second patch fixes a warning if there was any error in
am65_cpsw_nuss_init_rx_chns() and am65_cpsw_nuss_cleanup_rx_chns()
was called after that.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v3:
- Reverse Xmas tree style fixes
- Split out unrelated code fix to a new patch

Changes in v2:
- Dropped unused variables desc-idx and flow
- Link to v1: https://lore.kernel.org/r/20241029-am65-cpsw-multi-rx-j7-fix-v1-1-426ca805918c@kernel.org

---
Roger Quadros (2):
      net: ethernet: ti: am65-cpsw: Fix multi queue Rx on J7
      net: ethernet: ti: am65-cpsw: fix warning in am65_cpsw_nuss_remove_rx_chns()

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 75 ++++++++++++++------------------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  6 ++-
 2 files changed, 37 insertions(+), 44 deletions(-)
---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241023-am65-cpsw-multi-rx-j7-fix-f9a2149be6dd

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


