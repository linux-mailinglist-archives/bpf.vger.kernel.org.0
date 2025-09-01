Return-Path: <bpf+bounces-67091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51840B3DF87
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E1168E11
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8530FC19;
	Mon,  1 Sep 2025 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kIMLoz+i"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A118E25;
	Mon,  1 Sep 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721008; cv=none; b=MIT7qlXh+8t3jOeGsi9xnh6KgAxY33wbpN97Q5ch33EWZ7EvM8H/1+ml6q8ZMAXMaKgsIZ9a6uN9vy93ejIXG9qpWgDx6wptgFwcSYhfzIWZb4PrBixO4RDEkJGOXv/stawixRYMZ6GCVsiSNtf0hETKAl+RAWtDsaHZurLl2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721008; c=relaxed/simple;
	bh=of0Ygp/XsIOF5t7a6dKwKRYgiQJcI9K2m1aqKST2HEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nGF/eSCqBfQ/BJfVN+Ht7qXf96fzqnYriLTtOd0xXI8wkqu+pEIDe6siwt0s8s/kG+raemOUS0FCEFrMjhOOR72Oj5EEf/YUl5uKhHSOw+XQBP3PMqglgdfP8wyw6TgRB7hOUK8Zo4Z6XJd8eSJhWIiXynDMTh4ja9TrGDkYAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kIMLoz+i; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581A2Zdn2750339;
	Mon, 1 Sep 2025 05:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756720955;
	bh=AYD7oJiYVhwC2GJ9A4w87lRcuZgiRa3/UfxKJj2oMGM=;
	h=From:To:CC:Subject:Date;
	b=kIMLoz+igdMEjesfDK+GAmAWNZkzqzacqu+ZXrK34Y5LyiMm5WIjcBNIkdoeOeSjx
	 Bh8vd16N9vgdQWSZH7s8T3T9mGkdENpaf+U/zGoqHKkRgrnFbmyNHwxtz91XI+sGwM
	 Yle6LBdI7J4SSpzF5ZC/PXDL6/PhvnKCDdRfQFv8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581A2ZTQ1899681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 05:02:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 05:02:34 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 05:02:34 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581A2YwA159723;
	Mon, 1 Sep 2025 05:02:34 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 581A2XwK011082;
	Mon, 1 Sep 2025 05:02:34 -0500
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
Subject: [PATCH net-next v2 0/6] Add AF_XDP zero copy support
Date: Mon, 1 Sep 2025 15:32:21 +0530
Message-ID: <20250901100227.1150567-1-m-malladi@ti.com>
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

v2-v1:
Posted the series from net-next. This fixed the issue reported by Jakub in v1.
v1: https://lore.kernel.org/all/20250818112424.3068643-1-m-malladi@ti.com/ 

Meghana Malladi (6):
  net: ti: icssg-prueth: Add functions to create and destroy Rx/Tx
    queues
  net: ti: icssg-prueth: Add XSK pool helpers
  net: ti: icssg-prueth: Add AF_XDP zero copy for TX
  net: ti: icssg-prueth: Make emac_run_xdp function independent of page
  net: ti: icssg-prueth: Add AF_XDP zero copy for RX
  net: ti: icssg-prueth: Enable zero copy in XDP features

 drivers/net/ethernet/ti/icssg/icssg_common.c | 401 +++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 379 +++++++++++++++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  26 +-
 3 files changed, 699 insertions(+), 107 deletions(-)


base-commit: 864ecc4a6dade82d3f70eab43dad0e277aa6fc78
-- 
2.43.0


