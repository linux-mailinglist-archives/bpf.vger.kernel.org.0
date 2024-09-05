Return-Path: <bpf+bounces-38966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FCB96D14E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6489CB248D7
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294AC1946B9;
	Thu,  5 Sep 2024 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bM9At9ZT"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9E624;
	Thu,  5 Sep 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523635; cv=none; b=A1h15CnuShQF5ymJrHalSwlMnXr9PQYtX/BCOcLmjtoYSBHX5wZzUDXHqCC0AwGJwis1NHj+xFpZWzOl6joRoyZTG4VSpKFzcrcJjakszs2XXflTD9NqGNSDwJnK2TeE4NZnGZkJolhAziDDBBTphTJy58BQud9Me0dKtZVvBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523635; c=relaxed/simple;
	bh=9/2NK3fiU5FVn7kEatxMhteu1DvnEpCUVjmCvWlytZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aUZMx0Tj6+7MScuxz2lXMmNgcdk5doOzbG9BVh3dzflbKAJd1u3M/mwhrshMvpUKRLxwPnqcB6XPSPSGcnC6Q6lU1PbXdtZtyfl/Fx6rkBz0dWVpA20gbkoKTEsoTXXqilcuQ1baya1p78rfihiazlfqevxf1AJFds0WYSctvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bM9At9ZT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725523633; x=1757059633;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9/2NK3fiU5FVn7kEatxMhteu1DvnEpCUVjmCvWlytZ8=;
  b=bM9At9ZTsKTCTpo65cCA9YMddZxY62U/1sKOvbj4v9rwLqLobZ/REhcT
   YQLy01ln63TnNg/Id5Y4AJomoI9z83qw9XeyNEv/hLUJHzOE1rNys7Cak
   ffUUMVda1kIz1JrVKasR/EkLhgQN/vOMpsDjmfYyJdMr3aF1xm7dMZSVz
   yB3dDFu/8C7XTaaWY0nN2opGimGY+k2JaNadUZ7zfCxPYDjX7pkuNBkwV
   xaGs/FQKLvv/pF7LugQFN24f2P+0hCjLDFwWtBMoWuC7COnJ1yflQ7u/9
   imLAsltKZZXTsysmpW8ykIPEisnPgzYS2lkgAZBez4oj6onXkAZ+0AS80
   w==;
X-CSE-ConnectionGUID: un5sTwBcTQSB1/6lZ6FYYg==
X-CSE-MsgGUID: nWdClQQlSd2JzQm/EI25ww==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="32000381"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 01:07:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 01:06:57 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 01:06:55 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Sep 2024 10:06:30 +0200
Subject: [PATCH net-next 02/12] net: lan966x: use FDMA library symbols
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-fdma-lan966x-v1-2-e083f8620165@microchip.com>
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

Include and use the new FDMA header, which now provides the required
masks and bit offsets for operating on the DCB's and DB's.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/Makefile       |  1 +
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h | 10 +---------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/Makefile b/drivers/net/ethernet/microchip/lan966x/Makefile
index 3b6ac331691d..4cdbe263502c 100644
--- a/drivers/net/ethernet/microchip/lan966x/Makefile
+++ b/drivers/net/ethernet/microchip/lan966x/Makefile
@@ -20,3 +20,4 @@ lan966x-switch-$(CONFIG_DEBUG_FS) += lan966x_vcap_debugfs.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
+ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index f8bebbcf77b2..4d2aa775fbfd 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -16,6 +16,7 @@
 #include <net/switchdev.h>
 #include <net/xdp.h>
 
+#include <fdma_api.h>
 #include <vcap_api.h>
 #include <vcap_api_client.h>
 
@@ -76,15 +77,6 @@
 
 #define FDMA_RX_DCB_MAX_DBS		1
 #define FDMA_TX_DCB_MAX_DBS		1
-#define FDMA_DCB_INFO_DATAL(x)		((x) & GENMASK(15, 0))
-
-#define FDMA_DCB_STATUS_BLOCKL(x)	((x) & GENMASK(15, 0))
-#define FDMA_DCB_STATUS_SOF		BIT(16)
-#define FDMA_DCB_STATUS_EOF		BIT(17)
-#define FDMA_DCB_STATUS_INTR		BIT(18)
-#define FDMA_DCB_STATUS_DONE		BIT(19)
-#define FDMA_DCB_STATUS_BLOCKO(x)	(((x) << 20) & GENMASK(31, 20))
-#define FDMA_DCB_INVALID_DATA		0x1
 
 #define FDMA_XTR_CHANNEL		6
 #define FDMA_INJ_CHANNEL		0

-- 
2.34.1


