Return-Path: <bpf+bounces-65874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F006B2A059
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 13:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E8188B684
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B429321425;
	Mon, 18 Aug 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eoyyS6nM"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8E31814C;
	Mon, 18 Aug 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516325; cv=none; b=tT3DOdXW7LtrWQ6sdj3QKR4S/2hGA0uz39HK1WzSuJynLP7rnaHgP/KOk4c7+En+waT/IWDAq0f4XdQXhbR66YMtBbGZwGGjJwk6AneKWw/TiwrN8noogyO2EjadnpqZ3GkpN8Rs5MepOfmCYBY3nHy7uUSNPu3T3P19mstb7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516325; c=relaxed/simple;
	bh=vaW5aTGE+qefqD/NH6Ivaw/FuNGCH4FiZC4oY/qDm8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dRuwv8rpY06vNk2fRuWOL/JULgAX087qZBCMN8wKvNg74ukv/2tjGBRyhMyJLxeEyLEx1MjHVzPdv6hwtJ1wTqLQpkq7kKsF4Cloi4vJKcurwXOAjvPSPNbXM235DIPrkb4Xef+E/+KV9zNIpSaKs0vAl6bUqE22MmK4V8Jnjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eoyyS6nM; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IBOWiF2705411;
	Mon, 18 Aug 2025 06:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755516272;
	bh=90mC3YfXWKN74giepEOw1+2cwm+ae/kwLy7HbQ/iXSY=;
	h=From:To:CC:Subject:Date;
	b=eoyyS6nM4eDavWN/fCQubJRccfaSXee/fITxqMMEenm6T96qKTAwwee8QH/GkBhTw
	 6BdKVe1Ahm4aVJdx6vH6AHsB0dkK3EqIG7ZN9qMVkoYov+UNvJZoAjtzRXFbe47qVI
	 PCPaqOrAmBrNJnplh6gg/SKBRmaAku86+KgjUgRo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IBOWw7258313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 06:24:32 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 06:24:31 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 06:24:31 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IBOVj93651277;
	Mon, 18 Aug 2025 06:24:31 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 57IBOT19011654;
	Mon, 18 Aug 2025 06:24:30 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <namcao@linutronix.de>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next 0/6] net: ti: icssg-prueth: Add AF_XDP zero copy support
Date: Mon, 18 Aug 2025 16:54:18 +0530
Message-ID: <20250818112424.3068643-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds AF_XDP zero coppy support to icssg driver.

Tests were performed on AM64x-EVM with xdpsock application [1].

A clear improvement is seen Transmit (txonly) and receive (rxdrop)
for 64 byte packets. 1500 byte test seems to be limited by line
rate (1G link) so no improvement seen there in packet rate

Having some issue with l2fwd as the benchmarking numbers show 0
for 64 byte packets after forwading first batch packets and I am
currently looking into it.

AF_XDP performance using 64 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
rxdrop		259		462		645
txonly		350		354		760
l2fwd 		178		240		0

AF_XDP performance using 1500 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
rxdrop		82		82		82
txonly		81		82		82
l2fwd 		81		82		82

[1]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example

Meghana Malladi (6):
  net: ti: icssg-prueth: Add functions to create and destroy Rx/Tx
    queues
  net: ti: icssg-prueth: Add XSK pool helpers
  net: ti: icssg-prueth: Add AF_XDP zero copy for TX
  net: ti: icssg-prueth: Make emac_run_xdp function independent of page
  net: ti: icssg-prueth: Add AF_XDP zero copy for RX
  net: ti: icssg-prueth: Enable zero copy in XDP features

 drivers/net/ethernet/ti/icssg/icssg_common.c | 399 +++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 379 +++++++++++++++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  26 +-
 3 files changed, 696 insertions(+), 108 deletions(-)


base-commit: 715c7a36d59f54162a26fac1d1ed8dc087a24cf1
-- 
2.43.0


