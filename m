Return-Path: <bpf+bounces-26145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F289B83F
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 09:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C47A282F46
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACDE2576E;
	Mon,  8 Apr 2024 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g/14daJE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8C28DC1
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560821; cv=none; b=mzl7uZKv8GoyKOfBMWsHA2braGWk2k7Sin6wv5ZMhdDWzpjwtklqC1nc1fEWNlj2oy7eKiL+Pz6kbmdYOkXByLqjnztUh01ashSRgkw78YPrvivCfZasmnYYRniDJTihEsQ5xPRKY2JYF7+0z2DLmHfHB+aH2sEO0yfasnFwzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560821; c=relaxed/simple;
	bh=i1uSsLXWtkljlVD9K5i4/KkLIjH9N0qPb5HbIu0GR0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j1zOVmir1UNgPvgHK1NeZjJiWXrVCw8MqCJrI9Mq/24nEGEKkodZZ9jwm4WQd+XLp3XivSrlY/NhiNENLDEYBvzp9Ecw9MXu70nSj4Ib/d/GLQzNlt6oxJGouuioLsgRJbFIvlTtAYTQt7/GF1Y0qKqN7s6QNZJ2uWl+d57oZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g/14daJE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46de423039so292479266b.0
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712560816; x=1713165616; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6NgflAqowUAu0egVNgXe8ugQun7X39r3CL2uIz1gu4c=;
        b=g/14daJEtIj2AoOLznUn2oKAAJ7MoiWbCohMWwP3tYo0YPSar+L8xnZj/MBSc8fvmC
         Z8ZasBgxjvwc8zXHHaW1+ou/1/0+zFcv9f1b1Wt7vyEE4q7DtylMQsaoO838VKfAbpsP
         GycpHa7sOmakFTRo3k9YqAnYiaxZs303oj1gaLirQItR5Gn6HrFx+dQSryUAgsiDH+0w
         n8EWxLIeXNuuS4yvVIDZFalinjxhrLhbHIV0pC7ge7MEnv/hjPOM/HYFMsC+yhyH4aTs
         k3hukKcdPeXhBRIsDwxte5tCjoYk/3jY/hKlUtKQ+KzkGbS1J6eEyyHBKmLOx0AxbIhP
         6syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712560816; x=1713165616;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NgflAqowUAu0egVNgXe8ugQun7X39r3CL2uIz1gu4c=;
        b=T90DFmBOy+l76xPmPg0G56BrtPuuc665woZOGC3fWHWXH37vVnjPkcnEsJ0Y/PZ9eJ
         5LTcZI84QsmUgkicaCY8y3kYkcFR3pOJSMeOTLD5pE7joFLiT7xnAwCOJtTnQSk27UC/
         1OI+RHHcc3LQukYmEzShHxovd2+jjkcTAqCLRJFDuXGFmtlVWipLPtk08M1Th0W0rX1+
         nvCSNT+hldxsAV2njcAddtxbEWGFLpGuevMjVr9yMpHxWgIooR8CdJXdXv9GrkIT0KVx
         sTbvg1NYT5U7uIOlP9+9gQVrfKCESiovp+7J8Aunmwedgxq8YMtNsSzTq7PXbFJ4Xa5Y
         LGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbCsYNsOwg3KB4pRqWXnMGxa17O1EiAQY3w9Naesy2Pdq2IdONZmsT0hznXYH8dMLvb+qHFl5/yOj4ITpKA377bx4o
X-Gm-Message-State: AOJu0YwcVgB9Hf6DW51IxNcOzGulOUz39+5jaj9X2vDNh38D73TJNmib
	RJm84QHYVG/6+MfEjwX8Lm776b/iGC4Oh1gTBSiaNPRKGtN7hlh81UE83H1p1ag=
X-Google-Smtp-Source: AGHT+IELXUjkW+4uwxz09qQEfbszOo10hIajayl+cqGuPVmiHqNhtXuxaaAtecBt9WYaxZy/VQf6Rw==
X-Received: by 2002:a50:aad0:0:b0:56e:57f9:8c83 with SMTP id r16-20020a50aad0000000b0056e57f98c83mr2481000edc.19.1712560816205;
        Mon, 08 Apr 2024 00:20:16 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640243cf00b0056c2d0052c0sm3738769edc.60.2024.04.08.00.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:20:15 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH net-next v7 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
Date: Mon, 08 Apr 2024 09:20:04 +0200
Message-Id: <20240223-am65-cpsw-xdp-basic-v7-0-c3857c82dadb@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKSaE2YC/42Qy2rDMBBFfyVoHbV6R86q/1FKmJHGjUqsGCu4D
 sH/XsW7FlO8nMc9c5gHKzQkKuy4e7CBxlTSNdfisN+xcIb8STzFWjMllBFKaQ6dszz05ZtPsec
 IJQVuInrlrfBoPKvJ2iWOA+Rwfma/esipvNb9UwcpX1Km0yiei/1AbZqW8+8s041nmm7so07Oq
 dyuw33xGuUy/1dhlFzyphXoAkbQUrwh3C8JB3oJ125BjmoDRnHBhQwuAARAdCsYvQGjK8bGxhh
 oojewZmM2YEzFaK+dBKfBePyN2e82xBUZSzZSEMavWNgNFrZiMMiDbuRBYFj7iduAcU8bqYja1
 mK07R/MPM8/c23pw44CAAA=
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
 Naveen Mamindlapalli <naveenm@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712560813; l=2836;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=i1uSsLXWtkljlVD9K5i4/KkLIjH9N0qPb5HbIu0GR0c=;
 b=MUTibm7kGyAuDtUjnh2ZeNRI/50rwE91Xv2jEKDUpbBOwINm0U9jwGiMHhr5rpzav9qb6avay
 RtcRt/bl/EPBbB0r315Etc3lZuucZjmBRI6ix+LVq29ARmq9sJhRypb
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds XDP support to TI AM65 CPSW Ethernet driver.

The following features are implemented: NETDEV_XDP_ACT_BASIC,
NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.

Zero-copy and non-linear XDP buffer supports are NOT implemented.

Besides, the page pool memory model is used to get better performance.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
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

 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 547 +++++++++++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  13 +
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c |  37 ++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |   4 +
 4 files changed, 550 insertions(+), 51 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240223-am65-cpsw-xdp-basic-4db828508b48

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


