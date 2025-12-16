Return-Path: <bpf+bounces-76682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F7ACC102A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAAF43003867
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 05:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797B33506D;
	Tue, 16 Dec 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9IwvEGY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7C41C63
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862803; cv=none; b=Rp0DjnQfcsePuXSPvGkaoYOf8mIwF284BPN8wWDDZA06AII6DKZJF2ebTgSqonYct9+MTvaNsyXKiOqBAo40UhLvLfDWZIxUF8iD/apamaVWgfhVgvT+vtUpoklyXI1safoFcWbrnDsTa5jvo1xfcFOIfawISuTcoRqKIXsh0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862803; c=relaxed/simple;
	bh=+Tmn6vSyTwnDcEGq+qnplLYYi6HzmJ7AkF17KLDtBOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijR8WtLBy2r/VJUq0/I8xPeQ3vopU3GmB6eUp+HU8kEFa3xw+aFcSsIt9KPjywVn0wX1biV8oALPZFZmQim8yh/FyMeOxxzMry5yzYwE6PWQEExSrf3PvcI2cIfjmbL3QxTk4KC4/0znrqEz66OWXEsgs+SyG5ZdQCmXiZfDtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9IwvEGY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0a95200e8so21300745ad.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 21:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765862791; x=1766467591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lcsxypbcAxCRkYeAeqApz/iS3sxlqqcxNrXs4xuNiPQ=;
        b=k9IwvEGYxE2JXa2V8VjGNdisSDFP9HIuja406bGvMJPfvy31YEcWAgpZhBfDw2jWL5
         Tp1xgK+dUjORFtRStu/mIAp6yc1Pg/tP9B0PwGYON0QLAxbvPkwCSMWSZ9fA7x5Czmtu
         N/Dxz2P9FhMjKKyXVipXwfOzdgahdGhTtwsGKdS2cqSF25Mz0odvzlUtEsuBYyBVNAM+
         HFJ4UTDy2nnvpEZ6HtVhGY4AQ+NaJKTiArNj62/FGZddEWRu7D/hqVIzBr3WtR0+XS5b
         DASjcTf/FAQrU0zCGRckt2eUGnhbkzyVdCy6srwKeZs4M7NlnfD3BiCHfNsLwLiVf7gy
         TbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765862791; x=1766467591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcsxypbcAxCRkYeAeqApz/iS3sxlqqcxNrXs4xuNiPQ=;
        b=Il2A24ZnU1dlvUa8M+Mq1guovyPOumDDM3Dsd9phkjZqzicip9wtwL5UDPr/i3bYbh
         7bOkyrWyXjL/5EjubP+q3gwK7Y7qZTBXI62h6TbgSCgc6InKCcZUOpeunctBk1hWu8Kj
         ggVjcu2T0rG9WIaL1MKEpXawPH4NELusTeFfOYGXme7vgi6S2bg4IavfBpQha7Dtl+BQ
         3sEDGJuiEoVFLHGbDAB/thuqqCl3LaAGSY5muzRQEJvdgAmkHwW67d63AZufVMkcPl3d
         ejhsKk4ZqWyUmQj6BHYkb3yoW6DLNzFxab+PbXaU3OeUdTtER+6c0yLILN7Aasva59yk
         ocBA==
X-Gm-Message-State: AOJu0Yw8TgJrGq36lD49ELwGIjw+DHVsWiC7PLVDbBNAohH8AQBB41Tv
	sko82V5eTCfUlNS6LO/YAJUAl7vAntmrh39CIryvjRNZ6asPA1MexpNC
X-Gm-Gg: AY/fxX6SlwC9DPdeIsObaRaU8INbF2NjZoirn5Vs7b5u0RMTl8OdMumCxwtASD1F/7O
	eY+ubENlXnJmGvnyyBHJdzOwLDRcg/rePU8mnn2jPPjT1Im7n5Rt+hrRLBpHxrlU6IxgzOK52ys
	dXRSjLSq0uINTkGlmxFC72gQeV+mRHZ0BzHaR/HWfmviUQmvBN+CRQ3006Fbc1TKpm5hwJxsL88
	Hp37ZaXF5hV++19mo0SyCjgf1Vd60wnFXYWVejf/STtTjNyZPErEWnD3zyr1eBrA2QYGnkhI6Vv
	4Xv1TX60Ukhg/5bj3p3ICqnzGx6Vq6+VgjnB+AHhcXjSMGZsfm//bCyn3xNsWINx/QMZFM0Hoyb
	o3s7xR1/LRGlNVtV4XAV31IPhLnbCEaMHQoq4MsAcUmkfQQW+eFJ6h0Fu6+KhjF+k2T6rd2068k
	O4I4qAN8pmwodaco/4Bbn4QGPxBnsB1fbqmGHtIWUYTY7NHxkL1zb0g8Mn1A==
X-Google-Smtp-Source: AGHT+IH+UuREE2L2oI/f9++eF8O+lPF6GeYoWcFzwmygF3v+yf9Ylf2Yd9qrXd7u9dYHn/0w+8W93g==
X-Received: by 2002:a17:902:c402:b0:295:c2e7:7199 with SMTP id d9443c01a7336-29f23c7b8b9mr145172235ad.29.1765862790651;
        Mon, 15 Dec 2025 21:26:30 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0ced60ff4sm61302145ad.76.2025.12.15.21.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:26:30 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v2 0/2] xsk: introduce pre-allocated memory per xsk CQ
Date: Tue, 16 Dec 2025 13:26:21 +0800
Message-Id: <20251216052623.2697-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series was made based on the previous work[1] to fix the issue
without causing too much performance impact through adding a
pre-allocated memory for each xsk.

[1]: commit 30f241fcf52a ("xsk: Fix immature cq descriptor production")

---
v2
link: https://lore.kernel.org/all/20251209085950.96231-1-kerneljasonxing@gmail.com/
1. add if condition to test if cq is NULL
2. initialize the prod of local_cq

Jason Xing (2):
  xsk: introduce local_cq for each af_xdp socket
  xsk: introduce a dedicated local completion queue for each xsk

 include/net/xdp_sock.h |   8 ++
 net/xdp/xsk.c          | 208 ++++++++++++++++++++---------------------
 2 files changed, 111 insertions(+), 105 deletions(-)

-- 
2.41.3


