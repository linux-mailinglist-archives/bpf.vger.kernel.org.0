Return-Path: <bpf+bounces-65334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B42B209D7
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6167B3CC6
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE572DC34A;
	Mon, 11 Aug 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcUp2LTy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1802D8396;
	Mon, 11 Aug 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917966; cv=none; b=KQLIN7n+0S6TtxH1kxO9jZqGIJT9KSGVP5D7ZPZ6Os9ei2DWxf9+fY/eC1YhnTVpviBjj1Sxx1BKdLKyngdeK20cO8gQnr4S3o9WDLiM67mFjpqRD4TKY1wpzaG3IHSaZRKRRqCA4DqsDv9szQb0UOc5+H0TTAHDrH4qG0GSLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917966; c=relaxed/simple;
	bh=vvPCKyJYH0XXDpnBfsmDzTunKOUXZ5y1vWJq5EqeV5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZBVuN+8KMdTX3K+Q56baHOwIOuB6PrpxMYiiDEHVrYiuaHxLr4Q59UZlnh7NRXRJxwDJragzkFJtOpBxNiw5+O6Q7i7NgiOn7plKIa0ZWfTqWvplCVK0e7XUcSRuNSv/TDN3oNSqdLq0UcJZNzbvS58ajPfn0x46/c6a76BiuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcUp2LTy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bfabdbef5so3531415b3a.1;
        Mon, 11 Aug 2025 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917963; x=1755522763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVIMJg5R5sZv5Lr4Rz6ju2tVpZJjLM1IsEH4KNqRx5w=;
        b=NcUp2LTyjsn7QwXnv2ClJVdQpCG44+Szo8lwYeEZJZMGBVj8ae4b5uSMA8t1dCi6cn
         SiqUP36alg+zGw+oJmJn3I4VKUBjNQ8RGT4bAG3XADJAcWbOWsMGwE2EqOBZggRRrXvZ
         4JVACq/moZPEo5BadhwR973immCAawI5XUnQQiCpdhkA0uIimzi+GsPbp8APPjmqxwqX
         snTl+HA/N2/uReYk+DIcQF/7E7/H6lQV4HnXU3QPobKobJZNowjCKIjqrBjSu7h8FBhF
         G+/9T3Im7RFRG2esr4Mw45yBD0CCz4yOV0oZjdKPQvIeYaSS0LliILtuo7BqGdbVX9a9
         atEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917963; x=1755522763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVIMJg5R5sZv5Lr4Rz6ju2tVpZJjLM1IsEH4KNqRx5w=;
        b=k4Xr0FM4r784P4HAJ+AcrSkuZzTrgWIQzAdmdwtOFud8En0Wv1So9avLPopvs4kdx8
         bvF4GbmmFNZHaweO8KdTL8BW3TE1Hjh4x4M7wvEeEZQb63XQnf+i/G/I/N4h8WjDB4we
         w/w2kBD2dBTQSecs6+pbjG9BWEhYIdyQqUaSBwDIHszs39yWvCnTkyD7vnGyRl16PPO8
         dHuF+oiVkHXuIwAciwcHdBmTmhQRPpOYN72daSr1MiAdXsKTVuX5fYgX5S/zi6ikFvPX
         RNz3LXCWlMhSfe7A1Csx6oVIXpXaQkahOwxXPBHipWxxBlxH17A8AlXH00uXHFagbO5w
         DRnA==
X-Forwarded-Encrypted: i=1; AJvYcCX+uKZkDoNSeC8xnqUUoE01Bh6SZ9mmXAaBujetrXW5uoDpIW7etC8L+97UFA82JViu/DaV6dE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+IPSgYHwWt0E2xey0ons/DFoymPk03uNN6giD02qngOAxQuA
	mjZcC0SCXz6ruXWQoolB6vsILmyUN4kul5lKWpyUjU0YaWah6SMqOx6s
X-Gm-Gg: ASbGncvTi+EcrZ3XPpdoO5TpPjcsftug6Mmg2jXU+8SKU4syKYrRjMuQGfbJpB05R7T
	E7tM/mpQRNblVxl9LSrYV0DLR+7nSuzL3ndN5wqhDGeNj9E929BL431iotowd4LhEXYWyD+oCCD
	ndXWy58RG32CbTSP53BJxOdUdZ7K+mmE6k+vGR768RWvhrToLe5FdFTl9RPGktp7GEtk2QgJf0u
	p0SbbT7am3rUYmsHo7KP1e3tRraVuZid6xiRGXfz16qV8nnbfUfYLmk4Z/ZP2siXc7H47xpeXt1
	E/G5tveIFmG+5GKjW4kUTyI10AN2OtvwWZSCiWINNc3PvNdwCRN1Jl8HemknfoYBoaUZQtE9y6N
	c10qZH2BKOmUpiZH9GyilWyq9npsOCpK1NJmDet8CkMc857JWLW9p6cb/2NfeWHqPqOYJLg==
X-Google-Smtp-Source: AGHT+IGj8RxFoSvUsZve69ZQuIYiRRenRgHRbybWFNyXSov1uJAlVeUI2OTJA8QSbj5kZ7XGKat7Og==
X-Received: by 2002:a05:6a20:6a1c:b0:23f:fbb1:c229 with SMTP id adf61e73a8af0-24054d788a7mr17616063637.0.1754917963466;
        Mon, 11 Aug 2025 06:12:43 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c46a05464sm8227069b3a.96.2025.08.11.06.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:12:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] xsk: improvement performance in copy mode
Date: Mon, 11 Aug 2025 21:12:34 +0800
Message-Id: <20250811131236.56206-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like in VM using virtio_net, there are not that many machines supporting
advanced function like multi-buffer and zerocopy. Using xsk copy mode
becomes a default choice to support bypass kernel feature instead of
resorting to DPDK.

Prior to this series, zerocopy mode has a better performance than copy
mode. But now, the copy mode outperforms zc mode by 12.9%, which was
tested on ixgbe driver by means of xdpsock.

The thought behind this series is to aggregate packets in a certain
small group like GSO/GRO and then send them at one time by only grabbing
the tx queue and disable bh once.

Jason Xing (2):
  xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
  xsk: support generic batch xmit in copy mode

 Documentation/networking/af_xdp.rst |   9 ++
 include/linux/netdevice.h           |   2 +
 include/net/xdp_sock.h              |   2 +
 include/uapi/linux/if_xdp.h         |   1 +
 net/core/dev.c                      |  18 ++++
 net/xdp/xsk.c                       | 135 +++++++++++++++++++++++++++-
 tools/include/uapi/linux/if_xdp.h   |   1 +
 7 files changed, 165 insertions(+), 3 deletions(-)

-- 
2.41.3


