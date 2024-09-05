Return-Path: <bpf+bounces-38972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F378296D163
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AD31F22672
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A723198E84;
	Thu,  5 Sep 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T3RrpA8g"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2A194A42;
	Thu,  5 Sep 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523656; cv=none; b=GUW4aicZJZ1l4HbtVVMMgI6+P2vl3+pVkbCD7mSxbr0foAiONd214slLvRVQi5eRtI7wCVTm7MFLN7s8xL/aj5sbETA2ZLt/O6sGIIapWvNwOM4FKFwPPKg6CKBvN6FHQltyEu3vytJ6tcaYsbCUB77ltGZadueXCSiM6PIO5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523656; c=relaxed/simple;
	bh=xAVcagYKeai1L5aDpWrNMHA0kV8FWN6WneX4kRW678s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UJiday2FpQYXHbnru19LuHfw1gvzcr1X2uDlbPN/lqYQQW5UF+y34htdg4eOUiiXevC36u8UselxArpA2DQkyhVy1B4RanVl7F+xPP+C2MTjUjMWqjfEDcziiZ+zxIzCGDBedjtnpMCGVImdG6bSO5mLRSzi+67g8q7QWQqnPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T3RrpA8g; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523655; x=1757059655;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xAVcagYKeai1L5aDpWrNMHA0kV8FWN6WneX4kRW678s=;
  b=T3RrpA8gAJ+OCJmHHM3IkrvaaJi/R6a0JPOfqMDk7P+Kz4K5riUzosma
   hT+1qA30iuGZZag8tt1/757gyr8tiXYarwmLo/akljfR13MEkzO/g2tpd
   BbZfdohhZ+Ak1ngFalR0VHfOq38JtJjGQBHa8ZJPEorB+2lyfd8v6+2Xi
   eq0fl1+PfRpwCxcXsfs0x3LxQ5GUlVvGHzQprJJKwsavRapcd2ML5denz
   p+zbeXlExFDBjAvz2uxCV/si1h/MEAa5ltCbFW0tIer1ojqZcqAOuLPuB
   h/3ef20HlxIsbSkGzwtRhtWlDBLdlTm03D0W3/ubcq4icetc5+jQ+kZXD
   w==;
X-CSE-ConnectionGUID: rESGLHboTQ606MdHMphuVg==
X-CSE-MsgGUID: AJ5fZx6XSVaQmx4VSPL0qw==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="198790964"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:06:54 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:06:52 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:29 +0200
Subject: [PATCH net-next 01/12] net: lan966x: select FDMA library
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-1-e083f8620165@microchip.com>
References: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
In-Reply-To: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14-dev

Select the newly introduced FDMA library.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/Kconfig b/drivers/net/ethernet/microchip/lan966x/Kconfig
index f9ebffc04eb8..f663b6e12466 100644
--- a/drivers/net/ethernet/microchip/lan966x/Kconfig
+++ b/drivers/net/ethernet/microchip/lan966x/Kconfig
@@ -8,6 +8,7 @@ config LAN966X_SWITCH
 	select PHYLINK
 	select PAGE_POOL
 	select VCAP
+	select FDMA
 	help
 	  This driver supports the Lan966x network switch device.
 

-- 
2.34.1


