Return-Path: <bpf+bounces-70356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9911BB866D
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 01:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD31886CC1
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 23:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCFA265296;
	Fri,  3 Oct 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnANgrQ1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEA19DFA2;
	Fri,  3 Oct 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534256; cv=none; b=sD058/E+qJYiUIQtTo4n6SJI67vKL5xy1nWJhUt5mu2uT/+WFrMle7bT9RelhYZvTVExvZ2avGoz25wKGbeqm68z8nglLMXFAESc2oUr1oG5WaI5QbXlREFYFXE35mvmpFIdFHTxJeUVR69pbsZf78y96P7/KDzt2KSnF+52frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534256; c=relaxed/simple;
	bh=Uqaw0w6gOAaRop4luvTQy5qJH9Tr8UzibtcaDdzqhnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4e7NeRI5W51xDoFWTAqA895GlZbSI2auPGW0DsWcYzIdXrQVpeWCnsBOBilvpLFRMJcWArDRftRoNrTuIxDETtd7WaulvuP0xb6fd/P5SUsjStMgacGrgBEkYzcteVs7PcjVtE/MmbuDpM29lJU3VIBxYgtn7QtCU5fWDtxVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnANgrQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B5FC4CEF5;
	Fri,  3 Oct 2025 23:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759534255;
	bh=Uqaw0w6gOAaRop4luvTQy5qJH9Tr8UzibtcaDdzqhnE=;
	h=From:To:Cc:Subject:Date:From;
	b=FnANgrQ1rwKh+VyuyWBQTO3AunEEO0NkDY/+m9zWPkAq1Ap/0+pKha2EY/TD2AErj
	 bTkqU6tsMIngqg1TTXLcwBmnlHml8yq/iN6fBPud60RzhlWCjAglTmY707zpDDH6jX
	 ezeKxIHw3wx6L1XMTNudxSK4ulgC9taRFCmYXWt/Zm/87JckfI++fbNFUSXHSvHQ2A
	 darxpM7Hj6oqoGJkGJbc5xs/olrKTKJ68Ebep0iPHIbgZw1/w2/bmOZm99WTqLtxSI
	 sI+r+ZW3c2+2HRhdUGDg+Vrez8d6tjRYhhCM7hoLDaG+zMTSKebvFOJa97+7GiCQgP
	 QP1vcxfwOuFcA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/9] eth: fbnic: fix XDP_TX and XDP vs qstats
Date: Fri,  3 Oct 2025 16:30:16 -0700
Message-ID: <20251003233025.1157158-1-kuba@kernel.org>
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
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 72 +++++++++-----
 tools/testing/selftests/drivers/net/hw/config |  4 +
 .../selftests/drivers/net/hw/pp_alloc_fail.py | 34 +++++--
 tools/testing/selftests/drivers/net/xdp.py    | 99 +++++++++++++++++--
 9 files changed, 208 insertions(+), 46 deletions(-)

-- 
2.51.0


