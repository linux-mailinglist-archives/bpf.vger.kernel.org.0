Return-Path: <bpf+bounces-55933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC7A89773
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A457A2B0C
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92A27F750;
	Tue, 15 Apr 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WSMbMa7b"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0C1EDA24;
	Tue, 15 Apr 2025 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707984; cv=none; b=PqdbJMKHrk/chw4349ldQ9SnqyyKbrPAskttrNsGLnnXjy925eEFzEg7wTNJZHfVIfk9RNphziiXev2bkOKFgzNc7DppU2a9WDzfwYgvquk0m56F+RVuGrhUTmB5dnSE0RKHGvX3a+ZFHYN/LP2O17wl3lRFk+VzERRVQlb3FJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707984; c=relaxed/simple;
	bh=7WDKU8Ma/T9AoYhRllnGZ3XEGWfy6pb3mSJUfmtm2LY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ikW03aFwqkFYXmeMeFFbgh+k+wPCYI2HmI6+wvoys2HF7/WME6pP/clcZfq7wiO3u9skdx7zIaQW1hHOCftVs7efGKKAbZux/X2T8Sv5M1BScXANARnPRwcrFl2ndPh1Z1I4tVrgKkEKnsoH3HF7hAxU1mrMqfJexGWud0SMbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WSMbMa7b; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53F95mjt2436534
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 04:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744707948;
	bh=h5kvh+PJBUQXNkN1L2HdGd6JfOeVgSq/YRDXpDabNaM=;
	h=From:To:CC:Subject:Date;
	b=WSMbMa7b0h3v0Hco3CILMum3NOdurCJz16oklFdlcZ7Cm+kcrIFHCNFYaFZv0saK2
	 uTRzzMSqFyv2MFSMVdukIgWbWM62rhtmze0N14MitXl1ijgb3tMdAhxlQH23/kR69O
	 X4QqIi99fLWsdevDR96ip4rO6uOHJgeMXz6AIkLA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53F95m2l102143
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Apr 2025 04:05:48 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 04:05:48 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 04:05:48 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53F95mtF080138;
	Tue, 15 Apr 2025 04:05:48 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53F95ki8010947;
	Tue, 15 Apr 2025 04:05:47 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <dan.carpenter@linaro.org>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <richardcochran@gmail.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v4 0/3] Bug fixes from XDP and perout series
Date: Tue, 15 Apr 2025 14:35:40 +0530
Message-ID: <20250415090543.717991-1-m-malladi@ti.com>
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

This patch series consists of bug fixes from the XDP series:
1. Fixes a kernel warning that occurs when bringing down the
   network interface.
2. Resolves a potential NULL pointer dereference in the
   emac_xmit_xdp_frame() function.
3. Resolves a potential NULL pointer dereference in the
   icss_iep_perout_enable() function
   
v3: https://lore.kernel.org/all/20250328102403.2626974-1-m-malladi@ti.com/

Meghana Malladi (3):
  net: ti: icssg-prueth: Fix kernel warning while bringing down network
    interface
  net: ti: icssg-prueth: Fix possible NULL pointer dereference inside
    emac_xmit_xdp_frame()
  net: ti: icss-iep: Fix possible NULL pointer dereference for perout
    request

 drivers/net/ethernet/ti/icssg/icss_iep.c     | 121 +++++++++----------
 drivers/net/ethernet/ti/icssg/icssg_common.c |   9 +-
 2 files changed, 62 insertions(+), 68 deletions(-)


base-commit: 8c941f14a694b40a91d381e77bcd334622aa7196
-- 
2.43.0


