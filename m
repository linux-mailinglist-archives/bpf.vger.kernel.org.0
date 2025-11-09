Return-Path: <bpf+bounces-74030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D488AC447E4
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 22:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4E834E3670
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 21:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BCB26CE0F;
	Sun,  9 Nov 2025 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1eA0a4I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE41A0BD6;
	Sun,  9 Nov 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724319; cv=none; b=onw1jWfhOaMtIVqcJsNEUdHZ4qmGPpKPLPKbiQNUyLbHfY5sQ6hTph5MKAbmY+sFvjmx+4HI3BA6QSvsoFRZTMo5eoy1O8yIjp+JO5fYIjQd5OYd+wdPqqiiWzSvstPvZpttIdQEj+gu8wgtROUxdzlyDNiMRw0TYIPTnj2U700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724319; c=relaxed/simple;
	bh=1OeQ5leuGFX+BMFWlTTG7Yq9Lea1Zl3bo8L1tVXgnJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kp3sL0nCVSeB5yXqi8K3yg+IepvYigjf6seC5cB0AYKo6y+Pl6CpnKTUxIHRtSPPjLb528oSwsEIutNPmk4HChp26+vocFkU9Ocj/+rYyzBn+ienjvAyjJLAvhVwf7p8F+PCIZ5uSBrADMgx1xpAgb7ybnFCEayjLye+bSCRpfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1eA0a4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF65C4CEF7;
	Sun,  9 Nov 2025 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762724318;
	bh=1OeQ5leuGFX+BMFWlTTG7Yq9Lea1Zl3bo8L1tVXgnJU=;
	h=From:Subject:Date:To:Cc:From;
	b=O1eA0a4I81B5O2SKORoMD01mc9kPUecIbVVzFtjg/ViiEFGxv6BlC665gvLdbYafW
	 LuZmT/kfbURcxDUytLyZcSsGgkpbRzPr67rxAu1bTGWSQHv6/8G1o1co4mvAPlZmFa
	 3iJLJgDleEvwoqDOq/aNAISo9mO22PSpPUTlyo5w+j00TDMYX4XBcXWyQdwGFKZda1
	 BbOxpDnI/5HC87e/7gvvDuBsMRxF3NCZ9OAbRykdVU8V8/84P4Ll0Hn9NkAWDgbCYZ
	 xz/jFlavD7iouNq8j41kmaQft50ywKkuOV1RRATIHzqsXEL2vu06Y8YwHLKQyCNelf
	 FGLWQH5PvvUMQ==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next v2 0/7] net: ethernet: ti: am65-cpsw: add AF_XDP
 zero copy support
Date: Sun, 09 Nov 2025 23:37:50 +0200
Message-Id: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAJEWkC/2WNQQ6CMBBFr0Jm7ZgyMo264h6GBZYBGrWQllSUc
 Hebbl2+vPz3NwjirQS4Fht4iTbYySWgQwFmbN0gaLvEQIpYETG2L81o5vDGtZvxa5Da/iLVXco
 Ta0iz2Utv15y8gZMFnawLNMmMNiyT/+SvWGafs0zqPxtLVFgx81lR1bPW9UO8k+dx8gM0+77/A
 JZtY9y7AAAA
X-Change-ID: 20250225-am65-cpsw-xdp-zc-2af9e4be1356
To: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>
Cc: srk@ti.com, Meghana Malladi <m-malladi@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2592; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=1OeQ5leuGFX+BMFWlTTG7Yq9Lea1Zl3bo8L1tVXgnJU=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBpEQnZg6fI6ykKHG3Oz/FNzhRyWQwi6xRL+ysHJ
 oOBN9cLLr+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCaREJ2QAKCRDSWmvTvnYw
 k9eWEACMTuUzbaOk1xsjn4XoiN97IIuf/w38NHPAcEaf0tPHMTY7bDyzu5ugTaWwwkmtCeJ7o2U
 OLNFTceVInqiMu4nxpHvhgLo4DCS3HVoT0zI9EiCv0a5Z0CuvCaJHA8QUJa6sbPmqDFd7bbEu6L
 BVvhSPgN9RLKi5DplgGoONmgi81/E4wQ7WUUt8Vf2GjMyI6PXP8zMRYFUG/suRp+6u14QKRTdx3
 fpPondIgeicoUuGaKmjuyVK0VWg8W92+Q+X3yi92exVGN+PF+fd7CEPFY+Sp7MDeoPiGfCHOQkB
 T1l3d6vkvxSig3rcw9l6lx4GffUoRGXbjXW13ud2LIKwEg8UHk4EG0Rzek1orwBItxL5wZXjh5U
 s61ydIdzoV2eT7ED5cVkgNyhZL4pEPPVoZqPFR52W/k9+BuQOCQn6a78x0+cIqxQK3bXHBmEkZx
 h6o8bGpAPhhYYDfzGi+jlAVeJNAyaUlxe7ToHJkY8ZMuKe1TXzi2IMEinK96lBfMCxM244wj9qX
 8F+dM1Lsje2nJ0OGymksiAeWkmPgwZW8EFCfIQ6RPN2LtPbmsigexz0oIpSga8hdGsTu3N5yewQ
 2O4zIbs511nvexWNy/G1XuqkyphjcnL2XieKjaJTvn8voP/yH157sfxwSRAVtKf5esuMWe2ixra
 Qe4oJzlWdYn7+Zg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

This series adds AF_XDP zero coppy support to am65-cpsw driver.

Tests were performed on AM62x-sk with xdpsock application [1].

A clear improvement is seen in 64 byte packets on Transmit (txonly)
and receive (rxdrop).
1500 byte test seems to be limited by line rate (1G link) so no
improvement seen there in packet rate. A test on higher speed link
(or PHY-less setup) might be worthwile.

There is some issue during l2fwd with 64 byte packets and benchmark
results show 0. This issue needs to be debugged further.
A 512 byte l2fwd test result has been added to compare instead.

AF_XDP performance using 64 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
rxdrop		322		491		845
txonly		390		394		723
l2fwd 		205		257		0

AF_XDP performance using 512 byte packets in Kpps.
l2fwd		140		167		231

AF_XDP performance using 1500 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
rxdrop		82		82		82
txonly		82		82		82
l2fwd 		82		82		82

[1]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v2:
- Prevent crash on systems with 1 of 2 ports disabled in device tree. check
  for valid ndev before registering/unregistering XDP RXQ.
  Reported-by: Meghana Malladi <m-malladi@ti.com>
- Retain page pool on XDP program exchangae so we don't have to re-alloacate
  memory.
- Fix clearing of irq_disabled flag in am65_cpsw_nuss_rx_poll().
- Link to v1: https://lore.kernel.org/r/20250520-am65-cpsw-xdp-zc-v1-0-45558024f566@kernel.org

---
Roger Quadros (7):
      net: ethernet: ti: am65-cpsw: fix BPF Program change on multi-port CPSW
      net: ethernet: ti: am65-cpsw: Retain page_pool on XDP program exchange
      net: ethernet: ti: am65-cpsw: add XSK pool helpers
      net: ethernet: ti: am65-cpsw: Add AF_XDP zero copy for RX
      net: ethernet: ti: am65-cpsw: Add AF_XDP zero copy for TX
      net: ethernet: ti: am65-cpsw: enable zero copy in XDP features
      net: ethernet: ti: am65-cpsw: Fix clearing of irq_disabled flag in rx_poll

 drivers/net/ethernet/ti/Makefile         |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 583 ++++++++++++++++++++++++++-----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  37 +-
 drivers/net/ethernet/ti/am65-cpsw-xdp.c  | 155 ++++++++
 4 files changed, 692 insertions(+), 85 deletions(-)
---
base-commit: a0c3aefb08cd81864b17c23c25b388dba90b9dad
change-id: 20250225-am65-cpsw-xdp-zc-2af9e4be1356

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


