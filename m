Return-Path: <bpf+bounces-26625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E262A8A32A0
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4674BB21819
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF21487D6;
	Fri, 12 Apr 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O1xMdSjQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474F1487CB
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936330; cv=none; b=fgZQF/r2iCkUDpAWLGoVcNLOJSjFJFwtyCaKtE6poj6dTfOEmlgJyvqs2dgpZOe4NQbUHToHhnNkLRgzy6NlACvGqPqONeArLyu0O02Me1hzNfraskerTgDzbesVwMy0A10XehI4gcefD+95yEb0ivGPn3iAqgDK35iX1TSLhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936330; c=relaxed/simple;
	bh=FKKMgqvHByKA4tvc3eA5ffKwH9FrWfmfSY8lLNIiWog=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ugAENLrJ1LThTmJ0BYJY3wtodGjTkhVwxA0eggagfkShvkz5zrWY5MZN6x0JGFo1Gt9yMrEzFqyyMQFVI+8QBl84Lwo8S1T9hrQgEQ3+tziB2dwLiefzJk2GQkF9JI5DlsaLRO6bNqxIvTqmWdo6gc4X0cNHsGSUcnGzOY4gbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O1xMdSjQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343eb6cc46bso669431f8f.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712936327; x=1713541127; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PZpErhXoFLSgcwKLydiKCIqyrzv/osbJWkwgwT5Ay0=;
        b=O1xMdSjQwoUHvRW1ydPKWZqHpGO7AFro/nxnv0Ztanz5XcHzWmzb3KujO+CO7KcfEE
         2fqQAh2pdC/PYCWUVjjMNeguYH33VAJYArT3MGR3/+6D3m8EtalFyrJlg7rdx0HY2TT8
         Y4suxBITFQHxYbXucrfrmcnnFLOabNsSTU3RtSjZoZJiMgjRJneXc0bTnQ46d3k1yt4a
         f74wU3mqFXz/aQUKvEe39hl8wtbRz687KjrWsFN2nIIvb3gQNdv1AHSIDrJ7JVplbA0B
         aG539MzeCL/fMcwxqcrinI3hNGFTrLLjyiJTGb+G3b5VE5cFzqpGGjMVspO82NTkINF0
         TNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936327; x=1713541127;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PZpErhXoFLSgcwKLydiKCIqyrzv/osbJWkwgwT5Ay0=;
        b=bV0Bv4ls3qROgVspiQq3IMCvU7AOkphFnb9ty4/hGVK1xyRnxonXpYDDg4ai54ws2D
         lIBIzbqdji+3QTH87FSlFsGDfuFONSTO0i6sFVYOfH3FGL0Qs6aEjtnfa9VjRViugeVS
         ewPGbUlKGbD1YKMnZr0es6jcy9Swx1lX4L+fmeom+sK7ZypcCKTz7kXoTmJiRStRsDGt
         /L9j6ul746dbESki/WWDF8X5EInZj3Al17qPDV2DEFXx6+iq2VyfEUNRcv46czbf9Fwz
         6nk+P5P45JQ9mYeZfv1riGl/wwjrtA5nxovBl3oxyKndx/HWTgc5itSVCU7J4/u7GtBu
         XpEg==
X-Forwarded-Encrypted: i=1; AJvYcCX6KS6r/DDfUFRSV6syOOsK2F1pHSGSOz5r4AcW0uSmg49xbx1PFRnZsX55CHIF4yGJQBQA8MvxaxgKKKwe8gOBoVPQ
X-Gm-Message-State: AOJu0Yx4/VAB1zYOVuLv0FmJlN4e0I6ChAJJl8XIfDsA7yMbCb6BVi1w
	g0JYr5gnCMeOry7P7mmxISPWFnIpvu7J9voxQNj/sGJR2Zyp8D7Uq/iK9/oqnQA=
X-Google-Smtp-Source: AGHT+IFvHJ+ngcqc9RhfIXSS90heNPGSCkUVEJnwKOCeh0icy2zvFyQwZwEFve7IGLGy1/ZjqkhBHw==
X-Received: by 2002:a5d:6082:0:b0:341:c589:8aea with SMTP id w2-20020a5d6082000000b00341c5898aeamr1589834wrt.63.1712936326779;
        Fri, 12 Apr 2024 08:38:46 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id k9-20020adff289000000b0033e45930f35sm4545791wro.6.2024.04.12.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:38:46 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH net-next v9 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
Date: Fri, 12 Apr 2024 17:38:31 +0200
Message-Id: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdVGWYC/43QzW7CMAwH8FdBOZMt30057T2mCdmJOzJBqBrUg
 RDvvtDbpmrK0bH9y1++s0JTosJ2mzubaE4lnXMt+u2GhQPkT+Ip1popoYxQSnM4OcvDWL75NY4
 coaTATUSvvBUejWd1s74SxwlyODx3v0bIqbzW+f0JUj6mTPtZPAfHiYZ0Xb5/Z5kuPNP1wj5q5
 5DK5TzdllyzXPr/Rpgll7wfBLqAEbQUbwi3Y8KJXsL5tJCzamAUF1zI4AJAAES3wugGRlfGxt4
 Y6KM3sJbGNDCmMtprJ8FpMB5/M9tNw7oiY8lGCsL4lRS2IYWtDAbZ6V52AsPaTVwD455ppCIaB
 ovRDitM18B0lQna2y54FSHiCuMbGF+ZQRsl0foIov/DPB6PH37djukcAwAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Naveen Mamindlapalli <naveenm@marvell.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: danishanwar@ti.com, yuehaibing@huawei.com, rogerq@kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712936324; l=3692;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=FKKMgqvHByKA4tvc3eA5ffKwH9FrWfmfSY8lLNIiWog=;
 b=kwII0V9/2FbZDaTT8w+6oNfTEwAwUdOycaJSWRYmzp5yES3hHPlZUB8rpnxgLZj6mscBbWIPZ
 z+FRe6YDvzgDTx5m8F8cVA6A+X+ILKW6dCkIu4bWnfCN8UUKFssa5lV
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds XDP support to TI AM65 CPSW Ethernet driver.

The following features are implemented: NETDEV_XDP_ACT_BASIC,
NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.

Zero-copy and non-linear XDP buffer supports are NOT implemented.

Besides, the page pool memory model is used to get better performance.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Changes in v9:
- In k3_cppi_desc_pool_destroy(), free memory allocated for pool.
- In k3_cppi_desc_pool_create_name() function, remove unnecessary
error messages on mem alloc failures.
- In k3_cppi_desc_pool_create_name() function, move desc_infos alloc
forward to leverage pool_name freeing in gen_pool_destroy().
- In k3_cppi_desc_pool_create_name() function, remove unnecessary
'ret = -ENOMEM' since ret is already initialized with -ENOMEM value.
- For rx, do not build the skb upfront any more, Instead, give the page
to the HW then build the skb once HW sends a completion.
- Link to v8: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com

Changes in v8:
- Fix some warnings reported by patchwork.
- Link to v7: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v7-0-c3857c82dadb@baylibre.com

Changes in v7:
- Move xdp_do_flush() function call in am65_cpsw_nuss_rx_poll().
- Link to v6: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v6-0-212eeff5bd5f@baylibre.com

Changes in v6:
- In k3_cppi_*() functions, use const qualifier when the content of
pool is not modified.
- Add allow_direct bool parameter to am65_cpsw_alloc_skb() function
for direct use by page_pool_put_full_page().
- Link to v5: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com

Changes in v5:
- In k3_cppi_desc_pool_destroy(), free memory allocated for desc_infos.
- Link to v4: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v4-0-2e45e5dec048@baylibre.com

Changes in v4:
- Add skb_mark_for_recycle() in am65_cpsw_nuss_rx_packets() function.
- Specify napi page pool parameter in am65_cpsw_create_xdp_rxqs() function.
- Add benchmark numbers (with VS without page pool) in the commit description.
- Add xdp_do_flush() in am65_cpsw_run_xdp() function for XDP_REDIRECT case.
- Link to v3: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com

Changes in v3:
- Fix a potential issue with TX buffer type, which is now set for each buffer.
- Link to v2: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com

Changes in v2:
- Use page pool memory model instead of MEM_TYPE_PAGE_ORDER0.
- In am65_cpsw_alloc_skb(), release reference on the page pool page
in case of error returned by build_skb().
- [nit] Cleanup am65_cpsw_nuss_common_open/stop() functions.
- [nit] Arrange local variables in reverse xmas tree order.
- Link to v1: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com

---
Julien Panis (3):
      net: ethernet: ti: Add accessors for struct k3_cppi_desc_pool members
      net: ethernet: ti: Add desc_infos member to struct k3_cppi_desc_pool
      net: ethernet: ti: am65-cpsw: Add minimal XDP support

 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 659 ++++++++++++++++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  13 +
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c |  46 +-
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |   6 +
 4 files changed, 623 insertions(+), 101 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240223-am65-cpsw-xdp-basic-4db828508b48

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


