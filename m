Return-Path: <bpf+bounces-53523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5AA55CCC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 02:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52AC3AAF29
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD3F1531E8;
	Fri,  7 Mar 2025 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QRVKbRZk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE078145B27
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309942; cv=none; b=ly1S9wSi2JJ3G1kS0heHn7DeqKiGvhqzvdLSSdLJp4ScVKa3e2qszmrhPvpms1TZh+2MXnaaqn/AMg5VQazRNfno5fuodUSnq4w0vMCo20bx8SVu/focjOuSDIStOoioqgy9nljI7RYzHlCqZRlf3eaByxZ4ABlGAroG36yE1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309942; c=relaxed/simple;
	bh=noxXsObqGLx6uTUSZLiZR0FGe//Cjvt6Ch7d2Kqusko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISkDss552rZGb4+FRTdp2lWCNTSDi0HNjw0YlqUe+tfLYOdi9MW19C+FwiyCmkR5CGJmLQXRv0anUL4c2tzQ1QPlNrhm71TAbyW8wrJMRF5/GXvKX92Drwa3tF7O7vRS0Q2N6ni0b7TydYMsg398bR1es7FKrbBruoo/SQ9looc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QRVKbRZk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22349dc31bcso24124375ad.3
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 17:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309940; x=1741914740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIXlNf3Ao0dX27Zd+tqTBKwgBqBES5LVT2ggjMpbFJ0=;
        b=QRVKbRZkY0bnpo2dfVC8SNaQrobQ9KTQYhfPEQNSTv55QzV/nh+uaGY6AHGVB+TBB1
         /e0Mm1tDmiXiIFAkQQrfx+5tarTTI2Oi7sHYgYQ0jvK4eSch1z8a3y/ZgIcHoLAKpwdF
         YcZesMYxHNYvSEkyT5VJXbeiw4P/Lb9yhUHvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309940; x=1741914740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIXlNf3Ao0dX27Zd+tqTBKwgBqBES5LVT2ggjMpbFJ0=;
        b=S0xteHvQ9xbkqojTQ1cuLMI4cnRltq5RjqYhk3NzQKvsWXuOqMLc254EiTw5ihSE8N
         +LraPWZkWkHhy90lPa1WsJ3CwwHotormWofUBwaSFJa+gl9Z9LZZgVGCW032S7tVG8jT
         ESkys5N65FZUNMlVI8ULd0hKY099VJp2X0LchH+SST456f2Y3cDIITkiaGq2xbmo+wzV
         yt+ya8uUWJK+WShkDOWaeZzpCeDX+Lg0MZm4l6PVVF4YgSoWvLydACxlldxtBvp7kxzP
         dFZx4Qvb4VT/HBBKxqCrPAVan+/4znTukG+bORsn3iDeAtZ1xrA3+swJId4ZkHTgEwLD
         H/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2HD281jZy5QW/nR87hi3w75iblHf317LVBHjL10CRtim1qHJFcYU68J56+3jA6nOcKyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhx+8iC8N1z4krMqLyEmuWKCQTKd0IkG8a4HU16qfNTMSAoYAp
	0lmkDlEB62lhFi71hNyHTNyzivz3Tngc9Es06AZsYF8tAWDqqsqH8TqbRtmsw4w=
X-Gm-Gg: ASbGncvW81fVpT/49doFf9PPEmPHjAKvmgQbG/8H0pYO7vC67oyyURdJxsPaGT+DzjP
	utduXqN8p/2OwroG7FNkwIN6E+PMlBlnudhq7PT98WkgOwJSmsYllSiziB6EcasPcETutIlKdCv
	mDno9TpPRCA3PDhqymw0psI8qpxibDhBlxG6oX16irN3+i8PfRzvMq+oVwjrWaMj9s+XYPI5ItQ
	iL//34Q2RVqBgAT6SatEtd6gAK3y7+YJIsx17KZ+6RqBVFgwmaTzQSFAyV5QAq5KMnN0B37n73j
	pnoBFQwNX0835KQptncg/KEZ/sRomZwxY5IS9jkSgRdP4Qnj+UO3
X-Google-Smtp-Source: AGHT+IEkIz0d5WvMyob5VRa9MUqsKd4YXiS8Ojf2pCtLAEyE/o6Tcrsfiy2u8rS8941jEO1VbdZEHw==
X-Received: by 2002:a17:903:234f:b0:224:1eaa:5de1 with SMTP id d9443c01a7336-22428886900mr18124205ad.18.1741309939895;
        Thu, 06 Mar 2025 17:12:19 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:18 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
Subject: [PATCH net-next v6 0/4] virtio-net: Link queues to NAPIs
Date: Fri,  7 Mar 2025 01:12:08 +0000
Message-ID: <20250307011215.266806-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v6. Only patch updated is patch 3. See changelog below. 

Jakub recently commented [1] that I should not hold this series on
virtio-net linking queues to NAPIs behind other important work that is
on-going and suggested I re-spin, so here we are :)

As per the discussion on the v3 [2], now both RX and TX NAPIs use the
API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
correctly elides the TX-only NAPIs (instead of printing zero) when the
queues and NAPIs are linked.

As per the discussion on the v4 [3], patch 3 has been refactored to hold
RTNL only in the specific locations which need it as Jason requested.

As per the discussion on the v5 [4], patch 3 now leaves refill_work
as-is and does not use the API to unlink and relink queues and NAPIs. A
comment has been left as suggested by Jakub [5] for future work.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
[2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
[3]: https://lore.kernel.org/netdev/CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com/
[4]: https://lore.kernel.org/lkml/Z8X15hxz8t-vXpPU@LQ3V64L9R2/
[5]: https://lore.kernel.org/lkml/20250303160355.5f8d82d8@kernel.org/

v6:
  - Patch 3 has been updated to avoid using the queue linking API from
    refill_work and a comment has been added to instruct future
    work on the code.

v5: https://lore.kernel.org/lkml/20250227185017.206785-1-jdamato@fastly.com/
  - Patch 1 added Acked-by's from Michael and Jason. Added Tested-by
    from Lei. No functional changes.
  - Patch 2 added Acked-by's from Michael and Jason. Added Tested-by
    from Lei. No functional changes.
  - Patch 3:
    - Refactored as Jason requested, eliminating the
      virtnet_queue_set_napi helper entirely, and explicitly holding
      RTNL in the 3 locations where needed (refill_work, freeze, and
      restore).
    - Commit message updated to outline the known paths at the time the
      commit was written.
  - Patch 4 added Acked-by from Michael. Added Tested-by from Lei. No
    functional changes.

v4: https://lore.kernel.org/lkml/20250225020455.212895-1-jdamato@fastly.com/
  - Dropped Jakub's patch (previously patch 1).
  - Significant refactor from v3 affecting patches 1-3.
  - Patch 4 added tags from Jason and Gerhard.

rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fastly.com/
  - patch 3:
    - Removed the xdp checks completely, as Gerhard Engleder pointed
      out, they are likely not necessary.

  - patch 4:
    - Added Xuan Zhuo's Reviewed-by.

v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.com/
  - patch 1:
    - New in the v2 from Jakub.

  - patch 2:
    - Previously patch 1, unchanged from v1.
    - Added Gerhard Engleder's Reviewed-by.
    - Added Lei Yang's Tested-by.

  - patch 3:
    - Introduced virtnet_napi_disable to eliminate duplicated code
      in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
      refill_work as suggested by Jason Wang.
    - As a result of the above refactor, dropped Reviewed-by and
      Tested-by from patch 3.

  - patch 4:
    - New in v2. Adds persistent NAPI configuration. See commit message
      for more details.

v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly.com/


Joe Damato (4):
  virtio-net: Refactor napi_enable paths
  virtio-net: Refactor napi_disable paths
  virtio-net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c | 101 ++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 27 deletions(-)


base-commit: 8e0e8bef484160ac01ea7bcc3122cc1f0405c982
-- 
2.45.2


