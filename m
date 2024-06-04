Return-Path: <bpf+bounces-31304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594F38FB22E
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E540FB2311C
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8850145FE1;
	Tue,  4 Jun 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz0Aw7iw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9575145FFD;
	Tue,  4 Jun 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504197; cv=none; b=sysJdHJEnNgIuCKtcr8O8kfrjgQ4ncK1996j/rORUUdzzS3kpZ1OFN6pgOkVG8hUPQHNlNFNN45Kj028GrisGfwgMUveNfqm4+3Dbalg7d7lH2azAzo4wSgYRFeuFKL73zrpnWCDe3WXcJdqxfiL8zJ6Is4BfWXs7t6uAEvIG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504197; c=relaxed/simple;
	bh=B8vI+j7iuvQ3yiBfCrcT5AUKhIr0VQr0/eQqsTOGvjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTx7Aplo/0CfxKbqZOXgTyLyTbQ/pqSvw+f5O847OFCyOJcn8U4HpymMMWQYIWp8nHbKUfozi8DDChf5Xe5Hm1Ds9qUw9BV7edM6QqWXTkEeTTIV3DwmF4Qb2h5+nr+/QnjBt5oUPOsCmU21+gtoNqkmv6+z0jOx1RM7db3FCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cz0Aw7iw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e507e30c3so161126f8f.1;
        Tue, 04 Jun 2024 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504194; x=1718108994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIzQ2e1DcWXMu+FVoGgxHHgP/WfJFjXId4AMNdkJL4E=;
        b=cz0Aw7iwEHWjWS4qs9hPEBwQe5dk+9azC42TJGvCje3P6cFl0dJ27wsPkcRC8Lbtz4
         ESfCp/WlCo27Asa6QkjEkzN4pKxHpw1MgD7c1DTSg/nxM9qmhh/59xE0/sAdOi5sHXAP
         k6jfCOQmh7nwQJUg1tZ0N/cAdVlDbdlgLxV0FAOZDgneThlnwha7u3A3DjF1k6/5pFBr
         K4MCIHy44iTh4ouRvcZRbwZm0R2+knwPgQqQIEeMG+YBzaKcLHghP+UKeHIrbg0/5pqt
         RyTfqQZ6BeJrKDd+uw0sgtBQzX+X1nG8PgLCBjq5Yr3mT3Tk3FGOhVPFLkwb3mmEr191
         +X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504194; x=1718108994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIzQ2e1DcWXMu+FVoGgxHHgP/WfJFjXId4AMNdkJL4E=;
        b=pEXfu5qT9MwFG/TkyHDLZlzzNOYsFvNsxXAqq6GxW+fZ/uPYchy68RjXs6mXQQcxu6
         ZVcPQlJc4EYnKw20PD3Ha/MiLAnuplSdZeveKgzLE3yyjwVbSRokl/WoFZ1FL6kV7cU2
         f3p/T68h1wxJXBW1hR7P3G4BoS/05IgX3nGaZ18yPjtgHn8AWwrZweinRXzZsTvdNTJW
         x804Eeomqn/G2FzP0GfMpyL35cqxRT9QYKPxIRLwOC2zNPKki8Ovn+f4uToRGaTeMXes
         QvXkPgF3JR58tf6HDAebGPXBK/n7txq4UBLsyG5G8zZoLBq5LEZ0bbXNr0InlODJ4Ozw
         +mng==
X-Forwarded-Encrypted: i=1; AJvYcCWaE4byjAXVCZgdI3Cyr+Vd5qsuHv3+8+rOKC6rHdwBWYkYvTzlIhxu6ZgQw8uYeGkrQyRMOqmPdi6ehL6bGnPnQgas4P95lmpppUz1QNgwroyJW+x/yLhELntd
X-Gm-Message-State: AOJu0YzVXen7s0ZIPI5IsteZlLMRKI/euK3LGuvvyHZj7EDZKc3ooexW
	5NPfqU1o1dX0YdLbzVGiXv0EF7n6LwY6rdiL5iIeil7VfNR9JLbSSVMMk1fkvLU=
X-Google-Smtp-Source: AGHT+IHk1odO31RH7Iv0r6fDIxyPSVIVLRySVW3LycgB5iFc6UPnwTEn30btyGgD/sx+W0dMd4LCMg==
X-Received: by 2002:adf:e881:0:b0:35d:cf2b:9105 with SMTP id ffacd0b85a97d-35e0f32f61bmr8034643f8f.6.1717504193894;
        Tue, 04 Jun 2024 05:29:53 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-45.NA.cust.bahnhof.se. [158.174.22.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c10f2sm11409863f8f.10.2024.06.04.05.29.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:29:53 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	bpf@vger.kernel.org
Cc: YuvalE@radware.com
Subject: [PATCH bpf 1/2] Revert "xsk: support redirect to any socket bound to the same umem"
Date: Tue,  4 Jun 2024 14:29:25 +0200
Message-ID: <20240604122927.29080-2-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604122927.29080-1-magnus.karlsson@gmail.com>
References: <20240604122927.29080-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magnus Karlsson <magnus.karlsson@intel.com>

This reverts commit 2863d665ea41282379f108e4da6c8a2366ba66db.

This patch introduced a potential kernel crash when multiple napi
instances redirect to the same AF_XDP socket. By removing the
queue_index check, it is possible for multiple napi instances to
access the Rx ring at the same time, which will result in a corrupted
ring state which can lead to a crash when flushing the rings in
__xsk_flush(). This can happen when the linked list of sockets to
flush gets corrupted by concurrent accesses. A quick and small fix is
not possible, so let us revert this for now.

Reported-by: Yuval El-Hanany <YuvalE@radware.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Link: https://lore.kernel.org/xdp-newbies/8100DBDC-0B7C-49DB-9995-6027F6E63147@radware.com/
---
 net/xdp/xsk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 727aa20be4bd..7d1c0986f9bb 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -313,13 +313,10 @@ static bool xsk_is_bound(struct xdp_sock *xs)
 
 static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
-	struct net_device *dev = xdp->rxq->dev;
-	u32 qid = xdp->rxq->queue_index;
-
 	if (!xsk_is_bound(xs))
 		return -ENXIO;
 
-	if (!dev->_rx[qid].pool || xs->umem != dev->_rx[qid].pool->umem)
+	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
 		return -EINVAL;
 
 	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
-- 
2.45.1


