Return-Path: <bpf+bounces-77684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B6CEED94
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C7983011A62
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485F26059D;
	Fri,  2 Jan 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPxmJ7EZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9025A33A
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367245; cv=none; b=KcJBevj1L6bJB0S/l72wW8Z+zceeO/wBOZ2FVopKN6YUsphVDQQIh17UXe1U7fXWvhEBXJwsINzKKeDksPTNyB7ePUp1+VuaO1Z/3Hv0cgg8cB0d/gI72J5eQDROGKLKgVeRAaB8eo7DMV5gCs9ek+Y+kiFI3uPzFEvn6VFgu2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367245; c=relaxed/simple;
	bh=bEfI9VdyBfyGoJu/InKuPX/XT/uFeqFxXXZCS+SC1Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4vf/LnqaWZron2PDro2nVkaUxEPXSuDQ2DqatvIVScvx6YRxPtYtjgfFwvGKLW1cVqeKcPAAOHwbQzj4Mf1AuyPmSoJ3iHQkswxIdpUPg5tXSMgUVY5fZPOeySCFEqzZEtAury0zjuASW9bQb7IuBwX8G6m7DaOd3XAWksWG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPxmJ7EZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0833b5aeeso165525395ad.1
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 07:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367243; x=1767972043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w30MU9We+VQZj/AlvgZCJU00iqT1dGAHAA+FFNT8Fc=;
        b=LPxmJ7EZSxyn0N9JalSZFqsmiWvfbF9PvA06JZqPjEiuD14+NGohm4zyVYKnXAtH3u
         kFPD3mxVxTv44vCizwO42ZtmsieRT31DhMNejzRf97iuf8DuQ4K1216MQDfJ8H8BeQnx
         sehoQtpySQzQ6giZ8yGVebt/HHMtlwJgdO+KWRdxXdxu2fh057ozNdzdUXTnlQPEEeVs
         MmQLeS023u69900tECYJlyR6iPnrsORk/eJUTM7ZL+VhC1/S2JZsZfgTXd1GmERo6zsb
         82P0FWlIjRZWAoRah7SQ+ZlFtMciaMahIaeIlDOdViIYfnaE9XaYZTJ6kN4P23+cP+U4
         h9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367243; x=1767972043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w30MU9We+VQZj/AlvgZCJU00iqT1dGAHAA+FFNT8Fc=;
        b=hMQ82BeUsPs4KHQZ0hD4s2/J2hMjbgPRwAcm+Hx1I7Za6mybLSx5WHSPDPPSlvRmEb
         16ljseM6rLSN8RfHgfJ7BZng+azLcBxrCtcW5C7XKYAVPMs4TUl0ER5shDKG5bvFABfA
         9+ODyQaQkGYF7YvozXZQpNQI8iVwFCYOHTzGgIVaXKQ5+WUo9U97MwCI/jBZJHxqBQoS
         +Q3e28vC/qHCLV3PGbN4wA1FiVODG/8dPw+F0fHELjg6/YpQQNXR8NQGq1e41ISpiIq/
         wsyc78jLq87Pan9vzqKi/Jr9dJaASnPdJJF2nuRDGeJsYlmz4Klvgd910n7H3TLMVfw9
         jK0w==
X-Forwarded-Encrypted: i=1; AJvYcCXKcBqqWljrUBCdejFE140JuYimfq49iS8bhwBuqIXzzh6+zYu2rhIJn7ROlyTNqJfOfck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/pm73ro2SiL1pvA3qbSv85cUjicxL1W06ggL/4lI8+mW1c1K
	AvEDkw1i5itilk+9YJ2MitBzDNHTklhedu7xvND7hwSLyGdaQ/jS7yg6
X-Gm-Gg: AY/fxX6m5oqK29bCpVEVnrfEYngB9BRcv5l97xJ2wUQ2gH1D2MhFuC4huk3+4kd5HtM
	Se9lJ0V0TagZ95JpHShhkCe/vk1e3wzwiAtpdjxmKijFHyNRY2Q8qG1vhk+honUwqyixovmL6/t
	r3+Q3p5mJ5SOXQnqnkCCO3kbg1eLtmLZqg/hHhoj1Gj2fryWmCEFwXRguccHkbKDXcYnly9Srqe
	MqOy43Uy/0S9tLLygMSATBcaOX1jgLsTjrzbHTqPlFe+G8fskaoCpMZoEWYod7ik6tbUXW6/RDu
	0cApfapENW03sM5jTu/4hwNzt+y9B4ACaDbFwH/JvQJ8Himkqd1eXJqcYnjgd5AyAu0D3FWfavO
	vaOe2DsMhfdMtVaRh1RIU9NjTg4ZGzlpYLmjGkJOTqtcJ5N+o0WcX9L9CLC5djPHZswz8CDq+B+
	M+O1g6SJHWIGeTLJkOpHDRU5M=
X-Google-Smtp-Source: AGHT+IFMmIn+2/J2pbEHZ9vcoQ6zTgkAbud3TeSk4TfYXDj4qwzEgISl47tpMlZjJUNUzJ74kzK3hA==
X-Received: by 2002:a17:902:d4c7:b0:2a0:d7f6:e030 with SMTP id d9443c01a7336-2a2f2836757mr413049005ad.29.1767367242912;
        Fri, 02 Jan 2026 07:20:42 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:42 -0800 (PST)
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
Subject: [PATCH net v2 0/3] virtio-net: fix the deadlock when disabling rx NAPI
Date: Fri,  2 Jan 2026 22:20:20 +0700
Message-ID: <20260102152023.10773-1-minhquangbui99@gmail.com>
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

 drivers/net/virtio_net.c | 171 +++++++++------------------------------
 1 file changed, 40 insertions(+), 131 deletions(-)

-- 
2.43.0


