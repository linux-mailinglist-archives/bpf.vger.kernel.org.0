Return-Path: <bpf+bounces-52788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC993A48838
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14A016B1AA
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F1258CF1;
	Thu, 27 Feb 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gGxxcLWA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCB26BDBA
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682243; cv=none; b=n2UQYYVwn6Dg2t/92mvHiCb+eUKsLkHktg/q5yPJKko64V+IX9woeobkzY4Su7aNZiiFmm2xtJQ3DgPcR0ZsVQ8B7CS/1MWaY7/qqH0ufz4gjWNrZd3l9B7BgVrwqwP+Ydp2iAVd1lL7JbvvzWuAULyR9ux/R5LevcksbvbFwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682243; c=relaxed/simple;
	bh=JVrLUQPdhierVvVB9T39WHViYQpGOg8iWAODC6R6k+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ik5/tEiBGGMOmrBaPo8UPdecorP04RAc79YRlNT/M2GN4apFsJCchcHIeY+7DYbsufiq7Y4PzvmLFwazcBvcAtz1cyrp1cDOAh2RvGp6105ZZN0jOlMQONU7AmrG+HuN4FljMGpzu4bR8wHqfRtogHlibNCWSBqEdi3KFrxpldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gGxxcLWA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22114b800f7so27470135ad.2
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682240; x=1741287040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DooASBqDq2Su1Kjlyvffy6QfBZOl14ihxJCQdnbxEeA=;
        b=gGxxcLWAmZIeoFkDDobLo7IW7coKQZyLvDksPGpine7sgAU30GRRMh/tldAtfYoY82
         R30AtGtY6WoERneexwCWmRuoayVDBEFDabzGQfz7R0MjYC2f5+uzkNO0rxq88K2S611T
         1E/padxbqJ7Wsw9uDmEAt9IfD7cywysEaUzX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682240; x=1741287040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DooASBqDq2Su1Kjlyvffy6QfBZOl14ihxJCQdnbxEeA=;
        b=tTFa3Io0XPS9XGL7lMyxuiREpF/4ekxZwn8y7A4tkwr5jdv86MxCMenlS7prsT/q9V
         /lEd5vmXtcdAUcxPBxShuNUp9yUHEKn8jBxclbgrhqp/Ft8C3LPZfsImDkmOuIxRuRol
         604TtifCVBo2RXaFY5mWtRzbL1OyjuOsZK3TIZgSnDagJTqShtiB5unwurFp6hzyX359
         X7bTuko7JKyEwvjChYe+gPtJH+iTieHzf+WyCTlhb/K0Nklg6r74tHy/qFHv5jU57+10
         fFrAn6Xu3W5d0UbKQO9h+nPyRqxrw1Ufm8LytsWXiDshQEhIoy2kFFVxEnaFgsH29sLZ
         xzUg==
X-Forwarded-Encrypted: i=1; AJvYcCVmFfumDj5wCPvpatmvDq4FxxOg9dHsMKRBg5gapIkrMcrgeP7vLAdkzFK8cXxElKe1r6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTEtbXIt6x/goHz7SfIkRFQme12FxhrzRFfDBaCwubH/z+Dec
	euin33drHZAT4GPxOxak9y5ai1DVhPWbWsm7UCec6Aw/L6oklN9V3CQg5VhG+HA=
X-Gm-Gg: ASbGnctY9yrAnkEsKSPSXxm9s9wyHQ1VWZrCsPqjM24zfPC6AzO/S1xJrwXqu+ebxTn
	WNbmpcDRiyUXSI/FsgKSFJTApdoRzx5Aip66jGUbeHMoyic2G3ZIez7MGhi3TGjag7iJL/55WRV
	df0RJN8q8X3vurceokQuMLhQrgxzHFg8v+5ZYigkgry/E9D02zTL0uCGVtOraOQvpXF838VmVRW
	/e01bULr3mJHAbASgtPUyNSodQvDOzRR/QFk8wiQi1YT1q18MyRrYZfdzHOpVeVoeASVJlXJRPQ
	WEjU2uT14sfZ4ytxYhs0NzsQKKkjIYJadw==
X-Google-Smtp-Source: AGHT+IFA0MRx4/wAs809zakde3f4qVOiG47vG98z/6mWwQFds5bqMOu206vyHM1cjUG7RCAYoliRcg==
X-Received: by 2002:a17:902:d510:b0:220:f140:f7be with SMTP id d9443c01a7336-2236924e3f6mr3183985ad.41.1740682240355;
        Thu, 27 Feb 2025 10:50:40 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:39 -0800 (PST)
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
Subject: [PATCH net-next v5 0/4] virtio-net: Link queues to NAPIs
Date: Thu, 27 Feb 2025 18:50:10 +0000
Message-ID: <20250227185017.206785-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v5. Patches 1, 2, and 4 have no functional changes only
updated tags. Patch 3 was refactored as requested by Jason. See the
changelog below and the commit message for details.

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

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
[2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
[3]: https://lore.kernel.org/netdev/CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com/

v5:
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

 drivers/net/virtio_net.c | 95 ++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 28 deletions(-)


base-commit: 7fe0353606d77a32c4c7f2814833dd1c043ebdd2
-- 
2.45.2


