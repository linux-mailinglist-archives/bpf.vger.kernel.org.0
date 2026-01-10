Return-Path: <bpf+bounces-78480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FEBD0DD8E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 088C03038336
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A372BD5BF;
	Sat, 10 Jan 2026 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FntSP08Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF125771
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079126; cv=none; b=b7oGtUDHDLTw9BJHClkHnv6TEFzcFrA4Ki2uEJ8+6Z+92Rl6cs1atPa/W6GjnOdc2j/I0oFHztmznz2UShZgDGQC2KwDDz2xCDHkVPvDsvD8QxYlc109xb25Q7dU7Txwq6qpxVL9pkVRODGXOKrC6g8wY5IZvoEL9Cekvk6+5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079126; c=relaxed/simple;
	bh=YpbZsCPgUtK+YNOWaJpwHQw8D9O6JEbSkLrjqbbRMrE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=impYEsGJimNQTLkAW9BvDAgATReRvcg+SaX1uWZ++RXdzoWAm/qZK2khf66QAcoLx+FcQGWZTur4Q54+0DjBYEU0rjLo94512y7miiKpP5DLZG+E33QfcsHoAbUoQ/7LyNpnG1r5W3244JE/8lt7BRZrQ2Z/U7n3Otg/3bYbndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FntSP08Y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8706ce18c0so31152866b.2
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079123; x=1768683923; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lC30p+B2g5PX/MfNZDYtTYpmlqLfqwjvQthF+EF4ADY=;
        b=FntSP08YwvxcL0BuOnxibKPqK84pB7ihoMJzmQH0NfzP5OrFS4Vx827bKMY71PWFbE
         D9zkL7vxopmNgz2CbWVlMs+s77A2Ft9SULIlpLI1Mpg3BXH5hk1WpozX5IAsTJfKAoX4
         1G4BySACKv3GC0061mMdeLOKkALzcWCptp/d6BXD4nBBrMbD1k4VH4q5DXTUj0OANbTM
         QOFbFcsBmHtunzhHuZg2G5F18GLya46OO9NpaOvkOlnuvDzbqSAtWmNpEDzAhB9oK4Zn
         ROAwi/1NDc+0dqcREXrNIguwWiw3y6VE7RQr3C/NK6Tf13IHsfp80scRs1x/pKvdj4h/
         vpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079123; x=1768683923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC30p+B2g5PX/MfNZDYtTYpmlqLfqwjvQthF+EF4ADY=;
        b=Fp/SgIRPmbMIrw7gxhD8JEoBGexSqKDqdRo2cf7OFXKeabkNiK8f2mffSYutD/uScW
         BdhnbhNI+mrnIed4S5Vh33rWe4Do7HfywPX0GXxS8Voi75WRe4RZB0odZXLsDw6CudlQ
         qxr7EWY92S2Ek/K6AJFqWkTAtv8etn/s4OM7pF3NPc8mHqsXFG6n9tocKwUNFmNWZLHz
         YtvdIk9vgOY65bs8MWcN9S9hyOPxckayQ+AuEO8NqughQ9SfeW54tn8NmNOQgUYhtQac
         eU7v9FnmtwZL2X/dNUxnOrpPtJ8csaLqdCpQJ+aAWWGLk7tAJlDji8VKI3TKuaOCRTCk
         +LmA==
X-Forwarded-Encrypted: i=1; AJvYcCU9v8AEAQCyMgioYFh29EvPq072DZDZ987zjwMIzKVeEKspWgHgop8xXANJ5nEfiUxWDm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6p0NEJbP0G53PUey/ivswKpwxoBd/Dkg9mz9wuamJI2Z14wmZ
	190UNdBKlPui7kVBxgP4us+h+nOYpUa59Jx6sQAAk/hT6CMiCgSWJpGECe970E5YeirWQf64FnB
	TCfFu
X-Gm-Gg: AY/fxX7/NILXfn9NDKfOQtwPVTjphH6gbh5y8lXnfXJd1JzHlrs/nua5CcaS95fDsvg
	Xg67CK3UsvRy3Hifz0HTOHNNRsWY6LXno4McRr08Q0/woCqPHJC6tnjWILVgm8JbbUwa/cEIFVL
	wAnE3lvdI9kpHXW23on+YiAN77hh54P/Oa08Zl7mmmbKnsdxsqp8ZqJe52oloIgm/34/HUiK8Hw
	+PtmHOJXyrUMiQ627oHVoxJb6w9+qN0LLx/c0Bnkv6k4aGk1ygzIR09sVLaoEJslhS3EpIIzEYE
	7RuB5cj19n8lVPUSPLsDOV1e9zSzUR53yPMql9i41tTT75LavIeoQvTHGrXgyNHib+PABJgC2mg
	iVAi/DBzNG9b3dky3FveTtk8cb74aihZQKliDZWmQKdsmWDssGRVYlnKfJA2NbrPuttIxvP5pVN
	aaYgT/veDvF0Tvn+ZvFHas/7CYUqH8ZRtCA5XMJ3P+7G7iTpCvWlxzhEd+T1A=
X-Google-Smtp-Source: AGHT+IE4AcfstCcru9GHC8O+sbKkpLiZU/SVJ2RJZTUoj4FwyqUUl6TpJ4rXM8j6vltoVQ5e62sCOg==
X-Received: by 2002:a17:907:9802:b0:b7c:e320:5232 with SMTP id a640c23a62f3a-b8444c4ce48mr1225722466b.5.1768079123136;
        Sat, 10 Jan 2026 13:05:23 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm15151666b.56.2026.01.10.13.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:22 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next 00/10] Call skb_metadata_set when skb->data points
 past metadata
Date: Sat, 10 Jan 2026 22:05:14 +0100
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAq/YmkC/x3N0QrCMAyF4VcZuTbQzDLFVxEZcY0anHU0VQZj7
 27m5Qc/5yxgUlQMTs0CRb5q+s4O2jUwPDjfBTW5oQ1tF4gC2vOKL6mMN50/08Z+Y+LKvUnFgcf
 RMCY5HONeInUEvjUV8f7/c4bsWZa5wmVdf8VUy+aBAAAA
X-Change-ID: 20260110-skb-meta-fixup-skb_metadata_set-calls-4de7843e4161
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

This series is split out of [1] following discussion with Jakub.

To copy XDP metadata into an skb extension when skb_metadata_set() is
called, we need to locate the metadata contents.

These patches establish a contract with the drivers: skb_metadata_set()
must be called only after skb->data has been advanced past the metadata
area.

[1] https://lore.kernel.org/r/20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (10):
      net: Document skb_metadata_set contract with the drivers
      bnxt_en: Call skb_metadata_set when skb->data points past metadata
      i40e: Call skb_metadata_set when skb->data points past metadata
      igb: Call skb_metadata_set when skb->data points past metadata
      igc: Call skb_metadata_set when skb->data points past metadata
      ixgbe: Call skb_metadata_set when skb->data points past metadata
      mlx5e: Call skb_metadata_set when skb->data points past metadata
      veth: Call skb_metadata_set when skb->data points past metadata
      xsk: Call skb_metadata_set when skb->data points past metadata
      xdp: Call skb_metadata_set when skb->data points past metadata

 drivers/net/ethernet/broadcom/bnxt/bnxt.c           | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c          | 2 +-
 drivers/net/ethernet/intel/igb/igb_xsk.c            | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c           | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 drivers/net/veth.c                                  | 4 ++--
 include/linux/skbuff.h                              | 7 +++++++
 net/core/dev.c                                      | 5 ++++-
 net/core/xdp.c                                      | 2 +-
 10 files changed, 21 insertions(+), 11 deletions(-)


