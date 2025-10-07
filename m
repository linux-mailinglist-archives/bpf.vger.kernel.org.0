Return-Path: <bpf+bounces-70551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD9BBC2EF1
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 01:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D4319A1981
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 23:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4225C70C;
	Tue,  7 Oct 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8CajmAf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235C7235C01;
	Tue,  7 Oct 2025 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879627; cv=none; b=YaDBRZbQOT4HnVG2ozuEBhQEzn5W8HS0CjqPLAH4UoiYAf8dRgtYX79Fao4ebusFWL1xghW8b8qUpiiQiveBSTF0liYIsDbmCNcSITHKmMZhvlfbexZy4PrI1O5c5jvi5ViBtb21G8J5D+eWokjBoOm171ghAg/mo/CfacqYXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879627; c=relaxed/simple;
	bh=CaUXBZMISbzNhTMO0YWfXfkTC2QagyAT/MAcDC++FeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjkPG1zVz0FK2yAvmc78/C0rCy4JMFDU6HJ8o6yXiG6vkVQ1IQPYrM5IJRu9NwzqFuqFk/FoFWGIs6Rj+L/swxXeqVPcgL/vlT43wXDZutWuwGUu7hIM7MJeJ3WLUQCspfO1mVEiPHjT75BI2sLqON4JQmoI08CfXFlt3wB1+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8CajmAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C122C4CEF1;
	Tue,  7 Oct 2025 23:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879625;
	bh=CaUXBZMISbzNhTMO0YWfXfkTC2QagyAT/MAcDC++FeQ=;
	h=From:To:Cc:Subject:Date:From;
	b=S8CajmAf0ZHhErOJHTIVdQoZ9hHeSqr4IuXHqg3albYqq9pgAgkaC62FNRpjqUwOh
	 ALyG0Z0xsWOwYDZVKFIg7+sG9ENCf0fLJT72OGrXtArkWQwe/ZagPBUZJblCUHvelz
	 F2O+HkyjoAMSFSczWesuT3JkZguGaGAN6RILVxBkYJ9rcE8QoYWgF3fgi3WdA7ac9d
	 JEp7cqC+Sc7nN7vinmCkL/ScJkeoBuZ4xv55ejqeLvoDz/C/3uDfarieVRv/06r1+D
	 ZcL7RNhwE39CuWNhTD/g+Eh09u7flfK8JSvDfF+GzXVsl60ABriJLKBAceewLWkF6V
	 vLjNTYgisLJUQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/9] eth: fbnic: fix XDP_TX and XDP vs qstats
Date: Tue,  7 Oct 2025 16:26:44 -0700
Message-ID: <20251007232653.2099376-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix XDP_TX hangs and adjust the XDP statistics to match the definition
of qstats. The three problems are somewhat distinct.

XDP_TX hangs is a simple coding bug (patch 1).

The accounting of XDP packets is all over the place. Fix it to obey
qstat rules (packets seen by XDP always counted as Rx packets).
Patch 2 fixes the basic accounting, patch 3 touches up saving
the stats when rings are freed.

Patch 6 corrects reporting of alloc_fail stats which prevented
the pp_alloc_fail test from passing.

Patches 4, 5, 7, 8, 9 add or fix related test cases.

v2:
 - [patch 2] remove now unnecessary byte adjustment
 - [patch 8] use seen_fails more
v1: https://lore.kernel.org/20251003233025.1157158-1-kuba@kernel.org

Testing on fbnic below:

 $ ./tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
 TAP version 13
 1..1
 fbnic-err: bad MMIO read address 0x80074
 fbnic-err: bad MMIO read address 0x80074
 # Seen: pkts:20605 fails:40 (pass thrs:12)
 # ethtool -G change retval: success
 ok 1 pp_alloc_fail.test_pp_alloc
 # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

 $ ./tools/testing/selftests/drivers/net/xdp.py
 TAP version 13
 1..13
 ok 1 xdp.test_xdp_native_pass_sb
 ok 2 xdp.test_xdp_native_pass_mb
 ok 3 xdp.test_xdp_native_drop_sb
 ok 4 xdp.test_xdp_native_drop_mb
 ok 5 xdp.test_xdp_native_tx_sb
 ok 6 xdp.test_xdp_native_tx_mb
 # Failed run: pkt_sz 2048, offset 1. Last successful run: pkt_sz 1024, offset 256. Reason: Adjustment failed
 ok 7 xdp.test_xdp_native_adjst_tail_grow_data
 ok 8 xdp.test_xdp_native_adjst_tail_shrnk_data
 # Failed run: pkt_sz 512, offset -256. Last successful run: pkt_sz 512, offset -128. Reason: Adjustment failed
 ok 9 xdp.test_xdp_native_adjst_head_grow_data
 # Failed run: pkt_sz (2048) > HDS threshold (1536) and offset 64 > 48
 ok 10 xdp.test_xdp_native_adjst_head_shrnk_data
 ok 11 xdp.test_xdp_native_qstats_pass
 ok 12 xdp.test_xdp_native_qstats_drop
 ok 13 xdp.test_xdp_native_qstats_tx
 # Totals: pass:13 fail:0 xfail:0 xpass:0 skip:0 error:0

Jakub Kicinski (9):
  eth: fbnic: fix missing programming of the default descriptor
  eth: fbnic: fix accounting of XDP packets
  eth: fbnic: fix saving stats from XDP_TX rings on close
  selftests: drv-net: xdp: rename netnl to ethnl
  selftests: drv-net: xdp: add test for interface level qstats
  eth: fbnic: fix reporting of alloc_failed qstats
  selftests: drv-net: fix linter warnings in pp_alloc_fail
  selftests: drv-net: pp_alloc_fail: lower traffic expectations
  selftests: drv-net: pp_alloc_fail: add necessary optoins to config

 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  7 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  8 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 23 ++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 74 +++++++++-----
 tools/testing/selftests/drivers/net/hw/config |  4 +
 .../selftests/drivers/net/hw/pp_alloc_fail.py | 36 ++++---
 tools/testing/selftests/drivers/net/xdp.py    | 99 +++++++++++++++++--
 9 files changed, 209 insertions(+), 49 deletions(-)

-- 
2.51.0


