Return-Path: <bpf+bounces-61833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19BAEE15A
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B5B3B1AEF
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EB128EA67;
	Mon, 30 Jun 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3+4wMAg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2128E5F3;
	Mon, 30 Jun 2025 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294565; cv=none; b=GH+Mo4iCYuT5DmszuskzecwH1E40Na+RTI4aoxCfXC3/kxA5RZWTDBuJEcUyWmPosf68OJwumuM+xVZurpUE6ZK9inEL4mWbuKw7s5g2xVdRfHATpo6CNEXoVH3rfduPu77t5mkQXk6LiAXHZYQ8ODVtY2qnrVE0Y8qBawzAqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294565; c=relaxed/simple;
	bh=6qMdcAVrzLINFWGhEHKx2bOfsr29+z1VuJLunXEJhWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BneZ/4pCdU92QHq7RRTtRp+E2Wl8oM0rDBPz39nxP7mgEZF7wL9SURpoYBpQNUAZB+aBt13JGkk+zmDr0cFJh0L+aOU2u7NkDcTGPbhbkEtfsH2dQiYjcUHBsBadyDmYipnl4bLg8uesqyFtyJ74RQ51jPPHlXHd0AJDNvOhvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3+4wMAg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2352400344aso41498375ad.2;
        Mon, 30 Jun 2025 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751294563; x=1751899363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5aofoMvYrH1y9lMP9RzucrOBhds6qNg3gudKz2Vjufs=;
        b=T3+4wMAgn8Fn6meJFWEjeKz0hEq6dyWbjL7uxMTj8qz9bEJzPxKzxJXKUNmGDUNl6t
         Hf7JnD1Dpha4TDwJT7SrQo4PjJyUVjR2ZOlLZdyvwIQKNyh8PA/JulyVLP8MKRKdgXUJ
         jeJc2IBj8cZrxtWiJM8mbc0JmIAUqX+3is0Yef69x5zI9nzk+Cl8B8coLtftlxY5ovZa
         fhms6cYG/JxeGQgvabvuJ5cQr252YLcVJhLnHC155HBDDvCmI7fZvEoQ2wNMXU6xZL/2
         VFo0yuIjTV5/yCHlIY8hHZ/m0fdhoaAuZ2nIAqahtgWi9GZxIOhUJI38ed3NdTtnmpSR
         CpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294563; x=1751899363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aofoMvYrH1y9lMP9RzucrOBhds6qNg3gudKz2Vjufs=;
        b=g+uDx9OGz6RqEOjqEwPrCkaQdPuebIKp00eKHZ5ou+n6m4u7KtLFfRoLfoDZgx8zNf
         qNiOf9er2JnM3YNADBSYIKPYrakEya5mPNrSkbc+kscLBsPrqyE7i/NvtV6z1SNScO+8
         rDGfetS3q4+mTgmctLVy95chXHVdUncd/lEM2yyNbKUBpG89Sv8ytoxEbFy7nw8OANes
         IC4cd3IHvwiJv6fZNH7g6UHxUgsRaPAJOnS7z8N+iulWOa2wophD5NMXiSRXZZt7n43u
         xtncqZlByxtOQmbG9uEdEcUKTHYOrE8m8jlHHtlnG5w/GvZIvG4YvXfhJtqnojczCCpN
         hmoA==
X-Forwarded-Encrypted: i=1; AJvYcCU0zMvROY2J4Z8gXHlKLtyoZY8IzKjRijPNW+7BIQjbULEAZnB0/HL7qUBnaPw76WAZ480=@vger.kernel.org, AJvYcCVPCST7bnjBmTLnrJz9Znax/NutGyLAFho9C92vFGKSeBIhFPZ8irKmpaMajxTHcfqz/Ib/uAffoVSEhyOK@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTvMr47kJQrZ0pjaJIKa5JqUdM02KlXsLPG76qpTgEwTqwd0r
	IXN0RdRqlk3163PVpzvKYXv9rio8jes9sbdp/bl6H3Krr9lP/xA1OpSB9PNtqw==
X-Gm-Gg: ASbGncupr3WFGIcmnN66cvssFWKpUdDDbaprwgN2KyVigZSWUZ9rk1ZVFhKF4K7UadC
	0vQoaFLeGk8HjPlWzFk5f++Xf6JnywgwZLmV80yKBiNBJnZK/ZsRmEqJX2xsi6474WE5swWInqu
	eGHVLdX0aMbOEdxemak0PK13/nXmgvLdxk068i40iJ2UdjExQkOH3DSdUtw81d8w2RgND4mdbd+
	B//pnvm9etq56ddEe2fgi7fo1ZSrbJRL9YzLIWDasc/30abM0bm1uVW1eztBtnreN+FQHkia73x
	2QwftZLapSiMcf5iulJg+mohEogAf0GMXz6MXpJi9QpB27oRhStvYcgB6/5H85G8IwjlaJYB2Kj
	H
X-Google-Smtp-Source: AGHT+IH7KkUfeVZi1PbvFQWZ5RQ3dxQDhFjmunArM3SrATO1+z5mke2EDZHIxwCOZsltxOQabz5ffA==
X-Received: by 2002:a17:90b:3f0b:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-318c926ca4emr23469190a91.33.1751294562884;
        Mon, 30 Jun 2025 07:42:42 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a270csm9170017a91.16.2025.06.30.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:42:42 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 0/3] virtio-net: fixes for mergeable XDP receive path
Date: Mon, 30 Jun 2025 21:42:09 +0700
Message-ID: <20250630144212.48471-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series contains fixes for XDP receive path in virtio-net
- Patch 1: add a missing check for the received data length with our
allocated buffer size in mergeable mode.
- Patch 2: remove a redundant truesize check with PAGE_SIZE in mergeable
mode
- Patch 3: make the current repeated code use the check_mergeable_len to
check for received data length in mergeable mode

Version 2 changes:
- Move the check_mergeable_len helper definition to the patch 1.
- Remove patch 4.

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: ensure the received length does not exceed allocated size
  virtio-net: remove redundant truesize check with PAGE_SIZE
  virtio-net: use the check_mergeable_len helper

 drivers/net/virtio_net.c | 75 ++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

-- 
2.43.0


