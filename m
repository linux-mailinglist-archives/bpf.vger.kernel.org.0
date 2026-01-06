Return-Path: <bpf+bounces-77961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9DCF8F90
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 16:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17BB13037513
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC50F322C98;
	Tue,  6 Jan 2026 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWs7LeQR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB573334C1E
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711898; cv=none; b=dUkIyFziOyggDzVrauSLBFXLTvLhzWBZgw1ehGxkbzsWHCwZ7crJzm7fqRq/M53HlQ4o7iXv/IyLf0JiP2nRc8wl+ettrm1ghmYgLMvFj+Cl0bBlo0UIP9FXsOfHnKMq8dKwxxHgkyvyjFAMTvRD7a6wlD1U88dlMC5PbOV+IBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711898; c=relaxed/simple;
	bh=K8FNQhu5SnEcTiEsafwMNNxOn2K2Q9Ac3Y0d7g04XP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUBX1kdWppiIW279IfF97MgHjIoAxzdP5FtmYE1aMr4MxEP9lK/9i6gjJ5mqbE9ta3P8lfzxhIvpfYqLmkdAuDhPfQtDyDTsRRgNVMKlnYeOhumMfkzZUoiBnWYXsGua+bhrQdI+F//jNxnusXDQGXzF6kfMRm4a8lI27h4fvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWs7LeQR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso610526a12.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711895; x=1768316695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1gvuv/xyGr58xg9+znTKspBZ7TugLg/fG73JU/AoDE=;
        b=nWs7LeQRXbgUOg8TlDt5j4BBqvLcRKmTW7zj67NLvw1KV8WF7eMinuwr89ZoNmsPRf
         FXWcqH9WYdrrM3mmyztNXRTAGdK6OMYhAbDosf3WMTz0UISlWGW6/hKaPwJi/BPCTgN9
         K4B6C9e0ZJlAdN1xXDv/jK6tyElgXUb6Zo6nSc0NS68IejhikgJA94THyWJMJ3thJ1LX
         nFp8iehNmqEainK6EyV0YEnhpGdJeScv4APiyLyjm1bJNEJVautiiYso1UTS/hxxH0TT
         TVlARMQanYS97rRq5kc+KG1vF9hRaxwGf2IDs+KTOiObF1cm/NlkGfcpHjxhiQ/RYSwj
         788A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711895; x=1768316695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1gvuv/xyGr58xg9+znTKspBZ7TugLg/fG73JU/AoDE=;
        b=p+5PkEkJOkqFhWtFx0KmifO0002EogQiSLFyUjiscgKywfQnfsfAH9h99slVFWd2xh
         uizirbXh+mZ17RO1TCvDjJr6Xr5XLyt07GgbdwLrH8/o0cZA4OFHad8kHAjbe1dPWbbP
         msIpccGr5u6KyJqTYrstGo6AZJD+w1I1xnBrZOsexa9G3pUISWbMQ3r2t1puLRU9ssoD
         NoCnpk0vPtH8JB/SNOsyC8c2tnMkkWdDO63lHayMZI6uhnifqi1xcl9BJYXu/utJIHkg
         nSsskRnt+uhPvHvg0Vc7QsjejOWDYtx0Zhml2Zfidvitn8P59t7B2Qc+jFIT8/EpTcOx
         G0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUYFY/jYZPo3ugSkxfrDJ+VG9UMel6VIWIxfMGfhuWZBemIhyhwZosqq6OPzDQhCIId/A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBltMXVtvRKWVri/SLDPmCzq+0H/Oc1Jvmh2+VwnZjQP0RIhY0
	TXHB5WMlTDpK316Hmx3oY9k2VCYpDal8z2PeHP8WurMxH0um+enIzK39
X-Gm-Gg: AY/fxX54OsSoyKqHvfaRQE8Cp2aH0MskmWsLHScAhgJjP8cc6/V0Yc8IKcOeOPJa9FR
	bVXElyYsypdg527thlX9jLCHo/WduM/3/nWU7pr6i2g3kPKEOgnJFFD66qIIWt2BHx/O3Snk1Gl
	CnDu8Mlvoqkd3mlSlvvQe3pTLa6pSfFKZBcghRTyV1GH0/N8KpazMHdskfMT5mxuR3GdWEez9aP
	9pa+z9d/Yxn39yoTyw48XLptfW5+WVlcsAY++8IEflM3rV1yRQrpv1RenQR79RVTMDRyOwsN1y0
	AjqY2ixSaZY6lzNMOmDeUgDTnX+oYD4m3j+Zw8KWkiVfY13Hj5qXjb67kTbEz7+yZUxsfMx51xT
	E4VbY9TJH7wNpnSUl2evU6zLVpMuOu6hBSYmooC4mPn8jwaVFHSCywYNvjffOvyN8StOhbwmfJj
	lExZKHsNTL
X-Google-Smtp-Source: AGHT+IFU3Mhn1OWQ/XPfwYIXmQDx2yFG2njwZ4vCzwkyE0zpboeIRz229vtkdBQ3LSp9Eg2BDinhtg==
X-Received: by 2002:a05:6a20:4310:b0:35f:5fc4:d88c with SMTP id adf61e73a8af0-38982246c6emr2858508637.13.1767711894829;
        Tue, 06 Jan 2026 07:04:54 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:04:54 -0800 (PST)
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
Subject: [PATCH net v3 0/3] virtio-net: fix the deadlock when disabling rx NAPI
Date: Tue,  6 Jan 2026 22:04:35 +0700
Message-ID: <20260106150438.7425-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
when pausing rx"), to avoid the deadlock, when pausing the RX in
virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
However, in the virtnet_rx_resume_all(), we enable the delayed refill
work too early before enabling all the receive queue napis.

The deadlock can be reproduced by running
selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
device and inserting a cond_resched() inside the for loop in
virtnet_rx_resume_all() to increase the success rate. Because the worker
processing the delayed refilled work runs on the same CPU as
virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
In real scenario, the contention on netdev_lock can cause the
reschedule.

Due to the complexity of delayed refill worker, in this series, we remove
it. When we fail to refill the receive buffer, we will retry in the next
NAPI poll instead.
- Patch 1: removes delayed refill worker schedule and retry refill in next
NAPI
- Patch 2, 3: removes and clean up unused delayed refill worker code

For testing, I've run the following tests with no issue so far
- selftests/drivers/net/hw/xsk_reconfig.py which sets up the XDP zerocopy
without providing any descriptors to the fill ring. As a result,
try_fill_recv will always fail.
- Send TCP packets from host to guest while guest is nearly OOM and some
try_fill_recv calls fail.

Changes in v3:
- Patch 1: return budget when needing to retry in next NAPI in
virtnet_receive, fix comments and commit message
- Patch 2: edit the commit message
- Link to v2:
https://lore.kernel.org/netdev/20260102152023.10773-1-minhquangbui99@gmail.com/

Changes in v2:
- Remove the delayed refill worker to simplify the logic instead of trying
to fix it
- Link to v1:
https://lore.kernel.org/netdev/20251223152533.24364-1-minhquangbui99@gmail.com/

Link to the previous approach and discussion:
https://lore.kernel.org/netdev/20251212152741.11656-1-minhquangbui99@gmail.com/

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: don't schedule delayed refill worker
  virtio-net: remove unused delayed refill worker
  virtio-net: clean up __virtnet_rx_pause/resume

 drivers/net/virtio_net.c | 164 +++++++++------------------------------
 1 file changed, 35 insertions(+), 129 deletions(-)

-- 
2.43.0


