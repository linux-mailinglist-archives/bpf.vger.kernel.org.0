Return-Path: <bpf+bounces-54180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D4A64954
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 11:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9B51898C28
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8C238D2B;
	Mon, 17 Mar 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rT/d7l02"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248902356B4;
	Mon, 17 Mar 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206596; cv=none; b=qI5LNtBLoGyRMU2eOVBGyLL3FZ+unVOcze1yyULUDXKRNYvMBv0B6DuIJtbPfm7CR3ZC2bePICX3NRlPPIg7J4SMGma5igVYWjGMsoTbC89IZmTt7z6tTZgRTujmUGGDmSnkIwdf+mRaDkWD4syyuQo6QMkZ6lrdbWojJF95F7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206596; c=relaxed/simple;
	bh=IUObPNRR4NQzu31kLweJs0iKm+Tw8gF+37su5fyiEFE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ooC75wjjiB+rrfoSmIi+W3jgu1YY4paqyUC6dqEwK93/dm3/mHRhaGGKefcRpq8hZw8kjyrqLIOZfRuJwNccx/H9h3AEUeZN6ros9tOSEFbF3U7ZLK4KIJ73OG4ouF/YlI0MIFrNDca4JE/n3d/tLjbIrrY8NQmGFRGQr3Q+w9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rT/d7l02; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52HAFwoe2248052
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Mar 2025 05:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742206558;
	bh=CdL/+PjoujWaXbjx9Z6DltuQ+LmtMfq1I7St4x1lKEY=;
	h=From:To:CC:Subject:Date;
	b=rT/d7l02DwVXTVZQuvKIJ+3ad/PDz83E7BSa7gcBKo2nU+yI6hfuzsSCmCXOBOHmm
	 bDtR3pUj15YvCnsyAkveGhBN9+SZihUJzJs7P+p/P0agV9U3MYU35+qnaCGFiwddjx
	 XXyx9LwyDVSf4SCr3Hx3grzS7ijrmraDOyvt4vSU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52HAFwEU076244;
	Mon, 17 Mar 2025 05:15:58 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Mar 2025 05:15:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Mar 2025 05:15:57 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52HAFvM6036212;
	Mon, 17 Mar 2025 05:15:57 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 52HAFugA019281;
	Mon, 17 Mar 2025 05:15:57 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kory.maincent@bootlin.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next 0/3] Bug fixes from XDP and perout series
Date: Mon, 17 Mar 2025 15:45:47 +0530
Message-ID: <20250317101551.1005706-1-m-malladi@ti.com>
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

This patch series consists of bug fixes from the features which recently
got merged into net-next, and haven't been merged to net tree yet.

Patch 2/3 and 3/3 are bug fixes reported by Dan Carpenter
<dan.carpenter@linaro.org> using Smatch static checker.

Meghana Malladi (3):
  net: ti: prueth: Fix kernel warning while bringing down network
    interface
  net: ti: prueth: Fix possible NULL pointer dereference inside
    emac_xmit_xdp_frame()
  net: ti: icss-iep: Fix possible NULL pointer dereference for perout
    request

 drivers/net/ethernet/ti/icssg/icss_iep.c     | 4 ++++
 drivers/net/ethernet/ti/icssg/icssg_common.c | 9 ++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)


base-commit: bfc6c67ec2d64d0ca4e5cc3e1ac84298a10b8d62
-- 
2.43.0


